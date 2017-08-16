Received: from eggs.gnu.org ([2001:4830:134:3::10]:43100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhuAX-0008Pi-Qh
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhuAT-00067B-Oe
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:59:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhuAT-00064q-Er
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:59:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3853276B27
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 08:59:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-4-marcandre.lureau@redhat.com>
Date: Wed, 16 Aug 2017 10:59:06 +0200
In-Reply-To: <20170727154126.11339-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 27 Jul 2017 17:41:03 +0200")
Message-ID: <87efsbevmt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/26] qboject: add literal qobject type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

In the subject: s/qboject: add/qobject: Add/

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Promote LiteralQObject from tests/check-qjson.c to qobject/qlit.c,
> allowing to statically declare complex qobjects.
>
> Add a helper qobject_from_qlit() to instantiate a literal qobject to a
> real QObject. Add some simple test.

Suggest

* to also move the existing function making use of LiteralQObject
  compare_litqobj_to_qobj(), so other tests can use it to verify a
  QObject matches expectations, and

* to split the patch into the move and the addition of
  qobject_from_qlit().

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h | 53 ++++++++++++++++++++++++++++++++++++
>  qobject/qlit.c          | 53 ++++++++++++++++++++++++++++++++++++
>  tests/check-qjson.c     | 72 +++++++++++++++++--------------------------=
------
>  tests/check-qlit.c      | 52 +++++++++++++++++++++++++++++++++++
>  qobject/Makefile.objs   |  2 +-
>  tests/Makefile.include  |  5 +++-
>  6 files changed, 187 insertions(+), 50 deletions(-)
>  create mode 100644 include/qapi/qmp/qlit.h
>  create mode 100644 qobject/qlit.c
>  create mode 100644 tests/check-qlit.c
>
> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> new file mode 100644
> index 0000000000..fd6bfc3e69
> --- /dev/null
> +++ b/include/qapi/qmp/qlit.h
> @@ -0,0 +1,53 @@
> +/*
> + * Copyright IBM, Corp. 2009
> + * Copyright (c) 2013, 2015 Red Hat Inc.
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *  Markus Armbruster <armbru@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +#ifndef QLIT_H_
> +#define QLIT_H_
> +
> +#include "qapi-types.h"
> +#include "qobject.h"
> +
> +typedef struct QLitDictEntry QLitDictEntry;
> +typedef struct QLitObject QLitObject;
> +
> +struct QLitObject {
> +    int type;
> +    union {
> +        bool qbool;
> +        int64_t qnum;

Not this patch's fault: QLitObject restricts numbers to signed integers.

> +        const char *qstr;
> +        QLitDictEntry *qdict;
> +        QLitObject *qlist;
> +    } value;
> +};
> +
> +struct QLitDictEntry {
> +    const char *key;
> +    QLitObject value;
> +};
> +
> +#define QLIT_QNULL \
> +    { .type =3D QTYPE_QNULL }
> +#define QLIT_QBOOL(val) \
> +    { .type =3D QTYPE_QBOOL, .value.qbool =3D (val) }
> +#define QLIT_QNUM(val) \
> +    { .type =3D QTYPE_QNUM, .value.qnum =3D (val) }
> +#define QLIT_QSTR(val) \
> +    { .type =3D QTYPE_QSTRING, .value.qstr =3D (val) }
> +#define QLIT_QDICT(val) \
> +    { .type =3D QTYPE_QDICT, .value.qdict =3D (val) }
> +#define QLIT_QLIST(val) \
> +    { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
> +
> +QObject *qobject_from_qlit(const QLitObject *qlit);
> +
> +#endif /* QLIT_H_ */
> diff --git a/qobject/qlit.c b/qobject/qlit.c
> new file mode 100644
> index 0000000000..d7407b4b34
> --- /dev/null
> +++ b/qobject/qlit.c
> @@ -0,0 +1,53 @@
> +/*
> + * QLit literal qobject
> + *
> + * Copyright (C) 2017 Red Hat Inc.
> + *
> + * Authors:
> + *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/qmp/qlit.h"
> +#include "qapi/qmp/types.h"
> +
> +QObject *qobject_from_qlit(const QLitObject *qlit)
> +{
> +    int i;
> +
> +    switch (qlit->type) {
> +    case QTYPE_QNULL:
> +        return QOBJECT(qnull());
> +    case QTYPE_QNUM:
> +        return QOBJECT(qnum_from_int(qlit->value.qnum));
> +    case QTYPE_QSTRING:
> +        return QOBJECT(qstring_from_str(qlit->value.qstr));
> +    case QTYPE_QDICT: {
> +        QDict *qdict =3D qdict_new();
> +        for (i =3D 0; qlit->value.qdict[i].value.type !=3D QTYPE_NONE; i=
++) {
> +            QLitDictEntry *e =3D &qlit->value.qdict[i];
> +
> +            qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value));
> +        }
> +        return QOBJECT(qdict);
> +    }
> +    case QTYPE_QLIST: {
> +        QList *qlist =3D qlist_new();
> +
> +        for (i =3D 0; qlit->value.qlist[i].type !=3D QTYPE_NONE; i++) {
> +            qlist_append_obj(qlist, qobject_from_qlit(&qlit->value.qlist=
[i]));
> +        }
> +        return QOBJECT(qlist);
> +    }
> +    case QTYPE_QBOOL:
> +        return QOBJECT(qbool_from_bool(qlit->value.qbool));
> +    case QTYPE_NONE:
> +        assert(0);
> +    }
> +
> +    return NULL;
> +}
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index 9c42a46b7d..1a95aff2ba 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -16,6 +16,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qmp/types.h"
>  #include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qlit.h"
>  #include "qemu-common.h"
>=20=20
>  static void escaped_string(void)
> @@ -1059,39 +1060,14 @@ static void keyword_literal(void)
>      QDECREF(null);
>  }
>=20=20
> -typedef struct LiteralQDictEntry LiteralQDictEntry;
> -typedef struct LiteralQObject LiteralQObject;
> -
> -struct LiteralQObject
> -{
> -    int type;
> -    union {
> -        int64_t qnum;
> -        const char *qstr;
> -        LiteralQDictEntry *qdict;
> -        LiteralQObject *qlist;
> -    } value;
> -};
> -
> -struct LiteralQDictEntry
> -{
> -    const char *key;
> -    LiteralQObject value;
> -};
> -
> -#define QLIT_QNUM(val) (LiteralQObject){.type =3D QTYPE_QNUM, .value.qnu=
m =3D (val)}
> -#define QLIT_QSTR(val) (LiteralQObject){.type =3D QTYPE_QSTRING, .value.=
qstr =3D (val)}
> -#define QLIT_QDICT(val) (LiteralQObject){.type =3D QTYPE_QDICT, .value.q=
dict =3D (val)}
> -#define QLIT_QLIST(val) (LiteralQObject){.type =3D QTYPE_QLIST, .value.q=
list =3D (val)}
> -
>  typedef struct QListCompareHelper
>  {
>      int index;
> -    LiteralQObject *objs;
> +    QLitObject *objs;
>      int result;
>  } QListCompareHelper;
>=20=20
> -static int compare_litqobj_to_qobj(LiteralQObject *lhs, QObject *rhs);
> +static int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);
>=20=20
>  static void compare_helper(QObject *obj, void *opaque)
>  {
> @@ -1109,7 +1085,7 @@ static void compare_helper(QObject *obj, void *opaq=
ue)
>      helper->result =3D compare_litqobj_to_qobj(&helper->objs[helper->ind=
ex++], obj);
>  }
>=20=20
> -static int compare_litqobj_to_qobj(LiteralQObject *lhs, QObject *rhs)
> +static int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs)
>  {
>      int64_t val;
>=20=20
> @@ -1159,23 +1135,23 @@ static void simple_dict(void)
>      int i;
>      struct {
>          const char *encoded;
> -        LiteralQObject decoded;
> +        QLitObject decoded;
>      } test_cases[] =3D {
>          {
>              .encoded =3D "{\"foo\": 42, \"bar\": \"hello world\"}",
> -            .decoded =3D QLIT_QDICT(((LiteralQDictEntry[]){
> +            .decoded =3D QLIT_QDICT(((QLitDictEntry[]){
>                          { "foo", QLIT_QNUM(42) },
>                          { "bar", QLIT_QSTR("hello world") },
>                          { }
>                      })),
>          }, {
>              .encoded =3D "{}",
> -            .decoded =3D QLIT_QDICT(((LiteralQDictEntry[]){
> +            .decoded =3D QLIT_QDICT(((QLitDictEntry[]){
>                          { }
>                      })),
>          }, {
>              .encoded =3D "{\"foo\": 43}",
> -            .decoded =3D QLIT_QDICT(((LiteralQDictEntry[]){
> +            .decoded =3D QLIT_QDICT(((QLitDictEntry[]){
>                          { "foo", QLIT_QNUM(43) },
>                          { }
>                      })),
> @@ -1257,11 +1233,11 @@ static void simple_list(void)
>      int i;
>      struct {
>          const char *encoded;
> -        LiteralQObject decoded;
> +        QLitObject decoded;
>      } test_cases[] =3D {
>          {
>              .encoded =3D "[43,42]",
> -            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> +            .decoded =3D QLIT_QLIST(((QLitObject[]){
>                          QLIT_QNUM(43),
>                          QLIT_QNUM(42),
>                          { }
> @@ -1269,21 +1245,21 @@ static void simple_list(void)
>          },
>          {
>              .encoded =3D "[43]",
> -            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> +            .decoded =3D QLIT_QLIST(((QLitObject[]){
>                          QLIT_QNUM(43),
>                          { }
>                      })),
>          },
>          {
>              .encoded =3D "[]",
> -            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> +            .decoded =3D QLIT_QLIST(((QLitObject[]){
>                          { }
>                      })),
>          },
>          {
>              .encoded =3D "[{}]",
> -            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> -                        QLIT_QDICT(((LiteralQDictEntry[]){
> +            .decoded =3D QLIT_QLIST(((QLitObject[]){
> +                        QLIT_QDICT(((QLitDictEntry[]){
>                                      {},
>                                          })),
>                          {},
> @@ -1314,11 +1290,11 @@ static void simple_whitespace(void)
>      int i;
>      struct {
>          const char *encoded;
> -        LiteralQObject decoded;
> +        QLitObject decoded;
>      } test_cases[] =3D {
>          {
>              .encoded =3D " [ 43 , 42 ]",
> -            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> +            .decoded =3D QLIT_QLIST(((QLitObject[]){
>                          QLIT_QNUM(43),
>                          QLIT_QNUM(42),
>                          { }
> @@ -1326,12 +1302,12 @@ static void simple_whitespace(void)
>          },
>          {
>              .encoded =3D " [ 43 , { 'h' : 'b' }, [ ], 42 ]",
> -            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> +            .decoded =3D QLIT_QLIST(((QLitObject[]){
>                          QLIT_QNUM(43),
> -                        QLIT_QDICT(((LiteralQDictEntry[]){
> +                        QLIT_QDICT(((QLitDictEntry[]){
>                                      { "h", QLIT_QSTR("b") },
>                                      { }})),
> -                        QLIT_QLIST(((LiteralQObject[]){
> +                        QLIT_QLIST(((QLitObject[]){
>                                      { }})),
>                          QLIT_QNUM(42),
>                          { }
> @@ -1339,13 +1315,13 @@ static void simple_whitespace(void)
>          },
>          {
>              .encoded =3D " [ 43 , { 'h' : 'b' , 'a' : 32 }, [ ], 42 ]",
> -            .decoded =3D QLIT_QLIST(((LiteralQObject[]){
> +            .decoded =3D QLIT_QLIST(((QLitObject[]){
>                          QLIT_QNUM(43),
> -                        QLIT_QDICT(((LiteralQDictEntry[]){
> +                        QLIT_QDICT(((QLitDictEntry[]){
>                                      { "h", QLIT_QSTR("b") },
>                                      { "a", QLIT_QNUM(32) },
>                                      { }})),
> -                        QLIT_QLIST(((LiteralQObject[]){
> +                        QLIT_QLIST(((QLitObject[]){
>                                      { }})),
>                          QLIT_QNUM(42),
>                          { }
> @@ -1393,10 +1369,10 @@ static void simple_varargs(void)
>  {
>      QObject *embedded_obj;
>      QObject *obj;
> -    LiteralQObject decoded =3D QLIT_QLIST(((LiteralQObject[]){
> +    QLitObject decoded =3D QLIT_QLIST(((QLitObject[]){
>              QLIT_QNUM(1),
>              QLIT_QNUM(2),
> -            QLIT_QLIST(((LiteralQObject[]){
> +            QLIT_QLIST(((QLitObject[]){
>                          QLIT_QNUM(32),
>                          QLIT_QNUM(42),
>                          {}})),
> diff --git a/tests/check-qlit.c b/tests/check-qlit.c
> new file mode 100644
> index 0000000000..cda4620f92
> --- /dev/null
> +++ b/tests/check-qlit.c
> @@ -0,0 +1,52 @@
> +/*
> + * QLit unit-tests.
> + *
> + * Copyright (C) 2017 Red Hat Inc.
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/qmp/qlit.h"
> +
> +static void qobject_from_qlit_test(void)
> +{
> +    char *str;
> +    QObject *qobj =3D NULL;
> +    QLitObject qlit =3D QLIT_QDICT((
> +        (QLitDictEntry[]) {
> +            { "foo", QLIT_QNUM(42) },
> +            { "bar", QLIT_QSTR("hello world") },
> +            { "baz", QLIT_QNULL },
> +            { "bee", QLIT_QLIST((
> +                (QLitObject[]) {
> +                    QLIT_QNUM(43),
> +                    QLIT_QNUM(44),
> +                    QLIT_QBOOL(true),
> +                    { },
> +                }))
> +            },
> +            { },
> +        }));
> +
> +    qobj =3D qobject_from_qlit(&qlit);
> +
> +    str =3D qobject_to_string(qobj);
> +    g_assert_cmpstr(str, =3D=3D,
> +                    "bee:\n    [0]: 43\n    [1]: 44\n    [2]: true\n"   \
> +                    "baz: null\nbar: hello world\nfoo: 42\n");

I don't like this.  The order of QDict members in @str depends on
qdict_first()/qdict_next() iteration order, which is unspecified.

Here's how we check elsewhere that a QObject matches expectations:

    static void qobject_from_qlit_test(void)
    {
        QLitObject qlit =3D QLIT_QDICT((
            (QLitDictEntry[]) {
                { "foo", QLIT_QNUM(42) },
                { "bar", QLIT_QSTR("hello world") },
                { "baz", QLIT_QNULL },
                { "bee", QLIT_QLIST((
                    (QLitObject[]) {
                        QLIT_QNUM(43),
                        QLIT_QNUM(44),
                        QLIT_QBOOL(true),
                        { },
                    }))
                },
                { },
            }));
        QObject *qobj =3D qobject_from_qlit(&qlit);
        QDict *qdict;
        QList *baz;

        qdict =3D qobject_to_qdict(qobj);
        g_assert_cmpint(qdict_get_int(qdict, "foo"), =3D=3D, 42);
        g_assert_cmpstr(qdict_get_str(qdict, "bar"), =3D=3D, "hello world");
        g_assert(qobject_type(qdict_get(qdict, "baz")) =3D=3D QTYPE_QNULL);
        baz =3D qdict_get_qlist(qdict, "bee");
        g_assert_cmpint(qnum_get_int(qobject_to_qnum(qlist_pop(baz))), =3D=
=3D, 43);
        g_assert_cmpint(qnum_get_int(qobject_to_qnum(qlist_pop(baz))), =3D=
=3D, 44);
        g_assert_cmpint(qbool_get_bool(qobject_to_qbool(qlist_pop(baz))), =
=3D=3D, 1);

        qobject_decref(qobj);
    }

Robust, just tedious.

check-qjson.c uses a differently tedious technique: compare expected
QLitObject to actual QObject with compare_litqobj_to_qobj().  I like
that better, because I find the QLIT... initializers easier to read, and
less error prone to write.  You might prefer not to use QLit to test
QLit, though.

> +
> +    g_free(str);
> +    qobject_decref(qobj);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    g_test_add_func("/qlit/qobject_from_qlit", qobject_from_qlit_test);
> +
> +    return g_test_run();
> +}
> diff --git a/qobject/Makefile.objs b/qobject/Makefile.objs
> index fc8885c9a4..002d25873a 100644
> --- a/qobject/Makefile.objs
> +++ b/qobject/Makefile.objs
> @@ -1,2 +1,2 @@
> -util-obj-y =3D qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o
> +util-obj-y =3D qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o qlit.o
>  util-obj-y +=3D qjson.o qobject.o json-lexer.o json-streamer.o json-pars=
er.o
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7af278db55..960ab8c6dd 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -12,6 +12,8 @@ check-unit-y +=3D tests/test-char$(EXESUF)
>  gcov-files-check-qdict-y =3D chardev/char.c
>  check-unit-y +=3D tests/check-qnum$(EXESUF)
>  gcov-files-check-qnum-y =3D qobject/qnum.c
> +check-unit-y +=3D tests/check-qlit$(EXESUF)
> +gcov-files-check-qlit-y =3D qobject/qlit.c
>  check-unit-y +=3D tests/check-qstring$(EXESUF)
>  gcov-files-check-qstring-y =3D qobject/qstring.c
>  check-unit-y +=3D tests/check-qlist$(EXESUF)
> @@ -523,7 +525,7 @@ test-obj-y =3D tests/check-qnum.o tests/check-qstring=
.o tests/check-qdict.o \
>  	tests/rcutorture.o tests/test-rcu-list.o \
>  	tests/test-qdist.o tests/test-shift128.o \
>  	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
> -	tests/atomic_add-bench.o
> +	tests/atomic_add-bench.o tests/check-qlit.o

Please add it right next to the other qobject-related tests:

   test-obj-y =3D tests/check-qnum.o tests/check-qstring.o tests/check-qdic=
t.o \
 	tests/check-qlist.o tests/check-qnull.o \
-	tests/check-qjson.o \
+	tests/check-qjson.o tests/check-qlit.o \

>=20=20
>  $(test-obj-y): QEMU_INCLUDES +=3D -Itests
>  QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests
> @@ -541,6 +543,7 @@ test-io-obj-y =3D $(io-obj-y) $(test-crypto-obj-y)
>  test-block-obj-y =3D $(block-obj-y) $(test-io-obj-y) tests/iothread.o
>=20=20
>  tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
> +tests/check-qlit$(EXESUF): tests/check-qlit.o $(test-util-obj-y)
>  tests/check-qstring$(EXESUF): tests/check-qstring.o $(test-util-obj-y)
>  tests/check-qdict$(EXESUF): tests/check-qdict.o $(test-util-obj-y)
>  tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)

Same order as in test-obj-y, please.
