Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B07C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A961120732
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1w+h5wU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A961120732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTxJ-0001xf-S7
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 12:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jPTwV-0001TS-CB
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jPTwT-0001jm-EQ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:34:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23590
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jPTwR-0001iK-BP
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587141250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/lAM1fTbJ5nnvXZ6JvIEg0cXeU+Gq5rvTmLmP+YWIes=;
 b=d1w+h5wUyn7Tccqt6VlTx2PBdvmSMlFLyjJ2W5PYLczSfMotoawKsYc3fi7x/1x87V93Yt
 lYMJ0ig0x8MS4VaxXlX4hysfbTMK/bfd2PTal6esDHC6qdX8HnnEnbU9N/4zDtc5DxGfyj
 0X6OPU4/FsKFuZ6BYGU5Z9cUh4x9Fr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-rx01fEH8NWmFz3M3ULoGtg-1; Fri, 17 Apr 2020 12:34:08 -0400
X-MC-Unique: rx01fEH8NWmFz3M3ULoGtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B679B802564;
 Fri, 17 Apr 2020 16:34:07 +0000 (UTC)
Received: from blue.redhat.com (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD9301001925;
 Fri, 17 Apr 2020 16:34:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] qcow2: Expose bitmaps' size during measure
Date: Fri, 17 Apr 2020 11:34:01 -0500
Message-Id: <20200417163402.834200-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's useful to know how much space can be occupied by qcow2 persistent
bitmaps, even though such metadata is unrelated to the guest-visible
data.  Report this value as an additional field.  Update iotest 190 to
cover it.

The addition of a new field demonstrates why we should always
zero-initialize qapi C structs; while the qcow2 driver still fully
populates all fields, the raw and crypto drivers had to be tweaked.

See also: https://bugzilla.redhat.com/1779904

Reported-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

In v2:
- fix uninit memory [patchew]
- add BZ number [Nir]
- add iotest coverage

 qapi/block-core.json       | 15 ++++++++----
 block/crypto.c             |  2 +-
 block/qcow2.c              | 29 +++++++++++++++++++++-
 block/raw-format.c         |  2 +-
 qemu-img.c                 |  3 +++
 tests/qemu-iotests/190     | 50 ++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/190.out | 20 ++++++++++++++-
 7 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 943df1926a91..b47c6d69ba27 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -633,18 +633,23 @@
 # efficiently so file size may be smaller than virtual disk size.
 #
 # The values are upper bounds that are guaranteed to fit the new image fil=
e.
-# Subsequent modification, such as internal snapshot or bitmap creation, m=
ay
-# require additional space and is not covered here.
+# Subsequent modification, such as internal snapshot or further bitmap
+# creation, may require additional space and is not covered here.
 #
-# @required: Size required for a new image file, in bytes.
+# @required: Size required for a new image file, in bytes, when copying ju=
st
+#            guest-visible contents.
 #
 # @fully-allocated: Image file size, in bytes, once data has been written
-#                   to all sectors.
+#                   to all sectors, when copying just guest-visible conten=
ts.
+#
+# @bitmaps: Additional size required for bitmap metadata not directly used
+#           for guest contents, when that metadata can be copied in additi=
on
+#           to guest contents. (since 5.1)
 #
 # Since: 2.10
 ##
 { 'struct': 'BlockMeasureInfo',
-  'data': {'required': 'int', 'fully-allocated': 'int'} }
+  'data': {'required': 'int', 'fully-allocated': 'int', '*bitmaps': 'int'}=
 }

 ##
 # @query-block:
