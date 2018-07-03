Received: from eggs.gnu.org ([2001:4830:134:3::10]:34499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNN1-0002PX-WA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMy-0005Mn-H9
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faNMy-0005L6-5J
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEE97FA478
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F24E1117629
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 17:37:16 +0200
Message-Id: <20180703153728.2175-21-armbru@redhat.com>
In-Reply-To: <20180703153728.2175-1-armbru@redhat.com>
References: <20180703153728.2175-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 20/32] monitor: Peel off @mon_global wrapper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Wrapping global variables in a struct without a use for the wrapper
struct buys us nothing but longer lines.  Unwrap them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-21-armbru@redhat.com>
---
 monitor.c | 60 +++++++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/monitor.c b/monitor.c
index b3c5dcc685..26de90e4d2 100644
--- a/monitor.c
+++ b/monitor.c
@@ -211,7 +211,7 @@ struct Monitor {
 
     /*
      * State used only in the thread "owning" the monitor.
-     * If @use_io_thread, this is mon_global.mon_iothread.
+     * If @use_io_thread, this is @mon_iothread.
      * Else, it's the main thread.
      * These members can be safely accessed without locks.
      */
@@ -240,14 +240,13 @@ struct Monitor {
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
@@ -531,7 +530,7 @@ static void monitor_json_emitter(Monitor *mon, QObject *data)
         qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
         g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(data));
         qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
-        qemu_bh_schedule(mon_global.qmp_respond_bh);
+        qemu_bh_schedule(qmp_respond_bh);
     } else {
         /*
          * If not using monitor I/O thread, then we are in main thread.
@@ -4219,7 +4218,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
     qmp_request_free(req_obj);
 
     /* Reschedule instead of looping so the main loop stays responsive */
-    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
+    qemu_bh_schedule(qmp_dispatcher_bh);
 }
 
 #define  QMP_REQ_QUEUE_LEN_MAX  (8)
@@ -4305,7 +4304,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
 
     /* Kick the dispatcher routine */
-    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
+    qemu_bh_schedule(qmp_dispatcher_bh);
 }
 
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
@@ -4358,7 +4357,7 @@ int monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
+        aio_notify(iothread_get_aio_context(mon_iothread));
     }
 
     trace_monitor_suspend(mon, 1);
@@ -4378,7 +4377,7 @@ void monitor_resume(Monitor *mon)
              * kick the thread in case it's sleeping.
              */
             if (mon->use_io_thread) {
-                aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
+                aio_notify(iothread_get_aio_context(mon_iothread));
             }
         } else {
             assert(mon->rs);
@@ -4516,36 +4515,35 @@ static void sortcmdlist(void)
 
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
@@ -4702,7 +4700,7 @@ void monitor_cleanup(void)
      * we need to unregister from chardev below in
      * monitor_data_destroy(), and chardev is not thread-safe yet
      */
-    iothread_stop(mon_global.mon_iothread);
+    iothread_stop(mon_iothread);
 
     /*
      * After we have I/O thread to send responses, it's possible that
@@ -4723,13 +4721,13 @@ void monitor_cleanup(void)
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
