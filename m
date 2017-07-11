Received: from eggs.gnu.org ([2001:4830:134:3::10]:46680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxlp-0001cz-GX
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxll-0006zU-D1
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:17 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:51 +0200
Message-Id: <20170711160814.20941-63-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 62/85] raw-format: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

Maximum size calculation is trivial for the raw format: it's just the
requested image size (because there is no metadata).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20170705125738.8777-3-stefanha@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/raw-format.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index 1ea8c2d..a1622c6 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -312,6 +312,31 @@ static int64_t raw_getlength(BlockDriverState *bs)
     return s->size;
 }
 
+static BlockMeasureInfo *raw_measure(QemuOpts *opts, BlockDriverState *in_bs,
+                                     Error **errp)
+{
+    BlockMeasureInfo *info;
+    int64_t required;
+
+    if (in_bs) {
+        required = bdrv_getlength(in_bs);
+        if (required < 0) {
+            error_setg_errno(errp, -required, "Unable to get image size");
+            return NULL;
+        }
+    } else {
+        required = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                            BDRV_SECTOR_SIZE);
+    }
+
+    info = g_new(BlockMeasureInfo, 1);
+    info->required = required;
+
+    /* Unallocated sectors count towards the file size in raw images */
+    info->fully_allocated = info->required;
+    return info;
+}
+
 static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     return bdrv_get_info(bs->file->bs, bdi);
@@ -479,6 +504,7 @@ BlockDriver bdrv_raw = {
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
+    .bdrv_measure         = &raw_measure,
     .bdrv_get_info        = &raw_get_info,
     .bdrv_refresh_limits  = &raw_refresh_limits,
     .bdrv_probe_blocksizes = &raw_probe_blocksizes,
-- 
2.9.4
