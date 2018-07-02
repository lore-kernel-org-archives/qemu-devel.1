Received: from eggs.gnu.org ([2001:4830:134:3::10]:42609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1au-0004Su-IK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1ar-0006fV-Kw
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ar-0006eA-8W
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB5807DAC3
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:22:06 +0200
Message-Id: <20180702162218.13678-21-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 20/32] monitor: Peel off @mon_global wrapper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

Wrapping global variables in a struct without a use for the wrapper
struct buys us nothing but longer lines.  Unwrap them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 60 +++++++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/monitor.c b/monitor.c
index 10b6634d3e..ef19562f65 100644
--- a/monitor.c
+++ b/monitor.c
@@ -210,7 +210,7 @@ struct Monitor {
 
     /*
      * State used only in the thread "owning" the monitor.
-     * If @use_io_thread, this is mon_global.mon_iothread.
+     * If @use_io_thread, this is @mon_iothread.
      * Else, it's the main thread.
      * These members can be safely accessed without locks.
      */
@@ -239,14 +239,13 @@ struct Monitor {
     int mux_out;
 };
 
-/* Let's add monitor global variables to this struct. */
-static struct {
-    IOThread *mon_iothread;
-    /* Bottom half to dispatch the requests received from I/O thread */
-    QEMUBH *qmp_dispatcher_bh;
-    /* Bottom half to deliver the responses back to clients */
-    QEMUBH *qmp_respond_bh;
-} mon_global;
+IOThread *mon_iothread;
+
+/* Bottom half to dispatch the requests received from I/O thread */
+QEMUBH *qmp_dispatcher_bh;
+
+/* Bottom half to deliver the responses back to clients */
+QEMUBH *qmp_respond_bh;
 
 struct QMPRequest {
     /* Owner of the request */
@@ -530,7 +529,7 @@ static void monitor_json_emitter(Monitor *mon, QObject *data)
         qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
         g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(data));
         qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
-        qemu_bh_schedule(mon_global.qmp_respond_bh);
+        qemu_bh_schedule(qmp_respond_bh);
     } else {
         /*
          * If not using monitor I/O thread, then we are in main thread.
@@ -4218,7 +4217,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
     qmp_request_free(req_obj);
 
     /* Reschedule instead of looping so the main loop stays responsive */
-    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
+    qemu_bh_schedule(qmp_dispatcher_bh);
 }
 
 #define  QMP_REQ_QUEUE_LEN_MAX  (8)
@@ -4304,7 +4303,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
 
     /* Kick the dispatcher routine */
-    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
+    qemu_bh_schedule(qmp_dispatcher_bh);
 }
 
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
@@ -4357,7 +4356,7 @@ int monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
+        aio_notify(iothread_get_aio_context(mon_iothread));
     }
 
     trace_monitor_suspend(mon, 1);
@@ -4377,7 +4376,7 @@ void monitor_resume(Monitor *mon)
              * kick the thread in case it's sleeping.
              */
             if (mon->use_io_thread) {
-                aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
+                aio_notify(iothread_get_aio_context(mon_iothread));
             }
         } else {
             assert(mon->rs);
@@ -4515,36 +4514,35 @@ static void sortcmdlist(void)
 
 static GMainContext *monitor_get_io_context(void)
 {
-    return iothread_get_g_main_context(mon_global.mon_iothread);
+    return iothread_get_g_main_context(mon_iothread);
 }
 
 static AioContext *monitor_get_aio_context(void)
 {
-    return iothread_get_aio_context(mon_global.mon_iothread);
+    return iothread_get_aio_context(mon_iothread);
 }
 
 static void monitor_iothread_init(void)
 {
-    mon_global.mon_iothread = iothread_create("mon_iothread",
-                                              &error_abort);
+    mon_iothread = iothread_create("mon_iothread", &error_abort);
 
     /*
      * This MUST be on main loop thread since we have commands that
      * have assumption to be run on main loop thread.  It would be
      * nice that one day we can remove this assumption in the future.
      */
-    mon_global.qmp_dispatcher_bh = aio_bh_new(iohandler_get_aio_context(),
-                                              monitor_qmp_bh_dispatcher,
-                                              NULL);
+    qmp_dispatcher_bh = aio_bh_new(iohandler_get_aio_context(),
+                                   monitor_qmp_bh_dispatcher,
+                                   NULL);
 
     /*
      * Unlike the dispatcher BH, this must be run on the monitor I/O
      * thread, so that monitors that are using I/O thread will make
      * sure read/write operations are all done on the I/O thread.
      */
-    mon_global.qmp_respond_bh = aio_bh_new(monitor_get_aio_context(),
-                                           monitor_qmp_bh_responder,
-                                           NULL);
+    qmp_respond_bh = aio_bh_new(monitor_get_aio_context(),
+                                monitor_qmp_bh_responder,
+                                NULL);
 }
 
 void monitor_init_globals(void)
@@ -4701,7 +4699,7 @@ void monitor_cleanup(void)
      * we need to unregister from chardev below in
      * monitor_data_destroy(), and chardev is not thread-safe yet
      */
-    iothread_stop(mon_global.mon_iothread);
+    iothread_stop(mon_iothread);
 
     /*
      * After we have I/O thread to send responses, it's possible that
@@ -4722,13 +4720,13 @@ void monitor_cleanup(void)
     qemu_mutex_unlock(&monitor_lock);
 
     /* QEMUBHs needs to be deleted before destroying the I/O thread */
-    qemu_bh_delete(mon_global.qmp_dispatcher_bh);
-    mon_global.qmp_dispatcher_bh = NULL;
-    qemu_bh_delete(mon_global.qmp_respond_bh);
-    mon_global.qmp_respond_bh = NULL;
+    qemu_bh_delete(qmp_dispatcher_bh);
+    qmp_dispatcher_bh = NULL;
+    qemu_bh_delete(qmp_respond_bh);
+    qmp_respond_bh = NULL;
 
-    iothread_destroy(mon_global.mon_iothread);
-    mon_global.mon_iothread = NULL;
+    iothread_destroy(mon_iothread);
+    mon_iothread = NULL;
 }
 
 QemuOptsList qemu_mon_opts = {
-- 
2.17.1
