Received: from eggs.gnu.org ([2001:4830:134:3::10]:34406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMz-0002NP-Tw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMy-0005Lf-7M
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faNMx-0005Kf-VG
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D9FDF8FFA
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A8A02026D76
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 17:37:12 +0200
Message-Id: <20180703153728.2175-17-armbru@redhat.com>
In-Reply-To: <20180703153728.2175-1-armbru@redhat.com>
References: <20180703153728.2175-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 16/32] tests/qmp-test: Demonstrate QMP errors
 jumping the queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Message-Id: <20180703085358.13941-17-armbru@redhat.com>
---
 monitor.c        | 1 +
 tests/qmp-test.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/monitor.c b/monitor.c
index 37ca4e798d..c49214cd8f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4339,6 +4339,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
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
