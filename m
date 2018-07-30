Received: from eggs.gnu.org ([2001:4830:134:3::10]:47527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fjyDr-0004J8-Fb
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 22:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fjyDq-0001f0-IV
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 22:47:47 -0400
From: yuchenlin@synology.com
Date: Mon, 30 Jul 2018 10:47:01 +0800
Message-Id: <20180730024701.7613-3-yuchenlin@synology.com>
In-Reply-To: <20180730024701.7613-1-yuchenlin@synology.com>
References: <20180730024701.7613-1-yuchenlin@synology.com>
Subject: [Qemu-devel] [PATCH 2/2] vdi: refine code for vdi_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, qemu-block@nongnu.org, yuchenlin <yuchenlin@synology.com>

From: yuchenlin <yuchenlin@synology.com>

When the condition of each if or else if is true,
the code flow will goto fail. Which means we can decouple
if else if chain to get some readability.

Signed-off-by: yuchenlin <yuchenlin@synology.com>
---
 block/vdi.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 12f92e7891..28fc6210a7 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -405,35 +405,41 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
                    ")", header.signature);
         ret = -EINVAL;
         goto fail;
-    } else if (header.version != VDI_VERSION_1_1) {
+    }
+    if (header.version != VDI_VERSION_1_1) {
         error_setg(errp, "unsupported VDI image (version %" PRIu32 ".%" PRIu32
                    ")", header.version >> 16, header.version & 0xffff);
         ret = -ENOTSUP;
         goto fail;
-    } else if (header.offset_bmap % SECTOR_SIZE != 0) {
+    }
+    if (header.offset_bmap % SECTOR_SIZE != 0) {
         /* We only support block maps which start on a sector boundary. */
         error_setg(errp, "unsupported VDI image (unaligned block map offset "
                    "0x%" PRIx32 ")", header.offset_bmap);
         ret = -ENOTSUP;
         goto fail;
-    } else if (header.offset_data % SECTOR_SIZE != 0) {
+    }
+    if (header.offset_data % SECTOR_SIZE != 0) {
         /* We only support data blocks which start on a sector boundary. */
         error_setg(errp, "unsupported VDI image (unaligned data offset 0x%"
                    PRIx32 ")", header.offset_data);
         ret = -ENOTSUP;
         goto fail;
-    } else if (header.sector_size != SECTOR_SIZE) {
+    }
+    if (header.sector_size != SECTOR_SIZE) {
         error_setg(errp, "unsupported VDI image (sector size %" PRIu32
                    " is not %u)", header.sector_size, SECTOR_SIZE);
         ret = -ENOTSUP;
         goto fail;
-    } else if (header.block_size != DEFAULT_CLUSTER_SIZE) {
+    }
+    if (header.block_size != DEFAULT_CLUSTER_SIZE) {
         error_setg(errp, "unsupported VDI image (block size %" PRIu32
                          " is not %" PRIu64 ")",
                    header.block_size, DEFAULT_CLUSTER_SIZE);
         ret = -ENOTSUP;
         goto fail;
-    } else if (header.disk_size >
+    }
+    if (header.disk_size >
                (uint64_t)header.blocks_in_image * header.block_size) {
         error_setg(errp, "unsupported VDI image (disk size %" PRIu64 ", "
                    "image bitmap has room for %" PRIu64 ")",
@@ -441,15 +447,18 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
                    (uint64_t)header.blocks_in_image * header.block_size);
         ret = -ENOTSUP;
         goto fail;
-    } else if (!qemu_uuid_is_null(&header.uuid_link)) {
+    }
+    if (!qemu_uuid_is_null(&header.uuid_link)) {
         error_setg(errp, "unsupported VDI image (non-NULL link UUID)");
         ret = -ENOTSUP;
         goto fail;
-    } else if (!qemu_uuid_is_null(&header.uuid_parent)) {
+    }
+    if (!qemu_uuid_is_null(&header.uuid_parent)) {
         error_setg(errp, "unsupported VDI image (non-NULL parent UUID)");
         ret = -ENOTSUP;
         goto fail;
-    } else if (header.blocks_in_image > VDI_BLOCKS_IN_IMAGE_MAX) {
+    }
+    if (header.blocks_in_image > VDI_BLOCKS_IN_IMAGE_MAX) {
         error_setg(errp, "unsupported VDI image "
                          "(too many blocks %u, max is %u)",
                           header.blocks_in_image, VDI_BLOCKS_IN_IMAGE_MAX);
-- 
2.17.0
