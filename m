Received: from eggs.gnu.org ([2001:4830:134:3::10]:59086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIX-0002am-28
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIT-0004Qs-VR
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIT-0004Pe-MN
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCB42C05AA4E
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcSkh007997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:29 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:21 +0100
Message-Id: <1487363905-9480-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 10/14] tests: Don't check qobject_type() before
 qobject_to_qint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qobject_to_qint(obj) returns NULL when obj isn't a QInt.  Check
that instead of qobject_type(obj) == QTYPE_QINT.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c                 | 24 +++++-------------------
 tests/test-qobject-output-visitor.c | 28 ++++++++++++----------------
 2 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index dd080a8..aab4e0a 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -884,19 +884,15 @@ static void simple_number(void)
     };
 
     for (i = 0; test_cases[i].encoded; i++) {
-        QObject *obj;
         QInt *qint;
 
-        obj = qobject_from_json(test_cases[i].encoded);
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QINT);
-
-        qint = qobject_to_qint(obj);
+        qint = qobject_to_qint(qobject_from_json(test_cases[i].encoded));
+        g_assert(qint);
         g_assert(qint_get_int(qint) == test_cases[i].decoded);
         if (test_cases[i].skip == 0) {
             QString *str;
 
-            str = qobject_to_json(obj);
+            str = qobject_to_json(QOBJECT(qint));
             g_assert(strcmp(qstring_get_str(str), test_cases[i].encoded) == 0);
             QDECREF(str);
         }
@@ -952,22 +948,12 @@ static void vararg_number(void)
     long long value_ll = 0x2342342343LL;
     double valuef = 2.323423423;
 
-    obj = qobject_from_jsonf("%d", value);
-    g_assert(obj != NULL);
-    g_assert(qobject_type(obj) == QTYPE_QINT);
-
-    qint = qobject_to_qint(obj);
+    qint = qobject_to_qint(qobject_from_jsonf("%d", value));
     g_assert(qint_get_int(qint) == value);
-
     QDECREF(qint);
 
-    obj = qobject_from_jsonf("%lld", value_ll);
-    g_assert(obj != NULL);
-    g_assert(qobject_type(obj) == QTYPE_QINT);
-
-    qint = qobject_to_qint(obj);
+    qint = qobject_to_qint(qobject_from_jsonf("%lld", value_ll));
     g_assert(qint_get_int(qint) == value_ll);
-
     QDECREF(qint);
 
     obj = qobject_from_jsonf("%f", valuef);
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 3e34aa5..50b807e 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -58,13 +58,13 @@ static void test_visitor_out_int(TestOutputVisitorData *data,
                                  const void *unused)
 {
     int64_t value = -42;
-    QObject *obj;
+    QInt *qint;
 
     visit_type_int(data->ov, NULL, &value, &error_abort);
 
-    obj = visitor_get(data);
-    g_assert(qobject_type(obj) == QTYPE_QINT);
-    g_assert_cmpint(qint_get_int(qobject_to_qint(obj)), ==, value);
+    qint = qobject_to_qint(visitor_get(data));
+    g_assert(qint);
+    g_assert_cmpint(qint_get_int(qint), ==, value);
 }
 
 static void test_visitor_out_bool(TestOutputVisitorData *data,
@@ -335,13 +335,12 @@ static void test_visitor_out_any(TestOutputVisitorData *data,
     QBool *qbool;
     QString *qstring;
     QDict *qdict;
-    QObject *obj;
 
     qobj = QOBJECT(qint_from_int(-42));
     visit_type_any(data->ov, NULL, &qobj, &error_abort);
-    obj = visitor_get(data);
-    g_assert(qobject_type(obj) == QTYPE_QINT);
-    g_assert_cmpint(qint_get_int(qobject_to_qint(obj)), ==, -42);
+    qint = qobject_to_qint(visitor_get(data));
+    g_assert(qint);
+    g_assert_cmpint(qint_get_int(qint), ==, -42);
     qobject_decref(qobj);
 
     visitor_reset(data);
@@ -354,9 +353,7 @@ static void test_visitor_out_any(TestOutputVisitorData *data,
     qobject_decref(qobj);
     qdict = qobject_to_qdict(visitor_get(data));
     g_assert(qdict);
-    qobj = qdict_get(qdict, "integer");
-    g_assert(qobj);
-    qint = qobject_to_qint(qobj);
+    qint = qobject_to_qint(qdict_get(qdict, "integer"));
     g_assert(qint);
     g_assert_cmpint(qint_get_int(qint), ==, -42);
     qobj = qdict_get(qdict, "boolean");
@@ -394,8 +391,8 @@ static void test_visitor_out_union_flat(TestOutputVisitorData *data,
 static void test_visitor_out_alternate(TestOutputVisitorData *data,
                                        const void *unused)
 {
-    QObject *arg;
     UserDefAlternate *tmp;
+    QInt *qint;
     QString *qstr;
     QDict *qdict;
 
@@ -404,10 +401,9 @@ static void test_visitor_out_alternate(TestOutputVisitorData *data,
     tmp->u.i = 42;
 
     visit_type_UserDefAlternate(data->ov, NULL, &tmp, &error_abort);
-    arg = visitor_get(data);
-
-    g_assert(qobject_type(arg) == QTYPE_QINT);
-    g_assert_cmpint(qint_get_int(qobject_to_qint(arg)), ==, 42);
+    qint = qobject_to_qint(visitor_get(data));
+    g_assert(qint);
+    g_assert_cmpint(qint_get_int(qint), ==, 42);
 
     qapi_free_UserDefAlternate(tmp);
 
-- 
2.7.4
