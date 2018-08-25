Received: from eggs.gnu.org ([2001:4830:134:3::10]:49420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4Q-0001E9-E6
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4N-00035c-7B
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ftZ4N-00035S-1W
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:39 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Aug 2018 15:57:18 +0200
Message-Id: <20180825135724.8981-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180825135724.8981-1-marcandre.lureau@redhat.com>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/9] Revert "qmp: isolate responses into io
 thread"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This reverts commit abe3cd0ff7f774966da6842620806ab7576fe4f3.

There is no need to add an additional queue to send the reply to the
IOThread, because QMP response is thread safe, and chardev write path
is thread safe. It will schedule the watcher in the associated
IOThread.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 120 ++----------------------------------------------------
 1 file changed, 3 insertions(+), 117 deletions(-)

diff --git a/monitor.c b/monitor.c
index a1db4db487..084900c602 100644
--- a/monitor.c
+++ b/monitor.c
@@ -182,8 +182,6 @@ typedef struct {
     QemuMutex qmp_queue_lock;
     /* Input queue that holds all the parsed QMP requests */
     GQueue *qmp_requests;
-    /* Output queue contains all the QMP responses in order */
-    GQueue *qmp_responses;
 } MonitorQMP;
=20
 /*
@@ -247,9 +245,6 @@ IOThread *mon_iothread;
 /* Bottom half to dispatch the requests received from I/O thread */
 QEMUBH *qmp_dispatcher_bh;
=20
-/* Bottom half to deliver the responses back to clients */
-QEMUBH *qmp_respond_bh;
-
 struct QMPRequest {
     /* Owner of the request */
     Monitor *mon;
@@ -375,19 +370,10 @@ static void monitor_qmp_cleanup_req_queue_locked(Mo=
nitor *mon)
     }
 }
=20
-/* Caller must hold the mon->qmp.qmp_queue_lock */
-static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
-{
-    while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
-        qobject_unref((QDict *)g_queue_pop_head(mon->qmp.qmp_responses))=
;
-    }
-}
-
 static void monitor_qmp_cleanup_queues(Monitor *mon)
 {
     qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
-    monitor_qmp_cleanup_resp_queue_locked(mon);
     qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
 }
=20
@@ -518,85 +504,6 @@ static void qmp_send_response(Monitor *mon, const QD=
ict *rsp)
     qobject_unref(json);
 }
=20
-static void qmp_queue_response(Monitor *mon, QDict *rsp)
-{
-    if (mon->use_io_thread) {
-        /*
-         * Push a reference to the response queue.  The I/O thread
-         * drains that queue and emits.
-         */
-        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
-        g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(rsp));
-        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
-        qemu_bh_schedule(qmp_respond_bh);
-    } else {
-        /*
-         * Not using monitor I/O thread, i.e. we are in the main thread.
-         * Emit right away.
-         */
-        qmp_send_response(mon, rsp);
-    }
-}
-
-struct QMPResponse {
-    Monitor *mon;
-    QDict *data;
-};
-typedef struct QMPResponse QMPResponse;
-
-static QDict *monitor_qmp_response_pop_one(Monitor *mon)
-{
-    QDict *data;
-
-    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
-    data =3D g_queue_pop_head(mon->qmp.qmp_responses);
-    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
-
-    return data;
-}
-
-static void monitor_qmp_response_flush(Monitor *mon)
-{
-    QDict *data;
-
-    while ((data =3D monitor_qmp_response_pop_one(mon))) {
-        qmp_send_response(mon, data);
-        qobject_unref(data);
-    }
-}
-
-/*
- * Pop a QMPResponse from any monitor's response queue into @response.
- * Return false if all the queues are empty; else true.
- */
-static bool monitor_qmp_response_pop_any(QMPResponse *response)
-{
-    Monitor *mon;
-    QDict *data =3D NULL;
-
-    qemu_mutex_lock(&monitor_lock);
-    QTAILQ_FOREACH(mon, &mon_list, entry) {
-        data =3D monitor_qmp_response_pop_one(mon);
-        if (data) {
-            response->mon =3D mon;
-            response->data =3D data;
-            break;
-        }
-    }
-    qemu_mutex_unlock(&monitor_lock);
-    return data !=3D NULL;
-}
-
-static void monitor_qmp_bh_responder(void *opaque)
-{
-    QMPResponse response;
-
-    while (monitor_qmp_response_pop_any(&response)) {
-        qmp_send_response(response.mon, response.data);
-        qobject_unref(response.data);
-    }
-}
-
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] =3D=
 {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        =3D { 1000 * SCALE_MS },
@@ -620,7 +527,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, =
QDict *qdict)
     QTAILQ_FOREACH(mon, &mon_list, entry) {
         if (monitor_is_qmp(mon)
             && mon->qmp.commands !=3D &qmp_cap_negotiation_commands) {
-            qmp_queue_response(mon, qdict);
+            qmp_send_response(mon, qdict);
         }
     }
 }
