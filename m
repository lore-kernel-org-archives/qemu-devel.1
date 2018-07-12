Received: from eggs.gnu.org ([2001:4830:134:3::10]:47883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWO-000788-Pz
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWM-0006rE-Cz
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdZWM-0006qQ-4u
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA5C4406DE36
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:12:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 12 Jul 2018 13:12:19 +0200
Message-Id: <20180712111221.20326-19-armbru@redhat.com>
In-Reply-To: <20180712111221.20326-1-armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 18/20] migration-test: Clean up string
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
Cc: Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

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
---
 tests/migration-test.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 66a4cd2395..4a4db88b61 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -14,6 +14,7 @@
 
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
@@ -381,16 +382,19 @@ static void migrate_set_capability(QTestState *who, const char *capability,
     qobject_unref(rsp);
 }
 
-static void migrate(QTestState *who, const char *uri, const char *extra)
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
@@ -582,7 +586,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate(from, uri, NULL);
+    migrate(from, uri, "{}");
     g_free(uri);
 
     wait_for_migration_pass(from);
@@ -665,7 +669,7 @@ static void test_postcopy_recovery(void)
      * the newly created channel
      */
     wait_for_migration_status(from, "postcopy-paused");
-    migrate(from, uri, ", 'resume': true");
+    migrate(from, uri, "{'resume': true}");
     g_free(uri);
 
     /* Restore the postcopy bandwidth to unlimited */
@@ -684,7 +688,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:0:0", true)) {
         return;
     }
-    migrate(from, "tcp:0:0", NULL);
+    migrate(from, "tcp:0:0", "{}");
     do {
         status = migrate_query_status(from);
         g_assert(!strcmp(status, "setup") || !(strcmp(status, "failed")));
@@ -722,7 +726,7 @@ static void test_precopy_unix(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate(from, uri, NULL);
+    migrate(from, uri, "{}");
 
     wait_for_migration_pass(from);
 
-- 
2.17.1
