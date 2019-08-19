Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004BEC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA26D20651
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA26D20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzjFY-0004Nz-Cq
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 11:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hzj9i-0007IY-KT
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hzj9d-00071I-6x
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:01:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:44684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hzj9Z-0006xv-MZ; Mon, 19 Aug 2019 11:01:02 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hzj9V-0001Wf-2P; Mon, 19 Aug 2019 18:00:57 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 18:00:49 +0300
Message-Id: <20190819150049.28997-4-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190819150049.28997-1-dplotnikov@virtuozzo.com>
References: <20190819150049.28997-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 3/3] qcow2: add zstd cluster compression
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

zstd significantly reduces cluster compression time.
It provides better compression performance maintaining
the same level of compression ratio in comparison with
zlib, which, at the moment, has been the only compression
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
---
 block/qcow2-threads.c  | 94 ++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          |  6 +++
 configure              | 34 +++++++++++++++
 docs/interop/qcow2.txt | 20 +++++++++
 qapi/block-core.json   |  3 +-
 5 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 14b5bd76fb..85d04e6c2e 100644
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
@@ -165,6 +170,85 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
     return ret;
 }
 
+#ifdef CONFIG_ZSTD
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
+
+static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
+                                   const void *src, size_t src_size)
+{
+    ssize_t ret;
+    uint32_t *c_size = dest;
+    /* steal some bytes to store compressed chunk size */
+    char *d_buf = ((char *) dest) + sizeof(*c_size);
+
+    if (dest_size < sizeof(*c_size)) {
+        return -ENOMEM;
+    }
+
+    dest_size -= sizeof(*c_size);
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
+    /* store the compressed chunk size in the very beginning of the buffer */
+    *c_size = ret;
+
+    return ret + sizeof(*c_size);
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
+
+static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
+                                     const void *src, size_t src_size)
+{
+    ssize_t ret;
+    /*
+     * zstd decompress wants to know the exact length of the data
+     * for that purpose, on the compression the length is stored in
+     * the very beginning of the compressed buffer
+     */
+    const uint32_t *s_size = src;
+    const char *s_buf = ((const char *) src) + sizeof(*s_size);
+
+    ret = ZSTD_decompress(dest, dest_size, s_buf, *s_size);
+
+    if (ZSTD_isError(ret)) {
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
@@ -216,6 +300,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
         fn = qcow2_zlib_compress;
         break;
 
+#ifdef CONFIG_ZSTD
+    case QCOW2_COMPRESSION_TYPE_ZSTD:
+        fn = qcow2_zstd_compress;
+        break;
+#endif
     default:
         return -ENOTSUP;
     }
@@ -248,6 +337,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
         fn = qcow2_zlib_decompress;
         break;
 
+#ifdef CONFIG_ZSTD
+    case QCOW2_COMPRESSION_TYPE_ZSTD:
+        fn = qcow2_zstd_decompress;
+        break;
+#endif
     default:
         return -ENOTSUP;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 4e07b7e9ec..dfb7b52033 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1201,6 +1201,9 @@ static int check_compression_type(BDRVQcow2State *s, Error **errp)
 {
     switch (s->compression_type) {
     case QCOW2_COMPRESSION_TYPE_ZLIB:
+#ifdef CONFIG_ZSTD
+    case QCOW2_COMPRESSION_TYPE_ZSTD:
+#endif
         break;
 
     default:
@@ -3294,6 +3297,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
         switch (qcow2_opts->compression_type) {
         case QCOW2_COMPRESSION_TYPE_ZLIB:
+#ifdef CONFIG_ZSTD
+        case QCOW2_COMPRESSION_TYPE_ZSTD:
+#endif
             break;
 
         default:
diff --git a/configure b/configure
index 714e7fb6a1..111c34878d 100755
--- a/configure
+++ b/configure
@@ -441,6 +441,7 @@ opengl_dmabuf="no"
 cpuid_h="no"
 avx2_opt=""
 zlib="yes"
+zstd=""
 capstone=""
 lzo=""
 snappy=""
@@ -1358,6 +1359,10 @@ for opt do
   ;;
   --disable-lzfse) lzfse="no"
   ;;
+  --enable-zstd) zstd="yes"
+  ;;
+  --disable-zstd) zstd="no"
+  ;;
   --enable-guest-agent) guest_agent="yes"
   ;;
   --disable-guest-agent) guest_agent="no"
