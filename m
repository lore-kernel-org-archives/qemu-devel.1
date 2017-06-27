Received: from eggs.gnu.org ([2001:4830:134:3::10]:42475)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPphQ-00057o-Pl
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPphP-0005Hw-3L
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:32 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:41082 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPphO-0005HC-Q9
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:31 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 27 Jun 2017 14:34:09 +0200
Message-Id: <1498566850-7934-4-git-send-email-pl@kamp.de>
In-Reply-To: <1498566850-7934-1-git-send-email-pl@kamp.de>
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 3/4] block/qcow2: add lzo compression algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, Peter Lieven <pl@kamp.de>

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/qcow2-cluster.c | 65 +++++++++++++++++++++++++++++++---------------
 block/qcow2.c         | 72 ++++++++++++++++++++++++++++++++++-----------------
 block/qcow2.h         |  1 +
 configure             |  2 +-
 qemu-img.texi         |  1 +
 5 files changed, 95 insertions(+), 46 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3d341fd..ecb059b 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -24,6 +24,9 @@
 
 #include "qemu/osdep.h"
 #include <zlib.h>
+#ifdef CONFIG_LZO
+#include <lzo/lzo1x.h>
+#endif
 
 #include "qapi/error.h"
 #include "qemu-common.h"
@@ -1521,30 +1524,49 @@ again:
 }
 
 static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
-                             const uint8_t *buf, int buf_size)
+                             const uint8_t *buf, int buf_size,
+                             uint32_t compression_algorithm_id)
 {
     z_stream strm1, *strm = &strm1;
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
+    int ret = 0, out_len;
+
+    switch (compression_algorithm_id) {
+    case QCOW2_COMPRESSION_ZLIB:
+        memset(strm, 0, sizeof(*strm));
+
+        strm->next_in = (uint8_t *)buf;
+        strm->avail_in = buf_size;
+        strm->next_out = out_buf;
+        strm->avail_out = out_buf_size;
+
+        ret = inflateInit2(strm, -12);
+        if (ret != Z_OK) {
+            return -1;
+        }
+        ret = inflate(strm, Z_FINISH);
+        out_len = strm->next_out - out_buf;
+        ret = -(ret != Z_STREAM_END);
         inflateEnd(strm);
-        return -1;
+        break;
+#ifdef CONFIG_LZO
+    case QCOW2_COMPRESSION_LZO:
+        out_len = out_buf_size;
+        ret = lzo1x_decompress_safe(buf, buf_size, out_buf,
+                                    (lzo_uint *) &out_len, NULL);
+        if (ret == LZO_E_INPUT_NOT_CONSUMED) {
+            /* We always read up to the next sector boundary. Thus
+             * buf_size may be larger than the original compressed size. */
+            ret = 0;
+        }
+        break;
+#endif
+    default:
+        abort(); /* should never reach this point */
     }
-    inflateEnd(strm);
-    return 0;
+    if (out_len != out_buf_size) {
+        ret = -1;
+    }
+    return ret;
 }
 
 int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
@@ -1565,7 +1587,8 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
             return ret;
         }
         if (decompress_buffer(s->cluster_cache, s->cluster_size,
-                              s->cluster_data + sector_offset, csize) < 0) {
+                              s->cluster_data + sector_offset, csize,
+                              s->compression_algorithm_id) < 0) {
             return -EIO;
         }
         s->cluster_cache_offset = coffset;
diff --git a/block/qcow2.c b/block/qcow2.c
index c91eb1f..bd65582 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -26,6 +26,9 @@
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include <zlib.h>
+#ifdef CONFIG_LZO
+#include <lzo/lzo1x.h>
+#endif
 #include "block/qcow2.h"
 #include "qemu/error-report.h"
 #include "qapi/qmp/qerror.h"
@@ -84,6 +87,10 @@ static uint32_t is_compression_algorithm_supported(char *algorithm)
         /* no algorithm means the old default of zlib compression
          * with 12 window bits */
         return QCOW2_COMPRESSION_ZLIB;
+#ifdef CONFIG_LZO
+    } else if (!strcmp(algorithm, "lzo")) {
+        return QCOW2_COMPRESSION_LZO;
+#endif
     }
     return 0;
 }
@@ -2715,8 +2722,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     QEMUIOVector hd_qiov;
     struct iovec iov;
     z_stream strm;
