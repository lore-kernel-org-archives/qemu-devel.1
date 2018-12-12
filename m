Received: from eggs.gnu.org ([2001:4830:134:3::10]:49074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Uh-0000vE-CD
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Uf-0003Q3-TP
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gX1Uf-0003PD-Ji
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB6EE315484F
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:11:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Dec 2018 11:11:42 +0100
Message-Id: <20181212101145.3496-9-armbru@redhat.com>
In-Reply-To: <20181212101145.3496-1-armbru@redhat.com>
References: <20181212101145.3496-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/11] monitor: Suspend monitor instead dropping
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

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

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20181009062718.1914-2-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
@@ -130,8 +130,9 @@ to pass "id" with out-of-band commands.  Passing it w=
ith all commands
 is recommended for clients that accept capability "oob".
=20
 If the client sends in-band commands faster than the server can
-execute them, the server will eventually drop commands to limit the
-queue length.  The sever sends event COMMAND_DROPPED then.
+execute them, the server will stop reading the requests from the QMP
+channel until the request queue length is reduced to an acceptable
+range.
=20
 Only a few commands support out-of-band execution.  The ones that do
 have "allow-oob": true in output of query-qmp-schema.
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 6fd2c53b09..0c0a37d8cb 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -15,6 +15,8 @@ extern __thread Monitor *cur_mon;
 #define MONITOR_USE_PRETTY    0x08
 #define MONITOR_USE_OOB       0x10
=20
+#define QMP_REQ_QUEUE_LEN_MAX 8
+
 bool monitor_cur_is_qmp(void);
=20
 void monitor_init_globals(void);
diff --git a/monitor.c b/monitor.c
index 5ce2c58b76..d2529260ed 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4110,8 +4110,12 @@ static void monitor_qmp_dispatch(Monitor *mon, QOb=
ject *req, QObject *id)
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
     QMPRequest *req_obj =3D NULL;
     Monitor *mon;
@@ -4121,10 +4125,11 @@ static QMPRequest *monitor_qmp_requests_pop_any(v=
oid)
     QTAILQ_FOREACH(mon, &mon_list, entry) {
         qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
         req_obj =3D g_queue_pop_head(mon->qmp.qmp_requests);
-        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
         if (req_obj) {
+            /* With the lock of corresponding queue held */
             break;
         }
+        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
     }
=20
     if (req_obj) {
@@ -4143,30 +4148,34 @@ static QMPRequest *monitor_qmp_requests_pop_any(v=
oid)
=20
 static void monitor_qmp_bh_dispatcher(void *data)
 {
-    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any();
+    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock();
     QDict *rsp;
     bool need_resume;
+    Monitor *mon;
=20
     if (!req_obj) {
         return;
     }
=20
+    mon =3D req_obj->mon;
     /*  qmp_oob_enabled() might change after "qmp_capabilities" */
-    need_resume =3D !qmp_oob_enabled(req_obj->mon);
+    need_resume =3D !qmp_oob_enabled(mon) ||
+        mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
+    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
     if (req_obj->req) {
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?=
: "");
-        monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id);
+        monitor_qmp_dispatch(mon, req_obj->req, req_obj->id);
     } else {
         assert(req_obj->err);
         rsp =3D qmp_error_response(req_obj->err);
         req_obj->err =3D NULL;
-        monitor_qmp_respond(req_obj->mon, rsp, NULL);
+        monitor_qmp_respond(mon, rsp, NULL);
         qobject_unref(rsp);
     }
=20
     if (need_resume) {
         /* Pairs with the monitor_suspend() in handle_qmp_command() */
-        monitor_resume(req_obj->mon);
+        monitor_resume(mon);
     }
     qmp_request_free(req_obj);
=20
@@ -4174,8 +4183,6 @@ static void monitor_qmp_bh_dispatcher(void *data)
     qemu_bh_schedule(qmp_dispatcher_bh);
 }
=20
-#define  QMP_REQ_QUEUE_LEN_MAX  (8)
-
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
     Monitor *mon =3D opaque;
@@ -4217,28 +4224,14 @@ static void handle_qmp_command(void *opaque, QObj=
ect *req, Error *err)
     qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
=20
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
+        mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1) =
{
         monitor_suspend(mon);
-    } else {
-        /* Drop the request if queue is full. */
-        if (mon->qmp.qmp_requests->length >=3D QMP_REQ_QUEUE_LEN_MAX) {
-            qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
-            /*
-             * FIXME @id's scope is just @mon, and broadcasting it is
-             * wrong.  If another monitor's client has a command with
-             * the same ID in flight, the event will incorrectly claim
-             * that command was dropped.
-             */
-            qapi_event_send_command_dropped(id,
-                                            COMMAND_DROP_REASON_QUEUE_FU=
LL);
-            qmp_request_free(req_obj);
-            return;
-        }
     }
=20
     /*
@@ -4246,6 +4239,7 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
      * handled in time order.  Ownership for req_obj, req, id,
      * etc. will be delivered to the handler side.
      */
+    assert(mon->qmp.qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
     g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
     qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
=20
diff --git a/qapi/misc.json b/qapi/misc.json
index 45121492dd..4211a732f3 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3444,46 +3444,6 @@
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
=20
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
--=20
2.17.2
