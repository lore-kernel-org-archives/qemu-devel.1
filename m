Received: from eggs.gnu.org ([2001:4830:134:3::10]:40588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cuKGZ-00063R-Un
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cuKGY-00042O-Jg
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:44:36 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat,  1 Apr 2017 20:14:36 +0530
Message-Id: <1491057878-27868-5-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
References: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v3 4/6] vmdk: Rename get_cluster_offset() to
 vmdk_get_cluster_offset()
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

Rename the existing get_cluster_offset() function to
vmdk_get_cluster_offset() and have it make use of the new
get_cluster_table() to load the cluster tables. Also, it is no longer
used to allocate new clusters and hence perform COW. Make the necessary
renames at all the occurrences of get_cluster_offset().

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/vmdk.c | 117 +++++++++++------------------------------------------------
 1 file changed, 21 insertions(+), 96 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index e5a289d..a8babd7 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1419,7 +1419,7 @@ static int vmdk_alloc_cluster_offset(BlockDriverState *bs,
 }
 
 /**
- * get_cluster_offset
+ * vmdk_get_cluster_offset
  *
  * Look up cluster offset in extent file by sector number, and store in
  * @cluster_offset.
@@ -1427,84 +1427,34 @@ static int vmdk_alloc_cluster_offset(BlockDriverState *bs,
  * For flat extents, the start offset as parsed from the description file is
  * returned.
  *
- * For sparse extents, look up in L1, L2 table. If allocate is true, return an
- * offset for a new cluster and update L2 cache. If there is a backing file,
- * COW is done before returning; otherwise, zeroes are written to the allocated
- * cluster. Both COW and zero writing skips the sector range
- * [@skip_start_sector, @skip_end_sector) passed in by caller, because caller
- * has new data to write there.
+ * For sparse extents, look up in L1, L2 table.
  *
  * Returns: VMDK_OK if cluster exists and mapped in the image.
- *          VMDK_UNALLOC if cluster is not mapped and @allocate is false.
- *          VMDK_ERROR if failed.
+ *          VMDK_UNALLOC if cluster is not mapped.
+ *          VMDK_ERROR if failed
  */
-static int get_cluster_offset(BlockDriverState *bs,
-                              VmdkExtent *extent,
-                              VmdkMetaData *m_data,
-                              uint64_t offset,
-                              bool allocate,
-                              uint64_t *cluster_offset,
-                              uint64_t skip_start_bytes,
-                              uint64_t skip_end_bytes)
+static int vmdk_get_cluster_offset(BlockDriverState *bs,
+                                   VmdkExtent *extent,
+                                   uint64_t offset,
+                                   uint64_t *cluster_offset)
 {
-    unsigned int l1_index, l2_offset, l2_index;
-    int min_index, i, j;
-    uint32_t min_count, *l2_table;
+    int l1_index, l2_offset, l2_index;
+    uint32_t *l2_table;
     bool zeroed = false;
     int64_t ret;
     int64_t cluster_sector;
 
-    if (m_data) {
-        m_data->valid = 0;
-    }
     if (extent->flat) {
         *cluster_offset = extent->flat_start_offset;
         return VMDK_OK;
     }
 
-    offset -= (extent->end_sector - extent->sectors) * SECTOR_SIZE;
-    l1_index = (offset >> 9) / extent->l1_entry_sectors;
-    if (l1_index >= extent->l1_size) {
-        return VMDK_ERROR;
-    }
-    l2_offset = extent->l1_table[l1_index];
-    if (!l2_offset) {
-        return VMDK_UNALLOC;
-    }
-    for (i = 0; i < L2_CACHE_SIZE; i++) {
-        if (l2_offset == extent->l2_cache_offsets[i]) {
-            /* increment the hit count */
-            if (++extent->l2_cache_counts[i] == 0xffffffff) {
-                for (j = 0; j < L2_CACHE_SIZE; j++) {
-                    extent->l2_cache_counts[j] >>= 1;
-                }
-            }
-            l2_table = extent->l2_cache + (i * extent->l2_size);
-            goto found;
-        }
-    }
-    /* not found: load a new entry in the least used one */
-    min_index = 0;
-    min_count = 0xffffffff;
-    for (i = 0; i < L2_CACHE_SIZE; i++) {
-        if (extent->l2_cache_counts[i] < min_count) {
-            min_count = extent->l2_cache_counts[i];
-            min_index = i;
-        }
-    }
-    l2_table = extent->l2_cache + (min_index * extent->l2_size);
-    if (bdrv_pread(extent->file,
-                (int64_t)l2_offset * 512,
-                l2_table,
-                extent->l2_size * sizeof(uint32_t)
-            ) != extent->l2_size * sizeof(uint32_t)) {
-        return VMDK_ERROR;
+    ret = get_cluster_table(extent, offset, &l1_index, &l2_offset,
+                            &l2_index, &l2_table);
+    if (ret < 0) {
+        return ret;
     }
 
-    extent->l2_cache_offsets[min_index] = l2_offset;
-    extent->l2_cache_counts[min_index] = 1;
- found:
-    l2_index = ((offset >> 9) / extent->cluster_sectors) % extent->l2_size;
     cluster_sector = le32_to_cpu(l2_table[l2_index]);
 
     if (extent->has_zero_grain && cluster_sector == VMDK_GTE_ZEROED) {
@@ -1512,31 +1462,9 @@ static int get_cluster_offset(BlockDriverState *bs,
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
@@ -1579,9 +1507,7 @@ static int64_t coroutine_fn vmdk_co_get_block_status(BlockDriverState *bs,
         return 0;
     }
     qemu_co_mutex_lock(&s->lock);
-    ret = get_cluster_offset(bs, extent, NULL,
-                             sector_num * 512, false, &offset,
-                             0, 0);
+    ret = vmdk_get_cluster_offset(bs, extent, sector_num * 512, &offset);
     qemu_co_mutex_unlock(&s->lock);
 
     index_in_cluster = vmdk_find_index_in_cluster(extent, sector_num);
@@ -1772,13 +1698,13 @@ vmdk_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
             ret = -EIO;
             goto fail;
         }
-        ret = get_cluster_offset(bs, extent, NULL,
-                                 offset, false, &cluster_offset, 0, 0);
         offset_in_cluster = vmdk_find_offset_in_cluster(extent, offset);
 
         n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
                              - offset_in_cluster);
 
+        ret = vmdk_get_cluster_offset(bs, extent, offset, &cluster_offset);
+
         if (ret != VMDK_OK) {
             /* if not allocated, try to read from parent image, if exist */
             if (bs->backing && ret != VMDK_ZEROED) {
@@ -2508,9 +2434,8 @@ static int vmdk_check(BlockDriverState *bs, BdrvCheckResult *result,
                     sector_num);
             break;
         }
-        ret = get_cluster_offset(bs, extent, NULL,
-                                 sector_num << BDRV_SECTOR_BITS,
-                                 false, &cluster_offset, 0, 0);
+        ret = vmdk_get_cluster_offset(bs, extent,
+                        sector_num << BDRV_SECTOR_BITS, &cluster_offset);
         if (ret == VMDK_ERROR) {
             fprintf(stderr,
                     "ERROR: could not get cluster_offset for sector %"
-- 
2.6.2
