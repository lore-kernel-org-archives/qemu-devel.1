Received: from eggs.gnu.org ([2001:4830:134:3::10]:38422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvF-0002QD-FY
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvE-0003KD-Eg
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXZvE-0003Ig-66
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 425D2C001F0C
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 21:53:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 22:52:41 +0100
Message-Id: <20180105215246.908-7-quintela@redhat.com>
In-Reply-To: <20180105215246.908-1-quintela@redhat.com>
References: <20180105215246.908-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/11] tests: Add migration precopy test
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
---
 tests/migration-test.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index bcb0a82d42..88653ad767 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -571,7 +571,7 @@ static void test_deprecated(void)
     cleanup("dest_serial");
 }
 
-static void test_migrate(void)
+static void test_postcopy(void)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
@@ -618,6 +618,45 @@ static void test_migrate(void)
     test_migrate_end(from, to);
 }
 
+static void test_precopy_unix(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+
+    test_migrate_start(&from, &to, uri);
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
+    test_migrate_end(from, to);
+    g_free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -637,8 +676,9 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
 
-    qtest_add_func("/migration/postcopy/unix", test_migrate);
+    qtest_add_func("/migration/precopy/unix", test_precopy_unix);
     qtest_add_func("/migration/deprecated", test_deprecated);
+    qtest_add_func("/migration/postcopy/unix", test_postcopy);
 
     ret = g_test_run();
 
-- 
2.14.3
