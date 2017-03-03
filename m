Received: from eggs.gnu.org ([2001:4830:134:3::10]:37278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cjnd1-00007m-Ms
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cjnd0-0005qh-Uf
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:52:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cjnd0-0005qU-PV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:52:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  3 Mar 2017 21:51:48 +0800
Message-Id: <20170303135150.12145-3-stefanha@redhat.com>
In-Reply-To: <20170303135150.12145-1-stefanha@redhat.com>
References: <20170303135150.12145-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC 2/4] raw-format: add bdrv_max_size() support
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
 block/raw-format.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index 86fbc65..f8cb6b3 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -312,6 +312,21 @@ static int64_t raw_getlength(BlockDriverState *bs)
     return s->size;
 }
 
+static uint64_t raw_max_size(QemuOpts *opts, BlockDriverState *in_bs,
+                             Error **errp)
+{
+    if (in_bs) {
+        int64_t size = bdrv_nb_sectors(in_bs);
+        if (size < 0) {
+            error_setg_errno(errp, -size, "Unable to get image size");
+            return 0;
+        }
+        return (uint64_t)size * BDRV_SECTOR_SIZE;
+    }
+
+    return qemu_opt_get_size(opts, "size", 0);
+}
+
 static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     return bdrv_get_info(bs->file->bs, bdi);
@@ -477,6 +492,7 @@ BlockDriver bdrv_raw = {
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
+    .bdrv_max_size        = &raw_max_size,
     .bdrv_get_info        = &raw_get_info,
     .bdrv_refresh_limits  = &raw_refresh_limits,
     .bdrv_probe_blocksizes = &raw_probe_blocksizes,
-- 
2.9.3
