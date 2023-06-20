/*
 Завдання на SQL до лекції 03.
 */


/*
1.
Вивести кількість фільмів в кожній категорії.
Результат відсортувати за спаданням.

*/

SELECT category.name, COUNT(film_category.film_id) FROM film_category, category WHERE film_category.category_id=category.category_id GROUP BY category.category_id ORDER BY COUNT(film_category.film_id) DESC;

/*

Вивести 10 акторів, чиї фільми брали на прокат найбільше.
Результат відсортувати за спаданням.
*/

SELECT COUNT(rental.rental_id), actor.actor_id, actor.first_name, actor.last_name FROM rental, inventory, film, film_actor, actor WHERE actor.actor_id=film_actor.actor_id AND film_actor.film_id=film.film_id AND inventory.film_id=film.film_id AND inventory.inventory_id=rental.inventory_id GROUP BY actor.actor_id ORDER by COUNT(rental.rental_id) DESC LIMIT 10;

/*
3.
Вивести категорія фільмів, на яку було витрачено найбільше грошей
в прокаті
*/


SELECT category.category_id, category.name FROM category, film_category, payment, rental, inventory, film WHERE payment.rental_id=rental.rental_id AND inventory.film_id=film.film_id AND inventory.inventory_id=rental.inventory_id AND film_category.film_id=film.film_id AND film_category.category_id=category.category_id GROUP BY category.category_id ORDER BY SUM(payment.amount) DESC LIMIT 1;

/*
4.
Вивести назви фільмів, яких не має в inventory.
Запит має бути без оператора IN
*/

SELECT film_id, title FROM film WHERE NOT EXISTS (SELECT film_id FROM inventory WHERE inventory.film_id=film.film_id);

/*
5.
Вивести топ 3 актори, які найбільше зʼявлялись в категорії фільмів “Children”.
*/

SELECT COUNT(film.film_id), actor.actor_id, actor.first_name, actor.last_name FROM film, film_actor, actor, film_category WHERE film_category.film_id=film.film_id AND film_category.category_id=3 AND actor.actor_id=film_actor.actor_id AND film_actor.film_id=film.film_id GROUP BY actor.actor_id ORDER by COUNT(film.film_id) DESC LIMIT 7;

/* не зовсім коректна постановка завдання, тому що 4 актори мають однаковий рейтинг за цією вибіркою */
