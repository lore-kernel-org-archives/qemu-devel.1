Received: from eggs.gnu.org ([2001:4830:134:3::10]:36224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAJ-0006ef-FL
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAE-0007K3-F7
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxmAE-0007JY-A6
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:34 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:37 +0800
Message-Id: <20170929033844.26935-16-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 15/22] monitor: send event when request queue
 full
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Set maximum QMP request queue length to 8.  If queue full, instead of
queue the command, we directly return a "request-dropped" event, telling
client that specific command is dropped.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/monitor.c b/monitor.c
index 1e9a6cb6a5..d9bed31248 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3971,6 +3971,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
     }
 }
 
+#define  QMP_ASYNC_QUEUE_LEN_MAX  (8)
+
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
                                void *opaque)
 {
@@ -4002,6 +4004,19 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
     req_obj->id = id;
     req_obj->req = req;
 
+    /* Drop the request if queue is full. */
+    if (mon->qmp_requests->length >= QMP_ASYNC_QUEUE_LEN_MAX) {
+        const char *id_str = qobject_get_try_str(id);
+
+        qapi_event_send_request_dropped(id_str ? id_str : "",
+                                        REQUEST_DROP_REASON_QUEUE_FULL,
+                                        NULL);
+        qobject_decref(id);
+        qobject_decref(req);
+        g_free(req_obj);
+        return;
+    }
+
     /*
      * Put the request to the end of queue so that requests will be
      * handled in time order.  Ownership for req_obj, req, id,
-- 
2.13.5
