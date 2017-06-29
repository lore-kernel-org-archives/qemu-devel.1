Received: from eggs.gnu.org ([2001:4830:134:3::10]:55380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVey-0004QP-Ok
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVey-0006kz-1C
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:22:48 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 29 Jun 2017 14:53:35 +0530
Message-Id: <1498728221-23979-3-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
References: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v7 2/8] vmdk: Rename get_whole_cluster() to
 vmdk_perform_cow()
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

Rename the existing function get_whole_cluster() to vmdk_perform_cow()
as its sole purpose is to perform COW for the first and the last
allocated clusters if needed.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/vmdk.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 22be887..73ae786 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1028,8 +1028,8 @@ static void vmdk_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 }
 
-/**
- * get_whole_cluster
+/*
+ * vmdk_perform_cow
  *
  * Copy backing file's cluster that covers @sector_num, otherwise write zero,
  * to the cluster at @cluster_sector_num.
@@ -1037,13 +1037,18 @@ static void vmdk_refresh_limits(BlockDriverState *bs, Error **errp)
  * If @skip_start_sector < @skip_end_sector, the relative range
  * [@skip_start_sector, @skip_end_sector) is not copied or written, and leave
  * it for call to write user data in the request.
+ *
+ * Returns:
+ *   VMDK_OK:       on success
+ *
+ *   VMDK_ERROR:    in error cases
  */
-static int get_whole_cluster(BlockDriverState *bs,
-                             VmdkExtent *extent,
-                             uint64_t cluster_offset,
-                             uint64_t offset,
-                             uint64_t skip_start_bytes,
-                             uint64_t skip_end_bytes)
+static int vmdk_perform_cow(BlockDriverState *bs,
+                            VmdkExtent *extent,
+                            uint64_t cluster_offset,
+                            uint64_t offset,
+                            uint64_t skip_start_bytes,
+                            uint64_t skip_end_bytes)
 {
     int ret = VMDK_OK;
     int64_t cluster_bytes;
@@ -1244,7 +1249,7 @@ static int get_cluster_offset(BlockDriverState *bs,
          * This problem may occur because of insufficient space on host disk
          * or inappropriate VM shutdown.
          */
-        ret = get_whole_cluster(bs, extent, cluster_sector * BDRV_SECTOR_SIZE,
+        ret = vmdk_perform_cow(bs, extent, cluster_sector * BDRV_SECTOR_SIZE,
                                 offset, skip_start_bytes, skip_end_bytes);
         if (ret) {
             return ret;
-- 
2.6.2
