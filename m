Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33102C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0794206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OkznyOHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0794206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1kL-0001EK-UN
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 13:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xq-00074T-67; Tue, 05 May 2020 13:39:50 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:38910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xb-0008A2-Ln; Tue, 05 May 2020 13:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=+/O3i8KOSyQuNe622xMslZfW8d5/NLTjrp7xoKJ8h/E=; 
 b=OkznyOHVgRpECOQ5AiRl9E3u3YCAJ1Lk1qUnAxCFQOAaav1SVNJH/3FRaST6s434s8fqIRVvZhJrEReasYgcjkFNlukP2xIjaY/xs60yLJaoFFw/7c4khqEDTkrhjPkdX8rbhGNVURjl2W9NZD44RiSCAnORn75zM2qglRdjZUAQi3pf9RAm3G9ONg6nr3WC4pbPHur7yFys5+opKzYn42J2YXQwVh0fJ8UfMucFk0tvH2f1By3xZagxkrcDG6uNkxbeRTGv4HDgUEm4xjvyjoknWAjwrJy88mneJLIexmWYb3rRsTDNbSS/byUt0I5VUhWdt5SQQSqM7GSayY2jCA==;
Received: from static.160.43.0.81.ibercom.com ([81.0.43.160]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jW1Ws-00025b-Hr; Tue, 05 May 2020 19:38:50 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jW1Wd-00044p-Bv; Tue, 05 May 2020 19:38:35 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 28/31] qcow2: Add the 'extended_l2' option and the
 QCOW2_INCOMPAT_EXTL2 bit
Date: Tue,  5 May 2020 19:38:28 +0200
Message-Id: <f8d2bb7d22fd228816e5caed6640af36a63cdddc.1588699789.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588699789.git.berto@igalia.com>
References: <cover.1588699789.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 13:38:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the implementation of subclusters is complete we can finally
add the necessary options to create and read images with this feature,
which we call "extended L2 entries".

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json             |   7 +++
 block/qcow2.h                    |   8 ++-
 include/block/block_int.h        |   1 +
 block/qcow2.c                    |  65 ++++++++++++++++++--
 tests/qemu-iotests/031.out       |   8 +--
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 +++++++++++++++----------------
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061.out       |  20 +++---
 tests/qemu-iotests/065           |  18 ++++--
 tests/qemu-iotests/082.out       |  48 ++++++++++++---
 tests/qemu-iotests/085.out       |  38 ++++++------
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +--
 tests/qemu-iotests/198.out       |   2 +
 tests/qemu-iotests/206.out       |   4 ++
 tests/qemu-iotests/242.out       |   5 ++
 tests/qemu-iotests/255.out       |   8 +--
 tests/qemu-iotests/274.out       |  49 ++++++++-------
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/common.filter |   1 +
 22 files changed, 266 insertions(+), 139 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 943df1926a..f5d1656001 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -66,6 +66,9 @@
 #                 standalone (read-only) raw image without looking at qcow2
 #                 metadata (since: 4.0)
 #
+# @extended-l2: true if the image has extended L2 entries; only valid for
+#               compat >= 1.1 (since 5.1)
+#
 # @lazy-refcounts: on or off; only valid for compat >= 1.1
 #
 # @corrupt: true if the image has been marked corrupt; only valid for
@@ -85,6 +88,7 @@
       'compat': 'str',
       '*data-file': 'str',
       '*data-file-raw': 'bool',
+      '*extended-l2': 'bool',
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
       'refcount-bits': 'int',
@@ -4296,6 +4300,8 @@
 # @data-file-raw: True if the external data file must stay valid as a
 #                 standalone (read-only) raw image without looking at qcow2
 #                 metadata (default: false; since: 4.0)
+# @extended-l2      True to make the image have extended L2 entries
+#                   (default: false; since 5.1)
 # @size: Size of the virtual disk in bytes
 # @version: Compatibility level (default: v3)
 # @backing-file: File name of the backing file if a backing file
