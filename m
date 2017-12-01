Received: from eggs.gnu.org ([2001:4830:134:3::10]:54272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoIp-0004dU-3k
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoIk-0002oX-22
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eKoIj-0002np-Op
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB8B34E4C2
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 12:58:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  1 Dec 2017 13:58:11 +0100
Message-Id: <20171201125813.1437-5-quintela@redhat.com>
In-Reply-To: <20171201125813.1437-1-quintela@redhat.com>
References: <20171201125813.1437-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/6] tests: Add basic migration precopy tcp
 test
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

Not sharing code from precopy/unix because we have to read back the
tcp parameter.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 3f3f056be6..841c89e28a 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -354,8 +354,7 @@ static void cleanup(const char *filename)
     g_free(path);
 }
 
-static void migrate_check_parameter(QTestState *who, const char *parameter,
-                                    const char *value)
+static char *migrate_get_parameter(QTestState *who, const char *parameter)
 {
     QDict *rsp, *rsp_return;
     char *result;
@@ -364,9 +363,18 @@ static void migrate_check_parameter(QTestState *who, const char *parameter,
     rsp_return = qdict_get_qdict(rsp, "return");
     result = g_strdup_printf("%" PRId64,
                              qdict_get_try_int(rsp_return,  parameter, -1));
+    QDECREF(rsp);
+    return result;
+}
+
+static void migrate_check_parameter(QTestState *who, const char *parameter,
+                                    const char *value)
+{
+    char *result;
+
+    result = migrate_get_parameter(who, parameter);
     g_assert_cmpstr(result, ==, value);
     g_free(result);
-    QDECREF(rsp);
 }
 
 static void deprecated_set_downtime(QTestState *who, const double value)
@@ -621,6 +629,50 @@ static void test_precopy_unix(void)
     g_free(uri);
 }
 
+static void test_precopy_tcp(void)
+{
+    char *uri;
+    char *port;
+    QTestState *from, *to;
+
+    test_migrate_start(&from, &to, "tcp:127.0.0.1:0");
+
+    /* We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms */
+    migrate_set_parameter(from, "downtime-limit", "1");
+    /* 1GB/s slow*/
+    migrate_set_parameter(from, "max-bandwidth", "1000000000");
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    port = migrate_get_parameter(to, "tcp-port");
+    uri = g_strdup_printf("tcp:127.0.0.1:%s", port);
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
+    g_free(port);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -641,6 +693,7 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
 
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
+    qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/postcopy/unix", test_postcopy);
 
     ret = g_test_run();
-- 
2.14.3
