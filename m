Received: from eggs.gnu.org ([2001:4830:134:3::10]:39437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g0N0u-0007Fg-6l
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g0N0t-00082D-C7
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:30:12 -0400
From: yuchenlin@synology.com
Date: Thu, 13 Sep 2018 16:29:52 +0800
Message-Id: <20180913082952.3675-1-yuchenlin@synology.com>
Subject: [Qemu-devel] [PATCH v3] vmdk: align end of file to a sector boundary
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

There are three reasons to do it. First, if vmdk doesn't align at
the sector boundary, there may be many undefined behaviors,
such as, in vbox it will show VMDK: Compressed image is corrupted
'syno-vm-disk1.vmdk' (VERR_ZIP_CORRUPTED) when we try to import an
ova with unaligned vmdk. Second, all the cluster_sector is aligned
to sector, the last one should be like this, too. Third, it ease
reading with sector based I/Os.

Signed-off-by: yuchenlin <yuchenlin@synology.com>
---
v2 -> v3:
* Update commit message

thanks

 block/vmdk.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index a9d0084e36..2c9e86d98f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1698,6 +1698,27 @@ static int coroutine_fn
 vmdk_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
                            uint64_t bytes, QEMUIOVector *qiov)
 {
+    if (bytes == 0) {
+        /* The caller will write bytes 0 to signal EOF.
+         * When receive it, we align EOF to a sector boundary. */
+        BDRVVmdkState *s = bs->opaque;
+        int i, ret;
+        int64_t length;
+
+        for (i = 0; i < s->num_extents; i++) {
+            length = bdrv_getlength(s->extents[i].file->bs);
+            if (length < 0) {
+                return length;
+            }
+            length = QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
+            ret = bdrv_truncate(s->extents[i].file, length,
+                                PREALLOC_MODE_OFF, NULL);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+        return 0;
+    }
     return vmdk_co_pwritev(bs, offset, bytes, qiov, 0);
 }
 
-- 
2.18.0
