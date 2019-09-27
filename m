Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F66C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6B7207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6B7207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmzD-0000lJ-9d
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmmQ-0003Tp-Sb
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmmM-0007h1-Uo
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmmE-0007Wt-TZ; Fri, 27 Sep 2019 05:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A2043086E25;
 Fri, 27 Sep 2019 09:43:02 +0000 (UTC)
Received: from localhost (ovpn-204-76.brq.redhat.com [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 295636061E;
 Fri, 27 Sep 2019 09:43:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 07/18] iotests: Replace IMGOPTS= by -o
Date: Fri, 27 Sep 2019 11:42:31 +0200
Message-Id: <20190927094242.11152-8-mreitz@redhat.com>
In-Reply-To: <20190927094242.11152-1-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 27 Sep 2019 09:43:02 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tests should not overwrite all user-supplied image options, but only add
to it (which will effectively overwrite conflicting values).  Accomplish
this by passing options to _make_test_img via -o instead of $IMGOPTS.

For some tests, there is no functional change because they already only
appended options to IMGOPTS.  For these, this patch is just a
simplification.

For others, this is a change, so they now heed user-specified $IMGOPTS.
Some of those tests do not work with all image options, though, so we
need to disable them accordingly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/031 |  9 ++++---
 tests/qemu-iotests/039 | 24 ++++++------------
 tests/qemu-iotests/059 | 18 ++++++-------
 tests/qemu-iotests/060 |  6 ++---
 tests/qemu-iotests/061 | 57 ++++++++++++++++++++++--------------------
 tests/qemu-iotests/079 |  3 +--
 tests/qemu-iotests/106 |  2 +-
 tests/qemu-iotests/108 |  2 +-
 tests/qemu-iotests/112 | 32 ++++++++++++------------
 tests/qemu-iotests/115 |  3 +--
 tests/qemu-iotests/121 |  6 ++---
 tests/qemu-iotests/125 |  2 +-
 tests/qemu-iotests/137 |  2 +-
 tests/qemu-iotests/138 |  3 +--
 tests/qemu-iotests/175 |  2 +-
 tests/qemu-iotests/190 |  2 +-
 tests/qemu-iotests/191 |  3 +--
 tests/qemu-iotests/220 |  4 ++-
 tests/qemu-iotests/243 |  6 +++--
 tests/qemu-iotests/244 | 10 +++++---
 tests/qemu-iotests/250 |  3 +--
 tests/qemu-iotests/265 |  2 +-
 22 files changed, 100 insertions(+), 101 deletions(-)

diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index a3c25ec237..c44fcf91bb 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -40,19 +40,22 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
+# We want to test compat=3D0.10, which does not support refcount widths
+# other than 16
+_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
=20
 CLUSTER_SIZE=3D65536
=20
 # qcow2.py output depends on the exact options used, so override the com=
mand
 # line here as an exception
-for IMGOPTS in "compat=3D0.10" "compat=3D1.1"; do
+for compat in "compat=3D0.10" "compat=3D1.1"; do
=20
     echo
-    echo =3D=3D=3D=3D=3D Testing with -o $IMGOPTS =3D=3D=3D=3D=3D
+    echo =3D=3D=3D=3D=3D Testing with -o $compat =3D=3D=3D=3D=3D
     echo
     echo =3D=3D=3D Create image with unknown header extension =3D=3D=3D
     echo
-    _make_test_img 64M
+    _make_test_img -o $compat 64M
     $PYTHON qcow2.py "$TEST_IMG" add-header-ext 0x12345678 "This is a te=
st header extension"
     $PYTHON qcow2.py "$TEST_IMG" dump-header
     _check_test_img
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 325da63a4c..99563bf126 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -50,8 +50,7 @@ size=3D128M
 echo
 echo "=3D=3D Checking that image is clean on shutdown =3D=3D"
=20
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don"
-_make_test_img $size
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don" $size
=20
 $QEMU_IO -c "write -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
=20
@@ -62,8 +61,7 @@ _check_test_img
 echo
 echo "=3D=3D Creating a dirty image file =3D=3D"
=20
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don"
-_make_test_img $size
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don" $size
=20
 _NO_VALGRIND \
 $QEMU_IO -c "write -P 0x5a 0 512" \
@@ -98,8 +96,7 @@ $QEMU_IO -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_=
qemu_io
 echo
 echo "=3D=3D Opening a dirty image read/write should repair it =3D=3D"
=20
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don"
-_make_test_img $size
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don" $size
=20
 _NO_VALGRIND \
 $QEMU_IO -c "write -P 0x5a 0 512" \
@@ -117,8 +114,7 @@ $PYTHON qcow2.py "$TEST_IMG" dump-header | grep incom=
patible_features
 echo
 echo "=3D=3D Creating an image file with lazy_refcounts=3Doff =3D=3D"
=20
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Doff"
-_make_test_img $size
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Doff" $size
=20
 _NO_VALGRIND \
 $QEMU_IO -c "write -P 0x5a 0 512" \
@@ -132,11 +128,9 @@ _check_test_img
 echo
 echo "=3D=3D Committing to a backing file with lazy_refcounts=3Don =3D=3D=
"
=20
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don"
-TEST_IMG=3D"$TEST_IMG".base _make_test_img $size
+TEST_IMG=3D"$TEST_IMG".base _make_test_img -o "compat=3D1.1,lazy_refcoun=
ts=3Don" $size
=20
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don,backing_file=3D$TEST_IMG.bas=
e"
-_make_test_img $size
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don,backing_file=3D$TEST=
_IMG.base" $size
=20
 $QEMU_IO -c "write 0 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG commit "$TEST_IMG"
@@ -151,8 +145,7 @@ TEST_IMG=3D"$TEST_IMG".base _check_test_img
 echo
 echo "=3D=3D Changing lazy_refcounts setting at runtime =3D=3D"
=20
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Doff"
-_make_test_img $size
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Doff" $size
=20
 _NO_VALGRIND \
 $QEMU_IO -c "reopen -o lazy-refcounts=3Don" \
@@ -164,8 +157,7 @@ $QEMU_IO -c "reopen -o lazy-refcounts=3Don" \
 $PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
 _check_test_img
=20
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don"
-_make_test_img $size
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don" $size
=20
 _NO_VALGRIND \
 $QEMU_IO -c "reopen -o lazy-refcounts=3Doff" \
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 10bfbaecec..3941c3f0c2 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -70,18 +70,18 @@ poke_file "$TEST_IMG" "$grain_table_size_offset" "\x0=
1\x00\x00\x00"
=20
 echo
 echo "=3D=3D=3D Testing monolithicFlat creation and opening =3D=3D=3D"
-IMGOPTS=3D"subformat=3DmonolithicFlat" _make_test_img 2G
+_make_test_img -o "subformat=3DmonolithicFlat" 2G
 _img_info
 _cleanup_test_img
=20
 echo
 echo "=3D=3D=3D Testing monolithicFlat with zeroed_grain =3D=3D=3D"
-IMGOPTS=3D"subformat=3DmonolithicFlat,zeroed_grain=3Don" _make_test_img =
2G
+_make_test_img -o "subformat=3DmonolithicFlat,zeroed_grain=3Don" 2G
 _cleanup_test_img
=20
 echo
 echo "=3D=3D=3D Testing big twoGbMaxExtentFlat =3D=3D=3D"
-IMGOPTS=3D"subformat=3DtwoGbMaxExtentFlat" _make_test_img 1000G
+_make_test_img -o "subformat=3DtwoGbMaxExtentFlat" 1000G
 $QEMU_IMG info $TEST_IMG | _filter_testdir | sed -e 's/cid: [0-9]*/cid: =
XXXXXXXX/'
 _cleanup_test_img
=20
@@ -101,13 +101,13 @@ _img_info
=20
 echo
 echo "=3D=3D=3D Testing truncated sparse =3D=3D=3D"
-IMGOPTS=3D"subformat=3DmonolithicSparse" _make_test_img 100G
+_make_test_img -o "subformat=3DmonolithicSparse" 100G
 truncate -s 10M $TEST_IMG
 _img_info
=20
 echo
 echo "=3D=3D=3D Converting to streamOptimized from image with small clus=
ter size=3D=3D=3D"
-TEST_IMG=3D"$TEST_IMG.qcow2" IMGFMT=3Dqcow2 IMGOPTS=3D"cluster_size=3D40=
96" _make_test_img 1G
+TEST_IMG=3D"$TEST_IMG.qcow2" IMGFMT=3Dqcow2 _make_test_img -o "cluster_s=
ize=3D4096" 1G
 $QEMU_IO -f qcow2 -c "write -P 0xa 0 512" "$TEST_IMG.qcow2" | _filter_qe=
mu_io
 $QEMU_IO -f qcow2 -c "write -P 0xb 10240 512" "$TEST_IMG.qcow2" | _filte=
r_qemu_io
 $QEMU_IMG convert -f qcow2 -O vmdk -o subformat=3DstreamOptimized "$TEST=
_IMG.qcow2" "$TEST_IMG" 2>&1
@@ -117,7 +117,7 @@ echo "=3D=3D=3D Testing monolithicFlat with internall=
y generated JSON file name =3D=3D=3D"
=20
 echo '--- blkdebug ---'
 # Should work, because bdrv_dirname() works fine with blkdebug
-IMGOPTS=3D"subformat=3DmonolithicFlat" _make_test_img 64M
+_make_test_img -o "subformat=3DmonolithicFlat" 64M
 $QEMU_IO -c "open -o driver=3D$IMGFMT,file.driver=3Dblkdebug,file.image.=
filename=3D$TEST_IMG,file.inject-error.0.event=3Dread_aio" \
          -c info \
     2>&1 \
@@ -126,7 +126,7 @@ _cleanup_test_img
=20
 echo '--- quorum ---'
 # Should not work, because bdrv_dirname() does not work with quorum
-IMGOPTS=3D"subformat=3DmonolithicFlat" _make_test_img 64M
+_make_test_img -o "subformat=3DmonolithicFlat" 64M
 cp "$TEST_IMG" "$TEST_IMG.orig"
=20
 filename=3D"json:{
@@ -161,7 +161,7 @@ _cleanup_test_img
=20
 echo
 echo "=3D=3D=3D Testing 4TB monolithicFlat creation and IO =3D=3D=3D"
-IMGOPTS=3D"subformat=3DmonolithicFlat" _make_test_img 4T
+_make_test_img -o "subformat=3DmonolithicFlat" 4T
 _img_info
 $QEMU_IO -c "write -P 0xa 900G 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "read -v 900G 1024" "$TEST_IMG" | _filter_qemu_io
@@ -170,7 +170,7 @@ _cleanup_test_img
 echo
 echo "=3D=3D=3D Testing qemu-img map on extents =3D=3D=3D"
 for fmt in monolithicSparse twoGbMaxExtentSparse; do
-    IMGOPTS=3D"subformat=3D$fmt" _make_test_img 31G
+    _make_test_img -o "subformat=3D$fmt" 31G
     $QEMU_IO -c "write 65024 1k" "$TEST_IMG" | _filter_qemu_io
     $QEMU_IO -c "write 2147483136 1k" "$TEST_IMG" | _filter_qemu_io
     $QEMU_IO -c "write 5G 1k" "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 9c2ef42522..92243c2edd 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -158,7 +158,7 @@ $QEMU_IO -c 'write 0k 64k' "$BACKING_IMG" | _filter_q=
emu_io
 # compat=3D0.10 is required in order to make the following discard actua=
lly
 # unallocate the sector rather than make it a zero sector - we want COW,=
 after
 # all.
-IMGOPTS=3D'compat=3D0.10' _make_test_img -b "$BACKING_IMG" 1G
+_make_test_img -o 'compat=3D0.10' -b "$BACKING_IMG" 1G
 # Write two clusters, the second one enforces creation of an L2 table af=
ter
 # the first data cluster.
 $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qem=
u_io
@@ -398,7 +398,7 @@ echo
 echo "=3D=3D=3D Discarding a non-covered in-bounds refblock =3D=3D=3D"
 echo
=20
-IMGOPTS=3D'refcount_bits=3D1' _make_test_img 64M
+_make_test_img -o 'refcount_bits=3D1' 64M
=20
 # Pretend there's a refblock somewhere where there is no refblock to
 # cover it (but the covering refblock has a valid index in the
@@ -422,7 +422,7 @@ echo
 echo "=3D=3D=3D Discarding a refblock covered by an unaligned refblock =3D=
=3D=3D"
 echo
=20
-IMGOPTS=3D'refcount_bits=3D1' _make_test_img 64M
+_make_test_img -o 'refcount_bits=3D1' 64M
=20
 # Same as above
 poke_file "$TEST_IMG" "$(($rt_offset+8))" "\x00\x00\x00\x10\x00\x00\x00\=
x00"
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 4eac5b83bd..0480be0141 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -41,11 +41,14 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+# Conversion between different compat versions can only really work
+# with refcount_bits=3D16
+_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
=20
 echo
 echo "=3D=3D=3D Testing version downgrade with zero expansion =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don" _make_test_img 64M
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don" 64M
 $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
 $PYTHON qcow2.py "$TEST_IMG" dump-header
 $QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
@@ -56,7 +59,7 @@ _check_test_img
 echo
 echo "=3D=3D=3D Testing version downgrade with zero expansion and 4K cac=
he entries =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don" _make_test_img 64M
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don" 64M
 $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "write -z 32M 128k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c map "$TEST_IMG" | _filter_qemu_io
@@ -72,7 +75,7 @@ _check_test_img
 echo
 echo "=3D=3D=3D Testing dirty version downgrade =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don" _make_test_img 64M
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don" 64M
 _NO_VALGRIND \
 $QEMU_IO -c "write -P 0x2a 0 128k" -c flush \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 | _filter_qemu_i=
o
@@ -85,7 +88,7 @@ _check_test_img
 echo
 echo "=3D=3D=3D Testing version downgrade with unknown compat/autoclear =
flags =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" _make_test_img 64M
+_make_test_img -o "compat=3D1.1" 64M
 $PYTHON qcow2.py "$TEST_IMG" set-feature-bit compatible 42
 $PYTHON qcow2.py "$TEST_IMG" set-feature-bit autoclear 42
 $PYTHON qcow2.py "$TEST_IMG" dump-header
@@ -96,7 +99,7 @@ _check_test_img
 echo
 echo "=3D=3D=3D Testing version upgrade and resize =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D0.10" _make_test_img 64M
+_make_test_img -o "compat=3D0.10" 64M
 $QEMU_IO -c "write -P 0x2a 42M 64k" "$TEST_IMG" | _filter_qemu_io
 $PYTHON qcow2.py "$TEST_IMG" dump-header
 $QEMU_IMG amend -o "compat=3D1.1,lazy_refcounts=3Don,size=3D128M" "$TEST=
_IMG"
@@ -107,7 +110,7 @@ _check_test_img
 echo
 echo "=3D=3D=3D Testing dirty lazy_refcounts=3Doff =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don" _make_test_img 64M
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don" 64M
 _NO_VALGRIND \
 $QEMU_IO -c "write -P 0x2a 0 128k" -c flush \
          -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 | _filter_qemu_i=
o
@@ -120,8 +123,8 @@ _check_test_img
 echo
 echo "=3D=3D=3D Testing backing file =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" _make_test_img 64M
-IMGOPTS=3D"compat=3D1.1" TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
+_make_test_img -o "compat=3D1.1" 64M
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
 $QEMU_IO -c "read -P 0 0 128k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG amend -o "backing_file=3D$TEST_IMG.base,backing_fmt=3Dqcow2" "=
$TEST_IMG"
@@ -131,7 +134,7 @@ _check_test_img
 echo
 echo "=3D=3D=3D Testing invalid configurations =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D0.10" _make_test_img 64M
+_make_test_img -o "compat=3D0.10" 64M
 $QEMU_IMG amend -o "lazy_refcounts=3Don" "$TEST_IMG"
 $QEMU_IMG amend -o "compat=3D1.1" "$TEST_IMG" # actually valid
 $QEMU_IMG amend -o "compat=3D0.10,lazy_refcounts=3Don" "$TEST_IMG"
@@ -144,7 +147,7 @@ $QEMU_IMG amend -o "preallocation=3Don" "$TEST_IMG"
 echo
 echo "=3D=3D=3D Testing correct handling of unset value =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1,cluster_size=3D1k" _make_test_img 64M
+_make_test_img -o "compat=3D1.1,cluster_size=3D1k" 64M
 echo "Should work:"
 $QEMU_IMG amend -o "lazy_refcounts=3Don" "$TEST_IMG"
 echo "Should not work:" # Just to know which of these tests actually fai=
ls
@@ -153,7 +156,7 @@ $QEMU_IMG amend -o "cluster_size=3D64k" "$TEST_IMG"
 echo
 echo "=3D=3D=3D Testing zero expansion on inactive clusters =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" _make_test_img 64M
+_make_test_img -o "compat=3D1.1" 64M
 $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG snapshot -c foo "$TEST_IMG"
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG" | _filter_qemu_io
@@ -167,7 +170,7 @@ $QEMU_IO -c "read -P 0 0 128k" "$TEST_IMG" | _filter_=
qemu_io
 echo
 echo "=3D=3D=3D Testing zero expansion on shared L2 table =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" _make_test_img 64M
+_make_test_img -o "compat=3D1.1" 64M
 $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG snapshot -c foo "$TEST_IMG"
 $QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
@@ -180,9 +183,9 @@ $QEMU_IO -c "read -P 0 0 128k" "$TEST_IMG" | _filter_=
qemu_io
 echo
 echo "=3D=3D=3D Testing zero expansion on backed image =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
-IMGOPTS=3D"compat=3D1.1" _make_test_img -b "$TEST_IMG.base" 64M
+_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" 64M
 $QEMU_IO -c "read -P 0x2a 0 128k" -c "write -z 0 64k" "$TEST_IMG" | _fil=
ter_qemu_io
 $QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
 _check_test_img
@@ -191,9 +194,9 @@ $QEMU_IO -c "read -P 0 0 64k" -c "read -P 0x2a 64k 64=
k" "$TEST_IMG" | _filter_qe
 echo
 echo "=3D=3D=3D Testing zero expansion on backed inactive clusters =3D=3D=
=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
-IMGOPTS=3D"compat=3D1.1" _make_test_img -b "$TEST_IMG.base" 64M
+_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" 64M
 $QEMU_IO -c "write -z 0 64k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG snapshot -c foo "$TEST_IMG"
 $QEMU_IO -c "write -P 0x42 0 128k" "$TEST_IMG" | _filter_qemu_io
@@ -207,9 +210,9 @@ $QEMU_IO -c "read -P 0 0 64k" -c "read -P 0x2a 64k 64=
k" "$TEST_IMG" | _filter_qe
 echo
 echo "=3D=3D=3D Testing zero expansion on backed image with shared L2 ta=
ble =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
-IMGOPTS=3D"compat=3D1.1" _make_test_img -b "$TEST_IMG.base" 64M
+_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" 64M
 $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG snapshot -c foo "$TEST_IMG"
 $QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
@@ -222,7 +225,7 @@ $QEMU_IO -c "read -P 0 0 128k" "$TEST_IMG" | _filter_=
qemu_io
 echo
 echo "=3D=3D=3D Testing preallocated zero expansion on full image =3D=3D=
=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" TEST_IMG=3D"$TEST_IMG" _make_test_img 64M
+TEST_IMG=3D"$TEST_IMG" _make_test_img -o "compat=3D1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 64M" "$TEST_IMG" -c "write -z 0 64M" | _fil=
ter_qemu_io
 $QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
 _check_test_img
@@ -231,8 +234,8 @@ $QEMU_IO -c "read -P 0 0 64M" "$TEST_IMG" | _filter_q=
emu_io
 echo
 echo "=3D=3D=3D Testing progress report without snapshot =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" TEST_IMG=3D"$TEST_IMG.base" _make_test_img 4G
-IMGOPTS=3D"compat=3D1.1" _make_test_img -b "$TEST_IMG.base" 4G
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 4G
+_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" 4G
 $QEMU_IO -c "write -z 0  64k" \
          -c "write -z 1G 64k" \
          -c "write -z 2G 64k" \
@@ -243,8 +246,8 @@ _check_test_img
 echo
 echo "=3D=3D=3D Testing progress report with snapshot =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" TEST_IMG=3D"$TEST_IMG.base" _make_test_img 4G
-IMGOPTS=3D"compat=3D1.1" _make_test_img -b "$TEST_IMG.base" 4G
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 4G
+_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" 4G
 $QEMU_IO -c "write -z 0  64k" \
          -c "write -z 1G 64k" \
          -c "write -z 2G 64k" \
@@ -256,7 +259,7 @@ _check_test_img
 echo
 echo "=3D=3D=3D Testing version downgrade with external data file =3D=3D=
=3D"
 echo
-IMGOPTS=3D"compat=3D1.1,data_file=3D$TEST_IMG.data" _make_test_img 64M
+_make_test_img -o "compat=3D1.1,data_file=3D$TEST_IMG.data" 64M
 $QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
 _img_info --format-specific
 _check_test_img
@@ -264,11 +267,11 @@ _check_test_img
 echo
 echo "=3D=3D=3D Try changing the external data file =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1" _make_test_img 64M
+_make_test_img -o "compat=3D1.1" 64M
 $QEMU_IMG amend -o "data_file=3Dfoo" "$TEST_IMG"
=20
 echo
-IMGOPTS=3D"compat=3D1.1,data_file=3D$TEST_IMG.data" _make_test_img 64M
+_make_test_img -o "compat=3D1.1,data_file=3D$TEST_IMG.data" 64M
 $QEMU_IMG amend -o "data_file=3Dfoo" "$TEST_IMG"
 _img_info --format-specific
 TEST_IMG=3D"data-file.filename=3D$TEST_IMG.data,file.filename=3D$TEST_IM=
G" _img_info --format-specific --image-opts
@@ -281,7 +284,7 @@ TEST_IMG=3D"data-file.filename=3D$TEST_IMG.data,file.=
filename=3D$TEST_IMG" _img_info -
 echo
 echo "=3D=3D=3D Clearing and setting data-file-raw =3D=3D=3D"
 echo
-IMGOPTS=3D"compat=3D1.1,data_file=3D$TEST_IMG.data,data_file_raw=3Don" _=
make_test_img 64M
+_make_test_img -o "compat=3D1.1,data_file=3D$TEST_IMG.data,data_file_raw=
=3Don" 64M
 $QEMU_IMG amend -o "data_file_raw=3Don" "$TEST_IMG"
 _img_info --format-specific
 _check_test_img
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 81f0c21f53..162355b29a 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -44,8 +44,7 @@ echo
 cluster_sizes=3D"16384 32768 65536 131072 262144 524288 1048576 2097152 =
4194304"
=20
 for s in $cluster_sizes; do
-    IMGOPTS=3D$(_optstr_add "$IMGOPTS" "preallocation=3Dmetadata,cluster=
_size=3D$s") \
-        _make_test_img 4G
+    _make_test_img -o "preallocation=3Dmetadata,cluster_size=3D$s" 4G
 done
=20
 # success, all done
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index ac47eaa0f5..b5d1ec4078 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -51,7 +51,7 @@ for create_mode in off falloc full; do
         echo
         echo "--- create_mode=3D$create_mode growth_mode=3D$growth_mode =
---"
=20
-        IMGOPTS=3D"preallocation=3D$create_mode" _make_test_img ${CREATI=
ON_SIZE}K
+        _make_test_img -o "preallocation=3D$create_mode" ${CREATION_SIZE=
}K
         $QEMU_IMG resize -f "$IMGFMT" --preallocation=3D$growth_mode "$T=
EST_IMG" +${GROWTH_SIZE}K
=20
         expected_size=3D0
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 9c08172237..b0a6ae597b 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -65,7 +65,7 @@ echo
 echo '=3D=3D=3D Repairing unreferenced data cluster in new refblock area=
 =3D=3D=3D'
 echo
=20
-IMGOPTS=3D'cluster_size=3D512' _make_test_img 64M
+_make_test_img -o 'cluster_size=3D512' 64M
 # Allocate the first 128 kB in the image (first refblock)
 $QEMU_IO -c 'write 0 0x1b200' "$TEST_IMG" | _filter_qemu_io
 # should be 131072 =3D=3D 0x20000
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 706c10b600..6850225939 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -53,20 +53,20 @@ echo '=3D=3D=3D refcount_bits limits =3D=3D=3D'
 echo
=20
 # Must be positive (non-zero)
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D0" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D0" 64M
 # Must be positive (non-negative)
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D-1" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D-1" 64M
 # May not exceed 64
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D128" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D128" 64M
 # Must be a power of two
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D42" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D42" 64M
=20
 # 1 is the minimum
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D1" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D1" 64M
 print_refcount_bits
=20
 # 64 is the maximum
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D64" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D64" 64M
 print_refcount_bits
=20
 # 16 is the default
@@ -78,19 +78,19 @@ echo '=3D=3D=3D refcount_bits and compat=3D0.10 =3D=3D=
=3D'
 echo
=20
 # Should work
-IMGOPTS=3D"$IMGOPTS,compat=3D0.10,refcount_bits=3D16" _make_test_img 64M
+_make_test_img -o "compat=3D0.10,refcount_bits=3D16" 64M
 print_refcount_bits
=20
 # Should not work
-IMGOPTS=3D"$IMGOPTS,compat=3D0.10,refcount_bits=3D1" _make_test_img 64M
-IMGOPTS=3D"$IMGOPTS,compat=3D0.10,refcount_bits=3D64" _make_test_img 64M
+_make_test_img -o "compat=3D0.10,refcount_bits=3D1" 64M
+_make_test_img -o "compat=3D0.10,refcount_bits=3D64" 64M
=20
=20
 echo
 echo '=3D=3D=3D Snapshot limit on refcount_bits=3D1 =3D=3D=3D'
 echo
=20
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D1" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D1" 64M
 print_refcount_bits
=20
 $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
@@ -106,7 +106,7 @@ echo
 echo '=3D=3D=3D Snapshot limit on refcount_bits=3D2 =3D=3D=3D'
 echo
=20
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D2" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D2" 64M
 print_refcount_bits
=20
 $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
@@ -124,7 +124,7 @@ echo
 echo '=3D=3D=3D Compressed clusters with refcount_bits=3D1 =3D=3D=3D'
 echo
=20
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D1" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D1" 64M
 print_refcount_bits
=20
 # Both should fit into a single host cluster; instead of failing to incr=
ease the
@@ -140,7 +140,7 @@ echo
 echo '=3D=3D=3D MSb set in 64 bit refcount =3D=3D=3D'
 echo
=20
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D64" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D64" 64M
 print_refcount_bits
=20
 $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
@@ -158,7 +158,7 @@ echo
 echo '=3D=3D=3D Snapshot on maximum 64 bit refcount value =3D=3D=3D'
 echo
=20
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D64" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D64" 64M
 print_refcount_bits
=20
 $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
@@ -239,7 +239,7 @@ echo
 echo '=3D=3D=3D Testing too many references for check =3D=3D=3D'
 echo
=20
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D1" _make_test_img 64M
+_make_test_img -o "refcount_bits=3D1" 64M
 print_refcount_bits
=20
 # This cluster should be created at 0x50000
@@ -262,7 +262,7 @@ echo
 echo '=3D=3D=3D Multiple walks necessary during amend =3D=3D=3D'
 echo
=20
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D1,cluster_size=3D512" _make_test_img=
 64k
+_make_test_img -o "refcount_bits=3D1,cluster_size=3D512" 64k
=20
 # Cluster 0 is the image header, clusters 1 to 4 are used by the L1 tabl=
e, a
 # single L2 table, the reftable and a single refblock. This creates 58 d=
ata
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 9ed3cb6a83..d254b18342 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -64,8 +64,7 @@ echo
 # least 256 MB. We can achieve that by using preallocation=3Dmetadata fo=
r an image
 # which has a guest disk size of 256 MB.
=20
-IMGOPTS=3D"$IMGOPTS,refcount_bits=3D64,cluster_size=3D512,preallocation=3D=
metadata" \
-    _make_test_img 256M
+_make_test_img -o "refcount_bits=3D64,cluster_size=3D512,preallocation=3D=
metadata" 256M
=20
 # We know for sure that the L1 and refcount tables do not overlap with a=
ny other
 # structure because the metadata overlap checks would have caught that c=
ase.
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 90a0424edb..10db813d94 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -50,7 +50,7 @@ echo
 # Preallocation speeds up the write operation, but preallocating everyth=
ing will
 # destroy the purpose of the write; so preallocate one KB less than what=
 would
 # cause a reftable growth...
-IMGOPTS=3D'preallocation=3Dmetadata,cluster_size=3D1k' _make_test_img 64=
512K
+_make_test_img -o 'preallocation=3Dmetadata,cluster_size=3D1k' 64512K
 # ...and make the image the desired size afterwards.
 $QEMU_IMG resize "$TEST_IMG" 65M
=20
@@ -73,7 +73,7 @@ echo
 echo '--- Test 2 ---'
 echo
=20
-IMGOPTS=3D'preallocation=3Dmetadata,cluster_size=3D1k' _make_test_img 64=
513K
+_make_test_img -o 'preallocation=3Dmetadata,cluster_size=3D1k' 64513K
 # This results in an L1 table growth which in turn results in some clust=
ers at
 # the start of the image becoming free
 $QEMU_IMG resize "$TEST_IMG" 65M
@@ -96,7 +96,7 @@ echo
 echo '=3D=3D=3D Allocating a new refcount block must not leave holes in =
the image =3D=3D=3D'
 echo
=20
-IMGOPTS=3D'cluster_size=3D512,refcount_bits=3D16' _make_test_img 1M
+_make_test_img -o 'cluster_size=3D512,refcount_bits=3D16' 1M
=20
 # This results in an image with 256 used clusters: the qcow2 header,
 # the refcount table, one refcount block, the L1 table, four L2 tables
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 4e31aa4e5f..d510984045 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -114,7 +114,7 @@ for GROWTH_SIZE in 16 48 80; do
         for growth_mode in off metadata falloc full; do
             echo "--- cluster_size=3D$cluster_size growth_size=3D$GROWTH=
_SIZE create_mode=3D$create_mode growth_mode=3D$growth_mode ---"
=20
-            IMGOPTS=3D"preallocation=3D$create_mode,cluster_size=3D$clus=
ter_size" _make_test_img ${CREATION_SIZE}
+            _make_test_img -o "preallocation=3D$create_mode,cluster_size=
=3D$cluster_size" ${CREATION_SIZE}
             $QEMU_IMG resize -f "$IMGFMT" --preallocation=3D$growth_mode=
 "$TEST_IMG" +${GROWTH_SIZE}K
=20
             host_size_0=3D$(get_image_size_on_host)
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 089821da0c..6cf2997577 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -117,7 +117,7 @@ $QEMU_IO \
     -c "reopen -o cache-clean-interval=3D-1" \
     "$TEST_IMG" | _filter_qemu_io
=20
-IMGOPTS=3D"cluster_size=3D256k" _make_test_img 32P
+_make_test_img -o "cluster_size=3D256k" 32P
 $QEMU_IO \
     -c "reopen -o l2-cache-entry-size=3D512,l2-cache-size=3D1T" \
     "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 6a731370db..66ae9d5e78 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -45,8 +45,7 @@ echo
 echo '=3D=3D=3D Check on an image with a multiple of 2^32 clusters =3D=3D=
=3D'
 echo
=20
-IMGOPTS=3D$(_optstr_add "$IMGOPTS" "cluster_size=3D512") \
-    _make_test_img 512
+_make_test_img -o "cluster_size=3D512" 512
=20
 # Allocate L2 table
 $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index 55db2803ed..020ed8e61f 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -95,7 +95,7 @@ stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_bl=
ocks $extra_blocks $min_block
 for mode in off full falloc; do
     echo
     echo "=3D=3D creating image with preallocation $mode =3D=3D"
-    IMGOPTS=3Dpreallocation=3D$mode _make_test_img $size | _filter_imgfm=
t
+    _make_test_img -o preallocation=3D$mode $size | _filter_imgfmt
     stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_b=
locks $min_blocks $size
 done
=20
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index eb766ad09f..5890ff9cfc 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -45,7 +45,7 @@ _supported_proto file
 echo "=3D=3D Huge file =3D=3D"
 echo
=20
-IMGOPTS=3D'cluster_size=3D2M' _make_test_img 2T
+_make_test_img -o 'cluster_size=3D2M' 2T
=20
 $QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
 $QEMU_IMG measure -O qcow2 -o cluster_size=3D64k -f qcow2 "$TEST_IMG"
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index 528022e8d8..21c16a32cb 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -51,8 +51,7 @@ echo =3D=3D=3D Preparing and starting VM =3D=3D=3D
 echo
=20
 TEST_IMG=3D"${TEST_IMG}.base" _make_test_img $size
-IMGOPTS=3D$(_optstr_add "$IMGOPTS" "backing_fmt=3D$IMGFMT") \
-    TEST_IMG=3D"${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
+TEST_IMG=3D"${TEST_IMG}.mid" _make_test_img -o "backing_fmt=3D$IMGFMT" -=
b "${TEST_IMG}.base"
 _make_test_img -b "${TEST_IMG}.mid"
 TEST_IMG=3D"${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
=20
diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
index 2d62c5dcac..3769f372cb 100755
--- a/tests/qemu-iotests/220
+++ b/tests/qemu-iotests/220
@@ -37,6 +37,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+# To use a different refcount width but 16 bits we need compat=3D1.1
+_unsupported_imgopts 'compat=3D0.10'
=20
 echo "=3D=3D Creating huge file =3D=3D"
=20
@@ -46,7 +48,7 @@ if ! truncate --size=3D513T "$TEST_IMG"; then
     _notrun "file system on $TEST_DIR does not support large enough file=
s"
 fi
 rm "$TEST_IMG"
-IMGOPTS=3D'cluster_size=3D2M,refcount_bits=3D1' _make_test_img 513T
+_make_test_img -o 'cluster_size=3D2M,refcount_bits=3D1' 513T
=20
 echo "=3D=3D Populating refcounts =3D=3D"
 # We want an image with 256M refcounts * 2M clusters =3D 512T referenced=
.
diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
index e563761307..2b84b896db 100755
--- a/tests/qemu-iotests/243
+++ b/tests/qemu-iotests/243
@@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+# External data files do not work with compat=3D0.10
+_unsupported_imgopts 'compat=3D0.10'
=20
 for mode in off metadata falloc full; do
=20
@@ -47,7 +49,7 @@ for mode in off metadata falloc full; do
     echo "=3D=3D=3D preallocation=3D$mode =3D=3D=3D"
     echo
=20
-    IMGOPTS=3D"preallocation=3D$mode" _make_test_img 64M
+    _make_test_img -o "preallocation=3D$mode" 64M
=20
     printf "File size: "
     du -b $TEST_IMG | cut -f1
@@ -64,7 +66,7 @@ for mode in off metadata falloc full; do
     echo "=3D=3D=3D External data file: preallocation=3D$mode =3D=3D=3D"
     echo
=20
-    IMGOPTS=3D"data_file=3D$TEST_IMG.data,preallocation=3D$mode" _make_t=
est_img 64M
+    _make_test_img -o "data_file=3D$TEST_IMG.data,preallocation=3D$mode"=
 64M
=20
     echo -n "qcow2 file size: "
     du -b $TEST_IMG | cut -f1
diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index 13978f93d2..0375bc12d4 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -41,13 +41,15 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+# External data files do not work with compat=3D0.10
+_unsupported_imgopts 'compat=3D0.10'
=20
 echo
 echo "=3D=3D=3D Create and open image with external data file =3D=3D=3D"
 echo
=20
 echo "With data file name in the image:"
-IMGOPTS=3D"data_file=3D$TEST_IMG.data" _make_test_img 64M
+_make_test_img -o "data_file=3D$TEST_IMG.data" 64M
 _check_test_img
=20
 $QEMU_IO -c "open $TEST_IMG" -c "read -P 0 0 64k" 2>&1 | _filter_qemu_io=
 | _filter_testdir
@@ -104,7 +106,7 @@ echo
 echo "=3D=3D=3D Standalone image with external data file (efficient) =3D=
=3D=3D"
 echo
=20
-IMGOPTS=3D"data_file=3D$TEST_IMG.data" _make_test_img 64M
+_make_test_img -o "data_file=3D$TEST_IMG.data" 64M
=20
 echo -n "qcow2 file size before I/O: "
 du -b $TEST_IMG | cut -f1
@@ -154,7 +156,7 @@ echo
 echo "=3D=3D=3D Standalone image with external data file (valid raw) =3D=
=3D=3D"
 echo
=20
-IMGOPTS=3D"data_file=3D$TEST_IMG.data,data_file_raw=3Don" _make_test_img=
 64M
+_make_test_img -o "data_file=3D$TEST_IMG.data,data_file_raw=3Don" 64M
=20
 echo -n "qcow2 file size before I/O: "
 du -b $TEST_IMG | cut -f1
@@ -187,7 +189,7 @@ echo
 echo "=3D=3D=3D bdrv_co_block_status test for file and offset=3D0 =3D=3D=
=3D"
 echo
=20
-IMGOPTS=3D"data_file=3D$TEST_IMG.data" _make_test_img 64M
+_make_test_img -o "data_file=3D$TEST_IMG.data" 64M
=20
 $QEMU_IO -c 'write -P 0x11 0 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_i=
o
 $QEMU_IO -c 'read -P 0x11 0 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
index c9c0a84a5a..670cf19076 100755
--- a/tests/qemu-iotests/250
+++ b/tests/qemu-iotests/250
@@ -55,9 +55,8 @@ disk_usage()
 }
=20
 size=3D2100M
-IMGOPTS=3D"cluster_size=3D1M,preallocation=3Dmetadata"
=20
-_make_test_img $size
+_make_test_img -o "cluster_size=3D1M,preallocation=3Dmetadata" $size
 $QEMU_IO -c 'discard 0 10M' -c 'discard 2090M 10M' \
          -c 'write 2090M 10M' -c 'write 0 10M' "$TEST_IMG" | _filter_qem=
u_io
=20
diff --git a/tests/qemu-iotests/265 b/tests/qemu-iotests/265
index dce6f77be3..00f2ec769e 100755
--- a/tests/qemu-iotests/265
+++ b/tests/qemu-iotests/265
@@ -41,7 +41,7 @@ _supported_os Linux
 echo '--- Writing to the image ---'
=20
 # Reduce cluster size so we get more and quicker I/O
-IMGOPTS=3D'cluster_size=3D4096' _make_test_img 1M
+_make_test_img -o 'cluster_size=3D4096' 1M
 (for ((kb =3D 1024 - 4; kb >=3D 0; kb -=3D 4)); do \
      echo "aio_write -P 42 $((kb + 1))k 2k"; \
  done) \
--=20
2.21.0


