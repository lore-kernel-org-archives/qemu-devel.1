Received: from eggs.gnu.org ([2001:4830:134:3::10]:53680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdDZf-0008Cg-0t
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdDZd-0007dc-BF
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:09:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cdDZd-0007dT-2z
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:09:33 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55B558046C
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 10:09:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Feb 2017 11:09:05 +0100
Message-Id: <20170213100906.23486-18-pbonzini@redhat.com>
In-Reply-To: <20170213100906.23486-1-pbonzini@redhat.com>
References: <20170213100906.23486-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 17/18] async: remove unnecessary inc/dec pairs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

Pull the increment/decrement pair out of aio_bh_poll and into the
callers.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/aio-posix.c |  8 +++-----
 util/aio-win32.c |  8 ++++----
 util/async.c     | 12 ++++++------
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index e53434d..77cacdf 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -425,9 +425,8 @@ static bool aio_dispatch_handlers(AioContext *ctx)
 
 void aio_dispatch(AioContext *ctx)
 {
-    aio_bh_poll(ctx);
-
     qemu_lockcnt_inc(&ctx->list_lock);
+    aio_bh_poll(ctx);
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
index cc40735..9c3ce6a 100644
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
