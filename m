Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F85FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D336E20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co+v4ATa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D336E20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcp2-0003Vw-Vr
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcf6-00057r-7m
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcf3-00032v-BL
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590511360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnjlsxU8EC6R5JGu2gmb+BO+ZL3niFJnWJRxBYNIWA0=;
 b=Co+v4ATaNV7UBZmHLPsrTioCZGX/BwRz6FmmEULPhS73xjlh70hPkFjaANjKNibxYZPpCN
 sKFcl/ALDcUzsE1jwY0XffDJ5xWRnpb/D7BGr1Ms61xzXLyBrJ7ThJ/O3puQ01ENXkj4Sw
 Ym0miovnvdAA3mXdYfDOscaVoKjMfCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-Z9cituhvOguVYLiXDjxTeg-1; Tue, 26 May 2020 12:42:37 -0400
X-MC-Unique: Z9cituhvOguVYLiXDjxTeg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05FE9461;
 Tue, 26 May 2020 16:42:36 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7C2648DB;
 Tue, 26 May 2020 16:42:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] qcow2: Expose bitmaps' size during measure
Date: Tue, 26 May 2020 11:42:08 -0500
Message-Id: <20200526164211.1569366-9-eblake@redhat.com>
In-Reply-To: <20200526164211.1569366-1-eblake@redhat.com>
References: <20200526164211.1569366-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's useful to know how much space can be occupied by qcow2 persistent
bitmaps, even though such metadata is unrelated to the guest-visible
data.  Report this value as an additional QMP field, present when
measuring an existing image and output format that both support
bitmaps.  Update iotest 178 and 190 to updated output, as well as new
coverage in 190 demonstrating non-zero values made possible with the
recently-added qemu-img bitmap command (see 3b51ab4b).

The new 'bitmaps size:' field is displayed automatically as part of
'qemu-img measure' any time it is present in QMP (that is, any time
both the source image being measured and destination format support
bitmaps, even if the measurement is 0 because there are no bitmaps
present).  If the field is absent, it means that no bitmaps can be
copied (source, destination, or both lack bitmaps, including when
measuring based on size rather than on a source image).  This behavior
is compatible with an upcoming patch adding 'qemu-img convert
--bitmaps': that command will fail in the same situations where this
patch omits the field.

The addition of a new field demonstrates why we should always
zero-initialize qapi C structs; while the qcow2 driver still fully
populates all fields, the raw and crypto drivers had to be tweaked to
avoid uninitialized data.

Consideration was also given towards having a 'qemu-img measure
--bitmaps' which errors out when bitmaps are not possible, and
otherwise sums the bitmaps into the existing allocation totals rather
than displaying as a separate field, as a potential convenience
factor.  But this was ultimately decided to be more complexity than
necessary when the QMP interface was sufficient enough with bitmaps
remaining a separate field.

See also: https://bugzilla.redhat.com/1779904

Reported-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200521192137.1120211-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/tools/qemu-img.rst          |  7 +++++
 qapi/block-core.json             | 16 ++++++++----
 block/qcow2.h                    |  2 ++
 block/crypto.c                   |  2 +-
 block/qcow2-bitmap.c             | 36 +++++++++++++++++++++++++
 block/qcow2.c                    | 14 +++++++---
 block/raw-format.c               |  2 +-
 qemu-img.c                       |  3 +++
 tests/qemu-iotests/178.out.qcow2 | 16 ++++++++++++
 tests/qemu-iotests/190           | 45 ++++++++++++++++++++++++++++++--
 tests/qemu-iotests/190.out       | 27 ++++++++++++++++++-
 11 files changed, 157 insertions(+), 13 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 38d464ea3f23..320cb52b9f61 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -616,6 +616,7 @@ Command description:

     required size: 524288
     fully allocated size: 1074069504
+    bitmaps size: 0

   The ``required size`` is the file size of the new image.  It may be smaller
   than the virtual disk size if the image format supports compact representation.
@@ -625,6 +626,12 @@ Command description:
   occupy with the exception of internal snapshots, dirty bitmaps, vmstate data,
   and other advanced image format features.

