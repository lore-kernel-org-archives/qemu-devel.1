Received: from eggs.gnu.org ([2001:4830:134:3::10]:54266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoIp-0004dN-1l
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoIn-0002rH-EC
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eKoIn-0002qW-8I
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5172481DE5
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 12:58:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  1 Dec 2017 13:58:09 +0100
Message-Id: <20171201125813.1437-3-quintela@redhat.com>
In-Reply-To: <20171201125813.1437-1-quintela@redhat.com>
References: <20171201125813.1437-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/6] tests: migration test deprecated
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

We now test the deprecated commands everytime that we test the new
commands.  This makes unnecesary to add tests for deprecated commands.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 799e24ebc6..51f49c74e9 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -369,7 +369,7 @@ static void migrate_check_parameter(QTestState *who, const char *parameter,
     QDECREF(rsp);
 }
 
-static void migrate_set_downtime(QTestState *who, const double value)
+static void deprecated_set_downtime(QTestState *who, const double value)
 {
     QDict *rsp;
     gchar *cmd;
@@ -388,7 +388,7 @@ static void migrate_set_downtime(QTestState *who, const double value)
     g_free(expected);
 }
 
-static void migrate_set_speed(QTestState *who, const char *value)
+static void deprecated_set_speed(QTestState *who, const char *value)
 {
     QDict *rsp;
     gchar *cmd;
@@ -402,6 +402,30 @@ static void migrate_set_speed(QTestState *who, const char *value)
     migrate_check_parameter(who, "max-bandwidth", value);
 }
 
+static void migrate_set_parameter(QTestState *who, const char *parameter,
+                                  const char *value)
+{
+    QDict *rsp;
+    gchar *cmd;
+
+    if (strcmp(parameter, "downtime-limit") == 0) {
+        deprecated_set_downtime(who, 0.12345);
+    }
+
+    if (strcmp(parameter, "max-bandwidth") == 0) {
+        deprecated_set_speed(who, "12345");
+    }
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate-set-parameters',"
+                          "'arguments': { '%s': %s } }",
+                          parameter, value);
+    rsp = qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+    migrate_check_parameter(who, parameter, value);
+}
+
 static void migrate_set_capability(QTestState *who, const char *capability,
                                    const char *value)
 {
@@ -530,8 +554,8 @@ static void test_migrate(void)
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
