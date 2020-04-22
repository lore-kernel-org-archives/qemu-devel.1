Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F42C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 20:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA38321473
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 20:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzUYicVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA38321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRMOZ-0006RF-Uf
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 16:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRMNl-0005v7-B0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 16:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRMNj-00072h-Vc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 16:54:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRMNj-0006wz-Fh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 16:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587588844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m3QSbvBkVclO98K0Rs9Ea8ilwlKvpe1JLvl3aA+2kz8=;
 b=PzUYicVxrBP5t7yQUvSSzuS2Soof7HYeyhCvtJp5Gb17jfTQuZOc0rPmTIqP9KliVIkxpY
 MgeXwU8mfNy+y/a/6gH9ui/gMqwRktXNIWNVTY59n+9gEDbagkWSuQE85zvxhODQ6kGSEw
 nb9/SsdyBD0MWpXkJSaC0Wb/yn9vnWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-eh74VYqLN2iFoXALVKHmdA-1; Wed, 22 Apr 2020 16:54:00 -0400
X-MC-Unique: eh74VYqLN2iFoXALVKHmdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 995021934100;
 Wed, 22 Apr 2020 20:53:59 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89F0419C70;
 Wed, 22 Apr 2020 20:53:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Allow resize of images with internal snapshots
Date: Wed, 22 Apr 2020 15:53:55 -0500
Message-Id: <20200422205355.274706-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We originally refused to allow resize of images with internal
snapshots because the v2 image format did not require the tracking of
snapshot size, making it impossible to safely revert to a snapshot
with a different size than the current view of the image.  But the
snapshot size tracking was rectified in v3, and our recent fixes to
qemu-img amend (see 0a85af35) guarantee that we always have a valid
snapshot size.  Thus, we no longer need to artificially limit image
resizes, but it does become one more thing that would prevent a
downgrade back to v2.  And now that we support different-sized
snapshots, it's also easy to fix reverting to a snapshot to apply the
new size.

Upgrade iotest 61 to cover this (we previously had NO coverage of
refusal to resize while snapshots exist).  Note that the amend process
can fail but still have effects: in particular, since we break things
into upgrade, resize, downgrade, if a failure does not happen until a
later phase (such as the downgrade attempt), earlier steps are still
visible (a truncation and downgrade attempt will fail, but only after
truncating data).  But even before this patch, an attempt to upgrade
and resize would fail but only after changing the image to v3.  In
some sense, partial image changes on failure are inevitible, since we
can't avoid a mid-change EIO (if you are trying to amend more than one
thing at once, but something fails, I hope you have a backup image).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-snapshot.c     |  21 ++++--
 block/qcow2.c              |  31 ++++++--
 tests/qemu-iotests/061     |  23 ++++++
 tests/qemu-iotests/061.out | 144 +++++++++++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 82c32d4c9b08..3f9e48738d0b 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -23,6 +23,7 @@
  */

 #include "qemu/osdep.h"
+#include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qcow2.h"
 #include "qemu/bswap.h"