+  The ``bitmaps size`` is the additional size required in order to
+  copy bitmaps from a source image in addition to the guest-visible
+  data; the line is omitted if either source or destination lacks
+  bitmap support, or 0 if bitmaps are supported but there is nothing
+  to copy.
+
 .. option:: snapshot [--object OBJECTDEF] [--image-opts] [-U] [-q] [-l | -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME

   List, apply, create or delete snapshots in image *FILENAME*.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6fbacddab2cc..0e1c6a59f228 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -636,18 +636,24 @@
 # efficiently so file size may be smaller than virtual disk size.
 #
 # The values are upper bounds that are guaranteed to fit the new image file.
-# Subsequent modification, such as internal snapshot or bitmap creation, may
-# require additional space and is not covered here.
+# Subsequent modification, such as internal snapshot or further bitmap
+# creation, may require additional space and is not covered here.
 #
-# @required: Size required for a new image file, in bytes.
+# @required: Size required for a new image file, in bytes, when copying just
+#            allocated guest-visible contents.
 #
 # @fully-allocated: Image file size, in bytes, once data has been written
-#                   to all sectors.
+#                   to all sectors, when copying just guest-visible contents.
+#
+# @bitmaps: Additional size required if all the top-level bitmap metadata
+#           in the source image were to be copied to the destination,
+#           present only when source and destination both support
+#           persistent bitmaps. (since 5.1)
 #
 # Since: 2.10
 ##
 { 'struct': 'BlockMeasureInfo',
-  'data': {'required': 'int', 'fully-allocated': 'int'} }
+  'data': {'required': 'int', 'fully-allocated': 'int', '*bitmaps': 'int'} }

 ##
 # @query-block:
diff --git a/block/qcow2.h b/block/qcow2.h
index 402e8acb1cb7..7ce2c23bdb7a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -783,6 +783,8 @@ int qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                             const char *name,
                                             Error **errp);
 bool qcow2_supports_persistent_dirty_bitmap(BlockDriverState *bs);
+uint64_t qcow2_get_persistent_dirty_bitmap_size(BlockDriverState *bs,
+                                                uint32_t cluster_size);

 ssize_t coroutine_fn
 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
diff --git a/block/crypto.c b/block/crypto.c
index b216e12c3154..973b57b3eb74 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -552,7 +552,7 @@ static BlockMeasureInfo *block_crypto_measure(QemuOpts *opts,
      * Unallocated blocks are still encrypted so allocation status makes no
      * difference to the file size.
      */
-    info = g_new(BlockMeasureInfo, 1);
+    info = g_new0(BlockMeasureInfo, 1);
     info->fully_allocated = luks_payload_size + size;
     info->required = luks_payload_size + size;
     return info;
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 1cf6d2ab77a3..7bf12502da8c 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1755,3 +1755,39 @@ bool qcow2_supports_persistent_dirty_bitmap(BlockDriverState *bs)

     return s->qcow_version >= 3;
 }
+
+/*
+ * Compute the space required for bitmaps in @bs.
+ *
+ * The computation is based as if copying to a new image with the
+ * given @cluster_size, which may differ from the cluster size in @bs.
+ */
+uint64_t qcow2_get_persistent_dirty_bitmap_size(BlockDriverState *bs,
+                                                uint32_t cluster_size)
+{
+    uint64_t bitmaps_size = 0;
+    BdrvDirtyBitmap *bm;
+    size_t bitmap_dir_size = 0;
+
+    FOR_EACH_DIRTY_BITMAP(bs, bm) {
+        if (bdrv_dirty_bitmap_get_persistence(bm)) {
+            const char *name = bdrv_dirty_bitmap_name(bm);
+            uint32_t granularity = bdrv_dirty_bitmap_granularity(bm);
+            uint64_t bmbytes =
+                get_bitmap_bytes_needed(bdrv_dirty_bitmap_size(bm),
+                                        granularity);
+            uint64_t bmclusters = DIV_ROUND_UP(bmbytes, cluster_size);
+
+            /* Assume the entire bitmap is allocated */
+            bitmaps_size += bmclusters * cluster_size;
+            /* Also reserve space for the bitmap table entries */
+            bitmaps_size += ROUND_UP(bmclusters * sizeof(uint64_t),
+                                     cluster_size);
+            /* And space for contribution to bitmap directory size */
+            bitmap_dir_size += calc_dir_entry_size(strlen(name), 0);
+        }
+    }
+    bitmaps_size += ROUND_UP(bitmap_dir_size, cluster_size);
+
+    return bitmaps_size;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index dfab8d2f6cd8..0cd2e6757e8c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4953,16 +4953,24 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
         required = virtual_size;
     }

-    info = g_new(BlockMeasureInfo, 1);
+    info = g_new0(BlockMeasureInfo, 1);
     info->fully_allocated =
         qcow2_calc_prealloc_size(virtual_size, cluster_size,
                                  ctz32(refcount_bits)) + luks_payload_size;

