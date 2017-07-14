Received: from eggs.gnu.org ([2001:4830:134:3::10]:38268)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dVxLV-0003fW-3I
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dVxLT-00081g-Qg
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:13 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:51352 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dVxLT-00080c-HN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:11 -0400
From: Peter Lieven <pl@kamp.de>
Date: Fri, 14 Jul 2017 11:56:44 +0200
Message-Id: <1500026205-15542-9-git-send-email-pl@kamp.de>
In-Reply-To: <1500026205-15542-1-git-send-email-pl@kamp.de>
References: <1500026205-15542-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V3 8/9] block/qcow2: start using the compress
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
index f06c08f..6c14d59 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1479,30 +1479,39 @@ again:
 }
 
 static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
-                             const uint8_t *buf, int buf_size)
+                             const uint8_t *buf, int buf_size,
+                             int compress_format)
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
+    switch (compress_format) {
+    case QCOW2_COMPRESS_FORMAT_ZLIB:
+    case -1: {
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
@@ -1523,7 +1532,8 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
             return ret;
         }
         if (decompress_buffer(s->cluster_cache, s->cluster_size,
-                              s->cluster_data + sector_offset, csize) < 0) {
+                              s->cluster_data + sector_offset, csize,
+                              s->compress_format) < 0) {
             return -EIO;
         }
         s->cluster_cache_offset = coffset;
diff --git a/block/qcow2.c b/block/qcow2.c
index ecb4bd6..68b8d3a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3391,9 +3391,10 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
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
@@ -3418,34 +3419,38 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         buf = qiov->iov[0].iov_base;
     }
 
-    out_buf = g_malloc(s->cluster_size);
+    switch (s->compress_format) {
+    case -1:
+        z_windowBits = -12;
+    case QCOW2_COMPRESS_FORMAT_ZLIB:
+        out_buf = g_malloc(s->cluster_size);
+        if (s->compress_level > 0) {
+            z_level = s->compress_level;
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
