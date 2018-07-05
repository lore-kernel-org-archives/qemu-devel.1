Received: from eggs.gnu.org ([2001:4830:134:3::10]:49830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fauma-00048s-B4
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 23:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1faumY-0001qr-AW
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 23:18:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1faumY-0001pi-5W
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 23:18:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4CDB81A4EAD
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 03:18:09 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  5 Jul 2018 11:17:50 +0800
Message-Id: <20180705031755.3254-5-peterx@redhat.com>
In-Reply-To: <20180705031755.3254-1-peterx@redhat.com>
References: <20180705031755.3254-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 4/9] tests: introduce
 migrate_postcopy_* helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Separate the old postcopy UNIX socket test into three steps, provide a
helper for each step.  With these helpers, we can do more compliated
tests like postcopy recovery, while keep the codes shared.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 3a85446f95..2155869b96 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -351,13 +351,19 @@ static void migrate(QTestState *who, const char *uri)
     qobject_unref(rsp);
 }
 
-static void migrate_start_postcopy(QTestState *who)
+static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
     QDict *rsp;
 
-    rsp = wait_command(who, "{ 'execute': 'migrate-start-postcopy' }");
+    rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+
+    qtest_qmp_eventwait(to, "RESUME");
 }
 
 static void test_migrate_start(QTestState **from, QTestState **to,
@@ -505,7 +511,8 @@ static void test_deprecated(void)
     qtest_quit(from);
 }
 
-static void test_postcopy(void)
+static void migrate_postcopy_prepare(QTestState **from_ptr,
+                                     QTestState **to_ptr)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
@@ -527,28 +534,37 @@ static void test_postcopy(void)
     wait_for_serial("src_serial");
 
     migrate(from, uri);
+    g_free(uri);
 
     wait_for_migration_pass(from);
 
-    migrate_start_postcopy(from);
-
-    if (!got_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
+    *from_ptr = from;
+    *to_ptr = to;
+}
 
-    qtest_qmp_eventwait(to, "RESUME");
+static void migrate_postcopy_complete(QTestState *from, QTestState *to)
+{
+    wait_for_migration_complete(from);
 
+    /* Make sure we get at least one "B" on destination */
     wait_for_serial("dest_serial");
-    wait_for_migration_complete(from);
 
     if (uffd_feature_thread_id) {
         read_blocktime(to);
     }
-    g_free(uri);
 
     test_migrate_end(from, to, true);
 }
 
+static void test_postcopy(void)
+{
+    QTestState *from, *to;
+
+    migrate_postcopy_prepare(&from, &to);
+    migrate_postcopy_start(from, to);
+    migrate_postcopy_complete(from, to);
+}
+
 static void test_baddest(void)
 {
     QTestState *from, *to;
-- 
2.17.1
