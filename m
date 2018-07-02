Received: from eggs.gnu.org ([2001:4830:134:3::10]:42455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1aq-0004R1-VV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1ap-0006c0-J5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ap-0006bk-Dm
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14E3540250FF
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:21:50 +0200
Message-Id: <20180702162218.13678-5-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 04/32] qmp: Document COMMAND_DROPPED design flaw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

Events are broadcast to all monitors.  If another monitor's client has
a command with the same ID in flight, the event will incorrectly claim
that command was dropped.  This must be fixed before out-of-band
execution can graduate from "experimental".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c      | 6 ++++++
 qapi/misc.json | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/monitor.c b/monitor.c
index 3fb05d50aa..96e87d8664 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4330,6 +4330,12 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         /* Drop the request if queue is full. */
         if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
             qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+            /*
+             * FIXME @id's scope is just @mon, and broadcasting it is
+             * wrong.  If another monitor's client has a command with
+             * the same ID in flight, the event will incorrectly claim
+             * that command was dropped.
+             */
             qapi_event_send_command_dropped(id,
                                             COMMAND_DROP_REASON_QUEUE_FULL,
                                             &error_abort);
diff --git a/qapi/misc.json b/qapi/misc.json
index 0446c3e48e..74cd97f237 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3454,6 +3454,9 @@
 # only be dropped when the oob capability is enabled.
 #
 # @id: The dropped command's "id" field.
+# FIXME Broken by design.  Events are broadcast to all monitors.  If
+# another monitor's client has a command with the same ID in flight,
+# the event will incorrectly claim that command was dropped.
 #
 # @reason: The reason why the command is dropped.
 #
-- 
2.17.1
