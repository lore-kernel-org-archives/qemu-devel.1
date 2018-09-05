Received: from eggs.gnu.org ([2001:4830:134:3::10]:37175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxRE2-0006Vx-RB
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxRDz-0006rs-Bs
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:23:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44456 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fxRDy-0006nC-VW
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:23:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 491AC87A72
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 06:23:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Sep 2018 14:23:08 +0800
Message-Id: <20180905062313.4059-2-peterx@redhat.com>
In-Reply-To: <20180905062313.4059-1-peterx@redhat.com>
References: <20180905062313.4059-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 1/6] monitor: Suspend monitor instead
 dropping commands
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

When a QMP client sends in-band commands more quickly that we can
process them, we can either queue them without limit (QUEUE), drop
commands when the queue is full (DROP), or suspend receiving commands
when the queue is full (SUSPEND).  None of them is ideal:

* QUEUE lets a misbehaving client make QEMU eat memory without bounds.
Not such a hot idea.

* With DROP, the client has to cope with dropped in-band commands.  To
inform the client, we send a COMMAND_DROPPED event then.  The event is
flawed by design in two ways: it's ambiguous (see commit d621cfe0a17),
and it brings back the "eat memory without bounds" problem.

* With SUSPEND, the client has to manage the flow of in-band commands to
keep the monitor available for out-of-band commands.

We currently DROP.  Switch to SUSPEND.

Managing the flow of in-band commands to keep the monitor available for
out-of-band commands isn't really hard: just count the number of
"outstanding" in-band commands (commands sent minus replies received),
and if it exceeds the limit, hold back additional ones until it drops
below the limit again.

Note that we need to be careful pairing the suspend with a resume, or
else the monitor will hang, possibly forever.  And here since we need to
make sure both:

     (1) popping request from the req queue, and
     (2) reading length of the req queue

will be in the same critical section, we let the pop function take the
corresponding queue lock when there is a request, then we release the
lock from the caller.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/interop/qmp-spec.txt |  5 ++--
 include/monitor/monitor.h |  2 ++
 monitor.c                 | 52 +++++++++++++++++----------------------
 qapi/misc.json            | 40 ------------------------------
 4 files changed, 28 insertions(+), 71 deletions(-)

diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
index 8f7da0245d..67e44a8120 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -130,8 +130,9 @@ to pass "id" with out-of-band commands.  Passing it with all commands
 is recommended for clients that accept capability "oob".
 
 If the client sends in-band commands faster than the server can
-execute them, the server will eventually drop commands to limit the
-queue length.  The sever sends event COMMAND_DROPPED then.
+execute them, the server will stop reading the requests from the QMP
+channel until the request queue length is reduced to an acceptable
+range.
 
 Only a few commands support out-of-band execution.  The ones that do
 have "allow-oob": true in output of query-qmp-schema.
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 2ef5e04b37..76873c0d40 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -15,6 +15,8 @@ extern __thread Monitor *cur_mon;
 #define MONITOR_USE_PRETTY    0x08
 #define MONITOR_USE_OOB       0x10
 
+#define QMP_REQ_QUEUE_LEN_MAX 8
+
 bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
diff --git a/monitor.c b/monitor.c
index 3b90c9eb5f..a89bb86599 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4090,8 +4090,12 @@ static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
  * processing commands only on a very busy monitor.  To achieve that,
  * when we process one request on a specific monitor, we put that
  * monitor to the end of mon_list queue.
+ *
+ * Note: if the function returned with non-NULL, then the caller will
+ * be with mon->qmp.qmp_queue_lock held, and the caller is responsible
+ * to release it.
  */
-static QMPRequest *monitor_qmp_requests_pop_any(void)
+static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
 {
     QMPRequest *req_obj = NULL;
     Monitor *mon;
@@ -4101,10 +4105,11 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
     QTAILQ_FOREACH(mon, &mon_list, entry) {
         qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
         req_obj = g_queue_pop_head(mon->qmp.qmp_requests);
-        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
         if (req_obj) {
+            /* With the lock of corresponding queue held */
             break;
         }
+        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
     }
 
     if (req_obj) {
@@ -4123,30 +4128,34 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
 
 static void monitor_qmp_bh_dispatcher(void *data)
 {
-    QMPRequest *req_obj = monitor_qmp_requests_pop_any();
+    QMPRequest *req_obj = monitor_qmp_requests_pop_any_with_lock();
     QDict *rsp;
     bool need_resume;
+    Monitor *mon;
 
     if (!req_obj) {
         return;
     }
 
+    mon = req_obj->mon;
     /*  qmp_oob_enabled() might change after "qmp_capabilities" */
-    need_resume = !qmp_oob_enabled(req_obj->mon);
+    need_resume = !qmp_oob_enabled(mon) ||
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
 
@@ -4154,8 +4163,6 @@ static void monitor_qmp_bh_dispatcher(void *data)
     qemu_bh_schedule(qmp_dispatcher_bh);
 }
 
-#define  QMP_REQ_QUEUE_LEN_MAX  (8)
-
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
     Monitor *mon = opaque;
@@ -4197,28 +4204,14 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
     qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
 
     /*
-     * If OOB is not enabled on the current monitor, we'll emulate the
-     * old behavior that we won't process the current monitor any more
-     * until it has responded.  This helps make sure that as long as
-     * OOB is not enabled, the server will never drop any command.
+     * Suspend the monitor when we can't queue more requests after
+     * this one.  Dequeuing in monitor_qmp_bh_dispatcher() will resume
+     * it.  Note that when OOB is disabled, we queue at most one
+     * command, for backward compatibility.
      */
-    if (!qmp_oob_enabled(mon)) {
+    if (!qmp_oob_enabled(mon) ||
+        mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
         monitor_suspend(mon);
-    } else {
-        /* Drop the request if queue is full. */
-        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
-            qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
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
-        }
     }
 
     /*
@@ -4226,6 +4219,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
      * handled in time order.  Ownership for req_obj, req, id,
      * etc. will be delivered to the handler side.
      */
+    assert(mon->qmp.qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
     g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
     qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
 
diff --git a/qapi/misc.json b/qapi/misc.json
index d450cfef21..2c1a6119bf 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3432,46 +3432,6 @@
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
 
-##
-# @CommandDropReason:
-#
-# Reasons that caused one command to be dropped.
-#
-# @queue-full: the command queue is full. This can only occur when
-#              the client sends a new non-oob command before the
-#              response to the previous non-oob command has been
-#              received.
-#
-# Since: 2.12
-##
-{ 'enum': 'CommandDropReason',
-  'data': [ 'queue-full' ] }
-
-##
-# @COMMAND_DROPPED:
-#
-# Emitted when a command is dropped due to some reason.  Commands can
-# only be dropped when the oob capability is enabled.
-#
-# @id: The dropped command's "id" field.
-# FIXME Broken by design.  Events are broadcast to all monitors.  If
-# another monitor's client has a command with the same ID in flight,
-# the event will incorrectly claim that command was dropped.
-#
-# @reason: The reason why the command is dropped.
-#
-# Since: 2.12
-#
-# Example:
-#
-# { "event": "COMMAND_DROPPED",
-#   "data": {"result": {"id": "libvirt-102",
-#                       "reason": "queue-full" } } }
-#
-##
-{ 'event': 'COMMAND_DROPPED' ,
-  'data': { 'id': 'any', 'reason': 'CommandDropReason' } }
-
 ##
 # @set-numa-node:
 #
-- 
2.17.1
