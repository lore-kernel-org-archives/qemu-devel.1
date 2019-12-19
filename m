Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BF8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27DA2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjpvCKDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27DA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx6e-00026O-LI
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwxD-0005EW-U2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwxC-0006UP-JF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53867
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwxC-0006SH-AE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfhGiypQeqs35v6eObMG4DYHcsbQYJ76xth2sg4Mu+k=;
 b=RjpvCKDC8NDLFUb2K2Ee3byoG5rAglidSOk2Id9f/WI1MTljtHZQL9UwAHuKDv1VxWFsxu
 yXZ8j9iS9KW3SlcsnNTPOuWGoBSbJTPA188WR7oqJvBBNBFnN4OHNJv9feZLmsY+XVSE1S
 wxzM3lpFNJxikJdqjX8yEy7kFJ3QYkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-SErQlF2FPni3_U0-uM7kSQ-1; Thu, 19 Dec 2019 09:38:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 075CADB6E;
 Thu, 19 Dec 2019 14:38:55 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A39EE26FA3;
 Thu, 19 Dec 2019 14:38:53 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 08/18] iotests: Do not needlessly filter _make_test_img
Date: Thu, 19 Dec 2019 15:38:08 +0100
Message-Id: <20191219143818.1646168-9-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SErQlF2FPni3_U0-uM7kSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In most cases, _make_test_img does not need a _filter_imgfmt on top.  It
does that by itself.

(The exception is when IMGFMT has been overwritten but TEST_IMG has not.
In such cases, we do need a _filter_imgfmt on top to filter the test's
original IMGFMT from TEST_IMG.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/161 | 12 ++++++------
 tests/qemu-iotests/175 |  6 +++---
 tests/qemu-iotests/249 |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index f572a19af2..f9b44e52cf 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -48,9 +48,9 @@ _supported_os Linux
 IMG_SIZE=3D1M
=20
 # Create the images
-TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_im=
gfmt
-_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE
+TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.int"
=20
 # First test: reopen $TEST.IMG changing the detect-zeroes option on
 # its backing file ($TEST_IMG.int).
@@ -105,9 +105,9 @@ echo
 echo "*** Commit and then change an option on the backing file"
 echo
 # Create the images again
-TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_im=
gfmt
-_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE
+TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.int"
=20
 _launch_qemu -drive if=3Dnone,file=3D"${TEST_IMG}"
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index 020ed8e61f..2d164b6b5d 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -89,20 +89,20 @@ min_blocks=3D$(stat -c '%b' "$TEST_DIR/empty")
=20
 echo
 echo "=3D=3D creating image with default preallocation =3D=3D"
-_make_test_img $size | _filter_imgfmt
+_make_test_img $size
 stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_blocks =
$min_blocks $size
=20
 for mode in off full falloc; do
     echo
     echo "=3D=3D creating image with preallocation $mode =3D=3D"
-    _make_test_img -o preallocation=3D$mode $size | _filter_imgfmt
+    _make_test_img -o preallocation=3D$mode $size
     stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_blo=
cks $min_blocks $size
 done
=20
 for new_size in 4096 1048576; do
     echo
     echo "=3D=3D resize empty image with block_resize =3D=3D"
-    _make_test_img 0 | _filter_imgfmt
+    _make_test_img 0
     _block_resize $TEST_IMG $new_size >/dev/null
     stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_blo=
cks $min_blocks $new_size
 done
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index 2b99c9789e..4b0f810795 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -48,9 +48,9 @@ _supported_os Linux
 IMG_SIZE=3D1M
=20
 # Create the images: base <- int <- active
-TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_im=
gfmt
-_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE
+TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.int"
=20
 # Launch QEMU with these two drives:
 # none0: base (read-only)
--=20
2.23.0


