Received: from eggs.gnu.org ([2001:4830:134:3::10]:45420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJc-0000rr-2h
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJb-00063K-0H
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33612 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJa-000635-Qw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FEF9814F0D2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:18 -0500
Message-Id: <20180312183628.394722-28-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 27/36] monitor: send event when command queue
 full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Peter Xu <peterx@redhat.com>

Set maximum QMP command queue length to 8.  If the queue is full,
instead of queuing the command, we directly return a "command-dropped"
event, telling the client that a specific command is dropped.

Note that this flow control mechanism is only valid if OOB is enabled.
If it's not, the effective queue length will always be 1, which strictly
follows original behavior of QMP command handling (which never drops
messages).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-17-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: commit message grammar, abort on failure to send event]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 07446d6b879..d28457d60d7 100644
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
      * If OOB is not enabled on the current monitor, we'll emulate the
      * old behavior that we won't process the current monitor any more
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
+                                            &error_abort);
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
