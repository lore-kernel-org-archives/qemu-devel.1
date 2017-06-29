Received: from eggs.gnu.org ([2001:4830:134:3::10]:51641)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dQX8d-00071o-A8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dQX8b-00080f-2c
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:30 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:42015 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dQX8a-0007wn-Pz
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:29 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 29 Jun 2017 12:57:11 +0200
Message-Id: <1498733831-15254-9-git-send-email-pl@kamp.de>
In-Reply-To: <1498733831-15254-1-git-send-email-pl@kamp.de>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V2 8/8] block/qcow2: add lzo compress format
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
 block/qcow2.c         | 26 +++++++++++++++++++++++++-
 block/qcow2.h         |  1 +
 configure             |  2 +-
 qapi/block-core.json  | 14 ++++++++++++--
 qemu-img.texi         |  1 +
 6 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 353ac87..666d090 100644
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
@@ -1546,6 +1549,18 @@ static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
         inflateEnd(&z_strm);
         break;
     }
+#ifdef CONFIG_LZO
+    case QCOW2_COMPRESS_LZO:
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
index b41e58d..ef94193 100644
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
@@ -83,6 +86,10 @@ static int qcow2_compress_format_from_name(char *fmt)
         return QCOW2_COMPRESS_ZLIB_COMPAT;
     } else if (g_str_equal(fmt, "zlib")) {
         return QCOW2_COMPRESS_ZLIB;
+#ifdef CONFIG_LZO
+    } else if (g_str_equal(fmt, "lzo")) {
+        return QCOW2_COMPRESS_LZO;
+#endif
     } else {
         return -EINVAL;
     }
@@ -92,6 +99,7 @@ static int qcow2_compress_level_supported(int id, uint64_t level)
 {
     if ((id == QCOW2_COMPRESS_ZLIB_COMPAT && level > 0) ||
         (id == QCOW2_COMPRESS_ZLIB && level > 9) ||
+        (id == QCOW2_COMPRESS_LZO && level > 0) ||
         level > 0xff) {
         return -EINVAL;
     }
@@ -197,6 +205,13 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                            s->compress_format.level, s->compress_format.name);
                 return 5;
             }
+#ifdef CONFIG_LZO
+            if (s->compress_format_id == QCOW2_COMPRESS_LZO &&
+                lzo_init() != LZO_E_OK) {
+                error_setg(errp, "ERROR: internal error - lzo_init() failed");
+                return 6;
+            }
+#endif
 
 #ifdef DEBUG_EXT
             printf("Qcow2: Got compress format %s with compress level %"
@@ -2751,7 +2766,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     z_stream z_strm = {};
     int z_windowBits = -15, z_level = Z_DEFAULT_COMPRESSION;
     int ret, out_len = 0;
-    uint8_t *buf, *out_buf = NULL, *local_buf = NULL;
+    uint8_t *buf, *out_buf = NULL, *local_buf = NULL, *work_buf = NULL;
     uint64_t cluster_offset;
 
     if (bytes == 0) {
@@ -2803,6 +2818,14 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 
         ret = ret != Z_STREAM_END;
         break;
+#ifdef CONFIG_LZO
+    case QCOW2_COMPRESS_LZO:
+        out_buf = g_malloc(s->cluster_size + s->cluster_size / 16 + 64 + 3);
+        work_buf = g_malloc(LZO1X_1_MEM_COMPRESS);
+        ret = lzo1x_1_compress(buf, s->cluster_size, out_buf,
+                               (lzo_uint *) &out_len, work_buf);
+        break;
+#endif
     default:
         abort(); /* should never reach this point */
     }
@@ -2848,6 +2871,7 @@ success:
 fail:
     qemu_vfree(local_buf);
     g_free(out_buf);
+    g_free(work_buf);
     return ret;
 }
 
diff --git a/block/qcow2.h b/block/qcow2.h
index 4ceaba1..038688d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -177,6 +177,7 @@ enum {
      * is specified at create time */
     QCOW2_COMPRESS_ZLIB_COMPAT = 0,
     QCOW2_COMPRESS_ZLIB        = 1,
+    QCOW2_COMPRESS_LZO         = 2,
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
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1574ffb..736073a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2284,11 +2284,12 @@
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
@@ -2299,6 +2300,14 @@
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
@@ -2316,7 +2325,8 @@
   'base': { 'format': 'Qcow2CompressFormat',
             'level': 'uint8' },
   'discriminator': 'format',
-  'data': { 'zlib': 'Qcow2CompressZLib' } }
+  'data': { 'zlib': 'Qcow2CompressZLib',
+            'lzo': 'Qcow2CompressLZO' } }
 
 ##
 # @BlockdevOptionsQcow2:
diff --git a/qemu-img.texi b/qemu-img.texi
index 430f0b9..fda0e50 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -627,6 +627,7 @@ The following options are available if support for the respective libraries
 has been enabled at compile time:
 
    zlib            Uses standard zlib compression
+   lzo             Uses LZO1X compression
 
 The compression algorithm can only be defined at image create time and cannot
 be changed later.
-- 
1.9.1
