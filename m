Received: from eggs.gnu.org ([2001:4830:134:3::10]:55452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVfC-0004bX-41
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVf7-0006o7-5F
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:23:02 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 29 Jun 2017 14:53:36 +0530
Message-Id: <1498728221-23979-4-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
References: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v7 3/8] vmdk: Rename get_cluster_offset() to
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

Rename the existing get_cluster_offset() to vmdk_get_cluster_offset()
and update name in all the callers accordingly.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/vmdk.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 73ae786..f403981 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1144,7 +1144,7 @@ static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
 }
 
 /**
- * get_cluster_offset
+ * vmdk_get_cluster_offset
  *
  * Look up cluster offset in extent file by sector number, and store in
  * @cluster_offset.
@@ -1163,14 +1163,14 @@ static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
  *          VMDK_UNALLOC if cluster is not mapped and @allocate is false.
  *          VMDK_ERROR if failed.
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
+                                   VmdkMetaData *m_data,
+                                   uint64_t offset,
+                                   bool allocate,
+                                   uint64_t *cluster_offset,
+                                   uint64_t skip_start_bytes,
+                                   uint64_t skip_end_bytes)
 {
     unsigned int l1_index, l2_offset, l2_index;
     int min_index, i, j;
@@ -1304,9 +1304,9 @@ static int64_t coroutine_fn vmdk_co_get_block_status(BlockDriverState *bs,
         return 0;
     }
     qemu_co_mutex_lock(&s->lock);
-    ret = get_cluster_offset(bs, extent, NULL,
-                             sector_num * 512, false, &offset,
-                             0, 0);
+    ret = vmdk_get_cluster_offset(bs, extent, NULL,
+                                  sector_num * 512, false, &offset,
+                                  0, 0);
     qemu_co_mutex_unlock(&s->lock);
 
     index_in_cluster = vmdk_find_index_in_cluster(extent, sector_num);
@@ -1497,8 +1497,8 @@ vmdk_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
             ret = -EIO;
             goto fail;
         }
-        ret = get_cluster_offset(bs, extent, NULL,
-                                 offset, false, &cluster_offset, 0, 0);
+        ret = vmdk_get_cluster_offset(bs, extent, NULL,
+                                      offset, false, &cluster_offset, 0, 0);
         offset_in_cluster = vmdk_find_offset_in_cluster(extent, offset);
 
         n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
@@ -1584,10 +1584,10 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
         n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
                              - offset_in_cluster);
 
-        ret = get_cluster_offset(bs, extent, &m_data, offset,
-                                 !(extent->compressed || zeroed),
-                                 &cluster_offset, offset_in_cluster,
-                                 offset_in_cluster + n_bytes);
+        ret = vmdk_get_cluster_offset(bs, extent, &m_data, offset,
+                                      !(extent->compressed || zeroed),
+                                      &cluster_offset, offset_in_cluster,
+                                      offset_in_cluster + n_bytes);
         if (extent->compressed) {
             if (ret == VMDK_OK) {
                 /* Refuse write to allocated cluster for streamOptimized */
@@ -1596,8 +1596,8 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
                 return -EIO;
             } else {
                 /* allocate */
-                ret = get_cluster_offset(bs, extent, &m_data, offset,
-                                         true, &cluster_offset, 0, 0);
+                ret = vmdk_get_cluster_offset(bs, extent, &m_data, offset,
+                                              true, &cluster_offset, 0, 0);
             }
         }
         if (ret == VMDK_ERROR) {
@@ -2229,9 +2229,9 @@ static int vmdk_check(BlockDriverState *bs, BdrvCheckResult *result,
                     sector_num);
             break;
         }
-        ret = get_cluster_offset(bs, extent, NULL,
-                                 sector_num << BDRV_SECTOR_BITS,
-                                 false, &cluster_offset, 0, 0);
+        ret = vmdk_get_cluster_offset(bs, extent, NULL,
+                                      sector_num << BDRV_SECTOR_BITS,
+                                      false, &cluster_offset, 0, 0);
         if (ret == VMDK_ERROR) {
             fprintf(stderr,
                     "ERROR: could not get cluster_offset for sector %"
-- 
2.6.2
