Received: from eggs.gnu.org ([2001:4830:134:3::10]:60390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw0L-0002Rg-9h
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw0F-0002sD-Ny
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fpw0C-0002o6-Ue
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70A954023461
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 13:38:19 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 15 Aug 2018 21:37:38 +0800
Message-Id: <20180815133747.25032-5-peterx@redhat.com>
In-Reply-To: <20180815133747.25032-1-peterx@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 04/13] monitor: move need_resume flag into
 monitor struct
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

It was put into the request object to show whether we'll need to resume
the monitor after dispatching the command.  Now we move that into the
monitor struct so that it might be even used in other places in the
future, e.g., out-of-band message flow controls.

One thing to mention is that there is no lock needed before when
accessing the flag since the request object will always be owned by a
single thread.  After we move it into monitor struct we need to protect
that flag since it might be accessed by multiple threads now.  Renaming
the qmp_queue_lock into qmp_lock to protect the flag as well.

No functional change.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 72 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/monitor.c b/monitor.c
index 3fb480d94b..d31de95141 100644
--- a/monitor.c
+++ b/monitor.c
@@ -177,14 +177,20 @@ typedef struct {
     bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
     bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
     /*
-     * Protects qmp request/response queue.
+     * Protects qmp request/response queue, and need_resume flag.
      * Take monitor_lock first when you need both.
      */
-    QemuMutex qmp_queue_lock;
+    QemuMutex qmp_lock;
     /* Input queue that holds all the parsed QMP requests */
     GQueue *qmp_requests;
     /* Output queue contains all the QMP responses in order */
     GQueue *qmp_responses;
+    /*
+     * Whether we need to resume the monitor afterward.  This flag is
+     * used to emulate the old QMP server behavior that the current
+     * command must be completed before execution of the next one.
+     */
+    bool need_resume;
 } MonitorQMP;
 
 /*
@@ -262,12 +268,6 @@ struct QMPRequest {
      */
     QObject *req;
     Error *err;
-    /*
-     * Whether we need to resume the monitor afterward.  This flag is
-     * used to emulate the old QMP server behavior that the current
-     * command must be completed before execution of the next one.
-     */
-    bool need_resume;
 };
 typedef struct QMPRequest QMPRequest;
 
@@ -368,7 +368,7 @@ static void qmp_request_free(QMPRequest *req)
     g_free(req);
 }
 
-/* Caller must hold mon->qmp.qmp_queue_lock */
+/* Caller must hold mon->qmp.qmp_lock */
 static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
 {
     while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
@@ -376,7 +376,7 @@ static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
     }
 }
 
-/* Caller must hold the mon->qmp.qmp_queue_lock */
+/* Caller must hold the mon->qmp.qmp_lock */
 static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
 {
     while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
@@ -386,12 +386,23 @@ static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
 
 static void monitor_qmp_cleanup_queues(Monitor *mon)
 {
-    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_lock(&mon->qmp.qmp_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
     monitor_qmp_cleanup_resp_queue_locked(mon);
-    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_unlock(&mon->qmp.qmp_lock);
 }
 
+/* Try to resume the monitor if it was suspended due to any reason */
+static void monitor_qmp_try_resume(Monitor *mon)
+{
+    assert(monitor_is_qmp(mon));
+    qemu_mutex_lock(&mon->qmp.qmp_lock);
+    if (mon->qmp.need_resume) {
+        monitor_resume(mon);
+        mon->qmp.need_resume = false;
+    }
+    qemu_mutex_unlock(&mon->qmp.qmp_lock);
+}
 
 static void monitor_flush_locked(Monitor *mon);
 
@@ -526,9 +537,9 @@ static void qmp_queue_response(Monitor *mon, QDict *rsp)
          * Push a reference to the response queue.  The I/O thread
          * drains that queue and emits.
          */
-        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+        qemu_mutex_lock(&mon->qmp.qmp_lock);
         g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(rsp));
-        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+        qemu_mutex_unlock(&mon->qmp.qmp_lock);
         qemu_bh_schedule(qmp_respond_bh);
     } else {
         /*
@@ -549,9 +560,9 @@ static QDict *monitor_qmp_response_pop_one(Monitor *mon)
 {
     QDict *data;
 
-    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_lock(&mon->qmp.qmp_lock);
     data = g_queue_pop_head(mon->qmp.qmp_responses);
-    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_unlock(&mon->qmp.qmp_lock);
 
     return data;
 }
@@ -812,7 +823,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
 {
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->mon_lock);
-    qemu_mutex_init(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_init(&mon->qmp.qmp_lock);
     mon->outbuf = qstring_new();
     /* Use *mon_cmds by default. */
     mon->cmd_table = mon_cmds;
@@ -832,7 +843,7 @@ static void monitor_data_destroy(Monitor *mon)
     readline_free(mon->rs);
     qobject_unref(mon->outbuf);
     qemu_mutex_destroy(&mon->mon_lock);
-    qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_destroy(&mon->qmp.qmp_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
     monitor_qmp_cleanup_resp_queue_locked(mon);
     g_queue_free(mon->qmp.qmp_requests);
@@ -4191,9 +4202,9 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
     qemu_mutex_lock(&monitor_lock);
 
     QTAILQ_FOREACH(mon, &mon_list, entry) {
-        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+        qemu_mutex_lock(&mon->qmp.qmp_lock);
         req_obj = g_queue_pop_head(mon->qmp.qmp_requests);
-        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+        qemu_mutex_unlock(&mon->qmp.qmp_lock);
         if (req_obj) {
             break;
         }
@@ -4216,27 +4227,27 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
 static void monitor_qmp_bh_dispatcher(void *data)
 {
     QMPRequest *req_obj = monitor_qmp_requests_pop_any();
+    Monitor *mon;
     QDict *rsp;
 
     if (!req_obj) {
         return;
     }
 
+    mon = req_obj->mon;
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
 
-    if (req_obj->need_resume) {
-        /* Pairs with the monitor_suspend() in handle_qmp_command() */
-        monitor_resume(req_obj->mon);
-    }
+    monitor_qmp_try_resume(mon);
+
     qmp_request_free(req_obj);
 
     /* Reschedule instead of looping so the main loop stays responsive */
@@ -4285,10 +4296,9 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     req_obj->id = id;
     req_obj->req = req;
     req_obj->err = err;
-    req_obj->need_resume = false;
 
     /* Protect qmp_requests and fetching its length. */
-    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_lock(&mon->qmp.qmp_lock);
 
     /*
      * If OOB is not enabled on the current monitor, we'll emulate the
@@ -4298,11 +4308,11 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
      */
     if (!qmp_oob_enabled(mon)) {
         monitor_suspend(mon);
-        req_obj->need_resume = true;
+        mon->qmp.need_resume = true;
     } else {
         /* Drop the request if queue is full. */
         if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
-            qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+            qemu_mutex_unlock(&mon->qmp.qmp_lock);
             /*
              * FIXME @id's scope is just @mon, and broadcasting it is
              * wrong.  If another monitor's client has a command with
@@ -4322,7 +4332,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
      * etc. will be delivered to the handler side.
      */
     g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
-    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+    qemu_mutex_unlock(&mon->qmp.qmp_lock);
 
     /* Kick the dispatcher routine */
     qemu_bh_schedule(qmp_dispatcher_bh);
-- 
2.17.1
