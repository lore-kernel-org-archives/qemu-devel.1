Received: from eggs.gnu.org ([2001:4830:134:3::10]:53208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4d-0001XT-5W
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4X-0007Hd-Nb
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38148 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4X-0007GB-ES
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:57 +0200
Message-Id: <20180703085358.13941-32-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 31/32] monitor: Improve some comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 100 ++++++++++++++++++++++++------------------------------
 1 file changed, 45 insertions(+), 55 deletions(-)

diff --git a/monitor.c b/monitor.c
index 590e5b5b04..14af7b7ea6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -168,15 +168,16 @@ typedef struct {
     JSONMessageParser parser;
     /*
      * When a client connects, we're in capabilities negotiation mode.
-     * When command qmp_capabilities succeeds, we go into command
-     * mode.
+     * @commands is &qmp_cap_negotiation_commands then.  When command
+     * qmp_capabilities succeeds, we go into command mode, and
+     * @command becomes &qmp_commands.
      */
     QmpCommandList *commands;
     bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
     bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
     /*
-     * Protects qmp request/response queue.  Please take monitor_lock
-     * first when used together.
+     * Protects qmp request/response queue.
+     * Take monitor_lock first when you need both.
      */
     QemuMutex qmp_queue_lock;
     /* Input queue that holds all the parsed QMP requests */
@@ -231,7 +232,7 @@ struct Monitor {
     QemuMutex mon_lock;
 
     /*
-     * Fields that are protected by the per-monitor lock.
+     * Members that are protected by the per-monitor lock
      */
     QLIST_HEAD(, mon_fd_t) fds;
     QString *outbuf;
@@ -240,6 +241,7 @@ struct Monitor {
     int mux_out;
 };
 
+/* Shared monitor I/O thread */
 IOThread *mon_iothread;
 
 /* Bottom half to dispatch the requests received from I/O thread */
@@ -301,9 +303,9 @@ static inline bool monitor_is_qmp(const Monitor *mon)
 }
 
 /**
- * Whether @mon is using readline?  Note: not all HMP monitors use
- * readline, e.g., gdbserver has a non-interactive HMP monitor, so
- * readline is not used there.
+ * Is @mon is using readline?
+ * Note: not all HMP monitors use readline, e.g., gdbserver has a
+ * non-interactive HMP monitor, so readline is not used there.
  */
 static inline bool monitor_uses_readline(const Monitor *mon)
 {
@@ -317,14 +319,12 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
 
 /*
  * Return the clock to use for recording an event's time.
+ * It's QEMU_CLOCK_REALTIME, except for qtests it's
+ * QEMU_CLOCK_VIRTUAL, to support testing rate limits.
  * Beware: result is invalid before configure_accelerator().
  */
 static inline QEMUClockType monitor_get_event_clock(void)
 {
-    /*
-     * This allows us to perform tests on the monitor queues to verify
-     * that the rate limits are enforced.
-     */
     return qtest_enabled() ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME;
 }
 
@@ -367,7 +367,7 @@ static void qmp_request_free(QMPRequest *req)
     g_free(req);
 }
 
-/* Must with the mon->qmp.qmp_queue_lock held */
+/* Caller must hold mon->qmp.qmp_queue_lock */
 static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
 {
     while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
@@ -375,7 +375,7 @@ static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
     }
 }
 
-/* Must with the mon->qmp.qmp_queue_lock held */
+/* Caller must hold the mon->qmp.qmp_queue_lock */
 static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
 {
     while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
@@ -406,7 +406,7 @@ static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
     return FALSE;
 }
 
-/* Called with mon->mon_lock held.  */
+/* Caller must hold mon->mon_lock */
 static void monitor_flush_locked(Monitor *mon)
 {
     int rc;
@@ -522,10 +522,8 @@ static void qmp_queue_response(Monitor *mon, QDict *rsp)
 {
     if (mon->use_io_thread) {
         /*
-         * If using I/O thread, we need to queue the item so that I/O
-         * thread will do the rest for us.  Take refcount so that
-         * caller won't free the data (which will be finally freed in
-         * responder thread).
+         * Push a reference to the response queue.  The I/O thread
+         * drains that queue and emits.
          */
         qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
         g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(rsp));
@@ -533,8 +531,8 @@ static void qmp_queue_response(Monitor *mon, QDict *rsp)
         qemu_bh_schedule(qmp_respond_bh);
     } else {
         /*
-         * If not using monitor I/O thread, then we are in main thread.
-         * Do the emission right away.
+         * Not using monitor I/O thread, i.e. we are in the main thread.
+         * Emit right away.
          */
         qmp_send_response(mon, rsp);
     }
@@ -610,8 +608,9 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
 };
 
 /*
- * Emits the event to every monitor instance, @event is only used for trace
- * Called with monitor_lock held.
+ * Broadcast an event to all monitors.
+ * @qdict is the event object.  Its member "event" must match @event.
+ * Caller must hold monitor_lock.
  */
 static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
@@ -980,8 +979,7 @@ static int parse_cmdline(const char *cmdline,
 }
 
 /*
- * Returns true if the command can be executed in preconfig mode
- * i.e. it has the 'p' flag.
+ * Can command @cmd be executed in preconfig state?
  */
 static bool cmd_can_preconfig(const mon_cmd_t *cmd)
 {
@@ -2220,7 +2218,7 @@ void qmp_getfd(const char *fdname, Error **errp)
         tmp_fd = monfd->fd;
         monfd->fd = fd;
         qemu_mutex_unlock(&cur_mon->mon_lock);
-        /* Make sure close() is out of critical section */
+        /* Make sure close() is outside critical section */
         close(tmp_fd);
         return;
     }
