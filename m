Received: from eggs.gnu.org ([2001:4830:134:3::10]:42265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RZ-00068m-A6
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RV-0000Ec-Ho
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59494 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fj4RV-0000E9-AY
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jul 2018 17:13:55 +0200
Message-Id: <20180727151359.29061-20-armbru@redhat.com>
In-Reply-To: <20180727151359.29061-1-armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 19/23] migration-test: Clean up string
 interpolation into QMP, part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Leaving interpolation into JSON to qmp() is more robust than building
QMP input manually, as explained in the recent commit "tests: Clean up
string interpolation into QMP input (simple cases)".

migration-test.c interpolates strings into JSON in a few places:

* migrate_set_parameter() interpolates string parameter @value as a
  JSON number.  Change it to long long.  This requires changing
  migrate_check_parameter() similarly.

* migrate_set_capability() interpolates string parameter @value as a
  JSON boolean.  Change it to bool.

* deprecated_set_speed() interpolates string parameter @value as a
  JSON number.  Change it to long long.

Bonus: gets rid of non-literal format strings.  A step towards
compile-time format string checking without triggering
-Wformat-nonliteral.

Cc: Juan Quintela <quintela@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 74 +++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 1c1e56b15b..132c30891d 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -315,31 +315,25 @@ static void cleanup(const char *filename)
 }
 
 static void migrate_check_parameter(QTestState *who, const char *parameter,
-                                    const char *value)
+                                    long long value)
 {
     QDict *rsp_return;
-    char *result;
 
     rsp_return = wait_command(who,
                               "{ 'execute': 'query-migrate-parameters' }");
-    result = g_strdup_printf("%" PRId64,
-                             qdict_get_try_int(rsp_return,  parameter, -1));
-    g_assert_cmpstr(result, ==, value);
-    g_free(result);
+    g_assert_cmpint(qdict_get_int(rsp_return,  parameter), ==, value);
     qobject_unref(rsp_return);
 }
 
 static void migrate_set_parameter(QTestState *who, const char *parameter,
-                                  const char *value)
+                                  long long value)
 {
     QDict *rsp;
-    gchar *cmd;
 
-    cmd = g_strdup_printf("{ 'execute': 'migrate-set-parameters',"
-                          "'arguments': { '%s': %s } }",
-                          parameter, value);
-    rsp = qtest_qmp(who, cmd);
-    g_free(cmd);
+    rsp = qtest_qmp(who,
+                    "{ 'execute': 'migrate-set-parameters',"
+                    "'arguments': { %s: %lld } }",
+                    parameter, value);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
     migrate_check_parameter(who, parameter, value);
@@ -366,18 +360,16 @@ static void migrate_recover(QTestState *who, const char *uri)
 }
 
 static void migrate_set_capability(QTestState *who, const char *capability,
-                                   const char *value)
+                                   bool value)
 {
     QDict *rsp;
-    gchar *cmd;
 
-    cmd = g_strdup_printf("{ 'execute': 'migrate-set-capabilities',"
-                          "'arguments': { "
-                          "'capabilities': [ { "
-                          "'capability': '%s', 'state': %s } ] } }",
-                          capability, value);
-    rsp = qtest_qmp(who, cmd);
-    g_free(cmd);
+    rsp = qtest_qmp(who,
+                    "{ 'execute': 'migrate-set-capabilities',"
+                    "'arguments': { "
+                    "'capabilities': [ { "
+                    "'capability': %s, 'state': %i } ] } }",
+                    capability, value);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 }
@@ -521,29 +513,21 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
 static void deprecated_set_downtime(QTestState *who, const double value)
 {
     QDict *rsp;
-    char *expected;
-    int64_t result_int;
 
     rsp = qtest_qmp(who,
                     "{ 'execute': 'migrate_set_downtime',"
                     " 'arguments': { 'value': %f } }", value);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
-    result_int = value * 1000L;
-    expected = g_strdup_printf("%" PRId64, result_int);
-    migrate_check_parameter(who, "downtime-limit", expected);
-    g_free(expected);
+    migrate_check_parameter(who, "downtime-limit", value * 1000);
 }
 
-static void deprecated_set_speed(QTestState *who, const char *value)
+static void deprecated_set_speed(QTestState *who, long long value)
 {
     QDict *rsp;
-    gchar *cmd;
 
-    cmd = g_strdup_printf("{ 'execute': 'migrate_set_speed',"
-                          "'arguments': { 'value': %s } }", value);
-    rsp = qtest_qmp(who, cmd);
-    g_free(cmd);
+    rsp = qtest_qmp(who, "{ 'execute': 'migrate_set_speed',"
+                          "'arguments': { 'value': %lld } }", value);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
     migrate_check_parameter(who, "max-bandwidth", value);
@@ -556,7 +540,7 @@ static void test_deprecated(void)
     from = qtest_start("");
 
     deprecated_set_downtime(from, 0.12345);
-    deprecated_set_speed(from, "12345");
+    deprecated_set_speed(from, 12345);
 
     qtest_quit(from);
 }
@@ -572,16 +556,16 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
         return -1;
     }
 
-    migrate_set_capability(from, "postcopy-ram", "true");
-    migrate_set_capability(to, "postcopy-ram", "true");
-    migrate_set_capability(to, "postcopy-blocktime", "true");
+    migrate_set_capability(from, "postcopy-ram", true);
+    migrate_set_capability(to, "postcopy-ram", true);
+    migrate_set_capability(to, "postcopy-blocktime", true);
 
     /* We want to pick a speed slow enough that the test completes
      * quickly, but that it doesn't complete precopy even on a slow
      * machine, so also set the downtime.
      */
-    migrate_set_parameter(from, "max-bandwidth", "100000000");
-    migrate_set_parameter(from, "downtime-limit", "1");
+    migrate_set_parameter(from, "max-bandwidth", 100000000);
+    migrate_set_parameter(from, "downtime-limit", 1);
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -632,7 +616,7 @@ static void test_postcopy_recovery(void)
     }
 
     /* Turn postcopy speed down, 4K/s is slow enough on any machines */
-    migrate_set_parameter(from, "max-postcopy-bandwidth", "4096");
+    migrate_set_parameter(from, "max-postcopy-bandwidth", 4096);
 
     /* Now we start the postcopy */
     migrate_postcopy_start(from, to);
@@ -673,7 +657,7 @@ static void test_postcopy_recovery(void)
     g_free(uri);
 
     /* Restore the postcopy bandwidth to unlimited */
-    migrate_set_parameter(from, "max-postcopy-bandwidth", "0");
+    migrate_set_parameter(from, "max-postcopy-bandwidth", 0);
 
     migrate_postcopy_complete(from, to);
 }
@@ -719,9 +703,9 @@ static void test_precopy_unix(void)
      * machine, so also set the downtime.
      */
     /* 1 ms should make it not converge*/
-    migrate_set_parameter(from, "downtime-limit", "1");
+    migrate_set_parameter(from, "downtime-limit", 1);
     /* 1GB/s */
-    migrate_set_parameter(from, "max-bandwidth", "1000000000");
+    migrate_set_parameter(from, "max-bandwidth", 1000000000);
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -731,7 +715,7 @@ static void test_precopy_unix(void)
     wait_for_migration_pass(from);
 
     /* 300 ms should converge */
-    migrate_set_parameter(from, "downtime-limit", "300");
+    migrate_set_parameter(from, "downtime-limit", 300);
 
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
-- 
2.17.1
