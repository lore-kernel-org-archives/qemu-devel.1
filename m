Received: from eggs.gnu.org ([2001:4830:134:3::10]:36480)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1da125-0001ra-Gz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1da124-0000wb-9e
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:57 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:38004 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1da124-0000ur-0c
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:56 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 25 Jul 2017 16:41:38 +0200
Message-Id: <1500993699-19299-10-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-1-git-send-email-pl@kamp.de>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V5 09/10] block/qcow2: add lzo compress format
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
 block/qcow2-cluster.c  | 15 +++++++++++++++
 block/qcow2.c          | 25 ++++++++++++++++++++++++-
 configure              |  2 +-
 docs/interop/qcow2.txt |  2 ++
 qapi/block-core.json   | 15 ++++++++++++---
 qemu-img.texi          |  1 +
 6 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 345feec..f48cded 100644
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
index 6031963..0e9c2b8 100644
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
@@ -310,6 +313,14 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 return 5;
             }
 
+#ifdef CONFIG_LZO
+            if (s->compress.format == QCOW2_COMPRESS_FORMAT_LZO &&
+                lzo_init() != LZO_E_OK) {
+                error_setg(errp, "ERROR: internal error - lzo_init() failed");
+                return 6;
+            }
+#endif
+
 #ifdef DEBUG_EXT
             if (s->compress.format == QCOW2_COMPRESS_FORMAT_DEFLATE) {
                 printf("Qcow2: Got compress format %s with level %" PRIu8
@@ -317,6 +328,9 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                        Qcow2CompressFormat_lookup[s->compress.format],
                        s->compress.u.deflate.level,
                        s->compress.u.deflate.window_size);
+            } else {
+                printf("Qcow2: Got compress format %s\n",
+                       Qcow2CompressFormat_lookup[s->compress.format]);
             }
 #endif
             break;
@@ -3428,7 +3442,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     struct iovec iov;
     z_stream z_strm = {};
     int ret, out_len = 0;
-    uint8_t *buf, *out_buf = NULL, *local_buf = NULL;
+    uint8_t *buf, *out_buf = NULL, *local_buf = NULL, *work_buf = NULL;
     uint64_t cluster_offset;
 
     if (bytes == 0) {
@@ -3477,6 +3491,14 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 
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
@@ -3522,6 +3544,7 @@ success:
 fail:
     qemu_vfree(local_buf);
     g_free(out_buf);
+    g_free(work_buf);
     return ret;
 }
 
diff --git a/configure b/configure
index 987f59b..c1cee88 100755
--- a/configure
+++ b/configure
@@ -1958,7 +1958,7 @@ if test "$lzo" != "no" ; then
 int main(void) { lzo_version(); return 0; }
 EOF
     if compile_prog "" "-llzo2" ; then
-        libs_softmmu="$libs_softmmu -llzo2"
+        LIBS="$LIBS -llzo2"
         lzo="yes"
     else
         if test "$lzo" = "yes"; then
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index d0d2a8f..3262667 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -335,6 +335,8 @@ The fields of the compress format extension are:
                    deflate: Standard zlib deflate compression without
                             compression header
 
+                   lzo:     LZO1X compression without additional header
+
               14:  compress_level (uint8_t)
 
                    0 = default compress level (valid for all formats, default)
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f652206..d655bb1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2458,11 +2458,12 @@
 # @Qcow2CompressFormat:
 #
 # @deflate: standard zlib deflate compression
+# @lzo: lzo1x compression
 #
 # Since: 2.11
 ##
 { 'enum': 'Qcow2CompressFormat',
-  'data': [ 'deflate' ] }
+  'data': [ 'deflate', 'lzo' ] }
 
 ##
 # @Qcow2CompressDeflate:
@@ -2479,6 +2480,14 @@
             '*window-size': 'uint8' } }
 
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
@@ -2491,8 +2500,8 @@
 { 'union': 'Qcow2Compress',
   'base': { 'format': 'Qcow2CompressFormat' },
   'discriminator': 'format',
-  'data': { 'deflate': 'Qcow2CompressDeflate' } }
-
+  'data': { 'deflate': 'Qcow2CompressDeflate',
+            'lzo': 'Qcow2CompressLZO' } }
 
 ##
 # @BlockdevOptionsSsh:
diff --git a/qemu-img.texi b/qemu-img.texi
index 3612c59..5b0bdbe 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -682,6 +682,7 @@ The following options are available if support for the respective libraries
 has been enabled at compile time:
 
    deflate        Uses standard zlib defalte compression
+   lzo            Uses LZO1X compression
 
 The compression algorithm can only be defined at image create time and cannot
 be changed later.
-- 
1.9.1