@@ -2249,7 +2247,7 @@ void qmp_closefd(const char *fdname, Error **errp)
         g_free(monfd->name);
         g_free(monfd);
         qemu_mutex_unlock(&cur_mon->mon_lock);
-        /* Make sure close() is out of critical section */
+        /* Make sure close() is outside critical section */
         close(tmp_fd);
         return;
     }
@@ -4138,7 +4136,8 @@ static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
 }
 
 /*
- * Pop one QMP request from monitor queues, return NULL if not found.
+ * Pop a QMP request from a monitor request queue.
+ * Return the request, or NULL all request queues are empty.
  * We are using round-robin fashion to pop the request, to avoid
  * processing commands only on a very busy monitor.  To achieve that,
  * when we process one request on a specific monitor, we put that
@@ -4233,7 +4232,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     }
 
     if (qdict && qmp_is_oob(qdict)) {
-        /* Out-of-band (OOB) requests are executed directly in parser. */
+        /* OOB commands are executed immediately */
         trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id)
                                           ?: "");
         monitor_qmp_dispatch(mon, req, id);
@@ -4355,8 +4354,8 @@ void monitor_resume(Monitor *mon)
     if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
         if (monitor_is_qmp(mon)) {
             /*
-             * For QMP monitors that are running in I/O thread, let's
-             * kick the thread in case it's sleeping.
+             * For QMP monitors that are running in the I/O thread,
+             * let's kick the thread in case it's sleeping.
              */
             if (mon->use_io_thread) {
                 aio_notify(iothread_get_aio_context(mon_iothread));
@@ -4504,18 +4503,18 @@ static void monitor_iothread_init(void)
     mon_iothread = iothread_create("mon_iothread", &error_abort);
 
     /*
-     * This MUST be on main loop thread since we have commands that
-     * have assumption to be run on main loop thread.  It would be
-     * nice that one day we can remove this assumption in the future.
+     * The dispatcher BH must run in the main loop thread, since we
+     * have commands assuming that context.  It would be nice to get
+     * rid of those assumptions.
      */
     qmp_dispatcher_bh = aio_bh_new(iohandler_get_aio_context(),
                                    monitor_qmp_bh_dispatcher,
                                    NULL);
 
     /*
-     * Unlike the dispatcher BH, this must be run on the monitor I/O
-     * thread, so that monitors that are using I/O thread will make
-     * sure read/write operations are all done on the I/O thread.
+     * The responder BH must be run in the monitor I/O thread, so that
+     * monitors that are using the I/O thread have their output
+     * written by the I/O thread.
      */
     qmp_respond_bh = aio_bh_new(monitor_get_aio_context(),
                                 monitor_qmp_bh_responder,
@@ -4585,15 +4584,11 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     GMainContext *context;
 
     if (mon->use_io_thread) {
-        /*
-         * When @use_io_thread is set, we use the global shared dedicated
-         * I/O thread for this monitor to handle input/output.
-         */
+        /* Use @mon_iothread context */
         context = monitor_get_io_context();
-        /* We should have inited globals before reaching here. */
         assert(context);
     } else {
-        /* The default main loop, which is the main thread */
+        /* Use default main loop context */
         context = NULL;
     }
 
@@ -4643,15 +4638,12 @@ void monitor_init(Chardev *chr, int flags)
             remove_fd_in_watch(chr);
             /*
              * We can't call qemu_chr_fe_set_handlers() directly here
-             * since during the procedure the chardev will be active
-             * and running in monitor I/O thread, while we'll still do
-             * something before returning from it, which is a possible
-             * race too.  To avoid that, we just create a BH to setup
-             * the handlers.
+             * since chardev might be running in the monitor I/O
+             * thread.  Schedule a bottom half.
              */
             aio_bh_schedule_oneshot(monitor_get_aio_context(),
                                     monitor_qmp_setup_handlers_bh, mon);
-            /* We'll add this to mon_list in the BH when setup done */
+            /* The bottom half will add @mon to @mon_list */
             return;
         } else {
             qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
@@ -4672,21 +4664,19 @@ void monitor_cleanup(void)
 
     /*
      * We need to explicitly stop the I/O thread (but not destroy it),
-     * cleanup the monitor resources, then destroy the I/O thread since
+     * clean up the monitor resources, then destroy the I/O thread since
      * we need to unregister from chardev below in
      * monitor_data_destroy(), and chardev is not thread-safe yet
      */
     iothread_stop(mon_iothread);
 
     /*
-     * After we have I/O thread to send responses, it's possible that
-     * when we stop the I/O thread there are still replies queued in the
-     * responder queue.  Flush all of them.  Note that even after this
-     * flush it's still possible that out buffer is not flushed.
-     * It'll be done in below monitor_flush() as the last resort.
+     * Flush all response queues.  Note that even after this flush,
+     * data may remain in output buffers.
      */
     monitor_qmp_bh_responder(NULL);
 
+    /* Flush output buffers and destroy monitors */
     qemu_mutex_lock(&monitor_lock);
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QTAILQ_REMOVE(&mon_list, mon, entry);
-- 
2.17.1
