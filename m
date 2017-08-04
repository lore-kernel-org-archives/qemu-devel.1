Received: from eggs.gnu.org ([2001:4830:134:3::10]:56909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dddJH-0004AQ-Sx
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dddJ3-00055U-NI
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:10:39 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  4 Aug 2017 22:09:42 +0800
Message-Id: <20170804140942.19342-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] vmdk: Fix error handling/reporting of
 vmdk_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Errors from the callees must be captured and propagated to our caller,
ensure this for both find_extent() and bdrv_getlength().

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/vmdk.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 0fc97391a6..c665bcc977 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2236,6 +2236,7 @@ static int vmdk_check(BlockDriverState *bs, BdrvCheckResult *result,
             fprintf(stderr,
                     "ERROR: could not find extent for sector %" PRId64 "\n",
                     sector_num);
+            ret = -EINVAL;
             break;
         }
         ret = get_cluster_offset(bs, extent, NULL,
@@ -2247,19 +2248,28 @@ static int vmdk_check(BlockDriverState *bs, BdrvCheckResult *result,
                     PRId64 "\n", sector_num);
             break;
         }
-        if (ret == VMDK_OK &&
-            cluster_offset >= bdrv_getlength(extent->file->bs))
-        {
-            fprintf(stderr,
-                    "ERROR: cluster offset for sector %"
-                    PRId64 " points after EOF\n", sector_num);
-            break;
+        if (ret == VMDK_OK) {
+            int64_t extent_len = bdrv_getlength(extent->file->bs);
+            if (extent_len < 0) {
+                fprintf(stderr,
+                        "ERROR: could not get extent file length for sector %"
+                        PRId64 "\n", sector_num);
+                ret = extent_len;
+                break;
+            }
+            if (cluster_offset >= extent_len) {
+                fprintf(stderr,
+                        "ERROR: cluster offset for sector %"
+                        PRId64 " points after EOF\n", sector_num);
+                ret = -EINVAL;
+                break;
+            }
         }
         sector_num += extent->cluster_sectors;
     }
 
     result->corruptions++;
-    return 0;
+    return ret;
 }
 
 static ImageInfoSpecific *vmdk_get_specific_info(BlockDriverState *bs)
-- 
2.13.3
