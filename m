Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEC7C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A680C2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A680C2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCK5U-0000sD-2s
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 05:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jCK3U-0005oH-93
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jCK3R-00077h-Ai
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:23:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:49620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jCK3R-00075L-2z; Thu, 12 Mar 2020 05:23:01 -0400
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jCK3F-0004ma-G6; Thu, 12 Mar 2020 12:22:49 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/4] qcow2: add zstd cluster compression
Date: Thu, 12 Mar 2020 12:22:41 +0300
Message-Id: <20200312092242.5536-4-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200312092242.5536-1-dplotnikov@virtuozzo.com>
References: <20200312092242.5536-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

zstd significantly reduces cluster compression time.
It provides better compression performance maintaining
the same level of the compression ratio in comparison with
zlib, which, at the moment, is the only compression
method available.

The performance test results:
Test compresses and decompresses qemu qcow2 image with just
installed rhel-7.6 guest.
Image cluster size: 64K. Image on disk size: 2.2G

The test was conducted with brd disk to reduce the influence
of disk subsystem to the test results.
The results is given in seconds.

compress cmd:
  time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
                  src.img [zlib|zstd]_compressed.img
decompress cmd
  time ./qemu-img convert -O qcow2
                  [zlib|zstd]_compressed.img uncompressed.img

           compression               decompression
         zlib       zstd           zlib         zstd
------------------------------------------------------------
real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
user     65.0       15.8            5.3          2.5
sys       3.3        0.2            2.0          2.0

Both ZLIB and ZSTD gave the same compression ratio: 1.57
compressed image size in both cases: 1.4G

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
QAPI part:
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/qcow2.txt |  20 +++++++
 configure              |   2 +-
 qapi/block-core.json   |   3 +-
 block/qcow2-threads.c  | 124 +++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          |  11 ++++
 5 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 5597e24474..9048114445 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -208,6 +208,7 @@ version 2.
 
                     Available compression type values:
                         0: zlib <https://www.zlib.net/>
+                        1: zstd <http://github.com/facebook/zstd>
 
 
 === Header padding ===
@@ -575,11 +576,30 @@ Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
                     Another compressed cluster may map to the tail of the final
                     sector used by this compressed cluster.
 
+                    The layout of the compressed data depends on the compression
+                    type used for the image (see compressed cluster layout).
+
 If a cluster is unallocated, read requests shall read the data from the backing
 file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
 no backing file or the backing file is smaller than the image, they shall read
 zeros for all parts that are not covered by the backing file.
 
+=== Compressed Cluster Layout ===
+
+The compressed cluster data has a layout depending on the compression
+type used for the image, as follows:
+
+Compressed data layout for the available compression types:
+data_space_lenght - data chunk length available to store a compressed cluster.
+(for more details see "Compressed Clusters Descriptor")
+x = data_space_length - 1
+
+    0:  (default)  zlib <http://zlib.net/>:
+            Byte  0 -  x:     the compressed data content
+                              all the space provided used for compressed data
+    1:  zstd <http://github.com/facebook/zstd>:
+            Byte  0 -  3:     the length of compressed data in bytes
+                  4 -  x:     the compressed data content
 
 == Snapshots ==
 
diff --git a/configure b/configure
index caa65f5883..b2a0aa241a 100755
--- a/configure
+++ b/configure
@@ -1835,7 +1835,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   lzfse           support of lzfse compression library
                   (for reading lzfse-compressed dmg images)
   zstd            support for zstd compression library
-                  (for migration compression)
+                  (for migration compression and qcow2 cluster compression)
   seccomp         seccomp support
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
diff --git a/qapi/block-core.json b/qapi/block-core.json
index a306484973..8953451818 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4401,11 +4401,12 @@
 # Compression type used in qcow2 image file
 #
 # @zlib: zlib compression, see <http://zlib.net/>
+# @zstd: zstd compression, see <http://github.com/facebook/zstd>
 #
 # Since: 5.0
 ##
 { 'enum': 'Qcow2CompressionType',
-  'data': [ 'zlib' ] }
+  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
 
 ##
 # @BlockdevCreateOptionsQcow2:
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 7dbaf53489..b2d1c6d395 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -28,6 +28,11 @@
 #define ZLIB_CONST
 #include <zlib.h>
 
+#ifdef CONFIG_ZSTD
+#include <zstd.h>
+#include <zstd_errors.h>
+#endif
+
 #include "qcow2.h"
 #include "block/thread-pool.h"
 #include "crypto.h"
@@ -166,6 +171,115 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
     return ret;
 }
 
