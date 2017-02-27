Received: from eggs.gnu.org ([2001:4830:134:3::10]:44661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMW-00067i-NX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMU-00012F-8m
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:04 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:40 +0100
Message-Id: <1488194450-28056-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 14/24] check-qjson: Test errors from
 qobject_from_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

Pass &error_abort with known-good input.  Else pass &err and check
what comes back.  This demonstrates that the parser fails silently for
many errors.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 88 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index aa63758..963dd46 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -10,8 +10,10 @@
  * See the COPYING.LIB file in the top-level directory.
  *
  */
+
 #include "qemu/osdep.h"
 
+#include "qapi/error.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu-common.h"
@@ -53,7 +55,7 @@ static void escaped_string(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded, NULL);
+        obj = qobject_from_json(test_cases[i].encoded, &error_abort);
         str = qobject_to_qstring(obj);
         g_assert(str);
         g_assert_cmpstr(qstring_get_str(str), ==, test_cases[i].decoded);
@@ -85,7 +87,7 @@ static void simple_string(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded, NULL);
+        obj = qobject_from_json(test_cases[i].encoded, &error_abort);
         str = qobject_to_qstring(obj);
         g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
@@ -116,7 +118,7 @@ static void single_quote_string(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded, NULL);
+        obj = qobject_from_json(test_cases[i].encoded, &error_abort);
         str = qobject_to_qstring(obj);
         g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
@@ -809,7 +811,7 @@ static void utf8_string(void)
         utf8_in = test_cases[i].utf8_in ?: test_cases[i].utf8_out;
         json_out = test_cases[i].json_out ?: test_cases[i].json_in;
 
-        obj = qobject_from_json(json_in, NULL);
+        obj = qobject_from_json(json_in, utf8_out ? &error_abort : NULL);
         if (utf8_out) {
             str = qobject_to_qstring(obj);
             g_assert(str);
@@ -836,7 +838,7 @@ static void utf8_string(void)
          * FIXME Enable once these bugs have been fixed.
          */
         if (0 && json_out != json_in) {
-            obj = qobject_from_json(json_out, NULL);
+            obj = qobject_from_json(json_out, &error_abort);
             str = qobject_to_qstring(obj);
             g_assert(str);
             g_assert_cmpstr(qstring_get_str(str), ==, utf8_out);
@@ -886,7 +888,8 @@ static void simple_number(void)
     for (i = 0; test_cases[i].encoded; i++) {
         QInt *qint;
 
-        qint = qobject_to_qint(qobject_from_json(test_cases[i].encoded, NULL));
+        qint = qobject_to_qint(qobject_from_json(test_cases[i].encoded,
+                                                 &error_abort));
         g_assert(qint);
         g_assert(qint_get_int(qint) == test_cases[i].decoded);
         if (test_cases[i].skip == 0) {
@@ -920,7 +923,7 @@ static void float_number(void)
         QObject *obj;
         QFloat *qfloat;
 
-        obj = qobject_from_json(test_cases[i].encoded, NULL);
+        obj = qobject_from_json(test_cases[i].encoded, &error_abort);
         qfloat = qobject_to_qfloat(obj);
         g_assert(qfloat);
         g_assert(qfloat_get_double(qfloat) == test_cases[i].decoded);
@@ -965,7 +968,7 @@ static void keyword_literal(void)
     QObject *null;
     QString *str;
 
-    obj = qobject_from_json("true", NULL);
+    obj = qobject_from_json("true", &error_abort);
     qbool = qobject_to_qbool(obj);
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);
@@ -976,7 +979,7 @@ static void keyword_literal(void)
 
     QDECREF(qbool);
 
-    obj = qobject_from_json("false", NULL);
+    obj = qobject_from_json("false", &error_abort);
     qbool = qobject_to_qbool(obj);
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == false);
@@ -998,7 +1001,7 @@ static void keyword_literal(void)
     g_assert(qbool_get_bool(qbool) == true);
     QDECREF(qbool);
 
-    obj = qobject_from_json("null", NULL);
+    obj = qobject_from_json("null", &error_abort);
     g_assert(obj != NULL);
     g_assert(qobject_type(obj) == QTYPE_QNULL);
 
@@ -1134,13 +1137,13 @@ static void simple_dict(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded, NULL);
+        obj = qobject_from_json(test_cases[i].encoded, &error_abort);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         str = qobject_to_json(obj);
         qobject_decref(obj);
 
-        obj = qobject_from_json(qstring_get_str(str), NULL);
+        obj = qobject_from_json(qstring_get_str(str), &error_abort);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
         qobject_decref(obj);
         QDECREF(str);
@@ -1192,7 +1195,7 @@ static void large_dict(void)
     QObject *obj;
 
     gen_test_json(gstr, 10, 100);
-    obj = qobject_from_json(gstr->str, NULL);
+    obj = qobject_from_json(gstr->str, &error_abort);
     g_assert(obj != NULL);
 
     qobject_decref(obj);
@@ -1243,13 +1246,13 @@ static void simple_list(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded, NULL);
+        obj = qobject_from_json(test_cases[i].encoded, &error_abort);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         str = qobject_to_json(obj);
         qobject_decref(obj);
 
-        obj = qobject_from_json(qstring_get_str(str), NULL);
+        obj = qobject_from_json(qstring_get_str(str), &error_abort);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
         qobject_decref(obj);
         QDECREF(str);
@@ -1305,13 +1308,13 @@ static void simple_whitespace(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded, NULL);
+        obj = qobject_from_json(test_cases[i].encoded, &error_abort);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         str = qobject_to_json(obj);
         qobject_decref(obj);
 
-        obj = qobject_from_json(qstring_get_str(str), NULL);
+        obj = qobject_from_json(qstring_get_str(str), &error_abort);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         qobject_decref(obj);
@@ -1332,7 +1335,7 @@ static void simple_varargs(void)
                         {}})),
             {}}));
 