@@ -4314,6 +4320,7 @@
   'data': { 'file':             'BlockdevRef',
             '*data-file':       'BlockdevRef',
             '*data-file-raw':   'bool',
+            '*extended-l2':     'bool',
             'size':             'size',
             '*version':         'BlockdevQcow2Version',
             '*backing-file':    'str',
diff --git a/block/qcow2.h b/block/qcow2.h
index 7349c6ce40..09bf561305 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -237,13 +237,16 @@ enum {
     QCOW2_INCOMPAT_DIRTY_BITNR      = 0,
     QCOW2_INCOMPAT_CORRUPT_BITNR    = 1,
     QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
+    QCOW2_INCOMPAT_EXTL2_BITNR      = 4,
     QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
     QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
     QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
+    QCOW2_INCOMPAT_EXTL2            = 1 << QCOW2_INCOMPAT_EXTL2_BITNR,
 
     QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
                                     | QCOW2_INCOMPAT_CORRUPT
-                                    | QCOW2_INCOMPAT_DATA_FILE,
+                                    | QCOW2_INCOMPAT_DATA_FILE
+                                    | QCOW2_INCOMPAT_EXTL2,
 };
 
 /* Compatible feature bits */
@@ -555,8 +558,7 @@ typedef enum QCow2MetadataOverlap {
 
 static inline bool has_subclusters(BDRVQcow2State *s)
 {
-    /* FIXME: Return false until this feature is complete */
-    return false;
+    return s->incompatible_features & QCOW2_INCOMPAT_EXTL2;
 }
 
 static inline size_t l2_entry_size(BDRVQcow2State *s)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 92335f33c7..27f17bab78 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -57,6 +57,7 @@
 #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
 #define BLOCK_OPT_DATA_FILE         "data_file"
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
+#define BLOCK_OPT_EXTL2             "extended_l2"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/block/qcow2.c b/block/qcow2.c
index ec4d1405f0..18c8e3f52a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1385,6 +1385,12 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
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
@@ -2852,6 +2858,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  = QCOW2_INCOMPAT_DATA_FILE_BITNR,
                 .name = "external data file",
             },
+            {
+                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
+                .bit  = QCOW2_INCOMPAT_EXTL2_BITNR,
+                .name = "extended L2 entries",
+            },
             {
                 .type = QCOW2_FEAT_TYPE_COMPATIBLE,
                 .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
@@ -3195,7 +3206,8 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
     return meta_size + aligned_total_size;
 }
 
-static bool validate_cluster_size(size_t cluster_size, Error **errp)
+static bool validate_cluster_size(size_t cluster_size, bool extended_l2,
+                                  Error **errp)
 {
     int cluster_bits = ctz32(cluster_size);
     if (cluster_bits < MIN_CLUSTER_BITS || cluster_bits > MAX_CLUSTER_BITS ||
@@ -3205,16 +3217,28 @@ static bool validate_cluster_size(size_t cluster_size, Error **errp)
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
@@ -3328,7 +3352,20 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
@@ -3448,6 +3485,11 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
     }
 
+    if (qcow2_opts->extended_l2) {
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_EXTL2);
+    }
+
     ret = blk_pwrite(blk, 0, header, cluster_size, 0);
     g_free(header);
     if (ret < 0) {
@@ -3628,6 +3670,7 @@ static int coroutine_fn qcow2_co_create_opts(BlockDriver *drv,
         { BLOCK_OPT_BACKING_FMT,        "backing-fmt" },
         { BLOCK_OPT_CLUSTER_SIZE,       "cluster-size" },
         { BLOCK_OPT_LAZY_REFCOUNTS,     "lazy-refcounts" },
+        { BLOCK_OPT_EXTL2,              "extended-l2" },
         { BLOCK_OPT_REFCOUNT_BITS,      "refcount-bits" },
         { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
@@ -4721,9 +4764,13 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     PreallocMode prealloc;
     bool has_backing_file;
     bool has_luks;
+    bool extended_l2;
 
     /* Parse image creation options */
-    cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
+    extended_l2 = qemu_opt_get_bool_del(opts, BLOCK_OPT_EXTL2, false);
+
+    cluster_size = qcow2_opt_get_cluster_size_del(opts, extended_l2,
+                                                  &local_err);
     if (local_err) {
         goto err;
     }
@@ -4918,6 +4965,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
             .corrupt            = s->incompatible_features &
                                   QCOW2_INCOMPAT_CORRUPT,
             .has_corrupt        = true,
+            .has_extended_l2    = true,
+            .extended_l2        = has_subclusters(s),
             .refcount_bits      = s->refcount_bits,
             .has_bitmaps        = !!bitmaps,
             .bitmaps            = bitmaps,
@@ -5576,6 +5625,12 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Postpone refcount updates",
             .def_value_str = "off"
         },
+        {
+            .name = BLOCK_OPT_EXTL2,
+            .type = QEMU_OPT_BOOL,
+            .help = "Extended L2 tables",
+            .def_value_str = "off"
+        },
         {
             .name = BLOCK_OPT_REFCOUNT_BITS,
             .type = QEMU_OPT_NUMBER,
diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 46f97c5a4e..bb1afa7b87 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -117,7 +117,7 @@ header_length             104
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 Header extension:
@@ -150,7 +150,7 @@ header_length             104
 
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
+backing_file_offset       0x208
 backing_file_size         0x17
 cluster_bits              16
 size                      67108864
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
index affa55b341..191637dfaf 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -4,90 +4,90 @@ QA output created by 049
 == 1. Traditional size parameter ==
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024b
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1k
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1K
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1G
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1T
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0b
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5k
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5K
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5G
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5T
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 == 2. Specifying size via -o ==
 
 qemu-img create -f qcow2 -o size=1024 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024.0 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024.0b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 == 3. Invalid sizes ==
 
@@ -129,84 +129,84 @@ qemu-img: TEST_DIR/t.qcow2: The image size must be specified only once
 == Check correct interpretation of suffixes for cluster size ==
 
 qemu-img create -f qcow2 -o cluster_size=1024 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1048576 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1048576 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024.0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024.0b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=524288 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=524288 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 == Check compat level option ==
 
 qemu-img create -f qcow2 -o compat=0.10 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=1.1 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.42 TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=foobar TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 == Check preallocation option ==
 
 qemu-img create -f qcow2 -o preallocation=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=off lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=off lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o preallocation=metadata TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=metadata lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o preallocation=1234 TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=1234 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=1234 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 == Check encryption option ==
 
 qemu-img create -f qcow2 -o encryption=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 --object secret,id=sec0,data=123456 -o encryption=on,encrypt.key-secret=sec0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=on encrypt.key-secret=sec0 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=on encrypt.key-secret=sec0 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 == Check lazy_refcounts option (only with v3) ==
 
 qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=on TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=on extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=on TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=on extended_l2=off refcount_bits=16
 
 *** done
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 09caaea865..bcd2f9fedf 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -20,6 +20,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: true
+    extended l2: false
 qemu-io: can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; cannot be opened read/write
 no file open, try 'help open'
 read 512/512 bytes at offset 0
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 413cc4e0f4..b7b2533e0a 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -26,7 +26,7 @@ header_length             104
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 magic                     0x514649fb
@@ -84,7 +84,7 @@ header_length             104
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 magic                     0x514649fb
@@ -140,7 +140,7 @@ header_length             104
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 ERROR cluster 5 refcount=0 reference=1
@@ -195,7 +195,7 @@ header_length             104
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 magic                     0x514649fb
@@ -264,7 +264,7 @@ header_length             104
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 read 65536/65536 bytes at offset 44040192
@@ -298,7 +298,7 @@ header_length             104
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 ERROR cluster 5 refcount=0 reference=1
@@ -327,7 +327,7 @@ header_length             104
 
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>
 
 read 131072/131072 bytes at offset 0
@@ -496,6 +496,7 @@ Format specific information:
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: false
     corrupt: false
+    extended l2: false
 No errors were found on the image.
 
 === Try changing the external data file ===
@@ -516,6 +517,7 @@ Format specific information:
     data file: foo
     data file raw: false
     corrupt: false
+    extended l2: false
 
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': 'data-file' is required for this image
 image: TEST_DIR/t.IMGFMT
@@ -528,6 +530,7 @@ Format specific information:
     refcount bits: 16
     data file raw: false
     corrupt: false
+    extended l2: false
 
 === Clearing and setting data-file-raw ===
 
@@ -543,6 +546,7 @@ Format specific information:
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: true
     corrupt: false
+    extended l2: false
 No errors were found on the image.
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -555,6 +559,7 @@ Format specific information:
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: false
     corrupt: false
+    extended l2: false
 No errors were found on the image.
 qemu-img: data-file-raw cannot be set on existing images
 image: TEST_DIR/t.IMGFMT
@@ -568,5 +573,6 @@ Format specific information:
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: false
     corrupt: false
+    extended l2: false
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 6426474271..386add05ae 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -95,17 +95,21 @@ class TestQCow3NotLazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled'''
     img_options = 'compat=1.1,lazy_refcounts=off'
     json_compare = { 'compat': '1.1', 'lazy-refcounts': False,
-                     'refcount-bits': 16, 'corrupt': False }
+                     'refcount-bits': 16, 'corrupt': False,
+                     'extended-l2': False }
     human_compare = [ 'compat: 1.1', 'lazy refcounts: false',
-                      'refcount bits: 16', 'corrupt: false' ]
+                      'refcount bits: 16', 'corrupt: false',
+                      'extended l2: false' ]
 
 class TestQCow3Lazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts enabled'''
     img_options = 'compat=1.1,lazy_refcounts=on'
     json_compare = { 'compat': '1.1', 'lazy-refcounts': True,
-                     'refcount-bits': 16, 'corrupt': False }
+                     'refcount-bits': 16, 'corrupt': False,
+                     'extended-l2': False }
     human_compare = [ 'compat: 1.1', 'lazy refcounts: true',
-                      'refcount bits: 16', 'corrupt: false' ]
+                      'refcount bits: 16', 'corrupt: false',
+                      'extended l2: false' ]
 
 class TestQCow3NotLazyQMP(TestQMP):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled, opening
@@ -113,7 +117,8 @@ class TestQCow3NotLazyQMP(TestQMP):
     img_options = 'compat=1.1,lazy_refcounts=off'
     qemu_options = 'lazy-refcounts=on'
     compare = { 'compat': '1.1', 'lazy-refcounts': False,
-                'refcount-bits': 16, 'corrupt': False }
+                'refcount-bits': 16, 'corrupt': False,
+                'extended-l2': False }
 
 
 class TestQCow3LazyQMP(TestQMP):
@@ -122,7 +127,8 @@ class TestQCow3LazyQMP(TestQMP):
     img_options = 'compat=1.1,lazy_refcounts=on'
     qemu_options = 'lazy-refcounts=off'
     compare = { 'compat': '1.1', 'lazy-refcounts': True,
-                'refcount-bits': 16, 'corrupt': False }
+                'refcount-bits': 16, 'corrupt': False,
+                'extended-l2': False }
 
 TestImageInfoSpecific = None
 TestQemuImgInfo = None
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 9d4ed4dc9d..2a01e8bac2 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -3,14 +3,14 @@ QA output created by 082
 === create: Options specified more than once ===
 
 Testing: create -f foo -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 
 Testing: create -f qcow2 -o cluster_size=4k -o lazy_refcounts=on TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=4096 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=4096 lazy_refcounts=on extended_l2=off refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -20,9 +20,10 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: create -f qcow2 -o cluster_size=4k -o lazy_refcounts=on -o cluster_size=8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=on extended_l2=off refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -32,9 +33,10 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: create -f qcow2 -o cluster_size=4k,cluster_size=8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=off extended_l2=off refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
