Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AA5C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FD7208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FD7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5XHm-00007I-DD
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 11:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i5XDr-0005u2-On
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 11:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i5XDp-000312-L8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 11:29:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:60744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i5XDp-0002zs-9b; Wed, 04 Sep 2019 11:29:25 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i5XDm-0000Me-Or; Wed, 04 Sep 2019 18:29:22 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: armbru@redhat.com,
	qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 18:29:13 +0300
Message-Id: <20190904152915.30755-2-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190904152915.30755-1-dplotnikov@virtuozzo.com>
References: <20190904152915.30755-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v5 1/3] qcow2: introduce compression type
 feature
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
 qemu-block@nongnu.org, mreitz@redhat.com
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
It works roughly 2x faster than ZLIB providing a comparable compression ratio
and therefore provides a performance advantage in backup scenarios.

The default compression is ZLIB. Images created with ZLIB compression type
are backward compatible with older qemu versions.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/qcow2.c             | 91 +++++++++++++++++++++++++++++++++++++++
 block/qcow2.h             | 26 ++++++++---
 docs/interop/qcow2.txt    | 19 +++++++-
 include/block/block_int.h |  1 +
 qapi/block-core.json      | 22 +++++++++-
 5 files changed, 149 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 039bdc2f7e..2884b9d9f2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1197,6 +1197,32 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
     return ret;
 }
 
+static int check_compression_type(BDRVQcow2State *s, Error **errp)
+{
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
+
+    if (s->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB &&
+        !(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE)) {
+            error_setg(errp, "qcow2: Invalid compression type setting");
+            return -EINVAL;
+    }
+
+    return 0;
+}
+
 /* Called with s->lock held.  */
 static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
                                       int flags, Error **errp)
@@ -1312,6 +1338,35 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     s->compatible_features      = header.compatible_features;
     s->autoclear_features       = header.autoclear_features;
 
+    /*
+     * Handle compression type
+     * Older qcow2 images don't contain the compression type header.
+     * Distinguish them by the header length and use
+     * the only valid (default) compression type in that case
+     */
+    if (header.header_length > offsetof(QCowHeader, compression_type)) {
+        /* sanity check that we can read a compression type */
+        size_t min_len = offsetof(QCowHeader, compression_type) +
+                         sizeof(header.compression_type);
+        if (header.header_length < min_len) {
+            error_setg(errp,
+                       "Could not read compression type, "
+                       "qcow2 header is too short");
+            ret = -EINVAL;
+            goto fail;
+        }
+
+        header.compression_type = be32_to_cpu(header.compression_type);
+        s->compression_type = header.compression_type;
+    } else {
+        s->compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
+    }
+
+    ret = check_compression_type(s, errp);
+    if (ret) {
+        goto fail;
+    }
+
     if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
         void *feature_table = NULL;
         qcow2_read_extensions(bs, header.header_length, ext_end,
@@ -2516,6 +2571,12 @@ int qcow2_update_header(BlockDriverState *bs)
     total_size = bs->total_sectors * BDRV_SECTOR_SIZE;
     refcount_table_clusters = s->refcount_table_size >> (s->cluster_bits - 3);
 
+    ret = check_compression_type(s, NULL);
+
+    if (ret) {
+        goto fail;
+    }
+
     *header = (QCowHeader) {
         /* Version 2 fields */
         .magic                  = cpu_to_be32(QCOW_MAGIC),
@@ -2538,6 +2599,7 @@ int qcow2_update_header(BlockDriverState *bs)
         .autoclear_features     = cpu_to_be64(s->autoclear_features),
         .refcount_order         = cpu_to_be32(s->refcount_order),
         .header_length          = cpu_to_be32(header_length),
+        .compression_type       = cpu_to_be32(s->compression_type),
     };
 
     /* For older versions, write a shorter header */
@@ -2635,6 +2697,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3202,6 +3269,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         .refcount_table_offset      = cpu_to_be64(cluster_size),
         .refcount_table_clusters    = cpu_to_be32(1),
         .refcount_order             = cpu_to_be32(refcount_order),
+        .compression_type           = cpu_to_be32(QCOW2_COMPRESSION_TYPE_ZLIB),
         .header_length              = cpu_to_be32(sizeof(*header)),
     };
 
