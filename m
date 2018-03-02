Received: from eggs.gnu.org ([2001:4830:134:3::10]:52465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpq4-00018Y-7e
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpq0-0002gx-Sk
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:28 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:19 +0100
Message-Id: <20180302185448.6314-9-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/37] iscsi: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the iscsi driver accordingly.  In this case,
it is handy to teach iscsi_co_block_status() to handle a NULL map
and file parameter, even though the block layer passes non-NULL
values, because we also call the function directly.  For now, there
are no optimizations done based on the want_zero flag.

We can also make the simplification of asserting that the block
layer passed in aligned values.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 69 ++++++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index d2b0466775..c228ca21c8 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -653,36 +653,36 @@ out_unlock:
 
 
 
-static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
-                                                  int64_t sector_num,
-                                                  int nb_sectors, int *pnum,
-                                                  BlockDriverState **file)
+static int coroutine_fn iscsi_co_block_status(BlockDriverState *bs,
+                                              bool want_zero, int64_t offset,
+                                              int64_t bytes, int64_t *pnum,
+                                              int64_t *map,
+                                              BlockDriverState **file)
 {
     IscsiLun *iscsilun = bs->opaque;
     struct scsi_get_lba_status *lbas = NULL;
     struct scsi_lba_status_descriptor *lbasd = NULL;
     struct IscsiTask iTask;
     uint64_t lba;
-    int64_t ret;
+    int ret;
 
     iscsi_co_init_iscsitask(iscsilun, &iTask);
 
-    if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
-        ret = -EINVAL;
-        goto out;
-    }
+    assert(QEMU_IS_ALIGNED(offset | bytes, iscsilun->block_size));
 
     /* default to all sectors allocated */
-    ret = BDRV_BLOCK_DATA;
-    ret |= (sector_num << BDRV_SECTOR_BITS) | BDRV_BLOCK_OFFSET_VALID;
-    *pnum = nb_sectors;
+    ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
+    if (map) {
+        *map = offset;
+    }
+    *pnum = bytes;
 
     /* LUN does not support logical block provisioning */
     if (!iscsilun->lbpme) {
         goto out;
     }
 
-    lba = sector_qemu2lun(sector_num, iscsilun);
+    lba = offset / iscsilun->block_size;
 
     qemu_mutex_lock(&iscsilun->mutex);
 retry:
@@ -727,12 +727,12 @@ retry:
 
     lbasd = &lbas->descriptors[0];
 
-    if (sector_qemu2lun(sector_num, iscsilun) != lbasd->lba) {
+    if (lba != lbasd->lba) {
         ret = -EIO;
         goto out_unlock;
     }
 
-    *pnum = sector_lun2qemu(lbasd->num_blocks, iscsilun);
+    *pnum = lbasd->num_blocks * iscsilun->block_size;
 
     if (lbasd->provisioning == SCSI_PROVISIONING_TYPE_DEALLOCATED ||
         lbasd->provisioning == SCSI_PROVISIONING_TYPE_ANCHORED) {
@@ -743,15 +743,13 @@ retry:
     }
 
     if (ret & BDRV_BLOCK_ZERO) {
-        iscsi_allocmap_set_unallocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
-                                       *pnum * BDRV_SECTOR_SIZE);
+        iscsi_allocmap_set_unallocated(iscsilun, offset, *pnum);
     } else {
-        iscsi_allocmap_set_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
-                                     *pnum * BDRV_SECTOR_SIZE);
+        iscsi_allocmap_set_allocated(iscsilun, offset, *pnum);
     }
 
-    if (*pnum > nb_sectors) {
-        *pnum = nb_sectors;
+    if (*pnum > bytes) {
+        *pnum = bytes;
     }
 out_unlock:
     qemu_mutex_unlock(&iscsilun->mutex);
@@ -760,7 +758,7 @@ out:
     if (iTask.task != NULL) {
         scsi_free_scsi_task(iTask.task);
     }
-    if (ret > 0 && ret & BDRV_BLOCK_OFFSET_VALID) {
+    if (ret > 0 && ret & BDRV_BLOCK_OFFSET_VALID && file) {
         *file = bs;
     }
     return ret;
@@ -800,25 +798,24 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
                                  nb_sectors * BDRV_SECTOR_SIZE) &&
         !iscsi_allocmap_is_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
                                      nb_sectors * BDRV_SECTOR_SIZE)) {
-        int pnum;
-        BlockDriverState *file;
+        int64_t pnum;
         /* check the block status from the beginning of the cluster
          * containing the start sector */
-        int cluster_sectors = iscsilun->cluster_size >> BDRV_SECTOR_BITS;
-        int head;
-        int64_t ret;
-
-        assert(cluster_sectors);
-        head = sector_num % cluster_sectors;
-        ret = iscsi_co_get_block_status(bs, sector_num - head,
-                                        BDRV_REQUEST_MAX_SECTORS, &pnum,
-                                        &file);
+        int64_t head;
+        int ret;
+
+        assert(iscsilun->cluster_size);
+        head = (sector_num * BDRV_SECTOR_SIZE) % iscsilun->cluster_size;
+        ret = iscsi_co_block_status(bs, true,
+                                    sector_num * BDRV_SECTOR_SIZE - head,
+                                    BDRV_REQUEST_MAX_BYTES, &pnum, NULL, NULL);
         if (ret < 0) {
             return ret;
         }
         /* if the whole request falls into an unallocated area we can avoid
          * reading and directly return zeroes instead */
-        if (ret & BDRV_BLOCK_ZERO && pnum >= nb_sectors + head) {
+        if (ret & BDRV_BLOCK_ZERO &&
+            pnum >= nb_sectors * BDRV_SECTOR_SIZE + head) {
             qemu_iovec_memset(iov, 0, 0x00, iov->size);
             return 0;
         }
@@ -2218,7 +2215,7 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_truncate   = iscsi_truncate,
     .bdrv_refresh_limits = iscsi_refresh_limits,
 
-    .bdrv_co_get_block_status = iscsi_co_get_block_status,
+    .bdrv_co_block_status  = iscsi_co_block_status,
     .bdrv_co_pdiscard      = iscsi_co_pdiscard,
     .bdrv_co_pwrite_zeroes = iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         = iscsi_co_readv,
@@ -2253,7 +2250,7 @@ static BlockDriver bdrv_iser = {
     .bdrv_truncate   = iscsi_truncate,
     .bdrv_refresh_limits = iscsi_refresh_limits,
 
-    .bdrv_co_get_block_status = iscsi_co_get_block_status,
+    .bdrv_co_block_status  = iscsi_co_block_status,
     .bdrv_co_pdiscard      = iscsi_co_pdiscard,
     .bdrv_co_pwrite_zeroes = iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         = iscsi_co_readv,
-- 
2.13.6
