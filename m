Received: from eggs.gnu.org ([2001:4830:134:3::10]:47908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fbRlP-00073X-PJ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fbRlL-0003sh-NO
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:31:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fbRlL-0003qh-IT
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:31:07 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  6 Jul 2018 15:31:05 +0100
Message-Id: <20180706143105.93472-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/1] tests/migration: Skip tests for ppc tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, quintela@redhat.com, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

PPC tcg seems to be failing migration tests quite regularly;
we believe this is TCG bugs in dirty bit updating; it's
not clear why PPC fails more but lets skip for the moment.

$ ./tests/migration-test
/ppc64/migration/deprecated: OK
/ppc64/migration/bad_dest: Skipping test: kvm_hv not available OK
/ppc64/migration/postcopy/unix: Skipping test: kvm_hv not available OK
/ppc64/migration/precopy/unix: Skipping test: kvm_hv not available OK

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

v2
  use a print rather than g_test_skip since gtester is broken in
some version

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 3a85446f95..331efb0fe5 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -360,7 +360,7 @@ static void migrate_start_postcopy(QTestState *who)
     qobject_unref(rsp);
 }
 
-static void test_migrate_start(QTestState **from, QTestState **to,
+static int test_migrate_start(QTestState **from, QTestState **to,
                                const char *uri, bool hide_stderr)
 {
     gchar *cmd_src, *cmd_dst;
@@ -385,9 +385,13 @@ static void test_migrate_start(QTestState **from, QTestState **to,
                                   accel, tmpfs, bootpath, uri);
     } else if (strcmp(arch, "ppc64") == 0) {
 
-        /* On ppc64, the test only works with kvm-hv, but not with kvm-pr */
+        /* On ppc64, the test only works with kvm-hv, but not with kvm-pr
+         * and TCG is touchy due to race conditions on dirty bits
+         * (especially on PPC for some reason)
+         */
         if (access("/sys/module/kvm_hv", F_OK)) {
-            accel = "tcg";
+            g_print("Skipping test: kvm_hv not available ");
+            return -1;
         }
         cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
                                   " -name source,debug-threads=on"
@@ -424,6 +428,7 @@ static void test_migrate_start(QTestState **from, QTestState **to,
 
     *to = qtest_init(cmd_dst);
     g_free(cmd_dst);
+    return 0;
 }
 
 static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
@@ -510,7 +515,9 @@ static void test_postcopy(void)
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    test_migrate_start(&from, &to, uri, false);
+    if (test_migrate_start(&from, &to, uri, false)) {
+        return;
+    }
 
     migrate_set_capability(from, "postcopy-ram", "true");
     migrate_set_capability(to, "postcopy-ram", "true");
@@ -556,7 +563,9 @@ static void test_baddest(void)
     const char *status;
     bool failed;
 
-    test_migrate_start(&from, &to, "tcp:0:0", true);
+    if (test_migrate_start(&from, &to, "tcp:0:0", true)) {
+        return;
+    }
     migrate(from, "tcp:0:0");
     do {
         rsp = wait_command(from, "{ 'execute': 'query-migrate' }");
@@ -585,7 +594,9 @@ static void test_precopy_unix(void)
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    test_migrate_start(&from, &to, uri, false);
+    if (test_migrate_start(&from, &to, uri, false)) {
+        return;
+    }
 
     /* We want to pick a speed slow enough that the test completes
      * quickly, but that it doesn't complete precopy even on a slow
-- 
2.17.1
