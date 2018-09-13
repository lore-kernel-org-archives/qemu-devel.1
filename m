Received: from eggs.gnu.org ([2001:4830:134:3::10]:46816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7G-0002Mx-FA
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7F-0001uU-Hs
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:08 +0200
Message-Id: <20180913125217.23173-9-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/17] block: Add missing locking in
 bdrv_co_drain_bh_cb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

bdrv_do_drained_begin/end() assume that they are called with the
AioContext lock of bs held. If we call drain functions from a coroutine
with the AioContext lock held, we yield and schedule a BH to move out of
coroutine context. This means that the lock for the home context of the
coroutine is released and must be re-acquired in the bottom half.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/coroutine.h |  5 +++++
 block/io.c               | 15 +++++++++++++++
 util/qemu-coroutine.c    |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 6f8a487041..9801e7f5a4 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -90,6 +90,11 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co);
 void coroutine_fn qemu_coroutine_yield(void);
 
 /**
+ * Get the AioContext of the given coroutine
+ */
+AioContext *coroutine_fn qemu_coroutine_get_aio_context(Coroutine *co);
+
+/**
  * Get the currently executing coroutine
  */
 Coroutine *coroutine_fn qemu_coroutine_self(void);
diff --git a/block/io.c b/block/io.c
index 7100344c7b..914ba78f1a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -288,6 +288,18 @@ static void bdrv_co_drain_bh_cb(void *opaque)
     BlockDriverState *bs = data->bs;
 
     if (bs) {
+        AioContext *ctx = bdrv_get_aio_context(bs);
+        AioContext *co_ctx = qemu_coroutine_get_aio_context(co);
+
+        /*
+         * When the coroutine yielded, the lock for its home context was
+         * released, so we need to re-acquire it here. If it explicitly
+         * acquired a different context, the lock is still held and we don't
+         * want to lock it a second time (or AIO_WAIT_WHILE() would hang).
+         */
+        if (ctx == co_ctx) {
+            aio_context_acquire(ctx);
+        }
         bdrv_dec_in_flight(bs);
         if (data->begin) {
             bdrv_do_drained_begin(bs, data->recursive, data->parent,
@@ -296,6 +308,9 @@ static void bdrv_co_drain_bh_cb(void *opaque)
             bdrv_do_drained_end(bs, data->recursive, data->parent,
                                 data->ignore_bds_parents);
         }
+        if (ctx == co_ctx) {
+            aio_context_release(ctx);
+        }
     } else {
         assert(data->begin);
         bdrv_drain_all_begin();
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 1ba4191b84..2295928d33 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -198,3 +198,8 @@ bool qemu_coroutine_entered(Coroutine *co)
 {
     return co->caller;
 }
+
+AioContext *coroutine_fn qemu_coroutine_get_aio_context(Coroutine *co)
+{
+    return co->ctx;
+}
-- 
2.13.6
