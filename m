Received: from eggs.gnu.org ([2001:4830:134:3::10]:41168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VG-00080C-P8
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VF-0003j3-Ow
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7VF-0003ih-Hu
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:39:02 +0000
Message-Id: <20170116133911.21684-3-stefanha@redhat.com>
In-Reply-To: <20170116133911.21684-1-stefanha@redhat.com>
References: <20170116133911.21684-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 02/11] aio: rename bh_lock to list_lock
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

This will be used for AioHandlers too.  There is going to be little
or no contention, so it is better to reuse the same lock.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170112180800.21085-2-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h |  2 +-
 async.c             | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 4dca54d..013d400 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -91,7 +91,7 @@ struct AioContext {
     uint32_t notify_me;
 
     /* lock to protect between bh's adders and deleter */
-    QemuMutex bh_lock;
+    QemuMutex list_lock;
 
     /* Anchor of the list of Bottom Halves belonging to the context */
     struct QEMUBH *first_bh;
diff --git a/async.c b/async.c
index 2960171..69292fa 100644
--- a/async.c
+++ b/async.c
@@ -53,14 +53,14 @@ void aio_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
         .cb = cb,
         .opaque = opaque,
     };
-    qemu_mutex_lock(&ctx->bh_lock);
+    qemu_mutex_lock(&ctx->list_lock);
     bh->next = ctx->first_bh;
     bh->scheduled = 1;
     bh->deleted = 1;
     /* Make sure that the members are ready before putting bh into list */
     smp_wmb();
     ctx->first_bh = bh;
-    qemu_mutex_unlock(&ctx->bh_lock);
+    qemu_mutex_unlock(&ctx->list_lock);
     aio_notify(ctx);
 }
 
@@ -73,12 +73,12 @@ QEMUBH *aio_bh_new(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
         .cb = cb,
         .opaque = opaque,
     };
-    qemu_mutex_lock(&ctx->bh_lock);
+    qemu_mutex_lock(&ctx->list_lock);
     bh->next = ctx->first_bh;
     /* Make sure that the members are ready before putting bh into list */
     smp_wmb();
     ctx->first_bh = bh;
-    qemu_mutex_unlock(&ctx->bh_lock);
+    qemu_mutex_unlock(&ctx->list_lock);
     return bh;
 }
 
@@ -120,7 +120,7 @@ int aio_bh_poll(AioContext *ctx)
 
     /* remove deleted bhs */
     if (!ctx->walking_bh) {
-        qemu_mutex_lock(&ctx->bh_lock);
+        qemu_mutex_lock(&ctx->list_lock);
         bhp = &ctx->first_bh;
         while (*bhp) {
             bh = *bhp;
@@ -131,7 +131,7 @@ int aio_bh_poll(AioContext *ctx)
                 bhp = &bh->next;
             }
         }
-        qemu_mutex_unlock(&ctx->bh_lock);
+        qemu_mutex_unlock(&ctx->list_lock);
     }
 
     return ret;
@@ -270,7 +270,7 @@ aio_ctx_finalize(GSource     *source)
     }
 #endif
 
-    qemu_mutex_lock(&ctx->bh_lock);
+    qemu_mutex_lock(&ctx->list_lock);
     while (ctx->first_bh) {
         QEMUBH *next = ctx->first_bh->next;
 
@@ -280,12 +280,12 @@ aio_ctx_finalize(GSource     *source)
         g_free(ctx->first_bh);
         ctx->first_bh = next;
     }
-    qemu_mutex_unlock(&ctx->bh_lock);
+    qemu_mutex_unlock(&ctx->list_lock);
 
     aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
     event_notifier_cleanup(&ctx->notifier);
     qemu_rec_mutex_destroy(&ctx->lock);
-    qemu_mutex_destroy(&ctx->bh_lock);
+    qemu_mutex_destroy(&ctx->list_lock);
     timerlistgroup_deinit(&ctx->tlg);
 }
 
@@ -381,7 +381,7 @@ AioContext *aio_context_new(Error **errp)
     ctx->linux_aio = NULL;
 #endif
     ctx->thread_pool = NULL;
-    qemu_mutex_init(&ctx->bh_lock);
+    qemu_mutex_init(&ctx->list_lock);
     qemu_rec_mutex_init(&ctx->lock);
     timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
 
-- 
2.9.3
