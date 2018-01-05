Received: from eggs.gnu.org ([2001:4830:134:3::10]:47406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawM-0002vK-IR
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawL-00006Y-9w
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:18 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:38 -0600
Message-Id: <20180105225753.30509-6-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 05/20] iscsi: Switch cluster_sectors to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert all uses of
the cluster size in sectors, along with adding assertions that we
are not dividing by zero.

Improve some comment grammar while in the area.

Signed-off-by: Eric Blake <eblake@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v2-v7: no change
---
 block/iscsi.c | 56 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 5c0a9e55b6..7b03da54ee 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -84,7 +84,7 @@ typedef struct IscsiLun {
     unsigned long *allocmap;
     unsigned long *allocmap_valid;
     long allocmap_size;
-    int cluster_sectors;
+    int cluster_size;
     bool use_16_for_rw;
     bool write_protected;
     bool lbpme;
@@ -428,9 +428,10 @@ static int iscsi_allocmap_init(IscsiLun *iscsilun, int open_flags)
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
@@ -438,7 +439,7 @@ static int iscsi_allocmap_init(IscsiLun *iscsilun, int open_flags)
     }

     if (open_flags & BDRV_O_NOCACHE) {
-        /* in case that cache.direct = on all allocmap entries are
+        /* when cache.direct = on all allocmap entries are
          * treated as invalid to force a relookup of the block
          * status on every read request */
         return 0;
@@ -459,17 +460,19 @@ iscsi_allocmap_update(IscsiLun *iscsilun, int64_t sector_num,
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
@@ -533,9 +536,12 @@ iscsi_allocmap_is_allocated(IscsiLun *iscsilun, int64_t sector_num,
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
@@ -545,9 +551,12 @@ static inline bool iscsi_allocmap_is_valid(IscsiLun *iscsilun,
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
@@ -790,16 +799,21 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
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
@@ -1951,8 +1965,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -2158,7 +2172,7 @@ static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     IscsiLun *iscsilun = bs->opaque;
     bdi->unallocated_blocks_are_zero = iscsilun->lbprz;
     bdi->can_write_zeroes_with_unmap = iscsilun->lbprz && iscsilun->lbp.lbpws;
-    bdi->cluster_size = iscsilun->cluster_sectors * BDRV_SECTOR_SIZE;
+    bdi->cluster_size = iscsilun->cluster_size;
     return 0;
 }

-- 
2.14.3
