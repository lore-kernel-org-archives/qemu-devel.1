Received: from eggs.gnu.org ([2001:4830:134:3::10]:50583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1e1XdC-000181-Uc
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1e1XdC-00022E-6H
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:58:03 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon,  9 Oct 2017 18:29:37 +0530
Message-Id: <20171009125940.24220-6-ashijeetacharya@gmail.com>
In-Reply-To: <20171009125940.24220-1-ashijeetacharya@gmail.com>
References: <20171009125940.24220-1-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v9 5/8] vmdk: Set maximum bytes allocated in
 one cycle
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

Set the maximum bytes allowed to get allocated at once to be not more
than the extent size boundary to handle writes at two separate extents
appropriately.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/vmdk.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 07707779a0..11bc0f09c7 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1641,6 +1641,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
     uint64_t cluster_offset;
     uint64_t bytes_done = 0;
     VmdkMetaData m_data;
+    uint64_t extent_end;
 
     if (DIV_ROUND_UP(offset, BDRV_SECTOR_SIZE) > bs->total_sectors) {
         error_report("Wrong offset: offset=0x%" PRIx64
@@ -1654,9 +1655,17 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
         if (!extent) {
             return -EIO;
         }
+        extent_end = extent->end_sector * BDRV_SECTOR_SIZE;
+
         offset_in_cluster = vmdk_find_offset_in_cluster(extent, offset);
-        n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
-                             - offset_in_cluster);
+
+        /* truncate n_bytes to first cluster because we need to perform COW */
+        if (offset_in_cluster > 0) {
+            n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
+                                 - offset_in_cluster);
+        } else {
+            n_bytes = MIN(bytes, extent_end - offset);
+        }
 
         ret = vmdk_get_cluster_offset(bs, extent, &m_data, offset,
                                       !(extent->compressed || zeroed),
-- 
2.13.5
