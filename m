Received: from eggs.gnu.org ([2001:4830:134:3::10]:50461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QT-0007aA-HR
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QQ-0004Ki-7t
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew9QQ-0004K0-2t
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54B6F8182D2A
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 16:38:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Mar 2018 17:38:32 +0100
Message-Id: <20180314163838.7158-3-quintela@redhat.com>
In-Reply-To: <20180314163838.7158-1-quintela@redhat.com>
References: <20180314163838.7158-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/8] tests: Add migration precopy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 422bf1afdf..834cdf50f2 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -524,7 +524,7 @@ static void test_deprecated(void)
     qtest_quit(from);
 }
 
-static void test_migrate(void)
+static void test_postcopy(void)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
@@ -595,6 +595,45 @@ static void test_baddest(void)
     test_migrate_end(from, to, false);
 }
 
+static void test_precopy_unix(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+
+    test_migrate_start(&from, &to, uri, false);
+
+    /* We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms should make it not converge*/
+    migrate_set_parameter(from, "downtime-limit", "1");
+    /* 1GB/s */
+    migrate_set_parameter(from, "max-bandwidth", "1000000000");
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri);
+
+    wait_for_migration_pass(from);
+
+    /* 300 ms should converge */
+    migrate_set_parameter(from, "downtime-limit", "300");
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    test_migrate_end(from, to, true);
+    g_free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -614,9 +653,10 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
 
-    qtest_add_func("/migration/postcopy/unix", test_migrate);
+    qtest_add_func("/migration/postcopy/unix", test_postcopy);
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/bad_dest", test_baddest);
+    qtest_add_func("/migration/precopy/unix", test_precopy_unix);
 
     ret = g_test_run();
 
-- 
2.14.3