@@ -1812,6 +1817,7 @@ disabled with --disable-FEATURE, default is enabled if available:
                   (for reading bzip2-compressed dmg images)
   lzfse           support of lzfse compression library
                   (for reading lzfse-compressed dmg images)
+  zstd            support of zstd compression library
   seccomp         seccomp support
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
@@ -2407,6 +2413,30 @@ EOF
     fi
 fi
 
+#########################################
+# zstd check
+
+if test "$zstd" == "yes" ; then
+    if $pkg_config --exists libzstd; then
+        zstd_cflags=$($pkg_config --cflags libzstd)
+        zstd_libs=$($pkg_config --libs libzstd)
+        QEMU_CFLAGS="$zstd_cflags $QEMU_CFLAGS"
+        LIBS="$zstd_libs $LIBS"
+    else
+        cat > $TMPC << EOF
+#include <zstd.h>
+int main(void) { ZSTD_versionNumber(); return 0; }
+EOF
+        if compile_prog "" "-lzstd" ; then
+            LIBS="$LIBS -lzstd"
+        else
+            feature_not_found "zstd" "Install libzstd-devel"
+        fi
+    fi
+else
+    zstd="no"
+fi
+
 ##########################################
 # libseccomp check
 
@@ -6460,6 +6490,7 @@ echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
 echo "lzfse support     $lzfse"
+echo "zstd support      $zstd"
 echo "NUMA host support $numa"
 echo "libxml2           $libxml2"
 echo "tcmalloc support  $tcmalloc"
@@ -7306,6 +7337,9 @@ fi
 if test "$sheepdog" = "yes" ; then
   echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
 fi
+if test "$zstd" = "yes" ; then
+  echo "CONFIG_ZSTD=y" >> $config_host_mak
+fi
 
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index e1be8bd5c3..4b0dc124f5 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -181,6 +181,7 @@ in the description of a field.
                     must be set.
                     Available compression type values:
                         0: zlib <https://www.zlib.net/> (default)
+                        1: zstd <http://github.com/facebook/zstd>
 
 Directly after the image header, optional sections called header extensions can
 be stored. Each extension has a structure like the following:
@@ -536,6 +537,9 @@ Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
                     Another compressed cluster may map to the tail of the final
                     sector used by this compressed cluster.
 
+                    The layout of the compressed data depends on the compression
+                    type used for the image (see compressed cluster layout).
+
 If a cluster is unallocated, read requests shall read the data from the backing
 file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
 no backing file or the backing file is smaller than the image, they shall read
@@ -788,3 +792,19 @@ In the image file the 'enabled' state is reflected by the 'auto' flag. If this
 flag is set, the software must consider the bitmap as 'enabled' and start
 tracking virtual disk changes to this bitmap from the first write to the
 virtual disk. If this flag is not set then the bitmap is disabled.
+
+=== Compressed cluster layout ===
+
+The compressed cluster data may have a different layout depending on the
+compression type used for the image, and store specific data for the particular
+compression type.
+
+Compressed data layout for the available compression types:
+(x = data_space_length - 1)
+
+    zlib <http://zlib.net/>:
+        Byte  0 -  x:     the compressed data content
+                          all the space provided used for compressed data
+    zstd <http://github.com/facebook/zstd>:
+        Byte  0 -  3:     the length of compressed data
+              4 -  x:     the compressed data content
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2c002ca6a9..9e458d5b40 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4283,11 +4283,12 @@
 # Compression type used in qcow2 image file
 #
 # @zlib:  zlib compression, see <http://zlib.net/>
+# @zstd:  zstd compression, see <http://github.com/facebook/zstd>
 #
 # Since: 4.2
 ##
 { 'enum': 'Qcow2CompressionType',
-  'data': [ 'zlib' ] }
+  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
 
 ##
 # @BlockdevCreateOptionsQcow2:
-- 
2.17.0