-    /* Remove data clusters that are not required.  This overestimates the
+    /*
+     * Remove data clusters that are not required.  This overestimates the
      * required size because metadata needed for the fully allocated file is
-     * still counted.
+     * still counted.  Show bitmaps only if both source and destination
+     * would support them.
      */
     info->required = info->fully_allocated - virtual_size + required;
+    info->has_bitmaps = version >= 3 && in_bs &&
+        bdrv_supports_persistent_dirty_bitmap(in_bs);
+    if (info->has_bitmaps) {
+        info->bitmaps = qcow2_get_persistent_dirty_bitmap_size(in_bs,
+                                                               cluster_size);
+    }
     return info;

 err:
diff --git a/block/raw-format.c b/block/raw-format.c
index 018441bddf27..233d019ca338 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -359,7 +359,7 @@ static BlockMeasureInfo *raw_measure(QemuOpts *opts, BlockDriverState *in_bs,
                             BDRV_SECTOR_SIZE);
     }

-    info = g_new(BlockMeasureInfo, 1);
+    info = g_new0(BlockMeasureInfo, 1);
     info->required = required;

     /* Unallocated sectors count towards the file size in raw images */
diff --git a/qemu-img.c b/qemu-img.c
index 2d30682f129f..b2311bd3f6b4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5302,6 +5302,9 @@ static int img_measure(int argc, char **argv)
     if (output_format == OFORMAT_HUMAN) {
         printf("required size: %" PRIu64 "\n", info->required);
         printf("fully allocated size: %" PRIu64 "\n", info->fully_allocated);
+        if (info->has_bitmaps) {
+            printf("bitmaps size: %" PRIu64 "\n", info->bitmaps);
+        }
     } else {
         dump_json_block_measure_info(info);
     }
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.qcow2
index 4b69524c80ee..c7997760fd6f 100644
--- a/tests/qemu-iotests/178.out.qcow2
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -37,6 +37,7 @@ qemu-img: The image size is too large (try using a larger cluster size)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
 required size: 196608
 fully allocated size: 196608
+bitmaps size: 0

 converted image file size in bytes: 196608

@@ -45,6 +46,7 @@ converted image file size in bytes: 196608
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 required size: 393216
 fully allocated size: 1074135040
+bitmaps size: 0
 wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 65536
@@ -53,6 +55,7 @@ wrote 64512/64512 bytes at offset 134217728
 63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 required size: 589824
 fully allocated size: 1074135040
+bitmaps size: 0

 converted image file size in bytes: 524288

@@ -60,6 +63,7 @@ converted image file size in bytes: 524288

 required size: 524288
 fully allocated size: 1074135040
+bitmaps size: 0

 converted image file size in bytes: 458752

@@ -67,16 +71,19 @@ converted image file size in bytes: 458752

 required size: 1074135040
 fully allocated size: 1074135040
+bitmaps size: 0

 == qcow2 input image and LUKS encryption ==

 required size: 2686976
 fully allocated size: 1076232192
+bitmaps size: 0

 == qcow2 input image and preallocation (human) ==

 required size: 1074135040
 fully allocated size: 1074135040
+bitmaps size: 0

 converted image file size in bytes: 1074135040

@@ -87,6 +94,7 @@ wrote 8388608/8388608 bytes at offset 0
 8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 required size: 8716288
 fully allocated size: 8716288
+bitmaps size: 0

 converted image file size in bytes: 8716288

@@ -173,6 +181,7 @@ qemu-img: The image size is too large (try using a larger cluster size)

 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
 {
+    "bitmaps": 0,
     "required": 196608,
     "fully-allocated": 196608
 }
@@ -183,6 +192,7 @@ converted image file size in bytes: 196608

 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 {
+    "bitmaps": 0,
     "required": 393216,
     "fully-allocated": 1074135040
 }
@@ -193,6 +203,7 @@ wrote 65536/65536 bytes at offset 65536
 wrote 64512/64512 bytes at offset 134217728
 63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {
+    "bitmaps": 0,
     "required": 589824,
     "fully-allocated": 1074135040
 }
@@ -202,6 +213,7 @@ converted image file size in bytes: 524288
 == qcow2 input image with internal snapshot (json) ==

 {
+    "bitmaps": 0,
     "required": 524288,
     "fully-allocated": 1074135040
 }
@@ -211,6 +223,7 @@ converted image file size in bytes: 458752
 == qcow2 input image and a backing file (json) ==

 {
+    "bitmaps": 0,
     "required": 1074135040,
     "fully-allocated": 1074135040
 }
