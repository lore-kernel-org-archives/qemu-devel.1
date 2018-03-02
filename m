Received: from eggs.gnu.org ([2001:4830:134:3::10]:52376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erppy-00011D-UO
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erppx-0002d2-1P
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:17 +0100
Message-Id: <20180302185448.6314-7-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/37] iscsi: Switch cluster_sectors to
 byte-based
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

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert all uses of
the cluster size in sectors, along with adding assertions that we
are not dividing by zero.

Improve some comment grammar while in the area.

Signed-off-by: Eric Blake <eblake@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 56 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 421983dd6f..3414c21c7f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -86,7 +86,7 @@ typedef struct IscsiLun {
     unsigned long *allocmap;
     unsigned long *allocmap_valid;
     long allocmap_size;
-    int cluster_sectors;
+    int cluster_size;
     bool use_16_for_rw;
     bool write_protected;
     bool lbpme;
@@ -430,9 +430,10 @@ static int iscsi_allocmap_init(IscsiLun *iscsilun, int open_flags)
 {
     iscsi_allocmap_free(iscsilun);
 
+    assert(iscsilun->cluster_size);
     iscsilun->allocmap_size =
-        DIV_ROUND_UP(sector_lun2qemu(iscsilun->num_blocks, iscsilun),
-                     iscsilun->cluster_sectors);
+        DIV_ROUND_UP(iscsilun->num_blocks * iscsilun->block_size,
+                     iscsilun->cluster_size);
 
     iscsilun->allocmap = bitmap_try_new(iscsilun->allocmap_size);
     if (!iscsilun->allocmap) {
@@ -440,7 +441,7 @@ static int iscsi_allocmap_init(IscsiLun *iscsilun, int open_flags)
     }
 
     if (open_flags & BDRV_O_NOCACHE) {
-        /* in case that cache.direct = on all allocmap entries are
+        /* when cache.direct = on all allocmap entries are
          * treated as invalid to force a relookup of the block
          * status on every read request */
         return 0;
@@ -461,17 +462,19 @@ iscsi_allocmap_update(IscsiLun *iscsilun, int64_t sector_num,
                       int nb_sectors, bool allocated, bool valid)
 {
     int64_t cl_num_expanded, nb_cls_expanded, cl_num_shrunk, nb_cls_shrunk;
+    int cluster_sectors = iscsilun->cluster_size >> BDRV_SECTOR_BITS;
 
     if (iscsilun->allocmap == NULL) {
         return;
     }
     /* expand to entirely contain all affected clusters */
-    cl_num_expanded = sector_num / iscsilun->cluster_sectors;
+    assert(cluster_sectors);
+    cl_num_expanded = sector_num / cluster_sectors;
     nb_cls_expanded = DIV_ROUND_UP(sector_num + nb_sectors,
-                                   iscsilun->cluster_sectors) - cl_num_expanded;
+                                   cluster_sectors) - cl_num_expanded;
     /* shrink to touch only completely contained clusters */
-    cl_num_shrunk = DIV_ROUND_UP(sector_num, iscsilun->cluster_sectors);
-    nb_cls_shrunk = (sector_num + nb_sectors) / iscsilun->cluster_sectors
+    cl_num_shrunk = DIV_ROUND_UP(sector_num, cluster_sectors);
+    nb_cls_shrunk = (sector_num + nb_sectors) / cluster_sectors
                       - cl_num_shrunk;
     if (allocated) {
         bitmap_set(iscsilun->allocmap, cl_num_expanded, nb_cls_expanded);
@@ -535,9 +538,12 @@ iscsi_allocmap_is_allocated(IscsiLun *iscsilun, int64_t sector_num,
     if (iscsilun->allocmap == NULL) {
         return true;
     }
-    size = DIV_ROUND_UP(sector_num + nb_sectors, iscsilun->cluster_sectors);
+    assert(iscsilun->cluster_size);
+    size = DIV_ROUND_UP(sector_num + nb_sectors,
+                        iscsilun->cluster_size >> BDRV_SECTOR_BITS);
     return !(find_next_bit(iscsilun->allocmap, size,
-                           sector_num / iscsilun->cluster_sectors) == size);
+                           sector_num * BDRV_SECTOR_SIZE /
+                           iscsilun->cluster_size) == size);
 }
 
 static inline bool iscsi_allocmap_is_valid(IscsiLun *iscsilun,
@@ -547,9 +553,12 @@ static inline bool iscsi_allocmap_is_valid(IscsiLun *iscsilun,
     if (iscsilun->allocmap_valid == NULL) {
         return false;
     }
-    size = DIV_ROUND_UP(sector_num + nb_sectors, iscsilun->cluster_sectors);
+    assert(iscsilun->cluster_size);
+    size = DIV_ROUND_UP(sector_num + nb_sectors,
+                        iscsilun->cluster_size >> BDRV_SECTOR_BITS);
     return (find_next_zero_bit(iscsilun->allocmap_valid, size,
-                               sector_num / iscsilun->cluster_sectors) == size);
+                               sector_num * BDRV_SECTOR_SIZE /
+                               iscsilun->cluster_size) == size);
 }
 
 static int coroutine_fn
@@ -793,16 +802,21 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
         BlockDriverState *file;
         /* check the block status from the beginning of the cluster
          * containing the start sector */
-        int64_t ret = iscsi_co_get_block_status(bs,
-                          sector_num - sector_num % iscsilun->cluster_sectors,
-                          BDRV_REQUEST_MAX_SECTORS, &pnum, &file);
+        int cluster_sectors = iscsilun->cluster_size >> BDRV_SECTOR_BITS;
+        int head;
+        int64_t ret;
+
+        assert(cluster_sectors);
+        head = sector_num % cluster_sectors;
+        ret = iscsi_co_get_block_status(bs, sector_num - head,
+                                        BDRV_REQUEST_MAX_SECTORS, &pnum,
+                                        &file);
         if (ret < 0) {
             return ret;
         }
         /* if the whole request falls into an unallocated area we can avoid
-         * to read and directly return zeroes instead */
-        if (ret & BDRV_BLOCK_ZERO &&
-            pnum >= nb_sectors + sector_num % iscsilun->cluster_sectors) {
+         * reading and directly return zeroes instead */
+        if (ret & BDRV_BLOCK_ZERO && pnum >= nb_sectors + head) {
             qemu_iovec_memset(iov, 0, 0x00, iov->size);
             return 0;
         }
@@ -1953,8 +1967,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
      * reasonable size */
     if (iscsilun->bl.opt_unmap_gran * iscsilun->block_size >= 4 * 1024 &&
         iscsilun->bl.opt_unmap_gran * iscsilun->block_size <= 16 * 1024 * 1024) {
-        iscsilun->cluster_sectors = (iscsilun->bl.opt_unmap_gran *
-                                     iscsilun->block_size) >> BDRV_SECTOR_BITS;
+        iscsilun->cluster_size = iscsilun->bl.opt_unmap_gran *
+            iscsilun->block_size;
         if (iscsilun->lbprz) {
             ret = iscsi_allocmap_init(iscsilun, bs->open_flags);
         }
@@ -2163,7 +2177,7 @@ static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     IscsiLun *iscsilun = bs->opaque;
     bdi->unallocated_blocks_are_zero = iscsilun->lbprz;
-    bdi->cluster_size = iscsilun->cluster_sectors * BDRV_SECTOR_SIZE;
+    bdi->cluster_size = iscsilun->cluster_size;
     return 0;
 }
 
-- 
2.13.6
