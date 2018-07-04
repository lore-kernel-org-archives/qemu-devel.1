Received: from eggs.gnu.org ([2001:4830:134:3::10]:46334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadPp-0001OK-4E
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadPn-0005rL-Rf
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40454 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fadPn-0005r9-LZ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 318F734698
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 08:45:31 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  4 Jul 2018 16:45:03 +0800
Message-Id: <20180704084507.14560-6-peterx@redhat.com>
In-Reply-To: <20180704084507.14560-1-peterx@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 5/9] monitor: suspend monitor instead of send
 CMD_DROP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

When we received too many qmp commands, previously we'll send
COMMAND_DROPPED events to monitors, then we'll drop the requests.  It
can only solve the flow control of the request queue, however it'll not
really work since we might queue unlimited events in the response queue
which is a potential risk.

Now instead of sending such an event, we stop consuming the client input
when we noticed that the queue is reaching its limitation before hand.
Then after we handled commands, we'll try to resume the monitor when
needed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/monitor.c b/monitor.c
index 215029bc22..ebf862914f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -164,6 +164,8 @@ struct MonFdset {
     QLIST_ENTRY(MonFdset) next;
 };
 
+#define  QMP_REQ_QUEUE_LEN_MAX  (8)
+
 typedef struct {
     JSONMessageParser parser;
     /*
@@ -396,10 +398,21 @@ static void monitor_qmp_try_resume(Monitor *mon)
 {
     assert(monitor_is_qmp(mon));
     qemu_mutex_lock(&mon->qmp.qmp_lock);
+
+    if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
+        /*
+         * This should not happen, but in case if it happens, we
+         * should still keep the monitor in suspend state
+         */
+        qemu_mutex_unlock(&mon->qmp.qmp_lock);
+        return;
+    }
+
     if (mon->qmp.need_resume) {
         monitor_resume(mon);
         mon->qmp.need_resume = false;
     }
+
     qemu_mutex_unlock(&mon->qmp.qmp_lock);
 }
 
@@ -4213,7 +4226,14 @@ static void monitor_qmp_bh_dispatcher(void *data)
     qemu_bh_schedule(qmp_dispatcher_bh);
 }
 
-#define  QMP_REQ_QUEUE_LEN_MAX  (8)
+/* Called with Monitor.qmp.qmp_lock held. */
+static void monitor_qmp_suspend_locked(Monitor *mon)
+{
+    assert(monitor_is_qmp(mon));
+    assert(mon->qmp.need_resume == false);
+    monitor_suspend(mon);
+    mon->qmp.need_resume = true;
+}
 
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 {
@@ -4266,22 +4286,16 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
      * OOB is not enabled, the server will never drop any command.
      */
     if (!qmp_oob_enabled(mon)) {
-        monitor_suspend(mon);
-        mon->qmp.need_resume = true;
+        monitor_qmp_suspend_locked(mon);
     } else {
-        /* Drop the request if queue is full. */
-        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
-            qemu_mutex_unlock(&mon->qmp.qmp_lock);
-            /*
-             * FIXME @id's scope is just @mon, and broadcasting it is
-             * wrong.  If another monitor's client has a command with
-             * the same ID in flight, the event will incorrectly claim
-             * that command was dropped.
-             */
-            qapi_event_send_command_dropped(id,
-                                            COMMAND_DROP_REASON_QUEUE_FULL);
-            qmp_request_free(req_obj);
-            return;
+        /*
+         * If the queue is reaching the length limitation, we queue
+         * this command, meanwhile we suspend the monitor to block new
+         * commands.  We'll resume ourselves until the queue has more
+         * space.
+         */
+        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX - 1) {
+            monitor_qmp_suspend_locked(mon);
         }
     }
 
-- 
2.17.1
