<%@ page import="java.util.List" %>
<%@ page import="by.bsuir.bankapp.bean.Client" %><%--
  Created by IntelliJ IDEA.
  User: stas-
  Date: 9/9/2016
  Time: 2:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Home</title>
    <script type='text/javascript'
            src='http://code.jquery.com/jquery-3.1.0.js'></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="styles.css">


    <script type='text/javascript'>

        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }

        $(window).load(function () {
            var messages = getUrlVars();
            var message = messages['message'];
            if (message != null) {
                console.log("hello1");
                $('#myModal').modal('show');
            }
        });


        //<![CDATA[
        $(window).load(function () {
            $dropdown = $("#contextMenu");
            $(".actionButton").click(function () {
                //get row ID
                var id = $($(this).closest("tr").children()[5]).html();
                //move dropdown menu
                $(this).after($dropdown);
                //update links
                $dropdown.find(".openLink").attr("href", "/controller?command=getClient&passportNumber=" + id);
                $dropdown.find(".removeLink").attr("href", "/controller?command=removeClient&passportNumber=" + id);
                $dropdown.find(".editLink").attr("href", "/controller?command=openForEdit&passportNumber=" + id);
                $dropdown.find(".depositLink").attr("href", "/controller?command=chooseUserForDeposit&passportNumber=" + id);
                $dropdown.find(".creditLink").attr("href", "/controller?command=chooseUserForCredit&passportNumber=" + id);
                //show dropdown
                $(this).dropdown();
            });
        });//]]>

    </script>