@@ -59,6 +61,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -82,6 +85,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -105,6 +109,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -128,6 +133,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -151,6 +157,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -174,6 +181,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -197,6 +205,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -220,6 +229,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -227,10 +237,10 @@ Supported options:
   size=<size>            - Virtual disk size
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2, -o help TEST_DIR/t.qcow2 128M
 qemu-img: Invalid option list: backing_file=TEST_DIR/t.qcow2,
@@ -258,6 +268,7 @@ Supported qcow2 options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -279,7 +290,7 @@ qemu-img: Format driver 'bochs' does not support image creation
 === convert: Options specified more than once ===
 
 Testing: create -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 Testing: convert -f foo -f qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -302,6 +313,7 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: convert -O qcow2 -o cluster_size=4k -o lazy_refcounts=on -o cluster_size=8k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -313,6 +325,7 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: convert -O qcow2 -o cluster_size=4k,cluster_size=8k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -339,6 +352,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -362,6 +376,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -385,6 +400,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -408,6 +424,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -431,6 +448,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -454,6 +472,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -477,6 +496,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -500,6 +520,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -538,6 +559,7 @@ Supported qcow2 options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -582,6 +604,7 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: amend -f qcow2 -o size=130M -o lazy_refcounts=off TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
@@ -593,6 +616,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: amend -f qcow2 -o size=8M -o lazy_refcounts=on -o size=132M TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
@@ -604,6 +628,7 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Testing: amend -f qcow2 -o size=4M,size=148M TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
@@ -630,6 +655,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -654,6 +680,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -678,6 +705,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -702,6 +730,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -726,6 +755,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -750,6 +780,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -774,6 +805,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -798,6 +830,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
@@ -839,6 +872,7 @@ Creation options for 'qcow2':
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extended_l2=<bool (on/off)> - Extended L2 tables
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index fd11aae678..0142b2265f 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -13,7 +13,7 @@ Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=134217728
 === Create a single snapshot on virtio0 ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/1-snapshot-v0.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.1 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.1 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 
 === Invalid command - missing device and nodename ===
