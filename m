Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0FEC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2275820854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2275820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNvK-0005AH-U8
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNoC-00075M-9t
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNo9-0000EM-4j
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:28:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNo1-00007Z-A9; Tue, 15 Oct 2019 10:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8120318C8320;
 Tue, 15 Oct 2019 14:28:07 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3F985C298;
 Tue, 15 Oct 2019 14:28:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 14/21] iotests: Use _rm_test_img for deleting test images
Date: Tue, 15 Oct 2019 16:27:22 +0200
Message-Id: <20191015142729.18123-15-mreitz@redhat.com>
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 15 Oct 2019 14:28:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

Just rm will not delete external data files.  Use _rm_test_img every
time we delete a test image.

(In the process, clean up the indentation of every _cleanup() this patch
touches.)

((Also, use quotes consistently.  I am happy to see unquoted instances
like "rm -rf $TEST_DIR/..." go.))

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/005 |  2 +-
 tests/qemu-iotests/019 |  6 +++---
 tests/qemu-iotests/020 |  6 +++---
 tests/qemu-iotests/024 | 10 +++++-----
 tests/qemu-iotests/028 |  2 +-
 tests/qemu-iotests/029 |  2 +-
 tests/qemu-iotests/043 |  4 +++-
 tests/qemu-iotests/048 |  2 +-
 tests/qemu-iotests/050 |  4 ++--
 tests/qemu-iotests/053 |  4 ++--
 tests/qemu-iotests/058 |  2 +-
 tests/qemu-iotests/059 |  2 +-
 tests/qemu-iotests/061 |  2 +-
 tests/qemu-iotests/063 |  6 ++++--
 tests/qemu-iotests/069 |  2 +-
 tests/qemu-iotests/074 |  2 +-
 tests/qemu-iotests/080 |  2 +-
 tests/qemu-iotests/081 |  6 +++---
 tests/qemu-iotests/085 |  9 ++++++---
 tests/qemu-iotests/088 |  2 +-
 tests/qemu-iotests/092 |  2 +-
 tests/qemu-iotests/094 |  2 +-
 tests/qemu-iotests/095 |  5 +++--
 tests/qemu-iotests/099 |  7 ++++---
 tests/qemu-iotests/109 |  4 ++--
 tests/qemu-iotests/110 |  4 ++--
 tests/qemu-iotests/122 |  6 ++++--
 tests/qemu-iotests/123 |  2 +-
 tests/qemu-iotests/141 |  4 +++-
 tests/qemu-iotests/142 |  2 +-
 tests/qemu-iotests/144 |  4 +++-
 tests/qemu-iotests/153 | 10 +++-------
 tests/qemu-iotests/156 |  8 ++++++--
 tests/qemu-iotests/159 |  2 +-
 tests/qemu-iotests/160 |  3 ++-
 tests/qemu-iotests/161 |  4 ++--
 tests/qemu-iotests/170 |  2 +-
 tests/qemu-iotests/172 |  6 +++---
 tests/qemu-iotests/173 |  3 ++-
 tests/qemu-iotests/178 |  2 +-
 tests/qemu-iotests/182 |  2 +-
 tests/qemu-iotests/183 |  2 +-
 tests/qemu-iotests/185 |  4 ++--
 tests/qemu-iotests/187 |  6 +++---
 tests/qemu-iotests/190 |  2 +-
 tests/qemu-iotests/191 |  6 +++---
 tests/qemu-iotests/195 |  2 +-
 tests/qemu-iotests/197 |  2 +-
 tests/qemu-iotests/200 |  3 ++-
 tests/qemu-iotests/215 |  2 +-
 tests/qemu-iotests/225 |  2 +-
 tests/qemu-iotests/229 |  3 ++-
 tests/qemu-iotests/232 |  4 +++-
 tests/qemu-iotests/243 |  2 +-
 tests/qemu-iotests/244 |  4 ++--
 tests/qemu-iotests/247 |  4 +++-
 tests/qemu-iotests/249 |  4 ++--
 tests/qemu-iotests/252 |  2 +-
 58 files changed, 119 insertions(+), 96 deletions(-)

diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 58442762fe..2b651f2c37 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -62,7 +62,7 @@ if [ "$IMGFMT" =3D "raw" ]; then
     if ! truncate --size=3D5T "$TEST_IMG"; then
         _notrun "file system on $TEST_DIR does not support large enough =
files"
     fi
-    rm "$TEST_IMG"
+    _rm_test_img "$TEST_IMG"
 fi
