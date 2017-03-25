Received: from eggs.gnu.org ([2001:4830:134:3::10]:35096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1crji3-000158-Ow
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1crji2-0000ny-SZ
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:18:15 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat, 25 Mar 2017 16:48:15 +0530
Message-Id: <1490440701-12037-2-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1490440701-12037-1-git-send-email-ashijeetacharya@gmail.com>
References: <1490440701-12037-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/7] vmdk: Refactor and introduce new helper
 functions
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
the driver. Also, introduce a new helper function size_to_clusters()
which returns the number of clusters for a given size in bytes. Here,
we leave the last cluster as we need to perform COW for that one.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/vmdk.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index a9bd22b..7795c5f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -242,6 +242,26 @@ static void vmdk_free_last_extent(BlockDriverState *bs)
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
+static inline uint64_t size_to_clusters(VmdkExtent *extent, uint64_t size)
+{
+    uint64_t cluster_size, round_off_size;
+    cluster_size = extent->cluster_sectors * BDRV_SECTOR_SIZE;
+    round_off_size = cluster_size - (size % cluster_size);
+    return ((size + round_off_size) >> 16) - 1;
+}
+
 static uint32_t vmdk_read_cid(BlockDriverState *bs, int parent)
 {
     char *desc;
@@ -1266,18 +1286,6 @@ static VmdkExtent *find_extent(BDRVVmdkState *s,
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
