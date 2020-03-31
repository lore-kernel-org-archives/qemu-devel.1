Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6638DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BF72072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BF72072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDGA-0007u2-4s
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJDEI-0005sf-RI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJDED-00073Y-EN
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:30:42 -0400
Received: from relay.sw.ru ([185.231.240.75]:37720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJDEC-0006zg-Tr; Tue, 31 Mar 2020 05:30:37 -0400
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJDE4-0000Rx-Jr; Tue, 31 Mar 2020 12:30:28 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 1/4] qcow2: introduce compression type feature
Date: Tue, 31 Mar 2020 12:30:18 +0300
Message-Id: <20200331093021.22285-2-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200331093021.22285-1-dplotnikov@virtuozzo.com>
References: <20200331093021.22285-1-dplotnikov@virtuozzo.com>
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

The patch adds some preparation parts for incompatible compression type
feature to qcow2 allowing the use different compression methods for
image clusters (de)compressing.

It is implied that the compression type is set on the image creation and
can be changed only later by image conversion, thus compression type
defines the only compression algorithm used for the image, and thus,
for all image clusters.

The goal of the feature is to add support of other compression methods
to qcow2. For example, ZSTD which is more effective on compression than ZLIB.

The default compression is ZLIB. Images created with ZLIB compression type
are backward compatible with older qemu versions.

Adding of the compression type breaks a number of tests because now the
compression type is reported on image creation and there are some changes
in the qcow2 header in size and offsets.

The tests are fixed in the following ways:
    * filter out compression_type for many tests
    * fix header size, feature table size and backing file offset
      affected tests: 031, 036, 061, 080
      header_size +=8: 1 byte compression type
                       7 bytes padding
      feature_table += 48: incompatible feature compression type
      backing_file_offset += 56 (8 + 48 -> header_change + feature_table_change)
    * add "compression type" for test output matching when it isn't filtered
      affected tests: 049, 060, 061, 065, 144, 182, 242, 255

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
QAPI part:
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json             |  22 +++++-
 block/qcow2.h                    |  20 +++++-
 include/block/block_int.h        |   1 +
 block/qcow2.c                    | 113 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/031.out       |  14 ++--
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 ++++++++++++++--------------
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061.out       |  34 ++++++----
 tests/qemu-iotests/065           |  28 +++++---
 tests/qemu-iotests/080           |   2 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/242.out       |   5 ++
 tests/qemu-iotests/255.out       |   8 +--
 tests/qemu-iotests/common.filter |   3 +-
 16 files changed, 267 insertions(+), 96 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 943df1926a..d669ec0965 100644
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
@@ -4284,6 +4287,18 @@
   'data': [ 'v2', 'v3' ] }
 
 
+##
+# @Qcow2CompressionType:
+#
+# Compression type used in qcow2 image file
+#
+# @zlib: zlib compression, see <http://zlib.net/>
+#
+# Since: 5.0
+##
+{ 'enum': 'Qcow2CompressionType',
+  'data': [ 'zlib' ] }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #
@@ -4307,6 +4322,8 @@
 #                 allowed values: off, falloc, full, metadata)
 # @lazy-refcounts: True if refcounts may be updated lazily (default: off)
 # @refcount-bits: Width of reference counts in bits (default: 16)
+# @compression-type: The image cluster compression method
+#                    (default: zlib, since 5.0)
 #
 # Since: 2.12
 ##
@@ -4322,7 +4339,8 @@
             '*cluster-size':    'size',
             '*preallocation':   'PreallocMode',
             '*lazy-refcounts':  'bool',
-            '*refcount-bits':   'int' } }
+            '*refcount-bits':   'int',
+            '*compression-type':'Qcow2CompressionType' } }
 
 ##
 # @BlockdevCreateOptionsQed:
diff --git a/block/qcow2.h b/block/qcow2.h
index f4de0a27d5..6a8b82e6cc 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -146,8 +146,16 @@ typedef struct QCowHeader {
 
     uint32_t refcount_order;
     uint32_t header_length;
+
+    /* Additional fields */
+    uint8_t compression_type;
+
+    /* header must be a multiple of 8 */
+    uint8_t padding[7];
 } QEMU_PACKED QCowHeader;
 
+QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(sizeof(QCowHeader), 8));
+
 typedef struct QEMU_PACKED QCowSnapshotHeader {
     /* header is 8 byte aligned */
     uint64_t l1_table_offset;
@@ -216,13 +224,16 @@ enum {
     QCOW2_INCOMPAT_DIRTY_BITNR      = 0,
     QCOW2_INCOMPAT_CORRUPT_BITNR    = 1,
     QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
+    QCOW2_INCOMPAT_COMPRESSION_BITNR = 3,
     QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
     QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
     QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
+    QCOW2_INCOMPAT_COMPRESSION      = 1 << QCOW2_INCOMPAT_COMPRESSION_BITNR,
 
     QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
                                     | QCOW2_INCOMPAT_CORRUPT
-                                    | QCOW2_INCOMPAT_DATA_FILE,
+                                    | QCOW2_INCOMPAT_DATA_FILE
+                                    | QCOW2_INCOMPAT_COMPRESSION,
 };
 
 /* Compatible feature bits */
@@ -366,6 +377,13 @@ typedef struct BDRVQcow2State {
 
     bool metadata_preallocation_checked;
     bool metadata_preallocation;
+    /*
+     * Compression type used for the image. Default: 0 - ZLIB
+     * The image compression type is set on image creation.
+     * For now, the only way to change the compression type
+     * is to convert the image with the desired compression type set.
+     */
+    Qcow2CompressionType compression_type;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4c3587ea19..bc91b69f46 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -57,6 +57,7 @@
 #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
 #define BLOCK_OPT_DATA_FILE         "data_file"
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
+#define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 2bb536b014..6cb000be19 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1242,6 +1242,39 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
     return ret;
 }
 
+static int validate_compression_type(BDRVQcow2State *s, Error **errp)
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
+    if (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB) {
+        if (s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION) {
+            error_setg(errp, "qcow2: Compression type incompatible feature "
+                             "bit must not be set");
+            return -EINVAL;
+        }
+    } else {
+        if (!(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION)) {
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
@@ -1357,6 +1390,23 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     s->compatible_features      = header.compatible_features;
     s->autoclear_features       = header.autoclear_features;
 
+    /*
+     * Handle compression type
+     * Older qcow2 images don't contain the compression type header.
+     * Distinguish them by the header length and use
+     * the only valid (default) compression type in that case
+     */
+    if (header.header_length > offsetof(QCowHeader, compression_type)) {
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
@@ -2727,6 +2777,11 @@ int qcow2_update_header(BlockDriverState *bs)
     total_size = bs->total_sectors * BDRV_SECTOR_SIZE;
     refcount_table_clusters = s->refcount_table_size >> (s->cluster_bits - 3);
 
+    ret = validate_compression_type(s, NULL);
+    if (ret) {
+        goto fail;
+    }
+
     *header = (QCowHeader) {
         /* Version 2 fields */
         .magic                  = cpu_to_be32(QCOW_MAGIC),
@@ -2749,6 +2804,7 @@ int qcow2_update_header(BlockDriverState *bs)
         .autoclear_features     = cpu_to_be64(s->autoclear_features),
         .refcount_order         = cpu_to_be32(s->refcount_order),
         .header_length          = cpu_to_be32(header_length),
+        .compression_type       = s->compression_type,
     };
 
     /* For older versions, write a shorter header */
@@ -2848,6 +2904,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  = QCOW2_INCOMPAT_DATA_FILE_BITNR,
                 .name = "external data file",
             },
+            {
+                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
+                .bit  = QCOW2_INCOMPAT_COMPRESSION_BITNR,
+                .name = "compression type",
+            },
             {
                 .type = QCOW2_FEAT_TYPE_COMPATIBLE,
                 .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
@@ -3286,6 +3347,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     uint64_t* refcount_table;
     Error *local_err = NULL;
     int ret;
+    uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
@@ -3403,6 +3465,27 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         }
     }
 
+    if (qcow2_opts->has_compression_type &&
+        qcow2_opts->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
+
+        ret = -EINVAL;
+
+        if (version < 3) {
+            error_setg(errp, "Non-zlib compression type is only supported with "
+                       "compatibility level 1.1 and above (use version=v3 or "
+                       "greater)");
+            goto out;
+        }
+
+        switch (qcow2_opts->compression_type) {
+        default:
+            error_setg(errp, "Unknown compression type");
+            goto out;
+        }
+
+        compression_type = qcow2_opts->compression_type;
+    }
+
     /* Create BlockBackend to write to the image */
     blk = blk_new(bdrv_get_aio_context(bs),
                   BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
@@ -3425,6 +3508,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         .refcount_table_offset      = cpu_to_be64(cluster_size),
         .refcount_table_clusters    = cpu_to_be32(1),
         .refcount_order             = cpu_to_be32(refcount_order),
+        /* don't deal with endianness since compression_type is 1 byte long */
+        .compression_type           = compression_type,
         .header_length              = cpu_to_be32(sizeof(*header)),
     };
 
@@ -3443,6 +3528,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         header->autoclear_features |=
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
     }
+    if (compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_COMPRESSION);
+    }
 
     ret = blk_pwrite(blk, 0, header, cluster_size, 0);
     g_free(header);