-    int ret, out_len;
-    uint8_t *buf, *out_buf, *local_buf = NULL;
+    int ret, out_len = 0;
+    uint8_t *buf, *out_buf = NULL, *local_buf = NULL, *work_buf = NULL;
     uint64_t cluster_offset;
 
     if (bytes == 0) {
@@ -2741,34 +2748,50 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         buf = qiov->iov[0].iov_base;
     }
 
-    out_buf = g_malloc(s->cluster_size);
+    switch (s->compression_algorithm_id) {
+    case QCOW2_COMPRESSION_ZLIB:
+        out_buf = g_malloc(s->cluster_size);
 
-    /* best compression, small window, no zlib header */
-    memset(&strm, 0, sizeof(strm));
-    ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION,
-                       Z_DEFLATED, -12,
-                       9, Z_DEFAULT_STRATEGY);
-    if (ret != 0) {
-        ret = -EINVAL;
-        goto fail;
-    }
+        /* best compression, small window, no zlib header */
+        memset(&strm, 0, sizeof(strm));
+        ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION,
+                           Z_DEFLATED, -12,
+                           9, Z_DEFAULT_STRATEGY);
+        if (ret != 0) {
+            ret = -EINVAL;
+            goto fail;
+        }
 
-    strm.avail_in = s->cluster_size;
-    strm.next_in = (uint8_t *)buf;
-    strm.avail_out = s->cluster_size;
-    strm.next_out = out_buf;
+        strm.avail_in = s->cluster_size;
+        strm.next_in = (uint8_t *)buf;
+        strm.avail_out = s->cluster_size;
+        strm.next_out = out_buf;
+
+        ret = deflate(&strm, Z_FINISH);
+        if (ret != Z_STREAM_END && ret != Z_OK) {
+            deflateEnd(&strm);
+            ret = -EINVAL;
+            goto fail;
+        }
+        out_len = strm.next_out - out_buf;
 
-    ret = deflate(&strm, Z_FINISH);
-    if (ret != Z_STREAM_END && ret != Z_OK) {
         deflateEnd(&strm);
-        ret = -EINVAL;
-        goto fail;
-    }
-    out_len = strm.next_out - out_buf;
 
-    deflateEnd(&strm);
+        ret = ret != Z_STREAM_END;
+        break;
+#ifdef CONFIG_LZO
+    case QCOW2_COMPRESSION_LZO:
+        out_buf = g_malloc(s->cluster_size + s->cluster_size / 64 + 16 + 3);
+        work_buf = g_malloc(LZO1X_1_MEM_COMPRESS);
+        ret = lzo1x_1_compress(buf, s->cluster_size, out_buf,
+                               (lzo_uint *) &out_len, work_buf);
+        break;
+#endif
+    default:
+        abort(); /* should never reach this point */
+    }
 
-    if (ret != Z_STREAM_END || out_len >= s->cluster_size) {
+    if (ret || out_len >= s->cluster_size) {
         /* could not compress: write normal cluster */
         ret = qcow2_co_pwritev(bs, offset, bytes, qiov, 0);
         if (ret < 0) {
@@ -2809,6 +2832,7 @@ success:
 fail:
     qemu_vfree(local_buf);
     g_free(out_buf);
+    g_free(work_buf);
     return ret;
 }
 
diff --git a/block/qcow2.h b/block/qcow2.h
index 1c9ba06..716012c 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -172,6 +172,7 @@ typedef struct Qcow2UnknownHeaderExtension {
 
 enum {
     QCOW2_COMPRESSION_ZLIB          = 0xC0318301,
+    QCOW2_COMPRESSION_LZO           = 0xC0318302,
 };
 
 enum {
diff --git a/configure b/configure
index c571ad1..81d3286 100755
--- a/configure
+++ b/configure
@@ -1890,7 +1890,7 @@ if test "$lzo" != "no" ; then
 int main(void) { lzo_version(); return 0; }
 EOF
     if compile_prog "" "-llzo2" ; then
-        libs_softmmu="$libs_softmmu -llzo2"
+        LIBS="$LIBS -llzo2"
         lzo="yes"
     else
         if test "$lzo" = "yes"; then
diff --git a/qemu-img.texi b/qemu-img.texi
index c0d1bec..043c1ba 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -627,6 +627,7 @@ The following options are available if support for the respective libraries
 has been enabled at compile time:
 
    zlib            Uses standard zlib compression (default)
+   lzo             Uses LZO1X compression
 
 The compression algorithm can only be defined at image create time and cannot
 be changed later.
-- 
1.9.1
