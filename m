Received: from eggs.gnu.org ([2001:4830:134:3::10]:52267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG49M-000452-UU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG49L-00049A-PK
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG49L-00048p-Gu
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 787127F6A4
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:58:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:37 +0400
Message-Id: <20170531135709.345-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/45] json: learn to parse uint64 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Switch strtoll() usage to qemu_strtoi64() helper while at it.

Add a few tests for large numbers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/json-lexer.c  |  4 ++++
 qobject/json-parser.c | 30 ++++++++++++++++++++++++------
 tests/check-qjson.c   | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index af4a75e05b..980ba159d6 100644
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
         ['l'] =3D IN_ESCAPE_LL,
+        ['u'] =3D JSON_ESCAPE,
     },
=20
     [IN_ESCAPE_I64] =3D {
         ['d'] =3D JSON_ESCAPE,
+        ['u'] =3D JSON_ESCAPE,
     },
=20
     [IN_ESCAPE_I6] =3D {
@@ -251,6 +254,7 @@ static const uint8_t json_lexer[][256] =3D  {
         ['i'] =3D JSON_ESCAPE,
         ['p'] =3D JSON_ESCAPE,
         ['s'] =3D JSON_ESCAPE,
+        ['u'] =3D JSON_ESCAPE,
         ['f'] =3D JSON_ESCAPE,
         ['l'] =3D IN_ESCAPE_L,
         ['I'] =3D IN_ESCAPE_I,
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index b90b2fb45a..62dcac8128 100644
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
@@ -493,20 +501,30 @@ static QObject *parse_literal(JSONParserContext *ct=
xt)
     case JSON_INTEGER: {
         /*
          * Represent JSON_INTEGER as QNUM_I64 if possible, else as
-         * QNUM_DOUBLE. Note that strtoll() fails with ERANGE when
-         * it's not possible.
+         * QNUM_U64, else as QNUM_DOUBLE.  Note that qemu_strtoi64()
+         * and qemu_strtou64 fail with ERANGE when it's not possible.
          *
          * qnum_get_int() will then work for any signed 64-bit
-         * JSON_INTEGER, and qnum_get_double both for any JSON_INTEGER
+         * JSON_INTEGER, qnum_get_uint() for any unsigned 64-bit
+         * integer, and qnum_get_double() both for any JSON_INTEGER
          * and any JSON_FLOAT.
          */
+        int ret;
         int64_t value;
+        uint64_t uvalue;
=20
-        errno =3D 0; /* strtoll doesn't set errno on success */
-        value =3D strtoll(token->str, NULL, 10);
-        if (errno !=3D ERANGE) {
+        ret =3D qemu_strtoi64(token->str, NULL, 10, &value);
+        if (!ret) {
             return QOBJECT(qnum_from_int(value));
         }
+        assert(ret =3D=3D -ERANGE);
+
+        if (token->str[0] !=3D '-') {
+            ret =3D qemu_strtou64(token->str, NULL, 10, &uvalue);
+            if (!ret) {
+                return QOBJECT(qnum_from_uint(uvalue));
+            }
+        }
         /* fall through to JSON_FLOAT */
     }
     case JSON_FLOAT:
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 8ec728a702..6fb14445a3 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -906,6 +906,42 @@ static void simple_number(void)
     }
 }
=20
+static void large_number(void)
+{
+    const char *maxu64 =3D "18446744073709551615"; /* 2^64-1 */
+    const char *gtu64 =3D "18446744073709551616"; /* 2^64 */
+    const char *range =3D "-9223372036854775809";
+    QNum *qnum;
+    QString *str;
+    uint64_t val;
+
+    qnum =3D qobject_to_qnum(qobject_from_json(maxu64, &error_abort));
+    g_assert(qnum);
+    g_assert(qnum_get_uint(qnum, &val));
+    g_assert_cmpuint(val, =3D=3D, 18446744073709551615U);
+
+    str =3D qobject_to_json(QOBJECT(qnum));
+    g_assert_cmpstr(qstring_get_str(str), =3D=3D, maxu64);
+    QDECREF(str);
+    QDECREF(qnum);
+
+    qnum =3D qobject_to_qnum(qobject_from_json(gtu64, &error_abort));
+    g_assert(qnum);
+    g_assert_cmpfloat(qnum_get_double(qnum), >, 0);
+    g_assert(!qnum_get_uint(qnum, &val));
+
+    str =3D qobject_to_json(QOBJECT(qnum));
+    g_assert_cmpstr(qstring_get_str(str), =3D=3D, gtu64);
+    QDECREF(str);
+    QDECREF(qnum);
+
+    qnum =3D qobject_to_qnum(qobject_from_json(range, &error_abort));
+    g_assert(qnum);
+    g_assert_cmpfloat(qnum_get_double(qnum), <, 0);
+    g_assert(!qnum_get_uint(qnum, &val));
+    QDECREF(qnum);
+}
+
 static void float_number(void)
 {
     int i;
@@ -1475,6 +1511,7 @@ int main(int argc, char **argv)
     g_test_add_func("/literals/string/vararg", vararg_string);
=20
     g_test_add_func("/literals/number/simple", simple_number);
+    g_test_add_func("/literals/number/large", large_number);
     g_test_add_func("/literals/number/float", float_number);
     g_test_add_func("/literals/number/vararg", vararg_number);
=20
--=20
2.13.0.91.g00982b8dd
