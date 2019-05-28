Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF5C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C3020679
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C3020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36003 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVdGo-00032g-1V
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 10:40:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVdFg-0002QG-Kz
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVdFV-0007t2-Ek
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:38:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:46356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVdFO-0006u9-LX; Tue, 28 May 2019 10:38:40 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVdEM-0004ye-Cx; Tue, 28 May 2019 17:37:34 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com,
	qemu-block@nongnu.org
Date: Tue, 28 May 2019 17:37:27 +0300
Message-Id: <20190528143727.10529-4-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v0 3/3] qcow2: add zstd cluster compression
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

zstd significantly reduces cluster compression time.
It provides better compression performance maintaining
the same level of compression ratio in comparison with
zlib, which, by the moment, has been the only compression
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
 block/qcow2.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 configure     | 26 ++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 90f15cc3c9..58901f9f79 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -26,6 +26,7 @@
 
 #define ZLIB_CONST
 #include <zlib.h>
+#include <zstd.h>
 
 #include "block/block_int.h"
 #include "block/qdict.h"
@@ -1553,6 +1554,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     case QCOW2_COMPRESSION_TYPE_ZLIB:
         break;
 
+    case QCOW2_COMPRESSION_TYPE_ZSTD:
+        break;
+
     default:
         error_setg(errp, "Unknown compression type");
         ret = -EINVAL;
@@ -3286,6 +3290,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
          *  ZLIB shouldn't be here since it's the default
          */
         switch (qcow2_opts->compression_type) {
+        case QCOW2_COMPRESSION_TYPE_ZSTD:
+            break;
+
         default:
             error_setg_errno(errp, -EINVAL, "Unknown compression type");
             goto out;
@@ -4113,6 +4120,73 @@ static ssize_t zlib_decompress(void *dest, size_t dest_size,
     return ret;
 }
 
+/*
+ * zstd_compress()
+ *
+ * @dest - destination buffer, @dest_size bytes
+ * @src - source buffer, @src_size bytes
+ *
+ * Returns: compressed size on success
+ *          -1 on any error
+ */
+
+static ssize_t zstd_compress(void *dest, size_t dest_size,
+                             const void *src, size_t src_size)
+{
+    /* steal some bytes to store compressed chunk size */
+    size_t ret;
+    size_t *c_size = dest;
+    char *d_buf = dest;
+    d_buf += sizeof(ret);
+    dest_size -= sizeof(ret);
+
+    ret = ZSTD_compress(d_buf, dest_size, src, src_size, 5);
+
+    if (ZSTD_isError(ret)) {
+        return -1;
+    }
+
+    /* store the compressed chunk size in the very beginning of the buffer */
+    *c_size = ret;
+
+    return ret + sizeof(ret);
+}
+
+/*
+ * zstd_decompress()
+ *
+ * Decompress some data (not more than @src_size bytes) to produce exactly
+ * @dest_size bytes.
+ *
+ * @dest - destination buffer, @dest_size bytes
+ * @src - source buffer, @src_size bytes
+ *
+ * Returns: 0 on success
+ *          -1 on fail
+ */
+
+static ssize_t zstd_decompress(void *dest, size_t dest_size,
+                             const void *src, size_t src_size)
+{
+    size_t ret;
+    /*
+     * zstd decompress wants to know the exact lenght of the data
+     * for that purpose, zstd_compress stores the length in the
+     * very beginning of the compressed buffer
+     */
+    const size_t *s_size = src;
+    const char *s_buf = src;
+    s_buf += sizeof(size_t);
+
+    ret = ZSTD_decompress(dest, dest_size, s_buf, *s_size);
+
+    if (ZSTD_isError(ret)) {
+        return -1;
+    }
+
+    return 0;
+}
+
 #define MAX_COMPRESS_THREADS 4
 
 typedef ssize_t (*Qcow2CompressFunc)(void *dest, size_t dest_size,
@@ -4189,6 +4263,10 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
         fn = zlib_compress;
         break;
 
+    case QCOW2_COMPRESSION_TYPE_ZSTD:
+        fn = zstd_compress;
+        break;
+
     default:
         return -ENOTSUP;
     }
@@ -4208,6 +4286,10 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
         fn = zlib_decompress;
         break;
 
+    case QCOW2_COMPRESSION_TYPE_ZSTD:
+        fn = zstd_decompress;
+        break;
+
     default:
         return -ENOTSUP;
     }
diff --git a/configure b/configure
index 1c563a7027..c90716189c 100755
--- a/configure
+++ b/configure
@@ -433,6 +433,7 @@ opengl_dmabuf="no"
 cpuid_h="no"
 avx2_opt=""
 zlib="yes"
+zstd="yes"
 capstone=""
 lzo=""
 snappy=""
@@ -1317,6 +1318,8 @@ for opt do
   ;;
   --disable-zlib-test) zlib="no"
   ;;
+  --disable-zstd-test) zstd="no"
+  ;;
   --disable-lzo) lzo="no"
   ;;
   --enable-lzo) lzo="yes"
@@ -3702,6 +3705,29 @@ EOF
     fi
 fi
 
+#########################################
+# zstd check
+
+if test "$zstd" != "no" ; then
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
+            error_exit "zstd check failed" \
+                "Make sure to have the zstd libs and headers installed."
+        fi
+    fi
+fi
+
 ##########################################
 # SHA command probe for modules
 if test "$modules" = yes; then
-- 
2.17.0


