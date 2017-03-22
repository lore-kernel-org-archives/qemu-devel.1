Received: from eggs.gnu.org ([2001:4830:134:3::10]:51420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cqfMq-0000jS-UY
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cqfMn-0003wK-S0
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:27:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cqfMn-0003w8-MW
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:27:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 22 Mar 2017 11:16:02 +0000
Message-Id: <20170322111608.31230-3-stefanha@redhat.com>
In-Reply-To: <20170322111608.31230-1-stefanha@redhat.com>
References: <20170322111608.31230-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/8] raw-format: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Maximum size calculation is trivial for the raw format: it's just the
requested image size (because there is no metadata).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/raw-format.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index 86fbc65..e66ba00 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -312,6 +312,27 @@ static int64_t raw_getlength(BlockDriverState *bs)
     return s->size;
 }
 
+static void raw_measure(QemuOpts *opts, BlockDriverState *in_bs,
+                        BlockMeasureInfo *info,
+                        Error **errp)
+{
+    if (in_bs) {
+        int64_t ssize = bdrv_getlength(in_bs);
+        if (ssize < 0) {
+            error_setg_errno(errp, -ssize, "Unable to get image size");
+            return;
+        }
+        info->required = ssize;
+    } else {
+        info->required =
+            ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                     BDRV_SECTOR_SIZE);
+    }
+
+    /* Unallocated sectors count towards the file size in raw images */
+    info->fully_allocated = info->required;
+}
+
 static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     return bdrv_get_info(bs->file->bs, bdi);
@@ -477,6 +498,7 @@ BlockDriver bdrv_raw = {
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
+    .bdrv_measure         = &raw_measure,
     .bdrv_get_info        = &raw_get_info,
     .bdrv_refresh_limits  = &raw_refresh_limits,
     .bdrv_probe_blocksizes = &raw_probe_blocksizes,
-- 
2.9.3