@@ -30,40 +30,40 @@ Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file
 === Create several transactional group snapshots ===
 
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/2-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/2-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/1-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/1-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
+Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/3-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/3-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
+Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/4-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/4-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
+Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/5-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/5-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
+Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/6-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/6-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
+Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/7-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/7-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
+Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/8-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/8-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
+Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/9-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/9-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
+Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 { 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR/10-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/10-snapshot-v1.IMGFMT' } } ] } }
-Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
+Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 
 === Create a couple of snapshots using blockdev-snapshot ===
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index c7aa2e4820..5d9aceaf13 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=536870912
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/tmp.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 
 === Performing block-commit on active layer ===
@@ -31,6 +31,6 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/
 === Performing Live Snapshot 2 ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0', 'snapshot-file':'TEST_DIR/tmp2.IMGFMT', 'format': 'IMGFMT' } }
-Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index a8eea166c3..84dc7a2360 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -13,7 +13,7 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node0', 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
 {'execute': 'blockdev-snapshot-sync', 'arguments': { 'node-name': 'node0', 'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'snapshot-node-name': 'node1' } }
-Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node1', 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 9a3b65782b..859fa7daaa 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -9,14 +9,14 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 === Creating backing chain ===
 
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 'snapshot-file': 'TEST_DIR/t.IMGFMT.mid', 'format': 'IMGFMT', 'mode': 'absolute-paths' } }
-Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 { 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu-io disk "write 0 4M"' } }
 wrote 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 'snapshot-file': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'absolute-paths' } }
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"return": {}}
 
 === Start commit job and exit qemu ===
