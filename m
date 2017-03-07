Received: from eggs.gnu.org ([2001:4830:134:3::10]:44514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9QN-0001Yv-PI
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9QK-0006AR-Cs
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cl9QJ-00069V-Us
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:44 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C9A93B71B
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 07:20:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v277KfYL016302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 02:20:43 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  7 Mar 2017 08:20:25 +0100
Message-Id: <1488871237-12332-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1488871237-12332-1-git-send-email-armbru@redhat.com>
References: <1488871237-12332-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 12/24] qobject: Propagate parse errors
 through qobject_from_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The next few commits will put the errors to use where appropriate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488317230-26248-13-git-send-email-armbru@redhat.com>
---
 block.c                            |  2 +-
 include/qapi/qmp/qjson.h           |  2 +-
 monitor.c                          |  2 +-
 qobject/qjson.c                    |  4 +--
 tests/check-qjson.c                | 62 +++++++++++++++++++-------------------
 tests/test-visitor-serialization.c |  2 +-
 6 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/block.c b/block.c
index f293ccb..5ef5c7c 100644
--- a/block.c
+++ b/block.c
@@ -1262,7 +1262,7 @@ static QDict *parse_json_filename(const char *filename, Error **errp)
     ret = strstart(filename, "json:", &filename);
     assert(ret);
 
