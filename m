Received: from eggs.gnu.org ([2001:4830:134:3::10]:51823)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dQX8k-00079z-Sn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dQX8g-000895-VE
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:38 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34692 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dQX8g-00087O-N9
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:34 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 29 Jun 2017 12:57:09 +0200
Message-Id: <1498733831-15254-7-git-send-email-pl@kamp.de>
In-Reply-To: <1498733831-15254-1-git-send-email-pl@kamp.de>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V2 6/8] block/qcow2: optimize
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
index 39a8afc..0a7202a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2750,7 +2750,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     struct iovec iov;
     z_stream strm;
     int ret, out_len;
-    uint8_t *buf, *out_buf;
+    uint8_t *buf, *out_buf, *local_buf = NULL;
     uint64_t cluster_offset;
 
     if (bytes == 0) {
@@ -2760,8 +2760,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         return bdrv_truncate(bs->file, cluster_offset, NULL);
     }
 
-    buf = qemu_blockalign(bs, s->cluster_size);
-    if (bytes != s->cluster_size) {
+    if (bytes != s->cluster_size || qiov->niov != 1) {
+        buf = local_buf = qemu_blockalign(bs, s->cluster_size);
         if (bytes > s->cluster_size ||
             offset + bytes != bs->total_sectors << BDRV_SECTOR_BITS)
         {
@@ -2770,8 +2770,10 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         }
         /* Zero-pad last write if image size is not cluster aligned */
         memset(buf + bytes, 0, s->cluster_size - bytes);
+        qemu_iovec_to_buf(qiov, 0, buf, bytes);
+    } else {
+        buf = qiov->iov[0].iov_base;
     }
-    qemu_iovec_to_buf(qiov, 0, buf, bytes);
 
     out_buf = g_malloc(s->cluster_size);
 
@@ -2839,7 +2841,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
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
