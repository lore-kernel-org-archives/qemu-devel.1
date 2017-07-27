Received: from eggs.gnu.org ([2001:4830:134:3::10]:58082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dajpn-000886-Bg
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dajpm-00066o-Dr
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:32:15 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 27 Jul 2017 20:03:10 +0530
Message-Id: <1501165990-28033-9-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1501165990-28033-1-git-send-email-ashijeetacharya@gmail.com>
References: <1501165990-28033-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v8 8/8] vmdk: Make vmdk_get_cluster_offset()
 return cluster offset only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

vmdk_alloc_clusters() introduced earlier now handles the task of
allocating clusters and performing COW when needed. Thus we can change
vmdk_get_cluster_offset() to stick to the sole purpose of returning
cluster offset using sector number. Update the changes at all call
sites.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/vmdk.c | 56 ++++++++++++--------------------------------------------
 1 file changed, 12 insertions(+), 44 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 4a59ca4..a84b26c 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1494,25 +1494,16 @@ static int vmdk_alloc_clusters(BlockDriverState *bs,
  * For flat extents, the start offset as parsed from the description file is
  * returned.
  *
- * For sparse extents, look up in L1, L2 table. If allocate is true, return an
- * offset for a new cluster and update L2 cache. If there is a backing file,
- * COW is done before returning; otherwise, zeroes are written to the allocated
- * cluster. Both COW and zero writing skips the sector range
- * [@skip_start_sector, @skip_end_sector) passed in by caller, because caller
- * has new data to write there.
+ * For sparse extents, look up the L1, L2 table.
  *
  * Returns: VMDK_OK if cluster exists and mapped in the image.
- *          VMDK_UNALLOC if cluster is not mapped and @allocate is false.
- *          VMDK_ERROR if failed.
+ *          VMDK_UNALLOC if cluster is not mapped.
+ *          VMDK_ERROR if failed
  */
 static int vmdk_get_cluster_offset(BlockDriverState *bs,
                                    VmdkExtent *extent,
-                                   VmdkMetaData *m_data,
                                    uint64_t offset,
-                                   bool allocate,
-                                   uint64_t *cluster_offset,
-                                   uint64_t skip_start_bytes,
-                                   uint64_t skip_end_bytes)
+                                   uint64_t *cluster_offset)
 {
     int l1_index, l2_offset, l2_index;
     uint32_t *l2_table;
@@ -1537,31 +1528,9 @@ static int vmdk_get_cluster_offset(BlockDriverState *bs,
     }
 
     if (!cluster_sector || zeroed) {
-        if (!allocate) {
-            return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
-        }
-
-        cluster_sector = extent->next_cluster_sector;
-        extent->next_cluster_sector += extent->cluster_sectors;
-
-        /* First of all we write grain itself, to avoid race condition
-         * that may to corrupt the image.
-         * This problem may occur because of insufficient space on host disk
-         * or inappropriate VM shutdown.
-         */
-        ret = vmdk_perform_cow(bs, extent, cluster_sector * BDRV_SECTOR_SIZE,
-                                offset, skip_start_bytes, skip_end_bytes);
-        if (ret) {
-            return ret;
-        }
-        if (m_data) {
-            m_data->valid = 1;
-            m_data->l1_index = l1_index;
-            m_data->l2_index = l2_index;
-            m_data->l2_offset = l2_offset;
-            m_data->l2_cache_entry = &l2_table[l2_index];
-        }
+        return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
     }
+
     *cluster_offset = cluster_sector << BDRV_SECTOR_BITS;
     return VMDK_OK;
 }
@@ -1604,9 +1573,7 @@ static int64_t coroutine_fn vmdk_co_get_block_status(BlockDriverState *bs,
         return 0;
     }
     qemu_co_mutex_lock(&s->lock);
-    ret = vmdk_get_cluster_offset(bs, extent, NULL,
-                                  sector_num * 512, false, &offset,
-                                  0, 0);
+    ret = vmdk_get_cluster_offset(bs, extent, sector_num * 512, &offset);
     qemu_co_mutex_unlock(&s->lock);
 
     index_in_cluster = vmdk_find_index_in_cluster(extent, sector_num);
@@ -1797,13 +1764,14 @@ vmdk_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
             ret = -EIO;
             goto fail;
         }
-        ret = vmdk_get_cluster_offset(bs, extent, NULL,
-                                      offset, false, &cluster_offset, 0, 0);
+
         offset_in_cluster = vmdk_find_offset_in_cluster(extent, offset);
 
         n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
                              - offset_in_cluster);
 
+        ret = vmdk_get_cluster_offset(bs, extent, offset, &cluster_offset);
+
         if (ret != VMDK_OK) {
             /* if not allocated, try to read from parent image, if exist */
             if (bs->backing && ret != VMDK_ZEROED) {
@@ -2550,9 +2518,9 @@ static int vmdk_check(BlockDriverState *bs, BdrvCheckResult *result,
                     sector_num);
             break;
         }
-        ret = vmdk_get_cluster_offset(bs, extent, NULL,
+        ret = vmdk_get_cluster_offset(bs, extent,
                                       sector_num << BDRV_SECTOR_BITS,
-                                      false, &cluster_offset, 0, 0);
+                                      &cluster_offset);
         if (ret == VMDK_ERROR) {
             fprintf(stderr,
                     "ERROR: could not get cluster_offset for sector %"
-- 
2.6.2
