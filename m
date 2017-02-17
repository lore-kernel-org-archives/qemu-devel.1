Received: from eggs.gnu.org ([2001:4830:134:3::10]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIV-0002Ym-0a
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIT-0004QU-OS
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIT-0004PX-GP
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:29 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB9EF7FB77
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcS11005390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:29 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:23 +0100
Message-Id: <1487363905-9480-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 12/14] tests: Don't check qobject_type() before
 qobject_to_qbool()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qobject_to_qbool(obj) returns NULL when obj isn't a QBool.  Check
that instead of qobject_type(obj) == QTYPE_QBOOL.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c                 | 24 ++++++------------------
 tests/test-qobject-output-visitor.c | 12 +++++-------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 591b70a..e6d6935 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -966,10 +966,8 @@ static void keyword_literal(void)
     QString *str;
 
     obj = qobject_from_json("true");
-    g_assert(obj != NULL);
-    g_assert(qobject_type(obj) == QTYPE_QBOOL);
-
     qbool = qobject_to_qbool(obj);
+    g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);
 
     str = qobject_to_json(obj);
@@ -979,10 +977,8 @@ static void keyword_literal(void)
     QDECREF(qbool);
 
     obj = qobject_from_json("false");
-    g_assert(obj != NULL);
-    g_assert(qobject_type(obj) == QTYPE_QBOOL);
-
     qbool = qobject_to_qbool(obj);
+    g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == false);
 
     str = qobject_to_json(obj);
@@ -991,23 +987,15 @@ static void keyword_literal(void)
 
     QDECREF(qbool);
 
-    obj = qobject_from_jsonf("%i", false);
-    g_assert(obj != NULL);
-    g_assert(qobject_type(obj) == QTYPE_QBOOL);
-
-    qbool = qobject_to_qbool(obj);
+    qbool = qobject_to_qbool(qobject_from_jsonf("%i", false));
+    g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == false);
-
     QDECREF(qbool);
 
     /* Test that non-zero values other than 1 get collapsed to true */
-    obj = qobject_from_jsonf("%i", 2);
-    g_assert(obj != NULL);
-    g_assert(qobject_type(obj) == QTYPE_QBOOL);
-
-    qbool = qobject_to_qbool(obj);
+    qbool = qobject_to_qbool(qobject_from_jsonf("%i", 2));
+    g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);
-
     QDECREF(qbool);
 
     obj = qobject_from_json("null");
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 5617fd3..500b452 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -71,13 +71,13 @@ static void test_visitor_out_bool(TestOutputVisitorData *data,
                                   const void *unused)
 {
     bool value = true;
-    QObject *obj;
+    QBool *qbool;
 
     visit_type_bool(data->ov, NULL, &value, &error_abort);
 
-    obj = visitor_get(data);
-    g_assert(qobject_type(obj) == QTYPE_QBOOL);
-    g_assert(qbool_get_bool(qobject_to_qbool(obj)) == value);
+    qbool = qobject_to_qbool(visitor_get(data));
+    g_assert(qbool);
+    g_assert(qbool_get_bool(qbool) == value);
 }
 
 static void test_visitor_out_number(TestOutputVisitorData *data,
@@ -356,9 +356,7 @@ static void test_visitor_out_any(TestOutputVisitorData *data,
     qint = qobject_to_qint(qdict_get(qdict, "integer"));
     g_assert(qint);
     g_assert_cmpint(qint_get_int(qint), ==, -42);
-    qobj = qdict_get(qdict, "boolean");
-    g_assert(qobj);
-    qbool = qobject_to_qbool(qobj);
+    qbool = qobject_to_qbool(qdict_get(qdict, "boolean"));
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);
     qstring = qobject_to_qstring(qdict_get(qdict, "string"));
-- 
2.7.4
