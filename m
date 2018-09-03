Received: from eggs.gnu.org ([2001:4830:134:3::10]:53695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgXJ-0006yZ-C2
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgXI-0000HU-Gm
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fwgXI-0000HA-Bg
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65BF087A6D
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 04:32:23 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  3 Sep 2018 12:31:45 +0800
Message-Id: <20180903043149.4076-4-peterx@redhat.com>
In-Reply-To: <20180903043149.4076-1-peterx@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 3/7] monitor: suspend monitor instead of
 send CMD_DROP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

When we received too many qmp commands, previously we'll send
COMMAND_DROPPED events to monitors, then we'll drop the requests.  Now
instead of dropping the command we stop reading from input when we
notice the queue is getting full.  Note that here since we removed the
need_resume flag we need to be _very_ careful on the suspend/resume
paring on the conditions since unmatched condition checks will hang
death the monitor.  Meanwhile, now we will need to read the queue length
to decide whether we'll need to resume the monitor so we need to take
the queue lock again even after popping from it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/monitor.c b/monitor.c
index 3b90c9eb5f..9e6cad2af6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -89,6 +89,8 @@
 #include "hw/s390x/storage-attributes.h"
 #endif
 
+#define  QMP_REQ_QUEUE_LEN_MAX  (8)
+
 /*
  * Supported types:
  *
@@ -4124,29 +4126,33 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
 static void monitor_qmp_bh_dispatcher(void *data)
 {
     QMPRequest *req_obj = monitor_qmp_requests_pop_any();
+    Monitor *mon;
     QDict *rsp;
     bool need_resume;
 
     if (!req_obj) {
         return;
     }
-
+    mon = req_obj->mon;
     /*  qmp_oob_enabled() might change after "qmp_capabilities" */
-    need_resume = !qmp_oob_enabled(req_obj->mon);
+    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+    need_resume = !qmp_oob_enabled(req_obj->mon) ||
+        mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
+    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
     if (req_obj->req) {
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
-        monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id);
+        monitor_qmp_dispatch(mon, req_obj->req, req_obj->id);
     } else {
         assert(req_obj->err);
         rsp = qmp_error_response(req_obj->err);
         req_obj->err = NULL;
-        monitor_qmp_respond(req_obj->mon, rsp, NULL);
+        monitor_qmp_respond(mon, rsp, NULL);
         qobject_unref(rsp);
     }
 
     if (need_resume) {
         /* Pairs with the monitor_suspend() in handle_qmp_command() */
-        monitor_resume(req_obj->mon);
+        monitor_resume(mon);
     }
     qmp_request_free(req_obj);
 
@@ -4154,8 +4160,6 @@ static void monitor_qmp_bh_dispatcher(void *data)
     qemu_bh_schedule(qmp_dispatcher_bh);
 }
 
-#define  QMP_REQ_QUEUE_LEN_MAX  (8)
-
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
     Monitor *mon = opaque;
@@ -4205,19 +4209,12 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
     if (!qmp_oob_enabled(mon)) {
         monitor_suspend(mon);
     } else {
-        /* Drop the request if queue is full. */
-        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
-            qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+        if (mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
             /*
-             * FIXME @id's scope is just @mon, and broadcasting it is
-             * wrong.  If another monitor's client has a command with
-             * the same ID in flight, the event will incorrectly claim
-             * that command was dropped.
+             * If this is _exactly_ the last request that we can
+             * queue, we suspend the monitor right now.
              */
-            qapi_event_send_command_dropped(id,
-                                            COMMAND_DROP_REASON_QUEUE_FULL);
-            qmp_request_free(req_obj);
-            return;
+            monitor_suspend(mon);
         }
     }
 
-- 
2.17.1
