Received: from eggs.gnu.org ([2001:4830:134:3::10]:52630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gNjNj-0006c8-L2
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 14:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gNjNe-0004gY-5c
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 14:02:19 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1gNjNd-0004g2-Az
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 14:02:13 -0500
Received: by mail-wm1-x343.google.com with SMTP id r11-v6so23027602wmb.2
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:02:12 -0800 (PST)
From: remy.noel@blade-group.com
Date: Fri, 16 Nov 2018 20:02:10 +0100
Message-Id: <20181116190211.17622-4-remy.noel@blade-group.com>
In-Reply-To: <20181116190211.17622-1-remy.noel@blade-group.com>
References: <20181116190211.17622-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] aio: Do not use list_lock as a sync mechanism for
 aio_handlers anymore.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Remy Noel <remy.noel@blade-group.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>

From: Remy Noel <remy.noel@blade-group.com>

It is still used for bottom halves though and to avoid concurent
set_fd_handlers (We could probably decorrelate the two, but
set_fd_handlers are quite rare so it probably isn't worth it).

Signed-off-by: Remy Noel <remy.noel@blade-group.com>
---
 include/block/aio.h |  4 +++-
 util/aio-posix.c    | 20 --------------------
 util/aio-win32.c    |  9 ---------
 util/async.c        |  7 +++++--
 4 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 0ca25dfec6..99c17a22f7 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -57,7 +57,9 @@ struct AioContext {
     /* Used by AioContext users to protect from multi-threaded access.  */
     QemuRecMutex lock;
 
-    /* The list of registered AIO handlers.  Protected by ctx->list_lock. */
+    /* The list of registered AIO handlers.
+     * RCU-enabled, writes rotected by ctx->list_lock.
+     */
     QLIST_HEAD(, AioHandler) aio_handlers;
 
     /* Used to avoid unnecessary event_notifier_set calls in aio_notify;
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 83db3f65f4..46b7c571cc 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -341,7 +341,6 @@ static void poll_set_started(AioContext *ctx, bool started)
 
     ctx->poll_started = started;
 
-    qemu_lockcnt_inc(&ctx->list_lock);
     rcu_read_lock();
     QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         IOHandler *fn;
@@ -357,7 +356,6 @@ static void poll_set_started(AioContext *ctx, bool started)
         }
     }
     rcu_read_unlock();
-    qemu_lockcnt_dec(&ctx->list_lock);
 }
 
 
@@ -374,12 +372,6 @@ bool aio_pending(AioContext *ctx)
     AioHandler *node;
     bool result = false;
 
-    /*
-     * We have to walk very carefully in case aio_set_fd_handler is
-     * called while we're walking.
-     */
-    qemu_lockcnt_inc(&ctx->list_lock);
-
     rcu_read_lock();
     QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         int revents;
@@ -397,7 +389,6 @@ bool aio_pending(AioContext *ctx)
         }
     }
     rcu_read_unlock();
-    qemu_lockcnt_dec(&ctx->list_lock);
 
     return result;
 }
@@ -438,10 +429,8 @@ static bool aio_dispatch_handlers(AioContext *ctx)
 
 void aio_dispatch(AioContext *ctx)
 {
-    qemu_lockcnt_inc(&ctx->list_lock);
     aio_bh_poll(ctx);
     aio_dispatch_handlers(ctx);
-    qemu_lockcnt_dec(&ctx->list_lock);
 
     timerlistgroup_run_timers(&ctx->tlg);
 }
@@ -524,8 +513,6 @@ static bool run_poll_handlers_once(AioContext *ctx, int64_t *timeout)
  * Note that ctx->notify_me must be non-zero so this function can detect
  * aio_notify().
  *
- * Note that the caller must have incremented ctx->list_lock.
- *
  * Returns: true if progress was made, false otherwise
  */
 static bool run_poll_handlers(AioContext *ctx, int64_t max_ns, int64_t *timeout)
@@ -534,7 +521,6 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns, int64_t *timeout)
     int64_t start_time, elapsed_time;
 
     assert(ctx->notify_me);
-    assert(qemu_lockcnt_count(&ctx->list_lock) > 0);
 
     trace_run_poll_handlers_begin(ctx, max_ns, *timeout);
 
