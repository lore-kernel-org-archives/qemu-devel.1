Received: from eggs.gnu.org ([2001:4830:134:3::10]:57005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6N-0005UR-Sy
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6M-00028w-Jd
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:11 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:21 +0100
Message-Id: <20171222151846.28110-11-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 10/35] qcow2: get rid of qcow2_backing_read1
 routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>

Since bdrv_co_preadv does all neccessary checks including
reading after the end of the backing file, avoid duplication
of verification before bdrv_co_preadv call.

Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h |  3 ---
 block/qcow2.c | 51 ++++++++-------------------------------------------
 2 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 6f0ff15dd0..46c8cf44ec 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -528,9 +528,6 @@ uint32_t offset_to_reftable_index(BDRVQcow2State *s, uint64_t offset)
 }
 
 /* qcow2.c functions */
-int qcow2_backing_read1(BlockDriverState *bs, QEMUIOVector *qiov,
-                  int64_t sector_num, int nb_sectors);
-
 int64_t qcow2_refcount_metadata_size(int64_t clusters, size_t cluster_size,
                                      int refcount_order, bool generous_increase,
                                      uint64_t *refblock_count);
diff --git a/block/qcow2.c b/block/qcow2.c
index 1914a940e5..4348b2c0c5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1672,34 +1672,12 @@ static int64_t coroutine_fn qcow2_co_get_block_status(BlockDriverState *bs,
     return status;
 }
 
-/* handle reading after the end of the backing file */
-int qcow2_backing_read1(BlockDriverState *bs, QEMUIOVector *qiov,
-                        int64_t offset, int bytes)
-{
-    uint64_t bs_size = bs->total_sectors * BDRV_SECTOR_SIZE;
-    int n1;
-
-    if ((offset + bytes) <= bs_size) {
-        return bytes;
-    }
-
-    if (offset >= bs_size) {
-        n1 = 0;
-    } else {
-        n1 = bs_size - offset;
-    }
-
-    qemu_iovec_memset(qiov, n1, 0, bytes - n1);
-
-    return n1;
-}
-
 static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                                         uint64_t bytes, QEMUIOVector *qiov,
                                         int flags)
 {
     BDRVQcow2State *s = bs->opaque;
-    int offset_in_cluster, n1;
+    int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t cluster_offset = 0;
@@ -1734,26 +1712,13 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
         case QCOW2_CLUSTER_UNALLOCATED:
 
             if (bs->backing) {
-                /* read from the base image */
-                n1 = qcow2_backing_read1(bs->backing->bs, &hd_qiov,
-                                         offset, cur_bytes);
-                if (n1 > 0) {
-                    QEMUIOVector local_qiov;
-
-                    qemu_iovec_init(&local_qiov, hd_qiov.niov);
-                    qemu_iovec_concat(&local_qiov, &hd_qiov, 0, n1);
-
-                    BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                    qemu_co_mutex_unlock(&s->lock);
-                    ret = bdrv_co_preadv(bs->backing, offset, n1,
-                                         &local_qiov, 0);
-                    qemu_co_mutex_lock(&s->lock);
-
-                    qemu_iovec_destroy(&local_qiov);
-
-                    if (ret < 0) {
-                        goto fail;
-                    }
+                BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
+                qemu_co_mutex_unlock(&s->lock);
+                ret = bdrv_co_preadv(bs->backing, offset, cur_bytes,
+                                     &hd_qiov, 0);
+                qemu_co_mutex_lock(&s->lock);
+                if (ret < 0) {
+                    goto fail;
                 }
             } else {
                 /* Note: in this case, no need to wait */
-- 
2.13.6
