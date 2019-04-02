Received: from eggs.gnu.org ([209.51.188.92]:54857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hBIXa-00026p-Sx
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hBIXZ-0002Hz-AM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:29:22 -0400
From: Sergio Lopez <slp@redhat.com>
Date: Tue,  2 Apr 2019 14:19:08 +0200
Message-Id: <20190402121908.44081-1-slp@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH] aio: Add a knob to always poll if there
 are in-flight requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, Sergio Lopez <slp@redhat.com>

The polling mode in aio_poll is able to trim down ~20us on the average
request latency, but it needs manual fine tuning to adjust it to the
characteristics of the storage.

Here we add a new knob to the IOThread object, "poll-inflight". When
this knob is enabled, aio_poll will always use polling if there are
in-flight requests, ignoring the rest of poll-* parameters. If there
aren't any in-flight requests, the usual polling rules apply, which is
useful given that the default poll-max-ns value of 32us is usually
enough to catch a new request in the VQ when the Guest is putting
pressure on us.

To keep track of the number of in-flight requests, AioContext has a
new counter which is increased/decreased by thread-pool.c and
linux-aio.c on request submission/completion.

With poll-inflight, users willing to spend more Host CPU resources in
exchange for a lower latency just need to enable a single knob.

This is just an initial version of this feature and I'm just sharing
it to get some early feedback. As such, managing this property through
QAPI is not yet implemented.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 block/linux-aio.c         |  7 +++++++
 include/block/aio.h       |  9 ++++++++-
 include/sysemu/iothread.h |  1 +
 iothread.c                | 33 +++++++++++++++++++++++++++++++++
 util/aio-posix.c          | 32 +++++++++++++++++++++++++++++++-
 util/thread-pool.c        |  3 +++
 6 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index d4b61fb251..ab6b1f6941 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -219,6 +219,7 @@ static void qemu_laio_process_completions(LinuxAioSta=
te *s)
             /* Change counters one-by-one because we can be nested. */
             s->io_q.in_flight--;
             s->event_idx++;
+            atomic_dec(&s->aio_context->inflight_reqs);
             qemu_laio_process_completion(laiocb);
         }
     }
@@ -311,6 +312,7 @@ static void ioq_submit(LinuxAioState *s)
     int ret, len;
     struct qemu_laiocb *aiocb;
     struct iocb *iocbs[MAX_EVENTS];
+    unsigned int prev_inflight =3D s->io_q.in_flight;
     QSIMPLEQ_HEAD(, qemu_laiocb) completed;
=20
     do {
@@ -346,6 +348,11 @@ static void ioq_submit(LinuxAioState *s)
     } while (ret =3D=3D len && !QSIMPLEQ_EMPTY(&s->io_q.pending));
     s->io_q.blocked =3D (s->io_q.in_queue > 0);
=20
+    if (s->io_q.in_flight > prev_inflight) {
+        atomic_add(&s->aio_context->inflight_reqs,
+                   s->io_q.in_flight - prev_inflight);
+    }
+
     if (s->io_q.in_flight) {
         /* We can try to complete something just right away if there are
          * still requests in-flight. */
diff --git a/include/block/aio.h b/include/block/aio.h
index 0ca25dfec6..ae590b6e98 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -140,6 +140,12 @@ struct AioContext {
     int64_t poll_grow;      /* polling time growth factor */
     int64_t poll_shrink;    /* polling time shrink factor */
=20
+    /* If enabled, we'll keep polling (ignoring polling mode parameters)
+     * when there are in-flight requests.
+     */
+    bool poll_inflight;
+    unsigned int inflight_reqs; /* number of in-flight requests */
+
     /* Are we in polling mode or monitoring file descriptors? */
     bool poll_started;
=20
@@ -616,11 +622,12 @@ void aio_context_destroy(AioContext *ctx);
  * @max_ns: how long to busy poll for, in nanoseconds
  * @grow: polling time growth factor
  * @shrink: polling time shrink factor
+ * @inflight: should we keep polling if there are in-flight requests?
  *
  * Poll mode can be disabled by setting poll_max_ns to 0.
  */
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink,
-                                 Error **errp);
+                                 bool inflight, Error **errp);
=20
 #endif
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 5f6240d5cb..a2bc799a91 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -36,6 +36,7 @@ typedef struct {
     int64_t poll_max_ns;
     int64_t poll_grow;
     int64_t poll_shrink;
+    bool poll_inflight;
 } IOThread;
=20
 #define IOTHREAD(obj) \
diff --git a/iothread.c b/iothread.c
index 7130be58e3..01624e758f 100644
--- a/iothread.c
+++ b/iothread.c
@@ -185,6 +185,7 @@ static void iothread_complete(UserCreatable *obj, Err=
or **errp)
                                 iothread->poll_max_ns,
                                 iothread->poll_grow,
                                 iothread->poll_shrink,
+                                iothread->poll_inflight,
                                 &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
@@ -261,6 +262,7 @@ static void iothread_set_poll_param(Object *obj, Visi=
tor *v,
                                     iothread->poll_max_ns,
                                     iothread->poll_grow,
                                     iothread->poll_shrink,
+                                    iothread->poll_inflight,
                                     &local_err);
     }
