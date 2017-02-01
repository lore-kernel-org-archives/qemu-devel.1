Received: from eggs.gnu.org ([2001:4830:134:3::10]:56338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZD-00044x-Ch
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZC-0006WU-Bl
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:51 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  1 Feb 2017 00:34:40 -0500
Message-Id: <20170201053440.26002-6-jcody@redhat.com>
In-Reply-To: <20170201053440.26002-1-jcody@redhat.com>
References: <20170201053440.26002-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] sheepdog: reorganize check for overlapping
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

From: Paolo Bonzini <pbonzini@redhat.com>

Wrap the code that was copied repeatedly in the two functions,
sd_aio_setup and sd_aio_complete.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161129113245.32724-6-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/sheepdog.c | 66 ++++++++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 3ef7601..f757157 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -479,6 +479,19 @@ static inline AIOReq *alloc_aio_req(BDRVSheepdogState *s, SheepdogAIOCB *acb,
     return aio_req;
 }
 
+static void wait_for_overlapping_aiocb(BDRVSheepdogState *s, SheepdogAIOCB *acb)
+{
+    SheepdogAIOCB *cb;
+
+retry:
+    QLIST_FOREACH(cb, &s->inflight_aiocb_head, aiocb_siblings) {
+        if (AIOCBOverlapping(acb, cb)) {
+            qemu_co_queue_wait(&s->overlapping_queue);
+            goto retry;
+        }
+    }
+}
+
 static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
                          QEMUIOVector *qiov, int64_t sector_num, int nb_sectors,
                          int type)
@@ -505,6 +518,13 @@ static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
     acb->min_dirty_data_idx = UINT32_MAX;
     acb->max_dirty_data_idx = 0;
     acb->aiocb_type = type;
+
+    if (type == AIOCB_FLUSH_CACHE) {
+        return;
+    }
+
+    wait_for_overlapping_aiocb(s, acb);
+    QLIST_INSERT_HEAD(&s->inflight_aiocb_head, acb, aiocb_siblings);
 }
 
 /* Return -EIO in case of error, file descriptor on success */
@@ -2189,18 +2209,14 @@ static void coroutine_fn sd_co_rw_vector(SheepdogAIOCB *acb)
     }
 }
 
-static bool check_overlapping_aiocb(BDRVSheepdogState *s, SheepdogAIOCB *aiocb)
+static void sd_aio_complete(SheepdogAIOCB *acb)
 {
-    SheepdogAIOCB *cb;
-
-    QLIST_FOREACH(cb, &s->inflight_aiocb_head, aiocb_siblings) {
-        if (AIOCBOverlapping(aiocb, cb)) {
-            return true;
-        }
+    if (acb->aiocb_type == AIOCB_FLUSH_CACHE) {
+        return;
     }
 
-    QLIST_INSERT_HEAD(&s->inflight_aiocb_head, aiocb, aiocb_siblings);
-    return false;
+    QLIST_REMOVE(acb, aiocb_siblings);
+    qemu_co_queue_restart_all(&acb->s->overlapping_queue);
 }
 
 static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
@@ -2219,18 +2235,10 @@ static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
     }
 
     sd_aio_setup(&acb, s, qiov, sector_num, nb_sectors, AIOCB_WRITE_UDATA);
-
-retry:
-    if (check_overlapping_aiocb(s, &acb)) {
-        qemu_co_queue_wait(&s->overlapping_queue);
-        goto retry;
-    }
-
     sd_co_rw_vector(&acb);
     sd_write_done(&acb);
+    sd_aio_complete(&acb);
 
-    QLIST_REMOVE(&acb, aiocb_siblings);
-    qemu_co_queue_restart_all(&s->overlapping_queue);
     return acb.ret;
 }
 
@@ -2241,17 +2249,9 @@ static coroutine_fn int sd_co_readv(BlockDriverState *bs, int64_t sector_num,
     BDRVSheepdogState *s = bs->opaque;
 
     sd_aio_setup(&acb, s, qiov, sector_num, nb_sectors, AIOCB_READ_UDATA);
-
-retry:
-    if (check_overlapping_aiocb(s, &acb)) {
-        qemu_co_queue_wait(&s->overlapping_queue);
-        goto retry;
-    }
-
     sd_co_rw_vector(&acb);
+    sd_aio_complete(&acb);
 
-    QLIST_REMOVE(&acb, aiocb_siblings);
-    qemu_co_queue_restart_all(&s->overlapping_queue);
     return acb.ret;
 }
 
@@ -2275,6 +2275,8 @@ static int coroutine_fn sd_co_flush_to_disk(BlockDriverState *bs)
     if (--acb.nr_pending) {
         qemu_coroutine_yield();
     }
+
+    sd_aio_complete(&acb);
     return acb.ret;
 }
 
@@ -2730,17 +2732,9 @@ static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
     }
     sd_aio_setup(&acb, s, &discard_iov, offset >> BDRV_SECTOR_BITS,
                  count >> BDRV_SECTOR_BITS, AIOCB_DISCARD_OBJ);
-
-retry:
-    if (check_overlapping_aiocb(s, &acb)) {
-        qemu_co_queue_wait(&s->overlapping_queue);
-        goto retry;
-    }
-
     sd_co_rw_vector(&acb);
+    sd_aio_complete(&acb);
 
-    QLIST_REMOVE(&acb, aiocb_siblings);
-    qemu_co_queue_restart_all(&s->overlapping_queue);
     return acb.ret;
 }
 
-- 
2.9.3
