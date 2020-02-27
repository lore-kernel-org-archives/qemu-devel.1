Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9EDC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92C220714
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92C220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Dew-0002TS-0o
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 02:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7DcY-0000G1-Kd
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7DcW-0000Ah-IE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:30:10 -0500
Received: from relay.sw.ru ([185.231.240.75]:33982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7DcU-00005f-Le; Thu, 27 Feb 2020 02:30:07 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7DcO-0003Tx-AU; Thu, 27 Feb 2020 10:30:00 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/8] qcow2: introduce compression type feature
Date: Thu, 27 Feb 2020 10:29:46 +0300
Message-Id: <20200227072953.25445-2-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 den@vrtuozzo.com, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch adds some preparation parts for incompatible compression type
feature to Qcow2 that indicates which allow to use different compression
methods for image clusters (de)compressing.

It is implied that the compression type is set on the image creation and
can be changed only later by image conversion, thus compression type
defines the only compression algorithm used for the image, and thus,
for all image clusters.

The goal of the feature is to add support of other compression methods
to qcow2. For example, ZSTD which is more effective on compression than ZLIB.

The default compression is ZLIB. Images created with ZLIB compression type
are backward compatible with older qemu versions.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/qcow2.c             | 105 ++++++++++++++++++++++++++++++++++++++
 block/qcow2.h             |  31 ++++++++---
 include/block/block_int.h |   1 +
 qapi/block-core.json      |  22 +++++++-
 4 files changed, 150 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3c754f616b..2ccb2cabd1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1242,6 +1242,50 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
     return ret;
 }
 
+static int validate_compression_type(BDRVQcow2State *s, Error **errp)
+{
+    /*
+     * Sanity check
+     * according to qcow2 spec, the compression type is 1-byte field
+     * but in BDRVQcow2State the compression_type is enum sizeof(int)
+     * so, the max compression_type value is 255.
+     */
+    if (s->compression_type > 0xff) {
+        error_setg(errp, "qcow2: compression type value is too big");
+        return -EINVAL;
+    }
+
+    switch (s->compression_type) {
+    case QCOW2_COMPRESSION_TYPE_ZLIB:
+        break;
+
+    default:
+        error_setg(errp, "qcow2: unknown compression type: %u",
+                   s->compression_type);
+        return -ENOTSUP;
+    }
+
+    /*
+     * if the compression type differs from QCOW2_COMPRESSION_TYPE_ZLIB
+     * the incompatible feature flag must be set
+     */
+    if (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB) {
+        if (s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE) {
+            error_setg(errp, "qcow2: Compression type incompatible feature "
+                             "bit must not be set");
+            return -EINVAL;
+        }
+    } else {
+        if (!(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE)) {
+            error_setg(errp, "qcow2: Compression type incompatible feature "
+                             "bit must be set");
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
 /* Called with s->lock held.  */
 static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
                                       int flags, Error **errp)
@@ -1357,6 +1401,26 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     s->compatible_features      = header.compatible_features;
     s->autoclear_features       = header.autoclear_features;
 
+    /*
+     * Handle compression type
+     * Older qcow2 images don't contain the compression type header.
+     * Distinguish them by the header length and use
+     * the only valid (default) compression type in that case
+     */
+    if (header.header_length > offsetof(QCowHeader, compression_type)) {
+        /*
+         * don't deal with endians since compression_type is 1 byte long
+         */
+        s->compression_type = header.compression_type;
+    } else {
+        s->compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
+    }
+
+    ret = validate_compression_type(s, errp);
+    if (ret) {
+        goto fail;
+    }
+
     if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
         void *feature_table = NULL;
         qcow2_read_extensions(bs, header.header_length, ext_end,
@@ -2720,6 +2784,12 @@ int qcow2_update_header(BlockDriverState *bs)
     total_size = bs->total_sectors * BDRV_SECTOR_SIZE;
     refcount_table_clusters = s->refcount_table_size >> (s->cluster_bits - 3);
 
+    ret = validate_compression_type(s, NULL);
+
+    if (ret) {
+        goto fail;
+    }
+
     *header = (QCowHeader) {
         /* Version 2 fields */
         .magic                  = cpu_to_be32(QCOW_MAGIC),
@@ -2742,6 +2812,7 @@ int qcow2_update_header(BlockDriverState *bs)
         .autoclear_features     = cpu_to_be64(s->autoclear_features),
         .refcount_order         = cpu_to_be32(s->refcount_order),
         .header_length          = cpu_to_be32(header_length),
+        .compression_type       = (uint8_t) s->compression_type,
     };
 
     /* For older versions, write a shorter header */
@@ -2839,6 +2910,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3401,6 +3477,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         .refcount_table_offset      = cpu_to_be64(cluster_size),
         .refcount_table_clusters    = cpu_to_be32(1),
         .refcount_order             = cpu_to_be32(refcount_order),
+        .compression_type           = (uint8_t) QCOW2_COMPRESSION_TYPE_ZLIB,
         .header_length              = cpu_to_be32(sizeof(*header)),
     };
 
@@ -3420,6 +3497,26 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
     }
 
+    if (qcow2_opts->has_compression_type &&
+        qcow2_opts->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
+
+        if (qcow2_opts->compression_type > 0xff) {
+            error_setg_errno(errp, -EINVAL, "Too big compression type value");
+            goto out;
+        }
+
+        switch (qcow2_opts->compression_type) {
+        default:
+            error_setg_errno(errp, -EINVAL, "Unknown compression type");
+            goto out;
+        }
+
+        header->compression_type = (uint8_t) qcow2_opts->compression_type;
+
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_COMPRESSION_TYPE);
+    }
+
     ret = blk_pwrite(blk, 0, header, cluster_size, 0);
     g_free(header);
     if (ret < 0) {
@@ -3602,6 +3699,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
         { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
+        { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
         { NULL, NULL },
     };
 
@@ -4859,6 +4957,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
             .data_file          = g_strdup(s->image_data_file),
             .has_data_file_raw  = has_data_file(bs),
             .data_file_raw      = data_file_is_raw(bs),
+            .compression_type   = s->compression_type,
         };
     } else {
         /* if this assertion fails, this probably means a new version was
@@ -5516,6 +5615,12 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Width of a reference count entry in bits",
             .def_value_str = "16"
         },
+        {
+            .name = BLOCK_OPT_COMPRESSION_TYPE,
+            .type = QEMU_OPT_STRING,
+            .help = "Compression method used for image clusters compression",
+            .def_value_str = "zlib"
+        },
         { /* end of list */ }
     }
 };
