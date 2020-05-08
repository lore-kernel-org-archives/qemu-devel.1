Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF5EC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA1A20746
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hni3rKWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA1A20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7R2-0001Hl-4i
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX7Lp-0000Ex-Oj
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:03:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX7Lo-0007Se-5n
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588961035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dx9qEWC661Ly8+zLBn9gRB4mebS5W7U6GluC841n62c=;
 b=Hni3rKWz+W+57SN6mDY8Zc34CbnTpyMOSi9xCyVwnmyWwfwY43+J69ejz67tfz6r6iB88j
 GhFzSq6bsOLTHjmRiLcva0iK/cKAKdqOEJFyiX4hN/CO8/DQFQXh5l61SKfuE/gXz5urBd
 59diP4siFdIyP1mLEZ/q/ZdLKIa8y8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-ICnD_VyVMva5bEUy4uL3ng-1; Fri, 08 May 2020 14:03:53 -0400
X-MC-Unique: ICnD_VyVMva5bEUy4uL3ng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBFB37BAD;
 Fri,  8 May 2020 18:03:52 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D05C26198A;
 Fri,  8 May 2020 18:03:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/9] qcow2: Expose bitmaps' size during measure
Date: Fri,  8 May 2020 13:03:38 -0500
Message-Id: <20200508180340.675712-8-eblake@redhat.com>
In-Reply-To: <20200508180340.675712-1-eblake@redhat.com>
References: <20200508180340.675712-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Nir Soffer <nsoffer@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's useful to know how much space can be occupied by qcow2 persistent
bitmaps, even though such metadata is unrelated to the guest-visible
data.  Report this value as an additional field, present when
measuring an existing image and the output format supports bitmaps.
Update iotest 178 and 190 to updated output, as well as new coverage
in 190 demonstrating non-zero values made possible with the
recently-added qemu-img bitmap command.

The addition of a new field demonstrates why we should always
zero-initialize qapi C structs; while the qcow2 driver still fully
populates all fields, the raw and crypto drivers had to be tweaked to
avoid uninitialized data.

See also: https://bugzilla.redhat.com/1779904

Reported-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json             | 15 +++++++----
 block/crypto.c                   |  2 +-
 block/qcow2.c                    | 37 ++++++++++++++++++++++++---
 block/raw-format.c               |  2 +-
 qemu-img.c                       |  3 +++
 tests/qemu-iotests/178.out.qcow2 | 16 ++++++++++++
 tests/qemu-iotests/190           | 43 ++++++++++++++++++++++++++++++--
 tests/qemu-iotests/190.out       | 23 ++++++++++++++++-
 8 files changed, 128 insertions(+), 13 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 943df1926a91..9a7a388c7ad3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -633,18 +633,23 @@
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
+#            guest-visible contents.
 #
 # @fully-allocated: Image file size, in bytes, once data has been written
-#                   to all sectors.
+#                   to all sectors, when copying just guest-visible contents.
+#
+# @bitmaps: Additional size required for bitmap metadata in a source image,
+#           if that bitmap metadata can be copied in addition to guest
+#           contents. (since 5.1)
 #
 # Since: 2.10
 ##
 { 'struct': 'BlockMeasureInfo',
-  'data': {'required': 'int', 'fully-allocated': 'int'} }
+  'data': {'required': 'int', 'fully-allocated': 'int', '*bitmaps': 'int'} }

 ##
 # @query-block:
diff --git a/block/crypto.c b/block/crypto.c
index 6b21d6bf6c01..eadbcb248563 100644
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
diff --git a/block/qcow2.c b/block/qcow2.c
index 838d810ca5ec..f836a6047879 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4721,6 +4721,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     PreallocMode prealloc;
     bool has_backing_file;
     bool has_luks;
+    uint64_t bitmaps_size = 0; /* size occupied by bitmaps in in_bs */

     /* Parse image creation options */
     cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
