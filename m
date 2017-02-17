Received: from eggs.gnu.org ([2001:4830:134:3::10]:59090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIX-0002aq-3q
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIT-0004Qk-Ut
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIT-0004Ph-MR
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:29 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0E8BC04B924
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcSW0005388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:29 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:20 +0100
Message-Id: <1487363905-9480-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 09/14] tests: Don't check qobject_type() before
 qobject_to_qstring()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qobject_to_qstring(obj) returns NULL when obj isn't a QString.  Check
that instead of qobject_type(obj) == QTYPE_QSTRING.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c                 | 31 ++++++++-----------------------
 tests/test-qobject-output-visitor.c | 37 +++++++++++++++++--------------------
 2 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 49e02591..dd080a8 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -54,11 +54,8 @@ static void escaped_string(void)
         QString *str;
 
         obj = qobject_from_json(test_cases[i].encoded);
-
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QSTRING);
-        
         str = qobject_to_qstring(obj);
+        g_assert(str);
         g_assert_cmpstr(qstring_get_str(str), ==, test_cases[i].decoded);
 
         if (test_cases[i].skip == 0) {
@@ -89,11 +86,8 @@ static void simple_string(void)
         QString *str;
 
         obj = qobject_from_json(test_cases[i].encoded);
-
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QSTRING);
-        
         str = qobject_to_qstring(obj);
+        g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
 
         str = qobject_to_json(obj);
@@ -123,11 +117,8 @@ static void single_quote_string(void)
         QString *str;
 
         obj = qobject_from_json(test_cases[i].encoded);
-
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QSTRING);
-        
         str = qobject_to_qstring(obj);
+        g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
 
         QDECREF(str);
@@ -820,9 +811,8 @@ static void utf8_string(void)
 
         obj = qobject_from_json(json_in);
         if (utf8_out) {
-            g_assert(obj);
-            g_assert(qobject_type(obj) == QTYPE_QSTRING);
             str = qobject_to_qstring(obj);
+            g_assert(str);
             g_assert_cmpstr(qstring_get_str(str), ==, utf8_out);
         } else {
             g_assert(!obj);
@@ -847,9 +837,8 @@ static void utf8_string(void)
          */
         if (0 && json_out != json_in) {
             obj = qobject_from_json(json_out);
-            g_assert(obj);
-            g_assert(qobject_type(obj) == QTYPE_QSTRING);
             str = qobject_to_qstring(obj);
+            g_assert(str);
             g_assert_cmpstr(qstring_get_str(str), ==, utf8_out);
         }
     }
@@ -867,15 +856,11 @@ static void vararg_string(void)
     };
 
     for (i = 0; test_cases[i].decoded; i++) {
-        QObject *obj;
         QString *str;
 
-        obj = qobject_from_jsonf("%s", test_cases[i].decoded);
-
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QSTRING);
-        
-        str = qobject_to_qstring(obj);
+        str = qobject_to_qstring(qobject_from_jsonf("%s",
+                                                    test_cases[i].decoded));
+        g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
 
         QDECREF(str);
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 13a0a9b..3e34aa5 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -97,42 +97,41 @@ static void test_visitor_out_string(TestOutputVisitorData *data,
                                     const void *unused)
 {
     char *string = (char *) "Q E M U";
-    QObject *obj;
+    QString *qstr;
 
     visit_type_str(data->ov, NULL, &string, &error_abort);
 
-    obj = visitor_get(data);
-    g_assert(qobject_type(obj) == QTYPE_QSTRING);
-    g_assert_cmpstr(qstring_get_str(qobject_to_qstring(obj)), ==, string);
+    qstr = qobject_to_qstring(visitor_get(data));
+    g_assert(qstr);
+    g_assert_cmpstr(qstring_get_str(qstr), ==, string);
 }
 
 static void test_visitor_out_no_string(TestOutputVisitorData *data,
                                        const void *unused)
 {
     char *string = NULL;
-    QObject *obj;
+    QString *qstr;
 
     /* A null string should return "" */
     visit_type_str(data->ov, NULL, &string, &error_abort);
 
-    obj = visitor_get(data);
-    g_assert(qobject_type(obj) == QTYPE_QSTRING);
-    g_assert_cmpstr(qstring_get_str(qobject_to_qstring(obj)), ==, "");
+    qstr = qobject_to_qstring(visitor_get(data));
+    g_assert(qstr);
+    g_assert_cmpstr(qstring_get_str(qstr), ==, "");
 }
 
 static void test_visitor_out_enum(TestOutputVisitorData *data,
                                   const void *unused)
 {
-    QObject *obj;
     EnumOne i;
+    QString *qstr;
 
     for (i = 0; i < ENUM_ONE__MAX; i++) {
         visit_type_EnumOne(data->ov, "unused", &i, &error_abort);
 
-        obj = visitor_get(data);
-        g_assert(qobject_type(obj) == QTYPE_QSTRING);
-        g_assert_cmpstr(qstring_get_str(qobject_to_qstring(obj)), ==,
-                        EnumOne_lookup[i]);
+        qstr = qobject_to_qstring(visitor_get(data));
+        g_assert(qstr);
+        g_assert_cmpstr(qstring_get_str(qstr), ==, EnumOne_lookup[i]);
         visitor_reset(data);
     }
 }
@@ -365,9 +364,7 @@ static void test_visitor_out_any(TestOutputVisitorData *data,
     qbool = qobject_to_qbool(qobj);
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);
-    qobj = qdict_get(qdict, "string");
-    g_assert(qobj);
-    qstring = qobject_to_qstring(qobj);
+    qstring = qobject_to_qstring(qdict_get(qdict, "string"));
     g_assert(qstring);
     g_assert_cmpstr(qstring_get_str(qstring), ==, "foo");
 }
@@ -399,6 +396,7 @@ static void test_visitor_out_alternate(TestOutputVisitorData *data,
 {
     QObject *arg;
     UserDefAlternate *tmp;
+    QString *qstr;
     QDict *qdict;
 
     tmp = g_new0(UserDefAlternate, 1);
@@ -419,10 +417,9 @@ static void test_visitor_out_alternate(TestOutputVisitorData *data,
     tmp->u.s = g_strdup("hello");
 
     visit_type_UserDefAlternate(data->ov, NULL, &tmp, &error_abort);
-    arg = visitor_get(data);
-
-    g_assert(qobject_type(arg) == QTYPE_QSTRING);
-    g_assert_cmpstr(qstring_get_str(qobject_to_qstring(arg)), ==, "hello");
+    qstr = qobject_to_qstring(visitor_get(data));
+    g_assert(qstr);
+    g_assert_cmpstr(qstring_get_str(qstr), ==, "hello");
 
     qapi_free_UserDefAlternate(tmp);
 
-- 
2.7.4
