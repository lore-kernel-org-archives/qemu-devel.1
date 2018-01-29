Received: from eggs.gnu.org ([2001:4830:134:3::10]:41391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8GD-0005hy-76
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8G7-0001QE-8f
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8G7-0001Pd-3T
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76F0F4E05D
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:09:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:09:25 +0100
Message-Id: <20180129120932.12874-7-quintela@redhat.com>
In-Reply-To: <20180129120932.12874-1-quintela@redhat.com>
References: <20180129120932.12874-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 06/13] tests: Remove deprecated migration tests
 commands
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

We move to use migration_set_parameter() for everything.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
