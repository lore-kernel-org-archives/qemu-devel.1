Received: from eggs.gnu.org ([2001:4830:134:3::10]:52984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4X-0001RW-7S
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4V-0007Dk-8b
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4V-0007D6-4a
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:42 +0200
Message-Id: <20180703085358.13941-17-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/32] tests/qmp-test: Demonstrate QMP
 errors jumping the queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

When OOB is enabled, out-of-band commands are executed right away,
everything else is queued.  This lets out-of-band commands "jump the
queue".

However, certain errors are always reported right away, and therefore
can jump the queue even when the erroneous input does not request
out-of-band execution.  These errors are pretty unlikely to occur in
production, but it's wrong all the same.  Mark FIXME.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 monitor.c        | 1 +
 tests/qmp-test.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/monitor.c b/monitor.c
index 51ba1485ad..28fa9b8d44 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4338,6 +4338,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     return;
 
 err:
+    /* FIXME overtakes queued in-band commands, wrong when !qmp_is_oob() */
     monitor_qmp_respond(mon, NULL, err, NULL);
     qobject_unref(req);
 }
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 3f4e43bd2b..6581d1d755 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -242,6 +242,13 @@ static void test_qmp_oob(void)
     unblock_blocked_cmd();
     recv_cmd_id(qts, "ib-blocks-1");
     recv_cmd_id(qts, "ib-quick-1");
+
+    /* FIXME certain in-band errors overtake slow in-band command */
+    send_cmd_that_blocks(qts, "blocks-2");
+    qtest_async_qmp(qts, "{ 'id': 'err-2' }");
+    recv_cmd_id(qts, NULL);
+    unblock_blocked_cmd();
+    recv_cmd_id(qts, "blocks-2");
     cleanup_blocking_cmd();
 
     qtest_quit(qts);
-- 
2.17.1