@@ -3628,6 +3717,7 @@ static int coroutine_fn qcow2_co_create_opts(BlockDriver *drv,
         { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
+        { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
         { NULL, NULL },
     };
 
@@ -4850,6 +4940,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
             .data_file          = g_strdup(s->image_data_file),
             .has_data_file_raw  = has_data_file(bs),
             .data_file_raw      = data_file_is_raw(bs),
+            .compression_type   = s->compression_type,
         };
     } else {
         /* if this assertion fails, this probably means a new version was
@@ -5239,6 +5330,22 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                                  "images");
                 return -EINVAL;
             }
+        } else if (!strcmp(desc->name, BLOCK_OPT_COMPRESSION_TYPE)) {
+            const char *ct_name =
+                qemu_opt_get(opts, BLOCK_OPT_COMPRESSION_TYPE);
+            int compression_type =
+                qapi_enum_parse(&Qcow2CompressionType_lookup, ct_name, -1,
+                                NULL);
+            if (compression_type == -1) {
+                error_setg(errp, "Unknown compression type: %s", ct_name);
+                return -ENOTSUP;
+            }
+
+            if (compression_type != s->compression_type) {
+                error_setg(errp, "Changing the compression type "
+                                 "is not supported");
+                return -ENOTSUP;
+            }
         } else {
             /* if this point is reached, this probably means a new option was
              * added without having it covered here */
@@ -5507,6 +5614,12 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Width of a reference count entry in bits",
             .def_value_str = "16"
         },
+        {
+            .name = BLOCK_OPT_COMPRESSION_TYPE,
+            .type = QEMU_OPT_STRING,
+            .help = "Compression method used for image cluster compression",
+            .def_value_str = "zlib"
+        },
         { /* end of list */ }
     }
 };
diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 46f97c5a4e..5a4beda6a2 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -113,11 +113,11 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 Header extension:
@@ -146,11 +146,11 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 Header extension:
@@ -164,7 +164,7 @@ No errors were found on the image.
 
 magic                     0x514649fb
 version                   3
-backing_file_offset       0x1d8
+backing_file_offset       0x210
 backing_file_size         0x17
 cluster_bits              16
 size                      67108864
@@ -179,7 +179,7 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0xe2792aca
@@ -188,7 +188,7 @@ data                      'host_device'
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 Header extension:
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index 23b699ce06..e409acf60e 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -26,7 +26,7 @@ compatible_features       []
 autoclear_features        [63]
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 
@@ -38,7 +38,7 @@ compatible_features       []
 autoclear_features        []
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 *** done
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index affa55b341..a5cfba1756 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -4,90 +4,90 @@ QA output created by 049
 == 1. Traditional size parameter ==
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024b
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1k
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1K
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1G
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1T
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0b
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5k
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5K
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5G
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5T
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 == 2. Specifying size via -o ==
 
 qemu-img create -f qcow2 -o size=1024 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1024b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1024.0 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1024.0b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1.5k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1.5K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1.5M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1.5G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o size=1.5T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 == 3. Invalid sizes ==
 
