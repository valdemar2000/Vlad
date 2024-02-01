-- Создаем таблицу с типами
CREATE TABLE species_type ( 
    type_id       INTEGER PRIMARY KEY,
    type_name     VARCHAR NOT NULL
);

-- Создаем таблицу с видами
CREATE TABLE species( 
    species_id       INTEGER PRIMARY KEY,
    type_id          INTEGER,
    species_name     VARCHAR NOT NULL,
    species_amount   INTEGER,
    date_start       DATE,
	  species_status varchar(100) NOT NULL DEFAULT 'active'::character varying,
    CONSTRAINT species_status_check CHECK (((species_status)::text = ANY (ARRAY[('active'::character varying)::text, ('absent'::character varying)::text, ('fairy'::character varying)::text])))
);

-- Создаем таблицу с местами 
CREATE TABLE places ( 
    place_id       INTEGER PRIMARY KEY,
    place_name     VARCHAR NOT NULL,
    place_size     NUMERIC(10,2),
    place_date_start  TIMESTAMP NOT NULL DEFAULT CURRENT_DATE
);

-- Создаем таблицу с распределением видов по местам
CREATE TABLE species_in_places ( 
    place_id      INTEGER,
    species_id     INTEGER,
    PRIMARY KEY (place_id, species_id)
);


commit;

-- Создаем связи между таблицами

ALTER TABLE species ADD CONSTRAINT type_id_fkey FOREIGN KEY (type_id) REFERENCES species_type(type_id);
ALTER TABLE species_in_places ADD CONSTRAINT place_id_fkey FOREIGN KEY (place_id) REFERENCES places(place_id);
ALTER TABLE species_in_places ADD CONSTRAINT species_id_fkey FOREIGN KEY (species_id) REFERENCES species(species_id);

== Скрипты для заполнения таблиц


INSERT INTO species_type (type_id, type_name)
VALUES
(1, 'человек'),
(2, 'животные'),
(3, 'птицы'),
(4, 'рыбы'),
(5, 'цветы'),
(6, 'фрукты'),
(7, 'ягоды');


INSERT INTO places (place_id, place_name, place_size, place_date_start)
VALUES
(1, 'дом', 120.00, '2010-04-12 10:00:00.000'),
(2, 'сарай', 200.00, '2011-05-30 15:30:00.000'),
(3, 'сад', 350.00, '2010-04-12 12:35:15.000'),
(4, 'лес', 0.00, '1900-01-01 00:00:00.000'),
(5, 'река', 0.00, '1900-01-01 00:00:01.000');


INSERT INTO species (species_id, type_id, species_name, species_amount, date_start, species_status)
VALUES
(1, 1, 'малыш', 20, '2022-10-04', 'active'),
(2, 1, 'мужчина', 40, '2010-04-12', 'active'),
(3, 1, 'женщина', 42, '2010-04-12', 'active'),
(4, 2, 'собака', 30, '2010-05-30', 'active'),
(5, 2, 'кошка', 10, '2022-10-04', 'active'),
(6, 2, 'лошадь', 50, '2010-04-12', 'active'),
(7, 2, 'единорог', 1, '2010-04-12', 'fairy'),
(8, 2, 'лиса', 5, '2010-04-12', 'active'),
(9, 2, 'волк', 0, '2010-04-12', 'absent'),
(10, 2, 'скунс', 2, '2010-04-12', 'active'),
(11, 2, 'обезьяна', 6, '2023-04-10', 'active'),
(12, 3, 'попугай', 15, '2020-01-01', 'active'),
(13, 3, 'соловей', 7, '2010-04-12', 'active'),
(14, 3, 'дятел', 4, '2010-04-12', 'active'),
(15, 3, 'сова', 10, '2010-04-12', 'active'),
(16, 4, 'голубая рыба', 2, '2010-04-12', 'active'),
(17, 5, 'подсолнух', 1000, '2010-04-12', 'active'),
(18, 5, 'роза', 2000, '2010-04-12', 'active'),
(19, 5, 'тюльпан', 1500, '2010-04-12', 'active'),
(20, 6, 'яблоко', 0, '2010-04-12', 'absent'),
(21, 6, 'груша', 13, '2010-04-12', 'active'),
(22, 6, 'слива', 11, '2010-04-12', 'active'),
(23, 7, 'клубника', 30, '2010-04-12', 'active'),
(24, 7, 'вишня', 7, '2010-04-12', 'active');


INSERT INTO species_in_places (place_id, species_id)
VALUES(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 6),
(4, 8),
(4, 9),
(4, 10),
(1, 11),
(1, 12),
(4, 13),
(4, 14),
(4, 15),
(5, 16),
(3, 17),
(3, 18),
(3, 19),
(3, 20),
(4, 20),
(3, 21),
(3, 22),
(3, 23),
(3, 24);



SELECT*FROM species_type;
SELECT*FROM species;
SELECT*FROM places;
SELECT*FROM species_in_places;