@@ -48,7 +48,7 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'drive-mirror', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
@@ -62,7 +62,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 831ce3a289..f1e8cf7bab 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -72,6 +72,7 @@ Format specific information:
                 key offset: 1810432
         payload offset: 2068480
         master key iters: 1024
+    extended l2: false
 
 == checking image layer ==
 image: json:{ /* filtered */ }
@@ -115,4 +116,5 @@ Format specific information:
                 key offset: 1810432
         payload offset: 2068480
         master key iters: 1024
+    extended l2: false
 *** done
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 61e7241e0b..d2efc0394a 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -21,6 +21,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 === Successful image creation (inline blockdev-add, explicit defaults) ===
 
@@ -43,6 +44,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 === Successful image creation (v3 non-default options) ===
 
@@ -65,6 +67,7 @@ Format specific information:
     lazy refcounts: true
     refcount bits: 1
     corrupt: false
+    extended l2: false
 
 === Successful image creation (v2 non-default options) ===
 
@@ -141,6 +144,7 @@ Format specific information:
         payload offset: 528384
         master key iters: XXX
     corrupt: false
+    extended l2: false
 
 === Invalid BlockdevRef ===
 
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
index 7ac8404d11..0d32dd9148 100644
--- a/tests/qemu-iotests/242.out
+++ b/tests/qemu-iotests/242.out
@@ -15,6 +15,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 No bitmap in JSON format output
 
