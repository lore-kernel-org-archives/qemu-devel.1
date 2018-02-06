Received: from eggs.gnu.org ([2001:4830:134:3::10]:43537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5WS-00037M-KL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5WQ-0004VF-71
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:51:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej5WQ-0004Ud-1Y
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:51:02 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  6 Feb 2018 15:49:28 +0000
Message-Id: <20180206154936.13565-7-dgilbert@redhat.com>
In-Reply-To: <20180206154936.13565-1-dgilbert@redhat.com>
References: <20180206154936.13565-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 06/14] tests: Remove deprecated migration tests
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com, wei.w.wang@intel.com, danielhb@linux.vnet.ibm.com

From: Juan Quintela <quintela@redhat.com>

We move to use migration_set_parameter() for everything.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 799e24ebc6..0428d450df 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -369,37 +369,20 @@ static void migrate_check_parameter(QTestState *who, const char *parameter,
     QDECREF(rsp);
 }
 
-static void migrate_set_downtime(QTestState *who, const double value)
+static void migrate_set_parameter(QTestState *who, const char *parameter,
+                                  const char *value)
 {
     QDict *rsp;
     gchar *cmd;
-    char *expected;
-    int64_t result_int;
 
-    cmd = g_strdup_printf("{ 'execute': 'migrate_set_downtime',"
-                          "'arguments': { 'value': %g } }", value);
+    cmd = g_strdup_printf("{ 'execute': 'migrate-set-parameters',"
+                          "'arguments': { '%s': %s } }",
+                          parameter, value);
     rsp = qtest_qmp(who, cmd);
     g_free(cmd);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
-    result_int = value * 1000L;
-    expected = g_strdup_printf("%" PRId64, result_int);
-    migrate_check_parameter(who, "downtime-limit", expected);
-    g_free(expected);
-}
-
-static void migrate_set_speed(QTestState *who, const char *value)
-{
-    QDict *rsp;
-    gchar *cmd;
-
-    cmd = g_strdup_printf("{ 'execute': 'migrate_set_speed',"
-                          "'arguments': { 'value': %s } }", value);
-    rsp = qtest_qmp(who, cmd);
-    g_free(cmd);
-    g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
-    migrate_check_parameter(who, "max-bandwidth", value);
+    migrate_check_parameter(who, parameter, value);
 }
 
 static void migrate_set_capability(QTestState *who, const char *capability,
@@ -530,8 +513,8 @@ static void test_migrate(void)
      * quickly, but that it doesn't complete precopy even on a slow
      * machine, so also set the downtime.
      */
-    migrate_set_speed(from, "100000000");
-    migrate_set_downtime(from, 0.001);
+    migrate_set_parameter(from, "max-bandwidth", "100000000");
+    migrate_set_parameter(from, "downtime-limit", "1");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
-- 
2.14.3
