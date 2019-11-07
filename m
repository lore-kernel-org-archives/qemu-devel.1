Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AC4C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF802085B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/YTyHYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF802085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkxO-0007SH-2W
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSkn8-0003P9-RC
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSkn7-0005mE-F0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44298
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSkn7-0005lZ-Bf
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRgx2PB8gGG0yXPXhZDfobphu/IR7i3MYvw6qEzyy2M=;
 b=A/YTyHYCUzgHGCAZA22SIw09K6h0NIk6lfoTNq4I5w6dkR/Ajz1lGA1CqOyT79L7Eh/lPQ
 sKt4tToVyTZP8IzDPB99MYm96l8fduhXfsrnaQGVTS5GXbpXA87TPQxZLcx2uGVPoglnoN
 ympZTKBV19hTQ/hUIc/oT/NRcPkbOAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-9R4Tk-xiPi-ihDQtzPKDrQ-1; Thu, 07 Nov 2019 11:37:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB9CF800C61;
 Thu,  7 Nov 2019 16:37:44 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59C30608B4;
 Thu,  7 Nov 2019 16:37:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 16/22] iotests: Avoid cp/mv of test images
Date: Thu,  7 Nov 2019 17:37:02 +0100
Message-Id: <20191107163708.833192-17-mreitz@redhat.com>
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 9R4Tk-xiPi-ihDQtzPKDrQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will not work with external data files, so try to get tests working
without it as far as possible.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/063     | 12 ++++--------
 tests/qemu-iotests/063.out |  3 ++-
 tests/qemu-iotests/085     |  9 +++------
 tests/qemu-iotests/085.out |  8 ++++----
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index eef2b8a534..c750b3806e 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -51,15 +51,13 @@ _unsupported_imgopts "subformat=3DmonolithicFlat" \
 _make_test_img 4M
=20
 echo "=3D=3D Testing conversion with -n fails with no target file =3D=3D"
-# check .orig file does not exist
-rm -f "$TEST_IMG.orig"
 if $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG.orig"=
 >/dev/null 2>&1; then
     exit 1
 fi
=20
 echo "=3D=3D Testing conversion with -n succeeds with a target file =3D=3D=
"
-rm -f "$TEST_IMG.orig"
-cp "$TEST_IMG" "$TEST_IMG.orig"
+_rm_test_img "$TEST_IMG.orig"
+TEST_IMG=3D"$TEST_IMG.orig" _make_test_img 4M
 if ! $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG.ori=
g" ; then
     exit 1
 fi
@@ -85,10 +83,8 @@ fi
 _check_test_img
=20
 echo "=3D=3D Testing conversion to a smaller file fails =3D=3D"
-rm -f "$TEST_IMG.orig"
-mv "$TEST_IMG" "$TEST_IMG.orig"
-_make_test_img 2M
-if $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG.orig" "$TEST_IMG"=
 >/dev/null 2>&1; then
+TEST_IMG=3D"$TEST_IMG.target" _make_test_img 2M
+if $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG.targe=
t" >/dev/null 2>&1; then
     exit 1
 fi
=20
diff --git a/tests/qemu-iotests/063.out b/tests/qemu-iotests/063.out
index 7b691b2c9e..890b719bf0 100644
--- a/tests/qemu-iotests/063.out
+++ b/tests/qemu-iotests/063.out
@@ -2,11 +2,12 @@ QA output created by 063
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4194304
 =3D=3D Testing conversion with -n fails with no target file =3D=3D
 =3D=3D Testing conversion with -n succeeds with a target file =3D=3D
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D4194304
 =3D=3D Testing conversion to raw is the same after conversion with -n =3D=
=3D
 =3D=3D Testing conversion back to original format =3D=3D
 No errors were found on the image.
 =3D=3D Testing conversion to a smaller file fails =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2097152
+Formatting 'TEST_DIR/t.IMGFMT.target', fmt=3DIMGFMT size=3D2097152
 =3D=3D Regression testing for copy offloading bug =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
 Formatting 'TEST_DIR/t.IMGFMT.target', fmt=3DIMGFMT size=3D1048576
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index bbea1252d2..46981dbb64 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -105,8 +105,7 @@ add_snapshot_image()
 {
     base_image=3D"${TEST_DIR}/$((${1}-1))-${snapshot_virt0}"
     snapshot_file=3D"${TEST_DIR}/${1}-${snapshot_virt0}"
-    _make_test_img -u -b "${base_image}" "$size"
-    mv "${TEST_IMG}" "${snapshot_file}"
+    TEST_IMG=3D$snapshot_file _make_test_img -u -b "${base_image}" "$size"
     do_blockdev_add "$1" "'backing': null, " "${snapshot_file}"
 }
=20
@@ -122,10 +121,8 @@ blockdev_snapshot()
=20
 size=3D128M
=20
-_make_test_img $size
-mv "${TEST_IMG}" "${TEST_IMG}.1"
-_make_test_img $size
-mv "${TEST_IMG}" "${TEST_IMG}.2"
+TEST_IMG=3D"$TEST_IMG.1" _make_test_img $size
+TEST_IMG=3D"$TEST_IMG.2" _make_test_img $size
=20
 echo
 echo =3D=3D=3D Running QEMU =3D=3D=3D
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index 2a5f256cd3..313198f182 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -1,6 +1,6 @@
 QA output created by 085
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT.1', fmt=3DIMGFMT size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT.2', fmt=3DIMGFMT size=3D134217728
=20
 =3D=3D=3D Running QEMU =3D=3D=3D
=20
@@ -55,10 +55,10 @@ Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=3Dqcow2=
 size=3D134217728 backing_fil
=20
 =3D=3D=3D Create a couple of snapshots using blockdev-snapshot =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/10-snapshot-v0.IMGFMT
+Formatting 'TEST_DIR/11-snapshot-v0.IMGFMT', fmt=3DIMGFMT size=3D134217728=
 backing_file=3DTEST_DIR/10-snapshot-v0.IMGFMT
 {"return": {}}
 {"return": {}}
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/11-snapshot-v0.IMGFMT
+Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=3DIMGFMT size=3D134217728=
 backing_file=3DTEST_DIR/11-snapshot-v0.IMGFMT
 {"return": {}}
 {"return": {}}
=20
--=20
2.23.0


