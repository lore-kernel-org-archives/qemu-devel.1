Received: from eggs.gnu.org ([2001:4830:134:3::10]:58608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzW-0001yB-4X
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzU-0002Sk-AP
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgzU-0002ST-1p
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:24 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:41 +0400
Message-Id: <20170311132256.22951-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/21] json: learn to parse uint64 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

If the parsed number doesn't fit in a int64, try with a uint64 before
falling back to double.

Switch strtoll() usage to qemu_strtoi64() helper while at it.

Add a few tests for large numbers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/json-lexer.c  |  4 ++++
 qobject/json-parser.c | 19 +++++++++++++++++--
 qobject/qjson.c       |  8 ++++++++
 tests/check-qjson.c   | 28 ++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)

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
index c18e48ab94..b39cb4d8d6 100644
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
         return QOBJECT(qint_from_int(va_arg(*ap, long long)));
+    } else if (!strcmp(token->str, "%u")) {
+        return QOBJECT(quint_from_uint(va_arg(*ap, unsigned int)));
+    } else if (!strcmp(token->str, "%lu")) {
+        return QOBJECT(quint_from_uint(va_arg(*ap, unsigned long)));
+    } else if (!strcmp(token->str, "%llu") ||
+               !strcmp(token->str, "%I64u")) {
+        return QOBJECT(quint_from_uint(va_arg(*ap, unsigned long long)))=
;
     } else if (!strcmp(token->str, "%s")) {
         return QOBJECT(qstring_from_str(va_arg(*ap, const char *)));
     } else if (!strcmp(token->str, "%f")) {
@@ -504,14 +512,21 @@ static QObject *parse_literal(JSONParserContext *ct=
xt)
          * strtoll() indicates these instances by setting errno to ERANG=
E
          */
         int64_t value;
+        uint64_t uvalue;
=20
-        errno =3D 0; /* strtoll doesn't set errno on success */
-        value =3D strtoll(token->str, NULL, 10);
+        qemu_strtoi64(token->str, NULL, 10, &value);
         if (errno !=3D ERANGE) {
             return QOBJECT(qint_from_int(value));
         }
+
+        qemu_strtou64(token->str, NULL, 10, &uvalue);
+        if (errno !=3D ERANGE) {
+            return QOBJECT(quint_from_uint(uvalue));
+        }
+
         /* fall through to JSON_FLOAT */
     }
+
     case JSON_FLOAT:
         /* FIXME dependent on locale; a pervasive issue in QEMU */
         /* FIXME our lexer matches RFC 7159 in forbidding Inf or NaN,
diff --git a/qobject/qjson.c b/qobject/qjson.c
index b2f3bfec53..6356cff594 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -140,6 +140,14 @@ static void to_json(const QObject *obj, QString *str=
, int pretty, int indent)
         qstring_append(str, buffer);
         break;
     }
+    case QTYPE_QUINT: {
+        QUInt *val =3D qobject_to_quint(obj);
+        char buffer[1024];
+
+        snprintf(buffer, sizeof(buffer), "%" PRIu64, quint_get_uint(val)=
);
+        qstring_append(str, buffer);
+        break;
+    }
     case QTYPE_QSTRING: {
         QString *val =3D qobject_to_qstring(obj);
         const char *ptr;
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 963dd46f07..fd44cd6207 100644
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
+    QUInt *quint;
+    QFloat *qfloat;
+    QString *str;
+
+    quint =3D qobject_to_quint(qobject_from_json(maxu64, &error_abort));
+    g_assert(quint);
+    g_assert_cmpint(quint_get_uint(quint), =3D=3D, 18446744073709551615U=
);
+
+    str =3D qobject_to_json(QOBJECT(quint));
+    g_assert_cmpstr(qstring_get_str(str), =3D=3D, maxu64);
+    QDECREF(str);
+    QDECREF(quint);
+
+    qfloat =3D qobject_to_qfloat(qobject_from_json(gtu64, &error_abort))=
;
+    g_assert(qfloat);
+    g_assert_cmpfloat(qfloat_get_double(qfloat), =3D=3D, 184467440737095=
51616.0);
+
+    str =3D qobject_to_json(QOBJECT(qfloat));
+    g_assert_cmpstr(qstring_get_str(str), =3D=3D, gtu64);
+    QDECREF(str);
+    QDECREF(qfloat);
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
--=20
2.12.0.191.gc5d8de91d