/* 1 Составьте запрос, который выведет имя вида с наименьшим id. 
Результат будет соответствовать букве «М». */


SELECT*FROM species;


SELECT species.species_name
FROM species
WHERE species_id = (SELECT MIN(species_id) FROM species);


/* 2 Составьте запрос, который выведет имя вида с количеством представителей
более 1800. Результат будет соответствовать букве «Б». */


SELECT*FROM species;


SELECT species.species_name,species.species_amount
FROM species
WHERE species.species_amount > '1800';


/* 3 Составьте запрос, который выведет имя вида, начинающегося на «п» и
относящегося к типу с type_id = 5. Результат будет соответствовать букве «О». */

SELECT*FROM species;


SELECT species.species_name,species.type_id
FROM species
WHERE type_id = 5
ORDER BY species_name LIKE '[п]' 
LIMIT 1;


/* 4 Составьте запрос, который выведет имя вида, заканчивающегося на «са» или
количество представителей которого равно 5. Результат будет соответствовать
букве В. */


SELECT*FROM species;


SELECT species.species_name,species. species_amount
FROM species
WHERE species_amount = 5
ORDER BY species_name LIKE '[%са]'; 


/* 2.1 Составьте запрос, который выведет имя вида, появившегося на учете в 2023 году. 
Результат будет соответствовать букве «Ы». */


SELECT*FROM species;


SELECT species_name,date_start
FROM species
WHERE date_start>'2023-01-01';


/* 2.2 Составьте запрос, который выведет названия отсутствующего 
(species_status = absent) вида, расположенного вместе с place_id = 3. 
Результат будет соответствовать букве «С». */


SELECT*FROM species;

SELECT*FROM species_in_places;


SELECT species.species_name,species.species_status,species_in_places.place_id
FROM species
JOIN species_in_places
ON species.species_id=species_in_places.species_id
WHERE (species.species_status = 'absent') AND (species_in_places.place_id = '3');


/* 2.3 Составьте запрос, который выведет название вида, расположенного в доме и 
появившегося в мае, а также и количество представителей вида. 
Название вида будет соответствовать букве «П». */

SELECT*FROM species;

SELECT*FROM species_in_places;

SELECT*FROM places;

SELECT*FROM species_type;


SELECT species.species_name,places.place_name,species.date_start,species.species_amount,species_type.type_name
FROM places
JOIN species_in_places
ON places.place_id= species_in_places.place_id
JOIN species
ON species_in_places.species_id=species.species_id
JOIN species_type
ON species.type_id=species_type.type_id
WHERE to_char(species.date_start,'MM') = '05'
ORDER BY place_name='Дом'


/* 2.4 Составьте запрос, который выведет название вида, состоящего из двух слов
(содержит пробел). Результат будет соответствовать знаку !. */


SELECT*FROM species;


SELECT species.species_name
FROM species
WHERE species_name LIKE ('% %')


/* 3.1 Составьте запрос, который выведет имя вида, появившегося с малышом в один день. 
Результат будет соответствовать букве «Ч». */


SELECT*FROM places;

SELECT*FROM species_in_places;

SELECT*FROM species;

SELECT*FROM species_type;


SELECT places.place_date_start,species.species_name,species_type.type_name
FROM places
JOIN species_in_places
ON places.place_id=species_in_places.place_id
JOIN species
ON species_in_places.species_id=species.species_id
JOIN species_type
ON species.type_id=species_type.type_id
WHERE species_name='малыш';


/* 3.2 Составьте запрос, который выведет название вида, расположенного в
здании с наибольшей площадью. Результат будет соответствовать букве «Ж». */



SELECT*FROM places;

SELECT*FROM species_in_places;

SELECT*FROM species;


SELECT places.place_size,places.place_name,species.species_name
FROM places
JOIN species_in_places
ON places.place_id=species_in_places.place_id
JOIN species
ON species_in_places.species_id=species.species_id
WHERE place_name='дом' OR place_name='сарай'
ORDER BY place_size DESC

/* 3.3 Составьте запрос/запросы, которые найдут название вида,
относящегося к 5-й по численности группе проживающего дома.
Результат будет соответствовать букве «Ш». */


SELECT*FROM places;

SELECT*FROM species_in_places;

SELECT*FROM species;


SELECT species.type_id,species.species_name,species.species_amount,places.place_name 
FROM species 
JOIN species_in_places
ON species.species_id=species_in_places.species_id
JOIN places
ON places.place_id=species_in_places.place_id
WHERE place_name='дом'
ORDER BY species.species_amount DESC
LIMIT 5


/* 3.4 Составьте запрос, который выведет сказочный вид (статус fairy),
не расположенный ни в одном месте. Результат будет соответствовать букве «Т». */


SELECT*FROM places;

SELECT*FROM species_in_places;

SELECT*FROM species;

SELECT*FROM species_type;


SELECT species.species_name,species.species_status
FROM species
WHERE species.species_status='fairy'


