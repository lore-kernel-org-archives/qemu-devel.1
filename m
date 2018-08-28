Received: from eggs.gnu.org ([2001:4830:134:3::10]:36389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fuUWS-0002Lg-Gv
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fuUWR-0005lz-B2
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:18:28 -0400
From: yuchenlin@synology.com
Date: Tue, 28 Aug 2018 11:17:51 +0800
Message-Id: <20180828031751.29507-1-yuchenlin@synology.com>
Subject: [Qemu-devel] [PATCH] vmdk: align end of file to a sector boundary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, yuchenlin <yuchenlin@synology.com>

From: yuchenlin <yuchenlin@synology.com>

There is a rare case which the size of last compressed cluster
is larger than the cluster size, which will cause the file is
not aligned at the sector boundary.

Signed-off-by: yuchenlin <yuchenlin@synology.com>
---
 block/vmdk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index a9d0084e36..a8ae7c65d2 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1698,6 +1698,24 @@ static int coroutine_fn
 vmdk_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
                            uint64_t bytes, QEMUIOVector *qiov)
 {
+    if (bytes == 0) {
+        /* align end of file to a sector boundary. */
+        BDRVVmdkState *s = bs->opaque;
+        int i, ret;
+        int64_t length;
+
+        for (i = 0; i < s->num_extents; i++) {
+            length = bdrv_getlength(s->extents[i].file->bs);
+            if (length < 0) {
+                return length;
+            }
+            ret = bdrv_truncate(s->extents[i].file, length, PREALLOC_MODE_OFF, NULL);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+        return 0;
+    }
     return vmdk_co_pwritev(bs, offset, bytes, qiov, 0);
 }
 
-- 
2.17.0
