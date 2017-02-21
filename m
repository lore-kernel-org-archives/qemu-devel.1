Received: from eggs.gnu.org ([2001:4830:134:3::10]:38824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg94Q-0006yo-Dk
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg94O-0005W1-8g
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cg94O-0005Vt-0t
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:24 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 11:56:37 +0000
Message-Id: <20170221115644.28264-18-stefanha@redhat.com>
In-Reply-To: <20170221115644.28264-1-stefanha@redhat.com>
References: <20170221115644.28264-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 17/24] async: remove unnecessary inc/dec pairs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Pull the increment/decrement pair out of aio_bh_poll and into the
callers.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170213135235.12274-18-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c |  8 +++-----
 util/aio-win32.c |  8 ++++----
 util/async.c     | 12 ++++++------
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 2173378..2d51239 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -425,9 +425,8 @@ static bool aio_dispatch_handlers(AioContext *ctx)
 
 void aio_dispatch(AioContext *ctx)
 {
+    qemu_lockcnt_inc(&ctx->list_lock);
     aio_bh_poll(ctx);
-
-    qemu_lockcnt_inc(&ctx->list_lock);
     aio_dispatch_handlers(ctx);
     qemu_lockcnt_dec(&ctx->list_lock);
 
@@ -679,16 +678,15 @@ bool aio_poll(AioContext *ctx, bool blocking)
     }
 
     npfd = 0;
-    qemu_lockcnt_dec(&ctx->list_lock);
 
     progress |= aio_bh_poll(ctx);
 
     if (ret > 0) {
-        qemu_lockcnt_inc(&ctx->list_lock);
         progress |= aio_dispatch_handlers(ctx);
-        qemu_lockcnt_dec(&ctx->list_lock);
     }
 
+    qemu_lockcnt_dec(&ctx->list_lock);
+
     progress |= timerlistgroup_run_timers(&ctx->tlg);
 
     return progress;
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 442a179..bca496a 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -253,8 +253,6 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
     bool progress = false;
     AioHandler *tmp;
 
-    qemu_lockcnt_inc(&ctx->list_lock);
-
     /*
      * We have to walk very carefully in case aio_set_fd_handler is
      * called while we're walking.
@@ -305,14 +303,15 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
         }
     }
 
-    qemu_lockcnt_dec(&ctx->list_lock);
     return progress;
 }
 
 void aio_dispatch(AioContext *ctx)
 {
+    qemu_lockcnt_inc(&ctx->list_lock);
     aio_bh_poll(ctx);
     aio_dispatch_handlers(ctx, INVALID_HANDLE_VALUE);
+    qemu_lockcnt_dec(&ctx->list_lock);
     timerlistgroup_run_timers(&ctx->tlg);
 }
 
@@ -349,7 +348,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
         }
     }
 
-    qemu_lockcnt_dec(&ctx->list_lock);
     first = true;
 
     /* ctx->notifier is always registered.  */
@@ -392,6 +390,8 @@ bool aio_poll(AioContext *ctx, bool blocking)
         progress |= aio_dispatch_handlers(ctx, event);
     } while (count > 0);
 
+    qemu_lockcnt_dec(&ctx->list_lock);
+
     progress |= timerlistgroup_run_timers(&ctx->tlg);
     return progress;
 }
diff --git a/util/async.c b/util/async.c
index 187bc5b..7d469eb 100644
--- a/util/async.c
+++ b/util/async.c
@@ -90,15 +90,16 @@ void aio_bh_call(QEMUBH *bh)
     bh->cb(bh->opaque);
 }
 
-/* Multiple occurrences of aio_bh_poll cannot be called concurrently */
+/* Multiple occurrences of aio_bh_poll cannot be called concurrently.
+ * The count in ctx->list_lock is incremented before the call, and is
+ * not affected by the call.
+ */
 int aio_bh_poll(AioContext *ctx)
 {
     QEMUBH *bh, **bhp, *next;
     int ret;
     bool deleted = false;
 
-    qemu_lockcnt_inc(&ctx->list_lock);
-
     ret = 0;
     for (bh = atomic_rcu_read(&ctx->first_bh); bh; bh = next) {
         next = atomic_rcu_read(&bh->next);
@@ -123,11 +124,10 @@ int aio_bh_poll(AioContext *ctx)
 
     /* remove deleted bhs */
     if (!deleted) {
-        qemu_lockcnt_dec(&ctx->list_lock);
         return ret;
     }
 
-    if (qemu_lockcnt_dec_and_lock(&ctx->list_lock)) {
+    if (qemu_lockcnt_dec_if_lock(&ctx->list_lock)) {
         bhp = &ctx->first_bh;
         while (*bhp) {
             bh = *bhp;
@@ -138,7 +138,7 @@ int aio_bh_poll(AioContext *ctx)
                 bhp = &bh->next;
             }
         }
-        qemu_lockcnt_unlock(&ctx->list_lock);
+        qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
     }
     return ret;
 }
-- 
2.9.3