@@ -818,7 +725,6 @@ static void monitor_data_init(Monitor *mon, bool skip=
_flush,
     mon->skip_flush =3D skip_flush;
     mon->use_io_thread =3D use_io_thread;
     mon->qmp.qmp_requests =3D g_queue_new();
-    mon->qmp.qmp_responses =3D g_queue_new();
 }
=20
 static void monitor_data_destroy(Monitor *mon)
@@ -833,9 +739,7 @@ static void monitor_data_destroy(Monitor *mon)
     qemu_mutex_destroy(&mon->mon_lock);
     qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
-    monitor_qmp_cleanup_resp_queue_locked(mon);
     g_queue_free(mon->qmp.qmp_requests);
-    g_queue_free(mon->qmp.qmp_responses);
 }
=20
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_i=
ndex,
@@ -4152,7 +4056,7 @@ static void monitor_qmp_respond(Monitor *mon, QDict=
 *rsp, QObject *id)
             qdict_put_obj(rsp, "id", qobject_ref(id));
         }
=20
-        qmp_queue_response(mon, rsp);
+        qmp_send_response(mon, rsp);
     }
 }
=20
@@ -4444,7 +4348,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
         mon->qmp.commands =3D &qmp_cap_negotiation_commands;
         monitor_qmp_caps_reset(mon);
         data =3D qmp_greeting(mon);
-        qmp_queue_response(mon, data);
+        qmp_send_response(mon, data);
         qobject_unref(data);
         mon_refcount++;
         break;
@@ -4455,7 +4359,6 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
          * stdio, it's possible that stdout is still open when stdin
          * is closed.
          */
-        monitor_qmp_response_flush(mon);
         monitor_qmp_cleanup_queues(mon);
         json_message_parser_destroy(&mon->qmp.parser);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
@@ -4558,15 +4461,6 @@ static void monitor_iothread_init(void)
     qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
                                    monitor_qmp_bh_dispatcher,
                                    NULL);
-
-    /*
-     * The responder BH must be run in the monitor I/O thread, so that
-     * monitors that are using the I/O thread have their output
-     * written by the I/O thread.
-     */
-    qmp_respond_bh =3D aio_bh_new(monitor_get_aio_context(),
-                                monitor_qmp_bh_responder,
-                                NULL);
 }
=20
 void monitor_init_globals(void)
@@ -4719,12 +4613,6 @@ void monitor_cleanup(void)
      */
     iothread_stop(mon_iothread);
=20
-    /*
-     * Flush all response queues.  Note that even after this flush,
-     * data may remain in output buffers.
-     */
-    monitor_qmp_bh_responder(NULL);
-
     /* Flush output buffers and destroy monitors */
     qemu_mutex_lock(&monitor_lock);
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
@@ -4738,8 +4626,6 @@ void monitor_cleanup(void)
     /* QEMUBHs needs to be deleted before destroying the I/O thread */
     qemu_bh_delete(qmp_dispatcher_bh);
     qmp_dispatcher_bh =3D NULL;
-    qemu_bh_delete(qmp_respond_bh);
-    qmp_respond_bh =3D NULL;
=20
     iothread_destroy(mon_iothread);
     mon_iothread =3D NULL;
--=20
2.18.0.547.g1d89318c48
