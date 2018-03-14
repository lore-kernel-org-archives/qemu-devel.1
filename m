Received: from eggs.gnu.org ([2001:4830:134:3::10]:50507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QU-0007ar-Kb
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QT-0004NS-8W
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew9QT-0004My-3A
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A156B406E946
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 16:38:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Mar 2018 17:38:36 +0100
Message-Id: <20180314163838.7158-7-quintela@redhat.com>
In-Reply-To: <20180314163838.7158-1-quintela@redhat.com>
References: <20180314163838.7158-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 6/8] tests: Add basic migration precopy tcp
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 4a94d3d598..8f367ea1d7 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -19,6 +19,9 @@
 #include "qemu/sockets.h"
 #include "chardev/char.h"
 #include "sysemu/sysemu.h"
+#include "qapi/qapi-visit-sockets.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
 
 const unsigned start_address = 1024 * 1024;
 const unsigned end_address = 100 * 1024 * 1024;
@@ -277,8 +280,28 @@ static void cleanup(const char *filename)
     g_free(path);
 }
 
-static void migrate_check_parameter(QTestState *who, const char *parameter,
-                                    const char *value)
+static char *migrate_get_socket_address(QTestState *who, const char *parameter)
+{
+    QDict *rsp, *rsp_return;
+    char *result;
+    Error *local_err = NULL;
+    SocketAddress *saddr = NULL;
+    Visitor *iv = NULL;
+    QObject *object;
+
+    rsp = wait_command(who, "{ 'execute': 'query-migrate-parameters' }");
+    rsp_return = qdict_get_qdict(rsp, "return");
+    object = qdict_get(rsp_return, parameter);
+
+    iv = qobject_input_visitor_new(object);
+    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
+    result = g_strdup_printf("%s",
+                             SocketAddress_to_str("", saddr, false, false));
+    QDECREF(rsp);
+    return result;
+}
+
+static char *migrate_get_parameter(QTestState *who, const char *parameter)
 {
     QDict *rsp, *rsp_return;
     char *result;
@@ -287,9 +310,18 @@ static void migrate_check_parameter(QTestState *who, const char *parameter,
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
@@ -666,6 +698,46 @@ static void test_xbzrle_unix(void)
     g_free(uri);
 }
 
+static void test_precopy_tcp(void)
+{
+    char *uri;
+    QTestState *from, *to;
+
+    test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false);
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
+    uri = migrate_get_socket_address(to, "x-socket-address");
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
+    g_free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -689,6 +761,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
+    qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
 
     ret = g_test_run();
-- 
2.14.3
