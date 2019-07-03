Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977AC4646D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9698218A6
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9698218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hid3j-0003q1-1F
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 07:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59782)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hid0t-0000WJ-6X
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hid0q-0004WU-Kf
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:01:22 -0400
Received: from relay.sw.ru ([185.231.240.75]:59420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hid0V-0003p7-Ty; Wed, 03 Jul 2019 07:01:00 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hid0P-0004EW-9Y; Wed, 03 Jul 2019 14:00:53 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com
Date: Wed,  3 Jul 2019 14:00:42 +0300
Message-Id: <20190703110044.25610-2-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v1 1/3] qcow2: introduce compression type
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
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
 block/qcow2.c             | 94 +++++++++++++++++++++++++++++++++++++++
 block/qcow2.h             | 26 ++++++++---
 docs/interop/qcow2.txt    | 22 ++++++++-
 include/block/block_int.h |  1 +
 qapi/block-core.json      | 22 ++++++++-
 5 files changed, 155 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3ace3b2209..921eb67b80 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1202,6 +1202,47 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
     return ret;
 }
 
+static int check_compression_type(BDRVQcow2State *s, Error **errp)
+{
+    bool is_set;
+    int ret = 0;
+
+    switch (s->compression_type) {
+    case QCOW2_COMPRESSION_TYPE_ZLIB:
+        break;
+
+    default:
+        if (errp) {
+            error_setg(errp, "qcow2: unknown compression type: %u",
+                       s->compression_type);
+            return -ENOTSUP;
+        }
+    }
+
+    /*
+     * with QCOW2_COMPRESSION_TYPE_ZLIB the corresponding incompatible
+     * feature flag must be absent, with other compression types the
+     * incompatible feature flag must be set
+     */
+    is_set = s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE;
+
+    if (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB) {
+        if (is_set) {
+            ret = -EINVAL;
+        }
+    } else {
+        if (!is_set) {
+            ret = -EINVAL;
+        }
+    }
+
+    if (ret && errp) {
+        error_setg(errp, "qcow2: Illegal compression type setting");
+    }
+
+    return ret;
+}
+
 /* Called with s->lock held.  */
 static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
                                       int flags, Error **errp)
@@ -1318,6 +1359,24 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     s->compatible_features      = header.compatible_features;
     s->autoclear_features       = header.autoclear_features;
 
+    /* Handle compression type */
+    if (header.header_length > 104) {
+        header.compression_type = be32_to_cpu(header.compression_type);
+        s->compression_type = header.compression_type;
+    } else {
+        /*
+         * older qcow2 images don't contain the compression type header
+         * field, distinguish them by the header length and use
+         * the only valid compression type in that case
+         */
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
@@ -2434,6 +2493,13 @@ int qcow2_update_header(BlockDriverState *bs)
     total_size = bs->total_sectors * BDRV_SECTOR_SIZE;
     refcount_table_clusters = s->refcount_table_size >> (s->cluster_bits - 3);
 
+    ret = check_compression_type(s, NULL);
+
+    if (ret) {
+        goto fail;
+    }
+
+
     *header = (QCowHeader) {
         /* Version 2 fields */
         .magic                  = cpu_to_be32(QCOW_MAGIC),
@@ -2456,6 +2522,7 @@ int qcow2_update_header(BlockDriverState *bs)
         .autoclear_features     = cpu_to_be64(s->autoclear_features),
         .refcount_order         = cpu_to_be32(s->refcount_order),
         .header_length          = cpu_to_be32(header_length),
+        .compression_type       = cpu_to_be32(s->compression_type),
     };
 
     /* For older versions, write a shorter header */
@@ -2553,6 +2620,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3107,6 +3179,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         .refcount_table_offset      = cpu_to_be64(cluster_size),
         .refcount_table_clusters    = cpu_to_be32(1),
         .refcount_order             = cpu_to_be32(refcount_order),
+        .compression_type           = cpu_to_be32(QCOW2_COMPRESSION_TYPE_ZLIB),
         .header_length              = cpu_to_be32(sizeof(*header)),
     };
 
@@ -3126,6 +3199,20 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
     }
 
+    if (qcow2_opts->has_compression_type &&
+        qcow2_opts->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
+
+        if (qcow2_opts->compression_type >= QCOW2_COMPRESSION_TYPE__MAX) {
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
@@ -3307,6 +3394,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
         { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
+        { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
         { NULL, NULL },
     };
 
@@ -5239,6 +5327,12 @@ static QemuOptsList qcow2_create_opts = {
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
index fdee297f33..b44344c78e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -135,6 +135,7 @@ typedef struct QCowHeader {
 
     uint32_t refcount_order;
     uint32_t header_length;
+    uint32_t compression_type;
 } QEMU_PACKED QCowHeader;
 
 typedef struct QEMU_PACKED QCowSnapshotHeader {
@@ -198,16 +199,20 @@ enum {
 
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
@@ -350,6 +355,13 @@ typedef struct BDRVQcow2State {
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
index af5711e533..5b8a8d15fe 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -109,7 +109,12 @@ in the description of a field.
                                 An External Data File Name header extension may
                                 be present if this bit is set.
 
-                    Bits 3-63:  Reserved (set to 0)
+                    Bit 3:      Compression type bit. The bit must be set if
+                                the compression type differs from default: zlib.
+                                If the compression type is default the bit must
+                                be unset.
+
+                    Bits 4-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -165,6 +170,21 @@ in the description of a field.
                     Length of the header structure in bytes. For version 2
                     images, the length is always assumed to be 72 bytes.
 
+        104 - 107:  compression_type
+                    Defines the compression method used for compressed clusters.
+                    A single compression type is applied to all compressed image
+                    clusters.
+                    The compression type is set on image creation only.
+                    The default compression type is zlib.
+                    When the deafult compression type is used the compression
+                    type bit (incompatible feature bit 3) must be unset.
+                    When any other compression type is used the compression
+                    type bit must be set.
+                    Qemu versions older than 4.1 can use images created with
+                    the default compression type without any additional
+                    preparations and cannot use images created with any other
+                    compression type.
+
 Directly after the image header, optional sections called header extensions can
 be stored. Each extension has a structure like the following:
 
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
index 7ccbfff9d0..6aa8b99993 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -78,6 +78,8 @@
 #
 # @bitmaps: A list of qcow2 bitmap details (since 4.0)
 #
+# @compression-type: the image cluster compression method (since 4.1)
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
+      '*compression-type': 'Qcow2CompressionType'
   } }
 
 ##
@@ -4206,6 +4209,18 @@
   'data': [ 'v2', 'v3' ] }
 
 
+##
+# @Qcow2CompressionType:
+#
+# Compression type used in qcow2 image file
+#
+# @zlib:  zlib compression, see <http://zlib.net/>
+#
+# Since: 4.1
+##
+{ 'enum': 'Qcow2CompressionType',
+  'data': [ 'zlib' ] }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #
@@ -4228,6 +4243,8 @@
 # @preallocation    Preallocation mode for the new image (default: off)
 # @lazy-refcounts   True if refcounts may be updated lazily (default: off)
 # @refcount-bits    Width of reference counts in bits (default: 16)
+# @compression-type The image cluster compression method
+#                   (default: zlib, since 4.1)
 #
 # Since: 2.12
 ##
@@ -4243,7 +4260,8 @@
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


