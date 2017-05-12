Received: from eggs.gnu.org ([2001:4830:134:3::10]:49788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1d9AEX-000679-14
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1d9AES-0007P5-6o
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:03:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lcapitulino@redhat.com>)
	id 1d9AER-0007OL-Qm
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:03:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91ECF7F7A9
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 13:03:42 +0000 (UTC)
Date: Fri, 12 May 2017 09:03:35 -0400
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20170512090335.6b20c3ec@redhat.com>
In-Reply-To: <874lwqjzjl.fsf@dusky.pond.sub.org>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-5-marcandre.lureau@redhat.com>
	<874lwqjzjl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Fri, 12 May 2017 09:37:50 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Luiz, there's a lone question for you further down.  Search for your
> name.

I could not a question, can you paste it here?

>=20
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > We would like to use a same QObject type to represent numbers, whether
> > they are int, uint, or floats. getters will allow some compatibility
> > between the various types if the number fits other representations
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> =20
> [Snip part I already reviewed...]
> > diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> > index be8d81f07b..bcd06a7d6b 100644
> > --- a/tests/check-qdict.c
> > +++ b/tests/check-qdict.c
> > @@ -11,7 +11,6 @@
> >   */
> >  #include "qemu/osdep.h"
> > =20
> > -#include "qapi/qmp/qint.h"
> >  #include "qapi/qmp/qdict.h"
> >  #include "qapi/qmp/qstring.h"
> >  #include "qapi/error.h"
> > @@ -39,7 +38,7 @@ static void qdict_new_test(void)
> > =20
> >  static void qdict_put_obj_test(void)
> >  {
> > -    QInt *qi;
> > +    QNum *qi;
> >      QDict *qdict;
> >      QDictEntry *ent;
> >      const int num =3D 42;
> > @@ -51,8 +50,8 @@ static void qdict_put_obj_test(void)
> > =20
> >      g_assert(qdict_size(qdict) =3D=3D 1);
> >      ent =3D QLIST_FIRST(&qdict->table[12345 % QDICT_BUCKET_MAX]);
> > -    qi =3D qobject_to_qint(ent->value);
> > -    g_assert(qint_get_int(qi) =3D=3D num);
> > +    qi =3D qobject_to_qnum(ent->value);
> > +    g_assert(qnum_get_int(qi, &error_abort) =3D=3D num);
> > =20
> >      // destroy doesn't exit yet
> >      QDECREF(qi); =20
>=20
> Since you're touching three out of four lines containing @qi anyway:
> rename it to @qn?  You rename like that in some places, but not all.
>=20
> > @@ -74,7 +73,7 @@ static void qdict_destroy_simple_test(void)
> > =20
> >  static void qdict_get_test(void)
> >  {
> > -    QInt *qi;
> > +    QNum *qi;
> >      QObject *obj;
> >      const int value =3D -42;
> >      const char *key =3D "test";
> > @@ -85,8 +84,8 @@ static void qdict_get_test(void)
> >      obj =3D qdict_get(tests_dict, key);
> >      g_assert(obj !=3D NULL);
> > =20
> > -    qi =3D qobject_to_qint(obj);
> > -    g_assert(qint_get_int(qi) =3D=3D value);
> > +    qi =3D qobject_to_qnum(obj);
> > +    g_assert(qnum_get_int(qi, &error_abort) =3D=3D value);
> > =20
> >      QDECREF(tests_dict);
> >  }
> > @@ -329,7 +328,7 @@ static void qdict_array_split_test(void)
> >  {
> >      QDict *test_dict =3D qdict_new();
> >      QDict *dict1, *dict2;
> > -    QInt *int1;
> > +    QNum *int1;
> >      QList *test_list;
> > =20
> >      /*
> > @@ -380,7 +379,7 @@ static void qdict_array_split_test(void)
> > =20
> >      dict1 =3D qobject_to_qdict(qlist_pop(test_list));
> >      dict2 =3D qobject_to_qdict(qlist_pop(test_list));
> > -    int1 =3D qobject_to_qint(qlist_pop(test_list));
> > +    int1 =3D qobject_to_qnum(qlist_pop(test_list));
> > =20
> >      g_assert(dict1);
> >      g_assert(dict2);
> > @@ -402,7 +401,7 @@ static void qdict_array_split_test(void)
> > =20
> >      QDECREF(dict2);
> > =20
> > -    g_assert(qint_get_int(int1) =3D=3D 66);
> > +    g_assert(qnum_get_int(int1, &error_abort) =3D=3D 66);
> > =20
> >      QDECREF(int1);
> > =20
> > @@ -447,14 +446,14 @@ static void qdict_array_split_test(void)
> > =20
> >      qdict_array_split(test_dict, &test_list);
> > =20
> > -    int1 =3D qobject_to_qint(qlist_pop(test_list));
> > +    int1 =3D qobject_to_qnum(qlist_pop(test_list));
> > =20
> >      g_assert(int1);
> >      g_assert(qlist_empty(test_list));
> > =20
> >      QDECREF(test_list);
> > =20
> > -    g_assert(qint_get_int(int1) =3D=3D 42);
> > +    g_assert(qnum_get_int(int1, &error_abort) =3D=3D 42);
> > =20
> >      QDECREF(int1);
> > =20
> > diff --git a/tests/check-qfloat.c b/tests/check-qfloat.c
> > deleted file mode 100644
> > index 1da2cdae08..0000000000
> > --- a/tests/check-qfloat.c
> > +++ /dev/null
> > @@ -1,53 +0,0 @@
> > -/*
> > - * QFloat unit-tests.
> > - *
> > - * Copyright IBM, Corp. 2009
> > - *
> > - * Authors:
> > - *  Anthony Liguori   <aliguori@us.ibm.com>
> > - *
> > - * This work is licensed under the terms of the GNU LGPL, version 2.1 =
or later.
> > - * See the COPYING.LIB file in the top-level directory.
> > - *
> > - */
> > -#include "qemu/osdep.h"
> > -
> > -#include "qapi/qmp/qfloat.h"
> > -#include "qemu-common.h"
> > -
> > -/*
> > - * Public Interface test-cases
> > - *
> > - * (with some violations to access 'private' data)
> > - */
> > -
> > -static void qfloat_from_double_test(void)
> > -{
> > -    QFloat *qf;
> > -    const double value =3D -42.23423;
> > -
> > -    qf =3D qfloat_from_double(value);
> > -    g_assert(qf !=3D NULL);
> > -    g_assert(qf->value =3D=3D value);
> > -    g_assert(qf->base.refcnt =3D=3D 1);
> > -    g_assert(qobject_type(QOBJECT(qf)) =3D=3D QTYPE_QFLOAT);
> > -
> > -    // destroy doesn't exit yet
> > -    g_free(qf);
> > -}
> > -
> > -static void qfloat_destroy_test(void)
> > -{
> > -    QFloat *qf =3D qfloat_from_double(0.0);
> > -    QDECREF(qf);
> > -}
> > -
> > -int main(int argc, char **argv)
> > -{
> > -    g_test_init(&argc, &argv, NULL);
> > -
> > -    g_test_add_func("/public/from_double", qfloat_from_double_test);
> > -    g_test_add_func("/public/destroy", qfloat_destroy_test);
> > -
> > -    return g_test_run();
> > -}
> > diff --git a/tests/check-qint.c b/tests/check-qint.c
> > deleted file mode 100644
> > index b6e4555115..0000000000
> > --- a/tests/check-qint.c
> > +++ /dev/null
> > @@ -1,87 +0,0 @@
> > -/*
> > - * QInt unit-tests.
> > - *
> > - * Copyright (C) 2009 Red Hat Inc.
> > - *
> > - * Authors:
> > - *  Luiz Capitulino <lcapitulino@redhat.com>
> > - *
> > - * This work is licensed under the terms of the GNU LGPL, version 2.1 =
or later.
> > - * See the COPYING.LIB file in the top-level directory.
> > - */
> > -#include "qemu/osdep.h"
> > -
> > -#include "qapi/qmp/qint.h"
> > -#include "qemu-common.h"
> > -
> > -/*
> > - * Public Interface test-cases
> > - *
> > - * (with some violations to access 'private' data)
> > - */
> > -
> > -static void qint_from_int_test(void)
> > -{
> > -    QInt *qi;
> > -    const int value =3D -42;
> > -
> > -    qi =3D qint_from_int(value);
> > -    g_assert(qi !=3D NULL);
> > -    g_assert(qi->value =3D=3D value);
> > -    g_assert(qi->base.refcnt =3D=3D 1);
> > -    g_assert(qobject_type(QOBJECT(qi)) =3D=3D QTYPE_QINT);
> > -
> > -    // destroy doesn't exit yet
> > -    g_free(qi);
> > -}
> > -
> > -static void qint_destroy_test(void)
> > -{
> > -    QInt *qi =3D qint_from_int(0);
> > -    QDECREF(qi);
> > -}
> > -
> > -static void qint_from_int64_test(void)
> > -{
> > -    QInt *qi;
> > -    const int64_t value =3D 0x1234567890abcdefLL;
> > -
> > -    qi =3D qint_from_int(value);
> > -    g_assert((int64_t) qi->value =3D=3D value);
> > -
> > -    QDECREF(qi);
> > -}
> > -
> > -static void qint_get_int_test(void)
> > -{
> > -    QInt *qi;
> > -    const int value =3D 123456;
> > -
> > -    qi =3D qint_from_int(value);
> > -    g_assert(qint_get_int(qi) =3D=3D value);
> > -
> > -    QDECREF(qi);
> > -}
> > -
> > -static void qobject_to_qint_test(void)
> > -{
> > -    QInt *qi;
> > -
> > -    qi =3D qint_from_int(0);
> > -    g_assert(qobject_to_qint(QOBJECT(qi)) =3D=3D qi);
> > -
> > -    QDECREF(qi);
> > -}
> > -
> > -int main(int argc, char **argv)
> > -{
> > -    g_test_init(&argc, &argv, NULL);
> > -
> > -    g_test_add_func("/public/from_int", qint_from_int_test);
> > -    g_test_add_func("/public/destroy", qint_destroy_test);
> > -    g_test_add_func("/public/from_int64", qint_from_int64_test);
> > -    g_test_add_func("/public/get_int", qint_get_int_test);
> > -    g_test_add_func("/public/to_qint", qobject_to_qint_test);
> > -
> > -    return g_test_run();
> > -}
> > diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> > index 963dd46f07..c432aebf13 100644
> > --- a/tests/check-qjson.c
> > +++ b/tests/check-qjson.c
> > @@ -886,21 +886,21 @@ static void simple_number(void)
> >      };
> > =20
> >      for (i =3D 0; test_cases[i].encoded; i++) {
> > -        QInt *qint;
> > +        QNum *qnum;
> > =20
> > -        qint =3D qobject_to_qint(qobject_from_json(test_cases[i].encod=
ed,
> > +        qnum =3D qobject_to_qnum(qobject_from_json(test_cases[i].encod=
ed,
> >                                                   &error_abort));
> > -        g_assert(qint);
> > -        g_assert(qint_get_int(qint) =3D=3D test_cases[i].decoded);
> > +        g_assert(qnum);
> > +        g_assert(qnum_get_int(qnum, &error_abort) =3D=3D test_cases[i]=
.decoded);
> >          if (test_cases[i].skip =3D=3D 0) {
> >              QString *str;
> > =20
> > -            str =3D qobject_to_json(QOBJECT(qint));
> > +            str =3D qobject_to_json(QOBJECT(qnum));
> >              g_assert(strcmp(qstring_get_str(str), test_cases[i].encode=
d) =3D=3D 0);
> >              QDECREF(str);
> >          }
> > =20
> > -        QDECREF(qint);
> > +        QDECREF(qnum);
> >      }
> >  }
> > =20
> > @@ -921,12 +921,12 @@ static void float_number(void)
> > =20
> >      for (i =3D 0; test_cases[i].encoded; i++) {
> >          QObject *obj;
> > -        QFloat *qfloat;
> > +        QNum *qnum;
> > =20
> >          obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
> > -        qfloat =3D qobject_to_qfloat(obj);
> > -        g_assert(qfloat);
> > -        g_assert(qfloat_get_double(qfloat) =3D=3D test_cases[i].decode=
d);
> > +        qnum =3D qobject_to_qnum(obj);
> > +        g_assert(qnum);
> > +        g_assert(qnum_get_double(qnum) =3D=3D test_cases[i].decoded);
> > =20
> >          if (test_cases[i].skip =3D=3D 0) {
> >              QString *str;
> > @@ -936,29 +936,28 @@ static void float_number(void)
> >              QDECREF(str);
> >          }
> > =20
> > -        QDECREF(qfloat);
> > +        QDECREF(qnum);
> >      }
> >  }
> > =20
> >  static void vararg_number(void)
> >  {
> > -    QInt *qint;
> > -    QFloat *qfloat;
> > +    QNum *qnum;
> >      int value =3D 0x2342;
> >      long long value_ll =3D 0x2342342343LL;
> >      double valuef =3D 2.323423423;
> > =20
> > -    qint =3D qobject_to_qint(qobject_from_jsonf("%d", value));
> > -    g_assert(qint_get_int(qint) =3D=3D value);
> > -    QDECREF(qint);
> > +    qnum =3D qobject_to_qnum(qobject_from_jsonf("%d", value));
> > +    g_assert(qnum_get_int(qnum, &error_abort) =3D=3D value);
> > +    QDECREF(qnum);
> > =20
> > -    qint =3D qobject_to_qint(qobject_from_jsonf("%lld", value_ll));
> > -    g_assert(qint_get_int(qint) =3D=3D value_ll);
> > -    QDECREF(qint);
> > +    qnum =3D qobject_to_qnum(qobject_from_jsonf("%lld", value_ll));
> > +    g_assert(qnum_get_int(qnum, &error_abort) =3D=3D value_ll);
> > +    QDECREF(qnum);
> > =20
> > -    qfloat =3D qobject_to_qfloat(qobject_from_jsonf("%f", valuef));
> > -    g_assert(qfloat_get_double(qfloat) =3D=3D valuef);
> > -    QDECREF(qfloat);
> > +    qnum =3D qobject_to_qnum(qobject_from_jsonf("%f", valuef));
> > +    g_assert(qnum_get_double(qnum) =3D=3D valuef);
> > +    QDECREF(qnum);
> >  }
> > =20
> >  static void keyword_literal(void) =20
>=20
> By now we see the pattern.  It's a mechanical transformation
>=20
>     - qobject_to_qint(E)
>     + qobject_to_qnum(E)
>=20
>     - qint_get_int(E)
>     + qnum_get_int(E, &error_abort)
>=20
>     - qobject_to_qfloat(E)
>     + qobject_to_qnum(E)
>=20
>     - qfloat_get_double(E)
>     + qnum_get_double(E)
>=20
> plus replacement / merge of QInt / QFloat variables.  Did you do it
> entirely by hand or with help from Coccinelle?
>=20
> A helper function qnum_get_int_nofail(E) would result in slightly more
> compact source code (object code probably, too), but I'm not sure it's
> worth it.
>=20
> Other patterns that might justify helpers:
>=20
>     qnum_get_double(qobject_to_qnum(OBJ))
>     qnum_get_int(qobject_to_qnum(OBJ), ERR)
>     qnum_get_int(qobject_to_qnum(OBJ), &error_abort)
>=20
> These are ideas, not demands.
>=20
> > @@ -1019,7 +1018,7 @@ struct LiteralQObject
> >  {
> >      int type;
> >      union {
> > -        int64_t qint;
> > +        int64_t qnum;
> >          const char *qstr;
> >          LiteralQDictEntry *qdict;
> >          LiteralQObject *qlist;
> > @@ -1032,7 +1031,7 @@ struct LiteralQDictEntry
> >      LiteralQObject value;
> >  };
> > =20
> > -#define QLIT_QINT(val) (LiteralQObject){.type =3D QTYPE_QINT, .value.q=
int =3D (val)}
> > +#define QLIT_QNUM(val) (LiteralQObject){.type =3D QTYPE_QNUM, .value.q=
num =3D (val)}
> >  #define QLIT_QSTR(val) (LiteralQObject){.type =3D QTYPE_QSTRING, .valu=
e.qstr =3D (val)}
> >  #define QLIT_QDICT(val) (LiteralQObject){.type =3D QTYPE_QDICT, .value=
.qdict =3D (val)}
> >  #define QLIT_QLIST(val) (LiteralQObject){.type =3D QTYPE_QLIST, .value=
.qlist =3D (val)} =20
>=20
> Aside: yet another private way to compare actual QObjects to expected
> ones.  We should pick *one* way to compare, and stick to it.
>=20
> > @@ -1069,8 +1068,9 @@ static int compare_litqobj_to_qobj(LiteralQObject=
 *lhs, QObject *rhs)