-    options_obj = qobject_from_json(filename);
+    options_obj = qobject_from_json(filename, NULL);
     if (!options_obj) {
         error_setg(errp, "Could not parse the JSON options");
         return NULL;
diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
index 6fe42d0..6e84082 100644
--- a/include/qapi/qmp/qjson.h
+++ b/include/qapi/qmp/qjson.h
@@ -17,7 +17,7 @@
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qstring.h"
 
-QObject *qobject_from_json(const char *string);
+QObject *qobject_from_json(const char *string, Error **errp);
 QObject *qobject_from_jsonf(const char *string, ...) GCC_FMT_ATTR(1, 2);
 QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
     GCC_FMT_ATTR(1, 0);
diff --git a/monitor.c b/monitor.c
index ec7623e..ae6c4d3 100644
--- a/monitor.c
+++ b/monitor.c
@@ -953,7 +953,7 @@ EventInfoList *qmp_query_events(Error **errp)
 static void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
                                  Error **errp)
 {
-    *ret_data = qobject_from_json(qmp_schema_json);
+    *ret_data = qobject_from_json(qmp_schema_json, NULL);
 }
 
 /*
diff --git a/qobject/qjson.c b/qobject/qjson.c
index c98d6a7..b2f3bfe 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -50,9 +50,9 @@ QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
     return state.result;
 }
 
-QObject *qobject_from_json(const char *string)
+QObject *qobject_from_json(const char *string, Error **errp)
 {
-    return qobject_from_jsonv(string, NULL, NULL);
+    return qobject_from_jsonv(string, NULL, errp);
 }
 
 /*
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index e6d6935..aa63758 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -53,7 +53,7 @@ static void escaped_string(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded);
+        obj = qobject_from_json(test_cases[i].encoded, NULL);
         str = qobject_to_qstring(obj);
         g_assert(str);
         g_assert_cmpstr(qstring_get_str(str), ==, test_cases[i].decoded);
@@ -85,7 +85,7 @@ static void simple_string(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded);
+        obj = qobject_from_json(test_cases[i].encoded, NULL);
         str = qobject_to_qstring(obj);
         g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
@@ -116,7 +116,7 @@ static void single_quote_string(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded);
+        obj = qobject_from_json(test_cases[i].encoded, NULL);
         str = qobject_to_qstring(obj);
         g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
@@ -809,7 +809,7 @@ static void utf8_string(void)
         utf8_in = test_cases[i].utf8_in ?: test_cases[i].utf8_out;
         json_out = test_cases[i].json_out ?: test_cases[i].json_in;
 
-        obj = qobject_from_json(json_in);
+        obj = qobject_from_json(json_in, NULL);
         if (utf8_out) {
             str = qobject_to_qstring(obj);
             g_assert(str);
@@ -836,7 +836,7 @@ static void utf8_string(void)
          * FIXME Enable once these bugs have been fixed.
          */
         if (0 && json_out != json_in) {
-            obj = qobject_from_json(json_out);
+            obj = qobject_from_json(json_out, NULL);
             str = qobject_to_qstring(obj);
             g_assert(str);
             g_assert_cmpstr(qstring_get_str(str), ==, utf8_out);
@@ -886,7 +886,7 @@ static void simple_number(void)
     for (i = 0; test_cases[i].encoded; i++) {
         QInt *qint;
 
-        qint = qobject_to_qint(qobject_from_json(test_cases[i].encoded));
+        qint = qobject_to_qint(qobject_from_json(test_cases[i].encoded, NULL));
         g_assert(qint);
         g_assert(qint_get_int(qint) == test_cases[i].decoded);
         if (test_cases[i].skip == 0) {
@@ -920,7 +920,7 @@ static void float_number(void)
         QObject *obj;
         QFloat *qfloat;
 
-        obj = qobject_from_json(test_cases[i].encoded);
+        obj = qobject_from_json(test_cases[i].encoded, NULL);
         qfloat = qobject_to_qfloat(obj);
         g_assert(qfloat);
         g_assert(qfloat_get_double(qfloat) == test_cases[i].decoded);
@@ -965,7 +965,7 @@ static void keyword_literal(void)
     QObject *null;
     QString *str;
 
-    obj = qobject_from_json("true");
+    obj = qobject_from_json("true", NULL);
     qbool = qobject_to_qbool(obj);
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);
@@ -976,7 +976,7 @@ static void keyword_literal(void)
 
     QDECREF(qbool);
 
-    obj = qobject_from_json("false");
+    obj = qobject_from_json("false", NULL);
     qbool = qobject_to_qbool(obj);
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == false);
@@ -998,7 +998,7 @@ static void keyword_literal(void)
     g_assert(qbool_get_bool(qbool) == true);
     QDECREF(qbool);
 
-    obj = qobject_from_json("null");
+    obj = qobject_from_json("null", NULL);
     g_assert(obj != NULL);
     g_assert(qobject_type(obj) == QTYPE_QNULL);
 
@@ -1134,13 +1134,13 @@ static void simple_dict(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded);
+        obj = qobject_from_json(test_cases[i].encoded, NULL);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         str = qobject_to_json(obj);
         qobject_decref(obj);
 
-        obj = qobject_from_json(qstring_get_str(str));
+        obj = qobject_from_json(qstring_get_str(str), NULL);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
         qobject_decref(obj);
         QDECREF(str);
@@ -1192,7 +1192,7 @@ static void large_dict(void)
     QObject *obj;
 
     gen_test_json(gstr, 10, 100);
-    obj = qobject_from_json(gstr->str);
+    obj = qobject_from_json(gstr->str, NULL);
     g_assert(obj != NULL);
 
     qobject_decref(obj);
@@ -1243,13 +1243,13 @@ static void simple_list(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded);
+        obj = qobject_from_json(test_cases[i].encoded, NULL);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         str = qobject_to_json(obj);
         qobject_decref(obj);
 
-        obj = qobject_from_json(qstring_get_str(str));
+        obj = qobject_from_json(qstring_get_str(str), NULL);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
         qobject_decref(obj);
         QDECREF(str);
@@ -1305,13 +1305,13 @@ static void simple_whitespace(void)
         QObject *obj;
         QString *str;
 
-        obj = qobject_from_json(test_cases[i].encoded);
+        obj = qobject_from_json(test_cases[i].encoded, NULL);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         str = qobject_to_json(obj);
         qobject_decref(obj);
 
-        obj = qobject_from_json(qstring_get_str(str));
+        obj = qobject_from_json(qstring_get_str(str), NULL);
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         qobject_decref(obj);
@@ -1332,7 +1332,7 @@ static void simple_varargs(void)
                         {}})),
             {}}));
 
