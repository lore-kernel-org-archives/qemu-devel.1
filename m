Received: from eggs.gnu.org ([2001:4830:134:3::10]:39309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJuG-0000rN-R3
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJuF-0000z2-8Q
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJuF-0000vu-01
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:35 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:06:05 +0800
Message-Id: <20171116130610.23582-23-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 22/27] qmp: isolate responses into io thread
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

For those monitors who has enabled IO thread, we'll offload the
responding procedure into IO thread.  The main reason is that chardev is
not thread safe, and we need to do all the read/write IOs in the same
thread.  For use_io_thr=true monitors, that thread is the IO thread.

We do this isolation in similar pattern as what we have done to the
request queue: we first create one response queue for each monitor, then
instead of reply directly in main thread, we queue the responses and
kick the IO thread to do the rest of the job for us.

A funny thing after doing this is that, when the QMP clients send "quit"
to QEMU, it's possible that we close the IOThread even earlier than
replying to that "quit".  So another thing we need to do before cleaning
up the monitors is that we need to flush the response queue (we don't
need to do that for command queue; after all we are quitting) to make
sure replies for handled commands are always flushed back to clients.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index ccd350dca2..b18d9d696c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -172,6 +172,8 @@ typedef struct {
     QemuMutex qmp_queue_lock;
     /* Input queue that holds all the parsed QMP requests */
     GQueue *qmp_requests;
+    /* Output queue contains all the QMP responses in order */
+    GQueue *qmp_responses;
 } MonitorQMP;
 
 /*
@@ -219,6 +221,8 @@ struct MonitorGlobal {
     IOThread *mon_iothread;
     /* Bottom half to dispatch the requests received from IO thread */
     QEMUBH *qmp_dispatcher_bh;
+    /* Bottom half to deliver the responses back to clients */
+    QEMUBH *qmp_respond_bh;
 };
 
 static struct MonitorGlobal mon_global;
@@ -395,7 +399,8 @@ int monitor_fprintf(FILE *stream, const char *fmt, ...)
     return 0;
 }
 
-static void monitor_json_emitter(Monitor *mon, const QObject *data)
+static void monitor_json_emitter_raw(Monitor *mon,
+                                     QObject *data)
 {
     QString *json;
 
@@ -409,6 +414,71 @@ static void monitor_json_emitter(Monitor *mon, const QObject *data)
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
+        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+        g_queue_push_tail(mon->qmp.qmp_responses, (void *)data);
+        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
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
+        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+        data = g_queue_pop_head(mon->qmp.qmp_responses);
+        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
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
@@ -595,6 +665,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
     mon->skip_flush = skip_flush;
     mon->use_io_thr = use_io_thr;
     mon->qmp.qmp_requests = g_queue_new();
+    mon->qmp.qmp_responses = g_queue_new();
 }
 
 static void monitor_data_destroy(Monitor *mon)
@@ -609,6 +680,7 @@ static void monitor_data_destroy(Monitor *mon)
     qemu_mutex_destroy(&mon->out_lock);
     qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
     g_queue_free(mon->qmp.qmp_requests);
+    g_queue_free(mon->qmp.qmp_responses);
 }
 
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
@@ -4301,6 +4373,11 @@ static GMainContext *monitor_io_context_get(void)
     return iothread_get_g_main_context(mon_global.mon_iothread);
 }
 
+static AioContext *monitor_aio_context_get(void)
+{
+    return iothread_get_aio_context(mon_global.mon_iothread);
+}
+
 static void monitor_iothread_init(void)
 {
     mon_global.mon_iothread = iothread_create("monitor_iothread",
@@ -4314,6 +4391,15 @@ static void monitor_iothread_init(void)
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
@@ -4426,6 +4512,13 @@ void monitor_cleanup(void)
      */
     iothread_stop(mon_global.mon_iothread);
 
+    /*
+     * After we have IOThread to send responses, it's possible that
+     * when we stop the IOThread there are still replies queued in the
+     * responder queue.  Flush all of them.
+     */
+    monitor_qmp_bh_responder(NULL);
+
     qemu_mutex_lock(&monitor_lock);
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QTAILQ_REMOVE(&mon_list, mon, entry);
@@ -4437,6 +4530,8 @@ void monitor_cleanup(void)
     /* QEMUBHs needs to be deleted before destroying the IOThread. */
     qemu_bh_delete(mon_global.qmp_dispatcher_bh);
     mon_global.qmp_dispatcher_bh = NULL;
+    qemu_bh_delete(mon_global.qmp_respond_bh);
+    mon_global.qmp_respond_bh = NULL;
 
     iothread_destroy(mon_global.mon_iothread);
     mon_global.mon_iothread = NULL;
-- 
2.13.6