@@ -129,84 +129,84 @@ qemu-img: TEST_DIR/t.qcow2: The image size must be specified only once
 == Check correct interpretation of suffixes for cluster size ==
 
 qemu-img create -f qcow2 -o cluster_size=1024 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o cluster_size=1024b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o cluster_size=1k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o cluster_size=1K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o cluster_size=1M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1048576 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1048576 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o cluster_size=1024.0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o cluster_size=1024.0b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o cluster_size=0.5k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o cluster_size=0.5K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o cluster_size=0.5M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=524288 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=524288 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 == Check compat level option ==
 
 qemu-img create -f qcow2 -o compat=0.10 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o compat=1.1 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o compat=0.42 TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o compat=foobar TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 == Check preallocation option ==
 
 qemu-img create -f qcow2 -o preallocation=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=off lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=off lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o preallocation=metadata TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o preallocation=1234 TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=1234 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=1234 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 == Check encryption option ==
 
 qemu-img create -f qcow2 -o encryption=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 --object secret,id=sec0,data=123456 -o encryption=on,encrypt.key-secret=sec0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=on encrypt.key-secret=sec0 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=on encrypt.key-secret=sec0 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 == Check lazy_refcounts option (only with v3) ==
 
 qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=on TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=on refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=on TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=on refcount_bits=16 compression_type=zlib
 
 *** done
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index d27692a33c..3e47f537e8 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -17,6 +17,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     corrupt: true
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 413cc4e0f4..45c029228c 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -22,11 +22,11 @@ incompatible_features     []
 compatible_features       [0]
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 magic                     0x514649fb
@@ -80,11 +80,11 @@ incompatible_features     []
 compatible_features       [0]
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 magic                     0x514649fb
@@ -136,11 +136,11 @@ incompatible_features     [0]
 compatible_features       [0]
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 ERROR cluster 5 refcount=0 reference=1
@@ -191,11 +191,11 @@ incompatible_features     []
 compatible_features       [42]
 autoclear_features        [42]
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 magic                     0x514649fb
@@ -260,11 +260,11 @@ incompatible_features     []
 compatible_features       [0]
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 read 65536/65536 bytes at offset 44040192
@@ -294,11 +294,11 @@ incompatible_features     [0]
 compatible_features       [0]
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 ERROR cluster 5 refcount=0 reference=1
@@ -323,11 +323,11 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 read 131072/131072 bytes at offset 0
@@ -491,6 +491,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
@@ -511,6 +512,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file: foo
@@ -524,6 +526,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file raw: false
@@ -538,6 +541,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
@@ -550,6 +554,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
@@ -563,6 +568,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 6426474271..18dc488c7a 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -88,24 +88,30 @@ class TestQMP(TestImageInfoSpecific):
 class TestQCow2(TestQemuImgInfo):
     '''Testing a qcow2 version 2 image'''
     img_options = 'compat=0.10'
-    json_compare = { 'compat': '0.10', 'refcount-bits': 16 }
-    human_compare = [ 'compat: 0.10', 'refcount bits: 16' ]
+    json_compare = { 'compat': '0.10', 'refcount-bits': 16,
+                     'compression-type': 'zlib' }
+    human_compare = [ 'compat: 0.10', 'compression type: zlib',
+                      'refcount bits: 16' ]
 
 class TestQCow3NotLazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled'''
     img_options = 'compat=1.1,lazy_refcounts=off'
     json_compare = { 'compat': '1.1', 'lazy-refcounts': False,
-                     'refcount-bits': 16, 'corrupt': False }
-    human_compare = [ 'compat: 1.1', 'lazy refcounts: false',
-                      'refcount bits: 16', 'corrupt: false' ]
+                     'refcount-bits': 16, 'corrupt': False,
+                     'compression-type': 'zlib' }
+    human_compare = [ 'compat: 1.1', 'compression type: zlib',
+                      'lazy refcounts: false', 'refcount bits: 16',
+                      'corrupt: false' ]
 
 class TestQCow3Lazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts enabled'''
     img_options = 'compat=1.1,lazy_refcounts=on'
     json_compare = { 'compat': '1.1', 'lazy-refcounts': True,
-                     'refcount-bits': 16, 'corrupt': False }
-    human_compare = [ 'compat: 1.1', 'lazy refcounts: true',
-                      'refcount bits: 16', 'corrupt: false' ]
+                     'refcount-bits': 16, 'corrupt': False,
+                     'compression-type': 'zlib' }
+    human_compare = [ 'compat: 1.1', 'compression type: zlib',
+                      'lazy refcounts: true', 'refcount bits: 16',
+                      'corrupt: false' ]
 
 class TestQCow3NotLazyQMP(TestQMP):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled, opening
