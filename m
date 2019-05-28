Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9455C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFB620679
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFB620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVdGQ-0002kq-Ck
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 10:39:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVdFK-0002EK-3j
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVdF8-0007ca-2q
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:38:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:46350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVdEo-0006u7-99; Tue, 28 May 2019 10:38:02 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVdEM-0004ye-0f; Tue, 28 May 2019 17:37:34 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com,
	qemu-block@nongnu.org
Date: Tue, 28 May 2019 17:37:25 +0300
Message-Id: <20190528143727.10529-2-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v0 1/3] qcow2: introduce compression type
 feature
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

The patch adds some preparation parts for incompatible compression type
feature to QCOW2 header that indicates that *all* compressed clusters
must be (de)compressed using a certain compression type.

It is implied that the compression type is set on the image creation and
can be changed only later by image conversion, thus compression type
defines the only compression algorithm used for the image.

The goal of the feature is to add support of other compression algorithms
to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
It works roughly x2 faster than ZLIB providing a comparable compression ratio
and therefore provide a performance advantage in backup scenarios.

The default compression is ZLIB. Images created with ZLIB compression type
is backward compatible with older qemu versions.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/qcow2.c             | 61 +++++++++++++++++++++++++++++++++++++++
 block/qcow2.h             | 29 ++++++++++++++-----
 docs/interop/qcow2.txt    | 37 +++++++++++++++++++++++-
 include/block/block_int.h |  1 +
 qapi/block-core.json      | 34 ++++++++++++++++++++--
 5 files changed, 151 insertions(+), 11 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3ace3b2209..c4b5b93408 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -74,6 +74,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
 #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
+#define  QCOW2_EXT_MAGIC_COMPRESSION_TYPE 0x434D5052
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
@@ -398,6 +399,13 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
 #endif
             break;
 
+        case QCOW2_EXT_MAGIC_COMPRESSION_TYPE:
+            /*
+             * Setting compression type to BDRVQcow2State->compression_type
+             * from the image header is going to be here
+             */
+             break;
+
         case QCOW2_EXT_MAGIC_DATA_FILE:
         {
             s->image_data_file = g_malloc0(ext.len + 1);
@@ -2553,6 +2561,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -2583,6 +2596,22 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Compression type extension */
+    if (s->compression_type != 0) {
+        Qcow2CompressionTypeExt comp_header = {
+            .compression_type = cpu_to_be32(s->compression_type),
+        };
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_COMPRESSION_TYPE,
+                             &comp_header,
+                             sizeof(comp_header),
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
@@ -3184,6 +3213,29 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
+    /*
+     * default compression type is ZLIB: 0
+     * to apply it, there is no need for any header modification
+     */
+    if (qcow2_opts->has_compression_type &&
+        qcow2_opts->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
+
+        BDRVQcow2State *s = blk_bs(blk)->opaque;
+
+        /*
+         *  check for known compression types
+         *  ZLIB shouldn't be here since it's the default
+         */
+        switch (qcow2_opts->compression_type) {
+        default:
+            error_setg_errno(errp, -EINVAL, "Unknown compression type");
+            goto out;
+        }
+        s->incompatible_features |= QCOW2_INCOMPAT_COMPRESSION_TYPE;
+        s->compression_type = qcow2_opts->compression_type;
+    }
+
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     if (ret < 0) {
@@ -3307,6 +3359,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
         { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
+        { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
         { NULL, NULL },
     };
 
@@ -4675,6 +4728,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
             .data_file          = g_strdup(s->image_data_file),
             .has_data_file_raw  = has_data_file(bs),
             .data_file_raw      = data_file_is_raw(bs),
+            .has_compression_type = true,
+            .compression_type   = s->compression_type
         };
     } else {
         /* if this assertion fails, this probably means a new version was
@@ -5239,6 +5294,12 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Width of a reference count entry in bits",
             .def_value_str = "16"
         },
+        {
+            .name = BLOCK_OPT_COMPRESSION_TYPE,
+            .type = QEMU_OPT_STRING,
+            .help = "Compression method used for image clusters compression",
+            .def_value_str = "0"
+        },
         { /* end of list */ }
     }
 };
