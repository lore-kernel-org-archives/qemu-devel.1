Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA11C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0737E2064B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0737E2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyUh-0004iC-Lg
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39429)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hmyU7-0002wf-Uj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hmyU5-0001pT-RB
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:45:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hmyU1-0001jG-HW; Mon, 15 Jul 2019 06:45:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4458308FEC0;
 Mon, 15 Jul 2019 10:45:24 +0000 (UTC)
Received: from localhost (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1600A45C3;
 Mon, 15 Jul 2019 10:45:23 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Jul 2019 12:45:08 +0200
Message-Id: <20190715104508.7568-5-mreitz@redhat.com>
In-Reply-To: <20190715104508.7568-1-mreitz@redhat.com>
References: <20190715104508.7568-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 15 Jul 2019 10:45:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1? 4/4] iotests: Convert to preallocated
 encrypted qcow2
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
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test case for converting an empty image (which only returns zeroes
when read) to a preallocated encrypted qcow2 image.
qcow2_has_zero_init() should return 0 then, thus forcing qemu-img
convert to create zero clusters.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/188     | 20 +++++++++++++++++++-
 tests/qemu-iotests/188.out |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index be7278aa65..afca44df54 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -48,7 +48,7 @@ SECRETALT=3D"secret,id=3Dsec0,data=3Dplatypus"
=20
 _make_test_img --object $SECRET -o "encrypt.format=3Dluks,encrypt.key-se=
cret=3Dsec0,encrypt.iter-time=3D10" $size
=20
-IMGSPEC=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG,encrypt.key-secret=
=3Dsec0"
+IMGSPEC=3D"driver=3D$IMGFMT,encrypt.key-secret=3Dsec0,file.filename=3D$T=
EST_IMG"
=20
 QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
=20
@@ -68,6 +68,24 @@ echo
 echo "=3D=3D verify open failure with wrong password =3D=3D"
 $QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $IMGS=
PEC | _filter_qemu_io | _filter_testdir
=20
+_cleanup_test_img
+
+echo
+echo "=3D=3D verify that has_zero_init returns false when preallocating =
=3D=3D"
+
+# Empty source file
+if [ -n "$TEST_IMG_FILE" ]; then
+    TEST_IMG_FILE=3D"${TEST_IMG_FILE}.orig" _make_test_img $size
+else
+    TEST_IMG=3D"${TEST_IMG}.orig" _make_test_img $size
+fi
+
+$QEMU_IMG convert -O "$IMGFMT" --object $SECRET \
+    -o "encrypt.format=3Dluks,encrypt.key-secret=3Dsec0,encrypt.iter-tim=
e=3D10,preallocation=3Dmetadata" \
+    "${TEST_IMG}.orig" "$TEST_IMG"
+
+$QEMU_IMG compare --object $SECRET --image-opts "${IMGSPEC}.orig" "$IMGS=
PEC"
+
=20
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index 97b1402671..c568ef3701 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -15,4 +15,8 @@ read 16777216/16777216 bytes at offset 0
=20
 =3D=3D verify open failure with wrong password =3D=3D
 qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+=3D=3D verify that has_zero_init returns false when preallocating =3D=3D
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D16777216
+Images are identical.
 *** done
--=20
2.21.0


