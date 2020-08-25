Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760CFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8AA2065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAxfZpcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8AA2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUdc-0001l5-5S
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPe-0005TQ-NQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56265
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPZ-0000kB-1K
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DtjLZ7QDOf9Wk1dGfiYMEnwWZ8AiZX1WYtu0c/XRsrk=;
 b=GAxfZpcSkTqOYf6sM+mdsXu36lFFyqZ4hhGJ2C0xMQ4kKwyaPcJlJU5uXd5Uq7f4jNyLT8
 gTLV3FAjNBraBOidLP86DD8WvWE8FKB3wLHMfu8PuwJH0iwDgidb6+offTTiS30MlAza8G
 zmvniqCqTiDvOvePZbdGJ2iJfU7YwEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-hio8xrJNPZuh-XvWMTuqPA-1; Tue, 25 Aug 2020 04:34:26 -0400
X-MC-Unique: hio8xrJNPZuh-XvWMTuqPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0F9A1005E6E;
 Tue, 25 Aug 2020 08:34:25 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FBEE10098A5;
 Tue, 25 Aug 2020 08:34:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 31/34] qcow2: Add the 'extended_l2' option and the
 QCOW2_INCOMPAT_EXTL2 bit
Date: Tue, 25 Aug 2020 10:33:08 +0200
Message-Id: <20200825083311.1098442-32-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.101
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alberto Garcia <berto@igalia.com>

Now that the implementation of subclusters is complete we can finally
add the necessary options to create and read images with this feature,
which we call "extended L2 entries".

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <6476caaa73216bd05b7bb2d504a20415e1665176.1594396418.git.berto@igalia.com>
[mreitz: %s/5\.1/5.2/; fixed 302's and 303's reference output]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json             |   7 +++
 block/qcow2.h                    |   8 ++-
 include/block/block_int.h        |   1 +
 block/qcow2.c                    |  66 ++++++++++++++++++--
 tests/qemu-iotests/031.out       |   8 +--
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 +++++++++++++++----------------
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061.out       |  20 +++---
 tests/qemu-iotests/065           |  12 ++--
 tests/qemu-iotests/082.out       |  39 +++++++++---
 tests/qemu-iotests/085.out       |  38 ++++++------
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +--
 tests/qemu-iotests/198           |   2 +
 tests/qemu-iotests/206.out       |   4 ++
 tests/qemu-iotests/242.out       |   5 ++
 tests/qemu-iotests/255.out       |   8 +--
 tests/qemu-iotests/274.out       |  49 ++++++++-------
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/291.out       |   2 +
 tests/qemu-iotests/302.out       |   1 +
 tests/qemu-iotests/303.out       |   4 +-
 tests/qemu-iotests/common.filter |   1 +
 25 files changed, 256 insertions(+), 142 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 197bdc1c36..db08c58d78 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -67,6 +67,9 @@
 #                 standalone (read-only) raw image without looking at qcow2
 #                 metadata (since: 4.0)
 #
+# @extended-l2: true if the image has extended L2 entries; only valid for
+#               compat >= 1.1 (since 5.2)
+#
 # @lazy-refcounts: on or off; only valid for compat >= 1.1
 #
 # @corrupt: true if the image has been marked corrupt; only valid for
@@ -88,6 +91,7 @@
       'compat': 'str',
       '*data-file': 'str',
       '*data-file-raw': 'bool',
+      '*extended-l2': 'bool',
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
       'refcount-bits': 'int',
@@ -4304,6 +4308,8 @@
 # @data-file-raw: True if the external data file must stay valid as a
 #                 standalone (read-only) raw image without looking at qcow2
 #                 metadata (default: false; since: 4.0)
+# @extended-l2      True to make the image have extended L2 entries
+#                   (default: false; since 5.2)
 # @size: Size of the virtual disk in bytes
 # @version: Compatibility level (default: v3)
 # @backing-file: File name of the backing file if a backing file