@@ -4796,13 +4797,38 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,

     /* Account for input image */
     if (in_bs) {
+        BdrvDirtyBitmap *bm;
+        size_t bitmap_dir_size = 0;
         int64_t ssize = bdrv_getlength(in_bs);
+
         if (ssize < 0) {
             error_setg_errno(&local_err, -ssize,
                              "Unable to get image virtual_size");
             goto err;
         }

+        FOR_EACH_DIRTY_BITMAP(in_bs, bm) {
+            if (bdrv_dirty_bitmap_get_persistence(bm)) {
+                const char *name = bdrv_dirty_bitmap_name(bm);
+                uint32_t granularity = bdrv_dirty_bitmap_granularity(bm);
+                uint64_t bmbits = DIV_ROUND_UP(bdrv_dirty_bitmap_size(bm),
+                                               granularity);
+                uint64_t bmclusters = DIV_ROUND_UP(DIV_ROUND_UP(bmbits,
+                                                                CHAR_BIT),
+                                                   cluster_size);
+
+                /* Assume the entire bitmap is allocated */
+                bitmaps_size += bmclusters * cluster_size;
+                /* Also reserve space for the bitmap table entries */
+                bitmaps_size += ROUND_UP(bmclusters * sizeof(uint64_t),
+                                         cluster_size);
+                /* And space for contribution to bitmap directory size */
+                bitmap_dir_size += ROUND_UP(strlen(name) + 24,
+                                            sizeof(uint64_t));
+            }
+        }
+        bitmaps_size += ROUND_UP(bitmap_dir_size, cluster_size);
+
         virtual_size = ROUND_UP(ssize, cluster_size);

         if (has_backing_file) {
@@ -4849,16 +4875,21 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
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
+        bdrv_dirty_bitmap_supported(in_bs);
+    info->bitmaps = bitmaps_size;
     return info;

 err:
diff --git a/block/raw-format.c b/block/raw-format.c
index 9108e4369628..a134b1954ca2 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -346,7 +346,7 @@ static BlockMeasureInfo *raw_measure(QemuOpts *opts, BlockDriverState *in_bs,
                             BDRV_SECTOR_SIZE);
     }

-    info = g_new(BlockMeasureInfo, 1);
+    info = g_new0(BlockMeasureInfo, 1);
     info->required = required;

     /* Unallocated sectors count towards the file size in raw images */
diff --git a/qemu-img.c b/qemu-img.c
index 7ad86f7b8072..0e747247e0c5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5278,6 +5278,9 @@ static int img_measure(int argc, char **argv)
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
index f59bf4b2fbc4..0c6ca5e05713 100644
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
index 6d41650438e1..1b5fff45bfcd 100755
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
@@ -51,6 +51,45 @@ $QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
 $QEMU_IMG measure -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
 $QEMU_IMG measure -O qcow2 -o cluster_size=2M -f qcow2 "$TEST_IMG"

+echo
+echo "== Huge file with bitmaps =="
+echo
+
+$QEMU_IMG bitmap --add --granularity 512 -f qcow2 "$TEST_IMG" b1
+$QEMU_IMG bitmap --add -g 2M -f qcow2 "$TEST_IMG" b2
+
+# No bitmap output, since raw does not support it
+$QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
+# No bitmap output, since no bitmaps on raw source
+$QEMU_IMG measure -O qcow2 -f raw "$TEST_IMG"
+# No bitmap output, since v2 does not support it
+$QEMU_IMG measure -O qcow2 -o compat=0.10 -f qcow2 "$TEST_IMG"
+
+# Compute expected output:
+echo
+val2T=$((2*1024*1024*1024*1024))
+cluster=$((64*1024))
+b1clusters=$(( (val2T/512/8 + cluster - 1) / cluster ))
+b2clusters=$(( (val2T/2/1024/1024/8 + cluster - 1) / cluster ))
+echo expected bitmap $((b1clusters * cluster +
+			(b1clusters * 8 + cluster - 1) / cluster * cluster +
+			b2clusters * cluster +
+			(b2clusters * 8 + cluster - 1) / cluster * cluster +
+			cluster))
+$QEMU_IMG measure -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
+
+# Compute expected output:
+echo
+cluster=$((2*1024*1024))
+b1clusters=$(( (val2T/512/8 + cluster - 1) / cluster ))
+b2clusters=$(( (val2T/2/1024/1024/8 + cluster - 1) / cluster ))
+echo expected bitmap $((b1clusters * cluster +
+			(b1clusters * 8 + cluster - 1) / cluster * cluster +
+			b2clusters * cluster +
+			(b2clusters * 8 + cluster - 1) / cluster * cluster +
+			cluster))
+$QEMU_IMG measure -O qcow2 -o cluster_size=2M -f qcow2 "$TEST_IMG"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/190.out b/tests/qemu-iotests/190.out
index d001942002db..6d5a25e9de2f 100644
--- a/tests/qemu-iotests/190.out
+++ b/tests/qemu-iotests/190.out
@@ -1,11 +1,32 @@
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
+required size: 18874368
+fully allocated size: 2199042129920
+bitmaps size: 545259520
 *** done
-- 
2.26.2


