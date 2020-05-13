Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952D3C2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CDA5204EF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwA+gpb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDA5204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYsD0-00084b-9u
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYsB1-0004pl-KL
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:16:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYsAv-0006FJ-5z
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589379356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+YGjxGrRCAu96fVyDe9X7RBZE5bnJTHN/ysK1r6fu4=;
 b=FwA+gpb6+Kr9k1OLfaTk6l9FuOjXGwKFZ4ZP210FScwgyrkeJfxMduCNTACnRupg5bLfx7
 gID+lJjA09WlwmVAwfK6fvxI72/p6cdLBm5+NzApmzGxaiv83iZPp0ZzVK/0R2dRam6fDl
 jpgNaHu0P1SQYyoUUkNllQmmLNbzMNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-7RQT6nw9MkqFmi8MYpX5jw-1; Wed, 13 May 2020 10:15:51 -0400
X-MC-Unique: 7RQT6nw9MkqFmi8MYpX5jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8089A18FF661;
 Wed, 13 May 2020 14:15:50 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4456260C87;
 Wed, 13 May 2020 14:15:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/5] qcow2: introduce compression type feature
Date: Wed, 13 May 2020 16:15:40 +0200
Message-Id: <20200513141544.1459069-2-mreitz@redhat.com>
In-Reply-To: <20200513141544.1459069-1-mreitz@redhat.com>
References: <20200513141544.1459069-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:05:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

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
      affected tests: 049, 060, 061, 065, 082, 085, 144, 182, 185, 198, 206,
                      242, 255, 274, 280

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
QAPI part:
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200507082521.29210-2-dplotnikov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
 tests/qemu-iotests/082.out       |  48 +++++++++++--
 tests/qemu-iotests/085.out       |  38 +++++------
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +--
 tests/qemu-iotests/198.out       |   2 +
 tests/qemu-iotests/206.out       |   5 ++
 tests/qemu-iotests/242.out       |   5 ++
 tests/qemu-iotests/255.out       |   8 +--
 tests/qemu-iotests/274.out       |  49 +++++++-------
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/common.filter |   3 +-
 23 files changed, 365 insertions(+), 150 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 943df1926a..1522e2983f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -78,6 +78,8 @@
 #
 # @bitmaps: A list of qcow2 bitmap details (since 4.0)
 #
+# @compression-type: the image cluster compression method (since 5.1)
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
+# Since: 5.1
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
+#                    (default: zlib, since 5.1)
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
index df6d0273d6..7ba8c89036 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -57,6 +57,7 @@
 #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
 #define BLOCK_OPT_DATA_FILE         "data_file"
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
+#define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 1ad95ff048..b878a6a474 100644
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
@@ -2728,6 +2778,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -2750,6 +2805,7 @@ int qcow2_update_header(BlockDriverState *bs)
         .autoclear_features     = cpu_to_be64(s->autoclear_features),
         .refcount_order         = cpu_to_be32(s->refcount_order),
         .header_length          = cpu_to_be32(header_length),
+        .compression_type       = s->compression_type,
     };
 
     /* For older versions, write a shorter header */
@@ -2849,6 +2905,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3287,6 +3348,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     uint64_t* refcount_table;
     Error *local_err = NULL;
     int ret;
+    uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
@@ -3404,6 +3466,27 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
     blk = blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL,
                           errp);
@@ -3426,6 +3509,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         .refcount_table_offset      = cpu_to_be64(cluster_size),
         .refcount_table_clusters    = cpu_to_be32(1),
         .refcount_order             = cpu_to_be32(refcount_order),
+        /* don't deal with endianness since compression_type is 1 byte long */
+        .compression_type           = compression_type,
         .header_length              = cpu_to_be32(sizeof(*header)),
     };
 
@@ -3444,6 +3529,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         header->autoclear_features |=
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
     }
+    if (compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_COMPRESSION);
+    }
 
     ret = blk_pwrite(blk, 0, header, cluster_size, 0);
     g_free(header);
