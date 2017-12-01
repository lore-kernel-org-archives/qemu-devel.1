Received: from eggs.gnu.org ([2001:4830:134:3::10]:56432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoKM-000661-Vl
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoKI-0004Oi-5o
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:38:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eKoKH-0004My-T6
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:38:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E87F6C0050BB
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 12:58:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  1 Dec 2017 13:58:12 +0100
Message-Id: <20171201125813.1437-6-quintela@redhat.com>
In-Reply-To: <20171201125813.1437-1-quintela@redhat.com>
References: <20171201125813.1437-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/6] tests: Add migration xbzrle test
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
---
 tests/migration-test.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 841c89e28a..41dee78a9a 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -410,6 +410,20 @@ static void deprecated_set_speed(QTestState *who, const char *value)
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
 static void migrate_set_parameter(QTestState *who, const char *parameter,
                                   const char *value)
 {
@@ -424,6 +438,10 @@ static void migrate_set_parameter(QTestState *who, const char *parameter,
         deprecated_set_speed(who, "12345");
     }
 
+    if (strcmp(parameter, "xbzrle-cache-size") == 0) {
+        deprecated_set_cache_size(who, "4096");
+    }
+
     cmd = g_strdup_printf("{ 'execute': 'migrate-set-parameters',"
                           "'arguments': { '%s': %s } }",
                           parameter, value);
@@ -673,6 +691,55 @@ static void test_precopy_tcp(void)
     g_free(port);
 }
 
+static void test_xbzrle(const char *uri)
+{
+    QTestState *from, *to;
+
+    test_migrate_start(&from, &to, uri);
+
+    /* We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 100 ms */
+    migrate_set_parameter(from, "downtime-limit", "1");
+    /* 1MB/s slow*/
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
+    /* 300ms it should converge */
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
+    test_migrate_end(from, to);
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
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -695,6 +762,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/postcopy/unix", test_postcopy);
+    qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
 
     ret = g_test_run();
 
-- 
2.14.3