=20
@@ -268,6 +270,33 @@ out:
     error_propagate(errp, local_err);
 }
=20
+static bool iothread_get_poll_inflight(Object *obj, Error **errp)
+{
+    IOThread *iothread =3D IOTHREAD(obj);
+
+    return iothread->poll_inflight;
+}
+
+static void iothread_set_poll_inflight(Object *obj, bool value,
+        Error **errp)
+{
+    IOThread *iothread =3D IOTHREAD(obj);
+    Error *local_err =3D NULL;
+
+    iothread->poll_inflight =3D value;
+
+    if (iothread->ctx) {
+        aio_context_set_poll_params(iothread->ctx,
+                                    iothread->poll_max_ns,
+                                    iothread->poll_grow,
+                                    iothread->poll_shrink,
+                                    iothread->poll_inflight,
+                                    &local_err);
+    }
+
+    error_propagate(errp, local_err);
+}
+
 static void iothread_class_init(ObjectClass *klass, void *class_data)
 {
     UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(klass);
@@ -285,6 +314,10 @@ static void iothread_class_init(ObjectClass *klass, =
void *class_data)
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_shrink_info, &error_abort);
+    object_class_property_add_bool(klass, "poll-inflight",
+                                   iothread_get_poll_inflight,
+                                   iothread_set_poll_inflight,
+                                   &error_abort);
 }
=20
 static const TypeInfo iothread_info =3D {
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 506aa69054..43d030da41 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -606,6 +606,29 @@ static bool try_poll_mode(AioContext *ctx, int64_t *=
timeout)
     return run_poll_handlers_once(ctx, timeout);
 }
=20
+/* aio_poll variant used when there are in-flight requests, that just do=
es
+ * polling unconditionally, without checking or adjusting poll-ns parame=
ters.
+ */
+static bool aio_poll_inflight(AioContext *ctx, bool blocking)
+{
+    bool progress =3D false;
+    int64_t timeout;
+
+    qemu_lockcnt_inc(&ctx->list_lock);
+
+    poll_set_started(ctx, true);
+    while (blocking && !progress) {
+        progress |=3D run_poll_handlers_once(ctx, &timeout);
+        progress |=3D aio_bh_poll(ctx);
+    }
+    poll_set_started(ctx, false);
+
+    qemu_lockcnt_dec(&ctx->list_lock);
+
+    progress |=3D timerlistgroup_run_timers(&ctx->tlg);
+    return progress;
+}
+
 bool aio_poll(AioContext *ctx, bool blocking)
 {
     AioHandler *node;
@@ -617,6 +640,11 @@ bool aio_poll(AioContext *ctx, bool blocking)
=20
     assert(in_aio_context_home_thread(ctx));
=20
+    if (ctx->poll_inflight && !atomic_read(&ctx->poll_disable_cnt)
+        && atomic_read(&ctx->inflight_reqs)) {
+        return aio_poll_inflight(ctx, blocking);
+    }
+
     /* aio_notify can avoid the expensive event_notifier_set if
      * everything (file descriptors, bottom halves, timers) will
      * be re-evaluated before the next blocking poll().  This is
@@ -759,7 +787,8 @@ void aio_context_destroy(AioContext *ctx)
 }
=20
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
-                                 int64_t grow, int64_t shrink, Error **e=
rrp)
+                                 int64_t grow, int64_t shrink, bool infl=
ight,
+                                 Error **errp)
 {
     /* No thread synchronization here, it doesn't matter if an incorrect=
 value
      * is used once.
@@ -768,6 +797,7 @@ void aio_context_set_poll_params(AioContext *ctx, int=
64_t max_ns,
     ctx->poll_ns =3D 0;
     ctx->poll_grow =3D grow;
     ctx->poll_shrink =3D shrink;
+    ctx->poll_inflight =3D inflight;
=20
     aio_notify(ctx);
 }
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 610646d131..13bad68222 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -101,6 +101,7 @@ static void *worker_thread(void *opaque)
         QTAILQ_REMOVE(&pool->request_list, req, reqs);
         req->state =3D THREAD_ACTIVE;
         qemu_mutex_unlock(&pool->lock);
+        atomic_dec(&pool->ctx->inflight_reqs);
=20
         ret =3D req->func(req->arg);
=20
@@ -220,6 +221,7 @@ static void thread_pool_cancel(BlockAIOCB *acb)
          */
         qemu_sem_timedwait(&pool->sem, 0) =3D=3D 0) {
         QTAILQ_REMOVE(&pool->request_list, elem, reqs);
+        atomic_dec(&pool->ctx->inflight_reqs);
         qemu_bh_schedule(pool->completion_bh);
=20
         elem->state =3D THREAD_DONE;
@@ -264,6 +266,7 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPool *pool,
     }
     QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
     qemu_mutex_unlock(&pool->lock);
+    atomic_inc(&pool->ctx->inflight_reqs);
     qemu_sem_post(&pool->sem);
     return &req->common;
 }
--=20
2.20.1
