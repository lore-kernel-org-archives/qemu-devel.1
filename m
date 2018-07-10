Received: from eggs.gnu.org ([2001:4830:134:3::10]:40861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub2-0003Bm-Pp
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub1-0003P1-MF
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcub1-0003Oe-Gl
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2800C7C6A9
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:31 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:10 +0100
Message-Id: <20180710153016.131258-10-dgilbert@redhat.com>
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 09/15] tests: introduce migrate_postcopy_*
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

Separate the old postcopy UNIX socket test into three steps, provide a
helper for each step.  With these helpers, we can do more compliated
tests like postcopy recovery, while keep the codes shared.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180710091902.28780-6-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Fix up merge with 2e295789 / Skip tests for ppc tcg
---
 tests/migration-test.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 331efb0fe5..193c7df94e 100644
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
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -510,13 +516,14 @@ static void test_deprecated(void)
     qtest_quit(from);
 }
 
-static void test_postcopy(void)
+static int migrate_postcopy_prepare(QTestState **from_ptr,
+                                     QTestState **to_ptr)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
     if (test_migrate_start(&from, &to, uri, false)) {
-        return;
+        return -1;
     }
 
     migrate_set_capability(from, "postcopy-ram", "true");
@@ -534,28 +541,41 @@ static void test_postcopy(void)
     wait_for_serial("src_serial");
 
     migrate(from, uri);
+    g_free(uri);
 
     wait_for_migration_pass(from);
 
-    migrate_start_postcopy(from);
+    *from_ptr = from;
+    *to_ptr = to;
 
-    if (!got_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
+    return 0;
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
+    if (migrate_postcopy_prepare(&from, &to)) {
+        return;
+    }
+    migrate_postcopy_start(from, to);
+    migrate_postcopy_complete(from, to);
+}
+
 static void test_baddest(void)
 {
     QTestState *from, *to;
-- 
2.17.1