diff --git a/block/qcow2.h b/block/qcow2.h
index 0942126232..f92412ed5e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -146,6 +146,12 @@ typedef struct QCowHeader {
 
     uint32_t refcount_order;
     uint32_t header_length;
+
+    /* Additional fields */
+    uint8_t  compression_type;
+
+    /* header must be a multiple of 8 */
+    uint8_t  padding[7];
 } QEMU_PACKED QCowHeader;
 
 typedef struct QEMU_PACKED QCowSnapshotHeader {
@@ -213,16 +219,20 @@ enum {
 
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
@@ -369,6 +379,13 @@ typedef struct BDRVQcow2State {
 
     bool metadata_preallocation_checked;
     bool metadata_preallocation;
+    /*
+     * Compression type used for the image. Default: 0 - ZLIB
+     * The image compression type is set on image creation.
+     * The only way to change the compression type is to convert the image
+     * with the desired compression type set
+     */
+    Qcow2CompressionType compression_type;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6f9fd5e20e..2c6bb9dc99 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -57,6 +57,7 @@
 #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
 #define BLOCK_OPT_DATA_FILE         "data_file"
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
+#define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 85e27bb61f..873fbef3b5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -78,6 +78,8 @@
 #
 # @bitmaps: A list of qcow2 bitmap details (since 4.0)
 #
+# @compression-type: the image cluster compression method (since 5.0)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -89,7 +91,8 @@
       '*corrupt': 'bool',
       'refcount-bits': 'int',
       '*encrypt': 'ImageInfoSpecificQCow2Encryption',
-      '*bitmaps': ['Qcow2BitmapInfo']
+      '*bitmaps': ['Qcow2BitmapInfo'],
+      'compression-type': 'Qcow2CompressionType'
   } }
 
 ##
@@ -4392,6 +4395,18 @@
   'data': [ 'v2', 'v3' ] }
 
 
+##
+# @Qcow2CompressionType:
+#
+# Compression type used in qcow2 image file
+#
+# @zlib:  zlib compression, see <http://zlib.net/>
+#
+# Since: 5.0
+##
+{ 'enum': 'Qcow2CompressionType',
+  'data': [ 'zlib' ] }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #
@@ -4415,6 +4430,8 @@
 #                 allowed values: off, falloc, full, metadata)
 # @lazy-refcounts: True if refcounts may be updated lazily (default: off)
 # @refcount-bits: Width of reference counts in bits (default: 16)
+# @compression-type: The image cluster compression method
+#                    (default: zlib, since 5.0)
 #
 # Since: 2.12
 ##
@@ -4430,7 +4447,8 @@
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


