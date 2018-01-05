Received: from eggs.gnu.org ([2001:4830:134:3::10]:38433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvH-0002QH-Pg
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvG-0003M5-92
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXZvF-0003L6-Td
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF752C0587D2
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 21:53:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 22:52:42 +0100
Message-Id: <20180105215246.908-8-quintela@redhat.com>
In-Reply-To: <20180105215246.908-1-quintela@redhat.com>
References: <20180105215246.908-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 07/11] tests: Add basic migration precopy
 tcp test
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 88653ad767..024b6675fb 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -366,8 +366,7 @@ static void cleanup(const char *filename)
     g_free(path);
 }
 
-static void migrate_check_parameter(QTestState *who, const char *parameter,
-                                    const char *value)
+static char *migrate_get_parameter(QTestState *who, const char *parameter)
 {
     QDict *rsp, *rsp_return;
     char *result;
@@ -376,9 +375,18 @@ static void migrate_check_parameter(QTestState *who, const char *parameter,
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
 
 static void migrate_set_parameter(QTestState *who, const char *parameter,
@@ -657,6 +665,50 @@ static void test_precopy_unix(void)
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
+    /* 1 ms should make it not converge*/
+    migrate_set_parameter(from, "downtime-limit", "1");
+    /* 1GB/s */
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
@@ -677,6 +729,7 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
 
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
+    qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/postcopy/unix", test_postcopy);
 
-- 
2.14.3
