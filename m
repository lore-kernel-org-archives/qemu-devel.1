Received: from eggs.gnu.org ([2001:4830:134:3::10]:50272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxt-00083J-Pj
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxq-00067R-Jd
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSxq-00066J-Bx
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB492C326
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 970D22166BA9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:35:28 +0200
Message-Id: <20180703213556.20619-5-armbru@redhat.com>
In-Reply-To: <20180703213556.20619-1-armbru@redhat.com>
References: <20180703213556.20619-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 04/32] qmp: Document COMMAND_DROPPED design
 flaw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Events are broadcast to all monitors.  If another monitor's client has
a command with the same ID in flight, the event will incorrectly claim
that command was dropped.  This must be fixed before out-of-band
execution can graduate from "experimental".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-5-armbru@redhat.com>
---
 monitor.c      | 6 ++++++
 qapi/misc.json | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/monitor.c b/monitor.c
index 4f4f309d45..3ad89fe1ba 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4331,6 +4331,12 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
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
