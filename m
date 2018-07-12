Received: from eggs.gnu.org ([2001:4830:134:3::10]:47871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWO-00077h-6H
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWM-0006r6-CP
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdZWM-0006qT-4w
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C06AB400ADC2
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:12:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 12 Jul 2018 13:12:18 +0200
Message-Id: <20180712111221.20326-18-armbru@redhat.com>
In-Reply-To: <20180712111221.20326-1-armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 17/20] migration-test: Clean up string
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
Cc: Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

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
---
 tests/migration-test.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 55f9d006ec..66a4cd2395 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -355,13 +355,12 @@ static void migrate_pause(QTestState *who)
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