@@ -775,10 +776,22 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const c=
har *snapshot_id)
     }

     if (sn->disk_size !=3D bs->total_sectors * BDRV_SECTOR_SIZE) {
-        error_report("qcow2: Loading snapshots with different disk "
-            "size is not implemented");
-        ret =3D -ENOTSUP;
-        goto fail;
+        BlockBackend *blk =3D blk_new(bdrv_get_aio_context(bs),
+                                    BLK_PERM_RESIZE, BLK_PERM_ALL);
+        ret =3D blk_insert_bs(blk, bs, &local_err);
+        if (ret < 0) {
+            blk_unref(blk);
+            error_report_err(local_err);
+            goto fail;
+        }
+
+        ret =3D blk_truncate(blk, sn->disk_size, true, PREALLOC_MODE_OFF,
+                           &local_err);
+        blk_unref(blk);
+        if (ret < 0) {
+            error_report_err(local_err);
+            goto fail;
+        }
     }

     /*
diff --git a/block/qcow2.c b/block/qcow2.c
index b524b0c53f84..29047c33b7e5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3988,14 +3988,21 @@ static int coroutine_fn qcow2_co_truncate(BlockDriv=
erState *bs, int64_t offset,

     qemu_co_mutex_lock(&s->lock);

-    /* cannot proceed if image has snapshots */
-    if (s->nb_snapshots) {
-        error_setg(errp, "Can't resize an image which has snapshots");
+    /*
+     * Even though we store snapshot size for all images, it was not
+     * required until v3, so it is not safe to proceed for v2.
+     */
+    if (s->nb_snapshots && s->qcow_version < 3) {
+        error_setg(errp, "Can't resize a v2 image which has snapshots");
         ret =3D -ENOTSUP;
         goto fail;
     }

-    /* cannot proceed if image has bitmaps */
+    /*
+     * For now, it's easier to not proceed if image has bitmaps, even
+     * though we could resize bitmaps, because it is not obvious
+     * whether new bits should be set or clear.
+     */
     if (qcow2_truncate_bitmaps_check(bs, errp)) {
         ret =3D -ENOTSUP;
         goto fail;
@@ -4952,6 +4959,7 @@ static int qcow2_downgrade(BlockDriverState *bs, int =
target_version,
     BDRVQcow2State *s =3D bs->opaque;
     int current_version =3D s->qcow_version;
     int ret;
+    int i;

     /* This is qcow2_downgrade(), not qcow2_upgrade() */
     assert(target_version < current_version);
@@ -4969,6 +4977,21 @@ static int qcow2_downgrade(BlockDriverState *bs, int=
 target_version,
         return -ENOTSUP;
     }

+    /*
+     * If any internal snapshot has a different size than the current
+     * image size, or VM state size that exceeds 32 bits, downgrading
+     * is unsafe.  Even though we would still use v3-compliant output
+     * to preserve that data, other v2 programs might not realize
+     * those optional fields are important.
+     */
+    for (i =3D 0; i < s->nb_snapshots; i++) {
+        if (s->snapshots[i].vm_state_size > UINT32_MAX ||
+            s->snapshots[i].disk_size !=3D bs->total_sectors * BDRV_SECTOR=
_SIZE) {
+            error_setg(errp, "Internal snapshots prevent downgrade of imag=
e");
+            return -ENOTSUP;
+        }
+    }
+
     /* clear incompatible features */
     if (s->incompatible_features & QCOW2_INCOMPAT_DIRTY) {
         ret =3D qcow2_mark_clean(bs);
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index ce285d308408..fdfb8fab5fb6 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -111,6 +111,29 @@ $PYTHON qcow2.py "$TEST_IMG" dump-header
 $QEMU_IO -c "read -P 0x2a 42M 64k" "$TEST_IMG" | _filter_qemu_io
 _check_test_img

+echo
+echo "=3D=3D=3D Testing resize with snapshots =3D=3D=3D"
+echo
+_make_test_img -o "compat=3D0.10" 32M
+$QEMU_IO -c "write -P 0x2a 24M 64k" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG snapshot -c foo "$TEST_IMG"
+$QEMU_IMG resize "$TEST_IMG" 64M                         # fails
+$PYTHON qcow2.py "$TEST_IMG" dump-header
+$QEMU_IMG amend -o "compat=3D1.1,size=3D128M" "$TEST_IMG"    # succeeds
+$PYTHON qcow2.py "$TEST_IMG" dump-header
+$QEMU_IMG snapshot -c bar "$TEST_IMG"
+$QEMU_IMG resize --shrink "$TEST_IMG" 64M                # succeeds
+$PYTHON qcow2.py "$TEST_IMG" dump-header
+$QEMU_IMG amend -o "compat=3D0.10,size=3D32M" "$TEST_IMG"    # fails, imag=
e left v3
+$PYTHON qcow2.py "$TEST_IMG" dump-header
+$QEMU_IMG snapshot -a bar "$TEST_IMG"                    # succeeds
+$PYTHON qcow2.py "$TEST_IMG" dump-header
+$QEMU_IMG snapshot -d bar "$TEST_IMG"
+$QEMU_IMG amend -o "compat=3D0.10,size=3D32M" "$TEST_IMG"    # succeeds
+$PYTHON qcow2.py "$TEST_IMG" dump-header
+_check_test_img
+
+
 echo
 echo "=3D=3D=3D Testing dirty lazy_refcounts=3Doff =3D=3D=3D"
 echo
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 413cc4e0f4ab..0035210c9ae0 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -271,6 +271,150 @@ read 65536/65536 bytes at offset 44040192
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.

+=3D=3D=3D Testing resize with snapshots =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432
+wrote 65536/65536 bytes at offset 25165824
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Can't resize a v2 image which has snapshots
+magic                     0x514649fb
+version                   2
+backing_file_offset       0x0
+backing_file_size         0x0
+cluster_bits              16
+size                      33554432
+crypt_method              0
+l1_size                   1
+l1_table_offset           0x30000
+refcount_table_offset     0x10000
+refcount_table_clusters   1
+nb_snapshots              1
+snapshot_offset           0x70000
+incompatible_features     []
+compatible_features       []
+autoclear_features        []
+refcount_order            4
+header_length             72
+
+magic                     0x514649fb
+version                   3
+backing_file_offset       0x0
+backing_file_size         0x0
+cluster_bits              16
+size                      134217728
+crypt_method              0
+l1_size                   1
+l1_table_offset           0x30000
+refcount_table_offset     0x10000
+refcount_table_clusters   1
+nb_snapshots              1
+snapshot_offset           0x70000
+incompatible_features     []
+compatible_features       []
+autoclear_features        []
+refcount_order            4
+header_length             104
+
+Header extension:
+magic                     0x6803f857
+length                    288
+data                      <binary>
+
+Image resized.
+magic                     0x514649fb
+version                   3
+backing_file_offset       0x0
+backing_file_size         0x0
+cluster_bits              16
+size                      67108864
+crypt_method              0
+l1_size                   1
+l1_table_offset           0x30000
+refcount_table_offset     0x10000
+refcount_table_clusters   1
+nb_snapshots              2
+snapshot_offset           0x90000
+incompatible_features     []
+compatible_features       []
+autoclear_features        []
+refcount_order            4
+header_length             104
+
+Header extension:
+magic                     0x6803f857
+length                    288
+data                      <binary>
+
+qemu-img: Internal snapshots prevent downgrade of image
+magic                     0x514649fb
+version                   3
+backing_file_offset       0x0
+backing_file_size         0x0
+cluster_bits              16
+size                      33554432
+crypt_method              0
+l1_size                   1
+l1_table_offset           0x30000
+refcount_table_offset     0x10000
+refcount_table_clusters   1
+nb_snapshots              2
+snapshot_offset           0x90000
+incompatible_features     []
+compatible_features       []
+autoclear_features        []
+refcount_order            4
+header_length             104
+
+Header extension:
+magic                     0x6803f857
+length                    288
+data                      <binary>
+
+magic                     0x514649fb
+version                   3
+backing_file_offset       0x0
+backing_file_size         0x0
+cluster_bits              16
+size                      134217728
+crypt_method              0
+l1_size                   1
+l1_table_offset           0x30000
+refcount_table_offset     0x10000
+refcount_table_clusters   1
+nb_snapshots              2
+snapshot_offset           0x90000
+incompatible_features     []
+compatible_features       []
+autoclear_features        []
+refcount_order            4
+header_length             104
+
+Header extension:
+magic                     0x6803f857
+length                    288
+data                      <binary>
+
+magic                     0x514649fb
+version                   2
+backing_file_offset       0x0
+backing_file_size         0x0
+cluster_bits              16
+size                      33554432
+crypt_method              0
+l1_size                   1
+l1_table_offset           0x30000
+refcount_table_offset     0x10000
+refcount_table_clusters   1
+nb_snapshots              1
+snapshot_offset           0x70000
+incompatible_features     []
+compatible_features       []
+autoclear_features        []
+refcount_order            4
+header_length             72
+
+No errors were found on the image.
+
 =3D=3D=3D Testing dirty lazy_refcounts=3Doff =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
--=20
2.26.2


