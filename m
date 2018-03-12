Received: from eggs.gnu.org ([208.118.235.92]:51467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPtS-0005sk-E9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPtM-00027o-E4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:01:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 12 Mar 2018 16:01:25 +0000
Message-Id: <20180312160125.7596-2-stefanha@redhat.com>
In-Reply-To: <20180312160125.7596-1-stefanha@redhat.com>
References: <20180312160125.7596-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] block: make BDRV_POLL_WHILE() re-entrancy
 safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Nested BDRV_POLL_WHILE() calls can occur.  Currently
assert(!wait_->wakeup) fails in AIO_WAIT_WHILE() when this happens.

This patch converts the bool wait_->need_kick flag to an unsigned
wait_->num_waiters counter.

Nesting works correctly because outer AIO_WAIT_WHILE() callers evaluate
the condition again after the inner caller completes (invoking the inner
caller counts as aio_poll() progress).

Reported-by: "fuweiwei (C)" <fuweiwei2@huawei.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180307124619.6218-1-stefanha@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio-wait.h | 61 ++++++++++++++++++++++++------------------------
 util/aio-wait.c          |  2 +-
 2 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
index f7a3972200..8c90a2e66e 100644
--- a/include/block/aio-wait.h
+++ b/include/block/aio-wait.h
@@ -50,8 +50,8 @@
  *   }
  */
 typedef struct {
-    /* Is the main loop waiting for a kick?  Accessed with atomic ops. */
-    bool need_kick;
+    /* Number of waiting AIO_WAIT_WHILE() callers. Accessed with atomic ops. */
+    unsigned num_waiters;
 } AioWait;
 
 /**
@@ -71,35 +71,34 @@ typedef struct {
  * wait on conditions between two IOThreads since that could lead to deadlock,
  * go via the main loop instead.
  */
-#define AIO_WAIT_WHILE(wait, ctx, cond) ({                  \
-    bool waited_ = false;                                   \
-    bool busy_ = true;                                      \
-    AioWait *wait_ = (wait);                                \
-    AioContext *ctx_ = (ctx);                               \
-    if (in_aio_context_home_thread(ctx_)) {                 \
-        while ((cond) || busy_) {                           \
-            busy_ = aio_poll(ctx_, (cond));                 \
-            waited_ |= !!(cond) | busy_;                    \
-        }                                                   \
-    } else {                                                \
-        assert(qemu_get_current_aio_context() ==            \
-               qemu_get_aio_context());                     \
-        assert(!wait_->need_kick);                          \
-        /* Set wait_->need_kick before evaluating cond.  */ \
-        atomic_mb_set(&wait_->need_kick, true);             \
-        while (busy_) {                                     \
-            if ((cond)) {                                   \
-                waited_ = busy_ = true;                     \
-                aio_context_release(ctx_);                  \
-                aio_poll(qemu_get_aio_context(), true);     \
-                aio_context_acquire(ctx_);                  \
-            } else {                                        \
-                busy_ = aio_poll(ctx_, false);              \
-                waited_ |= busy_;                           \
-            }                                               \
-        }                                                   \
-        atomic_set(&wait_->need_kick, false);               \
-    }                                                       \
+#define AIO_WAIT_WHILE(wait, ctx, cond) ({                         \
+    bool waited_ = false;                                          \
+    bool busy_ = true;                                             \
+    AioWait *wait_ = (wait);                                       \
+    AioContext *ctx_ = (ctx);                                      \
+    if (in_aio_context_home_thread(ctx_)) {                        \
+        while ((cond) || busy_) {                                  \
+            busy_ = aio_poll(ctx_, (cond));                        \
+            waited_ |= !!(cond) | busy_;                           \
+        }                                                          \
+    } else {                                                       \
+        assert(qemu_get_current_aio_context() ==                   \
+               qemu_get_aio_context());                            \
+        /* Increment wait_->num_waiters before evaluating cond. */ \
+        atomic_inc(&wait_->num_waiters);                           \
+        while (busy_) {                                            \
+            if ((cond)) {                                          \
+                waited_ = busy_ = true;                            \
+                aio_context_release(ctx_);                         \
+                aio_poll(qemu_get_aio_context(), true);            \
+                aio_context_acquire(ctx_);                         \
+            } else {                                               \
+                busy_ = aio_poll(ctx_, false);                     \
+                waited_ |= busy_;                                  \
+            }                                                      \
+        }                                                          \
+        atomic_dec(&wait_->num_waiters);                           \
+    }                                                              \
     waited_; })
 
 /**
diff --git a/util/aio-wait.c b/util/aio-wait.c
index 975afddf4c..b8a8f86dba 100644
--- a/util/aio-wait.c
+++ b/util/aio-wait.c
@@ -34,7 +34,7 @@ static void dummy_bh_cb(void *opaque)
 void aio_wait_kick(AioWait *wait)
 {
     /* The barrier (or an atomic op) is in the caller.  */
-    if (atomic_read(&wait->need_kick)) {
+    if (atomic_read(&wait->num_waiters)) {
         aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
     }
 }
-- 
2.14.3
