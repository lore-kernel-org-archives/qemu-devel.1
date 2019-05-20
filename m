Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF1EC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB87F206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB87F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58659 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSbgJ-0008IU-R4
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 02:21:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hSbfT-0007u7-Rt
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hSbfS-0003Xr-Fd
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:21:03 -0400
Received: from relay.sw.ru ([185.231.240.75]:36658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hSbfO-0003VB-VH; Mon, 20 May 2019 02:20:59 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <dplotnikov@virtuozzo.com>)
	id 1hSbfJ-0006BF-Pg; Mon, 20 May 2019 09:20:53 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: eblake@redhat.com,
	kwolf@redhat.com,
	mreitz@redhat.com
Date: Mon, 20 May 2019 09:20:23 +0300
Message-Id: <20190520062023.11599-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2] [RFC] qcow2: add compression type feature
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch adds some preparation parts for incompatible compression type
feature into QCOW2 header that indicates that *all* compressed clusters
must be (de)compressed using a certain compression type.

It is implied that the compression type is set on the image creation and
can be changed only later by image conversion, thus the only compression
algorithm is used for the image.

The plan is to add support for ZSTD and then may be something more effective
in the future.

ZSTD compression algorithm consumes 3-5 times less CPU power with a
comparable compression ratio with zlib. It would be wise to use it for
data compression e.g. for backups.

The default compression is ZLIB.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/qcow2.c          | 25 +++++++++++++++++++++++++
 block/qcow2.h          | 29 ++++++++++++++++++++++-------
 docs/interop/qcow2.txt | 34 +++++++++++++++++++++++++++++++++-
 qapi/block-core.json   | 13 +++++++++++++
 4 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3ace3b2209..bca506b80f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -74,6 +74,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
 #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
+#define  QCOW2_EXT_MAGIC_COMPRESSION_TYPE 0x434D5052
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
@@ -398,6 +399,9 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
 #endif
             break;
 
+        case QCOW2_EXT_MAGIC_COMPRESSION_TYPE:
+            /* Setting compression type to BDRVQcow2State->compression_type */
+            /* from the image header is going to be here */
         case QCOW2_EXT_MAGIC_DATA_FILE:
         {
             s->image_data_file = g_malloc0(ext.len + 1);
@@ -2553,6 +2557,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
                 .name = "lazy refcounts",
             },
+            {
+                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
+                .bit  = QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
+                .name = "compression type",
+            },
         };
 
         ret = header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
@@ -2583,6 +2592,22 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Compression type extension */
+    if (s->compression_type != 0) {
+        Qcow2CompressionTypeExt comp_header = {
+            .compression_type = cpu_to_be32(s->compression_type),
+        };
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_COMPRESSION_TYPE,
+                             &comp_header,
+                             cpu_to_be64(sizeof(comp_header)),
+                             buflen);
+        if (ret < 0) {
+            goto fail;
+        }
+        buf += ret;
+        buflen -= ret;
+    }
+
     /* Keep unknown header extensions */
     QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
         ret = header_ext_add(buf, uext->magic, uext->data, uext->len, buflen);
diff --git a/block/qcow2.h b/block/qcow2.h
index fdee297f33..08468ab97d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -198,16 +198,20 @@ enum {
 
 /* Incompatible feature bits */
 enum {
-    QCOW2_INCOMPAT_DIRTY_BITNR      = 0,
-    QCOW2_INCOMPAT_CORRUPT_BITNR    = 1,
-    QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
-    QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
-    QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
-    QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
+    QCOW2_INCOMPAT_DIRTY_BITNR            = 0,
+    QCOW2_INCOMPAT_CORRUPT_BITNR          = 1,
+    QCOW2_INCOMPAT_DATA_FILE_BITNR        = 2,
+    QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR = 3,
+    QCOW2_INCOMPAT_DIRTY                  = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
+    QCOW2_INCOMPAT_CORRUPT                = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
+    QCOW2_INCOMPAT_DATA_FILE              = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
+    QCOW2_INCOMPAT_COMPRESSION_TYPE       =
+        1 << QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
 
     QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
                                     | QCOW2_INCOMPAT_CORRUPT
-                                    | QCOW2_INCOMPAT_DATA_FILE,
+                                    | QCOW2_INCOMPAT_DATA_FILE
+                                    | QCOW2_INCOMPAT_COMPRESSION_TYPE,
 };
 
 /* Compatible feature bits */
@@ -263,6 +267,10 @@ typedef struct Qcow2BitmapHeaderExt {
     uint64_t bitmap_directory_offset;
 } QEMU_PACKED Qcow2BitmapHeaderExt;
 
+typedef struct Qcow2CompressionTypeExt {
+    uint32_t compression_type;
+} QEMU_PACKED Qcow2CompressionTypeExt;
+
 typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
@@ -350,6 +358,13 @@ typedef struct BDRVQcow2State {
     int nb_compress_threads;
 
     BdrvChild *data_file;
+    /**
+     * Compression type used for the image. Default: 0 - ZLIB
+     * The image compression type is set on image creation.
+     * The only way to change the compression type is to convert the image
+     * with the desired compression type set
+     */
+    uint32_t compression_type;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index af5711e533..a070e82e1a 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -109,7 +109,14 @@ in the description of a field.
                                 An External Data File Name header extension may
                                 be present if this bit is set.
 
-                    Bits 3-63:  Reserved (set to 0)
+                    Bit 3:      Compression type. If the bit is set, then the
+                                type of compression the image uses is set in the
+                                header extension. When the bit is set the
+                                compression type extension header must be present.
+                                When the bit is not set the compression type
+                                header must absent.
+
+                    Bits 4-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -175,6 +182,7 @@ be stored. Each extension has a structure like the following:
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
                         0x44415441 - External data file name string
+                        0x434D5052 - Compression type extension
                         other      - Unknown header extension, can be safely
                                      ignored
 
@@ -771,3 +779,27 @@ In the image file the 'enabled' state is reflected by the 'auto' flag. If this
 flag is set, the software must consider the bitmap as 'enabled' and start
 tracking virtual disk changes to this bitmap from the first write to the
 virtual disk. If this flag is not set then the bitmap is disabled.
+
+
+== Compression type extension ==
+
+The compression type extension is an optional header extension. It stores the
+ID of the compressor which has to be used to compress/decompress disk clusters.
+A single compression type is applied to all compressed disk clusters,
+with no way to change compression types per cluster. Two clusters of the image
+couldn't be compressed with different compressors.
+
+The compression type is set on the image creation. The only way to change
+the compression type is to convert the image explicitly.
+
+The compression type extension is present if and only if the incompatible
+compression type bit is set. When the bit is not set the compression type
+header must absent.
+
+When the compression type bit is not set and the compression type header
+extension is absent ZLIB compression is used for compressed clusters.
+This defines default image compression type: ZLIB.
+
+Available compression types:
+    ID    0: Invalid value
+          1: ZSTD
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..9bde1372ba 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5257,3 +5257,16 @@
   'data' : { 'node-name': 'str',
              'iothread': 'StrOrNull',
              '*force': 'bool' } }
+
+##
+# @Qcow2CompressionType:
+#
+# Compression type used in qcow2 image file
+#
+# @zlib - gzip compressor
+# @zstd - zstd compression
+#
+# Since: 4.1
+##
+{ 'enum': 'Qcow2CompressionType',
+  'data': [ 'zlib', 'zstd' ] }
-- 
2.17.0


