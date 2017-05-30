Received: from eggs.gnu.org ([2001:4830:134:3::10]:52020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFi3N-0007Y4-Qs
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFi3J-00065z-Kc
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:23:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dFi3J-00065T-B0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:23:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-5-marcandre.lureau@redhat.com>
	<8737cbv53y.fsf@dusky.pond.sub.org>
	<CAJ+F1C+9WAO2RZt-x7hzzh5M6HBv4UjR6svj71vLJD31axC_Zw@mail.gmail.com>
Date: Tue, 30 May 2017 16:23:13 +0200
In-Reply-To: <CAJ+F1C+9WAO2RZt-x7hzzh5M6HBv4UjR6svj71vLJD31axC_Zw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 30 May 2017
	07:32:05 +0000")
Message-ID: <87lgpel8z2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: merge QInt and QFloat in QNum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, May 11, 2017 at 6:30 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>
>> > + *
>> > + * This work is licensed under the terms of the GNU LGPL, version 2.1=
 or later.
>> > + * See the COPYING.LIB file in the top-level directory.
>> > + */
>> > +
>> > +#ifndef QNUM_H
>> > +#define QNUM_H
>> > +
>> > +#include "qapi/qmp/qobject.h"
>> > +
>> > +typedef enum {
>> > +    QNUM_I64,
>> > +    QNUM_DOUBLE
>> > +} QNumType;
>>
>> Not bool because you're going to add to it.  Good.
>>
>>
> Hmm? There is no plan to add bool there so far, I am not sure that makes
> sense.

Misunderstanding.  I meant to say something like "defining an
enumeration with two values is usually silly, but you're going to add to
this one, so it's okay".

>> >  static void qobject_input_type_int64(Visitor *v, const char *name, in=
t64_t *obj,
>> > @@ -387,19 +384,19 @@ static void qobject_input_type_int64(Visitor *v,=
 const char *name, int64_t *obj,
>> >  {
>> >      QObjectInputVisitor *qiv =3D to_qiv(v);
>> >      QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
>> > -    QInt *qint;
>> > +    QNum *qnum;
>> >
>> >      if (!qobj) {
>> >          return;
>> >      }
>> > -    qint =3D qobject_to_qint(qobj);
>> > -    if (!qint) {
>> > +    qnum =3D qobject_to_qnum(qobj);
>> > +    if (!qnum) {
>> >          error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
>> >                     full_name(qiv, name), "integer");
>> >          return;
>> >      }
>> >
>> > -    *obj =3D qint_get_int(qint);
>> > +    *obj =3D qnum_get_int(qnum, errp);
>>
>> Compare the error message a few lines up
>>
>>     Invalid parameter type for 'NAME', expected: integer
>>
>> to the one we get here:
>>
>>     The number is a float
>>
>> Which number?  There can be quite a few in a QMP command.  We need to
>> pass @name to qnum_get_int() for a decent error message, like
>>
>>     Parameter 'NAME' is not a 64 bit integer
>>
>>
> I suggest we do it the same way as qom/object.c, handle the error and
> prepend/modify it. Passing @name feels awkward, since qtypes don't have to
> have names.

I'm afraid prepending leads to inferior error messages.  What exactly do
you propose to prepend?

Can you point to a call of qnum_get_int() where the appropriate name
isn't readily available?

If callers of qnum_get_int() have to mess with the error message to get
a decent one, chances are qnum_get_int() should leave creating the Error
object to its callers by returning just an error code.  If many callers
need the same messages, they can share a wrapper.

>> >  int64_t qdict_get_int(const QDict *qdict, const char *key)
>> >  {
>> > -    return qint_get_int(qobject_to_qint(qdict_get(qdict, key)));
>> > +    return qnum_get_int(qobject_to_qnum(qdict_get(qdict, key)), &erro=
r_abort);
>>
>> Line is a bit long for my taste.
>>
>> >  }
>> >
>> >  /**
>> > @@ -260,15 +248,25 @@ const char *qdict_get_str(const QDict *qdict, co=
nst char *key)
>> >   * qdict_get_try_int(): Try to get integer mapped by 'key'
>> >   *
>> >   * Return integer mapped by 'key', if it is not present in
>> > - * the dictionary or if the stored object is not of QInt type
>> > + * the dictionary or if the stored object is not of QNum type
>>
>> Actually "is not a QNum representing an integer".
>>
>> >   * 'def_value' will be returned.
>> >   */
>> >  int64_t qdict_get_try_int(const QDict *qdict, const char *key,
>> >                            int64_t def_value)
>> >  {
>> > -    QInt *qint =3D qobject_to_qint(qdict_get(qdict, key));
>> > +    Error *err =3D NULL;
>> > +    QNum *qnum =3D qobject_to_qnum(qdict_get(qdict, key));
>> > +    int64_t val =3D def_value;
>> > +
>> > +    if (qnum) {
>> > +        val =3D qnum_get_int(qnum, &err);
>> > +    }
>> > +    if (err) {
>> > +        error_free(err);
>> > +        val =3D def_value;
>> > +    }
>>
>> This is a bit inefficient: it creates and destroys an Error object.
>> Easily avoided with a predicate qnum_is_int().
>
> True, but a predicate would have to deal with the same implicit conversion
> as qnum_get_int(). Not sure it's worth the duplication.

I dislike duplicating the (small) switch less than the clumsy signalling
of failure by giving the caller an Error object to free.  Matter of
taste.  However, it adds to my uneasy feeling about the qnum_get_int()
interface.

Further up, we discussed qnum_get_int() leaving error messages to
callers by returning just an error code.  Would also eliminate the
clumsiness here.  Hmm.

>> >
>> > -    return qint ? qint_get_int(qint) : def_value;
>> > +    return val;
>> >  }
>> >
>> >  /**
>> > diff --git a/qobject/qfloat.c b/qobject/qfloat.c
>> > deleted file mode 100644
>> > index d5da847701..0000000000
>> > --- a/qobject/qfloat.c
>> > +++ /dev/null
>> > @@ -1,62 +0,0 @@
>> > -/*
>> > - * QFloat Module
>> > - *
>> > - * Copyright IBM, Corp. 2009
>> > - *
>> > - * Authors:
>> > - *  Anthony Liguori   <aliguori@us.ibm.com>
>> > - *
>> > - * This work is licensed under the terms of the GNU LGPL, version 2.1=
 or later.
>> > - * See the COPYING.LIB file in the top-level directory.
>> > - *
>> > - */
>> > -
>> > -#include "qemu/osdep.h"
>> > -#include "qapi/qmp/qfloat.h"
>> > -#include "qapi/qmp/qobject.h"
>> > -#include "qemu-common.h"
>> > -
>> > -/**
>> > - * qfloat_from_int(): Create a new QFloat from a float
>> > - *
>> > - * Return strong reference.
>> > - */
>> > -QFloat *qfloat_from_double(double value)
>> > -{
>> > -    QFloat *qf;
>> > -
>> > -    qf =3D g_malloc(sizeof(*qf));
>> > -    qobject_init(QOBJECT(qf), QTYPE_QFLOAT);
>> > -    qf->value =3D value;
>> > -
>> > -    return qf;
>> > -}
>> > -
>> > -/**
>> > - * qfloat_get_double(): Get the stored float
>> > - */
>> > -double qfloat_get_double(const QFloat *qf)
>> > -{
>> > -    return qf->value;
>> > -}
>> > -
>> > -/**
>> > - * qobject_to_qfloat(): Convert a QObject into a QFloat
>> > - */
>> > -QFloat *qobject_to_qfloat(const QObject *obj)
>> > -{
>> > -    if (!obj || qobject_type(obj) !=3D QTYPE_QFLOAT) {
>> > -        return NULL;
>> > -    }
>> > -    return container_of(obj, QFloat, base);
>> > -}
>> > -
>> > -/**
>> > - * qfloat_destroy_obj(): Free all memory allocated by a
>> > - * QFloat object
>> > - */
>> > -void qfloat_destroy_obj(QObject *obj)
>> > -{
>> > -    assert(obj !=3D NULL);
>> > -    g_free(qobject_to_qfloat(obj));
>> > -}
>> > diff --git a/qobject/qint.c b/qobject/qint.c
>> > deleted file mode 100644
>> > index d7d1b3021f..0000000000
>> > --- a/qobject/qint.c
>> > +++ /dev/null
>> > @@ -1,61 +0,0 @@
>> > -/*
>> > - * QInt Module
>> > - *
>> > - * Copyright (C) 2009 Red Hat Inc.
>> > - *
>> > - * Authors:
>> > - *  Luiz Capitulino <lcapitulino@redhat.com>
>> > - *
>> > - * This work is licensed under the terms of the GNU LGPL, version 2.1=
 or later.
>> > - * See the COPYING.LIB file in the top-level directory.
>> > - */
>> > -
>> > -#include "qemu/osdep.h"
>> > -#include "qapi/qmp/qint.h"
>> > -#include "qapi/qmp/qobject.h"
>> > -#include "qemu-common.h"
>> > -
>> > -/**
>> > - * qint_from_int(): Create a new QInt from an int64_t
>> > - *
>> > - * Return strong reference.
>> > - */
>> > -QInt *qint_from_int(int64_t value)
>> > -{
>> > -    QInt *qi;
>> > -
>> > -    qi =3D g_malloc(sizeof(*qi));
>> > -    qobject_init(QOBJECT(qi), QTYPE_QINT);
>> > -    qi->value =3D value;
>> > -
>> > -    return qi;
>> > -}
>> > -
>> > -/**
>> > - * qint_get_int(): Get the stored integer
>> > - */
>> > -int64_t qint_get_int(const QInt *qi)
>> > -{
>> > -    return qi->value;
>> > -}
>> > -
>> > -/**
>> > - * qobject_to_qint(): Convert a QObject into a QInt
>> > - */
>> > -QInt *qobject_to_qint(const QObject *obj)
>> > -{
>> > -    if (!obj || qobject_type(obj) !=3D QTYPE_QINT) {
>> > -        return NULL;
>> > -    }
>> > -    return container_of(obj, QInt, base);
>> > -}
>> > -
>> > -/**
>> > - * qint_destroy_obj(): Free all memory allocated by a
>> > - * QInt object
>> > - */
>> > -void qint_destroy_obj(QObject *obj)
>> > -{
>> > -    assert(obj !=3D NULL);
>> > -    g_free(qobject_to_qint(obj));
>> > -}
>> > diff --git a/qobject/qjson.c b/qobject/qjson.c
>> > index b2f3bfec53..2e0930884e 100644
>> > --- a/qobject/qjson.c
>> > +++ b/qobject/qjson.c
>> > @@ -132,12 +132,11 @@ static void to_json(const QObject *obj, QString =
*str, int pretty, int indent)
>> >      case QTYPE_QNULL:
>> >          qstring_append(str, "null");
>> >          break;
>> > -    case QTYPE_QINT: {
>> > -        QInt *val =3D qobject_to_qint(obj);
>> > -        char buffer[1024];
>> > -
>> > -        snprintf(buffer, sizeof(buffer), "%" PRId64, qint_get_int(val=
));
>> > +    case QTYPE_QNUM: {
>> > +        QNum *val =3D qobject_to_qnum(obj);
>> > +        char *buffer =3D qnum_to_string(val);
>> >          qstring_append(str, buffer);
>> > +        g_free(buffer);
>> >          break;
>> >      }
>> >      case QTYPE_QSTRING: {
>> > @@ -234,34 +233,6 @@ static void to_json(const QObject *obj, QString *=
str, int pretty, int indent)
>> >          qstring_append(str, "]");
>> >          break;
>> >      }
>> > -    case QTYPE_QFLOAT: {
>> > -        QFloat *val =3D qobject_to_qfloat(obj);
>> > -        char buffer[1024];
>> > -        int len;
>> > -
>> > -        /* FIXME: snprintf() is locale dependent; but JSON requires
>> > -         * numbers to be formatted as if in the C locale. Dependence
>> > -         * on C locale is a pervasive issue in QEMU. */
>> > -        /* FIXME: This risks printing Inf or NaN, which are not valid
>> > -         * JSON values. */
>> > -        /* FIXME: the default precision of 6 for %f often causes
>> > -         * rounding errors; we should be using DBL_DECIMAL_DIG (17),
>> > -         * and only rounding to a shorter number if the result would
>> > -         * still produce the same floating point value.  */
>> > -        len =3D snprintf(buffer, sizeof(buffer), "%f", qfloat_get_dou=
ble(val));
>> > -        while (len > 0 && buffer[len - 1] =3D=3D '0') {
>> > -            len--;
>> > -        }
>> > -
>> > -        if (len && buffer[len - 1] =3D=3D '.') {
>> > -            buffer[len - 1] =3D 0;
>> > -        } else {
>> > -            buffer[len] =3D 0;
>> > -        }
>> > -
>> > -        qstring_append(str, buffer);
>> > -        break;
>> > -    }
>> >      case QTYPE_QBOOL: {
>> >          QBool *val =3D qobject_to_qbool(obj);
>> >
>> > diff --git a/qobject/qnum.c b/qobject/qnum.c
>> > new file mode 100644
>> > index 0000000000..8e9dd38350
>> > --- /dev/null
>> > +++ b/qobject/qnum.c
>> > @@ -0,0 +1,138 @@
>> > +/*
>> > + * QNum Module
>> > + *
>> > + * Copyright (C) 2009 Red Hat Inc.
>> > + *
>> > + * Authors:
>> > + *  Luiz Capitulino <lcapitulino@redhat.com>
>> > + *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > + *
>> > + * This work is licensed under the terms of the GNU LGPL, version 2.1=
 or later.
>> > + * See the COPYING.LIB file in the top-level directory.
>> > + */
>> > +
>> > +#include "qemu/osdep.h"
>> > +#include "qapi/error.h"
>> > +#include "qapi/qmp/qnum.h"
>> > +#include "qapi/qmp/qobject.h"
>> > +#include "qemu-common.h"
>> > +
>> > +/**
>> > + * qnum_from_int(): Create a new QNum from an int64_t
>> > + *
>> > + * Return strong reference.
>> > + */
>> > +QNum *qnum_from_int(int64_t value)
>> > +{
>> > +    QNum *qn =3D g_new(QNum, 1);
>> > +
>> > +    qobject_init(QOBJECT(qn), QTYPE_QNUM);
>> > +    qn->type =3D QNUM_I64;
>> > +    qn->u.i64 =3D value;
>> > +
>> > +    return qn;
>> > +}
>> > +
>> > +/**
>> > + * qnum_from_double(): Create a new QNum from a double
>> > + *
>> > + * Return strong reference.
>> > + */
>> > +QNum *qnum_from_double(double value)
>> > +{
>> > +    QNum *qn =3D g_new(QNum, 1);
>> > +
>> > +    qobject_init(QOBJECT(qn), QTYPE_QNUM);
>> > +    qn->type =3D QNUM_DOUBLE;
>> > +    qn->u.dbl =3D value;
>> > +
>> > +    return qn;
>> > +}
>> > +
>> > +/**
>> > + * qnum_get_int(): Get an integer representation of the number
>> > + */
>> > +int64_t qnum_get_int(const QNum *qn, Error **errp)
>> > +{
>> > +    switch (qn->type) {
>> > +    case QNUM_I64:
>> > +        return qn->u.i64;
>> > +    case QNUM_DOUBLE:
>> > +        error_setg(errp, "The number is a float");
>> > +        return 0;
>> > +    }
>> > +
>> > +    g_assert_not_reached();
>>
>> g_assert_not_reached() is problematic, see "[PATCH] checkpatch: Disallow
>> glib asserts in main code".
>>
>> Message-Id: <20170427165526.19836-1-dgilbert@redhat.com>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05499.html
>>
>>
> Actually g_assert() and g_assert_not_reached() are accepted.

What exactly does g_assert() buy us over plain assert(), and
g_assert_not_reached() over assert(0)?

qapi/ overwhelmingly uses assert().
