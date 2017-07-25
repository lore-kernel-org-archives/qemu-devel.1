Received: from eggs.gnu.org ([2001:4830:134:3::10]:36583)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1da12D-00020h-Pr
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1da129-0000zg-8M
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:42:05 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:58796 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1da128-0000yn-VQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:42:01 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 25 Jul 2017 16:41:37 +0200
Message-Id: <1500993699-19299-9-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-1-git-send-email-pl@kamp.de>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V5 08/10] block/qcow2: start using the compress
 format extension
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

we now pass the parameters to the zlib compressor if the
extension is present and use the old default values if
the extension is absent.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/qcow2-cluster.c | 58 ++++++++++++++++++++++++++++++---------------------
 block/qcow2.c         | 53 +++++++++++++++++++++++-----------------------
 2 files changed, 61 insertions(+), 50 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f06c08f..345feec 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1479,30 +1479,39 @@ again:
 }
 
 static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
-                             const uint8_t *buf, int buf_size)
+                             const uint8_t *buf, int buf_size,
+                             Qcow2Compress *compress)
 {
-    z_stream strm1, *strm = &strm1;
-    int ret, out_len;
-
-    memset(strm, 0, sizeof(*strm));
-
-    strm->next_in = (uint8_t *)buf;
-    strm->avail_in = buf_size;
-    strm->next_out = out_buf;
-    strm->avail_out = out_buf_size;
-
-    ret = inflateInit2(strm, -12);
-    if (ret != Z_OK)
-        return -1;
-    ret = inflate(strm, Z_FINISH);
-    out_len = strm->next_out - out_buf;
-    if ((ret != Z_STREAM_END && ret != Z_BUF_ERROR) ||
-        out_len != out_buf_size) {
-        inflateEnd(strm);
-        return -1;
-    }
-    inflateEnd(strm);
-    return 0;
+    int ret = 0, out_len;
+
+    switch (compress->format) {
+    case QCOW2_COMPRESS_FORMAT_DEFLATE:
+    {
+        z_stream z_strm = {};
+
+        z_strm.next_in = (uint8_t *)buf;
+        z_strm.avail_in = buf_size;
+        z_strm.next_out = out_buf;
+        z_strm.avail_out = out_buf_size;
+
+        ret = inflateInit2(&z_strm, -compress->u.deflate.window_size);
+        if (ret != Z_OK) {
+            return -1;
+        }
+        ret = inflate(&z_strm, Z_FINISH);
+        out_len = z_strm.next_out - out_buf;
+        ret = -(ret != Z_STREAM_END);
+        inflateEnd(&z_strm);
+        break;
+    }
+    default:
+        abort(); /* should never reach this point */
+    }
+
+    if (out_len != out_buf_size) {
+        ret = -1;
+    }
+    return ret;
 }
 
 int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
@@ -1523,7 +1532,8 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
             return ret;
         }
         if (decompress_buffer(s->cluster_cache, s->cluster_size,
-                              s->cluster_data + sector_offset, csize) < 0) {
+                              s->cluster_data + sector_offset, csize,
+                              &s->compress) < 0) {
             return -EIO;
         }
         s->cluster_cache_offset = coffset;
diff --git a/block/qcow2.c b/block/qcow2.c
index a12b3d7..6031963 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3426,9 +3426,9 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     BDRVQcow2State *s = bs->opaque;
     QEMUIOVector hd_qiov;
     struct iovec iov;
-    z_stream strm;
-    int ret, out_len;
-    uint8_t *buf, *out_buf, *local_buf = NULL;
+    z_stream z_strm = {};
+    int ret, out_len = 0;
+    uint8_t *buf, *out_buf = NULL, *local_buf = NULL;
     uint64_t cluster_offset;
 
     if (bytes == 0) {
@@ -3453,34 +3453,35 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         buf = qiov->iov[0].iov_base;
     }
 
-    out_buf = g_malloc(s->cluster_size);
+    switch (s->compress.format) {
+    case QCOW2_COMPRESS_FORMAT_DEFLATE:
+        out_buf = g_malloc(s->cluster_size);
+        ret = deflateInit2(
+            &z_strm, s->compress.u.deflate.level ?
+                     Z_DEFAULT_COMPRESSION : s->compress.u.deflate.level,
+                     Z_DEFLATED, -s->compress.u.deflate.window_size,
+                     9, Z_DEFAULT_STRATEGY);
+        if (ret != Z_OK) {
+            ret = -EINVAL;
+            goto fail;
+        }
 
-    /* best compression, small window, no zlib header */
-    memset(&strm, 0, sizeof(strm));
-    ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION,
-                       Z_DEFLATED, -12,
-                       9, Z_DEFAULT_STRATEGY);
-    if (ret != 0) {
-        ret = -EINVAL;
-        goto fail;
-    }
+        z_strm.avail_in = s->cluster_size;
+        z_strm.next_in = (uint8_t *)buf;
+        z_strm.avail_out = s->cluster_size;
+        z_strm.next_out = out_buf;
 
-    strm.avail_in = s->cluster_size;
-    strm.next_in = (uint8_t *)buf;
-    strm.avail_out = s->cluster_size;
-    strm.next_out = out_buf;
+        ret = deflate(&z_strm, Z_FINISH);
+        out_len = z_strm.next_out - out_buf;
+        deflateEnd(&z_strm);
 
-    ret = deflate(&strm, Z_FINISH);
-    if (ret != Z_STREAM_END && ret != Z_OK) {
-        deflateEnd(&strm);
-        ret = -EINVAL;
-        goto fail;
+        ret = ret != Z_STREAM_END;
+        break;
+    default:
+        abort(); /* should never reach this point */
     }
-    out_len = strm.next_out - out_buf;
-
-    deflateEnd(&strm);
 
-    if (ret != Z_STREAM_END || out_len >= s->cluster_size) {
+    if (ret || out_len >= s->cluster_size) {
         /* could not compress: write normal cluster */
         ret = qcow2_co_pwritev(bs, offset, bytes, qiov, 0);
         if (ret < 0) {
-- 
1.9.1