diff --git a/block/qcow2.h b/block/qcow2.h
index fdee297f33..b70da3138d 100644
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
+    /*
+     * Compression type used for the image. Default: 0 - ZLIB
+     * The image compression type is set on image creation.
+     * The only way to change the compression type is to convert the image
+     * with the desired compression type set
+     */
+    uint32_t compression_type;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index af5711e533..cebcbc4f2f 100644
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
 
@@ -771,3 +779,30 @@ In the image file the 'enabled' state is reflected by the 'auto' flag. If this
 flag is set, the software must consider the bitmap as 'enabled' and start
 tracking virtual disk changes to this bitmap from the first write to the
 virtual disk. If this flag is not set then the bitmap is disabled.
+
+
+== Compression type extension ==
+
+The compression type extension is an optional header extension. It stores the
+compression type used for disk clusters (de)compression.
+A single compression type is applied to all compressed disk clusters,
+with no way to change compression types per cluster. Two clusters of the image
+couldn't be compressed with different compression types.
+
+The compression type is set on image creation. The only way to change
+the compression type is to convert the image explicitly.
+
+The compression type extension is present if and only if the incompatible
+compression type bit is set. When the bit is not set the compression type
+header must be absent.
+
+When the compression type bit is not set and the compression type header
+extension is absent, ZLIB compression is used for compressed clusters.
+This defines default image compression type: ZLIB.
+Qemu < 4.1 can use images created with compression type ZLIB without any
+additional preparations and cannot use images created with compression
+types != ZLIB.
+
+Available compression types:
+    0: ZLIB
+    1: ZSTD
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 01e855a066..814917baec 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -58,6 +58,7 @@
 #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
 #define BLOCK_OPT_DATA_FILE         "data_file"
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
+#define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..59610153fd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -78,6 +78,9 @@
 #
 # @bitmaps: A list of qcow2 bitmap details (since 4.0)
 #
+# @compression-type: the compression method used for image clusters
+#                    compression (since 4.1)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -89,7 +92,8 @@
       '*corrupt': 'bool',
       'refcount-bits': 'int',
       '*encrypt': 'ImageInfoSpecificQCow2Encryption',
-      '*bitmaps': ['Qcow2BitmapInfo']
+      '*bitmaps': ['Qcow2BitmapInfo'],
+      '*compression-type': 'Qcow2CompressionType'
   } }
 
 ##
@@ -3119,6 +3123,10 @@
 #                         an image, the data file name is loaded from the image
 #                         file. (since 4.0)
 #
+# @compression-type:      compression method to use for image clusters compression
+#                         The comression method is set on image creation and can
+#                         be changed via image converting only. (since 4.1)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsQcow2',
@@ -3134,7 +3142,8 @@
             '*refcount-cache-size': 'int',
             '*cache-clean-interval': 'int',
             '*encrypt': 'BlockdevQcow2Encryption',
-            '*data-file': 'BlockdevRef' } }
+            '*data-file': 'BlockdevRef',
+            '*compression-type': 'Qcow2CompressionType' } }
 
 ##
 # @SshHostKeyCheckMode:
@@ -4206,6 +4215,19 @@
   'data': [ 'v2', 'v3' ] }
 
 
+##
+# @Qcow2CompressionType:
+#
+# Compression type used in qcow2 image file
+#
+# @zlib     : gzip compressor
+# @zstd     : zstd compression
+#
+# Since: 4.1
+##
+{ 'enum': 'Qcow2CompressionType',
+  'data': [ 'zlib', 'zstd' ] }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #
@@ -4228,6 +4250,11 @@
 # @preallocation    Preallocation mode for the new image (default: off)
 # @lazy-refcounts   True if refcounts may be updated lazily (default: off)
 # @refcount-bits    Width of reference counts in bits (default: 16)
+# @compression-type Compression method used for image compressed clusters
+#                   (default: zlib(gzip), since 4.1).
+#                   Available types:
+#                       zlib
+#                       zstd
 #
 # Since: 2.12
 ##
@@ -4243,7 +4270,8 @@
             '*cluster-size':    'size',
             '*preallocation':   'PreallocMode',
             '*lazy-refcounts':  'bool',
-            '*refcount-bits':   'int' } }
+            '*refcount-bits':   'int',
+            '*compression-type': 'Qcow2CompressionType' } }
 
 ##
 # @BlockdevCreateOptionsQed:
-- 
2.17.0


