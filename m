Received: from eggs.gnu.org ([2001:4830:134:3::10]:50465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QT-0007aD-IH
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QQ-0004Kp-8a
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35947 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew9QQ-0004K1-3E
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5DE9406E946
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 16:38:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Mar 2018 17:38:33 +0100
Message-Id: <20180314163838.7158-4-quintela@redhat.com>
In-Reply-To: <20180314163838.7158-1-quintela@redhat.com>
References: <20180314163838.7158-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 3/8] tests: Add migration xbzrle test
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 834cdf50f2..fd885ba909 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -512,6 +512,20 @@ static void deprecated_set_speed(QTestState *who, const char *value)
     migrate_check_parameter(who, "max-bandwidth", value);
 }
 
+static void deprecated_set_cache_size(QTestState *who, const char *value)
+{
+    QDict *rsp;
+    gchar *cmd;
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate-set-cache-size',"
+                          "'arguments': { 'value': %s } }", value);
+    rsp = qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+    migrate_check_parameter(who, "xbzrle-cache-size", value);
+}
+
 static void test_deprecated(void)
 {
     QTestState *from;
@@ -520,6 +534,7 @@ static void test_deprecated(void)
 
     deprecated_set_downtime(from, 0.12345);
     deprecated_set_speed(from, "12345");
+    deprecated_set_cache_size(from, "4096");
 
     qtest_quit(from);
 }
@@ -634,6 +649,54 @@ static void test_precopy_unix(void)
     g_free(uri);
 }
 
+static void test_xbzrle(const char *uri)
+{
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
+    migrate_set_parameter(from, "xbzrle-cache-size", "33554432");
+
+    migrate_set_capability(from, "xbzrle", "true");
+    migrate_set_capability(to, "xbzrle", "true");
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri);
+
+    wait_for_migration_pass(from);
+
+    /* 300ms should converge */
+    migrate_set_parameter(from, "downtime-limit", "300");
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    test_migrate_end(from, to, true);
+}
+
+static void test_xbzrle_unix(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+
+    test_xbzrle(uri);
+    g_free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -657,6 +720,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
+    qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
 
     ret = g_test_run();
 
-- 
2.14.3