+#ifdef CONFIG_ZSTD
+
+/* The buffer size to store compressed chunk length */
+#define ZSTD_LEN_BUF 4
+
+/*
+ * qcow2_zstd_compress()
+ *
+ * Compress @src_size bytes of data using zstd compression method
+ *
+ * @dest - destination buffer, @dest_size bytes
+ * @src - source buffer, @src_size bytes
+ *
+ * Returns: compressed size on success
+ *          -ENOMEM destination buffer is not enough to store compressed data
+ *          -EIO    on any other error
+ */
+static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
+                                   const void *src, size_t src_size)
+{
+    size_t ret;
+
+    /*
+     * steal ZSTD_LEN_BUF bytes in the very beginning of the buffer
+     * to store compressed chunk size
+     */
+    char *d_buf = ((char *) dest) + ZSTD_LEN_BUF;
+
+    /*
+     * sanity check that we can store the compressed data length,
+     * and there is some space left for the compressor buffer
+     */
+    if (dest_size <= ZSTD_LEN_BUF) {
+        return -ENOMEM;
+    }
+
+    dest_size -= ZSTD_LEN_BUF;
+
+    ret = ZSTD_compress(d_buf, dest_size, src, src_size, 5);
+
+    if (ZSTD_isError(ret)) {
+        if (ZSTD_getErrorCode(ret) == ZSTD_error_dstSize_tooSmall) {
+            return -ENOMEM;
+        } else {
+            return -EIO;
+        }
+    }
+
+    /*
+     * paranoid sanity check that we can store
+     * the compressed size in the first 4 bytes
+     */
+    if (ret > UINT32_MAX) {
+        return -ENOMEM;
+    }
+
+    /* store the compressed chunk size in the very beginning of the buffer */
+    stl_be_p(dest, ret);
+
+    return ret + ZSTD_LEN_BUF;
+}
+
+/*
+ * qcow2_zstd_decompress()
+ *
+ * Decompress some data (not more than @src_size bytes) to produce exactly
+ * @dest_size bytes using zstd compression method
+ *
+ * @dest - destination buffer, @dest_size bytes
+ * @src - source buffer, @src_size bytes
+ *
+ * Returns: 0 on success
+ *          -EIO on any error
+ */
+static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
+                                     const void *src, size_t src_size)
+{
+    /*
+     * zstd decompress wants to know the exact length of the data.
+     * For that purpose, on compression, the length is stored in
+     * the very beginning of the compressed buffer
+     */
+    size_t s_size;
+    const char *s_buf = ((const char *) src) + ZSTD_LEN_BUF;
+
+    /*
+     * sanity check that we can read 4 byte the content length and
+     * and there is some content to decompress
+     */
+    if (src_size <= ZSTD_LEN_BUF) {
+        return -EIO;
+    }
+
+    s_size = ldl_be_p(src);
+
+    /* sanity check that the buffer is big enough to read the content from */
+    if (src_size - ZSTD_LEN_BUF < s_size) {
+        return -EIO;
+    }
+
+    if (ZSTD_isError(
+            ZSTD_decompress(dest, dest_size, s_buf, s_size))) {
+        return -EIO;
+    }
+
+    return 0;
+}
+#endif
+
 static int qcow2_compress_pool_func(void *opaque)
 {
     Qcow2CompressData *data = opaque;
@@ -217,6 +331,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
         fn = qcow2_zlib_compress;
         break;
 
+#ifdef CONFIG_ZSTD
+    case QCOW2_COMPRESSION_TYPE_ZSTD:
+        fn = qcow2_zstd_compress;
+        break;
+#endif
     default:
         abort();
     }
@@ -249,6 +368,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
         fn = qcow2_zlib_decompress;
         break;
 
+#ifdef CONFIG_ZSTD
+    case QCOW2_COMPRESSION_TYPE_ZSTD:
+        fn = qcow2_zstd_decompress;
+        break;
+#endif
     default:
         abort();
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 21231adb63..53f65502f1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1246,6 +1246,9 @@ static int validate_compression_type(BDRVQcow2State *s, Error **errp)
 {
     switch (s->compression_type) {
     case QCOW2_COMPRESSION_TYPE_ZLIB:
+#ifdef CONFIG_ZSTD
+    case QCOW2_COMPRESSION_TYPE_ZSTD:
+#endif
         break;
 
     default:
@@ -1279,6 +1282,10 @@ static int qcow2_compression_type_from_format(const char *ct)
 {
     if (g_str_equal(ct, "zlib")) {
         return QCOW2_COMPRESSION_TYPE_ZLIB;
+#ifdef CONFIG_ZSTD
+    } else if (g_str_equal(ct, "zstd")) {
+        return QCOW2_COMPRESSION_TYPE_ZSTD;
+#endif
     } else {
         return -EINVAL;
     }
@@ -3463,6 +3470,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         }
 
         switch (qcow2_opts->compression_type) {
+#ifdef CONFIG_ZSTD
+        case QCOW2_COMPRESSION_TYPE_ZSTD:
+            break;
+#endif
         default:
             error_setg(errp, "Unknown compression type");
             goto out;
-- 
2.17.0


