Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F474C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA3C2078C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCen9nAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA3C2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxSQ-00021n-6P
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAT-0002Ij-7U
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59216
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAR-0001OR-Vr
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODHBwiQG7zLsgD+hURCtxe6U8MhrFsHu+crICg+y2ok=;
 b=jCen9nAqKu+vchPCLQhKy38jMdP35AnYxhV3UP1O7GJUcpRsuwNnhnv5MbWt2lkuPOlHo+
 r5K/CgupDvKfCYgcT4BtrnaVWrHSTCrbGyn0GK/kiyi2e1siDL53qjh40iXCl20Y78zTjb
 p/KiFe7Zt+P5y5vkrPHx1ePfPXSWu4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-S1IrA6y_PaiyBVa4ND_fIg-1; Tue, 05 May 2020 08:59:05 -0400
X-MC-Unique: S1IrA6y_PaiyBVa4ND_fIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BED1A0C01;
 Tue,  5 May 2020 12:59:04 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAD455D9DD;
 Tue,  5 May 2020 12:59:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/24] qcow2: Allow resize of images with internal snapshots
Date: Tue,  5 May 2020 14:58:18 +0200
Message-Id: <20200505125826.1001451-17-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

From: Eric Blake <eblake@redhat.com>

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
into upgrade, resize, downgrade, a failure during resize does not roll
back changes made during upgrade, nor does failure in downgrade roll
back a resize.  But this situation is pre-existing even without this
patch; and without journaling, the best we could do is minimize the
chance of partial failure by collecting all changes prior to doing any
writes - which adds a lot of complexity but could still fail with EIO.
On the other hand, we are careful that even if we have partial
modification but then fail, the image is left viable (that is, we are
careful to sequence things so that after each successful cluster
write, there may be transient leaked clusters but no corrupt
metadata).  And complicating the code to make it more transaction-like
is not worth the effort: a user can always request multiple 'qemu-img
amend' changing one thing each, if they need finer-grained control
over detecting the first failure than what they get by letting qemu
decide how to sequence multiple changes.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200428192648.749066-3-eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-snapshot.c     | 20 ++++++++++++++++----
 block/qcow2.c              | 25 ++++++++++++++++++++++---
 tests/qemu-iotests/061     | 35 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/061.out | 28 ++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 82c32d4c9b..2756b37d24 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qcow2.h"
 #include "qemu/bswap.h"
@@ -775,10 +776,21 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const c=
har *snapshot_id)
     }
=20
     if (sn->disk_size !=3D bs->total_sectors * BDRV_SECTOR_SIZE) {
-        error_report("qcow2: Loading snapshots with different disk "
-            "size is not implemented");
-        ret =3D -ENOTSUP;
-        goto fail;
+        BlockBackend *blk =3D blk_new_with_bs(bs, BLK_PERM_RESIZE, BLK_PER=
M_ALL,
+                                            &local_err);
+        if (!blk) {
+            error_report_err(local_err);
+            ret =3D -ENOTSUP;
+            goto fail;
+        }
+
+        ret =3D blk_truncate(blk, sn->disk_size, true, PREALLOC_MODE_OFF, =
0,
+                           &local_err);
+        blk_unref(blk);
+        if (ret < 0) {
+            error_report_err(local_err);
+            goto fail;
+        }
     }
=20
     /*
diff --git a/block/qcow2.c b/block/qcow2.c
index 0edc7f4643..3e8b3d022b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3989,9 +3989,12 @@ static int coroutine_fn qcow2_co_truncate(BlockDrive=
rState *bs, int64_t offset,
=20
     qemu_co_mutex_lock(&s->lock);
=20
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
@@ -5005,6 +5008,7 @@ static int qcow2_downgrade(BlockDriverState *bs, int =
target_version,
     BDRVQcow2State *s =3D bs->opaque;
     int current_version =3D s->qcow_version;
     int ret;
+    int i;
=20
     /* This is qcow2_downgrade(), not qcow2_upgrade() */
     assert(target_version < current_version);
@@ -5022,6 +5026,21 @@ static int qcow2_downgrade(BlockDriverState *bs, int=
 target_version,
         return -ENOTSUP;
     }
=20
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
index ce285d3084..10eb243164 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -111,6 +111,41 @@ $PYTHON qcow2.py "$TEST_IMG" dump-header
 $QEMU_IO -c "read -P 0x2a 42M 64k" "$TEST_IMG" | _filter_qemu_io
 _check_test_img
=20
+echo
+echo "=3D=3D=3D Testing resize with snapshots =3D=3D=3D"
+echo
+_make_test_img -o "compat=3D0.10" 32M
+$QEMU_IO -c "write -P 0x2a 24M 64k" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG snapshot -c foo "$TEST_IMG"
+$QEMU_IMG resize "$TEST_IMG" 64M &&
+    echo "unexpected pass"
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep '^\(version\|size\|nb_snap=
\)'
+
+$QEMU_IMG amend -o "compat=3D1.1,size=3D128M" "$TEST_IMG" ||
+    echo "unexpected fail"
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep '^\(version\|size\|nb_snap=
\)'
+
+$QEMU_IMG snapshot -c bar "$TEST_IMG"
+$QEMU_IMG resize --shrink "$TEST_IMG" 64M ||
+    echo "unexpected fail"
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep '^\(version\|size\|nb_snap=
\)'
+
+$QEMU_IMG amend -o "compat=3D0.10,size=3D32M" "$TEST_IMG" &&
+    echo "unexpected pass"
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep '^\(version\|size\|nb_snap=
\)'
+
+$QEMU_IMG snapshot -a bar "$TEST_IMG" ||
+    echo "unexpected fail"
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep '^\(version\|size\|nb_snap=
\)'
+
+$QEMU_IMG snapshot -d bar "$TEST_IMG"
+$QEMU_IMG amend -o "compat=3D0.10,size=3D32M" "$TEST_IMG" ||
+    echo "unexpected fail"
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep '^\(version\|size\|nb_snap=
\)'
+
+_check_test_img
+
+
 echo
 echo "=3D=3D=3D Testing dirty lazy_refcounts=3Doff =3D=3D=3D"
 echo
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 413cc4e0f4..5a8d36d005 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -271,6 +271,34 @@ read 65536/65536 bytes at offset 44040192
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
=20
+=3D=3D=3D Testing resize with snapshots =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432
+wrote 65536/65536 bytes at offset 25165824
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Can't resize a v2 image which has snapshots
+version                   2
+size                      33554432
+nb_snapshots              1
+version                   3
+size                      134217728
+nb_snapshots              1
+Image resized.
+version                   3
+size                      67108864
+nb_snapshots              2
+qemu-img: Internal snapshots prevent downgrade of image
+version                   3
+size                      33554432
+nb_snapshots              2
+version                   3
+size                      134217728
+nb_snapshots              2
+version                   2
+size                      33554432
+nb_snapshots              1
+No errors were found on the image.
+
 =3D=3D=3D Testing dirty lazy_refcounts=3Doff =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
--=20
2.26.2


