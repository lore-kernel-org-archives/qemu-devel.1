Received: from eggs.gnu.org ([2001:4830:134:3::10]:41223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jq-0007e8-L1
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jp-0002c7-IU
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:50 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cS1jp-0002bl-B9
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:49 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so11634045wmr.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:17:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 13 Jan 2017 14:17:30 +0100
Message-Id: <20170113131731.1246-16-pbonzini@redhat.com>
In-Reply-To: <20170113131731.1246-1-pbonzini@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 15/16] async: remove unnecessary inc/dec pairs
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 aio-posix.c |  8 +++-----
 aio-win32.c |  8 ++++----
 async.c     | 12 ++++++------
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/aio-posix.c b/aio-posix.c
index 51e92b8..2537bcd 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -425,9 +425,8 @@ static bool aio_dispatch_handlers(AioContext *ctx)
 
 void aio_dispatch(AioContext *ctx)
 {
-    aio_bh_poll(ctx);
-
     qemu_lockcnt_inc(&ctx->list_lock);
+    aio_bh_poll(ctx);
     aio_dispatch_handlers(ctx);
     qemu_lockcnt_dec(&ctx->list_lock);
 
@@ -678,16 +677,15 @@ bool aio_poll(AioContext *ctx, bool blocking)
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
diff --git a/aio-win32.c b/aio-win32.c
index 442a179..bca496a 100644
--- a/aio-win32.c
+++ b/aio-win32.c
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
diff --git a/async.c b/async.c
index 1839aa5..c471b1e 100644
--- a/async.c
+++ b/async.c
@@ -89,15 +89,16 @@ void aio_bh_call(QEMUBH *bh)
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
@@ -122,11 +123,10 @@ int aio_bh_poll(AioContext *ctx)
 
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
@@ -137,7 +137,7 @@ int aio_bh_poll(AioContext *ctx)
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
