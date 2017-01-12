Received: from eggs.gnu.org ([2001:4830:134:3::10]:44258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRjnE-0008WJ-LI
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRjnD-0005EG-Jq
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:08 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRjnD-0005E9-BO
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:07 -0500
Received: by mail-wm0-x241.google.com with SMTP id r126so5474775wmr.3
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 10:08:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jan 2017 19:07:53 +0100
Message-Id: <20170112180800.21085-4-pbonzini@redhat.com>
In-Reply-To: <20170112180800.21085-1-pbonzini@redhat.com>
References: <20170112180800.21085-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/10] aio: make ctx->list_lock a QemuLockCnt,
 subsuming ctx->walking_bh
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

This will make it possible to walk the list of bottom halves without
holding the AioContext lock---and in turn to call bottom half
handlers without holding the lock.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 async.c             | 35 ++++++++++++++++-------------------
 include/block/aio.h | 12 +++++-------
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/async.c b/async.c
index 69292fa..2305e11 100644
--- a/async.c
+++ b/async.c
@@ -53,14 +53,14 @@ void aio_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
         .cb = cb,
         .opaque = opaque,
     };
-    qemu_mutex_lock(&ctx->list_lock);
+    qemu_lockcnt_lock(&ctx->list_lock);
     bh->next = ctx->first_bh;
     bh->scheduled = 1;
     bh->deleted = 1;
     /* Make sure that the members are ready before putting bh into list */
     smp_wmb();
     ctx->first_bh = bh;
-    qemu_mutex_unlock(&ctx->list_lock);
+    qemu_lockcnt_unlock(&ctx->list_lock);
     aio_notify(ctx);
 }
 
@@ -73,12 +73,12 @@ QEMUBH *aio_bh_new(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
         .cb = cb,
         .opaque = opaque,
     };
-    qemu_mutex_lock(&ctx->list_lock);
+    qemu_lockcnt_lock(&ctx->list_lock);
     bh->next = ctx->first_bh;
     /* Make sure that the members are ready before putting bh into list */
     smp_wmb();
     ctx->first_bh = bh;
-    qemu_mutex_unlock(&ctx->list_lock);
+    qemu_lockcnt_unlock(&ctx->list_lock);
     return bh;
 }
 
@@ -93,13 +93,11 @@ int aio_bh_poll(AioContext *ctx)
     QEMUBH *bh, **bhp, *next;
     int ret;
 
-    ctx->walking_bh++;
+    qemu_lockcnt_inc(&ctx->list_lock);
 
     ret = 0;
-    for (bh = ctx->first_bh; bh; bh = next) {
-        /* Make sure that fetching bh happens before accessing its members */
-        smp_read_barrier_depends();
-        next = bh->next;
+    for (bh = atomic_rcu_read(&ctx->first_bh); bh; bh = next) {
+        next = atomic_rcu_read(&bh->next);
         /* The atomic_xchg is paired with the one in qemu_bh_schedule.  The
          * implicit memory barrier ensures that the callback sees all writes
          * done by the scheduling thread.  It also ensures that the scheduling
@@ -116,11 +114,8 @@ int aio_bh_poll(AioContext *ctx)
         }
     }
 
-    ctx->walking_bh--;
-
     /* remove deleted bhs */
-    if (!ctx->walking_bh) {
-        qemu_mutex_lock(&ctx->list_lock);
+    if (qemu_lockcnt_dec_and_lock(&ctx->list_lock)) {
         bhp = &ctx->first_bh;
         while (*bhp) {
             bh = *bhp;
@@ -131,7 +126,7 @@ int aio_bh_poll(AioContext *ctx)
                 bhp = &bh->next;
             }
         }
-        qemu_mutex_unlock(&ctx->list_lock);
+        qemu_lockcnt_unlock(&ctx->list_lock);
     }
 
     return ret;
@@ -187,7 +182,8 @@ aio_compute_timeout(AioContext *ctx)
     int timeout = -1;
     QEMUBH *bh;
 
-    for (bh = ctx->first_bh; bh; bh = bh->next) {
+    for (bh = atomic_rcu_read(&ctx->first_bh); bh;
+         bh = atomic_rcu_read(&bh->next)) {
         if (bh->scheduled) {
             if (bh->idle) {
                 /* idle bottom halves will be polled at least
@@ -270,7 +266,8 @@ aio_ctx_finalize(GSource     *source)
     }
 #endif
 
-    qemu_mutex_lock(&ctx->list_lock);
+    qemu_lockcnt_lock(&ctx->list_lock);
+    assert(!qemu_lockcnt_count(&ctx->list_lock));
     while (ctx->first_bh) {
         QEMUBH *next = ctx->first_bh->next;
 
@@ -280,12 +277,12 @@ aio_ctx_finalize(GSource     *source)
         g_free(ctx->first_bh);
         ctx->first_bh = next;
     }
-    qemu_mutex_unlock(&ctx->list_lock);
+    qemu_lockcnt_unlock(&ctx->list_lock);
 
     aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
     event_notifier_cleanup(&ctx->notifier);
     qemu_rec_mutex_destroy(&ctx->lock);
-    qemu_mutex_destroy(&ctx->list_lock);
+    qemu_lockcnt_destroy(&ctx->list_lock);
     timerlistgroup_deinit(&ctx->tlg);
 }
 
@@ -372,6 +369,7 @@ AioContext *aio_context_new(Error **errp)
         goto fail;
     }
     g_source_set_can_recurse(&ctx->source, true);
+    qemu_lockcnt_init(&ctx->list_lock);
     aio_set_event_notifier(ctx, &ctx->notifier,
                            false,
                            (EventNotifierHandler *)
@@ -381,7 +379,6 @@ AioContext *aio_context_new(Error **errp)
     ctx->linux_aio = NULL;
 #endif
     ctx->thread_pool = NULL;
-    qemu_mutex_init(&ctx->list_lock);
     qemu_rec_mutex_init(&ctx->lock);
     timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
 
diff --git a/include/block/aio.h b/include/block/aio.h
index 013d400..be3adfe 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -90,17 +90,15 @@ struct AioContext {
      */
     uint32_t notify_me;
 
-    /* lock to protect between bh's adders and deleter */
-    QemuMutex list_lock;
+    /* A lock to protect between bh's adders and deleter, and to ensure
+     * that no callbacks are removed while we're walking and dispatching
+     * them.
+     */
+    QemuLockCnt list_lock;
 
     /* Anchor of the list of Bottom Halves belonging to the context */
     struct QEMUBH *first_bh;
 
-    /* A simple lock used to protect the first_bh list, and ensure that
-     * no callbacks are removed while we're walking and dispatching callbacks.
-     */
-    int walking_bh;
-
     /* Used by aio_notify.
      *
      * "notified" is used to avoid expensive event_notifier_test_and_clear
-- 
2.9.3
