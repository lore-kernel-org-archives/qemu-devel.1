Received: from eggs.gnu.org ([2001:4830:134:3::10]:42471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52N-0000HP-FK
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52I-00029G-Qc
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:29 +0200
Message-Id: <20170808135838.11525-10-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/18] vmdk: Fix error handling/reporting of
 vmdk_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Fam Zheng <famz@redhat.com>

Errors from the callees must be captured and propagated to our caller,
ensure this for both find_extent() and bdrv_getlength().

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.13.4
