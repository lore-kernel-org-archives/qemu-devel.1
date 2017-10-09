Received: from eggs.gnu.org ([2001:4830:134:3::10]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1e1Xcs-0000pr-IH
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1e1Xcr-0001ra-NB
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:57:42 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon,  9 Oct 2017 18:29:33 +0530
Message-Id: <20171009125940.24220-2-ashijeetacharya@gmail.com>
In-Reply-To: <20171009125940.24220-1-ashijeetacharya@gmail.com>
References: <20171009125940.24220-1-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v9 1/8] vmdk: Move
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
index c665bcc977..e86ca39ff2 100644
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
 /* Return -ve errno, or 0 on success and write CID into *pcid. */
 static int vmdk_read_cid(BlockDriverState *bs, int parent, uint32_t *pcid)
 {
@@ -1283,18 +1295,6 @@ static VmdkExtent *find_extent(BDRVVmdkState *s,
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
2.13.5
