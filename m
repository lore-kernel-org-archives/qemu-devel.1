Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZC-00044K-J8
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZB-0006W2-AK
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:50 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  1 Feb 2017 00:34:38 -0500
Message-Id: <20170201053440.26002-4-jcody@redhat.com>
In-Reply-To: <20170201053440.26002-1-jcody@redhat.com>
References: <20170201053440.26002-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] sheepdog: do not use BlockAIOCB
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

Sheepdog's AIOCB are completely internal entities for a group of
requests and do not need dynamic allocation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161129113245.32724-4-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/sheepdog.c | 99 ++++++++++++++++++++++----------------------------------
 1 file changed, 39 insertions(+), 60 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index e0985df..33ded57 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -306,6 +306,7 @@ static inline size_t count_data_objs(const struct SheepdogInode *inode)
     } while (0)
 
 typedef struct SheepdogAIOCB SheepdogAIOCB;
+typedef struct BDRVSheepdogState BDRVSheepdogState;
 
 typedef struct AIOReq {
     SheepdogAIOCB *aiocb;
@@ -334,7 +335,7 @@ enum AIOCBState {
        || y->max_affect_data_idx < x->min_affect_data_idx))
 
 struct SheepdogAIOCB {
-    BlockAIOCB common;
+    BDRVSheepdogState *s;
 
     QEMUIOVector *qiov;
 
@@ -362,7 +363,7 @@ struct SheepdogAIOCB {
     QLIST_ENTRY(SheepdogAIOCB) aiocb_siblings;
 };
 
-typedef struct BDRVSheepdogState {
+struct BDRVSheepdogState {
     BlockDriverState *bs;
     AioContext *aio_context;
 
@@ -389,7 +390,7 @@ typedef struct BDRVSheepdogState {
 
     CoQueue overlapping_queue;
     QLIST_HEAD(inflight_aiocb_head, SheepdogAIOCB) inflight_aiocb_head;
-} BDRVSheepdogState;
+};
 
 typedef struct BDRVSheepdogReopenState {
     int fd;
@@ -488,20 +489,15 @@ static inline void free_aio_req(BDRVSheepdogState *s, AIOReq *aio_req)
     acb->nr_pending--;
 }
 
-static const AIOCBInfo sd_aiocb_info = {
-    .aiocb_size     = sizeof(SheepdogAIOCB),
-};
-
-static SheepdogAIOCB *sd_aio_setup(BlockDriverState *bs, QEMUIOVector *qiov,
-                                   int64_t sector_num, int nb_sectors)
+static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
+                         QEMUIOVector *qiov, int64_t sector_num, int nb_sectors,
+                         int type)
 {
-    SheepdogAIOCB *acb;
     uint32_t object_size;
-    BDRVSheepdogState *s = bs->opaque;
 
     object_size = (UINT32_C(1) << s->inode.block_size_shift);
 
-    acb = qemu_aio_get(&sd_aiocb_info, bs, NULL, NULL);
+    acb->s = s;
 
     acb->qiov = qiov;
 
@@ -518,8 +514,7 @@ static SheepdogAIOCB *sd_aio_setup(BlockDriverState *bs, QEMUIOVector *qiov,
 
     acb->min_dirty_data_idx = UINT32_MAX;
     acb->max_dirty_data_idx = 0;
-
-    return acb;
+    acb->aiocb_type = type;
 }
 
 /* Return -EIO in case of error, file descriptor on success */
@@ -1967,7 +1962,7 @@ static int sd_truncate(BlockDriverState *bs, int64_t offset)
  */
 static void coroutine_fn sd_write_done(SheepdogAIOCB *acb)
 {
-    BDRVSheepdogState *s = acb->common.bs->opaque;
+    BDRVSheepdogState *s = acb->s;
     struct iovec iov;
     AIOReq *aio_req;
     uint32_t offset, data_len, mn, mx;
@@ -2105,16 +2100,15 @@ out:
  * Returns 1 when we need to wait a response, 0 when there is no sent
  * request and -errno in error cases.
  */
-static void coroutine_fn sd_co_rw_vector(void *p)
+static void coroutine_fn sd_co_rw_vector(SheepdogAIOCB *acb)
 {
-    SheepdogAIOCB *acb = p;
     int ret = 0;
     unsigned long len, done = 0, total = acb->nb_sectors * BDRV_SECTOR_SIZE;
     unsigned long idx;
     uint32_t object_size;
     uint64_t oid;
     uint64_t offset;
-    BDRVSheepdogState *s = acb->common.bs->opaque;
+    BDRVSheepdogState *s = acb->s;
     SheepdogInode *inode = &s->inode;
     AIOReq *aio_req;
 
@@ -2222,7 +2216,7 @@ static bool check_overlapping_aiocb(BDRVSheepdogState *s, SheepdogAIOCB *aiocb)
 static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
                         int nb_sectors, QEMUIOVector *qiov)
 {
-    SheepdogAIOCB *acb;
+    SheepdogAIOCB acb;
     int ret;
     int64_t offset = (sector_num + nb_sectors) * BDRV_SECTOR_SIZE;
     BDRVSheepdogState *s = bs->opaque;
@@ -2234,76 +2228,65 @@ static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
         }
     }
 
-    acb = sd_aio_setup(bs, qiov, sector_num, nb_sectors);
-    acb->aiocb_type = AIOCB_WRITE_UDATA;
+    sd_aio_setup(&acb, s, qiov, sector_num, nb_sectors, AIOCB_WRITE_UDATA);
 
 retry:
-    if (check_overlapping_aiocb(s, acb)) {
+    if (check_overlapping_aiocb(s, &acb)) {
         qemu_co_queue_wait(&s->overlapping_queue);
         goto retry;
     }
 
-    sd_co_rw_vector(acb);
-    sd_write_done(acb);
+    sd_co_rw_vector(&acb);
+    sd_write_done(&acb);
 
-    QLIST_REMOVE(acb, aiocb_siblings);
+    QLIST_REMOVE(&acb, aiocb_siblings);
     qemu_co_queue_restart_all(&s->overlapping_queue);
-    ret = acb->ret;
-    qemu_aio_unref(acb);
-    return ret;
+    return acb.ret;
 }
 
 static coroutine_fn int sd_co_readv(BlockDriverState *bs, int64_t sector_num,
                        int nb_sectors, QEMUIOVector *qiov)
 {
-    SheepdogAIOCB *acb;
-    int ret;
+    SheepdogAIOCB acb;
     BDRVSheepdogState *s = bs->opaque;
 
-    acb = sd_aio_setup(bs, qiov, sector_num, nb_sectors);
-    acb->aiocb_type = AIOCB_READ_UDATA;
+    sd_aio_setup(&acb, s, qiov, sector_num, nb_sectors, AIOCB_READ_UDATA);
 
 retry:
-    if (check_overlapping_aiocb(s, acb)) {
+    if (check_overlapping_aiocb(s, &acb)) {
         qemu_co_queue_wait(&s->overlapping_queue);
         goto retry;
     }
 
-    sd_co_rw_vector(acb);
+    sd_co_rw_vector(&acb);
 
-    QLIST_REMOVE(acb, aiocb_siblings);
+    QLIST_REMOVE(&acb, aiocb_siblings);
     qemu_co_queue_restart_all(&s->overlapping_queue);
-    ret = acb->ret;
-    qemu_aio_unref(acb);
-    return ret;
+    return acb.ret;
 }
 
 static int coroutine_fn sd_co_flush_to_disk(BlockDriverState *bs)
 {
     BDRVSheepdogState *s = bs->opaque;
-    SheepdogAIOCB *acb;
-    int ret;
+    SheepdogAIOCB acb;
     AIOReq *aio_req;
 
     if (s->cache_flags != SD_FLAG_CMD_CACHE) {
         return 0;
     }
 
-    acb = sd_aio_setup(bs, NULL, 0, 0);
-    acb->aiocb_type = AIOCB_FLUSH_CACHE;
+    sd_aio_setup(&acb, s, NULL, 0, 0, AIOCB_FLUSH_CACHE);
 
-    acb->nr_pending++;
-    aio_req = alloc_aio_req(s, acb, vid_to_vdi_oid(s->inode.vdi_id),
+    acb.nr_pending++;
+    aio_req = alloc_aio_req(s, &acb, vid_to_vdi_oid(s->inode.vdi_id),
                             0, 0, 0, false, 0, 0);
     QLIST_INSERT_HEAD(&s->inflight_aio_head, aio_req, aio_siblings);
-    add_aio_request(s, aio_req, NULL, 0, acb->aiocb_type);
+    add_aio_request(s, aio_req, NULL, 0, acb.aiocb_type);
 
-    if (--acb->nr_pending) {
+    if (--acb.nr_pending) {
         qemu_coroutine_yield();
     }
-    ret = acb->ret;
-    qemu_aio_unref(acb);
-    return ret;
+    return acb.ret;
 }
 
 static int sd_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
@@ -2737,9 +2720,8 @@ static int sd_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
 static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
                                       int count)
 {
-    SheepdogAIOCB *acb;
+    SheepdogAIOCB acb;
     BDRVSheepdogState *s = bs->opaque;
-    int ret;
     QEMUIOVector discard_iov;
     struct iovec iov;
     uint32_t zero = 0;
@@ -2757,23 +2739,20 @@ static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
     if (!QEMU_IS_ALIGNED(offset | count, BDRV_SECTOR_SIZE)) {
         return -ENOTSUP;
     }
-    acb = sd_aio_setup(bs, &discard_iov, offset >> BDRV_SECTOR_BITS,
-                       count >> BDRV_SECTOR_BITS);
-    acb->aiocb_type = AIOCB_DISCARD_OBJ;
+    sd_aio_setup(&acb, s, &discard_iov, offset >> BDRV_SECTOR_BITS,
+                 count >> BDRV_SECTOR_BITS, AIOCB_DISCARD_OBJ);
 
 retry:
-    if (check_overlapping_aiocb(s, acb)) {
+    if (check_overlapping_aiocb(s, &acb)) {
         qemu_co_queue_wait(&s->overlapping_queue);
         goto retry;
     }
 
-    sd_co_rw_vector(acb);
+    sd_co_rw_vector(&acb);
 
-    QLIST_REMOVE(acb, aiocb_siblings);
+    QLIST_REMOVE(&acb, aiocb_siblings);
     qemu_co_queue_restart_all(&s->overlapping_queue);
-    ret = acb->ret;
-    qemu_aio_unref(acb);
-    return ret;
+    return acb.ret;
 }
 
 static coroutine_fn int64_t
-- 
2.9.3