-    embedded_obj = qobject_from_json("[32, 42]", NULL);
+    embedded_obj = qobject_from_json("[32, 42]", &error_abort);
     g_assert(embedded_obj != NULL);
 
     obj = qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
@@ -1344,68 +1347,87 @@ static void simple_varargs(void)
 static void empty_input(void)
 {
     const char *empty = "";
-
-    QObject *obj = qobject_from_json(empty, NULL);
+    QObject *obj = qobject_from_json(empty, &error_abort);
     g_assert(obj == NULL);
 }
 
 static void unterminated_string(void)
 {
-    QObject *obj = qobject_from_json("\"abc", NULL);
+    Error *err = NULL;
+    QObject *obj = qobject_from_json("\"abc", &err);
+    g_assert(!err);             /* BUG */
     g_assert(obj == NULL);
 }
 
 static void unterminated_sq_string(void)
 {
-    QObject *obj = qobject_from_json("'abc", NULL);
+    Error *err = NULL;
+    QObject *obj = qobject_from_json("'abc", &err);
+    g_assert(!err);             /* BUG */
     g_assert(obj == NULL);
 }
 
 static void unterminated_escape(void)
 {
-    QObject *obj = qobject_from_json("\"abc\\\"", NULL);
+    Error *err = NULL;
+    QObject *obj = qobject_from_json("\"abc\\\"", &err);
+    g_assert(!err);             /* BUG */
     g_assert(obj == NULL);
 }
 
 static void unterminated_array(void)
 {
-    QObject *obj = qobject_from_json("[32", NULL);
+    Error *err = NULL;
+    QObject *obj = qobject_from_json("[32", &err);
+    g_assert(!err);             /* BUG */
     g_assert(obj == NULL);
 }
 
 static void unterminated_array_comma(void)
 {
-    QObject *obj = qobject_from_json("[32,", NULL);
+    Error *err = NULL;
+    QObject *obj = qobject_from_json("[32,", &err);
+    g_assert(!err);             /* BUG */
     g_assert(obj == NULL);
 }
 
 static void invalid_array_comma(void)
 {
-    QObject *obj = qobject_from_json("[32,}", NULL);
+    Error *err = NULL;
+    QObject *obj = qobject_from_json("[32,}", &err);
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
 static void unterminated_dict(void)
 {
-    QObject *obj = qobject_from_json("{'abc':32", NULL);
+    Error *err = NULL;
+    QObject *obj = qobject_from_json("{'abc':32", &err);
+    g_assert(!err);             /* BUG */
     g_assert(obj == NULL);
 }
 
 static void unterminated_dict_comma(void)
 {
-    QObject *obj = qobject_from_json("{'abc':32,", NULL);
+    Error *err = NULL;
+    QObject *obj = qobject_from_json("{'abc':32,", &err);
+    g_assert(!err);             /* BUG */
     g_assert(obj == NULL);
 }
 
 static void invalid_dict_comma(void)
 {
-    QObject *obj = qobject_from_json("{'abc':32,}", NULL);
+    Error *err = NULL;
+    QObject *obj = qobject_from_json("{'abc':32,}", &err);
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
 static void unterminated_literal(void)
 {
-    QObject *obj = qobject_from_json("nul", NULL);
+    Error *err = NULL;
+    QObject *obj = qobject_from_json("nul", &err);
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
@@ -1421,15 +1443,17 @@ static char *make_nest(char *buf, size_t cnt)
 
 static void limits_nesting(void)
 {
+    Error *err = NULL;
     enum { max_nesting = 1024 }; /* see qobject/json-streamer.c */
     char buf[2 * (max_nesting + 1) + 1];
     QObject *obj;
 
-    obj = qobject_from_json(make_nest(buf, max_nesting), NULL);
+    obj = qobject_from_json(make_nest(buf, max_nesting), &error_abort);
     g_assert(obj != NULL);
     qobject_decref(obj);
 
-    obj = qobject_from_json(make_nest(buf, max_nesting + 1), NULL);
+    obj = qobject_from_json(make_nest(buf, max_nesting + 1), &err);
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
-- 
2.7.4