@@ -218,6 +231,7 @@ converted image file size in bytes: 458752
 == qcow2 input image and LUKS encryption ==

 {
+    "bitmaps": 0,
     "required": 2686976,
     "fully-allocated": 1076232192
 }
@@ -225,6 +239,7 @@ converted image file size in bytes: 458752
 == qcow2 input image and preallocation (json) ==

 {
+    "bitmaps": 0,
     "required": 1074135040,
     "fully-allocated": 1074135040
 }
@@ -237,6 +252,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=8388608
 wrote 8388608/8388608 bytes at offset 0
 8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {
+    "bitmaps": 0,
     "required": 8716288,
     "fully-allocated": 8716288
 }
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 6d41650438e1..0c37862c6709 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -2,7 +2,7 @@
 #
 # qemu-img measure sub-command tests on huge qcow2 files
 #
-# Copyright (C) 2017 Red Hat, Inc.
+# Copyright (C) 2017-2020 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file

-echo "== Huge file =="
+echo "== Huge file without bitmaps =="
 echo

 _make_test_img -o 'cluster_size=2M' 2T
@@ -51,6 +51,47 @@ $QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
 $QEMU_IMG measure -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
 $QEMU_IMG measure -O qcow2 -o cluster_size=2M -f qcow2 "$TEST_IMG"

+echo
+echo "== Huge file with bitmaps =="
+echo
+
+$QEMU_IMG bitmap --add --granularity 512 -f qcow2 "$TEST_IMG" b1
+$QEMU_IMG bitmap --add -g 2M -f qcow2 "$TEST_IMG" b2
+
+# No bitmap without a source
+$QEMU_IMG measure -O qcow2 --size 10M
+# No bitmap output, since raw does not support it
+$QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
+# No bitmap output, since no bitmaps on raw source
+$QEMU_IMG measure -O qcow2 -f raw "$TEST_IMG"
+# No bitmap output, since v2 does not support it
+$QEMU_IMG measure -O qcow2 -o compat=0.10 -f qcow2 "$TEST_IMG"
+
+# Compute expected output: bitmap clusters + bitmap tables + bitmaps directory
+echo
+val2T=$((2*1024*1024*1024*1024))
+cluster=$((64*1024))
+b1clusters=$(( (val2T/512/8 + cluster - 1) / cluster ))
+b2clusters=$(( (val2T/2/1024/1024/8 + cluster - 1) / cluster ))
+echo expected bitmap $((b1clusters * cluster +
+                        (b1clusters * 8 + cluster - 1) / cluster * cluster +
+                        b2clusters * cluster +
+                        (b2clusters * 8 + cluster - 1) / cluster * cluster +
+                        cluster))
+$QEMU_IMG measure -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
+
+# Compute expected output: bitmap clusters + bitmap tables + bitmaps directory
+echo
+cluster=$((2*1024*1024))
+b1clusters=$(( (val2T/512/8 + cluster - 1) / cluster ))
+b2clusters=$(( (val2T/2/1024/1024/8 + cluster - 1) / cluster ))
+echo expected bitmap $((b1clusters * cluster +
+                        (b1clusters * 8 + cluster - 1) / cluster * cluster +
+                        b2clusters * cluster +
+                        (b2clusters * 8 + cluster - 1) / cluster * cluster +
+                        cluster))
+$QEMU_IMG measure --output=json -O qcow2 -o cluster_size=2M -f qcow2 "$TEST_IMG"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/190.out b/tests/qemu-iotests/190.out
index d001942002db..e9c5a2e1e481 100644
--- a/tests/qemu-iotests/190.out
+++ b/tests/qemu-iotests/190.out
@@ -1,11 +1,36 @@
 QA output created by 190
-== Huge file ==
+== Huge file without bitmaps ==

 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2199023255552
 required size: 2199023255552
 fully allocated size: 2199023255552
 required size: 335806464
 fully allocated size: 2199359062016
+bitmaps size: 0
 required size: 18874368
 fully allocated size: 2199042129920
+bitmaps size: 0
+
+== Huge file with bitmaps ==
+
+required size: 327680
+fully allocated size: 10813440
+required size: 2199023255552
+fully allocated size: 2199023255552
+required size: 7012352
+fully allocated size: 17170432
+required size: 335806464
+fully allocated size: 2199359062016
+
+expected bitmap 537198592
+required size: 335806464
+fully allocated size: 2199359062016
+bitmaps size: 537198592
+
+expected bitmap 545259520
+{
+    "bitmaps": 545259520,
+    "required": 18874368,
+    "fully-allocated": 2199042129920
+}
 *** done
-- 
2.26.2


