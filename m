Received: from eggs.gnu.org ([2001:4830:134:3::10]:42239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RY-000684-Ar
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RV-0000FA-V9
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fj4RV-0000Ei-RW
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jul 2018 17:13:52 +0200
Message-Id: <20180727151359.29061-17-armbru@redhat.com>
In-Reply-To: <20180727151359.29061-1-armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/23] migration-test: Make wait_command()
 cope with '%'
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

wait_command() passes its argument @command to qtest_qmp_send().
Falls apart if @command contain '%'.  Two ways to disarm this trap:
suppress interpretation of '%' by passing @command as argument to
format string "%s", or fix it by having wait_command() take the
variable arguments to go with @command.  Do the latter.

This is another step towards compile-time format string checking
without triggering -Wformat-nonliteral.

Cc: Juan Quintela <quintela@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 860b8aa0b9..0c92f2b1cd 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -156,9 +156,14 @@ static void stop_cb(void *opaque, const char *name, QDict *data)
 /*
  * Events can get in the way of responses we are actually waiting for.
  */
-static QDict *wait_command(QTestState *who, const char *command)
+static QDict *wait_command(QTestState *who, const char *command, ...)
 {
-    qtest_qmp_send(who, command);
+    va_list ap;
+
+    va_start(ap, command);
+    qtest_qmp_vsend(who, command, ap);
+    va_end(ap);
+
     return qtest_qmp_receive_success(who, stop_cb, NULL);
 }
 
-- 
2.17.1