=20
 echo
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index b4f5234609..813a84acac 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -30,9 +30,9 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	_cleanup_test_img
-    rm -f "$TEST_IMG.base"
-    rm -f "$TEST_IMG.orig"
+    _cleanup_test_img
+    _rm_test_img "$TEST_IMG.base"
+    _rm_test_img "$TEST_IMG.orig"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index f41b92f35f..20f8f185d0 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -28,9 +28,9 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	_cleanup_test_img
-    rm -f "$TEST_IMG.base"
-    rm -f "$TEST_IMG.orig"
+    _cleanup_test_img
+    _rm_test_img "$TEST_IMG.base"
+    _rm_test_img "$TEST_IMG.orig"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 23298c6f59..e2e766241e 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -29,12 +29,12 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_DIR/t.$IMGFMT.base_old"
-    rm -f "$TEST_DIR/t.$IMGFMT.base_new"
+    _rm_test_img "$TEST_DIR/t.$IMGFMT.base_old"
+    _rm_test_img "$TEST_DIR/t.$IMGFMT.base_new"
=20
-    rm -f "$TEST_DIR/subdir/t.$IMGFMT"
-    rm -f "$TEST_DIR/subdir/t.$IMGFMT.base_old"
-    rm -f "$TEST_DIR/subdir/t.$IMGFMT.base_new"
+    _rm_test_img "$TEST_DIR/subdir/t.$IMGFMT"
+    _rm_test_img "$TEST_DIR/subdir/t.$IMGFMT.base_old"
+    _rm_test_img "$TEST_DIR/subdir/t.$IMGFMT.base_new"
     rmdir "$TEST_DIR/subdir" 2> /dev/null
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 71301ec6e5..caf1258647 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -32,7 +32,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_qemu
-    rm -f "${TEST_IMG}.copy"
+    _rm_test_img "${TEST_IMG}.copy"
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 94c2713132..9254ede5e5 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -28,7 +28,7 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-    rm -f $TEST_IMG.snap
+    _rm_test_img "$TEST_IMG.snap"
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 67cc7e74c2..b102e49208 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -29,7 +29,9 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG".[123].base
+    for img in "$TEST_IMG".[123].base; do
+        _rm_test_img "$img"
+    done
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
index bde408ca92..a8feb76184 100755
--- a/tests/qemu-iotests/048
+++ b/tests/qemu-iotests/048
@@ -31,7 +31,7 @@ _cleanup()
 {
     echo "Cleanup"
     _cleanup_test_img
-    rm "${TEST_IMG_FILE2}"
+    _rm_test_img "${TEST_IMG_FILE2}"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 272ecab195..cdc5356541 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -29,8 +29,8 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.old"
-    rm -f "$TEST_IMG.new"
+    _rm_test_img "$TEST_IMG.old"
+    _rm_test_img "$TEST_IMG.new"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index e82bb69881..71d299c4f9 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -28,8 +28,8 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	rm -f "$TEST_IMG.orig"
-	_cleanup_test_img
+    _rm_test_img "$TEST_IMG.orig"
+    _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 8c3212a72f..ed01115fa3 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -42,7 +42,7 @@ _cleanup()
 {
     nbd_server_stop
     _cleanup_test_img
-    rm -f "$converted_image"
+    _rm_test_img "$converted_image"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 3941c3f0c2..5438025285 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -29,7 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.qcow2"
+    IMGFMT=3Dqcow2 _rm_test_img "$TEST_IMG.qcow2"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 0480be0141..b4076d8e8b 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -29,7 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f $TEST_IMG.data
+    _rm_test_img "$TEST_IMG.data"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index 7cf0427af4..eef2b8a534 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -29,8 +29,10 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	_cleanup_test_img
-	rm -f "$TEST_IMG.orig" "$TEST_IMG.raw1" "$TEST_IMG.raw2"
+    _cleanup_test_img
+    for img in "$TEST_IMG".{orig,raw1,raw2,target}; do
+        _rm_test_img "$img"
+    done
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 3974714852..b997b127f0 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -47,7 +47,7 @@ echo "=3D=3D=3D Creating an image with a backing file a=
nd deleting that file =3D=3D=3D"
 echo
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE
 _make_test_img -b "$TEST_IMG.base" $IMG_SIZE
-rm -f "$TEST_IMG.base"
+_rm_test_img "$TEST_IMG.base"
 # Just open the image and close it right again (this should print an err=
or message)
 $QEMU_IO -c quit "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
=20
diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
index bb4ad1cc08..62be89a0d9 100755
--- a/tests/qemu-iotests/074
+++ b/tests/qemu-iotests/074
@@ -31,7 +31,7 @@ _cleanup()
 {
     echo "Cleanup"
     _cleanup_test_img
-    rm "${TEST_IMG2}"
+    _rm_test_img "${TEST_IMG2}"
     rm -f "$TEST_DIR/blkdebug.conf"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 4bcb5021e8..b1ecafb41e 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -28,7 +28,7 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-    rm -f $TEST_IMG.snap
+    _rm_test_img "$TEST_IMG.snap"
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index 85acdf76d4..537d40dfd5 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -28,9 +28,9 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-    rm -rf $TEST_DIR/1.raw
-    rm -rf $TEST_DIR/2.raw
-    rm -rf $TEST_DIR/3.raw
+    _rm_test_img "$TEST_DIR/1.raw"
+    _rm_test_img "$TEST_DIR/2.raw"
+    _rm_test_img "$TEST_DIR/3.raw"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index d40fdab542..bbea1252d2 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -41,10 +41,13 @@ _cleanup()
     _cleanup_qemu
     for i in $(seq 1 ${SNAPSHOTS})
     do
-        rm -f "${TEST_DIR}/${i}-${snapshot_virt0}"
-        rm -f "${TEST_DIR}/${i}-${snapshot_virt1}"
+        _rm_test_img "${TEST_DIR}/${i}-${snapshot_virt0}"
+        _rm_test_img "${TEST_DIR}/${i}-${snapshot_virt1}"
+    done
+    for img in "${TEST_IMG}".{1,2,base}
+    do
+        _rm_test_img "$img"
     done
-    rm -f "${TEST_IMG}" "${TEST_IMG}.1" "${TEST_IMG}.2" "${TEST_IMG}.bas=
e"
=20
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index b44edd0cf9..ef1163346c 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -28,7 +28,7 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-    rm -f $TEST_IMG.snap
+    _rm_test_img "$TEST_IMG.snap"
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index e2e0726de1..40ec62b6f1 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -28,7 +28,7 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-    rm -f $TEST_IMG.snap
+    _rm_test_img "$TEST_IMG.snap"
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index d645952d54..2d3e1004d3 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -30,7 +30,7 @@ _cleanup()
 {
     _cleanup_qemu
     _cleanup_test_img
-    rm -f "$TEST_DIR/source.$IMGFMT"
+    _rm_test_img "$TEST_DIR/source.$IMGFMT"
 }
=20
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 58fe174b5e..155ae86aa7 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -32,8 +32,9 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_qemu
-    rm  -f "${TEST_IMG}.base" "${TEST_IMG}.snp1"
-	_cleanup_test_img
+    _rm_test_img "${TEST_IMG}.base"
+    _rm_test_img "${TEST_IMG}.snp1"
+    _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index c3cf66798a..b383c11e6a 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -29,7 +29,10 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	_cleanup_test_img
+    _cleanup_test_img
+    _rm_test_img "$TEST_IMG.compare"
+    rm -f "$TEST_DIR/blkdebug.conf"
+
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -121,8 +124,6 @@ echo
 test_qemu "file.driver=3Dblkdebug,file.image.filename=3D$TEST_IMG"
=20
=20
-rm -f "$TEST_IMG.compare" "$TEST_DIR/blkdebug.conf"
-
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 9897ceb6cd..ba638db11f 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -29,8 +29,8 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_qemu
-    rm -f $TEST_IMG.src
-	_cleanup_test_img
+    _rm_test_img "$TEST_IMG.src"
+    _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 2ef516baf1..f78df0e6e1 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -28,8 +28,8 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	_cleanup_test_img
-        rm -f "$TEST_IMG.copy"
+    _cleanup_test_img
+    _rm_test_img "$TEST_IMG.copy"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 059011ebb1..dfa350936f 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -28,8 +28,10 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-    rm -f "$TEST_IMG".[123]
-	_cleanup_test_img
+    for img in "$TEST_IMG".[123]; do
+        _rm_test_img "$img"
+    done
+    _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index 74d40d0478..01b771c76e 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -29,7 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$SRC_IMG"
+    _rm_test_img "$SRC_IMG"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 8c2ae79f2b..5192d256e3 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -30,7 +30,9 @@ _cleanup()
 {
     _cleanup_qemu
     _cleanup_test_img
-    rm -f "$TEST_DIR"/{b,m,o}.$IMGFMT
+    for img in "$TEST_DIR"/{b,m,o}.$IMGFMT; do
+        _rm_test_img "$img"
+    done
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 6b62271876..daefcbaa58 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -29,7 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f $TEST_IMG.snap
+    _rm_test_img "$TEST_IMG.snap"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 011ed4f2bc..4569ac0b4b 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -34,7 +34,9 @@ TMP_SNAP2=3D${TEST_DIR}/tmp2.qcow2
 _cleanup()
 {
     _cleanup_qemu
-    rm -f "${TEST_IMG}" "${TMP_SNAP1}" "${TMP_SNAP2}"
+    for img in "${TEST_IMG}" "${TMP_SNAP1}" "${TMP_SNAP2}"; do
+        _rm_test_img "$img"
+    done
 }
=20
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index e59090259c..2b13111768 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -30,13 +30,9 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "${TEST_IMG}.base"
-    rm -f "${TEST_IMG}.overlay"
-    rm -f "${TEST_IMG}.convert"
-    rm -f "${TEST_IMG}.a"
-    rm -f "${TEST_IMG}.b"
-    rm -f "${TEST_IMG}.c"
-    rm -f "${TEST_IMG}.lnk"
+    for img in "${TEST_IMG}".{base,overlay,convert,a,b,c,lnk}; do
+        _rm_test_img "$img"
+    done
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 2ffa3ca942..3f27db71f2 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -37,7 +37,9 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_qemu
-    rm -f "$TEST_IMG"{,.target}{,.backing,.overlay}
+    for img in "$TEST_IMG"{,.target}{,.backing,.overlay}; do
+        _rm_test_img "$img"
+    done
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -120,7 +122,9 @@ _send_qemu_cmd $QEMU_HANDLE \
     '"status": "null"'
=20
 # Remove the source images
-rm -f "$TEST_IMG{,.backing,.overlay}"
+for img in "$TEST_IMG{,.backing,.overlay}"; do
+    _rm_test_img "$img"
+done
=20
 echo
=20
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 2557140ac2..f9690053a2 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -28,7 +28,7 @@ status=3D1
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.out"
+    _rm_test_img "$TEST_IMG.out"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index df89d3864b..0572b5ae9a 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -28,7 +28,8 @@ status=3D1
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.out" "$TEST_IMG.out.dd"
+    _rm_test_img "$TEST_IMG.out"
+    _rm_test_img "$TEST_IMG.out.dd"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index 456a4bd8c4..f572a19af2 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -30,8 +30,8 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.base"
-    rm -f "$TEST_IMG.int"
+    _rm_test_img "$TEST_IMG.base"
+    _rm_test_img "$TEST_IMG.int"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 05dd6ed6c3..6c8f0e8085 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -28,7 +28,7 @@ status=3D1
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.out"
+    _rm_test_img  "$TEST_IMG.out"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index d67997e5f6..7195fb895a 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -28,9 +28,9 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	_cleanup_test_img
-    rm -f "$TEST_IMG.2"
-    rm -f "$TEST_IMG.3"
+    _cleanup_test_img
+    _rm_test_img "$TEST_IMG.2"
+    _rm_test_img "$TEST_IMG.3"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index 9e2fa2e73c..bba26f0d2a 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -29,7 +29,8 @@ status=3D1    # failure is the default!
 _cleanup()
 {
     _cleanup_qemu
-    rm  -f "${QEMU_TEST_DIR}/image.base" "${QEMU_TEST_DIR}/image.snp1"
+    _rm_test_img "${TEST_DIR}/image.base"
+    _rm_test_img "${TEST_DIR}/image.snp1"
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 75b5e8f314..51a70fe669 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -29,7 +29,7 @@ status=3D1    # failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.converted"
+    _rm_test_img "$TEST_IMG.converted"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 7f494eb9bb..8de724e7ec 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -30,7 +30,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.overlay"
+    _rm_test_img "$TEST_IMG.overlay"
     rm -f "$TEST_DIR/nbd.socket"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 04fb344d08..eff8e0216c 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -31,7 +31,7 @@ MIG_SOCKET=3D"${TEST_DIR}/migrate"
 _cleanup()
 {
     rm -f "${MIG_SOCKET}"
-    rm -f "${TEST_IMG}.dest"
+    _rm_test_img "${TEST_IMG}.dest"
     _cleanup_test_img
     _cleanup_qemu
 }
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 454ff600cc..e50f19ebf0 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -28,8 +28,8 @@ status=3D1 # failure is the default!
=20
 _cleanup()
 {
-    rm -f "${TEST_IMG}.mid"
-    rm -f "${TEST_IMG}.copy"
+    _rm_test_img "${TEST_IMG}.mid"
+    _rm_test_img "${TEST_IMG}.copy"
     _cleanup_test_img
     _cleanup_qemu
 }
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 2fcef9e2bd..c6e1dc57a0 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -28,9 +28,9 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	_cleanup_test_img
-    rm -f "$TEST_IMG.2"
-    rm -f "$TEST_IMG.3"
+    _cleanup_test_img
+    _rm_test_img "$TEST_IMG.2"
+    _rm_test_img "$TEST_IMG.3"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 5890ff9cfc..6d41650438 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -29,7 +29,7 @@ status=3D1    # failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.converted"
+    _rm_test_img "$TEST_IMG.converted"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index 21c16a32cb..23ab0ce899 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -28,9 +28,9 @@ status=3D1 # failure is the default!
=20
 _cleanup()
 {
-    rm -f "${TEST_IMG}.mid"
-    rm -f "${TEST_IMG}.ovl2"
-    rm -f "${TEST_IMG}.ovl3"
+    _rm_test_img "${TEST_IMG}.mid"
+    _rm_test_img "${TEST_IMG}.ovl2"
+    _rm_test_img "${TEST_IMG}.ovl3"
     _cleanup_test_img
     _cleanup_qemu
 }
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index ef7b9a94e2..48984b7ac1 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -29,7 +29,7 @@ status=3D1 # failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.mid"
+    _rm_test_img "$TEST_IMG.mid"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 4d3d08ad6f..95f05b0e34 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -43,7 +43,7 @@ esac
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_WRAP"
+    _rm_test_img "$TEST_WRAP"
     rm -f "$BLKDBG_CONF"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index d904885136..a2cdd7f83d 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -31,7 +31,8 @@ status=3D1    # failure is the default!
 _cleanup()
 {
     _cleanup_qemu
-    rm -f "${TEST_IMG}" "${BACKING_IMG}"
+    _rm_test_img "${TEST_IMG}"
+    _rm_test_img "${BACKING_IMG}"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index 55a1874dcd..f99bae78c7 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -40,7 +40,7 @@ esac
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_WRAP"
+    _rm_test_img "$TEST_WRAP"
     rm -f "$BLKDBG_CONF"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/225 b/tests/qemu-iotests/225
index fbd7404791..c9a334c7e9 100755
--- a/tests/qemu-iotests/225
+++ b/tests/qemu-iotests/225
@@ -29,7 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.not_base"
+    _rm_test_img "$TEST_IMG.not_base"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index e18a464fe0..866168b236 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -31,7 +31,8 @@ _cleanup()
 {
     _cleanup_qemu
     _cleanup_test_img
-    rm -f "$TEST_IMG" "$DEST_IMG"
+    _rm_test_img "$TEST_IMG"
+    _rm_test_img "$DEST_IMG"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index 65b0e42063..685356ac3b 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -29,7 +29,9 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f $TEST_IMG.[01234]
+    for img in "$TEST_IMG".[01234]; do
+        _rm_test_img "$img"
+    done
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
index 2b84b896db..3dc3b6a711 100755
--- a/tests/qemu-iotests/243
+++ b/tests/qemu-iotests/243
@@ -29,7 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f $TEST_IMG.data
+    _rm_test_img "$TEST_IMG.data"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index 0375bc12d4..13263292b0 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -29,8 +29,8 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f $TEST_IMG.data
-    rm -f $TEST_IMG.src
+    _rm_test_img "$TEST_IMG.data"
+    _rm_test_img "$TEST_IMG.src"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/247 b/tests/qemu-iotests/247
index c853b73819..87e37b39e2 100755
--- a/tests/qemu-iotests/247
+++ b/tests/qemu-iotests/247
@@ -29,7 +29,9 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f $TEST_IMG.[01234]
+    for img in "$TEST_IMG".[01234]; do
+        _rm_test_img "$img"
+    done
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index e4650ecf6b..2b99c9789e 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -30,8 +30,8 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.base"
-    rm -f "$TEST_IMG.int"
+    _rm_test_img "$TEST_IMG.base"
+    _rm_test_img "$TEST_IMG.int"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
diff --git a/tests/qemu-iotests/252 b/tests/qemu-iotests/252
index f6c8f71444..83280c1715 100755
--- a/tests/qemu-iotests/252
+++ b/tests/qemu-iotests/252
@@ -29,7 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.base_new"
+    _rm_test_img "$TEST_IMG.base_new"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
--=20
2.21.0


