Received: from eggs.gnu.org ([2001:4830:134:3::10]:41138)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dYCK3-0008Db-KF
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dYCK2-0007wc-Kx
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:59 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:60098 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dYCK2-0007vi-BR
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:58 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 20 Jul 2017 16:20:38 +0200
Message-Id: <1500560441-5670-8-git-send-email-pl@kamp.de>
In-Reply-To: <1500560441-5670-1-git-send-email-pl@kamp.de>
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V4 07/10] block/qcow2: optimize
 qcow2_co_pwritev_compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com, Peter Lieven <pl@kamp.de>

if we specify exactly one iov of s->cluster_size bytes we can avoid
the bounce buffer.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/qcow2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 67e48e1..978e8d2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3393,7 +3393,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     struct iovec iov;
     z_stream strm;
     int ret, out_len;
-    uint8_t *buf, *out_buf;
+    uint8_t *buf, *out_buf, *local_buf = NULL;
     uint64_t cluster_offset;
 
     if (bytes == 0) {
@@ -3403,8 +3403,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF, NULL);
     }
 
-    buf = qemu_blockalign(bs, s->cluster_size);
-    if (bytes != s->cluster_size) {
+    if (bytes != s->cluster_size || qiov->niov != 1) {
+        buf = local_buf = qemu_blockalign(bs, s->cluster_size);
         if (bytes > s->cluster_size ||
             offset + bytes != bs->total_sectors << BDRV_SECTOR_BITS)
         {
@@ -3413,8 +3413,10 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         }
         /* Zero-pad last write if image size is not cluster aligned */
         memset(buf + bytes, 0, s->cluster_size - bytes);
+        qemu_iovec_to_buf(qiov, 0, buf, bytes);
+    } else {
+        buf = qiov->iov[0].iov_base;
     }
-    qemu_iovec_to_buf(qiov, 0, buf, bytes);
 
     out_buf = g_malloc(s->cluster_size);
 
@@ -3482,7 +3484,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 success:
     ret = 0;
 fail:
-    qemu_vfree(buf);
+    qemu_vfree(local_buf);
     g_free(out_buf);
     return ret;
 }
-- 
1.9.1