@@ -113,7 +119,8 @@ class TestQCow3NotLazyQMP(TestQMP):
     img_options = 'compat=1.1,lazy_refcounts=off'
     qemu_options = 'lazy-refcounts=on'
     compare = { 'compat': '1.1', 'lazy-refcounts': False,
-                'refcount-bits': 16, 'corrupt': False }
+                'refcount-bits': 16, 'corrupt': False,
+                'compression-type': 'zlib' }
 
 
 class TestQCow3LazyQMP(TestQMP):
@@ -122,7 +129,8 @@ class TestQCow3LazyQMP(TestQMP):
     img_options = 'compat=1.1,lazy_refcounts=on'
     qemu_options = 'lazy-refcounts=off'
     compare = { 'compat': '1.1', 'lazy-refcounts': True,
-                'refcount-bits': 16, 'corrupt': False }
+                'refcount-bits': 16, 'corrupt': False,
+                'compression-type': 'zlib' }
 
 TestImageInfoSpecific = None
 TestQemuImgInfo = None
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index a3d13c414e..7588c63b6c 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -45,7 +45,7 @@ _supported_os Linux
 # - This is generally a test for compat=1.1 images
 _unsupported_imgopts 'refcount_bits=1[^0-9]' data_file 'compat=0.10'
 
-header_size=104
+header_size=112
 
 offset_backing_file_offset=8
 offset_backing_file_size=16
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index c7aa2e4820..885a8874a5 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=536870912
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/tmp.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 
 === Performing block-commit on active layer ===
@@ -31,6 +31,6 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/
 === Performing Live Snapshot 2 ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/tmp2.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index a8eea166c3..ae43654d32 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -13,7 +13,7 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node0', 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
 {'execute': 'blockdev-snapshot-sync', 'arguments': { 'node-name': 'node0', 'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'snapshot-node-name': 'node1' } }
-Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node1', 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
index 7ac8404d11..091b9126ce 100644
--- a/tests/qemu-iotests/242.out
+++ b/tests/qemu-iotests/242.out
@@ -12,6 +12,7 @@ virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
@@ -32,6 +33,7 @@ virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     bitmaps:
         [0]:
@@ -64,6 +66,7 @@ virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     bitmaps:
         [0]:
@@ -104,6 +107,7 @@ virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     bitmaps:
         [0]:
@@ -153,6 +157,7 @@ virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     bitmaps:
         [0]:
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
index 348909fdef..a3c99fd62e 100644
--- a/tests/qemu-iotests/255.out
+++ b/tests/qemu-iotests/255.out
@@ -3,9 +3,9 @@ Finishing a commit job with background reads
 
 === Create backing chain and start VM ===
 
-Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 === Start background read requests ===
 
@@ -23,9 +23,9 @@ Closing the VM while a job is being cancelled
 
 === Create images and start VM ===
 
-Formatting 'TEST_DIR/PID-src.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-src.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-dst.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-dst.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 3f8ee3e5f7..279e0bbb0d 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -152,7 +152,8 @@ _filter_img_create()
         -e "s# refcount_bits=[0-9]\\+##g" \
         -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
         -e "s# iter-time=[0-9]\\+##g" \
-        -e "s# force_size=\\(on\\|off\\)##g"
+        -e "s# force_size=\\(on\\|off\\)##g" \
+        -e "s# compression_type=[a-zA-Z0-9]\\+##g"
 }
 
 _filter_img_info()
-- 
2.17.0


