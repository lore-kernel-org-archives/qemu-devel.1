Received: from eggs.gnu.org ([2001:4830:134:3::10]:39097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJtu-0000Xy-V7
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJts-0000Gi-A0
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJts-0000ER-43
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:12 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:06:01 +0800
Message-Id: <20171116130610.23582-19-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 18/27] monitor: send event when request queue
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
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Set maximum QMP request queue length to 8.  If queue full, instead of
queue the command, we directly return a "request-dropped" event, telling
client that specific command is dropped.

Note that this flow control mechanism is only valid if OOB is enabled.
If it's not, the effective queue length will always be 1, which strictly
follows original behavior of QMP command handling (which never drop
messages).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/monitor.c b/monitor.c
index 0e2ff114cc..92e846e195 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4029,6 +4029,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
     }
 }
 
+#define  QMP_REQ_QUEUE_LEN_MAX  (8)
+
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
                                void *opaque)
 {
@@ -4061,6 +4063,19 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
     req_obj->id = id;
     req_obj->req = req;
 
+    if (qmp_oob_enabled(mon)) {
+        /* Drop the request if queue is full. */
+        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
+            qapi_event_send_request_dropped(id,
+                                            REQUEST_DROP_REASON_QUEUE_FULL,
+                                            NULL);
+            qobject_decref(id);
+            qobject_decref(req);
+            g_free(req_obj);
+            return;
+        }
+    }
+
     /*
      * Put the request to the end of queue so that requests will be
      * handled in time order.  Ownership for req_obj, req, id,
-- 
2.13.6