@@ -40,6 +41,7 @@ Format specific information:
             granularity: 32768
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 The same bitmaps in JSON format:
 [
@@ -77,6 +79,7 @@ Format specific information:
             granularity: 65536
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 The same bitmaps in JSON format:
 [
@@ -119,6 +122,7 @@ Format specific information:
             granularity: 65536
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 The same bitmaps in JSON format:
 [
@@ -162,5 +166,6 @@ Format specific information:
             granularity: 16384
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 Test complete
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
index 348909fdef..4e1b917a0f 100644
--- a/tests/qemu-iotests/255.out
+++ b/tests/qemu-iotests/255.out
@@ -3,9 +3,9 @@ Finishing a commit job with background reads
 
 === Create backing chain and start VM ===
 
-Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 === Start background read requests ===
 
@@ -23,9 +23,9 @@ Closing the VM while a job is being cancelled
 
 === Create images and start VM ===
 
-Formatting 'TEST_DIR/PID-src.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-src.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-dst.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-dst.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
index 9d6fdeb1f7..93afce30f5 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -1,9 +1,9 @@
 == Commit tests ==
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -55,6 +55,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -63,11 +64,11 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 === Testing HMP commit (top -> mid) ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -84,6 +85,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -92,11 +94,11 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 === Testing QMP active commit (top -> mid) ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -119,6 +121,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+    extended l2: false
 
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -128,9 +131,9 @@ read 1048576/1048576 bytes at offset 1048576
 
 == Resize tests ==
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=6442450944 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=6442450944 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=1073741824 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=1073741824 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 5368709120
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -147,9 +150,9 @@ read 65536/65536 bytes at offset 5368709120
 { "start": 1073741824, "length": 7516192768, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=metadata ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=34359738368 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=34359738368 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=32212254720 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=32212254720 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 33285996544
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -171,9 +174,9 @@ read 65536/65536 bytes at offset 33285996544
 { "start": 34896609280, "length": 536870912, "depth": 0, "zero": true, "data": false, "offset": 2685075456}]
 
 === preallocation=falloc ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=10485760 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=10485760 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=5242880 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=5242880 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 9437184
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -190,9 +193,9 @@ read 65536/65536 bytes at offset 9437184
 { "start": 5242880, "length": 10485760, "depth": 0, "zero": false, "data": true, "offset": 327680}]
 
 === preallocation=full ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=16777216 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=16777216 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=8388608 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=8388608 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 11534336
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -209,9 +212,9 @@ read 65536/65536 bytes at offset 11534336
 { "start": 8388608, "length": 4194304, "depth": 0, "zero": false, "data": true, "offset": 327680}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=393216 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=393216 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=259072 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=259072 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 259072
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -229,9 +232,9 @@ read 65536/65536 bytes at offset 259072
 { "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=409600 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=409600 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 344064
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -248,9 +251,9 @@ read 65536/65536 bytes at offset 344064
 { "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": false}]
 
 === preallocation=off ===
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=524288 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=524288 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 wrote 65536/65536 bytes at offset 446464
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
index 5d382faaa8..ef1aad1ae1 100644
--- a/tests/qemu-iotests/280.out
+++ b/tests/qemu-iotests/280.out
@@ -1,4 +1,4 @@
-Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off extended_l2=off refcount_bits=16
 
 === Launch VM ===
 Enabling migration QMP events on VM...
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 3f8ee3e5f7..db9793e7d9 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -146,6 +146,7 @@ _filter_img_create()
         -e "s# adapter_type=[^ ]*##g" \
         -e "s# hwversion=[^ ]*##g" \
         -e "s# lazy_refcounts=\\(on\\|off\\)##g" \
+        -e "s# extended_l2=\\(on\\|off\\)##g" \
         -e "s# block_size=[0-9]\\+##g" \
         -e "s# block_state_zero=\\(on\\|off\\)##g" \
         -e "s# log_size=[0-9]\\+##g" \
-- 
2.20.1