diff --git a/block/crypto.c b/block/crypto.c
index d577f89659fa..4e0f3ec97f0e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -535,7 +535,7 @@ static BlockMeasureInfo *block_crypto_measure(QemuOpts =
*opts,
      * Unallocated blocks are still encrypted so allocation status makes n=
o
      * difference to the file size.
      */
-    info =3D g_new(BlockMeasureInfo, 1);
+    info =3D g_new0(BlockMeasureInfo, 1);
     info->fully_allocated =3D luks_payload_size + size;
     info->required =3D luks_payload_size + size;
     return info;
diff --git a/block/qcow2.c b/block/qcow2.c
index b524b0c53f84..9fd650928016 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4657,6 +4657,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts=
, BlockDriverState *in_bs,
     PreallocMode prealloc;
     bool has_backing_file;
     bool has_luks;
+    uint64_t bitmaps_size =3D 0; /* size occupied by bitmaps in in_bs */

     /* Parse image creation options */
     cluster_size =3D qcow2_opt_get_cluster_size_del(opts, &local_err);
@@ -4732,6 +4733,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts=
, BlockDriverState *in_bs,

     /* Account for input image */
     if (in_bs) {
+        BdrvDirtyBitmap *bm;
+        size_t bitmap_overhead =3D 0;
         int64_t ssize =3D bdrv_getlength(in_bs);
         if (ssize < 0) {
             error_setg_errno(&local_err, -ssize,
@@ -4739,6 +4742,28 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opt=
s, BlockDriverState *in_bs,
             goto err;
         }

+        FOR_EACH_DIRTY_BITMAP(in_bs, bm) {
+            if (bdrv_dirty_bitmap_get_persistence(bm)) {
+                const char *name =3D bdrv_dirty_bitmap_name(bm);
+                uint32_t granularity =3D bdrv_dirty_bitmap_granularity(bm)=
;
+                uint64_t bmbits =3D DIV_ROUND_UP(bdrv_dirty_bitmap_size(bm=
),
+                                               granularity);
+                uint64_t bmclusters =3D DIV_ROUND_UP(DIV_ROUND_UP(bmbits,
+                                                                CHAR_BIT),
+                                                   cluster_size);
+
+                /* Assume the entire bitmap is allocated */
+                bitmaps_size +=3D bmclusters * cluster_size;
+                /* Also reserve space for the bitmap table entries */
+                bitmaps_size +=3D ROUND_UP(bmclusters * sizeof(uint64_t),
+                                         cluster_size);
+                /* Guess at contribution to bitmap directory size */
+                bitmap_overhead +=3D ROUND_UP(strlen(name) + 24,
+                                            sizeof(uint64_t));
+            }
+        }
+        bitmaps_size +=3D ROUND_UP(bitmap_overhead, cluster_size);
+
         virtual_size =3D ROUND_UP(ssize, cluster_size);

         if (has_backing_file) {
@@ -4785,7 +4810,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts=
, BlockDriverState *in_bs,
         required =3D virtual_size;
     }

-    info =3D g_new(BlockMeasureInfo, 1);
+    info =3D g_new0(BlockMeasureInfo, 1);
     info->fully_allocated =3D
         qcow2_calc_prealloc_size(virtual_size, cluster_size,
                                  ctz32(refcount_bits)) + luks_payload_size=
;
@@ -4795,6 +4820,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts=
, BlockDriverState *in_bs,
      * still counted.
      */
     info->required =3D info->fully_allocated - virtual_size + required;
+    info->has_bitmaps =3D !!bitmaps_size;
+    info->bitmaps =3D bitmaps_size;
     return info;

 err:
diff --git a/block/raw-format.c b/block/raw-format.c
index 93b25e1b6b0b..4bb54f4ac6c5 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -346,7 +346,7 @@ static BlockMeasureInfo *raw_measure(QemuOpts *opts, Bl=
ockDriverState *in_bs,
                             BDRV_SECTOR_SIZE);
     }

-    info =3D g_new(BlockMeasureInfo, 1);
+    info =3D g_new0(BlockMeasureInfo, 1);
     info->required =3D required;

     /* Unallocated sectors count towards the file size in raw images */
diff --git a/qemu-img.c b/qemu-img.c
index 6541357179c2..d900bde89911 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5084,6 +5084,9 @@ static int img_measure(int argc, char **argv)
     if (output_format =3D=3D OFORMAT_HUMAN) {
         printf("required size: %" PRIu64 "\n", info->required);
         printf("fully allocated size: %" PRIu64 "\n", info->fully_allocate=
d);
+        if (info->has_bitmaps) {
+            printf("bitmaps size: %" PRIu64 "\n", info->bitmaps);
+        }
     } else {
         dump_json_block_measure_info(info);
     }
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 6d41650438e1..15a1c8d4227a 100755
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
@@ -42,7 +42,19 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file

-echo "=3D=3D Huge file =3D=3D"
+do_run_qemu()
+{
+    echo Testing: "$@"
+    $QEMU -nographic -qmp stdio -serial none "$@"
+    echo
+}
+
+run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp
+}
+
+echo "=3D=3D Huge file without bitmaps =3D=3D"
 echo

 _make_test_img -o 'cluster_size=3D2M' 2T
@@ -51,6 +63,40 @@ $QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
 $QEMU_IMG measure -O qcow2 -o cluster_size=3D64k -f qcow2 "$TEST_IMG"
 $QEMU_IMG measure -O qcow2 -o cluster_size=3D2M -f qcow2 "$TEST_IMG"

+echo
+echo "=3D=3D Huge file with bitmaps =3D=3D"
+echo
+
+run_qemu -blockdev \
+    driver=3Dqcow2,node-name=3Dn,file.driver=3Dfile,file.filename=3D"$TEST=
_IMG" <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "transaction",
+  "arguments": {
+    "actions": [
+      { "type": "block-dirty-bitmap-add",
+        "data": {
+          "node": "n",
+          "name": "b1",
+          "persistent": true,
+          "granularity": 512
+        } },
+      { "type": "block-dirty-bitmap-add",
+        "data": {
+          "node": "n",
+          "name": "b2",
+          "persistent": true,
+          "granularity": 2097152
+       } }
+    ]
+  }
+}
+{ "execute": "quit" }
+EOF
+
+$QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
+$QEMU_IMG measure -O qcow2 -o cluster_size=3D64k -f qcow2 "$TEST_IMG"
+$QEMU_IMG measure -O qcow2 -o cluster_size=3D2M -f qcow2 "$TEST_IMG"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/190.out b/tests/qemu-iotests/190.out
index d001942002db..5511d53e7e7c 100644
--- a/tests/qemu-iotests/190.out
+++ b/tests/qemu-iotests/190.out
@@ -1,5 +1,5 @@
 QA output created by 190
-=3D=3D Huge file =3D=3D
+=3D=3D Huge file without bitmaps =3D=3D

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2199023255552
 required size: 2199023255552
@@ -8,4 +8,22 @@ required size: 335806464
 fully allocated size: 2199359062016
 required size: 18874368
 fully allocated size: 2199042129920
+
+=3D=3D Huge file with bitmaps =3D=3D
+
+Testing: -blockdev driver=3Dqcow2,node-name=3Dn,file.driver=3Dfile,file.fi=
lename=3DTEST_DIR/t.qcow2
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+required size: 2199023255552
+fully allocated size: 2199023255552
+required size: 335806464
+fully allocated size: 2199359062016
+bitmaps size: 537198592
+required size: 18874368
+fully allocated size: 2199042129920
+bitmaps size: 545259520
 *** done
--=20
2.26.1


