Received: from eggs.gnu.org ([2001:4830:134:3::10]:38368)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dVxLZ-0003js-7y
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dVxLY-000855-3c
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:17 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34986 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dVxLX-000846-Pu
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:16 -0400
From: Peter Lieven <pl@kamp.de>
Date: Fri, 14 Jul 2017 11:56:45 +0200
Message-Id: <1500026205-15542-10-git-send-email-pl@kamp.de>
In-Reply-To: <1500026205-15542-1-git-send-email-pl@kamp.de>
References: <1500026205-15542-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V3 9/9] block/qcow2: add lzo compress format
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

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/qcow2-cluster.c | 15 +++++++++++++++
 block/qcow2.c         | 42 +++++++++++++++++++++++++++++++++++-------
 configure             |  2 +-
 qapi/block-core.json  | 14 ++++++++++++--
 qemu-img.texi         |  1 +
 5 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 6c14d59..7d47dde 100644
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
@@ -1504,6 +1507,18 @@ static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
         inflateEnd(&z_strm);
         break;
     }
+#ifdef CONFIG_LZO
+    case QCOW2_COMPRESS_FORMAT_LZO:
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
     default:
         abort(); /* should never reach this point */
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 68b8d3a..2571f05 100644
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
@@ -165,10 +168,18 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
 }
 
 
-static void qcow2_compress_level_supported(int format, uint8_t level,
+static void qcow2_compress_settings_supported(int format, uint8_t level,
                                            Error **errp)
 {
-    if (format == QCOW2_COMPRESS_FORMAT_ZLIB && level > 9) {
+#ifndef CONFIG_LZO
+    if (format == QCOW2_COMPRESS_FORMAT_LZO) {
+        error_setg(errp, "ERROR: compress format '%s' is not supported",
+                         Qcow2CompressFormat_lookup[format]);
+        return;
+    }
+#endif
+    if ((format == QCOW2_COMPRESS_FORMAT_ZLIB && level > 9) ||
+        (format == QCOW2_COMPRESS_FORMAT_LZO && level > 0)) {
         error_setg(errp, "ERROR: compress level %" PRIu8 " is not"
                          " supported for format '%s'", level,
                          Qcow2CompressFormat_lookup[format]);
@@ -280,14 +291,22 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 return 4;
             }
 
-            qcow2_compress_level_supported(s->compress_format,
-                                           compress_ext.level, &local_err);
+            qcow2_compress_settings_supported(s->compress_format,
+                                              compress_ext.level, &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
                 return 5;
             }
             s->compress_level = compress_ext.level;
 
+#ifdef CONFIG_LZO
+            if (s->compress_format == QCOW2_COMPRESS_FORMAT_LZO &&
+                lzo_init() != LZO_E_OK) {
+                error_setg(errp, "ERROR: internal error - lzo_init() failed");
+                return 6;
+            }
+#endif
+
 #ifdef DEBUG_EXT
             printf("Qcow2: Got compress format %s with compress level %"
                    PRIu8 "\n", Qcow2CompressFormat_lookup[s->compress_format],
@@ -3078,8 +3097,8 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         visit_free(v);
         QDECREF(compressopts);
         QDECREF(options);
-        qcow2_compress_level_supported(compress.format, compress.level,
-                                       &local_err);
+        qcow2_compress_settings_supported(compress.format, compress.level,
+                                          &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             goto finish;
@@ -3394,7 +3413,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     z_stream z_strm = {};
     int z_windowBits = -15, z_level = Z_DEFAULT_COMPRESSION;
     int ret, out_len = 0;
-    uint8_t *buf, *out_buf = NULL, *local_buf = NULL;
+    uint8_t *buf, *out_buf = NULL, *local_buf = NULL, *work_buf = NULL;
     uint64_t cluster_offset;
 
     if (bytes == 0) {
@@ -3446,6 +3465,14 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 
         ret = ret != Z_STREAM_END;
         break;
+#ifdef CONFIG_LZO
+    case QCOW2_COMPRESS_FORMAT_LZO:
+        out_buf = g_malloc(s->cluster_size + s->cluster_size / 16 + 64 + 3);
+        work_buf = g_malloc(LZO1X_1_MEM_COMPRESS);
+        ret = lzo1x_1_compress(buf, s->cluster_size, out_buf,
+                               (lzo_uint *) &out_len, work_buf);
+        break;
+#endif
     default:
         abort(); /* should never reach this point */
     }
@@ -3491,6 +3518,7 @@ success:
 fail:
     qemu_vfree(local_buf);
     g_free(out_buf);
+    g_free(work_buf);
     return ret;
 }
 
diff --git a/configure b/configure
index 902653a..42e6ad0 100755
--- a/configure
+++ b/configure
@@ -1976,7 +1976,7 @@ if test "$lzo" != "no" ; then
 int main(void) { lzo_version(); return 0; }
 EOF
     if compile_prog "" "-llzo2" ; then
-        libs_softmmu="$libs_softmmu -llzo2"
+        LIBS="$LIBS -llzo2"
         lzo="yes"
     else
         if test "$lzo" = "yes"; then
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d6703a2..a368829 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2449,11 +2449,12 @@
 ##
 # @Qcow2CompressFormat:
 # @zlib: standard zlib deflate compression
+# @lzo: lzo1x compression
 #
 # Since: 2.10
 ##
 { 'enum': 'Qcow2CompressFormat',
-  'data': [ 'zlib' ] }
+  'data': [ 'zlib', 'lzo' ] }
 
 ##
 # @Qcow2CompressZLib:
@@ -2464,6 +2465,14 @@
   'data': { } }
 
 ##
+# @Qcow2CompressLZO:
+#
+# Since: 2.10
+##
+{ 'struct': 'Qcow2CompressLZO',
+  'data': { } }
+
+##
 # @Qcow2Compress:
 #
 # Specifies the compression format and compression level that should
@@ -2481,7 +2490,8 @@
   'base': { 'format': 'Qcow2CompressFormat',
             '*level': 'uint8' },
   'discriminator': 'format',
-  'data': { 'zlib': 'Qcow2CompressZLib' } }
+  'data': { 'zlib': 'Qcow2CompressZLib',
+            'lzo': 'Qcow2CompressLZO' } }
 
 
 ##
diff --git a/qemu-img.texi b/qemu-img.texi
index 79b0182..6ce2a02 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -675,6 +675,7 @@ The following options are available if support for the respective libraries
 has been enabled at compile time:
 
    zlib            Uses standard zlib compression
+   lzo             Uses LZO1X compression
 
 The compression algorithm can only be defined at image create time and cannot
 be changed later.
-- 
1.9.1
