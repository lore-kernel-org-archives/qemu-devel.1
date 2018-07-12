Received: from eggs.gnu.org ([2001:4830:134:3::10]:47867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWO-00077Y-1I
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWM-0006r0-B4
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdZWM-0006qS-57
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB594C12AD
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:12:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 12 Jul 2018 13:12:17 +0200
Message-Id: <20180712111221.20326-17-armbru@redhat.com>
In-Reply-To: <20180712111221.20326-1-armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 16/20] migration-test: Make wait_command() cope
 with '%'
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
---
 tests/migration-test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 267342fd3e..55f9d006ec 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -156,9 +156,15 @@ static void stop_cb(void *opaque, const char *name, QDict *data)
 /*
  * Events can get in the way of responses we are actually waiting for.
  */
-static QDict *wait_command(QTestState *who, const char *command)
+GCC_FMT_ATTR(2, 3)
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
