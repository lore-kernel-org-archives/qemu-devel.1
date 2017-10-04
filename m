Received: from eggs.gnu.org ([2001:4830:134:3::10]:52208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzh5f-0007c0-P7
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzh5e-00048D-Lj
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:39:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzh5e-00047B-D1
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:39:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72016C059B76
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:39:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:39:31 +0200
Message-Id: <20171004103933.7898-5-quintela@redhat.com>
In-Reply-To: <20171004103933.7898-1-quintela@redhat.com>
References: <20171004103933.7898-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] tests: Add migration xbzrle test
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
 tests/migration-test.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 8549e4c2c6..f0734e4ba0 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -422,6 +422,23 @@ static void migrate_set_parameter(QTestState *who, const char *parameter,
     QDECREF(rsp);
 }
 
+static void migrate_set_capability(QTestState *who, const char *capability,
+                                   const char *value)
+{
+    QDict *rsp;
+    gchar *cmd;
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate-set-capabilities',"
+                          "'arguments': { "
+                            "'capabilities': [ { "
+                              "'capability': '%s', 'state': %s } ] } }",
+                          capability, value);
+    rsp = qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+}
+
 static void migrate_set_downtime(QTestState *who, const char *value)
 {
     QDict *rsp;
@@ -448,6 +465,19 @@ static void migrate_set_speed(QTestState *who, const char *value)
     QDECREF(rsp);
 }
 
+static void migrate_set_cache_size(QTestState *who, const char *value)
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
+}
+
 static void test_precopy_deprecated(const char *uri)
 {
     QTestState *from, *to;
@@ -543,6 +573,55 @@ static void test_precopy_tcp(void)
     test_precopy(uri);
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
+    migrate_set_parameter(from, "downtime-limit", "100");
+    /* 1MB/s slow*/
+    migrate_set_parameter(from, "max-bandwidth", "100000000");
+
+    migrate_set_cache_size(from, "50000000");
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
+    /* 1GB/s now it should converge */
+    migrate_set_parameter(from, "max-bandwidth", "1000000000");
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
@@ -561,6 +640,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/deprecated/unix", test_deprecated_unix);
+    qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
 
     ret = g_test_run();
 
-- 
2.13.5
