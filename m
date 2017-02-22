Received: from eggs.gnu.org ([2001:4830:134:3::10]:40599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgcNU-0004dD-S8
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgcNS-0000eu-UT
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgcNS-0000e5-Ot
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:02 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 011AC3D95D
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 19:15:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1MJF1Fc025335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 14:15:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Feb 2017 20:14:55 +0100
Message-Id: <1487790898-24921-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1487790898-24921-1-git-send-email-armbru@redhat.com>
References: <1487790898-24921-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 13/16] tests: Don't check qobject_type() before
 qobject_to_qfloat()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qobject_to_qfloat(obj) returns NULL when obj isn't a QFloat.  Check
that instead of qobject_type(obj) == QTYPE_QFLOAT.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1487363905-9480-12-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/check-qjson.c                 | 12 ++----------
 tests/test-qobject-output-visitor.c |  8 ++++----
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index aab4e0a..591b70a 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -921,10 +921,8 @@ static void float_number(void)
         QFloat *qfloat;
 
         obj = qobject_from_json(test_cases[i].encoded);
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QFLOAT);
-
         qfloat = qobject_to_qfloat(obj);
+        g_assert(qfloat);
         g_assert(qfloat_get_double(qfloat) == test_cases[i].decoded);
 
         if (test_cases[i].skip == 0) {
@@ -941,7 +939,6 @@ static void float_number(void)
 
 static void vararg_number(void)
 {
-    QObject *obj;
     QInt *qint;
     QFloat *qfloat;
     int value = 0x2342;
@@ -956,13 +953,8 @@ static void vararg_number(void)
     g_assert(qint_get_int(qint) == value_ll);
     QDECREF(qint);
 
-    obj = qobject_from_jsonf("%f", valuef);
-    g_assert(obj != NULL);
-    g_assert(qobject_type(obj) == QTYPE_QFLOAT);
-
-    qfloat = qobject_to_qfloat(obj);
+    qfloat = qobject_to_qfloat(qobject_from_jsonf("%f", valuef));
     g_assert(qfloat_get_double(qfloat) == valuef);
-
     QDECREF(qfloat);
 }
 
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 50b807e..5617fd3 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -84,13 +84,13 @@ static void test_visitor_out_number(TestOutputVisitorData *data,
                                     const void *unused)
 {
     double value = 3.14;
-    QObject *obj;
+    QFloat *qfloat;
 
     visit_type_number(data->ov, NULL, &value, &error_abort);
 
-    obj = visitor_get(data);
-    g_assert(qobject_type(obj) == QTYPE_QFLOAT);
-    g_assert(qfloat_get_double(qobject_to_qfloat(obj)) == value);
+    qfloat = qobject_to_qfloat(visitor_get(data));
+    g_assert(qfloat);
+    g_assert(qfloat_get_double(qfloat) == value);
 }
 
 static void test_visitor_out_string(TestOutputVisitorData *data,
-- 
2.7.4
