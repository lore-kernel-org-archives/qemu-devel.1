Received: from eggs.gnu.org ([2001:4830:134:3::10]:49258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcO-0007Ue-KQ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcN-0004z0-4N
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcM-0004ys-PG
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60BD4401DEA6
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 14:30:30 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:10 -0500
Message-Id: <20180327143014.1767669-11-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/14] qmp: cleanup qmp queues properly
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

Marc-Andr=C3=A9 Lureau reported that we can have this happen:

1. client1 connects, send command C1
2. client1 disconnects before getting response for C1
3. client2 connects, who might receive response of C1

However client2 should not receive remaining responses for client1.

Basically, we should clean up the request/response queue elements when:

- after a session is closed
- before destroying the queues

Some helpers are introduced to achieve that.  We need to make sure we're
with the lock when operating on those queues.  This also needed the
declaration of QMPRequest moved earlier.

Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180326063901.27425-3-peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[eblake: drop pointless qmp_response_free(), drop queue flush on connect
since a clean queue on disconnect is sufficient]
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++-----------=
------
 1 file changed, 52 insertions(+), 19 deletions(-)

diff --git a/monitor.c b/monitor.c
index 3b1ef34711b..32d6114ac3a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -234,6 +234,22 @@ static struct {
     QEMUBH *qmp_respond_bh;
 } mon_global;

+struct QMPRequest {
+    /* Owner of the request */
+    Monitor *mon;
+    /* "id" field of the request */
+    QObject *id;
+    /* Request object to be handled */
+    QObject *req;
+    /*
+     * Whether we need to resume the monitor afterward.  This flag is
+     * used to emulate the old QMP server behavior that the current
+     * command must be completed before execution of the next one.
+     */
+    bool need_resume;
+};
+typedef struct QMPRequest QMPRequest;
+
 /* QMP checker flags */
 #define QMP_ACCEPT_UNKNOWNS 1

@@ -310,6 +326,38 @@ int monitor_read_password(Monitor *mon, ReadLineFunc=
 *readline_func,
     }
 }

+static void qmp_request_free(QMPRequest *req)
+{
+    qobject_decref(req->id);
+    qobject_decref(req->req);
+    g_free(req);
+}
+
+/* Must with the mon->qmp.qmp_queue_lock held */
+static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
+{
+    while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
+        qmp_request_free(g_queue_pop_head(mon->qmp.qmp_requests));
+    }
+}
+
+/* Must with the mon->qmp.qmp_queue_lock held */
+static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
+{
+    while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
+        qobject_decref(g_queue_pop_head(mon->qmp.qmp_responses));
+    }
+}
+
+static void monitor_qmp_cleanup_queues(Monitor *mon)
+{
+    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(mon);
+    monitor_qmp_cleanup_resp_queue_locked(mon);
+    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+}
+
+
 static void monitor_flush_locked(Monitor *mon);

 static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
@@ -701,6 +749,8 @@ static void monitor_data_destroy(Monitor *mon)
     QDECREF(mon->outbuf);
     qemu_mutex_destroy(&mon->out_lock);
     qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(mon);
+    monitor_qmp_cleanup_resp_queue_locked(mon);
     g_queue_free(mon->qmp.qmp_requests);
     g_queue_free(mon->qmp.qmp_responses);
 }
@@ -4009,22 +4059,6 @@ static void monitor_qmp_respond(Monitor *mon, QObj=
ect *rsp,
     qobject_decref(rsp);
 }

-struct QMPRequest {
-    /* Owner of the request */
-    Monitor *mon;
-    /* "id" field of the request */
-    QObject *id;
-    /* Request object to be handled */
-    QObject *req;
-    /*
-     * Whether we need to resume the monitor afterward.  This flag is
-     * used to emulate the old QMP server behavior that the current
-     * command must be completed before execution of the next one.
-     */
-    bool need_resume;
-};
-typedef struct QMPRequest QMPRequest;
-
 /*
  * Dispatch one single QMP request. The function will free the req_obj
  * and objects inside it before return.
@@ -4191,9 +4225,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
             qapi_event_send_command_dropped(id,
                                             COMMAND_DROP_REASON_QUEUE_FU=
LL,
                                             &error_abort);
-            qobject_decref(id);
-            qobject_decref(req);
-            g_free(req_obj);
+            qmp_request_free(req_obj);
             return;
         }
     }
@@ -4335,6 +4367,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
         mon_refcount++;
         break;
     case CHR_EVENT_CLOSED:
+        monitor_qmp_cleanup_queues(mon);
         json_message_parser_destroy(&mon->qmp.parser);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
         mon_refcount--;
--=20
2.14.3
