Received: from eggs.gnu.org ([2001:4830:134:3::10]:45571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d895e-0007Fg-26
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d895Z-0004Jm-4C
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:38:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d895Y-0004JR-SI
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:38:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B57E77F7DD
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:38:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:49 +0300
Message-Id: <20170509173559.31598-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/17] json: learn to parse uint64 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Switch strtoll() usage to qemu_strtoi64() helper while at it.

Replace temporarily the error in qnum_get_int() with values >INT64_MAX
until the visitor is updated.

Add a few tests for large numbers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/json-lexer.c               |  4 ++++
 qobject/json-parser.c              | 30 ++++++++++++++++++++++--------
 qobject/qnum.c                     |  4 ++--
 tests/check-qjson.c                | 28 ++++++++++++++++++++++++++++
 tests/check-qnum.c                 |  9 +++++----
 tests/test-qobject-input-visitor.c |  7 ++-----
 6 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index af4a75e05b..a0beb0b106 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -227,15 +227,18 @@ static const uint8_t json_lexer[][256] =3D  {
     /* escape */
     [IN_ESCAPE_LL] =3D {
         ['d'] =3D JSON_ESCAPE,
+        ['u'] =3D JSON_ESCAPE,
     },
=20
     [IN_ESCAPE_L] =3D {
         ['d'] =3D JSON_ESCAPE,
+        ['u'] =3D JSON_ESCAPE,
         ['l'] =3D IN_ESCAPE_LL,
     },
=20
     [IN_ESCAPE_I64] =3D {
         ['d'] =3D JSON_ESCAPE,
+        ['u'] =3D JSON_ESCAPE,
     },
=20
     [IN_ESCAPE_I6] =3D {
@@ -247,6 +250,7 @@ static const uint8_t json_lexer[][256] =3D  {
     },
=20
     [IN_ESCAPE] =3D {
+        ['u'] =3D JSON_ESCAPE,
         ['d'] =3D JSON_ESCAPE,
         ['i'] =3D JSON_ESCAPE,
         ['p'] =3D JSON_ESCAPE,
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index f431854ba1..fa15c762d3 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qapi/qmp/types.h"
@@ -472,6 +473,13 @@ static QObject *parse_escape(JSONParserContext *ctxt=
, va_list *ap)
     } else if (!strcmp(token->str, "%lld") ||
                !strcmp(token->str, "%I64d")) {
         return QOBJECT(qnum_from_int(va_arg(*ap, long long)));
+    } else if (!strcmp(token->str, "%u")) {
+        return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned int)));
+    } else if (!strcmp(token->str, "%lu")) {
+        return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned long)));
+    } else if (!strcmp(token->str, "%llu") ||
+               !strcmp(token->str, "%I64u")) {
+        return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned long long)));
     } else if (!strcmp(token->str, "%s")) {
         return QOBJECT(qstring_from_str(va_arg(*ap, const char *)));
     } else if (!strcmp(token->str, "%f")) {
@@ -494,22 +502,28 @@ static QObject *parse_literal(JSONParserContext *ct=
xt)
         /* A possibility exists that this is a whole-valued float where =
the
          * fractional part was left out due to being 0 (.0). It's not a =
big
          * deal to treat these as ints in the parser, so long as users o=
f the
-         * resulting QObject know to expect a QNum in place of a QNum in
-         * cases like these.
+         * resulting QObject know to expect a QNum that will handle
+         * implicit conversions to the expected type.
          *
-         * However, in some cases these values will overflow/underflow a
-         * QNum/int64 container, thus we should assume these are to be h=
andled
-         * as QNums/doubles rather than silently changing their values.
+         * However, in some cases these values will overflow/underflow
+         * a QNum/int64 container, thus we should assume these are to
+         * be handled as QNum/uint64 or QNums/doubles rather than
+         * silently changing their values.
          *
-         * strtoll() indicates these instances by setting errno to ERANG=
E
+         * qemu_strto*() indicates these instances by setting errno to E=
RANGE
          */
         int64_t value;
+        uint64_t uvalue;
=20
-        errno =3D 0; /* strtoll doesn't set errno on success */
-        value =3D strtoll(token->str, NULL, 10);
+        qemu_strtoi64(token->str, NULL, 10, &value);
         if (errno !=3D ERANGE) {
             return QOBJECT(qnum_from_int(value));
         }
+
+        qemu_strtou64(token->str, NULL, 10, &uvalue);
+        if (errno !=3D ERANGE) {
+            return QOBJECT(qnum_from_uint(uvalue));
+        }
         /* fall through to JSON_FLOAT */
     }
     case JSON_FLOAT:
