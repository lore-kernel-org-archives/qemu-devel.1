Received: from eggs.gnu.org ([2001:4830:134:3::10]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYsiF-0006yn-0x
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYsiD-0003jE-8P
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:41:19 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Fri, 29 Jun 2018 15:40:51 +0300
Message-Id: <20180629124052.331406-2-dplotnikov@virtuozzo.com>
In-Reply-To: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v0 1/2] async: add infrastructure for postponed
 actions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, reitz@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-stable@nongnu.org
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

There is the concept of iothreads servicing Block Driver States
via processing events on the corresponding aio context. Also,
there is a mechanism called "drained section" which is kind of
critical section, preventing an instance of Block Driver State
from processing external requests.

The "drained section" is respected by iothreads. While processing the
the event loop, the iothread stops its event loop from running until
the current context has no Block Driver States in drained section.

This scheme works for devices are able to work with iothread only.
There are other devices, e.g. ide, which don't work with iothreads.
The requests to those devices are processed by the main event loop
which doesn't stop processing the events on its context when there are
in "drained section" BlockDriverState-s.

Thereby, there is a case when the request can be processed when
the BDS don't expect that, for example, ide controller makes a request
when the VM finalizes the drive mirroring. This could lead to spoiling
the data consistency on those BDS'es.

To prevent this situation, the patch introduces the infrastructure
for postponing actions. The infrastructure allows postponing the
actions for the BDS to the moment when BDS's context becomes enabled
for external requests. When the context becomes enabled for external
requests all the postponed action are executed.

The not-iothread-friendly devices can use the infrastructure to
postpone the execution of the requests appeared when the context was
in "drained section".

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 include/block/aio.h | 63 +++++++++++++++++++++++++++++++++++++++++++++
 util/async.c        | 33 ++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index ae6f354e6c..ca61009e57 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -46,11 +46,24 @@ typedef struct AioHandler AioHandler;
 typedef void QEMUBHFunc(void *opaque);
 typedef bool AioPollFn(void *opaque);
 typedef void IOHandler(void *opaque);
+typedef void AioPostponedFunc(void *opaque);
 
 struct Coroutine;
 struct ThreadPool;
 struct LinuxAioState;
 
+/**
+ * Struct for postponing the actions
+ */
+typedef struct AioPostponedAction {
+    /* A function to run on context enabling */
+    AioPostponedFunc *func;
+    /* Param to be passed to the function */
+    void *func_param;
+    /**/
+    QSLIST_ENTRY(AioPostponedAction) next_action;
+} AioPostponedAction;
+
 struct AioContext {
     GSource source;
 
@@ -110,6 +123,16 @@ struct AioContext {
     EventNotifier notifier;
 
     QSLIST_HEAD(, Coroutine) scheduled_coroutines;
+
+    /* list of postponed actions
+     * The actions (might be thought as requests) which have been postponed
+     * because of the drained section was entered at the moment of their
+     * appearing.
+     * All these actions have to be run wheen the context is enabled for
+     * external requests.
+     */
+    QSLIST_HEAD(, AioPostponedAction) postponed_actions;
+
     QEMUBH *co_schedule_bh;
 
     /* Thread pool for performing work and receiving completion callbacks.
@@ -435,6 +458,41 @@ static inline void aio_timer_init(AioContext *ctx,
  */
 int64_t aio_compute_timeout(AioContext *ctx);
 
+/**
+ * aio_create_postponed_action:
+ * @ctx: the aio context
+ * @func: the function to postpone
+ * @param: the parameter to passed to the function
+ *
+ * Create a postponed action.
+ */
+AioPostponedAction *aio_create_postponed_action(
+                        AioPostponedFunc func, void *func_param);
+
+/**
+ * aio_postpone_action:
+ * @ctx: the aio context
+ * @action: the function and the parameter to passed to the function
+ *
+ * Queue an ation to the queue. The queue are processed and the actions
+ * are executed when the context becomes available to the external
+ * requests.
+ *
+ * Should be invoked under aio_context_acquire/release.
+ */
+void aio_postpone_action(AioContext *ctx, AioPostponedAction *action);
+
+/**
+ * aio_run_postponed_actions:
+ * @ctx: the aio context
+ *
+ * The function invokes all the actions queued to postponed action
+ * context queue.
+ *
+ * Should be invoked under aio_context_acquire/release.
+ */
+void aio_run_postponed_actions(AioContext *ctx);
+
 /**
  * aio_disable_external:
  * @ctx: the aio context
@@ -443,7 +501,9 @@ int64_t aio_compute_timeout(AioContext *ctx);
  */
 static inline void aio_disable_external(AioContext *ctx)
 {
+    aio_context_acquire(ctx);
     atomic_inc(&ctx->external_disable_cnt);
+    aio_context_release(ctx);
 }
 
 /**
@@ -456,12 +516,15 @@ static inline void aio_enable_external(AioContext *ctx)
 {
     int old;
 
+    aio_context_acquire(ctx);
     old = atomic_fetch_dec(&ctx->external_disable_cnt);
     assert(old > 0);
     if (old == 1) {
+        aio_run_postponed_actions(ctx);
         /* Kick event loop so it re-arms file descriptors */
         aio_notify(ctx);
     }
+    aio_context_release(ctx);
 }
 
 /**
diff --git a/util/async.c b/util/async.c
index 03f62787f2..e5fa35972e 100644
--- a/util/async.c
+++ b/util/async.c
@@ -278,6 +278,7 @@ aio_ctx_finalize(GSource     *source)
 #endif
 
     assert(QSLIST_EMPTY(&ctx->scheduled_coroutines));
+    assert(QSLIST_EMPTY(&ctx->postponed_actions));
     qemu_bh_delete(ctx->co_schedule_bh);
 
     qemu_lockcnt_lock(&ctx->list_lock);
@@ -415,6 +416,7 @@ AioContext *aio_context_new(Error **errp)
 
     ctx->co_schedule_bh = aio_bh_new(ctx, co_schedule_bh_cb, ctx);
     QSLIST_INIT(&ctx->scheduled_coroutines);
+    QSLIST_INIT(&ctx->postponed_actions);
 
     aio_set_event_notifier(ctx, &ctx->notifier,
                            false,
@@ -507,3 +509,34 @@ void aio_context_release(AioContext *ctx)
 {
     qemu_rec_mutex_unlock(&ctx->lock);
 }
+
+AioPostponedAction *aio_create_postponed_action(
+                        AioPostponedFunc func, void *func_param)
+{
+    AioPostponedAction *action = g_malloc(sizeof(AioPostponedAction));
+    action->func = func;
+    action->func_param = func_param;
+    return action;
+}
+
+static void aio_destroy_postponed_action(AioPostponedAction *action)
+{
+    g_free(action);
+}
+
+/* should be run under aio_context_aquire/release */
+void aio_postpone_action(AioContext *ctx, AioPostponedAction *action)
+{
+    QSLIST_INSERT_HEAD(&ctx->postponed_actions, action, next_action);
+}
+
+/* should be run under aio_context_aquire/release */
+void aio_run_postponed_actions(AioContext *ctx)
+{
+    while(!QSLIST_EMPTY(&ctx->postponed_actions)) {
+        AioPostponedAction *action = QSLIST_FIRST(&ctx->postponed_actions);
+        QSLIST_REMOVE_HEAD(&ctx->postponed_actions, next_action);
+        action->func(action->func_param);
+        aio_destroy_postponed_action(action);
+    }
+}
-- 
2.17.0