> >      }
> > =20
> >      switch (lhs->type) {
> > -    case QTYPE_QINT:
> > -        return lhs->value.qint =3D=3D qint_get_int(qobject_to_qint(rhs=
));
> > +    case QTYPE_QNUM:
> > +        return lhs->value.qnum =3D=3D qnum_get_int(qobject_to_qnum(rhs=
),
> > +                                               &error_abort);
> >      case QTYPE_QSTRING:
> >          return (strcmp(lhs->value.qstr, qstring_get_str(qobject_to_qst=
ring(rhs))) =3D=3D 0);
> >      case QTYPE_QDICT: {
> > @@ -1114,7 +1114,7 @@ static void simple_dict(void)
> >          {
> >              .encoded =3D "{\"foo\": 42, \"bar\": \"hello world\"}",
> >              .decoded =3D QLIT_QDICT(((LiteralQDictEntry[]){
> > -                        { "foo", QLIT_QINT(42) },
> > +                        { "foo", QLIT_QNUM(42) },
> >                          { "bar", QLIT_QSTR("hello world") },
> >                          { }
> >                      })),
> > @@ -1126,7 +1126,7 @@ static void simple_dict(void)
> >          }, {
> >              .encoded =3D "{\"foo\": 43}",
> >              .decoded =3D QLIT_QDICT(((LiteralQDictEntry[]){
> > -                        { "foo", QLIT_QINT(43) },
> > +                        { "foo", QLIT_QNUM(43) },
> >                          { }
> >                      })),
> >          },
> > @@ -1212,15 +1212,15 @@ static void simple_list(void)
> >          {
> >              .encoded =3D "[43,42]",
> >              .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> > -                        QLIT_QINT(43),
> > -                        QLIT_QINT(42),
> > +                        QLIT_QNUM(43),
> > +                        QLIT_QNUM(42),
> >                          { }
> >                      })),
> >          },
> >          {
> >              .encoded =3D "[43]",
> >              .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> > -                        QLIT_QINT(43),
> > +                        QLIT_QNUM(43),
> >                          { }
> >                      })),
> >          },
> > @@ -1269,35 +1269,35 @@ static void simple_whitespace(void)
> >          {
> >              .encoded =3D " [ 43 , 42 ]",
> >              .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> > -                        QLIT_QINT(43),
> > -                        QLIT_QINT(42),
> > +                        QLIT_QNUM(43),
> > +                        QLIT_QNUM(42),
> >                          { }
> >                      })),
> >          },
> >          {
> >              .encoded =3D " [ 43 , { 'h' : 'b' }, [ ], 42 ]",
> >              .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> > -                        QLIT_QINT(43),
> > +                        QLIT_QNUM(43),
> >                          QLIT_QDICT(((LiteralQDictEntry[]){
> >                                      { "h", QLIT_QSTR("b") },
> >                                      { }})),
> >                          QLIT_QLIST(((LiteralQObject[]){
> >                                      { }})),
> > -                        QLIT_QINT(42),
> > +                        QLIT_QNUM(42),
> >                          { }
> >                      })),
> >          },
> >          {
> >              .encoded =3D " [ 43 , { 'h' : 'b' , 'a' : 32 }, [ ], 42 ]",
> >              .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> > -                        QLIT_QINT(43),
> > +                        QLIT_QNUM(43),
> >                          QLIT_QDICT(((LiteralQDictEntry[]){
> >                                      { "h", QLIT_QSTR("b") },
> > -                                    { "a", QLIT_QINT(32) },
> > +                                    { "a", QLIT_QNUM(32) },
> >                                      { }})),
> >                          QLIT_QLIST(((LiteralQObject[]){
> >                                      { }})),
> > -                        QLIT_QINT(42),
> > +                        QLIT_QNUM(42),
> >                          { }
> >                      })),
> >          },
> > @@ -1327,11 +1327,11 @@ static void simple_varargs(void)
> >      QObject *embedded_obj;
> >      QObject *obj;
> >      LiteralQObject decoded =3D QLIT_QLIST(((LiteralQObject[]){
> > -            QLIT_QINT(1),
> > -            QLIT_QINT(2),
> > +            QLIT_QNUM(1),
> > +            QLIT_QNUM(2),
> >              QLIT_QLIST(((LiteralQObject[]){
> > -                        QLIT_QINT(32),
> > -                        QLIT_QINT(42),
> > +                        QLIT_QNUM(32),
> > +                        QLIT_QNUM(42),
> >                          {}})),
> >              {}}));
> > =20
> > diff --git a/tests/check-qlist.c b/tests/check-qlist.c
> > index 4983867c27..a2d1701003 100644
> > --- a/tests/check-qlist.c
> > +++ b/tests/check-qlist.c
> > @@ -11,8 +11,8 @@
> >   */
> >  #include "qemu/osdep.h"
> > =20
> > -#include "qapi/qmp/qint.h"
> > -#include "qapi/qmp/qlist.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qmp/types.h" =20
>=20
> qapi/qmp/types.h is a lazy way to increase compile times by including
> more than you need.  One day I'll kill it.  Until then, I tolerate it in
> .c, but not in .h.  But I'd stick to just qlist.h and qnum.h here.
>=20
> > =20
> >  /*
> >   * Public Interface test-cases
> > @@ -35,11 +35,11 @@ static void qlist_new_test(void)
> > =20
> >  static void qlist_append_test(void)
> >  {
> > -    QInt *qi;
> > +    QNum *qi;
> >      QList *qlist;
> >      QListEntry *entry;
> > =20
> > -    qi =3D qint_from_int(42);
> > +    qi =3D qnum_from_int(42);
> > =20
> >      qlist =3D qlist_new();
> >      qlist_append(qlist, qi);
> > @@ -84,13 +84,14 @@ static const int iter_max =3D 42;
> > =20
> >  static void iter_func(QObject *obj, void *opaque)
> >  {
> > -    QInt *qi;
> > +    QNum *qi;
> > =20
> >      g_assert(opaque =3D=3D NULL);
> > =20
> > -    qi =3D qobject_to_qint(obj);
> > +    qi =3D qobject_to_qnum(obj);
> >      g_assert(qi !=3D NULL);
> > -    g_assert((qint_get_int(qi) >=3D 0) && (qint_get_int(qi) <=3D iter_=
max));
> > +    g_assert((qnum_get_int(qi, &error_abort) >=3D 0) &&
> > +             (qnum_get_int(qi, &error_abort) <=3D iter_max));
> > =20
> >      iter_called++;
> >  }
> > diff --git a/tests/check-qnum.c b/tests/check-qnum.c
> > new file mode 100644
> > index 0000000000..d08d35e85a
> > --- /dev/null
> > +++ b/tests/check-qnum.c =20
>=20
> Let's compare to the old check-qint.c and check-qfloat.c.
>=20
> > @@ -0,0 +1,131 @@
> > +/*
> > + * QNum unit-tests.
> > + *
> > + * Copyright (C) 2009 Red Hat Inc. =20
>=20
> Also merge check-qfloat.c's
>=20
>     * Copyright IBM, Corp. 2009
>=20
> here, and
>=20
> > + *
> > + * Authors:
> > + *  Luiz Capitulino <lcapitulino@redhat.com> =20
>=20
>     *  Anthony Liguori   <aliguori@us.ibm.com>
>=20
> here.
>=20
> > + *
> > + * This work is licensed under the terms of the GNU LGPL, version 2.1 =
or later.
> > + * See the COPYING.LIB file in the top-level directory.
> > + */ =20
>=20
> Blank line here, please.
>=20
> > +#include "qemu/osdep.h"
> > +
> > +#include "qapi/qmp/qnum.h"
> > +#include "qapi/error.h"
> > +#include "qemu-common.h"
> > +
> > +/*
> > + * Public Interface test-cases
> > + *
> > + * (with some violations to access 'private' data)
> > + */ =20
>=20
> I consider this comment close to useless.
>=20
> > +
> > +static void qnum_from_int_test(void)
> > +{
> > +    QNum *qi;
> > +    const int value =3D -42;
> > +
> > +    qi =3D qnum_from_int(value);
> > +    g_assert(qi !=3D NULL); =20
>=20
>        g_assert_cmpint(qi->type, =3D=3D, QNUM_I64);
>=20
> > +    g_assert_cmpint(qi->u.i64, =3D=3D, value);
> > +    g_assert_cmpint(qi->base.refcnt, =3D=3D, 1);
> > +    g_assert_cmpint(qobject_type(QOBJECT(qi)), =3D=3D, QTYPE_QNUM);
> > +
> > +    // destroy doesn't exit yet
> > +    g_free(qi);
> > +}
> > +
> > +static void qnum_from_double_test(void)
> > +{
> > +    QNum *qf;
> > +    const double value =3D -42.23423;
> > +
> > +    qf =3D qnum_from_double(value);
> > +    g_assert(qf !=3D NULL); =20
>=20
>        g_assert_cmpint(qf->type, =3D=3D, QNUM_DOUBLE);
>=20
> > +    g_assert_cmpfloat(qf->u.dbl, =3D=3D, value);
> > +    g_assert_cmpint(qf->base.refcnt, =3D=3D, 1);
> > +    g_assert_cmpint(qobject_type(QOBJECT(qf)), =3D=3D, QTYPE_QNUM);
> > +
> > +    // destroy doesn't exit yet
> > +    g_free(qf);
> > +} =20
>=20
> Let's rename @qi and @qf to @qn.
>=20
> > +
> > +static void qnum_from_int64_test(void)
> > +{
> > +    QNum *qi;
> > +    const int64_t value =3D 0x1234567890abcdefLL;
> > +
> > +    qi =3D qnum_from_int(value);
> > +    g_assert_cmpint((int64_t) qi->u.i64, =3D=3D, value);
> > +
> > +    QDECREF(qi);
> > +}
> > +
> > +static void qnum_get_int_test(void)
> > +{
> > +    QNum *qi;
> > +    const int value =3D 123456;
> > +
> > +    qi =3D qnum_from_int(value);
> > +    g_assert_cmpint(qnum_get_int(qi, &error_abort), =3D=3D, value);
> > +
> > +    QDECREF(qi);
> > +}
> > +
> > +static void qobject_to_qnum_test(void)
> > +{
> > +    QNum *qn;
> > +
> > +    qn =3D qnum_from_int(0);
> > +    g_assert(qobject_to_qnum(QOBJECT(qn)) =3D=3D qn);
> > +    QDECREF(qn);
> > +
> > +    qn =3D qnum_from_double(0);
> > +    g_assert(qobject_to_qnum(QOBJECT(qn)) =3D=3D qn);
> > +    QDECREF(qn); =20
>=20
> You added this one.  Makes sense, but announcing in the commit message
> that you're also adding test cases wouldn't hurt.
>=20
> > +}
> > +
> > +static void qnum_to_string_test(void)
> > +{
> > +    QNum *qn;
> > +    char *tmp;
> > +
> > +    qn =3D qnum_from_int(123456);
> > +    tmp =3D qnum_to_string(qn);
> > +    g_assert_cmpstr(tmp, =3D=3D, "123456");
> > +    g_free(tmp);
> > +    QDECREF(qn);
> > +
> > +    qn =3D qnum_from_double(0.42);
> > +    tmp =3D qnum_to_string(qn);
> > +    g_assert_cmpstr(tmp, =3D=3D, "0.42");
> > +    g_free(tmp);
> > +    QDECREF(qn); =20
>=20
> Also new.  Good.
>=20
> Test coverage could use further improvement, but this will do for now.
>=20
> > +}
> > +
> > +static void qnum_destroy_test(void)
> > +{
> > +    QNum *qn;
> > +
> > +    qn =3D qnum_from_int(0);
> > +    QDECREF(qn);
> > +
> > +    qn =3D qnum_from_double(0.42);
> > +    QDECREF(qn);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    g_test_init(&argc, &argv, NULL);
> > +
> > +    g_test_add_func("/qnum/from_int", qnum_from_int_test);
> > +    g_test_add_func("/qnum/from_double", qnum_from_double_test);
> > +    g_test_add_func("/qnum/destroy", qnum_destroy_test);
> > +    g_test_add_func("/qnum/from_int64", qnum_from_int64_test);
> > +    g_test_add_func("/qnum/get_int", qnum_get_int_test);
> > +    g_test_add_func("/qnum/to_qnum", qobject_to_qnum_test);
> > +    g_test_add_func("/qnum/to_string", qnum_to_string_test);
> > +
> > +    return g_test_run();
> > +}
> > diff --git a/tests/test-keyval.c b/tests/test-keyval.c
> > index df0ff831b5..bec574257e 100644
> > --- a/tests/test-keyval.c
> > +++ b/tests/test-keyval.c
> > @@ -611,7 +611,6 @@ static void test_keyval_visit_optional(void)
> > =20
> >  static void test_keyval_visit_alternate(void)
> >  {
> > -    Error *err =3D NULL;
> >      Visitor *v;
> >      QDict *qdict;
> >      AltNumStr *ans; =20
>=20
> This belongs to PATCH 03.
>=20
> > diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
> > index acdded4d67..96a52dbca8 100644
> > --- a/tests/test-qmp-commands.c
> > +++ b/tests/test-qmp-commands.c
> > @@ -162,7 +162,7 @@ static void test_dispatch_cmd_io(void)
> >      QDict *ud1b =3D qdict_new();
> >      QDict *ret, *ret_dict, *ret_dict_dict, *ret_dict_dict_userdef;
> >      QDict *ret_dict_dict2, *ret_dict_dict2_userdef;
> > -    QInt *ret3;
> > +    QNum *ret3;
> > =20
> >      qdict_put_int(ud1a, "integer", 42);
> >      qdict_put_str(ud1a, "string", "hello");
> > @@ -194,8 +194,8 @@ static void test_dispatch_cmd_io(void)
> >      qdict_put(req, "arguments", args3);
> >      qdict_put_str(req, "execute", "guest-get-time");
> > =20
> > -    ret3 =3D qobject_to_qint(test_qmp_dispatch(req));
> > -    assert(qint_get_int(ret3) =3D=3D 66);
> > +    ret3 =3D qobject_to_qnum(test_qmp_dispatch(req));
> > +    assert(qnum_get_int(ret3, &error_abort) =3D=3D 66);
> >      QDECREF(ret3);
> > =20
> >      QDECREF(req);
> > diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
> > index 4c0f09601d..e996bebc6e 100644
> > --- a/tests/test-qmp-event.c
> > +++ b/tests/test-qmp-event.c
> > @@ -18,7 +18,6 @@
> >  #include "test-qapi-visit.h"
> >  #include "test-qapi-event.h"
> >  #include "qapi/qmp/types.h"
> > -#include "qapi/qmp/qint.h"
> >  #include "qapi/qmp/qobject.h"
> >  #include "qapi/qmp-event.h"
> > =20
> > @@ -62,9 +61,9 @@ void qdict_cmp_do_simple(const char *key, QObject *ob=
j1, void *opaque)
> >          d->result =3D (qbool_get_bool(qobject_to_qbool(obj1)) =3D=3D
> >                       qbool_get_bool(qobject_to_qbool(obj2)));
> >          return;
> > -    case QTYPE_QINT:
> > -        d->result =3D (qint_get_int(qobject_to_qint(obj1)) =3D=3D
> > -                     qint_get_int(qobject_to_qint(obj2)));
> > +    case QTYPE_QNUM:
> > +        d->result =3D (qnum_get_int(qobject_to_qnum(obj1), &error_abor=
t) =3D=3D
> > +                     qnum_get_int(qobject_to_qnum(obj2), &error_abort)=
);
> >          return;
> >      case QTYPE_QSTRING:
> >          d->result =3D g_strcmp0(qstring_get_str(qobject_to_qstring(obj=
1)),
> > diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-in=
put-visitor.c
> > index a30e2d5e95..4484980969 100644
> > --- a/tests/test-qobject-input-visitor.c
> > +++ b/tests/test-qobject-input-visitor.c
> > @@ -152,7 +152,7 @@ static void test_visitor_in_int_overflow(TestInputV=
isitorData *data,
> >      Visitor *v;
> > =20
> >      /* this will overflow a Qint/int64, so should be deserialized into
> > -     * a QFloat/double field instead, leading to an error if we pass it
> > +     * a QNum/double field instead, leading to an error if we pass it =
=20
>=20
> s#a Qint/int64#an int64_t#
> s#a QNum/double field#a double#
>=20
> Or perhaps explain using QNUM_I64 and QNUM_DOUBLE.  Your choice.
>=20
> >       * to visit_type_int. confirm this.
> >       */
> >      v =3D visitor_input_test_init(data, "%f", DBL_MAX);
> > @@ -428,7 +428,7 @@ static void test_visitor_in_any(TestInputVisitorDat=
a *data,
> >  {
> >      QObject *res =3D NULL;
> >      Visitor *v;
> > -    QInt *qint;
> > +    QNum *qnum;
> >      QBool *qbool;
> >      QString *qstring;
> >      QDict *qdict;
> > @@ -436,9 +436,9 @@ static void test_visitor_in_any(TestInputVisitorDat=
a *data,
> > =20
> >      v =3D visitor_input_test_init(data, "-42");
> >      visit_type_any(v, NULL, &res, &error_abort);
> > -    qint =3D qobject_to_qint(res);
> > -    g_assert(qint);
> > -    g_assert_cmpint(qint_get_int(qint), =3D=3D, -42);
> > +    qnum =3D qobject_to_qnum(res);
> > +    g_assert(qnum);
> > +    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, -42);
> >      qobject_decref(res);
> > =20
> >      v =3D visitor_input_test_init(data, "{ 'integer': -42, 'boolean': =
true, 'string': 'foo' }");
> > @@ -447,9 +447,9 @@ static void test_visitor_in_any(TestInputVisitorDat=
a *data,
> >      g_assert(qdict && qdict_size(qdict) =3D=3D 3);
> >      qobj =3D qdict_get(qdict, "integer");
> >      g_assert(qobj);
> > -    qint =3D qobject_to_qint(qobj);
> > -    g_assert(qint);
> > -    g_assert_cmpint(qint_get_int(qint), =3D=3D, -42);
> > +    qnum =3D qobject_to_qnum(qobj);
> > +    g_assert(qnum);
> > +    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, -42);
> >      qobj =3D qdict_get(qdict, "boolean");
> >      g_assert(qobj);
> >      qbool =3D qobject_to_qbool(qobj);
> > @@ -527,7 +527,7 @@ static void test_visitor_in_alternate(TestInputVisi=
torData *data,
> > =20
> >      v =3D visitor_input_test_init(data, "42");
> >      visit_type_UserDefAlternate(v, NULL, &tmp, &error_abort);
> > -    g_assert_cmpint(tmp->type, =3D=3D, QTYPE_QINT);
> > +    g_assert_cmpint(tmp->type, =3D=3D, QTYPE_QNUM);
> >      g_assert_cmpint(tmp->u.i, =3D=3D, 42);
> >      qapi_free_UserDefAlternate(tmp);
> > =20
> > @@ -555,7 +555,7 @@ static void test_visitor_in_alternate(TestInputVisi=
torData *data,
> > =20
> >      v =3D visitor_input_test_init(data, "{ 'alt': 42 }");
> >      visit_type_WrapAlternate(v, NULL, &wrap, &error_abort);
> > -    g_assert_cmpint(wrap->alt->type, =3D=3D, QTYPE_QINT);
> > +    g_assert_cmpint(wrap->alt->type, =3D=3D, QTYPE_QNUM);
> >      g_assert_cmpint(wrap->alt->u.i, =3D=3D, 42);
> >      qapi_free_WrapAlternate(wrap);
> > =20
> > @@ -596,19 +596,19 @@ static void test_visitor_in_alternate_number(Test=
InputVisitorData *data,
> > =20
> >      v =3D visitor_input_test_init(data, "42");
> >      visit_type_AltStrNum(v, NULL, &asn, &error_abort);
> > -    g_assert_cmpint(asn->type, =3D=3D, QTYPE_QFLOAT);
> > +    g_assert_cmpint(asn->type, =3D=3D, QTYPE_QNUM);
> >      g_assert_cmpfloat(asn->u.n, =3D=3D, 42);
> >      qapi_free_AltStrNum(asn);
> > =20
> >      v =3D visitor_input_test_init(data, "42");
> >      visit_type_AltNumStr(v, NULL, &ans, &error_abort);
> > -    g_assert_cmpint(ans->type, =3D=3D, QTYPE_QFLOAT);
> > +    g_assert_cmpint(ans->type, =3D=3D, QTYPE_QNUM);
> >      g_assert_cmpfloat(ans->u.n, =3D=3D, 42);
> >      qapi_free_AltNumStr(ans);
> > =20
> >      v =3D visitor_input_test_init(data, "42");
> >      visit_type_AltStrInt(v, NULL, &asi, &error_abort);
> > -    g_assert_cmpint(asi->type, =3D=3D, QTYPE_QINT);
> > +    g_assert_cmpint(asi->type, =3D=3D, QTYPE_QNUM);
> >      g_assert_cmpint(asi->u.i, =3D=3D, 42);
> >      qapi_free_AltStrInt(asi);
> > =20
> > @@ -621,13 +621,13 @@ static void test_visitor_in_alternate_number(Test=
InputVisitorData *data,
> > =20
> >      v =3D visitor_input_test_init(data, "42.5");
> >      visit_type_AltStrNum(v, NULL, &asn, &error_abort);
> > -    g_assert_cmpint(asn->type, =3D=3D, QTYPE_QFLOAT);
> > +    g_assert_cmpint(asn->type, =3D=3D, QTYPE_QNUM);
> >      g_assert_cmpfloat(asn->u.n, =3D=3D, 42.5);
> >      qapi_free_AltStrNum(asn);
> > =20
> >      v =3D visitor_input_test_init(data, "42.5");
> >      visit_type_AltNumStr(v, NULL, &ans, &error_abort);
> > -    g_assert_cmpint(ans->type, =3D=3D, QTYPE_QFLOAT);
> > +    g_assert_cmpint(ans->type, =3D=3D, QTYPE_QNUM);
> >      g_assert_cmpfloat(ans->u.n, =3D=3D, 42.5);
> >      qapi_free_AltNumStr(ans);
> > =20
> > diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-o=
utput-visitor.c
> > index 94b9518e40..66a682d5a8 100644
> > --- a/tests/test-qobject-output-visitor.c
> > +++ b/tests/test-qobject-output-visitor.c
> > @@ -58,13 +58,13 @@ static void test_visitor_out_int(TestOutputVisitorD=
ata *data,
> >                                   const void *unused)
> >  {
> >      int64_t value =3D -42;
> > -    QInt *qint;
> > +    QNum *qnum;
> > =20
> >      visit_type_int(data->ov, NULL, &value, &error_abort);
> > =20
> > -    qint =3D qobject_to_qint(visitor_get(data));
> > -    g_assert(qint);
> > -    g_assert_cmpint(qint_get_int(qint), =3D=3D, value);
> > +    qnum =3D qobject_to_qnum(visitor_get(data));
> > +    g_assert(qnum);
> > +    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, value);
> >  }
> > =20
> >  static void test_visitor_out_bool(TestOutputVisitorData *data,
> > @@ -84,13 +84,13 @@ static void test_visitor_out_number(TestOutputVisit=
orData *data,
> >                                      const void *unused)
> >  {
> >      double value =3D 3.14;
> > -    QFloat *qfloat;
> > +    QNum *qnum;
> > =20
> >      visit_type_number(data->ov, NULL, &value, &error_abort);
> > =20
> > -    qfloat =3D qobject_to_qfloat(visitor_get(data));
> > -    g_assert(qfloat);
> > -    g_assert(qfloat_get_double(qfloat) =3D=3D value);
> > +    qnum =3D qobject_to_qnum(visitor_get(data));
> > +    g_assert(qnum);
> > +    g_assert(qnum_get_double(qnum) =3D=3D value);
> >  }
> > =20
> >  static void test_visitor_out_string(TestOutputVisitorData *data,
> > @@ -329,16 +329,16 @@ static void test_visitor_out_any(TestOutputVisito=
rData *data,
> >                                   const void *unused)
> >  {
> >      QObject *qobj;
> > -    QInt *qint;
> > +    QNum *qnum;
> >      QBool *qbool;
> >      QString *qstring;
> >      QDict *qdict;
> > =20
> > -    qobj =3D QOBJECT(qint_from_int(-42));
> > +    qobj =3D QOBJECT(qnum_from_int(-42));
> >      visit_type_any(data->ov, NULL, &qobj, &error_abort);
> > -    qint =3D qobject_to_qint(visitor_get(data));
> > -    g_assert(qint);
> > -    g_assert_cmpint(qint_get_int(qint), =3D=3D, -42);
> > +    qnum =3D qobject_to_qnum(visitor_get(data));
> > +    g_assert(qnum);
> > +    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, -42);
> >      qobject_decref(qobj);
> > =20
> >      visitor_reset(data);
> > @@ -351,9 +351,9 @@ static void test_visitor_out_any(TestOutputVisitorD=
ata *data,
> >      qobject_decref(qobj);
> >      qdict =3D qobject_to_qdict(visitor_get(data));
> >      g_assert(qdict);
> > -    qint =3D qobject_to_qint(qdict_get(qdict, "integer"));
> > -    g_assert(qint);
> > -    g_assert_cmpint(qint_get_int(qint), =3D=3D, -42);
> > +    qnum =3D qobject_to_qnum(qdict_get(qdict, "integer"));
> > +    g_assert(qnum);
> > +    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, -42);
> >      qbool =3D qobject_to_qbool(qdict_get(qdict, "boolean"));
> >      g_assert(qbool);
> >      g_assert(qbool_get_bool(qbool) =3D=3D true);
> > @@ -388,18 +388,18 @@ static void test_visitor_out_alternate(TestOutput=
VisitorData *data,
> >                                         const void *unused)
> >  {
> >      UserDefAlternate *tmp;
> > -    QInt *qint;
> > +    QNum *qnum;
> >      QString *qstr;
> >      QDict *qdict;
> > =20
> >      tmp =3D g_new0(UserDefAlternate, 1);
> > -    tmp->type =3D QTYPE_QINT;
> > +    tmp->type =3D QTYPE_QNUM;
> >      tmp->u.i =3D 42;
> > =20
> >      visit_type_UserDefAlternate(data->ov, NULL, &tmp, &error_abort);
> > -    qint =3D qobject_to_qint(visitor_get(data));
> > -    g_assert(qint);
> > -    g_assert_cmpint(qint_get_int(qint), =3D=3D, 42);
> > +    qnum =3D qobject_to_qnum(visitor_get(data));
> > +    g_assert(qnum);
> > +    g_assert_cmpint(qnum_get_int(qnum, &error_abort), =3D=3D, 42);
> > =20
> >      qapi_free_UserDefAlternate(tmp);
> > =20
> > @@ -603,18 +603,18 @@ static void check_native_list(QObject *qobj,
> >      case USER_DEF_NATIVE_LIST_UNION_KIND_U16:
> >      case USER_DEF_NATIVE_LIST_UNION_KIND_U32:
> >      case USER_DEF_NATIVE_LIST_UNION_KIND_U64:
> > -        /* all integer elements in JSON arrays get stored into QInts w=
hen
> > +        /* all integer elements in JSON arrays get stored into QNums w=
hen =20
>=20
> Please use the opportunity to wing the comment at both ends and start
> with a capital letter:
>=20
>            /*
>             * All integer ...
>=20
> >           * we convert to QObjects, so we can check them all in the same
> >           * fashion, so simply fall through here
> >           */
> >      case USER_DEF_NATIVE_LIST_UNION_KIND_INTEGER:
> >          for (i =3D 0; i < 32; i++) {
> >              QObject *tmp;
> > -            QInt *qvalue;
> > +            QNum *qvalue;
> >              tmp =3D qlist_peek(qlist);
> >              g_assert(tmp);
> > -            qvalue =3D qobject_to_qint(tmp);
> > -            g_assert_cmpint(qint_get_int(qvalue), =3D=3D, i);
> > +            qvalue =3D qobject_to_qnum(tmp);
> > +            g_assert_cmpint(qnum_get_int(qvalue, &error_abort), =3D=3D=
, i);
> >              qobject_decref(qlist_pop(qlist));
> >          }
> >          break;
> > @@ -645,15 +645,15 @@ static void check_native_list(QObject *qobj,
> >      case USER_DEF_NATIVE_LIST_UNION_KIND_NUMBER:
> >          for (i =3D 0; i < 32; i++) {
> >              QObject *tmp;
> > -            QFloat *qvalue;
> > +            QNum *qvalue;
> >              GString *double_expected =3D g_string_new("");
> >              GString *double_actual =3D g_string_new("");
> > =20
> >              tmp =3D qlist_peek(qlist);
> >              g_assert(tmp);
> > -            qvalue =3D qobject_to_qfloat(tmp);
> > +            qvalue =3D qobject_to_qnum(tmp);
> >              g_string_printf(double_expected, "%.6f", (double)i / 3);
> > -            g_string_printf(double_actual, "%.6f", qfloat_get_double(q=
value));
> > +            g_string_printf(double_actual, "%.6f", qnum_get_double(qva=
lue));
> >              g_assert_cmpstr(double_actual->str, =3D=3D, double_expecte=
d->str);
> > =20
> >              qobject_decref(qlist_pop(qlist));
> > diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compa=
t.c
> > index 79a2e69a28..60d168fda8 100644
> > --- a/tests/test-x86-cpuid-compat.c
> > +++ b/tests/test-x86-cpuid-compat.c
> > @@ -1,9 +1,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu-common.h"
> > -#include "qapi/qmp/qlist.h"
> > -#include "qapi/qmp/qdict.h"
> > -#include "qapi/qmp/qint.h"
> > -#include "qapi/qmp/qbool.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qmp/types.h" =20
>=20
> Previous note on qapi/qmp/types.h applies.
>=20
> >  #include "libqtest.h"
> > =20
> >  static char *get_cpu0_qom_path(void)
> > @@ -56,12 +54,13 @@ static void test_cpuid_prop(const void *data)
> >  {
> >      const CpuidTestArgs *args =3D data;
> >      char *path;
> > -    QInt *value;
> > +    QNum *value;
> > =20
> >      qtest_start(args->cmdline);
> >      path =3D get_cpu0_qom_path();
> > -    value =3D qobject_to_qint(qom_get(path, args->property));
> > -    g_assert_cmpint(qint_get_int(value), =3D=3D, args->expected_value);
> > +    value =3D qobject_to_qnum(qom_get(path, args->property));
> > +    g_assert_cmpint(qnum_get_int(value, &error_abort), =3D=3D,
> > +                    args->expected_value);
> >      qtest_end();
> > =20
> >      QDECREF(value);
> > diff --git a/ui/spice-core.c b/ui/spice-core.c
> > index 804abc5c0f..561d0649cf 100644
> > --- a/ui/spice-core.c
> > +++ b/ui/spice-core.c
> > @@ -30,7 +30,6 @@
> >  #include "qemu-x509.h"
> >  #include "qemu/sockets.h"
> >  #include "qmp-commands.h"
> > -#include "qapi/qmp/qint.h"
> >  #include "qapi/qmp/qbool.h"
> >  #include "qapi/qmp/qstring.h"
> >  #include "qapi/qmp/qjson.h"
> > diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
> > index 1e53b1cf84..89ab12c0d8 100644
> > --- a/ui/vnc-enc-tight.c
> > +++ b/ui/vnc-enc-tight.c
> > @@ -44,7 +44,6 @@
> >  #endif
> > =20
> >  #include "qemu/bswap.h"
> > -#include "qapi/qmp/qint.h"
> >  #include "vnc.h"
> >  #include "vnc-enc-tight.h"
> >  #include "vnc-palette.h"
> > diff --git a/util/qemu-option.c b/util/qemu-option.c
> > index 5977bfc3e9..39b1e06225 100644
> > --- a/util/qemu-option.c
> > +++ b/util/qemu-option.c
> > @@ -941,9 +941,8 @@ typedef struct OptsFromQDictState {
> >  static void qemu_opts_from_qdict_1(const char *key, QObject *obj, void=
 *opaque)
> >  {
> >      OptsFromQDictState *state =3D opaque;
> > -    char buf[32];
> > +    char buf[32], *tmp =3D NULL;
> >      const char *value;
> > -    int n;
> > =20
> >      if (!strcmp(key, "id") || *state->errp) {
> >          return;
> > @@ -953,17 +952,9 @@ static void qemu_opts_from_qdict_1(const char *key=
, QObject *obj, void *opaque)
> >      case QTYPE_QSTRING:
> >          value =3D qstring_get_str(qobject_to_qstring(obj));
> >          break;
> > -    case QTYPE_QINT:
> > -        n =3D snprintf(buf, sizeof(buf), "%" PRId64,
> > -                     qint_get_int(qobject_to_qint(obj)));
> > -        assert(n < sizeof(buf));
> > -        value =3D buf;
> > -        break;
> > -    case QTYPE_QFLOAT:
> > -        n =3D snprintf(buf, sizeof(buf), "%.17g",
> > -                     qfloat_get_double(qobject_to_qfloat(obj)));
> > -        assert(n < sizeof(buf));
> > -        value =3D buf;
> > +    case QTYPE_QNUM:
> > +        tmp =3D qnum_to_string(qobject_to_qnum(obj));
> > +        value =3D tmp;
> >          break;
> >      case QTYPE_QBOOL:
> >          pstrcpy(buf, sizeof(buf),
> > @@ -975,12 +966,13 @@ static void qemu_opts_from_qdict_1(const char *ke=
y, QObject *obj, void *opaque)
> >      }
> > =20
> >      qemu_opt_set(state->opts, key, value, state->errp);
> > +    g_free(tmp);
> >  }
> > =20
> >  /*
> >   * Create QemuOpts from a QDict.
> >   * Use value of key "id" as ID if it exists and is a QString.
> > - * Only QStrings, QInts, QFloats and QBools are copied.  Entries with
> > + * Only QStrings, QNums and QBools are copied.  Entries with
> >   * other types are silently ignored.
> >   */ =20
>=20
> Refill the sentence, please.
>=20
> >  QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 66c9734311..421fb585ae 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1395,8 +1395,7 @@ F: include/qapi/qmp/
> >  X: include/qapi/qmp/dispatch.h
> >  F: scripts/coccinelle/qobject.cocci
> >  F: tests/check-qdict.c
> > -F: tests/check-qfloat.c
> > -F: tests/check-qint.c
> > +F: tests/check-qnum.c
> >  F: tests/check-qjson.c
> >  F: tests/check-qlist.c
> >  F: tests/check-qstring.c
> > diff --git a/qobject/Makefile.objs b/qobject/Makefile.objs
> > index bed55084bb..fc8885c9a4 100644
> > --- a/qobject/Makefile.objs
> > +++ b/qobject/Makefile.objs
> > @@ -1,2 +1,2 @@
> > -util-obj-y =3D qnull.o qint.o qstring.o qdict.o qlist.o qfloat.o qbool=
.o
> > +util-obj-y =3D qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o
> >  util-obj-y +=3D qjson.o qobject.o json-lexer.o json-streamer.o json-pa=
rser.o
> > diff --git a/scripts/coccinelle/qobject.cocci b/scripts/coccinelle/qobj=
ect.cocci
> > index 97703a438b..c3253deb1b 100644
> > --- a/scripts/coccinelle/qobject.cocci
> > +++ b/scripts/coccinelle/qobject.cocci
> > @@ -6,7 +6,7 @@ expression Obj, Key, E;
> >  - qdict_put_obj(Obj, Key, QOBJECT(E));
> >  + qdict_put(Obj, Key, E);
> >  |
> > -- qdict_put(Obj, Key, qint_from_int(E));
> > +- qdict_put(Obj, Key, qnum_from_int(E));
> >  + qdict_put_int(Obj, Key, E);
> >  |
> >  - qdict_put(Obj, Key, qbool_from_bool(E));
> > @@ -24,7 +24,7 @@ expression Obj, E;
> >  - qlist_append_obj(Obj, QOBJECT(E));
> >  + qlist_append(Obj, E);
> >  |
> > -- qlist_append(Obj, qint_from_int(E));
> > +- qlist_append(Obj, qnum_from_int(E));
> >  + qlist_append_int(Obj, E);
> >  |
> >  - qlist_append(Obj, qbool_from_bool(E));
> > diff --git a/tests/.gitignore b/tests/.gitignore
> > index a966740c2c..847f4f1474 100644
> > --- a/tests/.gitignore
> > +++ b/tests/.gitignore
> > @@ -1,7 +1,6 @@
> >  atomic_add-bench
> >  check-qdict
> > -check-qfloat
> > -check-qint
> > +check-qnum
> >  check-qjson
> >  check-qlist
> >  check-qnull
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 31931c0d77..ac0387d88a 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -10,10 +10,8 @@ check-unit-y =3D tests/check-qdict$(EXESUF)
> >  gcov-files-check-qdict-y =3D qobject/qdict.c
> >  check-unit-y +=3D tests/test-char$(EXESUF)
> >  gcov-files-check-qdict-y =3D chardev/char.c
> > -check-unit-y +=3D tests/check-qfloat$(EXESUF)
> > -gcov-files-check-qfloat-y =3D qobject/qfloat.c
> > -check-unit-y +=3D tests/check-qint$(EXESUF)
> > -gcov-files-check-qint-y =3D qobject/qint.c
> > +check-unit-y +=3D tests/check-qnum$(EXESUF)
> > +gcov-files-check-qnum-y =3D qobject/qnum.c
> >  check-unit-y +=3D tests/check-qstring$(EXESUF)
> >  gcov-files-check-qstring-y =3D qobject/qstring.c
> >  check-unit-y +=3D tests/check-qlist$(EXESUF)
> > @@ -500,8 +498,8 @@ GENERATED_FILES +=3D tests/test-qapi-types.h tests/=
test-qapi-visit.h \
> >  	tests/test-qmp-commands.h tests/test-qapi-event.h \
> >  	tests/test-qmp-introspect.h
> > =20
> > -test-obj-y =3D tests/check-qint.o tests/check-qstring.o tests/check-qd=
ict.o \
> > -	tests/check-qlist.o tests/check-qfloat.o tests/check-qnull.o \
> > +test-obj-y =3D tests/check-qnum.o tests/check-qstring.o tests/check-qd=
ict.o \
> > +	tests/check-qlist.o tests/check-qnull.o \
> >  	tests/check-qjson.o \
> >  	tests/test-coroutine.o tests/test-string-output-visitor.o \
> >  	tests/test-string-input-visitor.o tests/test-qobject-output-visitor.o=
 \
> > @@ -529,11 +527,10 @@ test-crypto-obj-y =3D $(crypto-obj-y) $(test-qom-=
obj-y)
> >  test-io-obj-y =3D $(io-obj-y) $(test-crypto-obj-y)
> >  test-block-obj-y =3D $(block-obj-y) $(test-io-obj-y) tests/iothread.o
> > =20
> > -tests/check-qint$(EXESUF): tests/check-qint.o $(test-util-obj-y)
> > +tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
> >  tests/check-qstring$(EXESUF): tests/check-qstring.o $(test-util-obj-y)
> >  tests/check-qdict$(EXESUF): tests/check-qdict.o $(test-util-obj-y)
> >  tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)
> > -tests/check-qfloat$(EXESUF): tests/check-qfloat.o $(test-util-obj-y)
> >  tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
> >  tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
> >  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test=
-qom-obj-y)
> > diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comment=
s.out
> > index 5d7c13cad1..17e652535c 100644
> > --- a/tests/qapi-schema/comments.out
> > +++ b/tests/qapi-schema/comments.out
> > @@ -1,4 +1,4 @@
> > -enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfl=
oat', 'qbool']
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
> >      prefix QTYPE
> >  enum Status ['good', 'bad', 'ugly']
> >  object q_empty
> > diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-goo=
d.out
> > index 70c1252408..63ca25a8b9 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -6,7 +6,7 @@ object Object
> >      tag base1
> >      case one: Variant1
> >      case two: Variant2
> > -enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfl=
oat', 'qbool']
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
> >      prefix QTYPE
> >  object SugaredUnion
> >      member type: SugaredUnionKind optional=3DFalse
> > diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
> > index 8a5b034424..40b886ddae 100644
> > --- a/tests/qapi-schema/empty.out
> > +++ b/tests/qapi-schema/empty.out
> > @@ -1,3 +1,3 @@
> > -enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfl=
oat', 'qbool']
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
> >      prefix QTYPE
> >  object q_empty
> > diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event=
-case.out
> > index 5a0f2bf805..313c0fe7be 100644
> > --- a/tests/qapi-schema/event-case.out
> > +++ b/tests/qapi-schema/event-case.out
> > @@ -1,4 +1,4 @@
> > -enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfl=
oat', 'qbool']
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
> >      prefix QTYPE
> >  event oops None
> >     boxed=3DFalse
> > diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schem=
a/ident-with-escape.out
> > index 1d2722c02e..b5637cb2e0 100644
> > --- a/tests/qapi-schema/ident-with-escape.out
> > +++ b/tests/qapi-schema/ident-with-escape.out
> > @@ -1,4 +1,4 @@
> > -enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfl=
oat', 'qbool']
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
> >      prefix QTYPE
> >  command fooA q_obj_fooA-arg -> None
> >     gen=3DTrue success_response=3DTrue boxed=3DFalse
> > diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/=
include-relpath.out
> > index 5d7c13cad1..17e652535c 100644
> > --- a/tests/qapi-schema/include-relpath.out
> > +++ b/tests/qapi-schema/include-relpath.out
> > @@ -1,4 +1,4 @@
> > -enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfl=
oat', 'qbool']
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
> >      prefix QTYPE
> >  enum Status ['good', 'bad', 'ugly']
> >  object q_empty
> > diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-sche=
ma/include-repetition.out
> > index 5d7c13cad1..17e652535c 100644
> > --- a/tests/qapi-schema/include-repetition.out
> > +++ b/tests/qapi-schema/include-repetition.out
> > @@ -1,4 +1,4 @@
> > -enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfl=
oat', 'qbool']
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
> >      prefix QTYPE
> >  enum Status ['good', 'bad', 'ugly']
> >  object q_empty
> > diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/i=
nclude-simple.out
> > index 5d7c13cad1..17e652535c 100644
> > --- a/tests/qapi-schema/include-simple.out
> > +++ b/tests/qapi-schema/include-simple.out
> > @@ -1,4 +1,4 @@
> > -enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfl=
oat', 'qbool']
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
> >      prefix QTYPE
> >  enum Status ['good', 'bad', 'ugly']
> >  object q_empty
> > diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/in=
dented-expr.out
> > index e8171c935f..586795f44d 100644
> > --- a/tests/qapi-schema/indented-expr.out
> > +++ b/tests/qapi-schema/indented-expr.out
> > @@ -1,4 +1,4 @@
> > -enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfl=
oat', 'qbool']
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
> >      prefix QTYPE
> >  command eins None -> None
> >     gen=3DTrue success_response=3DTrue boxed=3DFalse
> > diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema=
/qapi-schema-test.out
> > index 5c6655a5c3..7812a6c69b 100644
> > --- a/tests/qapi-schema/qapi-schema-test.out
> > +++ b/tests/qapi-schema/qapi-schema-test.out
> > @@ -46,7 +46,7 @@ object NestedEnumsOne
> >      member enum4: EnumOne optional=3DTrue
> >  enum QEnumTwo ['value1', 'value2']
> >      prefix QENUM_TWO
> > -enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfl=
oat', 'qbool']
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
> >      prefix QTYPE
> >  object TestStruct
> >      member integer: int optional=3DFalse =20
>=20
> I still like it :)
>=20
