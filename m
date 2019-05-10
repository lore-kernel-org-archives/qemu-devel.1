Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E90BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D4A21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D4A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCwp-0007vT-6H
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 17:20:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hPCvw-0007Tw-K0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hPCvv-0007gN-JP
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:20:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hPCvt-0007ep-9C; Fri, 10 May 2019 17:19:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9720C81F19;
	Fri, 10 May 2019 21:19:56 +0000 (UTC)
Received: from localhost (ovpn-204-59.brq.redhat.com [10.40.204.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 305325C29A;
	Fri, 10 May 2019 21:19:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 10 May 2019 23:19:54 +0200
Message-Id: <20190510211954.29574-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 10 May 2019 21:19:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] iotests: Filter 175's allocation information
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
	Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is possible for an empty file to take up blocks on a filesystem.
Make iotest 175 take this into account.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/175     | 15 +++++++++++----
 tests/qemu-iotests/175.out |  8 ++++----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index d0ffc495c2..b5652a3889 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -28,7 +28,8 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	_cleanup_test_img
+    _cleanup_test_img
+    rm -f "$TEST_DIR/empty"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -40,18 +41,24 @@ _supported_fmt raw
 _supported_proto file
 _supported_os Linux
=20
-size=3D1m
+size=3D$((1 * 1024 * 1024))
+
+touch "$TEST_DIR/empty"
+empty_blocks=3D$(stat -c '%b' "$TEST_DIR/empty")
=20
 echo
 echo "=3D=3D creating image with default preallocation =3D=3D"
 _make_test_img $size | _filter_imgfmt
-stat -c "size=3D%s, blocks=3D%b" $TEST_IMG
+stat -c "size=3D%s, blocks=3D%b" $TEST_IMG \
+    | sed -e "s/blocks=3D$empty_blocks/nothing allocated/"
=20
 for mode in off full falloc; do
     echo
     echo "=3D=3D creating image with preallocation $mode =3D=3D"
     IMGOPTS=3Dpreallocation=3D$mode _make_test_img $size | _filter_imgfm=
t
-    stat -c "size=3D%s, blocks=3D%b" $TEST_IMG
+    stat -c "size=3D%s, blocks=3D%b" $TEST_IMG \
+        | sed -e "s/blocks=3D$empty_blocks/nothing allocated/" \
+        | sed -e "s/blocks=3D$((empty_blocks + size / 512))/everything a=
llocated/"
 done
=20
 # success, all done
diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
index 76c02c6a57..6d9a5ed84e 100644
--- a/tests/qemu-iotests/175.out
+++ b/tests/qemu-iotests/175.out
@@ -2,17 +2,17 @@ QA output created by 175
=20
 =3D=3D creating image with default preallocation =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
-size=3D1048576, blocks=3D0
+size=3D1048576, nothing allocated
=20
 =3D=3D creating image with preallocation off =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocatio=
n=3Doff
-size=3D1048576, blocks=3D0
+size=3D1048576, nothing allocated
=20
 =3D=3D creating image with preallocation full =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocatio=
n=3Dfull
-size=3D1048576, blocks=3D2048
+size=3D1048576, everything allocated
=20
 =3D=3D creating image with preallocation falloc =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocatio=
n=3Dfalloc
-size=3D1048576, blocks=3D2048
+size=3D1048576, everything allocated
  *** done
--=20
2.21.0