@@ -3629,6 +3718,7 @@ static int coroutine_fn qcow2_co_create_opts(BlockDriver *drv,
         { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
+        { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
         { NULL, NULL },
     };
 
@@ -4925,6 +5015,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
             .data_file          = g_strdup(s->image_data_file),
             .has_data_file_raw  = has_data_file(bs),
             .data_file_raw      = data_file_is_raw(bs),
+            .compression_type   = s->compression_type,
         };
     } else {
         /* if this assertion fails, this probably means a new version was
@@ -5330,6 +5421,22 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
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
@@ -5596,6 +5703,12 @@ static QemuOptsList qcow2_create_opts = {
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
index 09caaea865..be5f8707a3 100644
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
index 5a8d36d005..a51ad1b5ba 100644
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
@@ -322,11 +322,11 @@ incompatible_features     [0]
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
@@ -351,11 +351,11 @@ incompatible_features     []
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
@@ -519,6 +519,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
@@ -539,6 +540,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file: foo
@@ -552,6 +554,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file raw: false
@@ -566,6 +569,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
@@ -578,6 +582,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
@@ -591,6 +596,7 @@ virtual size: 64 MiB (67108864 bytes)
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
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 9d4ed4dc9d..529a1214e1 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -3,38 +3,40 @@ QA output created by 082
 === create: Options specified more than once ===
 
 Testing: create -f foo -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 
 Testing: create -f qcow2 -o cluster_size=4k -o lazy_refcounts=on TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=4096 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=4096 lazy_refcounts=on refcount_bits=16 compression_type=zlib
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 4096
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
 
 Testing: create -f qcow2 -o cluster_size=4k -o lazy_refcounts=on -o cluster_size=8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=on refcount_bits=16 compression_type=zlib
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
 
 Testing: create -f qcow2 -o cluster_size=4k,cluster_size=8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -48,6 +50,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -71,6 +74,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -94,6 +98,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -117,6 +122,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -140,6 +146,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -163,6 +170,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -186,6 +194,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -209,6 +218,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -227,10 +237,10 @@ Supported options:
   size=<size>            - Virtual disk size
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2, -o help TEST_DIR/t.qcow2 128M
 qemu-img: Invalid option list: backing_file=TEST_DIR/t.qcow2,
@@ -247,6 +257,7 @@ Supported qcow2 options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -279,7 +290,7 @@ qemu-img: Format driver 'bochs' does not support image creation
 === convert: Options specified more than once ===
 
 Testing: create -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 Testing: convert -f foo -f qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -299,6 +310,7 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 4096
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
@@ -310,6 +322,7 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
@@ -328,6 +341,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -351,6 +365,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -374,6 +389,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -397,6 +413,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -420,6 +437,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -443,6 +461,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -466,6 +485,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -489,6 +509,7 @@ Supported options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -527,6 +548,7 @@ Supported qcow2 options:
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -579,6 +601,7 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
@@ -590,6 +613,7 @@ virtual size: 130 MiB (136314880 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
@@ -601,6 +625,7 @@ virtual size: 132 MiB (138412032 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
@@ -619,6 +644,7 @@ Creation options for 'qcow2':
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -643,6 +669,7 @@ Creation options for 'qcow2':
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -667,6 +694,7 @@ Creation options for 'qcow2':
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -691,6 +719,7 @@ Creation options for 'qcow2':
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -715,6 +744,7 @@ Creation options for 'qcow2':
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -739,6 +769,7 @@ Creation options for 'qcow2':
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -763,6 +794,7 @@ Creation options for 'qcow2':
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -787,6 +819,7 @@ Creation options for 'qcow2':
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
@@ -828,6 +861,7 @@ Creation options for 'qcow2':
   backing_fmt=<str>      - Image format of the base image
   cluster_size=<size>    - qcow2 cluster size
   compat=<str>           - Compatibility level (v2 [0.10] or v3 [1.1])
+  compression_type=<str> - Compression method used for image cluster compression
   data_file=<str>        - File name of an external data file
   data_file_raw=<bool (on/off)> - The external data file must stay valid as a raw image
   encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index fd11aae678..a822ff4ef6 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -13,7 +13,7 @@ Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=134217728
 === Create a single snapshot on virtio0 ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/1-snapshot-v0.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.1 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.1 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 
 === Invalid command - missing device and nodename ===
@@ -30,40 +30,40 @@ Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file
 === Create several transactional group snapshots ===
 
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/2-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/2-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/1-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/1-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/3-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/3-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/4-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/4-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/5-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/5-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/6-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/6-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/7-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/7-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/8-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/8-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/9-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/9-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/10-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/10-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 
 === Create a couple of snapshots using blockdev-snapshot ===
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
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 9a3b65782b..ac5ab16bc8 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -9,14 +9,14 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 === Creating backing chain ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 'snapshot-file': 'TEST_DIR/t.IMGFMT.mid', 'format': 'IMGFMT', 'mode': 'absolute-paths' } }
-Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 { 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu-io disk "write 0 4M"' } }
 wrote 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 'snapshot-file': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'absolute-paths' } }
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"return": {}}
 
 === Start commit job and exit qemu ===
@@ -48,7 +48,7 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'drive-mirror', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
@@ -62,7 +62,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 831ce3a289..6280ae6eed 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -36,6 +36,7 @@ image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 16 MiB (16777216 bytes)
 Format specific information:
+    compression type: zlib
     encrypt:
         ivgen alg: plain64
         hash alg: sha256
@@ -79,6 +80,7 @@ file format: IMGFMT
 virtual size: 16 MiB (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
 Format specific information:
+    compression type: zlib
     encrypt:
         ivgen alg: plain64
         hash alg: sha256
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 61e7241e0b..1a14255a83 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -18,6 +18,7 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
@@ -40,6 +41,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
@@ -62,6 +64,7 @@ virtual size: 32 MiB (33554432 bytes)
 cluster_size: 2097152
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: true
     refcount bits: 1
     corrupt: false
@@ -86,6 +89,7 @@ backing file: TEST_IMG.base
 backing file format: IMGFMT
 Format specific information:
     compat: 0.10
+    compression type: zlib
     refcount bits: 16
 
 === Successful image creation (encrypted) ===
@@ -102,6 +106,7 @@ encrypted: yes
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     encrypt:
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
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
index 9d6fdeb1f7..d24ff681af 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -1,9 +1,9 @@
 == Commit tests ==
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -52,6 +52,7 @@ cluster_size: 65536
 backing file: TEST_DIR/PID-base
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
@@ -63,11 +64,11 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 === Testing HMP commit (top -> mid) ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -81,6 +82,7 @@ cluster_size: 65536
 backing file: TEST_DIR/PID-base
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
@@ -92,11 +94,11 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 === Testing QMP active commit (top -> mid) ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -116,6 +118,7 @@ cluster_size: 65536
 backing file: TEST_DIR/PID-base
 Format specific information:
     compat: 1.1
+    compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
@@ -128,9 +131,9 @@ read 1048576/1048576 bytes at offset 1048576
 
 == Resize tests ==
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=6442450944 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=6442450944 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=1073741824 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=1073741824 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 5368709120
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -147,9 +150,9 @@ read 65536/65536 bytes at offset 5368709120
 { "start": 1073741824, "length": 7516192768, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=metadata ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=34359738368 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=34359738368 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=32212254720 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=32212254720 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 33285996544
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -171,9 +174,9 @@ read 65536/65536 bytes at offset 33285996544
 { "start": 34896609280, "length": 536870912, "depth": 0, "zero": true, "data": false, "offset": 2685075456}]
 
 === preallocation=falloc ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=10485760 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=10485760 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=5242880 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=5242880 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 9437184
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -190,9 +193,9 @@ read 65536/65536 bytes at offset 9437184
 { "start": 5242880, "length": 10485760, "depth": 0, "zero": false, "data": true, "offset": 327680}]
 
 === preallocation=full ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=16777216 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=16777216 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=8388608 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=8388608 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 11534336
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -209,9 +212,9 @@ read 65536/65536 bytes at offset 11534336
 { "start": 8388608, "length": 4194304, "depth": 0, "zero": false, "data": true, "offset": 327680}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=393216 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=393216 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=259072 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=259072 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 259072
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -229,9 +232,9 @@ read 65536/65536 bytes at offset 259072
 { "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=409600 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=409600 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 344064
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -248,9 +251,9 @@ read 65536/65536 bytes at offset 344064
 { "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=524288 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=524288 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 446464
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
index 5d382faaa8..92e4d14079 100644
--- a/tests/qemu-iotests/280.out
+++ b/tests/qemu-iotests/280.out
@@ -1,4 +1,4 @@
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 === Launch VM ===
 Enabling migration QMP events on VM...
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
2.26.2


