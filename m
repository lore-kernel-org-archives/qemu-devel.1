Received: from eggs.gnu.org ([2001:4830:134:3::10]:41921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDuN-0008Pr-6W
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDuM-00005T-Aw
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euDuM-00005C-51
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:46 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 16:59:59 +0800
Message-Id: <20180309090006.10018-17-peterx@redhat.com>
In-Reply-To: <20180309090006.10018-1-peterx@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 16/23] monitor: send event when command
 queue full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Set maximum QMP command queue length to 8.  If queue full, instead of
queue the command, we directly return a "command-dropped" event, telling
client that specific command is dropped.

Note that this flow control mechanism is only valid if OOB is enabled.
If it's not, the effective queue length will always be 1, which strictly
follows original behavior of QMP command handling (which never drop
messages).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 5104e5db07..4d57a8d341 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4007,6 +4007,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
     }
 }
 
+#define  QMP_REQ_QUEUE_LEN_MAX  (8)
+
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 {
     QObject *req, *id = NULL;
@@ -4040,6 +4042,9 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     req_obj->req = req;
     req_obj->need_resume = false;
 
+    /* Protect qmp_requests and fetching its length. */
+    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+
     /*
      * If OOB is not enabled on current monitor, we'll emulate the old
      * behavior that we won't process current monitor any more until
@@ -4049,6 +4054,18 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     if (!qmp_oob_enabled(mon)) {
         monitor_suspend(mon);
         req_obj->need_resume = true;
+    } else {
+        /* Drop the request if queue is full. */
+        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
+            qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+            qapi_event_send_command_dropped(id,
+                                            COMMAND_DROP_REASON_QUEUE_FULL,
+                                            NULL);
+            qobject_decref(id);
+            qobject_decref(req);
+            g_free(req_obj);
+            return;
+        }
     }
 
     /*
@@ -4056,7 +4073,6 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
      * handled in time order.  Ownership for req_obj, req, id,
      * etc. will be delivered to the handler side.
      */
-    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
     g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
     qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
 
-- 
2.14.3
