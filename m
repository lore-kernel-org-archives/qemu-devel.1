Received: from eggs.gnu.org ([2001:4830:134:3::10]:36338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAk-00072c-GX
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAj-0007fn-7J
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxmAi-0007eC-V4
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:05 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:42 +0800
Message-Id: <20170929033844.26935-21-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 20/22] qmp: isolate responses into io thread
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

For those monitors who has enabled IO thread, we'll offload the
responding procedure into IO thread.  The main reason is that chardev is
not thread safe, and we need to do all the read/write IOs in the same
thread.  For use_io_thr=true monitors, that thread is the IO thread.

We do this isolation in similar pattern as what we have done to the
request queue: we first create one response queue for each monitor, then
instead of reply directly in main thread, we queue the responses and
kick the IO thread to do the rest of the job for us.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 2be79eadcc..649491a2ce 100644
--- a/monitor.c
+++ b/monitor.c
@@ -211,12 +211,16 @@ struct Monitor {
     QTAILQ_ENTRY(Monitor) entry;
     /* Input queue that hangs all the parsed QMP requests */
     GQueue *qmp_requests;
+    /* Output queue contains all the QMP responses in order */
+    GQueue *qmp_responses;
 };
 
 struct MonitorGlobal {
     IOThread *mon_io_thread;
     /* Bottom half to dispatch the requests received from IO thread */
     QEMUBH *qmp_dispatcher_bh;
+    /* Bottom half to deliver the responses back to clients */
+    QEMUBH *qmp_respond_bh;
 };
 
 static struct MonitorGlobal mon_global;
@@ -393,7 +397,8 @@ int monitor_fprintf(FILE *stream, const char *fmt, ...)
     return 0;
 }
 
-static void monitor_json_emitter(Monitor *mon, const QObject *data)
+static void monitor_json_emitter_raw(Monitor *mon,
+                                     QObject *data)
 {
     QString *json;
 
@@ -407,6 +412,67 @@ static void monitor_json_emitter(Monitor *mon, const QObject *data)
     QDECREF(json);
 }
 
+static void monitor_json_emitter(Monitor *mon, QObject *data)
+{
+    if (mon->use_io_thr) {
+        /*
+         * If using IO thread, we need to queue the item so that IO
+         * thread will do the rest for us.  Take refcount so that
+         * caller won't free the data (which will be finally freed in
+         * responder thread).
+         */
+        qobject_incref(data);
+        g_queue_push_tail(mon->qmp_responses, (void *)data);
+        qemu_bh_schedule(mon_global.qmp_respond_bh);
+    } else {
+        /*
+         * If not using monitor IO thread, then we are in main thread.
+         * Do the emission right away.
+         */
+        monitor_json_emitter_raw(mon, data);
+    }
+}
+
+struct QMPResponse {
+    Monitor *mon;
+    QObject *data;
+};
+typedef struct QMPResponse QMPResponse;
+
+/*
+ * Return one QMPResponse.  The response is only valid if
+ * response.data is not NULL.
+ */
+static QMPResponse monitor_qmp_response_pop_one(void)
+{
+    Monitor *mon;
+    QObject *data = NULL;
+
+    qemu_mutex_lock(&monitor_lock);
+    QTAILQ_FOREACH(mon, &mon_list, entry) {
+        data = g_queue_pop_head(mon->qmp_responses);
+        if (data) {
+            break;
+        }
+    }
+    qemu_mutex_unlock(&monitor_lock);
+    return (QMPResponse) { .mon = mon, .data = data };
+}
+
+static void monitor_qmp_bh_responder(void *opaque)
+{
+    QMPResponse response;
+
+    while (true) {
+        response = monitor_qmp_response_pop_one();
+        if (!response.data) {
+            break;
+        }
+        monitor_json_emitter_raw(response.mon, response.data);
+        qobject_decref(response.data);
+    }
+}
+
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
@@ -592,6 +658,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
     mon->skip_flush = skip_flush;
     mon->use_io_thr = use_io_thr;
     mon->qmp_requests = g_queue_new();
+    mon->qmp_responses = g_queue_new();
 }
 
 static void monitor_data_destroy(Monitor *mon)
@@ -604,6 +671,7 @@ static void monitor_data_destroy(Monitor *mon)
     QDECREF(mon->outbuf);
     qemu_mutex_destroy(&mon->out_lock);
     g_queue_free(mon->qmp_requests);
+    g_queue_free(mon->qmp_responses);
 }
 
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
@@ -4197,6 +4265,11 @@ static GMainContext *monitor_io_context_get(void)
     return iothread_get_g_main_context(mon_global.mon_io_thread);
 }
 
+static AioContext *monitor_aio_context_get(void)
+{
+    return iothread_get_aio_context(mon_global.mon_io_thread);
+}
+
 static void monitor_io_thread_init(void)
 {
     mon_global.mon_io_thread = iothread_create("monitor_io_thr",
@@ -4215,6 +4288,15 @@ static void monitor_io_thread_init(void)
     mon_global.qmp_dispatcher_bh = aio_bh_new(qemu_get_aio_context(),
                                               monitor_qmp_bh_dispatcher,
                                               NULL);
+
+    /*
+     * Unlike the dispatcher BH, this must be run on the monitor IO
+     * thread, so that monitors that are using IO thread will make
+     * sure read/write operations are all done on the IO thread.
+     */
+    mon_global.qmp_respond_bh = aio_bh_new(monitor_aio_context_get(),
+                                           monitor_qmp_bh_responder,
+                                           NULL);
 }
 
 void monitor_init_globals(void)
@@ -4321,6 +4403,8 @@ static void monitor_io_thread_destroy(void)
     /* QEMUBHs needs to be deleted before destroying the IOThread. */
     qemu_bh_delete(mon_global.qmp_dispatcher_bh);
     mon_global.qmp_dispatcher_bh = NULL;
+    qemu_bh_delete(mon_global.qmp_respond_bh);
+    mon_global.qmp_respond_bh = NULL;
 
     iothread_destroy(mon_global.mon_io_thread);
     mon_global.mon_io_thread = NULL;
-- 
2.13.5
