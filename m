Received: from eggs.gnu.org ([2001:4830:134:3::10]:52986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4X-0001RY-8l
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4T-0007BF-0C
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4S-0007Az-QQ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:00 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:28 +0200
Message-Id: <20180703085358.13941-3-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/32] monitor: Spell "I/O thread"
 consistently in comments
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
 monitor.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/monitor.c b/monitor.c
index f5f20e36e3..3fb05d50aa 100644
--- a/monitor.c
+++ b/monitor.c
@@ -242,7 +242,7 @@ struct Monitor {
 /* Let's add monitor global variables to this struct. */
 static struct {
     IOThread *mon_iothread;
-    /* Bottom half to dispatch the requests received from IO thread */
+    /* Bottom half to dispatch the requests received from I/O thread */
     QEMUBH *qmp_dispatcher_bh;
     /* Bottom half to deliver the responses back to clients */
     QEMUBH *qmp_respond_bh;
@@ -517,7 +517,7 @@ static void monitor_json_emitter(Monitor *mon, QObject *data)
 {
     if (mon->use_io_thr) {
         /*
-         * If using IO thread, we need to queue the item so that IO
+         * If using I/O thread, we need to queue the item so that I/O
          * thread will do the rest for us.  Take refcount so that
          * caller won't free the data (which will be finally freed in
          * responder thread).
@@ -528,7 +528,7 @@ static void monitor_json_emitter(Monitor *mon, QObject *data)
         qemu_bh_schedule(mon_global.qmp_respond_bh);
     } else {
         /*
-         * If not using monitor IO thread, then we are in main thread.
+         * If not using monitor I/O thread, then we are in main thread.
          * Do the emission right away.
          */
         monitor_json_emitter_raw(mon, data);
@@ -1268,7 +1268,7 @@ static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
             if (!mon->use_io_thr) {
                 /*
                  * Out-of-band only works with monitors that are
-                 * running on dedicated IOThread.
+                 * running on dedicated I/O thread.
                  */
                 error_setg(errp, "This monitor does not support "
                            "out-of-band (OOB)");
@@ -4402,7 +4402,7 @@ int monitor_suspend(Monitor *mon)
 
     if (monitor_is_qmp(mon)) {
         /*
-         * Kick iothread to make sure this takes effect.  It'll be
+         * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
         aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
@@ -4421,7 +4421,7 @@ void monitor_resume(Monitor *mon)
     if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
         if (monitor_is_qmp(mon)) {
             /*
-             * For QMP monitors that are running in IOThread, let's
+             * For QMP monitors that are running in I/O thread, let's
              * kick the thread in case it's sleeping.
              */
             if (mon->use_io_thr) {
@@ -4445,7 +4445,7 @@ static QObject *get_qmp_greeting(Monitor *mon)
 
     for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
         if (!mon->use_io_thr && cap == QMP_CAPABILITY_OOB) {
-            /* Monitors that are not using IOThread won't support OOB */
+            /* Monitors that are not using I/O thread won't support OOB */
             continue;
         }
         qlist_append_str(cap_list, QMPCapability_str(cap));
@@ -4586,9 +4586,9 @@ static void monitor_iothread_init(void)
                                               NULL);
 
     /*
-     * Unlike the dispatcher BH, this must be run on the monitor IO
-     * thread, so that monitors that are using IO thread will make
-     * sure read/write operations are all done on the IO thread.
+     * Unlike the dispatcher BH, this must be run on the monitor I/O
+     * thread, so that monitors that are using I/O thread will make
+     * sure read/write operations are all done on the I/O thread.
      */
     mon_global.qmp_respond_bh = aio_bh_new(monitor_get_aio_context(),
                                            monitor_qmp_bh_responder,
@@ -4660,7 +4660,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     if (mon->use_io_thr) {
         /*
          * When use_io_thr is set, we use the global shared dedicated
-         * IO thread for this monitor to handle input/output.
+         * I/O thread for this monitor to handle input/output.
          */
         context = monitor_get_io_context();
         /* We should have inited globals before reaching here. */
@@ -4717,7 +4717,7 @@ void monitor_init(Chardev *chr, int flags)
             /*
              * We can't call qemu_chr_fe_set_handlers() directly here
              * since during the procedure the chardev will be active
-             * and running in monitor iothread, while we'll still do
+             * and running in monitor I/O thread, while we'll still do
              * something before returning from it, which is a possible
              * race too.  To avoid that, we just create a BH to setup
              * the handlers.
@@ -4744,16 +4744,16 @@ void monitor_cleanup(void)
     Monitor *mon, *next;
 
     /*
-     * We need to explicitly stop the iothread (but not destroy it),
-     * cleanup the monitor resources, then destroy the iothread since
+     * We need to explicitly stop the I/O thread (but not destroy it),
+     * cleanup the monitor resources, then destroy the I/O thread since
      * we need to unregister from chardev below in
      * monitor_data_destroy(), and chardev is not thread-safe yet
      */
     iothread_stop(mon_global.mon_iothread);
 
     /*
-     * After we have IOThread to send responses, it's possible that
-     * when we stop the IOThread there are still replies queued in the
+     * After we have I/O thread to send responses, it's possible that
+     * when we stop the I/O thread there are still replies queued in the
      * responder queue.  Flush all of them.  Note that even after this
      * flush it's still possible that out buffer is not flushed.
      * It'll be done in below monitor_flush() as the last resort.
@@ -4769,7 +4769,7 @@ void monitor_cleanup(void)
     }
     qemu_mutex_unlock(&monitor_lock);
 
-    /* QEMUBHs needs to be deleted before destroying the IOThread. */
+    /* QEMUBHs needs to be deleted before destroying the I/O thread */
     qemu_bh_delete(mon_global.qmp_dispatcher_bh);
     mon_global.qmp_dispatcher_bh = NULL;
     qemu_bh_delete(mon_global.qmp_respond_bh);
-- 
2.17.1