diff --git a/qobject/qnum.c b/qobject/qnum.c
index be6307accf..2f87952db8 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -76,8 +76,8 @@ int64_t qnum_get_int(const QNum *qn, Error **errp)
         return qn->u.i64;
     case QNUM_U64:
         if (qn->u.u64 > INT64_MAX) {
-            error_setg(errp, "The number is too large, use qnum_get_uint=
()");
-            return 0;
+            /* temporarily accepts to cast to i64 until visitor is switc=
hed */
+            error_report("The number is too large, use qnum_get_uint()")=
;
         }
         return qn->u.u64;
     case QNUM_DOUBLE:
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index c432aebf13..57c2366dc3 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -904,6 +904,33 @@ static void simple_number(void)
     }
 }
=20
+static void large_number(void)
+{
+    const char *maxu64 =3D "18446744073709551615"; /* 2^64-1 */
+    const char *gtu64 =3D "18446744073709551616"; /* 2^64 */
+    QNum *qnum;
+    QString *str;
+
+    qnum =3D qobject_to_qnum(qobject_from_json(maxu64, &error_abort));
+    g_assert(qnum);
+    g_assert_cmpuint(qnum_get_uint(qnum, &error_abort),
+                     =3D=3D, 18446744073709551615U);
+
+    str =3D qobject_to_json(QOBJECT(qnum));
+    g_assert_cmpstr(qstring_get_str(str), =3D=3D, maxu64);
+    QDECREF(str);
+    QDECREF(qnum);
+
+    qnum =3D qobject_to_qnum(qobject_from_json(gtu64, &error_abort));
+    g_assert(qnum);
+    g_assert_cmpfloat(qnum_get_double(qnum), =3D=3D, 1844674407370955161=
6.0);
+
+    str =3D qobject_to_json(QOBJECT(qnum));
+    g_assert_cmpstr(qstring_get_str(str), =3D=3D, gtu64);
+    QDECREF(str);
+    QDECREF(qnum);
+}
+
 static void float_number(void)
 {
     int i;
@@ -1468,6 +1495,7 @@ int main(int argc, char **argv)
     g_test_add_func("/literals/string/vararg", vararg_string);
=20
     g_test_add_func("/literals/number/simple", simple_number);
+    g_test_add_func("/literals/number/large", large_number);
     g_test_add_func("/literals/number/float", float_number);
     g_test_add_func("/literals/number/vararg", vararg_number);
=20
diff --git a/tests/check-qnum.c b/tests/check-qnum.c
index 8199546f99..9a22af3d0e 100644
--- a/tests/check-qnum.c
+++ b/tests/check-qnum.c
@@ -107,10 +107,11 @@ static void qnum_get_uint_test(void)
     error_free_or_abort(&err);
     QDECREF(qn);
=20
-    qn =3D qnum_from_uint(-1ULL);
-    qnum_get_int(qn, &err);
-    error_free_or_abort(&err);
-    QDECREF(qn);
+    /* temporarily disabled until visitor is switched */
+    /* qn =3D qnum_from_uint(-1ULL); */
+    /* qnum_get_int(qn, &err); */
+    /* error_free_or_abort(&err); */
+    /* QDECREF(qn); */
=20
     /* invalid case */
     qn =3D qnum_from_double(0.42);
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 5df62c4f9e..276a6b4427 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -119,7 +119,6 @@ static void test_visitor_in_int(TestInputVisitorData =
*data,
 static void test_visitor_in_uint(TestInputVisitorData *data,
                                 const void *unused)
 {
-    Error *err =3D NULL;
     uint64_t res =3D 0;
     int value =3D 42;
     Visitor *v;
@@ -136,12 +135,10 @@ static void test_visitor_in_uint(TestInputVisitorDa=
ta *data,
     visit_type_uint64(v, NULL, &res, &error_abort);
     g_assert_cmpuint(res, =3D=3D, (uint64_t)-value);
=20
-    /* BUG: value between INT64_MAX+1 and UINT64_MAX rejected */
-
     v =3D visitor_input_test_init(data, "18446744073709551574");
=20
-    visit_type_uint64(v, NULL, &res, &err);
-    error_free_or_abort(&err);
+    visit_type_uint64(v, NULL, &res, &error_abort);
+    g_assert_cmpuint(res, =3D=3D, 18446744073709551574U);
 }
=20
 static void test_visitor_in_int_overflow(TestInputVisitorData *data,
--=20
2.13.0.rc1.16.gd80b50c3f
