Received: from eggs.gnu.org ([2001:4830:134:3::10]:39446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cM-0003P8-4k
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cI-0004Xp-CQ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk3cI-0004Wq-5i
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:22 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 30 Jul 2018 10:33:12 +0200
Message-Id: <20180730083317.11765-19-armbru@redhat.com>
In-Reply-To: <20180730083317.11765-1-armbru@redhat.com>
References: <20180730083317.11765-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 18/23] migration-test: Clean up string
 interpolation into QMP, part 2
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

migrate() interpolates members into a JSON object.  Change it to take
its extra QMP arguments as arguments for qdict_from_jsonf_nofail()
instead of a string containing JSON members.

Bonus: gets rid of a non-literal format string.  A step towards
compile-time format string checking without triggering
-Wformat-nonliteral.

Cc: Juan Quintela <quintela@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/migration-test.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 323bb60535..beccb6337e 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -14,6 +14,7 @@
 
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
@@ -381,16 +382,25 @@ static void migrate_set_capability(QTestState *who, const char *capability,
     qobject_unref(rsp);
 }
 
-static void migrate(QTestState *who, const char *uri, const char *extra)
+/*
+ * Send QMP command "migrate".
+ * Arguments are built from @fmt... (formatted like
+ * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
+ */
+GCC_FMT_ATTR(3, 4)
+static void migrate(QTestState *who, const char *uri, const char *fmt, ...)
 {
-    QDict *rsp;
-    gchar *cmd;
+    va_list ap;
+    QDict *args, *rsp;
 
-    cmd = g_strdup_printf("{ 'execute': 'migrate',"
-                          "  'arguments': { 'uri': '%s' %s } }",
-                          uri, extra ? extra : "");
-    rsp = qtest_qmp(who, cmd);
-    g_free(cmd);
+    va_start(ap, fmt);
+    args = qdict_from_vjsonf_nofail(fmt, ap);
+    va_end(ap);
+
+    g_assert(!qdict_haskey(args, "uri"));
+    qdict_put_str(args, "uri", uri);
+
+    rsp = qmp("{ 'execute': 'migrate', 'arguments': %p}", args);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 }
@@ -582,7 +592,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate(from, uri, NULL);
+    migrate(from, uri, "{}");
     g_free(uri);
 
     wait_for_migration_pass(from);
@@ -665,7 +675,7 @@ static void test_postcopy_recovery(void)
      * the newly created channel
      */
     wait_for_migration_status(from, "postcopy-paused");
-    migrate(from, uri, ", 'resume': true");
+    migrate(from, uri, "{'resume': true}");
     g_free(uri);
 
     /* Restore the postcopy bandwidth to unlimited */
@@ -684,7 +694,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:0:0", true)) {
         return;
     }
-    migrate(from, "tcp:0:0", NULL);
+    migrate(from, "tcp:0:0", "{}");
     do {
         status = migrate_query_status(from);
         g_assert(!strcmp(status, "setup") || !(strcmp(status, "failed")));
@@ -722,7 +732,7 @@ static void test_precopy_unix(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate(from, uri, NULL);
+    migrate(from, uri, "{}");
 
     wait_for_migration_pass(from);
 
-- 
2.17.1
