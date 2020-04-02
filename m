Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E4BC2BA12
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D182206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D182206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJtUY-0001Wy-LC
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 02:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJtTh-0000Bw-Cj
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJtTf-0007FQ-EV
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:37:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:48120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJtTf-0007Dl-74; Thu, 02 Apr 2020 02:37:23 -0400
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJtTY-00022g-TU; Thu, 02 Apr 2020 09:37:17 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v18 3/4] qcow2: add zstd cluster compression
Date: Thu,  2 Apr 2020 09:36:44 +0300
Message-Id: <20200402063645.23685-4-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200402063645.23685-1-dplotnikov@virtuozzo.com>
References: <20200402063645.23685-1-dplotnikov@virtuozzo.com>
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
QAPI part:
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/qcow2.txt |   1 +
 configure              |   2 +-
 qapi/block-core.json   |   3 +-
 block/qcow2-threads.c  | 157 +++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          |   7 ++
 5 files changed, 168 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 640e0eca40..18a77f737e 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -209,6 +209,7 @@ version 2.
 
                     Available compression type values:
                         0: zlib <https://www.zlib.net/>
+                        1: zstd <http://github.com/facebook/zstd>
 
 
 === Header padding ===
diff --git a/configure b/configure
index e225a1e3ff..fdc991b010 100755
--- a/configure
+++ b/configure
@@ -1861,7 +1861,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   lzfse           support of lzfse compression library
                   (for reading lzfse-compressed dmg images)
   zstd            support for zstd compression library
-                  (for migration compression)
+                  (for migration compression and qcow2 cluster compression)
   seccomp         seccomp support
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1522e2983f..6fbacddab2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4293,11 +4293,12 @@
 # Compression type used in qcow2 image file
 #
 # @zlib: zlib compression, see <http://zlib.net/>
+# @zstd: zstd compression, see <http://github.com/facebook/zstd>
 #
 # Since: 5.1
 ##
 { 'enum': 'Qcow2CompressionType',
-  'data': [ 'zlib' ] }
+  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
 
 ##
 # @BlockdevCreateOptionsQcow2:
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 7dbaf53489..0525718704 100644
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
@@ -166,6 +171,148 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
     return ret;
 }
 
+#ifdef CONFIG_ZSTD
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
+    ssize_t ret;
+    ZSTD_outBuffer output = { dest, dest_size, 0 };
+    ZSTD_inBuffer input = { src, src_size, 0 };
+    ZSTD_CCtx *cctx = ZSTD_createCCtx();
+
+    if (!cctx) {
+        return -EIO;
+    }
+    /*
+     * Use the zstd streamed interface for symmetry with decompression,
+     * where streaming is essential since we don't record the exact
+     * compressed size.
+     *
+     * In the loop, we try to compress all the data into one zstd frame.
+     * ZSTD_compressStream2 potentially can finish a frame earlier
+     * than the full input data is consumed. That's why we are looping
+     * until all the input data is consumed.
+     */
+    while (input.pos < input.size) {
+        size_t zstd_ret;
+        /*
+         * ZSTD spec: "You must continue calling ZSTD_compressStream2()
+         * with ZSTD_e_end until it returns 0, at which point you are
+         * free to start a new frame". We assume that "start a new frame"
+         * means call ZSTD_compressStream2 in the very beginning or when
+         * ZSTD_compressStream2 has returned with 0.
+         */
+        do {
+            zstd_ret = ZSTD_compressStream2(cctx, &output, &input, ZSTD_e_end);
+
+            if (ZSTD_isError(zstd_ret)) {
+                ret = -EIO;
+                goto out;
+            }
+            /* Dest buffer isn't big enough to store compressed content */
+            if (zstd_ret > output.size - output.pos) {
+                ret = -ENOMEM;
+                goto out;
+            }
+        } while (zstd_ret);
+    }
+    /* make sure we can safely return compressed buffer size with ssize_t */
+    assert(output.pos <= SSIZE_MAX);
+    ret = output.pos;
+out:
+    ZSTD_freeCCtx(cctx);
+    return ret;
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
+    size_t zstd_ret = 0;
+    ssize_t ret = 0;
+    ZSTD_outBuffer output = { dest, dest_size, 0 };
+    ZSTD_inBuffer input = { src, src_size, 0 };
+    ZSTD_DCtx *dctx = ZSTD_createDCtx();
+
+    if (!dctx) {
+        return -EIO;
+    }
+
+    /*
+     * The compressed stream from the input buffer may consist of more
+     * than one zstd frame. So we iterate until we get a fully
+     * uncompressed cluster.
+     * From zstd docs related to ZSTD_decompressStream:
+     * "return : 0 when a frame is completely decoded and fully flushed"
+     * We suppose that this means: each time ZSTD_decompressStream reads
+     * only ONE full frame and returns 0 if and only if that frame
+     * is completely decoded and flushed. Only after returning 0,
+     * ZSTD_decompressStream reads another ONE full frame.
+     */
+    while (output.pos < output.size) {
+        size_t last_in_pos = input.pos;
+        size_t last_out_pos = output.pos;
+        zstd_ret = ZSTD_decompressStream(dctx, &output, &input);
+
+        if (ZSTD_isError(zstd_ret)) {
+            ret = -EIO;
+            break;
+        }
+
+        /*
+         * The ZSTD manual is vague about what to do if it reads
+         * the buffer partially, and we don't want to get stuck
+         * in an infinite loop where ZSTD_decompressStream
+         * returns > 0 waiting for another input chunk. So, we add
+         * a check which ensures that the loop makes some progress
+         * on each step.
+         */
+        if (last_in_pos >= input.pos &&
+            last_out_pos >= output.pos) {
+            ret = -EIO;
+            break;
+        }
+    }
+    /*
+     * Make sure that we have the frame fully flushed here
+     * if not, we somehow managed to get uncompressed cluster
+     * greater then the cluster size, possibly because of its
+     * damage.
+     */
+    if (zstd_ret > 0) {
+        ret = -EIO;
+    }
+
+    ZSTD_freeDCtx(dctx);
+    assert(ret == 0 || ret == -EIO);
+    return ret;
+}
+#endif
+
 static int qcow2_compress_pool_func(void *opaque)
 {
     Qcow2CompressData *data = opaque;
@@ -217,6 +364,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
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
@@ -249,6 +401,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
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
index 6cb000be19..3ae9624ba3 100644
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
@@ -3478,6 +3481,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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


