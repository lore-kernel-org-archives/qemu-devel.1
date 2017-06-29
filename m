Received: from eggs.gnu.org ([2001:4830:134:3::10]:51701)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dQX8f-00072N-3C
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dQX8d-00083u-N9
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:33 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:39176 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dQX8d-00081A-EO
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:31 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 29 Jun 2017 12:57:10 +0200
Message-Id: <1498733831-15254-8-git-send-email-pl@kamp.de>
In-Reply-To: <1498733831-15254-1-git-send-email-pl@kamp.de>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V2 7/8] block/qcow2: start using the compress
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
 block/qcow2.c         | 57 +++++++++++++++++++++++++++-----------------------
 2 files changed, 65 insertions(+), 50 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3d341fd..353ac87 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1521,30 +1521,39 @@ again:
 }
 
 static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
-                             const uint8_t *buf, int buf_size)
+                             const uint8_t *buf, int buf_size,
+                             uint32_t compress_format_id)
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
+    switch (compress_format_id) {
+    case QCOW2_COMPRESS_ZLIB:
+    case QCOW2_COMPRESS_ZLIB_COMPAT: {
+        z_stream z_strm = {};
+
+        z_strm.next_in = (uint8_t *)buf;
+        z_strm.avail_in = buf_size;
+        z_strm.next_out = out_buf;
+        z_strm.avail_out = out_buf_size;
+
+        ret = inflateInit2(&z_strm, -15);
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
@@ -1565,7 +1574,8 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
             return ret;
         }
         if (decompress_buffer(s->cluster_cache, s->cluster_size,
-                              s->cluster_data + sector_offset, csize) < 0) {
+                              s->cluster_data + sector_offset, csize,
+                              s->compress_format_id) < 0) {
             return -EIO;
         }
         s->cluster_cache_offset = coffset;
diff --git a/block/qcow2.c b/block/qcow2.c
index 0a7202a..b41e58d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2748,9 +2748,10 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     BDRVQcow2State *s = bs->opaque;
     QEMUIOVector hd_qiov;
     struct iovec iov;
-    z_stream strm;
-    int ret, out_len;
-    uint8_t *buf, *out_buf, *local_buf = NULL;
+    z_stream z_strm = {};
+    int z_windowBits = -15, z_level = Z_DEFAULT_COMPRESSION;
+    int ret, out_len = 0;
+    uint8_t *buf, *out_buf = NULL, *local_buf = NULL;
     uint64_t cluster_offset;
 
     if (bytes == 0) {
@@ -2775,34 +2776,38 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         buf = qiov->iov[0].iov_base;
     }
 
-    out_buf = g_malloc(s->cluster_size);
+    switch (s->compress_format_id) {
+    case QCOW2_COMPRESS_ZLIB_COMPAT:
+        z_windowBits = -12;
+    case QCOW2_COMPRESS_ZLIB:
+        out_buf = g_malloc(s->cluster_size);
+        if (s->compress_format.level > 0) {
+            z_level = s->compress_format.level;
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
+        ret = deflateInit2(&z_strm, z_level, Z_DEFLATED, z_windowBits, 9,
+                           Z_DEFAULT_STRATEGY);
+        if (ret != Z_OK) {
+            ret = -EINVAL;
+            goto fail;
+        }
 
-    strm.avail_in = s->cluster_size;
-    strm.next_in = (uint8_t *)buf;
-    strm.avail_out = s->cluster_size;
-    strm.next_out = out_buf;
+        z_strm.avail_in = s->cluster_size;
+        z_strm.next_in = (uint8_t *)buf;
+        z_strm.avail_out = s->cluster_size;
+        z_strm.next_out = out_buf;
 
-    ret = deflate(&strm, Z_FINISH);
-    if (ret != Z_STREAM_END && ret != Z_OK) {
-        deflateEnd(&strm);
-        ret = -EINVAL;
-        goto fail;
-    }
-    out_len = strm.next_out - out_buf;
+        ret = deflate(&z_strm, Z_FINISH);
+        out_len = z_strm.next_out - out_buf;
+        deflateEnd(&z_strm);
 
-    deflateEnd(&strm);
+        ret = ret != Z_STREAM_END;
+        break;
+    default:
+        abort(); /* should never reach this point */
+    }
 
-    if (ret != Z_STREAM_END || out_len >= s->cluster_size) {
+    if (ret || out_len >= s->cluster_size) {
         /* could not compress: write normal cluster */
         ret = qcow2_co_pwritev(bs, offset, bytes, qiov, 0);
         if (ret < 0) {
-- 
1.9.1
