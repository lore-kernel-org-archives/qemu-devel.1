Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVep-0004IB-GI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVeo-0006fP-Nq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:22:39 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 29 Jun 2017 14:53:34 +0530
Message-Id: <1498728221-23979-2-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
References: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v7 1/8] vmdk: Move
 vmdk_find_offset_in_cluster() to the top
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

Move the existing vmdk_find_offset_in_cluster() function to the top of
the driver.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/vmdk.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index a9bd22b..22be887 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -242,6 +242,18 @@ static void vmdk_free_last_extent(BlockDriverState *bs)
     s->extents = g_renew(VmdkExtent, s->extents, s->num_extents);
 }
 
+static inline uint64_t vmdk_find_offset_in_cluster(VmdkExtent *extent,
+                                                   int64_t offset)
+{
+    uint64_t extent_begin_offset, extent_relative_offset;
+    uint64_t cluster_size = extent->cluster_sectors * BDRV_SECTOR_SIZE;
+
+    extent_begin_offset =
+        (extent->end_sector - extent->sectors) * BDRV_SECTOR_SIZE;
+    extent_relative_offset = offset - extent_begin_offset;
+    return extent_relative_offset % cluster_size;
+}
+
 static uint32_t vmdk_read_cid(BlockDriverState *bs, int parent)
 {
     char *desc;
@@ -1266,18 +1278,6 @@ static VmdkExtent *find_extent(BDRVVmdkState *s,
     return NULL;
 }
 
-static inline uint64_t vmdk_find_offset_in_cluster(VmdkExtent *extent,
-                                                   int64_t offset)
-{
-    uint64_t extent_begin_offset, extent_relative_offset;
-    uint64_t cluster_size = extent->cluster_sectors * BDRV_SECTOR_SIZE;
-
-    extent_begin_offset =
-        (extent->end_sector - extent->sectors) * BDRV_SECTOR_SIZE;
-    extent_relative_offset = offset - extent_begin_offset;
-    return extent_relative_offset % cluster_size;
-}
-
 static inline uint64_t vmdk_find_index_in_cluster(VmdkExtent *extent,
                                                   int64_t sector_num)
 {
-- 
2.6.2
