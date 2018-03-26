Received: from eggs.gnu.org ([2001:4830:134:3::10]:54761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkc-00054w-He
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TkZ-0002g8-Q0
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TkZ-0002fr-K3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:31 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:41 +0200
Message-Id: <20180326150916.9602-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/38] Revert "qmp: isolate responses into
 io thread"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This reverts commit abe3cd0ff7f774966da6842620806ab7576fe4f3.

There is no need to add an additional queue to send the reply to the
IOThread, because QMP response is thread safe, and chardev write path
is thread safe. It will schedule watcher in the associated IOThread.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 96 +------------------------------------------------------
 1 file changed, 1 insertion(+), 95 deletions(-)

diff --git a/monitor.c b/monitor.c
index d57bbbb134..59920ea872 100644
--- a/monitor.c
+++ b/monitor.c
@@ -180,8 +180,6 @@ typedef struct {
     QemuMutex qmp_queue_lock;
     /* Input queue that holds all the parsed QMP requests */
     GQueue *qmp_requests;
-    /* Output queue contains all the QMP responses in order */
-    GQueue *qmp_responses;
 } MonitorQMP;
=20
 /*
@@ -208,7 +206,6 @@ struct Monitor {
     bool skip_flush;
     bool use_io_thr;
=20
-    /* We can't access guest memory when holding the lock */
     QemuMutex out_lock;
     QString *outbuf;
     guint out_watch;
@@ -231,8 +228,6 @@ static struct {
     IOThread *mon_iothread;
     /* Bottom half to dispatch the requests received from IO thread */
     QEMUBH *qmp_dispatcher_bh;
-    /* Bottom half to deliver the responses back to clients */
-    QEMUBH *qmp_respond_bh;
 } mon_global;
=20
 /* QMP checker flags */
@@ -422,8 +417,7 @@ int monitor_fprintf(FILE *stream, const char *fmt, ..=
.)
     return 0;
 }
=20
-static void monitor_json_emitter_raw(Monitor *mon,
-                                     QObject *data)
+static void monitor_json_emitter(Monitor *mon, const QObject *data)
 {
     QString *json;
=20
@@ -437,71 +431,6 @@ static void monitor_json_emitter_raw(Monitor *mon,
     QDECREF(json);
 }
=20
-static void monitor_json_emitter(Monitor *mon, QObject *data)
-{
-    if (mon->use_io_thr) {
-        /*
-         * If using IO thread, we need to queue the item so that IO
-         * thread will do the rest for us.  Take refcount so that
-         * caller won't free the data (which will be finally freed in
-         * responder thread).
-         */
-        qobject_incref(data);
-        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
-        g_queue_push_tail(mon->qmp.qmp_responses, (void *)data);
-        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
-        qemu_bh_schedule(mon_global.qmp_respond_bh);
-    } else {
-        /*
-         * If not using monitor IO thread, then we are in main thread.
-         * Do the emission right away.
-         */
-        monitor_json_emitter_raw(mon, data);
-    }
-}
-
-struct QMPResponse {
-    Monitor *mon;
-    QObject *data;
-};
-typedef struct QMPResponse QMPResponse;
-
-/*
- * Return one QMPResponse.  The response is only valid if
- * response.data is not NULL.
- */
-static QMPResponse monitor_qmp_response_pop_one(void)
-{
-    Monitor *mon;
-    QObject *data =3D NULL;
-
-    qemu_mutex_lock(&monitor_lock);
-    QTAILQ_FOREACH(mon, &mon_list, entry) {
-        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
-        data =3D g_queue_pop_head(mon->qmp.qmp_responses);
-        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
-        if (data) {
-            break;
-        }
-    }
-    qemu_mutex_unlock(&monitor_lock);
-    return (QMPResponse) { .mon =3D mon, .data =3D data };
-}
-
-static void monitor_qmp_bh_responder(void *opaque)
-{
-    QMPResponse response;
-
-    while (true) {
-        response =3D monitor_qmp_response_pop_one();
-        if (!response.data) {
-            break;
-        }
-        monitor_json_emitter_raw(response.mon, response.data);
-        qobject_decref(response.data);
-    }
-}
-
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] =3D=
 {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        =3D { 1000 * SCALE_MS },
@@ -688,7 +617,6 @@ static void monitor_data_init(Monitor *mon, bool skip=
_flush,
     mon->skip_flush =3D skip_flush;
     mon->use_io_thr =3D use_io_thr;
     mon->qmp.qmp_requests =3D g_queue_new();
-    mon->qmp.qmp_responses =3D g_queue_new();
 }
=20
 static void monitor_data_destroy(Monitor *mon)
@@ -703,7 +631,6 @@ static void monitor_data_destroy(Monitor *mon)
     qemu_mutex_destroy(&mon->out_lock);
     qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
     g_queue_free(mon->qmp.qmp_requests);
-    g_queue_free(mon->qmp.qmp_responses);
 }
=20
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_i=
ndex,
@@ -4443,15 +4370,6 @@ static void monitor_iothread_init(void)
     mon_global.qmp_dispatcher_bh =3D aio_bh_new(qemu_get_aio_context(),
                                               monitor_qmp_bh_dispatcher,
                                               NULL);
-
-    /*
-     * Unlike the dispatcher BH, this must be run on the monitor IO
-     * thread, so that monitors that are using IO thread will make
-     * sure read/write operations are all done on the IO thread.
-     */
-    mon_global.qmp_respond_bh =3D aio_bh_new(monitor_get_aio_context(),
-                                           monitor_qmp_bh_responder,
-                                           NULL);
 }
=20
 void monitor_init_globals(void)
@@ -4597,19 +4515,9 @@ void monitor_cleanup(void)
      */
     iothread_stop(mon_global.mon_iothread);
=20
-    /*
-     * After we have IOThread to send responses, it's possible that
-     * when we stop the IOThread there are still replies queued in the
-     * responder queue.  Flush all of them.  Note that even after this
-     * flush it's still possible that out buffer is not flushed.
-     * It'll be done in below monitor_flush() as the last resort.
-     */
-    monitor_qmp_bh_responder(NULL);
-
     qemu_mutex_lock(&monitor_lock);
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QTAILQ_REMOVE(&mon_list, mon, entry);
-        monitor_flush(mon);
         monitor_data_destroy(mon);
         g_free(mon);
     }
@@ -4618,8 +4526,6 @@ void monitor_cleanup(void)
     /* QEMUBHs needs to be deleted before destroying the IOThread. */
     qemu_bh_delete(mon_global.qmp_dispatcher_bh);
     mon_global.qmp_dispatcher_bh =3D NULL;
-    qemu_bh_delete(mon_global.qmp_respond_bh);
-    mon_global.qmp_respond_bh =3D NULL;
=20
     iothread_destroy(mon_global.mon_iothread);
     mon_global.mon_iothread =3D NULL;
--=20
2.17.0.rc1.1.g4c4f2b46a3
