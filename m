Received: from eggs.gnu.org ([2001:4830:134:3::10]:39424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cL-0003P6-Lj
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cI-0004XS-Ac
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk3cI-0004Wh-0c
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:22 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 30 Jul 2018 10:33:11 +0200
Message-Id: <20180730083317.11765-18-armbru@redhat.com>
In-Reply-To: <20180730083317.11765-1-armbru@redhat.com>
References: <20180730083317.11765-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 17/23] migration-test: Clean up string
 interpolation into QMP, part 1
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

migrate_recover() builds QMP input manually because wait_command()
can't interpolate.  Well, it can since the previous commit.  Simplify
accordingly.

Bonus: gets rid of a non-literal format string.  A step towards
compile-time format string checking without triggering
-Wformat-nonliteral.

Cc: Juan Quintela <quintela@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/migration-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 0c92f2b1cd..323bb60535 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -156,6 +156,7 @@ static void stop_cb(void *opaque, const char *name, QDict *data)
 /*
  * Events can get in the way of responses we are actually waiting for.
  */
+GCC_FMT_ATTR(2, 3)
 static QDict *wait_command(QTestState *who, const char *command, ...)
 {
     va_list ap;
@@ -354,13 +355,12 @@ static void migrate_pause(QTestState *who)
 static void migrate_recover(QTestState *who, const char *uri)
 {
     QDict *rsp;
-    gchar *cmd = g_strdup_printf(
-        "{ 'execute': 'migrate-recover', "
-        "  'id': 'recover-cmd', "
-        "  'arguments': { 'uri': '%s' } }", uri);
 
-    rsp = wait_command(who, cmd);
-    g_free(cmd);
+    rsp = wait_command(who,
+                       "{ 'execute': 'migrate-recover', "
+                       "  'id': 'recover-cmd', "
+                       "  'arguments': { 'uri': %s } }",
+                       uri);
     qobject_unref(rsp);
 }
 
-- 
2.17.1