-    embedded_obj = qobject_from_json("[32, 42]");
+    embedded_obj = qobject_from_json("[32, 42]", NULL);
     g_assert(embedded_obj != NULL);
 
     obj = qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
@@ -1345,67 +1345,67 @@ static void empty_input(void)
 {
     const char *empty = "";
 
-    QObject *obj = qobject_from_json(empty);
+    QObject *obj = qobject_from_json(empty, NULL);
     g_assert(obj == NULL);
 }
 
 static void unterminated_string(void)
 {
-    QObject *obj = qobject_from_json("\"abc");
+    QObject *obj = qobject_from_json("\"abc", NULL);
     g_assert(obj == NULL);
 }
 
 static void unterminated_sq_string(void)
 {
-    QObject *obj = qobject_from_json("'abc");
+    QObject *obj = qobject_from_json("'abc", NULL);
     g_assert(obj == NULL);
 }
 
 static void unterminated_escape(void)
 {
-    QObject *obj = qobject_from_json("\"abc\\\"");
+    QObject *obj = qobject_from_json("\"abc\\\"", NULL);
     g_assert(obj == NULL);
 }
 
 static void unterminated_array(void)
 {
-    QObject *obj = qobject_from_json("[32");
+    QObject *obj = qobject_from_json("[32", NULL);
     g_assert(obj == NULL);
 }
 
 static void unterminated_array_comma(void)
 {
-    QObject *obj = qobject_from_json("[32,");
+    QObject *obj = qobject_from_json("[32,", NULL);
     g_assert(obj == NULL);
 }
 
 static void invalid_array_comma(void)
 {
-    QObject *obj = qobject_from_json("[32,}");
+    QObject *obj = qobject_from_json("[32,}", NULL);
     g_assert(obj == NULL);
 }
 
 static void unterminated_dict(void)
 {
-    QObject *obj = qobject_from_json("{'abc':32");
+    QObject *obj = qobject_from_json("{'abc':32", NULL);
     g_assert(obj == NULL);
 }
 
 static void unterminated_dict_comma(void)
 {
-    QObject *obj = qobject_from_json("{'abc':32,");
+    QObject *obj = qobject_from_json("{'abc':32,", NULL);
     g_assert(obj == NULL);
 }
 
 static void invalid_dict_comma(void)
 {
-    QObject *obj = qobject_from_json("{'abc':32,}");
+    QObject *obj = qobject_from_json("{'abc':32,}", NULL);
     g_assert(obj == NULL);
 }
 
 static void unterminated_literal(void)
 {
-    QObject *obj = qobject_from_json("nul");
+    QObject *obj = qobject_from_json("nul", NULL);
     g_assert(obj == NULL);
 }
 
@@ -1425,11 +1425,11 @@ static void limits_nesting(void)
     char buf[2 * (max_nesting + 1) + 1];
     QObject *obj;
 
-    obj = qobject_from_json(make_nest(buf, max_nesting));
+    obj = qobject_from_json(make_nest(buf, max_nesting), NULL);
     g_assert(obj != NULL);
     qobject_decref(obj);
 
-    obj = qobject_from_json(make_nest(buf, max_nesting + 1));
+    obj = qobject_from_json(make_nest(buf, max_nesting + 1), NULL);
     g_assert(obj == NULL);
 }
 
diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-serialization.c
index c7e64f0..37dff41 100644
--- a/tests/test-visitor-serialization.c
+++ b/tests/test-visitor-serialization.c
@@ -1037,7 +1037,7 @@ static void qmp_deserialize(void **native_out, void *datap,
     visit_complete(d->qov, &d->obj);
     obj_orig = d->obj;
     output_json = qobject_to_json(obj_orig);
-    obj = qobject_from_json(qstring_get_str(output_json));
+    obj = qobject_from_json(qstring_get_str(output_json), NULL);
 
     QDECREF(output_json);
     d->qiv = qobject_input_visitor_new(obj);
-- 
2.7.4
