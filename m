Received: from eggs.gnu.org ([2001:4830:134:3::10]:44287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLALK-00046f-2O
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLALJ-0008Lg-94
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:36:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dLALJ-0008L9-2e
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:36:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 14 Jun 2017 16:35:50 +0100
Message-Id: <20170614153557.3319-3-stefanha@redhat.com>
In-Reply-To: <20170614153557.3319-1-stefanha@redhat.com>
References: <20170614153557.3319-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v8 2/9] raw-format: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Maximum size calculation is trivial for the raw format: it's just the
requested image size (because there is no metadata).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/raw-format.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index 36e6503..ac7453e 100644
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
