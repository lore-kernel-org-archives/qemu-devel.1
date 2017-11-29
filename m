Received: from eggs.gnu.org ([2001:4830:134:3::10]:41416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3i8-0005TU-Od
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3i7-00061K-I1
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:51:40 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 22:49:49 +0800
Message-Id: <20171129144956.11409-3-famz@redhat.com>
In-Reply-To: <20171129144956.11409-1-famz@redhat.com>
References: <20171129144956.11409-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/9] aio: Add drain begin/end API to
 AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/block/aio.h | 27 +++++++++++++++++---
 util/async.c        | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index e9aeeaec94..40c2f64544 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -47,6 +47,15 @@ typedef void QEMUBHFunc(void *opaque);
 typedef bool AioPollFn(void *opaque);
 typedef void IOHandler(void *opaque);
 
+typedef void AioDrainFn(void *opaque);
+typedef struct AioDrainOps {
+    AioDrainFn *drained_begin;
+    AioDrainFn *drained_end;
+    void *opaque;
+    bool is_new;
+    QTAILQ_ENTRY(AioDrainOps) next;
+} AioDrainOps;
+
 struct Coroutine;
 struct ThreadPool;
 struct LinuxAioState;
@@ -147,6 +156,9 @@ struct AioContext {
     int epollfd;
     bool epoll_enabled;
     bool epoll_available;
+
+    QTAILQ_HEAD(, AioDrainOps) drain_ops;
+    bool drain_ops_updated;
 };
 
 /**
@@ -441,9 +453,9 @@ int64_t aio_compute_timeout(AioContext *ctx);
  *
  * Disable the further processing of external clients.
  */
-static inline void aio_disable_external(AioContext *ctx)
+static inline bool aio_disable_external(AioContext *ctx)
 {
-    atomic_inc(&ctx->external_disable_cnt);
+    return atomic_fetch_inc(&ctx->external_disable_cnt) == 0;
 }
 
 /**
@@ -452,7 +464,7 @@ static inline void aio_disable_external(AioContext *ctx)
  *
  * Enable the processing of external clients.
  */
-static inline void aio_enable_external(AioContext *ctx)
+static inline bool aio_enable_external(AioContext *ctx)
 {
     int old;
 
@@ -462,6 +474,7 @@ static inline void aio_enable_external(AioContext *ctx)
         /* Kick event loop so it re-arms file descriptors */
         aio_notify(ctx);
     }
+    return old == 1;
 }
 
 /**
@@ -564,4 +577,12 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink,
                                  Error **errp);
 
+void aio_context_drained_begin(AioContext *ctx);
+void aio_context_drained_end(AioContext *ctx);
+
+void aio_context_add_drain_ops(AioContext *ctx,
+                               AioDrainFn *begin, AioDrainFn *end, void *opaque);
+void aio_context_del_drain_ops(AioContext *ctx,
+                               AioDrainFn *begin, AioDrainFn *end, void *opaque);
+
 #endif
diff --git a/util/async.c b/util/async.c
index 4dd9d95a9e..cca0efd263 100644
--- a/util/async.c
+++ b/util/async.c
@@ -402,6 +402,7 @@ AioContext *aio_context_new(Error **errp)
     AioContext *ctx;
 
     ctx = (AioContext *) g_source_new(&aio_source_funcs, sizeof(AioContext));
+    QTAILQ_INIT(&ctx->drain_ops);
     aio_context_setup(ctx);
 
     ret = event_notifier_init(&ctx->notifier, false);
@@ -506,3 +507,75 @@ void aio_context_release(AioContext *ctx)
 {
     qemu_rec_mutex_unlock(&ctx->lock);
 }
+
+/* Called with ctx->lock */
+void aio_context_drained_begin(AioContext *ctx)
+{
+    AioDrainOps *ops;
+
+    /* TODO: When all external fds are handled in the following drain_ops
+     * callbacks, aio_disable_external can be dropped. */
+    aio_disable_external(ctx);
+restart:
+    ctx->drain_ops_updated = false;
+    QTAILQ_FOREACH(ops, &ctx->drain_ops, next) {
+        ops->drained_begin(ops->opaque);
+        if (ctx->drain_ops_updated) {
+            goto restart;
+        }
+    }
+}
+
+/* Called with ctx->lock */
+void aio_context_drained_end(AioContext *ctx)
+{
+    AioDrainOps *ops;
+
+restart:
+    ctx->drain_ops_updated = false;
+    QTAILQ_FOREACH(ops, &ctx->drain_ops, next) {
+        if (ops->is_new) {
+            continue;
+        }
+        ops->drained_end(ops->opaque);
+        if (ctx->drain_ops_updated) {
+            goto restart;
+        }
+    }
+    if (aio_enable_external(ctx)) {
+        QTAILQ_FOREACH(ops, &ctx->drain_ops, next) {
+            ops->is_new = false;
+        }
+    }
+}
+
+/* Called with ctx->lock */
+void aio_context_add_drain_ops(AioContext *ctx,
+                               AioDrainFn *begin, AioDrainFn *end, void *opaque)
+{
+    AioDrainOps *ops = g_new0(AioDrainOps, 1);
+    ops->drained_begin = begin;
+    ops->drained_end = end;
+    ops->opaque = opaque;
+    ops->is_new = true;
+    QTAILQ_INSERT_TAIL(&ctx->drain_ops, ops, next);
+    ctx->drain_ops_updated = true;
+}
+
+/* Called with ctx->lock */
+void aio_context_del_drain_ops(AioContext *ctx,
+                               AioDrainFn *begin, AioDrainFn *end, void *opaque)
+{
+    AioDrainOps *ops;
+
+    QTAILQ_FOREACH(ops, &ctx->drain_ops, next) {
+        if (ops->drained_begin == begin &&
+            ops->drained_end == end &&
+            ops->opaque == opaque) {
+            QTAILQ_REMOVE(&ctx->drain_ops, ops, next);
+            ctx->drain_ops_updated = true;
+            g_free(ops);
+            return;
+        }
+    }
+}
-- 
2.14.3