@@ -563,8 +549,6 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns, int64_t *timeout)
  *
  * ctx->notify_me must be non-zero so this function can detect aio_notify().
  *
- * Note that the caller must have incremented ctx->list_lock.
- *
  * Returns: true if progress was made, false otherwise
  */
 static bool try_poll_mode(AioContext *ctx, int64_t *timeout)
@@ -609,8 +593,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
         atomic_add(&ctx->notify_me, 2);
     }
 
-    qemu_lockcnt_inc(&ctx->list_lock);
-
     if (ctx->poll_max_ns) {
         start = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     }
@@ -713,8 +695,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
         progress |= aio_dispatch_handlers(ctx);
     }
 
-    qemu_lockcnt_dec(&ctx->list_lock);
-
     progress |= timerlistgroup_run_timers(&ctx->tlg);
 
     return progress;
diff --git a/util/aio-win32.c b/util/aio-win32.c
index d7c694e5ac..881bad0c28 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -176,7 +176,6 @@ bool aio_prepare(AioContext *ctx)
      * We have to walk very carefully in case aio_set_fd_handler is
      * called while we're walking.
      */
-    qemu_lockcnt_inc(&ctx->list_lock);
     rcu_read_lock();
 
     /* fill fd sets */
@@ -206,7 +205,6 @@ bool aio_prepare(AioContext *ctx)
         }
     }
     rcu_read_unlock();
-    qemu_lockcnt_dec(&ctx->list_lock);
     return have_select_revents;
 }
 
@@ -219,7 +217,6 @@ bool aio_pending(AioContext *ctx)
      * We have to walk very carefully in case aio_set_fd_handler is
      * called while we're walking.
      */
-    qemu_lockcnt_inc(&ctx->list_lock);
     rcu_read_lock();
     QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         if (node->pfd.revents && node->io_notify) {
@@ -238,7 +235,6 @@ bool aio_pending(AioContext *ctx)
     }
 
     rcu_read_unlock();
-    qemu_lockcnt_dec(&ctx->list_lock);
     return result;
 }
 
@@ -296,10 +292,8 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
 
 void aio_dispatch(AioContext *ctx)
 {
-    qemu_lockcnt_inc(&ctx->list_lock);
     aio_bh_poll(ctx);
     aio_dispatch_handlers(ctx, INVALID_HANDLE_VALUE);
-    qemu_lockcnt_dec(&ctx->list_lock);
     timerlistgroup_run_timers(&ctx->tlg);
 }
 
@@ -324,7 +318,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
         atomic_add(&ctx->notify_me, 2);
     }
 
-    qemu_lockcnt_inc(&ctx->list_lock);
     have_select_revents = aio_prepare(ctx);
 
     /* fill fd sets */
@@ -381,8 +374,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
         progress |= aio_dispatch_handlers(ctx, event);
     } while (count > 0);
 
-    qemu_lockcnt_dec(&ctx->list_lock);
-
     progress |= timerlistgroup_run_timers(&ctx->tlg);
     return progress;
 }
diff --git a/util/async.c b/util/async.c
index c10642a385..5078deed83 100644
--- a/util/async.c
+++ b/util/async.c
@@ -100,6 +100,8 @@ int aio_bh_poll(AioContext *ctx)
     int ret;
     bool deleted = false;
 
+    qemu_lockcnt_inc(&ctx->list_lock);
+
     ret = 0;
     for (bh = atomic_rcu_read(&ctx->first_bh); bh; bh = next) {
         next = atomic_rcu_read(&bh->next);
@@ -124,10 +126,11 @@ int aio_bh_poll(AioContext *ctx)
 
     /* remove deleted bhs */
     if (!deleted) {
+        qemu_lockcnt_dec(&ctx->list_lock);
         return ret;
     }
 
-    if (qemu_lockcnt_dec_if_lock(&ctx->list_lock)) {
+    if (qemu_lockcnt_dec_and_lock(&ctx->list_lock)) {
         bhp = &ctx->first_bh;
         while (*bhp) {
             bh = *bhp;
@@ -138,7 +141,7 @@ int aio_bh_poll(AioContext *ctx)
                 bhp = &bh->next;
             }
         }
-        qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
+        qemu_lockcnt_unlock(&ctx->list_lock);
     }
     return ret;
 }
-- 
2.19.1
