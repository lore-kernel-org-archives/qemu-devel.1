Received: from eggs.gnu.org ([2001:4830:134:3::10]:47020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7cy9-0004qA-GH
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7cy8-00087x-GE
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:52:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e7cy8-00087M-7K
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31E50C047B97
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 07:52:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 26 Oct 2017 09:52:21 +0200
Message-Id: <20171026075222.27798-10-quintela@redhat.com>
In-Reply-To: <20171026075222.27798-1-quintela@redhat.com>
References: <20171026075222.27798-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/10] tests: Add migration xbzrle test
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
 tests/migration-test.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index b72dff3917..db30b3864b 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -573,6 +573,19 @@ static void test_postcopy(void)
     test_migrate_end(from, to);
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
@@ -588,6 +601,9 @@ static void test_precopy_deprecated(const char *uri)
     /* 1MB/s slow*/
     migrate_set_speed(from, "1000000000");
 
+    /* we don't use xbzrle here, but we test old commands */
+    migrate_set_cache_size(from, "33554432");
+
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
@@ -670,6 +686,55 @@ static void test_precopy_tcp(void)
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
@@ -693,6 +758,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/deprecated/unix", test_deprecated_unix);
     qtest_add_func("/migration/postcopy/unix", test_postcopy);
+    qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
 
     ret = g_test_run();
 
-- 
2.13.6
