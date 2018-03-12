Received: from eggs.gnu.org ([2001:4830:134:3::10]:45493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJe-0000ul-9X
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJc-00064l-QQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJc-00064W-LG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 426924000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:21 -0500
Message-Id: <20180312183628.394722-31-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 30/36] qmp: isolate responses into io thread
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

For those monitors who have enabled IO thread, we'll offload the
responding procedure into IO thread.  The main reason is that chardev is
not thread safe, and we need to do all the read/write IOs in the same
thread.  For use_io_thr=true monitors, that thread is the IO thread.

We do this isolation in similar pattern as what we have done to the
request queue: we first create one response queue for each monitor, then
instead of replying directly in the main thread, we queue the responses
and kick the IO thread to do the rest of the job for us.

A funny thing after doing this is that, when the QMP clients send "quit"
to QEMU, it's possible that we close the IOThread even earlier than
replying to that "quit".  So another thing we need to do before cleaning
up the monitors is that we need to flush the response queue (we don't
need to do that for command queue; after all we are quitting) to make
sure replies for handled commands are always flushed back to clients.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-20-peterx@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 3b7a4a5c3a7..905d5efc6fa 100644
--- a/monitor.c
+++ b/monitor.c
@@ -179,6 +179,8 @@ typedef struct {
     QemuMutex qmp_queue_lock;
     /* Input queue that holds all the parsed QMP requests */
     GQueue *qmp_requests;
+    /* Output queue contains all the QMP responses in order */
+    GQueue *qmp_responses;
 } MonitorQMP;

 /*
@@ -205,6 +207,7 @@ struct Monitor {
     bool skip_flush;
     bool use_io_thr;

+    /* We can't access guest memory when holding the lock */
     QemuMutex out_lock;
     QString *outbuf;
     guint out_watch;
@@ -227,6 +230,8 @@ static struct {
     IOThread *mon_iothread;
     /* Bottom half to dispatch the requests received from IO thread */
     QEMUBH *qmp_dispatcher_bh;
+    /* Bottom half to deliver the responses back to clients */
+    QEMUBH *qmp_respond_bh;
 } mon_global;

 /* QMP checker flags */
@@ -416,7 +421,8 @@ int monitor_fprintf(FILE *stream, const char *fmt, ...)
     return 0;
 }

-static void monitor_json_emitter(Monitor *mon, const QObject *data)
+static void monitor_json_emitter_raw(Monitor *mon,
+                                     QObject *data)
 {
     QString *json;

@@ -430,6 +436,71 @@ static void monitor_json_emitter(Monitor *mon, const QObject *data)
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
@@ -616,6 +687,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
     mon->skip_flush = skip_flush;
     mon->use_io_thr = use_io_thr;
     mon->qmp.qmp_requests = g_queue_new();
+    mon->qmp.qmp_responses = g_queue_new();
 }

 static void monitor_data_destroy(Monitor *mon)
@@ -630,6 +702,7 @@ static void monitor_data_destroy(Monitor *mon)
     qemu_mutex_destroy(&mon->out_lock);
     qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
     g_queue_free(mon->qmp.qmp_requests);
+    g_queue_free(mon->qmp.qmp_responses);
 }

 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
@@ -4367,6 +4440,15 @@ static void monitor_iothread_init(void)
     mon_global.qmp_dispatcher_bh = aio_bh_new(qemu_get_aio_context(),
                                               monitor_qmp_bh_dispatcher,
                                               NULL);
+
+    /*
+     * Unlike the dispatcher BH, this must be run on the monitor IO
+     * thread, so that monitors that are using IO thread will make
+     * sure read/write operations are all done on the IO thread.
+     */
+    mon_global.qmp_respond_bh = aio_bh_new(monitor_get_aio_context(),
+                                           monitor_qmp_bh_responder,
+                                           NULL);
 }

 void monitor_init_globals(void)
@@ -4505,9 +4587,19 @@ void monitor_cleanup(void)
      */
     iothread_stop(mon_global.mon_iothread);

+    /*
+     * After we have IOThread to send responses, it's possible that
+     * when we stop the IOThread there are still replies queued in the
+     * responder queue.  Flush all of them.  Note that even after this
+     * flush it's still possible that out buffer is not flushed.
+     * It'll be done in below monitor_flush() as the last resort.
+     */
+    monitor_qmp_bh_responder(NULL);
+
     qemu_mutex_lock(&monitor_lock);
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QTAILQ_REMOVE(&mon_list, mon, entry);
+        monitor_flush(mon);
         monitor_data_destroy(mon);
         g_free(mon);
     }
@@ -4516,6 +4608,8 @@ void monitor_cleanup(void)
     /* QEMUBHs needs to be deleted before destroying the IOThread. */
     qemu_bh_delete(mon_global.qmp_dispatcher_bh);
     mon_global.qmp_dispatcher_bh = NULL;
+    qemu_bh_delete(mon_global.qmp_respond_bh);
+    mon_global.qmp_respond_bh = NULL;

     iothread_destroy(mon_global.mon_iothread);
     mon_global.mon_iothread = NULL;
-- 
2.14.3
