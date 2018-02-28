Received: from eggs.gnu.org ([2001:4830:134:3::10]:46065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1er6Kg-0008Cm-3K
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1er6Kc-0000lK-SF
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:20:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 28 Feb 2018 18:19:46 +0000
Message-Id: <20180228181946.22958-5-stefanha@redhat.com>
In-Reply-To: <20180228181946.22958-1-stefanha@redhat.com>
References: <20180228181946.22958-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Commit 00d09fdbbae5f7864ce754913efc84c12fdf9f1a ("vl: pause vcpus before
stopping iothreads") and commit dce8921b2baaf95974af8176406881872067adfa
("iothread: Stop threads before main() quits") tried to work around the
fact that emulation was still active during termination by stopping
iothreads.  They suffer from race conditions:
1. virtio_scsi_handle_cmd_vq() racing with iothread_stop_all() hits the
   virtio_scsi_ctx_check() assertion failure because the BDS AioContext
   has been modified by iothread_stop_all().
2. Guest vq kick racing with main loop termination leaves a readable
   ioeventfd that is handled by the next aio_poll() when external
   clients are enabled again, resulting in unwanted emulation activity.

This patch obsoletes those commits by fully disabling emulation activity
when vcpus are stopped.

Use the new vm_shutdown() function instead of pause_all_vcpus() so that
vm change state handlers are invoked too.  Virtio devices will now stop
their ioeventfds, preventing further emulation activity after vm_stop().

Note that vm_stop(RUN_STATE_SHUTDOWN) cannot be used because it emits a
QMP STOP event that may affect existing clients.

It is no longer necessary to call replay_disable_events() directly since
vm_shutdown() does so already.

Drop iothread_stop_all() since it is no longer used.

Cc: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/iothread.h |  1 -
 include/sysemu/sysemu.h   |  1 +
 cpus.c                    | 16 +++++++++++++---
 iothread.c                | 31 -------------------------------
 vl.c                      | 13 +++----------
 5 files changed, 17 insertions(+), 45 deletions(-)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 799614ffd2..8a7ac2c528 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -45,7 +45,6 @@ typedef struct {
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
-void iothread_stop_all(void);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 /*
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 77bb3da582..54f91dbc03 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -55,6 +55,7 @@ void vm_start(void);
 int vm_prepare_start(void);
 int vm_stop(RunState state);
 int vm_stop_force_state(RunState state);
+int vm_shutdown(void);
 
 typedef enum WakeupReason {
     /* Always keep QEMU_WAKEUP_REASON_NONE = 0 */
diff --git a/cpus.c b/cpus.c
index f298b659f4..90279f73fc 100644
--- a/cpus.c
+++ b/cpus.c
@@ -993,7 +993,7 @@ void cpu_synchronize_all_pre_loadvm(void)
     }
 }
 
-static int do_vm_stop(RunState state)
+static int do_vm_stop(RunState state, bool send_stop)
 {
     int ret = 0;
 
@@ -1002,7 +1002,9 @@ static int do_vm_stop(RunState state)
         pause_all_vcpus();
         runstate_set(state);
         vm_state_notify(0, state);
-        qapi_event_send_stop(&error_abort);
+        if (send_stop) {
+            qapi_event_send_stop(&error_abort);
+        }
     }
 
     bdrv_drain_all();
@@ -1012,6 +1014,14 @@ static int do_vm_stop(RunState state)
     return ret;
 }
 
+/* Special vm_stop() variant for terminating the process.  Historically clients
+ * did not expect a QMP STOP event and so we need to retain compatibility.
+ */
+int vm_shutdown(void)
+{
+    return do_vm_stop(RUN_STATE_SHUTDOWN, false);
+}
+
 static bool cpu_can_run(CPUState *cpu)
 {
     if (cpu->stop) {
@@ -2007,7 +2017,7 @@ int vm_stop(RunState state)
         return 0;
     }
 
-    return do_vm_stop(state);
+    return do_vm_stop(state, true);
 }
 
 /**
diff --git a/iothread.c b/iothread.c
index 4b9bbde4cd..68d92086e3 100644
--- a/iothread.c
+++ b/iothread.c
@@ -101,18 +101,6 @@ void iothread_stop(IOThread *iothread)
     qemu_thread_join(&iothread->thread);
 }
 
-static int iothread_stop_iter(Object *object, void *opaque)
-{
-    IOThread *iothread;
-
-    iothread = (IOThread *)object_dynamic_cast(object, TYPE_IOTHREAD);
-    if (!iothread) {
-        return 0;
-    }
-    iothread_stop(iothread);
-    return 0;
-}
-
 static void iothread_instance_init(Object *obj)
 {
     IOThread *iothread = IOTHREAD(obj);
@@ -333,25 +321,6 @@ IOThreadInfoList *qmp_query_iothreads(Error **errp)
     return head;
 }
 
-void iothread_stop_all(void)
-{
-    Object *container = object_get_objects_root();
-    BlockDriverState *bs;
-    BdrvNextIterator it;
-
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        AioContext *ctx = bdrv_get_aio_context(bs);
-        if (ctx == qemu_get_aio_context()) {
-            continue;
-        }
-        aio_context_acquire(ctx);
-        bdrv_set_aio_context(bs, qemu_get_aio_context());
-        aio_context_release(ctx);
-    }
-
-    object_child_foreach(container, iothread_stop_iter, NULL);
-}
-
 static gpointer iothread_g_main_context_init(gpointer opaque)
 {
     AioContext *ctx;
diff --git a/vl.c b/vl.c
index 9e7235df6d..de719ae756 100644
--- a/vl.c
+++ b/vl.c
@@ -4755,17 +4755,10 @@ int main(int argc, char **argv, char **envp)
     os_setup_post();
 
     main_loop();
-    replay_disable_events();
 
-    /* The ordering of the following is delicate.  Stop vcpus to prevent new
-     * I/O requests being queued by the guest.  Then stop IOThreads (this
-     * includes a drain operation and completes all request processing).  At
-     * this point emulated devices are still associated with their IOThreads
-     * (if any) but no longer have any work to do.  Only then can we close
-     * block devices safely because we know there is no more I/O coming.
-     */
-    pause_all_vcpus();
-    iothread_stop_all();
+    /* No more vcpu or device emulation activity beyond this point */
+    vm_shutdown();
+
     bdrv_close_all();
 
     res_free();
-- 
2.14.3