@@ -3221,6 +3289,21 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
     }
 
+    if (qcow2_opts->has_compression_type &&
+        qcow2_opts->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
+
+        switch (qcow2_opts->compression_type) {
+        default:
+            error_setg_errno(errp, -EINVAL, "Unknown compression type");
+            goto out;
+        }
+
+        header->compression_type = cpu_to_be32(qcow2_opts->compression_type);
+
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_COMPRESSION_TYPE);
+    }
+
     ret = blk_pwrite(blk, 0, header, cluster_size, 0);
     g_free(header);
     if (ret < 0) {
@@ -3402,6 +3485,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
         { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
+        { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
         { NULL, NULL },
     };
 
@@ -4598,6 +4682,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
             .data_file          = g_strdup(s->image_data_file),
             .has_data_file_raw  = has_data_file(bs),
             .data_file_raw      = data_file_is_raw(bs),
+            .compression_type   = s->compression_type,
         };
     } else {
         /* if this assertion fails, this probably means a new version was
@@ -5163,6 +5248,12 @@ static QemuOptsList qcow2_create_opts = {
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
index fc1b0d3c1e..659e4f852a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -140,6 +140,7 @@ typedef struct QCowHeader {
 
     uint32_t refcount_order;
     uint32_t header_length;
+    uint32_t compression_type;
 } QEMU_PACKED QCowHeader;
 
 typedef struct QEMU_PACKED QCowSnapshotHeader {
@@ -203,16 +204,20 @@ enum {
 
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
@@ -359,6 +364,13 @@ typedef struct BDRVQcow2State {
 
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
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index af5711e533..e1be8bd5c3 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -109,7 +109,12 @@ in the description of a field.
                                 An External Data File Name header extension may
                                 be present if this bit is set.
 
-                    Bits 3-63:  Reserved (set to 0)
+                    Bit 3:      Compression type bit. The bit must be set if
+                                the compression type differs from default of zlib.
+                                If the compression type is default the bit should
+                                be unset.
+
+                    Bits 4-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -165,6 +170,18 @@ in the description of a field.
                     Length of the header structure in bytes. For version 2
                     images, the length is always assumed to be 72 bytes.
 
+        104 - 107:  compression_type
+                    Defines the compression method used for compressed clusters.
+                    A single compression type is applied to all compressed image
+                    clusters.
+                    The compression type is set on image creation only.
+                    The default compression type is zlib (value: 0).
+                    When the compression type differs from the default
+                    the compression type bit (incompatible feature bit 3)
+                    must be set.
+                    Available compression type values:
+                        0: zlib <https://www.zlib.net/> (default)
+
 Directly after the image header, optional sections called header extensions can
 be stored. Each extension has a structure like the following:
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3aa1e832a8..4b254802e5 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -58,6 +58,7 @@
 #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
 #define BLOCK_OPT_DATA_FILE         "data_file"
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
+#define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..2c002ca6a9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -78,6 +78,8 @@
 #
 # @bitmaps: A list of qcow2 bitmap details (since 4.0)
 #
+# @compression-type: the image cluster compression method (since 4.2)
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
@@ -4274,6 +4277,18 @@
   'data': [ 'v2', 'v3' ] }
 
 
+##
+# @Qcow2CompressionType:
+#
+# Compression type used in qcow2 image file
+#
+# @zlib:  zlib compression, see <http://zlib.net/>
+#
+# Since: 4.2
+##
+{ 'enum': 'Qcow2CompressionType',
+  'data': [ 'zlib' ] }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #
@@ -4297,6 +4312,8 @@
 #                   allowed values: off, falloc, full, metadata)
 # @lazy-refcounts   True if refcounts may be updated lazily (default: off)
 # @refcount-bits    Width of reference counts in bits (default: 16)
+# @compression-type The image cluster compression method
+#                   (default: zlib, since 4.2)
 #
 # Since: 2.12
 ##
@@ -4312,7 +4329,8 @@
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