</head>
<body>
<div class="container">

    <form action="bankomat_login.jsp">
        <button type="submit" class="btn btn-primary btn-lg btn-block">БАНКОМАТ</button>
    </form>

    <h2 class="text-center">Подсистема ввода и модификации данных о клиентах условного коммерческого учреждения </h2>
    <div class="panel-group">

        <div class="panel panel-info">
            <div class="panel-heading">Модуль «Клиенты».</div>
            <div class="panel-body">

                <a class="btn icon-btn btn-info pull-right " data-toggle="modal" data-target="#myModal" href="#">
                    <span class="glyphicon btn-glyphicon glyphicon-plus img-circle text-success"></span>
                    Добавить клиента
                </a>

                <div class="modal fade" id="myModal" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Создание нового клиента</h4>
                            </div>
                            <div class="modal-body">

                                <c:if test="${not empty param['message']}">
                                    <c:choose>
                                        <c:when test="${param['message'] == 'fullNameMatch'}">
                                            <p class="text-danger">Пользвователь с таким именем уже существует</p>
                                        </c:when>
                                        <c:when test="${param['message'] == 'passportNoMatch'}">
                                            <p class="text-danger">Пользователь с таким номером паспорта уже
                                                существует</p>
                                        </c:when>
                                        <c:when test="${param['message'] == 'passpordIdMatch'}">
                                            <p class="text-danger">Пользователь с таким идентификационным номером
                                                паспорта уже существует</p>
                                        </c:when>
                                        <c:when test="${param['message'] == 'invalidData'}">
                                            <p class="text-danger">Введены некорректные данные</p>
                                        </c:when>
                                    </c:choose>

                                </c:if>

                                <small>Поля, отмеченные *, обязательны к заполнению</small>

                                <form class="form-horizontal" action="/controller" method="post">

                                    <input type="hidden" name="command" value="createClient">

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="firstName">* Фамилия:</label>
                                        <div class="col-sm-10">
                                            <input required type="text" maxlength="45" class="form-control"
                                                   name="firstName"
                                                   pattern="^[A-Za-zА-Яа-яЁё]+$"
                                                   id="firstName" placeholder="Введите фамилию"
                                                   value="${client.secName}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="name">* Имя:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required maxlength="45"
                                                   pattern="^[A-Za-zА-Яа-яЁё]+$"
                                                   class="form-control" name="name" id="name"
                                                   value="${client.name}"
                                                   placeholder="Введите имя">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="surname">* Отчество:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required
                                                   pattern="^[A-Za-zА-Яа-яЁё]+$"
                                                   maxlength="45" class="form-control" name="surname" id="surname"
                                                   value="${client.surName}"
                                                   placeholder="Введите отчество">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="birthDay">* Дата рождения:</label>
                                        <div class="col-sm-10">
                                            <input type="date" required class="form-control" name="birthDay"
                                                   value="${client.birthday}"
                                                   id="birthDay" placeholder="Выберите дату рождения">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="sex">* Пол:</label>
                                        <div class="col-sm-10" id="sex">
                                            <c:if test="${empty client}">
                                                <label class="radio-inline"><input type="radio" name="sexRadio"
                                                                                   value="m">Мужской</label>
                                                <label class="radio-inline"><input type="radio" name="sexRadio"
                                                                                   value="w">Женский</label>
                                            </c:if>

                                            <c:if test="${not empty client}">
                                                <c:if test="${client.sex}">
                                                    <label class="radio-inline"><input type="radio" checked
                                                                                       name="sexRadio"
                                                                                       value="m">Мужской</label>
                                                    <label class="radio-inline"><input type="radio" name="sexRadio"
                                                                                       value="w">Женский</label>
                                                </c:if>
                                                <c:if test="${not client.sex}">
                                                    <label class="radio-inline"><input type="radio" name="sexRadio"
                                                                                       value="m">Мужской</label>
                                                    <label class="radio-inline"><input type="radio" checked
                                                                                       name="sexRadio"
                                                                                       value="w">Женский</label>
                                                </c:if>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="passportSeries">* Серия
                                            паспорта:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required maxlength="2" class="form-control"
                                                   name="passportSeries"
                                                   id="passportSeries" value="${client.passportSeries}"
                                                   placeholder="Введите серию паспорта (2 буквы)">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="passportNo">* Номер паспорта:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required class="form-control" name="passportNo"
                                                   id="passportNo" pattern="[0-9]{8}"
                                                   value="${client.passportNumber}"
                                                   title="неверный формат номера паспорта"
                                                   placeholder="Введите номер паспорта">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="passportPlace">* Кем выдан:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required maxlength="150" class="form-control"
                                                   name="passportPlace"
                                                   id="passportPlace"
                                                   value="${client.passportPlace}"
                                                   placeholder="Укажите, каким учреждением был выдан паспорт">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="passportDate">* Дата выдачи:</label>
                                        <div class="col-sm-10">
                                            <input type="date" required
                                                   value="${client.passportDate}" class="form-control"
                                                   name="passportDate"
                                                   id="passportDate" placeholder="">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="passportIdNo">* Идентификационный
                                            номер:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required class="form-control" name="passportIdNo"
                                                   id="passportIdNo"
                                                   pattern="[0-9]{7}[A-Z][0-9]{3}[A-Z]{2}[0-9]"
                                                   value="${client.passportId}"
                                                   title="неверный формат идентификационного номера"
                                                   placeholder="Введите идентификационный номер паспорта">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="birthPlace">* Место рождения:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required maxlength="150" class="form-control"
                                                   value="${cleint.birthPlace}"
                                                   name="birthPlace"
                                                   id="birthPlace" placeholder="Введите место рождения">
                                        </div>
                                    </div>

                                    <%
                                        if (session.getAttribute("client") != null) {
                                            List<String> list = ((Client) session.getAttribute("client")).getLivingCities();
                                            String[] strings = list.toArray(new String[list.size()]);
                                            request.setAttribute("cities", strings);
                                        }
                                    %>

                                    <c:if test="${not empty client}">
                                        <c:set var="cities" value="${fn:join(cities, ' ,')}"/>
                                    </c:if>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="livingCity">* Город фактического
                                            проживания:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required class="form-control" name="livingCity"
                                                   id="livingCity"
                                                   maxlength="1000"
                                                   value="${cities}"
                                                   pattern="^[-\w\s\u0400-\u04ff]+(?:, [-\w\s\u0400-\u04ff]*)*$"
                                                   placeholder="Введите города в следующем формате: Город, Город,..">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="livingPlace">* Адрес фактического
                                            проживания:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required class="form-control" name="address"
                                                   maxlength="150"
                                                   id="livingPlace"
                                                   value="${client.address}"
                                                   placeholder="Введите адрес фактического проживания">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="homePhone">Номер домашнего
                                            телефона:</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" name="homePhone" id="homePhone"
                                                   pattern="80172[0-9]{6}"
                                                   maxlength="45"
                                                   value="${client.homePhone}"
                                                   placeholder="Введите номер домашнего телефона">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="phone">Номер мобильного
                                            телефона:</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" name="phone" id="phone"
                                                   pattern="+375[0-9]{9}"
                                                   maxlength="45"
                                                   value="${client.phone}"
                                                   placeholder="Введите номер мобильного телефона">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="email">E-mail:</label>
                                        <div class="col-sm-10">
                                            <input type="email" class="form-control" name="email" id="email"
                                                   value="${client.email}"
                                                   maxlength="45"
                                                   placeholder="Введите ваш e-mail">
                                        </div>
                                    </div>

                                    <%
                                        if (session.getAttribute("client") != null) {
                                            List<String> list2 = ((Client) session.getAttribute("client")).getFamilyMembers();
                                            String[] strings2 = list2.toArray(new String[list2.size()]);
                                            request.setAttribute("familyMembers", strings2);
                                        }
                                    %>

                                    <c:if test="${not empty client}">
                                        <c:set var="family" value="${fn:join(familyMembers, ' ,')}"/>
                                    </c:if>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="sp">* Семейное положение:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required class="form-control"
                                                   name="sp" id="sp"
                                                   pattern="^[-\w\s\u0400-\u04ff]+(?:, [-\w\s\u0400-\u04ff]*)*$"
                                                   value="${family}"
                                                   maxlength="1000"
                                                   placeholder="Заполните поле в следующем формате: женат, дочь, сын..">
                                        </div>
                                    </div>

                                    <%
                                        if (session.getAttribute("client") != null) {
                                            List<String> list3 = ((Client) session.getAttribute("client")).getNationalities();
                                            String[] strings3 = list3.toArray(new String[list3.size()]);
                                            request.setAttribute("nationalitiesCl", strings3);
                                        }
                                    %>
                                    <c:if test="${not empty client}">
                                        <c:set var="nationalities" value="${fn:join(nationalitiesCl, ' ,')}"/>
                                    </c:if>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="nationality">* Гражданство:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required class="form-control" name="nationality"
                                                   id="nationality"
                                                   pattern="^[-\w\s\u0400-\u04ff]+(?:, [-\w\s\u0400-\u04ff]*)*$"
                                                   maxlength="1000"
                                                   value="${nationalities}"
                                                   placeholder="Заполните поле в следующем формате: РБ, РФ,..">
                                        </div>
                                    </div>

                                    <%
                                        if (session.getAttribute("client") != null) {
                                            List<String> list4 = ((Client) session.getAttribute("client")).getIlls();
                                            String[] strings4 = list4.toArray(new String[list4.size()]);
                                            request.setAttribute("illsCl", strings4);
                                        }
                                    %>
                                    <c:if test="${not empty client}">
                                        <c:set var="ills" value="${fn:join(illsCl, ' ,')}"/>
                                    </c:if>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="ills">* Инвалидность:</label>
                                        <div class="col-sm-10">
                                            <input type="text" required class="form-control" name="ills" id="ills"
                                                   value="${ills}"
                                                   pattern="^[-\w\s\u0400-\u04ff]+(?:, [-\w\s\u0400-\u04ff]*)*$"
                                                   maxlength="1000"
                                                   placeholder="Введите болезни через запятую">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="pensioner">* Пенсионер:</label>
                                        <div class="col-sm-10 checkbox">
                                            <c:if test="${client.pensioner}">
                                                <label><input type="checkbox" checked name="pensioner" id="pensioner"
                                                              value="yes">Да</label>
                                            </c:if>
                                            <c:if test="${not client.pensioner}">
                                                <label><input type="checkbox" name="pensioner" id="pensioner"
                                                              value="yes">Да</label>
                                            </c:if>

                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="military">* Военнообязанный:</label>
                                        <div class="col-sm-10 checkbox">
                                            <c:if test="${client.military}">
                                                <label><input type="checkbox" checked name="military" id="military"
                                                              value="yes">Да</label>
                                            </c:if>
                                            <c:if test="${not client.military}">
                                                <label><input type="checkbox" name="military" id="military"
                                                              value="yes">Да</label>
                                            </c:if>

                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-sm-2" for="income">Ежемесячный доход в
                                            у.е.:</label>
                                        <div class="col-sm-10">
                                            <input type="number" min="0" step="1" required class="form-control"
                                                   name="income" id="income"
                                                   maxlength="7"
                                                   value="${client.income}"
                                                   placeholder="Ваш ежемесячный доход">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <button type="submit" class="btn btn-default">Сохранить</button>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>

                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>Фамилия</th>
                        <th>Имя</th>
                        <th>Отчество</th>
                        <th>Дата рождения</th>
                        <th>Серия паспорта</th>
                        <th>Номер паспорта</th>
                        <th>Адрес</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="client" items="${clients}">
                        <tr>
                            <td>${client.secName}</td>
                            <td>${client.name}</td>
                            <td>${client.surName}</td>
                            <td>${client.birthday}</td>
                            <td>${client.passportSeries}</td>
                            <td>${client.passportNumber}</td>
                            <td>${client.address}</td>
                            <td class="dropdown"><a class="btn btn-default actionButton"
                                                    data-toggle="dropdown" href="#"> Операция </a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <ul id="contextMenu" class="dropdown-menu" role="menu">
                    <li><a tabindex="-1" href="#" class="openLink">Открыть</a></li>
                    <li><a tabindex="-1" href="#" class="editLink">Изменить</a></li>
                    <li><a tabindex="-1" href="#" class="removeLink">Удалить</a></li>
                    <li><a tabindex="-1" href="#" class="depositLink">Заключить депозитный договор</a></li>
                    <li><a tabindex="-1" href="#" class="creditLink">Заключить кредитный договор</a></li>
                </ul>
            </div>
        </div>

        <div class="panel panel-info">
            <div class="panel-heading">Модуль «Депозитные операции с физическими лицами».</div>
            <div class="panel-body">

                <h3 class="text-center">Депозитные программы</h3>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>Описание</th>
                        <th>Процентная ставка (%)</th>
                        <th>Валюта</th>
                        <th>Тип</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="deposit" items="${deposits}">
                        <tr>
                            <td>${deposit.name}</td>
                            <td>${deposit.percent}</td>
                            <td>${deposit.currency}</td>

                            <c:choose>
                                <c:when test="${deposit.type.name eq 'REVOCABLE'}">
                                    <td>Отзывный</td>
                                </c:when>
                                <c:otherwise>
                                    <td>Безотзывный</td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <h3 class="text-center">Клиентские счета</h3>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>Номер счёта</th>
                        <th>ФИО клиента</th>
                        <th>Тип депозита</th>
                        <th>Дата начала - Дата окончания</th>
                        <th>Количество средств на счету</th>
                        <th>Операция</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="bill" items="${bills}">
                        <tr>
                            <td>${bill.activeBill.number}</td>
                            <td>${bill.activeBill.creator.secName} ${bill.activeBill.creator.name} ${bill.activeBill.creator.surName}</td>

                            <c:choose>
                                <c:when test="${bill.activeBill.deposit.type.name eq 'REVOCABLE'}">
                                    <td>${bill.activeBill.deposit.currency} | Отзывный
                                        | ${bill.activeBill.deposit.percent}%
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td>${bill.activeBill.deposit.currency} | Безотзывный
                                        | ${bill.activeBill.deposit.percent}%
                                    </td>
                                </c:otherwise>
                            </c:choose>
                            <td>${bill.activeBill.startDate} - ${bill.activeBill.endDate}</td>
                            <td>${bill.activeBill.moneySum}</td>

                            <jsp:useBean id="today" class="java.util.Date"/>

                            <c:choose>
                                <c:when test="${bill.activeBill.deposit.type.name eq 'REVOCABLE'}">
                                    <td>
                                        <a href="/controller?command=revokeBill&billActiveId=${bill.activeBill.id}&billPassiveId=${bill.passiveBill.id}"
                                           class="btn btn-primary" role="button">
                                            Отозвать
                                        </a>
                                    </td>
                                </c:when>
                                <c:when test="${(bill.activeBill.deposit.type.name ne 'REVOCABLE') && (today.time gt bill.activeBill.endDate.time)}">
                                    <td>
                                        <a href="/controller?command=revokeBill&billActiveId=${bill.activeBill.id}&billPassiveId=${bill.passiveBill.id}"
                                           class="btn btn-primary" role="button">
                                            Отозвать
                                        </a>
                                    </td>
                                </c:when>
                            </c:choose>
                        </tr>

                        <tr>
                            <td>${bill.passiveBill.number}</td>
                            <td>${bill.passiveBill.creator.secName} ${bill.passiveBill.creator.name} ${bill.passiveBill.creator.surName}</td>

                            <c:choose>
                                <c:when test="${bill.passiveBill.deposit.type.name eq 'REVOCABLE'}">
                                    <td>${bill.passiveBill.deposit.currency} | Отзывный
                                        | ${bill.passiveBill.deposit.percent}%
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td>${bill.passiveBill.deposit.currency} | Безотзывный
                                        | ${bill.passiveBill.deposit.percent}%
                                    </td>
                                </c:otherwise>
                            </c:choose>
                            <td>${bill.passiveBill.startDate} - ${bill.passiveBill.endDate}</td>
                            <td>${bill.passiveBill.moneySum}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <h3 class="text-center">Счета фонда развития банка</h3>
                <table class="table table-hover">
                    <thead>
                    <th>Счёт</th>
                    <th>Валюта</th>
                    <th>Количество средств</th>
                    </thead>
                    <tbody>
                    <c:forEach var="bankBill" items="${bankBills}">
                        <tr>
                            <td>${bankBill.name}</td>
                            <td>${bankBill.currency}</td>
                            <td>${bankBill.moneyAmount}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <form action="/controller" method="get">
                    <input type="hidden" name="command" value="endBankDay">
                    <button type="submit" class="btn btn-primary">Закрытие банковского дня</button>
                </form>
            </div>
        </div>


        <div class="panel panel-info">
            <div class="panel-heading">Модуль «Кредитные операции с физическими лицами».</div>
            <div class="panel-body">

                <h3 class="text-center">Кредитные программы</h3>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>Описание</th>
                        <th>Процентная ставка (%)</th>
                        <th>Валюта</th>
                        <th>Тип</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="credit" items="${credits}">
                        <tr>
                            <td>${credit.name}</td>
                            <td>${credit.percent}</td>
                            <td>${credit.currency}</td>

                            <c:choose>
                                <c:when test="${credit.type.name eq 'MONTHLY'}">
                                    <td>Ежемесячный</td>
                                </c:when>
                                <c:otherwise>
                                    <td>Аннуитетный</td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <h3 class="text-center">Клиентские счета</h3>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>Номер счёта</th>
                        <th>ФИО клиента</th>
                        <th>Тип кредита</th>
                        <th>Дата начала - Дата окончания</th>
                        <th>Количество средств на счету</th>
                        <th>Операция</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="creditBill" items="${creditBills}">
                        <tr>
                            <td>${creditBill.activeBill.number}</td>
                            <td>${creditBill.activeBill.creator.secName} ${creditBill.activeBill.creator.name} ${creditBill.activeBill.creator.surName}</td>

                            <c:choose>
                                <c:when test="${creditBill.activeBill.credit.type.name eq 'MONTHLY'}">
                                    <td>${creditBill.activeBill.credit.currency} | Ежемесячный
                                        | ${creditBill.activeBill.credit.percent}%
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td>${creditBill.activeBill.credit.currency} | Аннуитетный
                                        | ${creditBill.activeBill.credit.percent}%
                                    </td>
                                </c:otherwise>
                            </c:choose>
                            <td>${creditBill.activeBill.startDate} - ${creditBill.activeBill.endDate}</td>
                            <td>${creditBill.activeBill.moneySum}</td>

                            <c:choose>
                                <c:when test="${creditBill.canToClose}">
                                    <td>
                                        <a href="/controller?command=closeCreditBill&creditBillActiveId=${creditBill.activeBill.id}&creditBillPassiveId=${creditBill.passiveBill.id}"
                                           class="btn btn-primary" role="button">
                                            Закрыть кредит
                                        </a>
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td>
                                        <a href="/controller?command=creditEndPeriod&creditBillActiveId=${creditBill.activeBill.id}&creditBillPassiveId=${creditBill.passiveBill.id}"
                                           class="btn btn-primary" role="button">
                                            Закрыть кредитный период(месяц)
                                        </a>
                                    </td>
                                </c:otherwise>
                            </c:choose>

                        </tr>

                        <tr>
                            <td>${creditBill.passiveBill.number}</td>
                            <td>${creditBill.passiveBill.creator.secName} ${creditBill.passiveBill.creator.name} ${creditBill.passiveBill.creator.surName}</td>

                            <c:choose>
                                <c:when test="${creditBill.passiveBill.credit.type.name eq 'MONTHLY'}">
                                    <td>${creditBill.passiveBill.credit.currency} | Ежемесячный
                                        | ${creditBill.passiveBill.credit.percent}%
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td>${creditBill.passiveBill.credit.currency} | Аннуитетный
                                        | ${creditBill.passiveBill.credit.percent}%
                                    </td>
                                </c:otherwise>
                            </c:choose>
                            <td>${creditBill.passiveBill.startDate} - ${creditBill.passiveBill.endDate}</td>
                            <td>${creditBill.passiveBill.moneySum}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <h3 class="text-center">Счета фонда развития банка</h3>
                <table class="table table-hover">
                    <thead>
                    <th>Счёт</th>
                    <th>Валюта</th>
                    <th>Количество средств</th>
                    </thead>
                    <tbody>
                    <c:forEach var="bankBill" items="${bankBills}">
                        <tr>
                            <td>${bankBill.name}</td>
                            <td>${bankBill.currency}</td>
                            <td>${bankBill.moneyAmount}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
