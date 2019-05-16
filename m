Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0597C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5613320815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5613320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59323 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHcw-0000c0-A1
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:44:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRHbR-0007yz-VD
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRHbQ-0002oI-OZ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hRHbO-0002kk-2Z; Thu, 16 May 2019 10:43:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63C03300180C;
	Thu, 16 May 2019 14:43:21 +0000 (UTC)
Received: from localhost (ovpn-204-34.brq.redhat.com [10.40.204.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F0EB010027C4;
	Thu, 16 May 2019 14:43:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 16 May 2019 16:43:19 +0200
Message-Id: <20190516144319.12570-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 16 May 2019 14:43:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3] iotests: Filter 175's allocation information
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is possible for an empty file to take up blocks on a filesystem, for
example:

$ qemu-img create -f raw test.img 1G
Formatting 'test.img', fmt=3Draw size=3D1073741824
$ mkfs.ext4 -I 128 -q test.img
$ mkdir test-mount
$ sudo mount -o loop test.img test-mount
$ sudo touch test-mount/test-file
$ stat -c 'blocks=3D%b' test-mount/test-file
blocks=3D8

These extra blocks (one cluster) are apparently used for metadata,
because they are always there, on top of blocks used for data:

$ sudo dd if=3D/dev/zero of=3Dtest-mount/test-file bs=3D1M count=3D1
1+0 records in
1+0 records out
1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.00135339 s, 775 MB/s
$ stat -c 'blocks=3D%b' test-mount/test-file
blocks=3D2056

Make iotest 175 take this into account.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Nir Soffer <nsoffer@redhat.com>
---
v3:
- Actually tested this on an FS with the behavior in question and
  noticed the patterns were lacking a $.  Since I'm now sending a v3
  anyway, I might as well fix it with the heavy hammer and make it a
  ($|[^0-9]).
- Added example configuration to the commit message [Nir]
- Kept the R-bs because I didn't feel too bad about doing so.
---
 tests/qemu-iotests/175     | 26 ++++++++++++++++++++++----
 tests/qemu-iotests/175.out |  8 ++++----
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index d0ffc495c2..51e62c8276 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -28,10 +28,25 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	_cleanup_test_img
+    _cleanup_test_img
+    rm -f "$TEST_DIR/empty"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
+# Some file systems sometimes allocate extra blocks independently of
+# the file size.  This function hides the resulting difference in the
+# stat -c '%b' output.
+# Parameter 1: Number of blocks an empty file occupies
+# Parameter 2: Image size in bytes
+_filter_blocks()
+{
+    extra_blocks=3D$1
+    img_size=3D$2
+
+    sed -e "s/blocks=3D$extra_blocks\\(\$\\|[^0-9]\\)/nothing allocated/=
" \
+        -e "s/blocks=3D$((extra_blocks + img_size / 512))\\(\$\\|[^0-9]\=
\)/everything allocated/"
+}
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
@@ -40,18 +55,21 @@ _supported_fmt raw
 _supported_proto file
 _supported_os Linux
=20
-size=3D1m
+size=3D$((1 * 1024 * 1024))
+
+touch "$TEST_DIR/empty"
+extra_blocks=3D$(stat -c '%b' "$TEST_DIR/empty")
=20
 echo
 echo "=3D=3D creating image with default preallocation =3D=3D"
 _make_test_img $size | _filter_imgfmt
-stat -c "size=3D%s, blocks=3D%b" $TEST_IMG
+stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_block=
s $size
=20
 for mode in off full falloc; do
     echo
     echo "=3D=3D creating image with preallocation $mode =3D=3D"
     IMGOPTS=3Dpreallocation=3D$mode _make_test_img $size | _filter_imgfm=
t
-    stat -c "size=3D%s, blocks=3D%b" $TEST_IMG
+    stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_b=
locks $size
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