@@ -4324,6 +4330,7 @@
   'data': { 'file':             'BlockdevRef',
             '*data-file':       'BlockdevRef',
             '*data-file-raw':   'bool',
+            '*extended-l2':     'bool',
             'size':             'size',
             '*version':         'BlockdevQcow2Version',
             '*backing-file':    'str',
diff --git a/block/qcow2.h b/block/qcow2.h
index f3499e53bf..065ec3df0b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -246,15 +246,18 @@ enum {
     QCOW2_INCOMPAT_CORRUPT_BITNR    = 1,
     QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
     QCOW2_INCOMPAT_COMPRESSION_BITNR = 3,
+    QCOW2_INCOMPAT_EXTL2_BITNR      = 4,
     QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
     QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
     QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
     QCOW2_INCOMPAT_COMPRESSION      = 1 << QCOW2_INCOMPAT_COMPRESSION_BITNR,
+    QCOW2_INCOMPAT_EXTL2            = 1 << QCOW2_INCOMPAT_EXTL2_BITNR,
 
     QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
                                     | QCOW2_INCOMPAT_CORRUPT
                                     | QCOW2_INCOMPAT_DATA_FILE
-                                    | QCOW2_INCOMPAT_COMPRESSION,
+                                    | QCOW2_INCOMPAT_COMPRESSION
+                                    | QCOW2_INCOMPAT_EXTL2,
 };
 
 /* Compatible feature bits */
@@ -581,8 +584,7 @@ typedef enum QCow2MetadataOverlap {
 
 static inline bool has_subclusters(BDRVQcow2State *s)
 {
-    /* FIXME: Return false until this feature is complete */
-    return false;
+    return s->incompatible_features & QCOW2_INCOMPAT_EXTL2;
 }
 
 static inline size_t l2_entry_size(BDRVQcow2State *s)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 38dec0275b..9da7a42927 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -59,6 +59,7 @@
 #define BLOCK_OPT_DATA_FILE         "data_file"
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
+#define BLOCK_OPT_EXTL2             "extended_l2"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 7c03d41170..00cda5696b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1449,6 +1449,12 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     s->subcluster_size = s->cluster_size / s->subclusters_per_cluster;
     s->subcluster_bits = ctz32(s->subcluster_size);
 
+    if (s->subcluster_size < (1 << MIN_CLUSTER_BITS)) {
+        error_setg(errp, "Unsupported subcluster size: %d", s->subcluster_size);
+        ret = -EINVAL;
+        goto fail;
+    }
+
     /* Check support for various header values */
     if (header.refcount_order > 6) {
         error_setg(errp, "Reference count entry width too large; may not "
@@ -2934,6 +2940,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  = QCOW2_INCOMPAT_COMPRESSION_BITNR,
                 .name = "compression type",
             },
+            {
+                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
+                .bit  = QCOW2_INCOMPAT_EXTL2_BITNR,
+                .name = "extended L2 entries",
+            },
             {
                 .type = QCOW2_FEAT_TYPE_COMPATIBLE,
                 .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
@@ -3270,7 +3281,8 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
     return meta_size + aligned_total_size;
 }
 
-static bool validate_cluster_size(size_t cluster_size, Error **errp)
+static bool validate_cluster_size(size_t cluster_size, bool extended_l2,
+                                  Error **errp)
 {
     int cluster_bits = ctz32(cluster_size);
     if (cluster_bits < MIN_CLUSTER_BITS || cluster_bits > MAX_CLUSTER_BITS ||
@@ -3280,16 +3292,28 @@ static bool validate_cluster_size(size_t cluster_size, Error **errp)
                    "%dk", 1 << MIN_CLUSTER_BITS, 1 << (MAX_CLUSTER_BITS - 10));
         return false;
     }
+
+    if (extended_l2) {
+        unsigned min_cluster_size =
+            (1 << MIN_CLUSTER_BITS) * QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER;
+        if (cluster_size < min_cluster_size) {
+            error_setg(errp, "Extended L2 entries are only supported with "
+                       "cluster sizes of at least %u bytes", min_cluster_size);
+            return false;
+        }
+    }
+
     return true;
 }
 
-static size_t qcow2_opt_get_cluster_size_del(QemuOpts *opts, Error **errp)
+static size_t qcow2_opt_get_cluster_size_del(QemuOpts *opts, bool extended_l2,
+                                             Error **errp)
 {
     size_t cluster_size;
 
     cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
                                          DEFAULT_CLUSTER_SIZE);
-    if (!validate_cluster_size(cluster_size, errp)) {
+    if (!validate_cluster_size(cluster_size, extended_l2, errp)) {
         return 0;
     }
     return cluster_size;
@@ -3403,7 +3427,20 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         cluster_size = DEFAULT_CLUSTER_SIZE;
     }
 
-    if (!validate_cluster_size(cluster_size, errp)) {
+    if (!qcow2_opts->has_extended_l2) {
+        qcow2_opts->extended_l2 = false;
+    }
+    if (qcow2_opts->extended_l2) {
+        if (version < 3) {
+            error_setg(errp, "Extended L2 entries are only supported with "
+                       "compatibility level 1.1 and above (use version=v3 or "
+                       "greater)");
+            ret = -EINVAL;
+            goto out;
+        }
+    }
+
+    if (!validate_cluster_size(cluster_size, qcow2_opts->extended_l2, errp)) {
         ret = -EINVAL;
         goto out;
     }
@@ -3554,6 +3591,11 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             cpu_to_be64(QCOW2_INCOMPAT_COMPRESSION);
     }
 
+    if (qcow2_opts->extended_l2) {
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_EXTL2);
+    }
+
     ret = blk_pwrite(blk, 0, header, cluster_size, 0);
     g_free(header);
     if (ret < 0) {
@@ -3731,6 +3773,7 @@ static int coroutine_fn qcow2_co_create_opts(BlockDriver *drv,
         { BLOCK_OPT_BACKING_FMT,        "backing-fmt" },
         { BLOCK_OPT_CLUSTER_SIZE,       "cluster-size" },
         { BLOCK_OPT_LAZY_REFCOUNTS,     "lazy-refcounts" },
+        { BLOCK_OPT_EXTL2,              "extended-l2" },
         { BLOCK_OPT_REFCOUNT_BITS,      "refcount-bits" },
         { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
@@ -4847,11 +4890,14 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     PreallocMode prealloc;
     bool has_backing_file;
     bool has_luks;
-    bool extended_l2 = false; /* Set to false until the option is added */
+    bool extended_l2;
     size_t l2e_size;
 
     /* Parse image creation options */
-    cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
+    extended_l2 = qemu_opt_get_bool_del(opts, BLOCK_OPT_EXTL2, false);
+
+    cluster_size = qcow2_opt_get_cluster_size_del(opts, extended_l2,
+                                                  &local_err);
     if (local_err) {
         goto err;
     }
@@ -5047,6 +5093,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
             .corrupt            = s->incompatible_features &
                                   QCOW2_INCOMPAT_CORRUPT,
             .has_corrupt        = true,
+            .has_extended_l2    = true,
+            .extended_l2        = has_subclusters(s),
             .refcount_bits      = s->refcount_bits,
             .has_bitmaps        = !!bitmaps,
             .bitmaps            = bitmaps,
@@ -5774,6 +5822,12 @@ static QemuOptsList qcow2_create_opts = {
             .help = "qcow2 cluster size",                               \
             .def_value_str = stringify(DEFAULT_CLUSTER_SIZE)            \
         },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_EXTL2,                                    \
+            .type = QEMU_OPT_BOOL,                                      \
+            .help = "Extended L2 tables",                               \
+            .def_value_str = "off"                                      \
+        },                                                              \
         {                                                               \
             .name = BLOCK_OPT_PREALLOC,                                 \
             .type = QEMU_OPT_STRING,                                    \
diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 4b21d6a9ba..0054c2ed97 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -117,7 +117,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 Header extension:
@@ -150,7 +150,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 Header extension:
@@ -164,7 +164,7 @@ No errors were found on the image.
 
 magic                     0x514649fb
 version                   3
-backing_file_offset       0x210
+backing_file_offset       0x240
 backing_file_size         0x17
 cluster_bits              16
 size                      67108864
@@ -188,7 +188,7 @@ data                      'host_device'
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 Header extension:
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index a9bed828e5..1fa7cad28d 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -26,7 +26,7 @@ compatible_features       []
 autoclear_features        [63]
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 
@@ -38,7 +38,7 @@ compatible_features       []
 autoclear_features        []
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 *** done
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 4c21dc70a5..a7e220830d 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -4,90 +4,90 @@ QA output created by 049
 == 1. Traditional size parameter ==
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024b
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1k
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1K
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1048576 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1048576 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1G
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1073741824 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1073741824 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1T
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1099511627776 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1099511627776 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0b
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5k
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5K
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1572864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1572864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5G
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1610612736 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1610612736 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5T
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1649267441664 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1649267441664 lazy_refcounts=off refcount_bits=16
 
 == 2. Specifying size via -o ==
 
 qemu-img create -f qcow2 -o size=1024 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1048576 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1048576 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1073741824 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1073741824 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1099511627776 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1099511627776 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024.0 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024.0b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1572864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1572864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1610612736 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1610612736 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1649267441664 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1649267441664 lazy_refcounts=off refcount_bits=16
 
 == 3. Invalid sizes ==
 
@@ -129,84 +129,84 @@ qemu-img: TEST_DIR/t.qcow2: The image size must be specified only once
 == Check correct interpretation of suffixes for cluster size ==
 
 qemu-img create -f qcow2 -o cluster_size=1024 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1048576 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1048576 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024.0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024.0b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=1024 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=512 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=512 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=512 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=512 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=524288 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=524288 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 == Check compat level option ==
 
 qemu-img create -f qcow2 -o compat=0.10 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=1.1 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=1.1 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 compat=1.1 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.42 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=0.42 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 compat=0.42 lazy_refcounts=off refcount_bits=16
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
 
 qemu-img create -f qcow2 -o compat=foobar TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=foobar lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 compat=foobar lazy_refcounts=off refcount_bits=16
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
 
 == Check preallocation option ==
 
 qemu-img create -f qcow2 -o preallocation=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 preallocation=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off preallocation=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o preallocation=metadata TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 preallocation=metadata compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off preallocation=metadata compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o preallocation=1234 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 preallocation=1234 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off preallocation=1234 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
 
 == Check encryption option ==
 
 qemu-img create -f qcow2 -o encryption=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 encryption=off cluster_size=65536 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 encryption=off cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 --object secret,id=sec0,data=123456 -o encryption=on,encrypt.key-secret=sec0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 encryption=on encrypt.key-secret=sec0 cluster_size=65536 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 encryption=on encrypt.key-secret=sec0 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 == Check lazy_refcounts option (only with v3) ==
 
 qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=1.1 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 compat=1.1 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=on TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=1.1 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 compat=1.1 lazy_refcounts=on refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=on TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=on refcount_bits=16
 qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
 
 *** done
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index b2804a0d07..b74540bafb 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -21,6 +21,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: true
+    extended l2: false
 qemu-io: can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; cannot be opened read/write
 no file open, try 'help open'
 read 512/512 bytes at offset 0
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index b2d2dfed04..b0a1382046 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -26,7 +26,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 magic                     0x514649fb
@@ -84,7 +84,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 magic                     0x514649fb
@@ -140,7 +140,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 ERROR cluster 5 refcount=0 reference=1
@@ -195,7 +195,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 magic                     0x514649fb
@@ -264,7 +264,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 read 65536/65536 bytes at offset 44040192
@@ -326,7 +326,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 ERROR cluster 5 refcount=0 reference=1
@@ -355,7 +355,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 read 131072/131072 bytes at offset 0
@@ -530,6 +530,7 @@ Format specific information:
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: false
     corrupt: false
+    extended l2: false
 No errors were found on the image.
 
 === Try changing the external data file ===
@@ -551,6 +552,7 @@ Format specific information:
     data file: foo
     data file raw: false
     corrupt: false
+    extended l2: false
 
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': 'data-file' is required for this image
 image: TEST_DIR/t.IMGFMT
@@ -564,6 +566,7 @@ Format specific information:
     refcount bits: 16
     data file raw: false
     corrupt: false
+    extended l2: false
 
 === Clearing and setting data-file-raw ===
 
@@ -580,6 +583,7 @@ Format specific information:
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: true
     corrupt: false
+    extended l2: false
 No errors were found on the image.
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -593,6 +597,7 @@ Format specific information:
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: false
     corrupt: false
+    extended l2: false
 No errors were found on the image.
 qemu-img: data-file-raw cannot be set on existing images
 image: TEST_DIR/t.IMGFMT
@@ -607,5 +612,6 @@ Format specific information:
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: false
     corrupt: false
+    extended l2: false
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 18dc488c7a..29a7f7ad60 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -98,20 +98,20 @@ class TestQCow3NotLazy(TestQemuImgInfo):
     img_options = 'compat=1.1,lazy_refcounts=off'
     json_compare = { 'compat': '1.1', 'lazy-refcounts': False,
                      'refcount-bits': 16, 'corrupt': False,
-                     'compression-type': 'zlib' }
+                     'compression-type': 'zlib', 'extended-l2': False }
     human_compare = [ 'compat: 1.1', 'compression type: zlib',
                       'lazy refcounts: false', 'refcount bits: 16',
-                      'corrupt: false' ]
+                      'corrupt: false', 'extended l2: false' ]
 
 class TestQCow3Lazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts enabled'''
     img_options = 'compat=1.1,lazy_refcounts=on'
     json_compare = { 'compat': '1.1', 'lazy-refcounts': True,
                      'refcount-bits': 16, 'corrupt': False,
-                     'compression-type': 'zlib' }
+                     'compression-type': 'zlib', 'extended-l2': False }
     human_compare = [ 'compat: 1.1', 'compression type: zlib',
                       'lazy refcounts: true', 'refcount bits: 16',
-                      'corrupt: false' ]
+                      'corrupt: false', 'extended l2: false' ]
 
 class TestQCow3NotLazyQMP(TestQMP):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled, opening
@@ -120,7 +120,7 @@ class TestQCow3NotLazyQMP(TestQMP):
     qemu_options = 'lazy-refcounts=on'
     compare = { 'compat': '1.1', 'lazy-refcounts': False,
                 'refcount-bits': 16, 'corrupt': False,
-                'compression-type': 'zlib' }
+                'compression-type': 'zlib', 'extended-l2': False }
 
 
 class TestQCow3LazyQMP(TestQMP):
@@ -130,7 +130,7 @@ class TestQCow3LazyQMP(TestQMP):
     qemu_options = 'lazy-refcounts=off'
     compare = { 'compat': '1.1', 'lazy-refcounts': True,
                 'refcount-bits': 16, 'corrupt': False,
-                'compression-type': 'zlib' }
+                'compression-type': 'zlib', 'extended-l2': False }
 
 TestImageInfoSpecific = None
 TestQemuImgInfo = None
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 1728aff1e0..b70c12c139 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -3,14 +3,14 @@ QA output created by 082
 === create: Options specified more than once ===
 
 Testing: create -f foo -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 
 Testing: create -f qcow2 -o cluster_size=4k -o lazy_refcounts=on TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=4096 compression_type=zlib size=134217728 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=4096 extended_l2=off compression_type=zlib size=134217728 lazy_refcounts=on refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -21,9 +21,10 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: create -f qcow2 -o cluster_size=4k -o lazy_refcounts=on -o cluster_size=8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=8192 compression_type=zlib size=134217728 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=8192 extended_l2=off compression_type=zlib size=134217728 lazy_refcounts=on refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -34,9 +35,10 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: create -f qcow2 -o cluster_size=4k,cluster_size=8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=8192 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=8192 extended_l2=off compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -62,6 +64,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -87,6 +90,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -112,6 +116,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -137,6 +142,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -162,6 +168,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -187,6 +194,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -212,6 +220,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -237,6 +246,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -245,10 +255,10 @@ Supported options:
   size=<size>            - Virtual disk size
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help -F qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2,,help backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2,,help backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,? -F qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2,,? backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2,,? backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2, -o help TEST_DIR/t.qcow2 128M
 qemu-img: Invalid option list: backing_file=TEST_DIR/t.qcow2,
@@ -277,6 +287,7 @@ Supported qcow2 options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -298,7 +309,7 @@ qemu-img: Format driver 'bochs' does not support image creation
 === convert: Options specified more than once ===
 
 Testing: create -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 
 Testing: convert -f foo -f qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -322,6 +333,7 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: convert -O qcow2 -o cluster_size=4k -o lazy_refcounts=on -o cluster_size=8k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -334,6 +346,7 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: convert -O qcow2 -o cluster_size=4k,cluster_size=8k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -361,6 +374,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -386,6 +400,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -411,6 +426,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -436,6 +452,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -461,6 +478,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -486,6 +504,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -511,6 +530,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -536,6 +556,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
@@ -576,6 +597,7 @@ Supported qcow2 options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -621,6 +643,7 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: amend -f qcow2 -o size=130M -o lazy_refcounts=off TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
@@ -633,6 +656,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: amend -f qcow2 -o size=8M -o lazy_refcounts=on -o size=132M TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
@@ -645,6 +669,7 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: amend -f qcow2 -o size=4M,size=148M TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index 700658d5a3..7fc44b1c61 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -13,7 +13,7 @@ Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=134217728
 === Create a single snapshot on virtio0 ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/1-snapshot-v0.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2.1 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2.1 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Invalid command - missing device and nodename ===
@@ -30,40 +30,40 @@ Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compress
 === Create several transactional group snapshots ===
 
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/2-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/2-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/1-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2.2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/1-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2.2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/3-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/3-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/2-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/2-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/2-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/2-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/4-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/4-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/3-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/3-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/3-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/3-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/5-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/5-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/4-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/4-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/4-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/4-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/6-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/6-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/5-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/5-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/5-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/5-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/7-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/7-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/6-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/6-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/6-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/6-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/8-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/8-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/7-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/7-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/7-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/7-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/9-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/9-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/8-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/8-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/8-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/8-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/10-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/10-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/9-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 backing_file=TEST_DIR/9-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/9-snapshot-v0.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/9-snapshot-v1.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Create a couple of snapshots using blockdev-snapshot ===
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index a2172a1308..13e0c4f5a7 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=536870912
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/tmp.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Performing block-commit on active layer ===
@@ -31,6 +31,6 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 cluster_size=65536 compression_type=z
 === Performing Live Snapshot 2 ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/tmp2.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index 29e9db3497..ce23340670 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -13,7 +13,7 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node0', 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
 {'execute': 'blockdev-snapshot-sync', 'arguments': { 'node-name': 'node0', 'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'snapshot-node-name': 'node1' } }
-Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 cluster_size=65536 compression_type=zlib size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file lazy_refcounts=off refcount_bits=16
 {"return": {}}
 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node1', 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 62d1ab74d3..339438ac68 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -9,14 +9,14 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 === Creating backing chain ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 'snapshot-file': 'TEST_DIR/t.IMGFMT.mid', 'format': 'IMGFMT', 'mode': 'absolute-paths' } }
-Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 { 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu-io disk "write 0 4M"' } }
 wrote 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 'snapshot-file': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'absolute-paths' } }
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Start commit job and exit qemu ===
@@ -48,7 +48,7 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zli
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'drive-mirror', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
@@ -62,7 +62,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 compression_typ
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index 1b9bfb827b..46f0c54537 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -94,6 +94,7 @@ echo "== checking image base =="
 $QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info --format-specific \
     | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' \
           -e '/lazy refcounts:/ D' -e '/corrupt:/ D' -e '/^\s*data file/ D' \
+          -e '/extended l2:/ D' \
     | _filter_json_filename
 
 echo
@@ -101,6 +102,7 @@ echo "== checking image layer =="
 $QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info --format-specific \
     | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' \
           -e '/lazy refcounts:/ D' -e '/corrupt:/ D' -e '/^\s*data file/ D' \
+          -e '/extended l2:/ D' \
     | _filter_json_filename
 
 
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 1a14255a83..363c5abe35 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -22,6 +22,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 === Successful image creation (inline blockdev-add, explicit defaults) ===
 
@@ -45,6 +46,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 === Successful image creation (v3 non-default options) ===
 
@@ -68,6 +70,7 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 1
     corrupt: false
+    extended l2: false
 
 === Successful image creation (v2 non-default options) ===
 
@@ -146,6 +149,7 @@ Format specific information:
         payload offset: 528384
         master key iters: XXX
     corrupt: false
+    extended l2: false
 
 === Invalid BlockdevRef ===
 
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
index 091b9126ce..3759c99284 100644
--- a/tests/qemu-iotests/242.out
+++ b/tests/qemu-iotests/242.out
@@ -16,6 +16,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 No bitmap in JSON format output
 
@@ -42,6 +43,7 @@ Format specific information:
             granularity: 32768
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 The same bitmaps in JSON format:
 [
@@ -80,6 +82,7 @@ Format specific information:
             granularity: 65536
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 The same bitmaps in JSON format:
 [
@@ -123,6 +126,7 @@ Format specific information:
             granularity: 65536
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 The same bitmaps in JSON format:
 [
@@ -167,5 +171,6 @@ Format specific information:
             granularity: 16384
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Test complete
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
index d74903db99..33b7f22de3 100644
--- a/tests/qemu-iotests/255.out
+++ b/tests/qemu-iotests/255.out
@@ -3,9 +3,9 @@ Finishing a commit job with background reads
 
 === Create backing chain and start VM ===
 
-Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 
 === Start background read requests ===
 
@@ -23,9 +23,9 @@ Closing the VM while a job is being cancelled
 
 === Create images and start VM ===
 
-Formatting 'TEST_DIR/PID-src.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-src.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-dst.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-dst.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 lazy_refcounts=off refcount_bits=16
 
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
index 3a36fe7dfd..bf5abd4c10 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -1,9 +1,9 @@
 == Commit tests ==
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -57,6 +57,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -65,11 +66,11 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 === Testing HMP commit (top -> mid) ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -88,6 +89,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -96,11 +98,11 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 === Testing QMP active commit (top -> mid) ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -125,6 +127,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -134,9 +137,9 @@ read 1048576/1048576 bytes at offset 1048576
 
 == Resize tests ==
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=6442450944 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=6442450944 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=1073741824 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1073741824 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 5368709120
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -153,9 +156,9 @@ read 65536/65536 bytes at offset 5368709120
 { "start": 1073741824, "length": 7516192768, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=metadata ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=34359738368 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=34359738368 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=32212254720 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=32212254720 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 33285996544
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -177,9 +180,9 @@ read 65536/65536 bytes at offset 33285996544
 { "start": 34896609280, "length": 536870912, "depth": 0, "zero": true, "data": false, "offset": 2685075456}]
 
 === preallocation=falloc ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=10485760 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=10485760 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=5242880 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=5242880 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 9437184
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -196,9 +199,9 @@ read 65536/65536 bytes at offset 9437184
 { "start": 5242880, "length": 10485760, "depth": 0, "zero": false, "data": true, "offset": 327680}]
 
 === preallocation=full ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=16777216 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=16777216 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=8388608 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=8388608 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 11534336
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -215,9 +218,9 @@ read 65536/65536 bytes at offset 11534336
 { "start": 8388608, "length": 4194304, "depth": 0, "zero": false, "data": true, "offset": 327680}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=393216 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=393216 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=259072 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=259072 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 259072
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -235,9 +238,9 @@ read 65536/65536 bytes at offset 259072
 { "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=409600 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=409600 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=262144 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=262144 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 344064
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -254,9 +257,9 @@ read 65536/65536 bytes at offset 344064
 { "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=524288 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=524288 lazy_refcounts=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 compression_type=zlib size=262144 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=262144 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 446464
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
index fc59b9bc5c..09a0f1a7cb 100644
--- a/tests/qemu-iotests/280.out
+++ b/tests/qemu-iotests/280.out
@@ -1,4 +1,4 @@
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 
 === Launch VM ===
 Enabling migration QMP events on VM...
diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
index 9f661515b4..ee89a72885 100644
--- a/tests/qemu-iotests/291.out
+++ b/tests/qemu-iotests/291.out
@@ -41,6 +41,7 @@ Format specific information:
             granularity: 65536
     refcount bits: 16
     corrupt: false
+    extended l2: false
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 10 MiB (10485760 bytes)
@@ -65,6 +66,7 @@ Format specific information:
             granularity: 65536
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 === Check bitmap contents ===
 
diff --git a/tests/qemu-iotests/302.out b/tests/qemu-iotests/302.out
index e37d3a1030..e2f6077e83 100644
--- a/tests/qemu-iotests/302.out
+++ b/tests/qemu-iotests/302.out
@@ -17,6 +17,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 === Converted image check ===
 No errors were found on the image.
diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
index 7fa1edef0d..7c16998587 100644
--- a/tests/qemu-iotests/303.out
+++ b/tests/qemu-iotests/303.out
@@ -47,7 +47,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    336
+length                    384
 data                      <binary>
 
 Header extension:
@@ -105,7 +105,7 @@ Bitmap table   type            size         offset
     {
         "name": "Feature table",
         "magic": 1745090647,
-        "length": 336,
+        "length": 384,
         "data_str": "<binary>"
     },
     {
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index c6912be009..838ed15793 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -239,6 +239,7 @@ _filter_img_info()
         -e "/adapter_type: '[^']*'/d" \
         -e "/hwversion: '[^']*'/d" \
         -e "/lazy_refcounts: \\(on\\|off\\)/d" \
+        -e "/extended_l2=\\(on\\|off\\)/d" \
         -e "/block_size: [0-9]\\+/d" \
         -e "/block_state_zero: \\(on\\|off\\)/d" \
         -e "/log_size: [0-9]\\+/d" \
-- 
2.26.2


