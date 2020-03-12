Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A2FC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45B0206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McXZXOvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45B0206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTXT-0007Jd-P7
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCTVo-0004uU-0d
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCTVd-00079e-O2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:28:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37814
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCTVd-000797-AS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584041324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfQg1dWjSBEimQj8tKLF7704C3iJKp7y0O3FUJX4C74=;
 b=McXZXOvOzxwwS+coQubu+AjS4FQm4vDSBkGqi5fHYBGguJkcfsCX6stHzbGO3iCxvngjgK
 eOXbn44MEWpooTBFkinzhGZ67sYEho60JqLqPV5vA8x5Nt+l7wYRY5C0uzT9ZIp2nAWZy5
 F8xJkKSFUroImIE3X52yjyYFHS8oOQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-ugq4vEC2O1KFu6e2liNt6A-1; Thu, 12 Mar 2020 15:28:40 -0400
X-MC-Unique: ugq4vEC2O1KFu6e2liNt6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3CD3DB64;
 Thu, 12 Mar 2020 19:28:39 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E113E5DA7B;
 Thu, 12 Mar 2020 19:28:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/7] iotests: Specify explicit backing format where sensible
Date: Thu, 12 Mar 2020 14:28:20 -0500
Message-Id: <20200312192822.3739399-6-eblake@redhat.com>
In-Reply-To: <20200312192822.3739399-1-eblake@redhat.com>
References: <20200312192822.3739399-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 kchamart@redhat.com, libvir-list@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are many existing qcow2 images that specify a backing file but
no format.  This has been the source of CVEs in the past, but has
become more prominent of a problem now that libvirt has switched to
-blockdev.  With older -drive, at least the probing was always done by
qemu (so the only risk of a changed format between successive boots of
a guest was if qemu was upgraded and probed differently).  But with
newer -blockdev, libvirt must specify a format; if libvirt guesses raw
where the image was formatted, this results in data corruption visible
to the guest; conversely, if libvirt guesses qcow2 where qemu was
using raw, this can result in potential security holes, so modern
libvirt instead refuses to use images without explicit backing format.

The change in libvirt to reject images without explicit backing format
has pointed out that a number of tools have been far too reliant on
probing in the past.  It's time to set a better example in our own
iotests of properly setting this parameter.

iotest calls to create, rebase, and convert are all impacted to some
degree.  It's a bit annoying that we are inconsistent on command line
- while all of those accept -o backing_file=3D...,backing_fmt=3D..., the
shortcuts are different: create and rebase have -b and -F, while
convert has -B but no -F.  (amend has no shortcuts, but the previous
patch just deprecated the use of amend to change backing chains).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/017        |  2 +-
 tests/qemu-iotests/017.out    |  2 +-
 tests/qemu-iotests/018        |  2 +-
 tests/qemu-iotests/018.out    |  2 +-
 tests/qemu-iotests/019        |  5 ++--
 tests/qemu-iotests/019.out    |  2 +-
 tests/qemu-iotests/020        |  4 +--
 tests/qemu-iotests/020.out    |  4 +--
 tests/qemu-iotests/024        |  8 +++---
 tests/qemu-iotests/024.out    |  5 ++--
 tests/qemu-iotests/028        |  4 +--
 tests/qemu-iotests/028.out    |  2 +-
 tests/qemu-iotests/030        | 26 +++++++++++++------
 tests/qemu-iotests/034        |  2 +-
 tests/qemu-iotests/034.out    |  2 +-
 tests/qemu-iotests/037        |  2 +-
 tests/qemu-iotests/037.out    |  2 +-
 tests/qemu-iotests/038        |  2 +-
 tests/qemu-iotests/038.out    |  2 +-
 tests/qemu-iotests/039        |  3 ++-
 tests/qemu-iotests/039.out    |  2 +-
 tests/qemu-iotests/040        | 47 +++++++++++++++++++++++++----------
 tests/qemu-iotests/041        | 37 ++++++++++++++++++---------
 tests/qemu-iotests/042        |  4 +--
 tests/qemu-iotests/043        | 18 +++++++-------
 tests/qemu-iotests/043.out    | 16 +++++++-----
 tests/qemu-iotests/046        |  2 +-
 tests/qemu-iotests/046.out    |  2 +-
 tests/qemu-iotests/050        |  4 +--
 tests/qemu-iotests/050.out    |  2 +-
 tests/qemu-iotests/051        |  2 +-
 tests/qemu-iotests/051.out    |  2 +-
 tests/qemu-iotests/051.pc.out |  2 +-
 tests/qemu-iotests/056        |  3 ++-
 tests/qemu-iotests/060        |  2 +-
 tests/qemu-iotests/060.out    |  2 +-
 tests/qemu-iotests/061        | 10 ++++----
 tests/qemu-iotests/061.out    | 10 ++++----
 tests/qemu-iotests/069        |  2 +-
 tests/qemu-iotests/069.out    |  2 +-
 tests/qemu-iotests/073        |  2 +-
 tests/qemu-iotests/073.out    |  2 +-
 tests/qemu-iotests/082        | 10 +++++---
 tests/qemu-iotests/082.out    | 12 ++++-----
 tests/qemu-iotests/085        |  4 +--
 tests/qemu-iotests/085.out    |  6 ++---
 tests/qemu-iotests/089        |  2 +-
 tests/qemu-iotests/089.out    |  2 +-
 tests/qemu-iotests/095        |  4 +--
 tests/qemu-iotests/095.out    |  4 +--
 tests/qemu-iotests/097        |  4 +--
 tests/qemu-iotests/097.out    | 16 ++++++------
 tests/qemu-iotests/098        |  2 +-
 tests/qemu-iotests/098.out    |  8 +++---
 tests/qemu-iotests/110        |  4 +--
 tests/qemu-iotests/110.out    |  4 +--
 tests/qemu-iotests/122        | 27 ++++++++++++--------
 tests/qemu-iotests/122.out    |  8 +++---
 tests/qemu-iotests/126        |  4 +--
 tests/qemu-iotests/126.out    |  4 +--
 tests/qemu-iotests/127        |  4 +--
 tests/qemu-iotests/127.out    |  4 +--
 tests/qemu-iotests/129        |  3 ++-
 tests/qemu-iotests/133        |  2 +-
 tests/qemu-iotests/133.out    |  2 +-
 tests/qemu-iotests/139        |  2 +-
 tests/qemu-iotests/141        |  4 +--
 tests/qemu-iotests/141.out    |  4 +--
 tests/qemu-iotests/142        |  2 +-
 tests/qemu-iotests/142.out    |  2 +-
 tests/qemu-iotests/153        | 14 +++++------
 tests/qemu-iotests/153.out    | 35 ++++++++++++++------------
 tests/qemu-iotests/154        | 42 +++++++++++++++----------------
 tests/qemu-iotests/154.out    | 42 +++++++++++++++----------------
 tests/qemu-iotests/155        | 12 ++++++---
 tests/qemu-iotests/156        |  9 ++++---
 tests/qemu-iotests/156.out    |  6 ++---
 tests/qemu-iotests/158        |  2 +-
 tests/qemu-iotests/158.out    |  2 +-
 tests/qemu-iotests/161        |  8 +++---
 tests/qemu-iotests/161.out    |  8 +++---
 tests/qemu-iotests/176        |  4 +--
 tests/qemu-iotests/176.out    | 32 ++++++++++++------------
 tests/qemu-iotests/177        |  2 +-
 tests/qemu-iotests/177.out    |  2 +-
 tests/qemu-iotests/179        |  2 +-
 tests/qemu-iotests/179.out    |  2 +-
 tests/qemu-iotests/189        |  2 +-
 tests/qemu-iotests/189.out    |  2 +-
 tests/qemu-iotests/191        | 12 ++++-----
 tests/qemu-iotests/191.out    | 12 ++++-----
 tests/qemu-iotests/195        |  6 ++---
 tests/qemu-iotests/195.out    |  6 ++---
 tests/qemu-iotests/198        |  2 +-
 tests/qemu-iotests/198.out    |  3 ++-
 tests/qemu-iotests/204        |  2 +-
 tests/qemu-iotests/204.out    |  2 +-
 tests/qemu-iotests/216        |  2 +-
 tests/qemu-iotests/224        |  4 +--
 tests/qemu-iotests/225        |  2 +-
 tests/qemu-iotests/225.out    |  2 +-
 tests/qemu-iotests/228        |  5 ++--
 tests/qemu-iotests/245        |  3 ++-
 tests/qemu-iotests/249        |  4 +--
 tests/qemu-iotests/249.out    |  4 +--
 tests/qemu-iotests/252        |  2 +-
 tests/qemu-iotests/257        |  3 ++-
 tests/qemu-iotests/267        |  4 +--
 tests/qemu-iotests/267.out    |  6 ++---
 tests/qemu-iotests/270        |  2 +-
 tests/qemu-iotests/270.out    |  2 +-
 tests/qemu-iotests/273        |  4 +--
 tests/qemu-iotests/273.out    |  4 +--
 tests/qemu-iotests/279        |  4 +--
 tests/qemu-iotests/279.out    |  4 +--
 115 files changed, 410 insertions(+), 336 deletions(-)

diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 0a4b854e6520..585512bb296b 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -66,7 +66,7 @@ echo "Creating test image with backing file"
 echo

 TEST_IMG=3D$TEST_IMG_SAVE
-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G

 echo "Filling test image"
 echo
diff --git a/tests/qemu-iotests/017.out b/tests/qemu-iotests/017.out
index 8fc9241942e8..f439d3ece3a7 100644
--- a/tests/qemu-iotests/017.out
+++ b/tests/qemu-iotests/017.out
@@ -269,7 +269,7 @@ wrote 65536/65536 bytes at offset 4295032832
 No errors were found on the image.
 Creating test image with backing file

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 Filling test image

 =3D=3D=3D IO: pattern 1
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index c69ce0920920..191b461a4d29 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -66,7 +66,7 @@ echo "Creating test image with backing file"
 echo

 TEST_IMG=3D"$TEST_IMG_SAVE.orig"
-_make_test_img -b "$TEST_IMG_SAVE.base" 6G
+_make_test_img -b "$TEST_IMG_SAVE.base" -F $IMGFMT 6G

 echo "Filling test image"
 echo
diff --git a/tests/qemu-iotests/018.out b/tests/qemu-iotests/018.out
index 5df966727f98..0ab664ca4b4c 100644
--- a/tests/qemu-iotests/018.out
+++ b/tests/qemu-iotests/018.out
@@ -269,7 +269,7 @@ wrote 65536/65536 bytes at offset 4295032832
 No errors were found on the image.
 Creating test image with backing file

-Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D6442450944 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D6442450944 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 Filling test image

 =3D=3D=3D IO: pattern 1
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index 813a84acac47..d3c11256dc0f 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -74,7 +74,7 @@ echo "Creating test image with backing file"
 echo

 TEST_IMG=3D"$TEST_IMG_SAVE.orig"
-_make_test_img -b "$TEST_IMG_SAVE.base" 6G
+_make_test_img -b "$TEST_IMG_SAVE.base" -F $IMGFMT 6G

 echo "Filling test image"
 echo
@@ -98,7 +98,8 @@ for backing_option in "-B " "-o backing_file=3D"; do
     echo
     echo Testing conversion with $backing_option"$TEST_IMG.base" | _filter=
_testdir | _filter_imgfmt
     echo
-    $QEMU_IMG convert -f $IMGFMT -O $IMGFMT $backing_option"$TEST_IMG.base=
" "$TEST_IMG.orig" "$TEST_IMG"
+    $QEMU_IMG convert -f $IMGFMT -O $IMGFMT $backing_option"$TEST_IMG.base=
" \
+        -o backing_fmt=3D$IMGFMT "$TEST_IMG.orig" "$TEST_IMG"

     echo "Checking if backing clusters are allocated when they shouldn't"
     echo
diff --git a/tests/qemu-iotests/019.out b/tests/qemu-iotests/019.out
index 17a7c036b989..0fa73bd69ab8 100644
--- a/tests/qemu-iotests/019.out
+++ b/tests/qemu-iotests/019.out
@@ -269,7 +269,7 @@ wrote 65536/65536 bytes at offset 4296015872
 No errors were found on the image.
 Creating test image with backing file

-Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D6442450944 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D6442450944 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 Filling test image

 =3D=3D=3D IO: pattern 43
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 20f8f185d071..f90f133f1262 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -70,7 +70,7 @@ echo "Creating test image with backing file"
 echo

 TEST_IMG=3D"$TEST_IMG_SAVE"
-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G

 echo "Filling test image"
 echo
@@ -126,7 +126,7 @@ _make_test_img -b "json:{'driver': '$IMGFMT',
                              'image': {
                                  'driver': 'file',
                                  'filename': '$TEST_IMG.base'
-                             }}}"
+                             }}}" -F $IMGFMT

 # Just write anything so committing will not be a no-op
 $QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
index 4b722b2dd022..8c0bf238b297 100644
--- a/tests/qemu-iotests/020.out
+++ b/tests/qemu-iotests/020.out
@@ -269,7 +269,7 @@ wrote 65536/65536 bytes at offset 4295032832
 No errors were found on the image.
 Creating test image with backing file

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 Filling test image

 =3D=3D=3D IO: pattern 1
@@ -1090,7 +1090,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1=
048576 backing_file=3Djson:{'driv
                              'image': {
                                  'driver': 'file',,
                                  'filename': 'TEST_DIR/t.IMGFMT.base'
-                             }}}
+                             }}} backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Block job failed: No space left on device
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index e2e766241e1a..3c5d57310e94 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -83,7 +83,7 @@ TEST_IMG=3D"$TEST_IMG_SAVE"
 echo "Creating COW image"
 echo

-_make_test_img -b "$TEST_IMG.base_old" 1G
+_make_test_img -b "$TEST_IMG.base_old" -F $IMGFMT 1G
 io_pattern writev 0 $((4 * CLUSTER_SIZE)) 0 1 0x33
 io_pattern writev $((8 * CLUSTER_SIZE)) $((4 * CLUSTER_SIZE)) 0 1 0x33

@@ -109,7 +109,7 @@ io_pattern readv $((15 * CLUSTER_SIZE)) $CLUSTER_SIZE 0=
 1 0x00
 echo
 echo Rebase and test again
 echo
-$QEMU_IMG rebase -b "$TEST_IMG.base_new" "$TEST_IMG"
+$QEMU_IMG rebase -b "$TEST_IMG.base_new" -F $IMGFMT "$TEST_IMG"
 io_pattern readv $((0 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x33
 io_pattern readv $((1 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x33
 io_pattern readv $((2 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x33
@@ -159,7 +159,7 @@ OVERLAY=3D"$TEST_DIR/$OVERLAY_WREL"

 TEST_IMG=3D$BASE_OLD _make_test_img 1M
 TEST_IMG=3D$BASE_NEW _make_test_img 1M
-TEST_IMG=3D$OVERLAY _make_test_img -b "$BASE_OLD_OREL" 1M
+TEST_IMG=3D$OVERLAY _make_test_img -b "$BASE_OLD_OREL" -F $IMGFMT 1M

 echo

@@ -176,7 +176,7 @@ $QEMU_IO "$BASE_NEW" \
 echo

 pushd "$TEST_DIR" >/dev/null
-$QEMU_IMG rebase -f "$IMGFMT" -b "$BASE_NEW_OREL" "$OVERLAY_WREL"
+$QEMU_IMG rebase -f "$IMGFMT" -b "$BASE_NEW_OREL" -F $IMGFMT "$OVERLAY_WRE=
L"
 popd >/dev/null

 # Verify the backing path is correct
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 024dc786b3c4..f4fd77fd5b4d 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -33,7 +33,7 @@ wrote 131072/131072 bytes at offset 786432
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Creating COW image

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base_old
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base_old backing_fmt=3DIMGFMT
 =3D=3D=3D IO: pattern 0x33
 wrote 262144/262144 bytes at offset 0
 256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -146,7 +146,7 @@ read 65536/65536 bytes at offset 983040

 Formatting 'TEST_DIR/subdir/t.IMGFMT.base_old', fmt=3DIMGFMT size=3D104857=
6
 Formatting 'TEST_DIR/subdir/t.IMGFMT.base_new', fmt=3DIMGFMT size=3D104857=
6
-Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing=
_file=3Dt.IMGFMT.base_old
+Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing=
_file=3Dt.IMGFMT.base_old backing_fmt=3DIMGFMT

 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -158,6 +158,7 @@ wrote 65536/65536 bytes at offset 196608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 backing file: t.IMGFMT.base_new (actual path: TEST_DIR/subdir/t.IMGFMT.bas=
e_new)
+backing file format: IMGFMT

 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 797dae535042..5d043cef9289 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -76,7 +76,7 @@ echo "Creating test image with backing file"
 echo

 TEST_IMG=3D"$TEST_IMG_SAVE"
-_make_test_img -b "$TEST_IMG.base" $image_size
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $image_size

 echo "Filling test image"
 echo
@@ -101,7 +101,7 @@ io_zero readv $(( offset + 32 * 1024 )) 512 1024 32
 _check_test_img

 # Rebase it on top of its base image
-$QEMU_IMG rebase -b "$TEST_IMG.base" "$TEST_IMG"
+$QEMU_IMG rebase -b "$TEST_IMG.base" -F $IMGFMT "$TEST_IMG"

 echo
 echo block-backup
diff --git a/tests/qemu-iotests/028.out b/tests/qemu-iotests/028.out
index 37aed8443628..12f82c6a6c39 100644
--- a/tests/qemu-iotests/028.out
+++ b/tests/qemu-iotests/028.out
@@ -70,7 +70,7 @@ wrote 512/512 bytes at offset 3221225984
 No errors were found on the image.
 Creating test image with backing file

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294968832 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294968832 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 Filling test image

 =3D=3D=3D IO: pattern 196
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index aa911d266a13..322e31e2cd93 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -32,8 +32,12 @@ class TestSingleDrive(iotests.QMPTestCase):

     def setUp(self):
         iotests.create_image(backing_img, TestSingleDrive.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % mid_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img,
+                 '-F', 'raw', mid_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % mid_img,
+                 '-F', iotests.imgfmt, test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 512', backing_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 524288 512', mid=
_img)
         self.vm =3D iotests.VM().add_drive("blkdebug::" + test_img,
@@ -199,7 +203,8 @@ class TestParallelOps(iotests.QMPTestCase):
         iotests.create_image(self.imgs[0], self.image_len)
         for i in range(1, self.num_imgs):
             qemu_img('create', '-f', iotests.imgfmt,
-                     '-o', 'backing_file=3D%s' % self.imgs[i-1], self.imgs=
[i])
+                     '-o', 'backing_file=3D%s' % self.imgs[i-1],
+                     '-F', 'raw' if i =3D=3D 1 else iotests.imgfmt, self.i=
mgs[i])

         # Put data into the images we are copying data from
         odd_img_indexes =3D [x for x in reversed(range(self.num_imgs)) if =
x % 2 =3D=3D 1]
@@ -544,7 +549,8 @@ class TestQuorum(iotests.QMPTestCase):
             qemu_io('-f', iotests.imgfmt,
                     '-c', 'write -P 0x55 0 1024', backing_img)
             qemu_img('create', '-f', iotests.imgfmt,
-                     '-o', 'backing_file=3D%s' % backing_img, child_img)
+                     '-o', 'backing_file=3D%s' % backing_img,
+                     '-F', iotests.imgfmt, child_img)
             opts.append("children.%d.file.filename=3D%s" % (i, child_img))
             opts.append("children.%d.node-name=3Dnode%d" % (i, i))

@@ -585,7 +591,9 @@ class TestSmallerBackingFile(iotests.QMPTestCase):

     def setUp(self):
         iotests.create_image(backing_img, self.backing_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, test_img, str(self.image_len))
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img,
+                 '-F', 'raw', test_img, str(self.image_len))
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.launch()

@@ -848,7 +856,9 @@ class TestStreamStop(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', backing_img, str(TestStreamStop.image_len))
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 32M', backing_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img,
+                 '-F', 'raw', test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 32M 32M', test_i=
mg)
         self.vm =3D iotests.VM().add_drive("blkdebug::" + test_img)
         self.vm.launch()
@@ -879,7 +889,9 @@ class TestSetSpeed(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', backing_img, str(TestSetSpeed.image_len))
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 32M', backing_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img,
+                 '-F', 'raw', test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 32M 32M', test_i=
mg)
         self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
         self.vm.launch()
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index da4cea1571e4..ac2d687c71da 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -58,7 +58,7 @@ $QEMU_IO -c "write -P 0x55 0 1M" "$TEST_IMG" | _filter_qe=
mu_io

 TEST_IMG=3D"$TEST_IMG_SAVE"

-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G

 echo
 echo "=3D=3D zero write with backing file =3D=3D"
diff --git a/tests/qemu-iotests/034.out b/tests/qemu-iotests/034.out
index 0764ead8b95d..478205ad2542 100644
--- a/tests/qemu-iotests/034.out
+++ b/tests/qemu-iotests/034.out
@@ -4,7 +4,7 @@ QA output created by 034
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D zero write with backing file =3D=3D
 wrote 196608/196608 bytes at offset 65536
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index e6517acbd4cd..e1187ac24a0b 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -74,7 +74,7 @@ backing_io 0 256 write | $QEMU_IO "$TEST_IMG" | _filter_q=
emu_io

 TEST_IMG=3D"$TEST_IMG_SAVE"

-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G

 echo
 echo "=3D=3D COW in a single cluster =3D=3D"
diff --git a/tests/qemu-iotests/037.out b/tests/qemu-iotests/037.out
index cd6710c90160..30ef989b64d6 100644
--- a/tests/qemu-iotests/037.out
+++ b/tests/qemu-iotests/037.out
@@ -514,7 +514,7 @@ wrote 512/512 bytes at offset 130048
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 130560
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D COW in a single cluster =3D=3D
 wrote 2048/2048 bytes at offset 0
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index 707e2d72e92d..a253231f5baf 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -71,7 +71,7 @@ backing_io 0 256 write | $QEMU_IO "$TEST_IMG" | _filter_q=
emu_io

 TEST_IMG=3D"$TEST_IMG_SAVE"

-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G

 echo
 echo "=3D=3D Some concurrent requests touching the same cluster =3D=3D"
diff --git a/tests/qemu-iotests/038.out b/tests/qemu-iotests/038.out
index 0bdfb19faa63..fe2108593ae6 100644
--- a/tests/qemu-iotests/038.out
+++ b/tests/qemu-iotests/038.out
@@ -514,7 +514,7 @@ wrote 65536/65536 bytes at offset 16646144
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 16711680
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D Some concurrent requests touching the same cluster =3D=3D
 wrote 65536/65536 bytes at offset XXX
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index ddce48ab4752..42f65031383a 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -133,7 +133,8 @@ echo "=3D=3D Committing to a backing file with lazy_ref=
counts=3Don =3D=3D"

 TEST_IMG=3D"$TEST_IMG".base _make_test_img -o "compat=3D1.1,lazy_refcounts=
=3Don" $size

-_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don,backing_file=3D$TEST_I=
MG.base" $size
+_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don,backing_file=3D$TEST_I=
MG.base" \
+    -F $IMGFMT $size

 $QEMU_IO -c "write 0 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG commit "$TEST_IMG"
diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index bdafa3ace360..e52484d4be1b 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -66,7 +66,7 @@ No errors were found on the image.

 =3D=3D Committing to a backing file with lazy_refcounts=3Don =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 32c82b4ec68a..f58f50d023e6 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -80,8 +80,11 @@ class TestSingleDrive(ImageCommitTestCase):

     def setUp(self):
         iotests.create_image(backing_img, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % mid_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img, '-F', 'raw', mid=
_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % mid_img,
+                 '-F', iotests.imgfmt, test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', backing_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288',=
 mid_img)
         self.vm =3D iotests.VM().add_drive(test_img, "node-name=3Dtop,back=
ing.node-name=3Dmid,backing.backing.node-name=3Dbase", interface=3D"none")
@@ -305,10 +308,16 @@ class TestRelativePaths(ImageCommitTestCase):
             if exception.errno !=3D errno.EEXIST:
                 raise
         iotests.create_image(self.backing_img_abs, TestRelativePaths.image=
_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % self.backing_img_abs, self.mid_img_abs)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % self.mid_img_abs, self.test_img)
-        qemu_img('rebase', '-u', '-b', self.backing_img, self.mid_img_abs)
-        qemu_img('rebase', '-u', '-b', self.mid_img, self.test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % self.backing_img_abs,
+                 '-F', 'raw', self.mid_img_abs)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % self.mid_img_abs,
+                 '-F', iotests.imgfmt, self.test_img)
+        qemu_img('rebase', '-u', '-b', self.backing_img,
+                 '-F', 'raw', self.mid_img_abs)
+        qemu_img('rebase', '-u', '-b', self.mid_img,
+                 '-F', iotests.imgfmt, self.test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', self.backing_=
img_abs)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288',=
 self.mid_img_abs)
         self.vm =3D iotests.VM().add_drive(self.test_img)
@@ -371,8 +380,11 @@ class TestSetSpeed(ImageCommitTestCase):

     def setUp(self):
         qemu_img('create', backing_img, str(TestSetSpeed.image_len))
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % mid_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img, '-F', 'raw', mid=
_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % mid_img,
+                 '-F', iotests.imgfmt, test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 0 512', test_img=
)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288',=
 mid_img)
         self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
@@ -410,9 +422,14 @@ class TestReopenOverlay(ImageCommitTestCase):

     def setUp(self):
         iotests.create_image(self.img0, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % self.img0, self.img1)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % self.img1, self.img2)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % self.img2, self.img3)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % self.img0, '-F', 'raw', self.=
img1)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % self.img1,
+                 '-F', iotests.imgfmt, self.img2)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % self.img2,
+                 '-F', iotests.imgfmt, self.img3)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xab 0 128K', self.i=
mg1)
         self.vm =3D iotests.VM().add_drive(self.img3)
         self.vm.launch()
@@ -435,8 +452,12 @@ class TestErrorHandling(iotests.QMPTestCase):

     def setUp(self):
         iotests.create_image(backing_img, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % mid_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img,
+                 '-F', 'raw', mid_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % mid_img,
+                 '-F', iotests.imgfmt, test_img)

         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x11 0 512k', mid_im=
g)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x22 0 512k', test_i=
mg)
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 5d67bf14bfe8..547d75cc491a 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -44,7 +44,8 @@ class TestSingleDrive(iotests.QMPTestCase):

     def setUp(self):
         iotests.create_image(backing_img, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img, '-F', 'raw', tes=
t_img)
         self.vm =3D iotests.VM().add_drive(test_img, "node-name=3Dtop,back=
ing.node-name=3Dbase")
         if iotests.qemu_default_machine =3D=3D 'pc':
             self.vm.add_drive(None, 'media=3Dcdrom', 'ide')
@@ -157,7 +158,8 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()

         qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=3D%d,=
backing_file=3D%s'
-                        % (self.image_len, backing_img), target_img)
+                        % (self.image_len, backing_img),
+                 '-F', 'raw', target_img)
         result =3D self.vm.qmp(self.qmp_cmd, device=3D'drive0', sync=3D'fu=
ll',
                              mode=3D'existing', target=3Dself.qmp_target)
         self.assert_qmp(result, 'return', {})
@@ -227,7 +229,8 @@ class TestSingleBlockdev(TestSingleDrive):

     def setUp(self):
         TestSingleDrive.setUp(self)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, target_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img, '-F', 'raw', tar=
get_img)
         args =3D {'driver': iotests.imgfmt,
                 'node-name': self.qmp_target,
                 'file': { 'filename': target_img, 'driver': 'file' } }
@@ -265,7 +268,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):

     def setUp(self):
         iotests.create_image(backing_img, TestMirrorNoBacking.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img, '-F', 'raw', tes=
t_img)
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.launch()

@@ -282,7 +286,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
     def test_complete(self):
         self.assert_no_active_block_jobs()

-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, target_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img, '-F', 'raw', tar=
get_img)
         result =3D self.vm.qmp('drive-mirror', device=3D'drive0', sync=3D'=
full',
                              mode=3D'existing', target=3Dtarget_img)
         self.assert_qmp(result, 'return', {})
@@ -297,7 +302,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
     def test_cancel(self):
         self.assert_no_active_block_jobs()

-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, target_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img, '-F', 'raw', tar=
get_img)
         result =3D self.vm.qmp('drive-mirror', device=3D'drive0', sync=3D'=
full',
                              mode=3D'existing', target=3Dtarget_img)
         self.assert_qmp(result, 'return', {})
@@ -316,7 +322,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'size=3D%d'
                         %(TestMirrorNoBacking.image_len), target_backing_i=
mg)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=3D%d,=
backing_file=3D%s'
-                        % (TestMirrorNoBacking.image_len, target_backing_i=
mg), target_img)
+                        % (TestMirrorNoBacking.image_len, target_backing_i=
mg),
+                 '-F', iotests.imgfmt, target_img)

         result =3D self.vm.qmp('drive-mirror', device=3D'drive0', sync=3D'=
full',
                              mode=3D'existing', target=3Dtarget_img)
@@ -335,7 +342,8 @@ class TestMirrorResized(iotests.QMPTestCase):

     def setUp(self):
         iotests.create_image(backing_img, TestMirrorResized.backing_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img, '-F', 'raw', tes=
t_img)
         qemu_img('resize', test_img, '2M')
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.launch()
@@ -481,7 +489,9 @@ new_state =3D "1"
         # Test COW into the target image.  The first half of the
         # cluster at MIRROR_GRANULARITY has to be copied from
         # backing_img, even though sync=3D'top'.
-        qemu_img('create', '-f', iotests.imgfmt, '-ocluster_size=3D131072,=
backing_file=3D%s' %(backing_img), target_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-ocluster_size=3D131072,backing_file=3D%s' %(backing_img=
),
+                 '-F', 'raw', target_img)
         result =3D self.vm.qmp('drive-mirror', device=3D'drive0', sync=3D'=
top',
                              on_source_error=3D'ignore',
                              mode=3D'existing', target=3Dtarget_img)
@@ -501,7 +511,8 @@ new_state =3D "1"
         self.vm.shutdown()

         # Detach blkdebug to compare images successfully
-        qemu_img('rebase', '-f', iotests.imgfmt, '-u', '-b', backing_img, =
test_img)
+        qemu_img('rebase', '-f', iotests.imgfmt, '-u', '-b', backing_img,
+                 '-F', 'raw', test_img)
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirrorin=
g')

@@ -573,7 +584,8 @@ new_state =3D "1"
         self.blkdebug_file =3D target_img + ".blkdebug"
         iotests.create_image(backing_img, TestWriteErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "write_aio", 5)
-        qemu_img('create', '-f', iotests.imgfmt, '-obacking_file=3D%s' %(b=
acking_img), test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-obacking_file=3D%s' %(backing_img), '-F', 'raw', test_i=
mg)
         self.vm =3D iotests.VM().add_drive(test_img)
         self.target_img =3D 'blkdebug:%s:%s' % (self.blkdebug_file, target=
_img)
         qemu_img('create', '-f', iotests.imgfmt, '-osize=3D%d' %(TestWrite=
Errors.image_len), target_img)
@@ -668,7 +680,8 @@ class TestSetSpeed(iotests.QMPTestCase):

     def setUp(self):
         qemu_img('create', backing_img, str(TestSetSpeed.image_len))
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img, '-F', 'raw', tes=
t_img)
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.launch()

diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index 0e85b356b76a..e8f23a174ce7 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -64,8 +64,8 @@ _check_test_img
 echo
 echo "=3D=3D Rebasing the image =3D=3D"

-$QEMU_IMG rebase -u -b "$TEST_IMG.orig" "$TEST_IMG"
-$QEMU_IMG rebase -b "$TEST_IMG.orig" "$TEST_IMG"
+$QEMU_IMG rebase -u -b "$TEST_IMG.orig" -F $IMGFMT "$TEST_IMG"
+$QEMU_IMG rebase -b "$TEST_IMG.orig" -F $IMGFMT "$TEST_IMG"
 _check_test_img

 # success, all done
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index b102e49208b8..e4022b7044de 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -46,7 +46,7 @@ _supported_proto file

 size=3D128M
 _make_test_img $size
-$QEMU_IMG rebase -u -b "$TEST_IMG" "$TEST_IMG"
+$QEMU_IMG rebase -u -b "$TEST_IMG" -F $IMGFMT "$TEST_IMG"

 echo
 echo "=3D=3D backing file references self =3D=3D"
@@ -54,8 +54,8 @@ _img_info --backing-chain

 _make_test_img $size
 mv "$TEST_IMG" "$TEST_IMG.base"
-_make_test_img -b "$TEST_IMG.base" $size
-$QEMU_IMG rebase -u -b "$TEST_IMG" "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
+$QEMU_IMG rebase -u -b "$TEST_IMG" -F $IMGFMT "$TEST_IMG.base"

 echo
 echo "=3D=3D parent references self =3D=3D"
@@ -63,12 +63,12 @@ _img_info --backing-chain

 _make_test_img $size
 mv "$TEST_IMG" "$TEST_IMG.1.base"
-_make_test_img -b "$TEST_IMG.1.base" $size
+_make_test_img -b "$TEST_IMG.1.base" -F $IMGFMT $size
 mv "$TEST_IMG" "$TEST_IMG.2.base"
-_make_test_img -b "$TEST_IMG.2.base" $size
+_make_test_img -b "$TEST_IMG.2.base" -F $IMGFMT $size
 mv "$TEST_IMG" "$TEST_IMG.3.base"
-_make_test_img -b "$TEST_IMG.3.base" $size
-$QEMU_IMG rebase -u -b "$TEST_IMG.2.base" "$TEST_IMG.1.base"
+_make_test_img -b "$TEST_IMG.3.base" -F $IMGFMT $size
+$QEMU_IMG rebase -u -b "$TEST_IMG.2.base" -F $IMGFMT "$TEST_IMG.1.base"

 echo
 echo "=3D=3D ancestor references another ancestor =3D=3D"
@@ -76,9 +76,9 @@ _img_info --backing-chain

 _make_test_img $size
 mv "$TEST_IMG" "$TEST_IMG.1.base"
-_make_test_img -b "$TEST_IMG.1.base" $size
+_make_test_img -b "$TEST_IMG.1.base" -F $IMGFMT $size
 mv "$TEST_IMG" "$TEST_IMG.2.base"
-_make_test_img -b "$TEST_IMG.2.base" $size
+_make_test_img -b "$TEST_IMG.2.base" -F $IMGFMT $size

 echo
 echo "=3D=3D finite chain of length 3 (human) =3D=3D"
diff --git a/tests/qemu-iotests/043.out b/tests/qemu-iotests/043.out
index 0280f999ce12..7251e26d4ff9 100644
--- a/tests/qemu-iotests/043.out
+++ b/tests/qemu-iotests/043.out
@@ -4,20 +4,20 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D13421=
7728
 =3D=3D backing file references self =3D=3D
 qemu-img: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D parent references self =3D=3D
 qemu-img: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.1.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.2.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.3.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.1.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.2.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.3.base backing_fmt=3DIMGFMT

 =3D=3D ancestor references another ancestor =3D=3D
 qemu-img: Backing file 'TEST_DIR/t.IMGFMT.2.base' creates an infinite loop=
.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.1.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.2.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.1.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.2.base backing_fmt=3DIMGFMT

 =3D=3D finite chain of length 3 (human) =3D=3D
 image: TEST_DIR/t.IMGFMT
@@ -25,12 +25,14 @@ file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.2.base
+backing file format: IMGFMT

 image: TEST_DIR/t.IMGFMT.2.base
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.1.base
+backing file format: IMGFMT

 image: TEST_DIR/t.IMGFMT.1.base
 file format: IMGFMT
@@ -40,6 +42,7 @@ cluster_size: 65536
 =3D=3D finite chain of length 3 (json) =3D=3D
 [
     {
+        "backing-filename-format": "IMGFMT",
         "virtual-size": 134217728,
         "filename": "TEST_DIR/t.IMGFMT",
         "cluster-size": 65536,
@@ -49,6 +52,7 @@ cluster_size: 65536
         "dirty-flag": false
     },
     {
+        "backing-filename-format": "IMGFMT",
         "virtual-size": 134217728,
         "filename": "TEST_DIR/t.IMGFMT.2.base",
         "cluster-size": 65536,
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index a066eec60598..7384136dc016 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -69,7 +69,7 @@ backing_io 0 32 write | $QEMU_IO "$TEST_IMG" | _filter_qe=
mu_io

 mv "$TEST_IMG" "$TEST_IMG.base"

-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G

 echo
 echo "=3D=3D Some concurrent requests touching the same cluster =3D=3D"
diff --git a/tests/qemu-iotests/046.out b/tests/qemu-iotests/046.out
index ca2c7404a914..1a9dfe200f6f 100644
--- a/tests/qemu-iotests/046.out
+++ b/tests/qemu-iotests/046.out
@@ -66,7 +66,7 @@ wrote 65536/65536 bytes at offset 1966080
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 2031616
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D Some concurrent requests touching the same cluster =3D=3D
 blkdebug: Suspended request 'A'
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index cdc53565410d..4b0a390c437c 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -58,13 +58,13 @@ $QEMU_IO -c "write -P 0x5a 0 1048576" "$TEST_IMG" | _fi=
lter_qemu_io

 TEST_IMG=3D"$TEST_IMG_SAVE"

-_make_test_img -b "$TEST_IMG.old" $size
+_make_test_img -b "$TEST_IMG.old" -F $IMGFMT $size
 $QEMU_IO -c "write -z 0 1048576" "$TEST_IMG" | _filter_qemu_io

 echo
 echo "=3D=3D Rebasing the image =3D=3D"

-$QEMU_IMG rebase -b "$TEST_IMG.new" "$TEST_IMG"
+$QEMU_IMG rebase -b "$TEST_IMG.new" -F $IMGFMT "$TEST_IMG"
 $QEMU_IO -c "read -P 0x00 0 1048576" "$TEST_IMG" | _filter_qemu_io

 # success, all done
diff --git a/tests/qemu-iotests/050.out b/tests/qemu-iotests/050.out
index 3602d580dc05..ab3daeddca3e 100644
--- a/tests/qemu-iotests/050.out
+++ b/tests/qemu-iotests/050.out
@@ -7,7 +7,7 @@ wrote 1048576/1048576 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT.new', fmt=3DIMGFMT size=3D10485760
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485760 backing_file=
=3DTEST_DIR/t.IMGFMT.old
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485760 backing_file=
=3DTEST_DIR/t.IMGFMT.old backing_fmt=3DIMGFMT
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 034d3a325077..bee26075b207 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -70,7 +70,7 @@ device_id=3D"drive0"
 _make_test_img $size
 cp "$TEST_IMG" "$TEST_IMG.orig"
 mv "$TEST_IMG" "$TEST_IMG.base"
-_make_test_img -b "$TEST_IMG.base" $size
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size

 echo
 echo =3D=3D=3D Unknown option =3D=3D=3D
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 554c5ca90a02..de4771bcb36d 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -1,6 +1,6 @@
 QA output created by 051
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D=3D Unknown option =3D=3D=3D

diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 0ea80d35f0e2..0a261753faac 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -1,6 +1,6 @@
 QA output created by 051
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D=3D Unknown option =3D=3D=3D

diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index f73fc74457df..052456aa003f 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -54,7 +54,8 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):

     def setUp(self):
         create_image(backing_img, TestSyncModesNoneAndTop.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=3D%s' % backing_img, '-F', 'raw', tes=
t_img)
         qemu_io('-c', 'write -P0x41 0 512', test_img)
         qemu_io('-c', 'write -P0xd5 1M 32k', test_img)
         qemu_io('-c', 'write -P0xdc 32M 124k', test_img)
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 043f12904aab..2f0894e255ea 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -163,7 +163,7 @@ $QEMU_IO -c 'write 0k 64k' "$BACKING_IMG" | _filter_qem=
u_io
 # compat=3D0.10 is required in order to make the following discard actuall=
y
 # unallocate the sector rather than make it a zero sector - we want COW, a=
fter
 # all.
-_make_test_img -o 'compat=3D0.10' -b "$BACKING_IMG" 1G
+_make_test_img -o 'compat=3D0.10' -b "$BACKING_IMG" -F $IMGFMT 1G
 # Write two clusters, the second one enforces creation of an L2 table afte=
r
 # the first data cluster.
 $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qemu_=
io
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index d27692a33c0d..6b0a3b360d41 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -100,7 +100,7 @@ read 512/512 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1073741824
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 536870912
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 36b040491fef..5d3cbc5083b6 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -187,7 +187,7 @@ echo "=3D=3D=3D Testing zero expansion on backed image =
=3D=3D=3D"
 echo
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
-_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" 64M
+_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" -F $IMGFMT 64M
 $QEMU_IO -c "read -P 0x2a 0 128k" -c "write -z 0 64k" "$TEST_IMG" | _filte=
r_qemu_io
 $QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
 _check_test_img
@@ -198,7 +198,7 @@ echo "=3D=3D=3D Testing zero expansion on backed inacti=
ve clusters =3D=3D=3D"
 echo
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
-_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" 64M
+_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" -F $IMGFMT 64M
 $QEMU_IO -c "write -z 0 64k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG snapshot -c foo "$TEST_IMG"
 $QEMU_IO -c "write -P 0x42 0 128k" "$TEST_IMG" | _filter_qemu_io
@@ -214,7 +214,7 @@ echo "=3D=3D=3D Testing zero expansion on backed image =
with shared L2 table =3D=3D=3D"
 echo
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
-_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" 64M
+_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" -F $IMGFMT 64M
 $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG snapshot -c foo "$TEST_IMG"
 $QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
@@ -237,7 +237,7 @@ echo
 echo "=3D=3D=3D Testing progress report without snapshot =3D=3D=3D"
 echo
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 4G
-_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" 4G
+_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" -F $IMGFMT 4G
 $QEMU_IO -c "write -z 0  64k" \
          -c "write -z 1G 64k" \
          -c "write -z 2G 64k" \
@@ -249,7 +249,7 @@ echo
 echo "=3D=3D=3D Testing progress report with snapshot =3D=3D=3D"
 echo
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img -o "compat=3D1.1" 4G
-_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" 4G
+_make_test_img -o "compat=3D1.1" -b "$TEST_IMG.base" -F $IMGFMT 4G
 $QEMU_IO -c "write -z 0  64k" \
          -c "write -z 1G 64k" \
          -c "write -z 2G 64k" \
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 3bf37b526f8b..274d80b8ac35 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -396,7 +396,7 @@ read 131072/131072 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 0
@@ -412,7 +412,7 @@ read 65536/65536 bytes at offset 65536
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 0
@@ -431,7 +431,7 @@ read 65536/65536 bytes at offset 65536
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
@@ -455,7 +455,7 @@ read 67108864/67108864 bytes at offset 0
 =3D=3D=3D Testing progress report without snapshot =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D4294967296
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 1073741824
@@ -470,7 +470,7 @@ No errors were found on the image.
 =3D=3D=3D Testing progress report with snapshot =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D4294967296
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 1073741824
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index b997b127f025..a4da83b2d9da 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -46,7 +46,7 @@ echo
 echo "=3D=3D=3D Creating an image with a backing file and deleting that fi=
le =3D=3D=3D"
 echo
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE
-_make_test_img -b "$TEST_IMG.base" $IMG_SIZE
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $IMG_SIZE
 _rm_test_img "$TEST_IMG.base"
 # Just open the image and close it right again (this should print an error=
 message)
 $QEMU_IO -c quit "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
diff --git a/tests/qemu-iotests/069.out b/tests/qemu-iotests/069.out
index c78e8c2b7204..126b4d2d519b 100644
--- a/tests/qemu-iotests/069.out
+++ b/tests/qemu-iotests/069.out
@@ -3,6 +3,6 @@ QA output created by 069
 =3D=3D=3D Creating an image with a backing file and deleting that file =3D=
=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D131072
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072 backing_file=3D=
TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072 backing_file=3D=
TEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing file:=
 Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
 *** done
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 23a1bdf89056..1dce47870914 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -52,7 +52,7 @@ echo "=3D=3D creating backing file =3D=3D"

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size

-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 $QEMU_IO -c "write -P 0xa5 0 $size" "$TEST_IMG.base" | _filter_qemu_io

 echo
diff --git a/tests/qemu-iotests/073.out b/tests/qemu-iotests/073.out
index de5452492c70..7a718b525e68 100644
--- a/tests/qemu-iotests/073.out
+++ b/tests/qemu-iotests/073.out
@@ -2,7 +2,7 @@ QA output created by 073

 =3D=3D creating backing file =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 3286c2c6dbb7..52957fd86c2f 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -83,8 +83,10 @@ run_qemu_img create -f $IMGFMT -o cluster_size=3D4k -o h=
elp "$TEST_IMG" $size
 run_qemu_img create -f $IMGFMT -o cluster_size=3D4k -o \? "$TEST_IMG" $siz=
e

 # Looks like a help option, but is part of the backing file name
-run_qemu_img create -f $IMGFMT -u -o backing_file=3D"$TEST_IMG",,help "$TE=
ST_IMG" $size
-run_qemu_img create -f $IMGFMT -u -o backing_file=3D"$TEST_IMG",,\? "$TEST=
_IMG" $size
+run_qemu_img create -f $IMGFMT -u -o backing_file=3D"$TEST_IMG",,help \
+    -F $IMGFMT "$TEST_IMG" $size
+run_qemu_img create -f $IMGFMT -u -o backing_file=3D"$TEST_IMG",,\? \
+    -F $IMGFMT "$TEST_IMG" $size

 # Try to trick qemu-img into creating escaped commas
 run_qemu_img create -f $IMGFMT -o backing_file=3D"$TEST_IMG", -o help "$TE=
ST_IMG" $size
@@ -140,8 +142,8 @@ run_qemu_img convert -O $IMGFMT -o cluster_size=3D4k -o=
 help "$TEST_IMG" "$TEST_IM
 run_qemu_img convert -O $IMGFMT -o cluster_size=3D4k -o \? "$TEST_IMG" "$T=
EST_IMG".base

 # Looks like a help option, but is part of the backing file name
-run_qemu_img convert -O $IMGFMT -o backing_file=3D"$TEST_IMG",,help "$TEST=
_IMG" "$TEST_IMG".base
-run_qemu_img convert -O $IMGFMT -o backing_file=3D"$TEST_IMG",,\? "$TEST_I=
MG" "$TEST_IMG".base
+run_qemu_img convert -O $IMGFMT -o backing_fmt=3D$IMGFMT,backing_file=3D"$=
TEST_IMG",,help "$TEST_IMG" "$TEST_IMG".base
+run_qemu_img convert -O $IMGFMT -o backing_fmt=3D$IMGFMT,backing_file=3D"$=
TEST_IMG",,\? "$TEST_IMG" "$TEST_IMG".base

 # Try to trick qemu-img into creating escaped commas
 run_qemu_img convert -O $IMGFMT -o backing_file=3D"$TEST_IMG", -o help "$T=
EST_IMG" "$TEST_IMG".base
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 94ea990a2754..813e9b1a949f 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -226,11 +226,11 @@ Supported options:
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size

-Testing: create -f qcow2 -u -o backing_file=3DTEST_DIR/t.qcow2,,help TEST_=
DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_file=
=3DTEST_DIR/t.qcow2,,help cluster_size=3D65536 lazy_refcounts=3Doff refcoun=
t_bits=3D16
+Testing: create -f qcow2 -u -o backing_file=3DTEST_DIR/t.qcow2,,help -F qc=
ow2 TEST_DIR/t.qcow2 128M
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_file=
=3DTEST_DIR/t.qcow2,,help backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_ref=
counts=3Doff refcount_bits=3D16

-Testing: create -f qcow2 -u -o backing_file=3DTEST_DIR/t.qcow2,,? TEST_DIR=
/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_file=
=3DTEST_DIR/t.qcow2,,? cluster_size=3D65536 lazy_refcounts=3Doff refcount_b=
its=3D16
+Testing: create -f qcow2 -u -o backing_file=3DTEST_DIR/t.qcow2,,? -F qcow2=
 TEST_DIR/t.qcow2 128M
+Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_file=
=3DTEST_DIR/t.qcow2,,? backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcou=
nts=3Doff refcount_bits=3D16

 Testing: create -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2, -o help TEST_=
DIR/t.qcow2 128M
 qemu-img: Invalid option list: backing_file=3DTEST_DIR/t.qcow2,
@@ -506,10 +506,10 @@ Supported options:
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size

-Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/t.qcow2,,help TEST_DI=
R/t.qcow2 TEST_DIR/t.qcow2.base
+Testing: convert -O qcow2 -o backing_fmt=3Dqcow2,backing_file=3DTEST_DIR/t=
.qcow2,,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing f=
ile: Could not open 'TEST_DIR/t.qcow2,help': No such file or directory

-Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/t.qcow2,,? TEST_DIR/t=
.qcow2 TEST_DIR/t.qcow2.base
+Testing: convert -O qcow2 -o backing_fmt=3Dqcow2,backing_file=3DTEST_DIR/t=
.qcow2,,? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing f=
ile: Could not open 'TEST_DIR/t.qcow2,?': No such file or directory

 Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/t.qcow2, -o help TEST=
_DIR/t.qcow2 TEST_DIR/t.qcow2.base
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 46981dbb64ae..09137c70474e 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -105,7 +105,7 @@ add_snapshot_image()
 {
     base_image=3D"${TEST_DIR}/$((${1}-1))-${snapshot_virt0}"
     snapshot_file=3D"${TEST_DIR}/${1}-${snapshot_virt0}"
-    TEST_IMG=3D$snapshot_file _make_test_img -u -b "${base_image}" "$size"
+    TEST_IMG=3D$snapshot_file _make_test_img -u -b "${base_image}" -F $IMG=
FMT "$size"
     do_blockdev_add "$1" "'backing': null, " "${snapshot_file}"
 }

@@ -224,7 +224,7 @@ echo
 SNAPSHOTS=3D$((${SNAPSHOTS}+1))

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img "$size"
-_make_test_img -b "${TEST_IMG}.base" "$size"
+_make_test_img -b "${TEST_IMG}.base" -F $IMGFMT "$size"
 do_blockdev_add ${SNAPSHOTS} "" "${TEST_IMG}"
 blockdev_snapshot ${SNAPSHOTS} error

diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index fd11aae67822..b84b20bd5741 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -68,12 +68,12 @@ Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=3Dqcow2=
 size=3D134217728 backing_fil

 =3D=3D=3D Create a couple of snapshots using blockdev-snapshot =3D=3D=3D

-Formatting 'TEST_DIR/11-snapshot-v0.IMGFMT', fmt=3DIMGFMT size=3D134217728=
 backing_file=3DTEST_DIR/10-snapshot-v0.IMGFMT
+Formatting 'TEST_DIR/11-snapshot-v0.IMGFMT', fmt=3DIMGFMT size=3D134217728=
 backing_file=3DTEST_DIR/10-snapshot-v0.IMGFMT backing_fmt=3DIMGFMT
 { 'execute': 'blockdev-add', 'arguments': { 'driver': 'IMGFMT', 'node-name=
': 'snap_11', 'backing': null, 'file': { 'driver': 'file', 'filename': 'TES=
T_DIR/11-snapshot-v0.IMGFMT', 'node-name': 'file_11' } } }
 {"return": {}}
 { 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overl=
ay':'snap_11' } }
 {"return": {}}
-Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=3DIMGFMT size=3D134217728=
 backing_file=3DTEST_DIR/11-snapshot-v0.IMGFMT
+Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=3DIMGFMT size=3D134217728=
 backing_file=3DTEST_DIR/11-snapshot-v0.IMGFMT backing_fmt=3DIMGFMT
 { 'execute': 'blockdev-add', 'arguments': { 'driver': 'IMGFMT', 'node-name=
': 'snap_12', 'backing': null, 'file': { 'driver': 'file', 'filename': 'TES=
T_DIR/12-snapshot-v0.IMGFMT', 'node-name': 'file_12' } } }
 {"return": {}}
 { 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overl=
ay':'snap_12' } }
@@ -101,7 +101,7 @@ Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=3DIMGF=
MT size=3D134217728 backing_f
 =3D=3D=3D Invalid command - snapshot node has a backing image =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 { 'execute': 'blockdev-add', 'arguments': { 'driver': 'IMGFMT', 'node-name=
': 'snap_13', 'file': { 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', =
'node-name': 'file_13' } } }
 {"return": {}}
 { 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overl=
ay':'snap_13' } }
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 059ad75e28d6..66c5415abe8c 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -84,7 +84,7 @@ echo
 echo "=3D=3D=3D Testing correct handling of 'backing':null =3D=3D=3D"
 echo

-_make_test_img -b "$TEST_IMG.base" $IMG_SIZE
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $IMG_SIZE

 # This should read 42
 $QEMU_IO -c 'read -P 42 0 512' "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 20c8ce8f0ef4..15682c28862a 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -21,7 +21,7 @@ read 512/512 bytes at offset 0

 =3D=3D=3D Testing correct handling of 'backing':null =3D=3D=3D

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 512/512 bytes at offset 0
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 155ae86aa780..77a5f0f3f597 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -51,9 +51,9 @@ size_larger=3D100M

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size_smaller

-TEST_IMG=3D"$TEST_IMG.snp1" _make_test_img -b "$TEST_IMG.base" $size_large=
r
+TEST_IMG=3D"$TEST_IMG.snp1" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT =
$size_larger

-_make_test_img -b "${TEST_IMG}.snp1" $size_larger
+_make_test_img -b "${TEST_IMG}.snp1" -F $IMGFMT $size_larger

 echo
 echo "=3D=3D=3D Base image info before commit and resize =3D=3D=3D"
diff --git a/tests/qemu-iotests/095.out b/tests/qemu-iotests/095.out
index 614e5ccbbb38..e66ced58f855 100644
--- a/tests/qemu-iotests/095.out
+++ b/tests/qemu-iotests/095.out
@@ -1,7 +1,7 @@
 QA output created by 095
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D5242880
-Formatting 'TEST_DIR/t.IMGFMT.snp1', fmt=3DIMGFMT size=3D104857600 backing=
_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D104857600 backing_file=
=3DTEST_DIR/t.IMGFMT.snp1
+Formatting 'TEST_DIR/t.IMGFMT.snp1', fmt=3DIMGFMT size=3D104857600 backing=
_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D104857600 backing_file=
=3DTEST_DIR/t.IMGFMT.snp1 backing_fmt=3DIMGFMT

 =3D=3D=3D Base image info before commit and resize =3D=3D=3D
 image: TEST_DIR/t.IMGFMT.base
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 690f3d3ce1ed..d910a8b107ea 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -67,8 +67,8 @@ echo

 len=3D$((2100 * 1024 * 1024 + 512)) # larger than 2G, and not cluster alig=
ned
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $len
-TEST_IMG=3D"$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" $len
-_make_test_img -b "$TEST_IMG.itmd" $len
+TEST_IMG=3D"$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT =
$len
+_make_test_img -b "$TEST_IMG.itmd" -F $IMGFMT $len

 $QEMU_IO -c "write -P 1 0x7ffd0000 192k" "$TEST_IMG.base" | _filter_qemu_i=
o
 $QEMU_IO -c "write -P 2 0x7ffe0000 128k" "$TEST_IMG.itmd" | _filter_qemu_i=
o
diff --git a/tests/qemu-iotests/097.out b/tests/qemu-iotests/097.out
index f6705a1cc74a..3038ddab3100 100644
--- a/tests/qemu-iotests/097.out
+++ b/tests/qemu-iotests/097.out
@@ -3,8 +3,8 @@ QA output created by 097
 =3D=3D=3D Test pass 0 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -40,8 +40,8 @@ Offset          Length          File
 =3D=3D=3D Test pass 1 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -78,8 +78,8 @@ Offset          Length          File
 =3D=3D=3D Test pass 2 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -116,8 +116,8 @@ Offset          Length          File
 =3D=3D=3D Test pass 3 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index 1e29d96b3d7e..f2ccdd790980 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -52,7 +52,7 @@ echo "=3D=3D=3D $event =3D=3D=3D"
 echo

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
-_make_test_img -b "$TEST_IMG.base" 64M
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 64M

 # Some data that can be leaked when emptying the top image
 $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/098.out b/tests/qemu-iotests/098.out
index 7634d0e8b02b..14d3018ecce7 100644
--- a/tests/qemu-iotests/098.out
+++ b/tests/qemu-iotests/098.out
@@ -3,7 +3,7 @@ QA output created by 098
 =3D=3D=3D l1_update =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFM=
T: Input/output error
@@ -12,7 +12,7 @@ No errors were found on the image.
 =3D=3D=3D empty_image_prepare =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFM=
T: Input/output error
@@ -25,7 +25,7 @@ No errors were found on the image.
 =3D=3D=3D reftable_update =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFM=
T: Input/output error
@@ -39,7 +39,7 @@ No errors were found on the image.
 =3D=3D=3D refblock_alloc =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFM=
T: Input/output error
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 139c02c2cf6b..f1813d0dfb50 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -50,7 +50,7 @@ echo '=3D=3D=3D Reconstructable filename =3D=3D=3D'
 echo

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
-_make_test_img -b "$TEST_IMG_REL.base" 64M
+_make_test_img -b "$TEST_IMG_REL.base" -F $IMGFMT 64M
 # qemu should be able to reconstruct the filename, so relative backing nam=
es
 # should work
 # (We have to filter the backing file format because vmdk always
@@ -91,7 +91,7 @@ echo '=3D=3D=3D Backing name is always relative to the ba=
cked image =3D=3D=3D'
 echo

 # omit the image size; it should work anyway
-_make_test_img -b "$TEST_IMG_REL.base"
+_make_test_img -b "$TEST_IMG_REL.base" -F $IMGFMT

 echo
 echo '=3D=3D=3D Nodes without a common directory =3D=3D=3D'
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index f835553a9930..cf8f6c025d60 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -3,7 +3,7 @@ QA output created by 110
 =3D=3D=3D Reconstructable filename =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3Dt.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3Dt.IMGFMT.base backing_fmt=3DIMGFMT
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
@@ -18,7 +18,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGF=
MT.base)

 =3D=3D=3D Backing name is always relative to the backed image =3D=3D=3D

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3Dt.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3Dt.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D=3D Nodes without a common directory =3D=3D=3D

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index f7a3ae684a7c..61a0d7aeec2a 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -52,9 +52,10 @@ echo
 echo "=3D=3D=3D Check allocation status regression with -B =3D=3D=3D"
 echo

-_make_test_img -b "$TEST_IMG".base
+_make_test_img -b "$TEST_IMG".base -F $IMGFMT
 $QEMU_IO -c "write -P 0x22 0 3M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _fil=
ter_testdir
-$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG".o=
rig
+$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base \
+    -o backing_fmt=3D$IMGFMT "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IMG map "$TEST_IMG".orig | _filter_qemu_img_map


@@ -62,18 +63,22 @@ echo
 echo "=3D=3D=3D Check that zero clusters are kept in overlay =3D=3D=3D"
 echo

-_make_test_img -b "$TEST_IMG".base
+_make_test_img -b "$TEST_IMG".base -F $IMGFMT

 $QEMU_IO -c "write -P 0 0 3M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter=
_testdir
-$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG".o=
rig
+$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -o backing_fmt=3D$IMGFMT =
\
+    "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IO -c "read -P 0 0 3M" "$TEST_IMG".orig 2>&1 | _filter_qemu_io | _fi=
lter_testdir
-$QEMU_IMG convert -O $IMGFMT -c -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG=
".orig
+$QEMU_IMG convert -O $IMGFMT -c -B "$TEST_IMG".base -o backing_fmt=3D$IMGF=
MT \
+    "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IO -c "read -P 0 0 3M" "$TEST_IMG".orig 2>&1 | _filter_qemu_io | _fi=
lter_testdir

 $QEMU_IO -c "write -z 0 3M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_t=
estdir
-$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG".o=
rig
+$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -o backing_fmt=3D$IMGFMT =
\
+    "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IO -c "read -P 0 0 3M" "$TEST_IMG".orig 2>&1 | _filter_qemu_io | _fi=
lter_testdir
-$QEMU_IMG convert -O $IMGFMT -c -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG=
".orig
+$QEMU_IMG convert -O $IMGFMT -c -B "$TEST_IMG".base -o backing_fmt=3D$IMGF=
MT \
+    "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IO -c "read -P 0 0 3M" "$TEST_IMG".orig 2>&1 | _filter_qemu_io | _fi=
lter_testdir


@@ -94,11 +99,11 @@ TEST_IMG=3D"$TEST_IMG".base _make_test_img 256M
 # We do not want such a zero write, however, because we are past the
 # end of the backing file on the target as well, so we do not need to
 # write anything there.
-_make_test_img -b "$TEST_IMG".base 768M
+_make_test_img -b "$TEST_IMG".base 768M -F $IMGFMT

 # Use compat=3D0.10 as the output so there is no zero cluster support
 $QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -o compat=3D0.10 \
-    "$TEST_IMG" "$TEST_IMG".orig
+    -o backing_fmt=3D$IMGFMT "$TEST_IMG" "$TEST_IMG".orig
 # See that nothing has been allocated past 64M
 $QEMU_IMG map "$TEST_IMG".orig | _filter_qemu_img_map

@@ -110,7 +115,7 @@ $QEMU_IO -c 'write -P 0x11 255M 1M' "$TEST_IMG".base 2>=
&1 | _filter_qemu_io
 $QEMU_IO -c 'write -P 0x22 600M 1M' "$TEST_IMG" 2>&1 | _filter_qemu_io

 $QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -o compat=3D0.10 \
-    "$TEST_IMG" "$TEST_IMG".orig
+    -o backing_fmt=3D$IMGFMT "$TEST_IMG" "$TEST_IMG".orig

 $QEMU_IMG map "$TEST_IMG".orig | _filter_qemu_img_map
 $QEMU_IO -c 'read -P 0x11 255M 1M' \
@@ -199,7 +204,7 @@ $QEMU_IMG map --output=3Djson "$TEST_IMG".orig | _filte=
r_qemu_img_map
 TEST_IMG=3D"$TEST_IMG".base _make_test_img 64M
 $QEMU_IO -c "write -P 0x11 0 32M" "$TEST_IMG".base 2>&1 | _filter_qemu_io =
| _filter_testdir

-_make_test_img -b "$TEST_IMG".base 64M
+_make_test_img -b "$TEST_IMG".base 64M -F $IMGFMT
 $QEMU_IO -c "write -P 0x22 0 3M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _fil=
ter_testdir

 echo
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 1a35951a80a8..513c34ef3b9d 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -5,7 +5,7 @@ wrote 67108864/67108864 bytes at offset 0

 =3D=3D=3D Check allocation status regression with -B =3D=3D=3D

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 3145728/3145728 bytes at offset 0
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
@@ -14,7 +14,7 @@ Offset          Length          File

 =3D=3D=3D Check that zero clusters are kept in overlay =3D=3D=3D

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 3145728/3145728 bytes at offset 0
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 3145728/3145728 bytes at offset 0
@@ -31,7 +31,7 @@ read 3145728/3145728 bytes at offset 0
 =3D=3D=3D Converting to an overlay larger than its backing file =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D268435456
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D805306368 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D805306368 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 Offset          Length          File

 wrote 1048576/1048576 bytes at offset 267386880
@@ -141,7 +141,7 @@ read 63963136/63963136 bytes at offset 3145728
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
 wrote 33554432/33554432 bytes at offset 0
 32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 3145728/3145728 bytes at offset 0
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index b7fce1e59dd3..dd5a2112278d 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -61,7 +61,7 @@ BASE_IMG=3D"$TEST_DIR/image:base.$IMGFMT"
 TOP_IMG=3D"$TEST_DIR/image:top.$IMGFMT"

 TEST_IMG=3D$BASE_IMG _make_test_img 64M
-TEST_IMG=3D$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
+TEST_IMG=3D$TOP_IMG _make_test_img -b ./image:base.$IMGFMT -F $IMGFMT

 # (1) The default cluster size depends on the image format
 # (2) vmdk only supports vmdk backing files, so it always reports the
@@ -82,7 +82,7 @@ BASE_IMG=3D"base.$IMGFMT"
 TOP_IMG=3D"file:image:top.$IMGFMT"

 TEST_IMG=3D$BASE_IMG _make_test_img 64M
-TEST_IMG=3D$TOP_IMG _make_test_img -b "$BASE_IMG"
+TEST_IMG=3D$TOP_IMG _make_test_img -b "$BASE_IMG" -F $IMGFMT

 TEST_IMG=3D$TOP_IMG _img_info | grep -ve 'cluster_size' -e 'backing file f=
ormat'

diff --git a/tests/qemu-iotests/126.out b/tests/qemu-iotests/126.out
index e3c4d619162d..7d6634685eb5 100644
--- a/tests/qemu-iotests/126.out
+++ b/tests/qemu-iotests/126.out
@@ -8,14 +8,14 @@ Formatting 'file:TEST_DIR/a:b.IMGFMT', fmt=3DIMGFMT size=
=3D67108864
 =3D=3D=3D Testing relative backing filename resolution =3D=3D=3D

 Formatting 'TEST_DIR/image:base.IMGFMT', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/image:top.IMGFMT', fmt=3DIMGFMT size=3D67108864 backi=
ng_file=3D./image:base.IMGFMT
+Formatting 'TEST_DIR/image:top.IMGFMT', fmt=3DIMGFMT size=3D67108864 backi=
ng_file=3D./image:base.IMGFMT backing_fmt=3DIMGFMT
 image: TEST_DIR/image:top.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 backing file: ./image:base.IMGFMT (actual path: TEST_DIR/./image:base.IMGF=
MT)

 Formatting 'base.IMGFMT', fmt=3DIMGFMT size=3D67108864
-Formatting 'file:image:top.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3Dbase.IMGFMT
+Formatting 'file:image:top.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3Dbase.IMGFMT backing_fmt=3DIMGFMT
 image: ./image:top.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index a4fc8660381b..e2ac2f55364d 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -48,8 +48,8 @@ _require_devices virtio-scsi scsi-hd
 IMG_SIZE=3D64K

 _make_test_img $IMG_SIZE
-TEST_IMG=3D"$TEST_IMG.overlay0" _make_test_img -b "$TEST_IMG" $IMG_SIZE
-TEST_IMG=3D"$TEST_IMG.overlay1" _make_test_img -b "$TEST_IMG" $IMG_SIZE
+TEST_IMG=3D"$TEST_IMG.overlay0" _make_test_img -b "$TEST_IMG" -F $IMGFMT $=
IMG_SIZE
+TEST_IMG=3D"$TEST_IMG.overlay1" _make_test_img -b "$TEST_IMG" -F $IMGFMT $=
IMG_SIZE

 # So that we actually have something to mirror and the job does not return
 # immediately (which may be bad because then we cannot know whether the
diff --git a/tests/qemu-iotests/127.out b/tests/qemu-iotests/127.out
index 623d52bbd150..efd6cb327fe5 100644
--- a/tests/qemu-iotests/127.out
+++ b/tests/qemu-iotests/127.out
@@ -1,7 +1,7 @@
 QA output created by 127
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65536
-Formatting 'TEST_DIR/t.IMGFMT.overlay0', fmt=3DIMGFMT size=3D65536 backing=
_file=3DTEST_DIR/t.IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT.overlay1', fmt=3DIMGFMT size=3D65536 backing=
_file=3DTEST_DIR/t.IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.overlay0', fmt=3DIMGFMT size=3D65536 backing=
_file=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.overlay1', fmt=3DIMGFMT size=3D65536 backing=
_file=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
 wrote 42/42 bytes at offset 0
 42 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index b0da4a5541ab..0e13244d850e 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -29,7 +29,8 @@ class TestStopWithBlockJob(iotests.QMPTestCase):

     def setUp(self):
         iotests.qemu_img('create', '-f', iotests.imgfmt, self.base_img, "1=
G")
-        iotests.qemu_img('create', '-f', iotests.imgfmt, self.test_img, "-=
b", self.base_img)
+        iotests.qemu_img('create', '-f', iotests.imgfmt, self.test_img,
+                         "-b", self.base_img, '-F', iotests.imgfmt)
         iotests.qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x5d 1M 128M'=
, self.test_img)
         self.vm =3D iotests.VM().add_drive(self.test_img)
         self.vm.launch()
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 6f7cacc0910b..4070fd9457b2 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -40,7 +40,7 @@ _supported_fmt qcow2
 _supported_proto file

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 echo
 echo "=3D=3D=3D Check that node-name can't be changed =3D=3D=3D"
diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
index 1491ef45a984..d70c2e8041ce 100644
--- a/tests/qemu-iotests/133.out
+++ b/tests/qemu-iotests/133.out
@@ -1,6 +1,6 @@
 QA output created by 133
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D=3D Check that node-name can't be changed =3D=3D=3D

diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 7120d3142b77..1452fd24b335 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -71,7 +71,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
     def addBlockDriverStateOverlay(self, node):
         self.checkBlockDriverState(node, False)
         iotests.qemu_img('create', '-u', '-f', iotests.imgfmt,
-                         '-b', base_img, new_img, '1M')
+                         '-b', base_img, '-F', iotests.imgfmt, new_img, '1=
M')
         opts =3D {'driver': iotests.imgfmt,
                 'node-name': node,
                 'backing': None,
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 5192d256e314..21aa0b42d813 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -89,8 +89,8 @@ test_blockjob()


 TEST_IMG=3D"$TEST_DIR/b.$IMGFMT" _make_test_img 1M
-TEST_IMG=3D"$TEST_DIR/m.$IMGFMT" _make_test_img -b "$TEST_DIR/b.$IMGFMT" 1=
M
-_make_test_img -b "$TEST_DIR/m.$IMGFMT" 1M
+TEST_IMG=3D"$TEST_DIR/m.$IMGFMT" _make_test_img -b "$TEST_DIR/b.$IMGFMT" -=
F $IMGFMT 1M
+_make_test_img -b "$TEST_DIR/m.$IMGFMT" 1M -F $IMGFMT

 _launch_qemu -nodefaults

diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 263b680bdfb3..08e0aecd65f4 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -1,7 +1,7 @@
 QA output created by 141
 Formatting 'TEST_DIR/b.IMGFMT', fmt=3DIMGFMT size=3D1048576
-Formatting 'TEST_DIR/m.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/b.IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/m.IMGFMT
+Formatting 'TEST_DIR/m.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/b.IMGFMT backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/m.IMGFMT backing_fmt=3DIMGFMT
 {'execute': 'qmp_capabilities'}
 {"return": {}}

diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index daefcbaa5878..69fd10ef5103 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -67,7 +67,7 @@ size=3D128M

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
 TEST_IMG=3D"$TEST_IMG.snap" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base" $size
+_make_test_img -b "$TEST_IMG.base" $size -F $IMGFMT

 echo
 echo =3D=3D=3D Simple test for all cache modes =3D=3D=3D
diff --git a/tests/qemu-iotests/142.out b/tests/qemu-iotests/142.out
index 3667e38def8a..a92b948edd95 100644
--- a/tests/qemu-iotests/142.out
+++ b/tests/qemu-iotests/142.out
@@ -1,7 +1,7 @@
 QA output created by 142
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
 Formatting 'TEST_DIR/t.IMGFMT.snap', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D=3D Simple test for all cache modes =3D=3D=3D

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 2b1311176801..4d41f25e2ced 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -94,7 +94,7 @@ for opts1 in "" "read-only=3Don" "read-only=3Don,force-sh=
are=3Don"; do

     echo
     echo "=3D=3D Creating test image =3D=3D"
-    _make_test_img -b "${TEST_IMG}.base"
+    _make_test_img -b "${TEST_IMG}.base" -F $IMGFMT

     echo
     echo "=3D=3D Launching QEMU, opts: '$opts1' =3D=3D"
@@ -125,7 +125,7 @@ for opts1 in "" "read-only=3Don" "read-only=3Don,force-=
share=3Don"; do
         _run_cmd $QEMU_IMG amend -o "" $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG commit      $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG resize      $L "${TEST_IMG}" $size
-        _run_cmd $QEMU_IMG rebase      $L "${TEST_IMG}" -b "${TEST_IMG}.ba=
se"
+        _run_cmd $QEMU_IMG rebase      $L "${TEST_IMG}" -b "${TEST_IMG}.ba=
se" -F $IMGFMT
         _run_cmd $QEMU_IMG snapshot -l $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG convert     $L "${TEST_IMG}" "${TEST_IMG}.conve=
rt"
         _run_cmd $QEMU_IMG dd          $L if=3D"${TEST_IMG}" of=3D"${TEST_=
IMG}.convert" bs=3D512 count=3D1
@@ -135,7 +135,7 @@ for opts1 in "" "read-only=3Don" "read-only=3Don,force-=
share=3Don"; do
         # qemu-img create does not support -U
         if [ -z "$L" ]; then
             _run_cmd $QEMU_IMG create -f $IMGFMT "${TEST_IMG}" \
-                                      -b ${TEST_IMG}.base
+                                      -b ${TEST_IMG}.base -F $IMGFMT
             # Read the file format.  It used to be the case that
             # file-posix simply truncated the file, but the qcow2
             # driver then failed to format it because it was unable
@@ -168,9 +168,9 @@ done
 echo
 echo "=3D=3D Creating ${TEST_IMG}.[abc] =3D=3D" | _filter_testdir
 (
-    $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}"
-    $QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}"
-    $QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b"
+    $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}" -F $IMGFMT
+    $QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}" -F $IMGFMT
+    $QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b" -F $IMGFM=
T
 ) | _filter_img_create

 echo
@@ -219,7 +219,7 @@ _send_qemu_cmd $QEMU_HANDLE \
 _run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'

 echo "Creating overlay with qemu-img when the guest is running should be a=
llowed"
-_run_cmd $QEMU_IMG create -f $IMGFMT -b "${TEST_IMG}" "${TEST_IMG}.overlay=
"
+_run_cmd $QEMU_IMG create -f $IMGFMT -b "${TEST_IMG}" -F $IMGFMT "${TEST_I=
MG}.overlay"

 echo "=3D=3D Closing an image should unlock it =3D=3D"
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index f7464dd8d345..24fcf78d63b2 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -6,7 +6,7 @@ QEMU_PROG: -drive if=3Dnone,file=3Dnull-co://,readonly=3Dof=
f,force-share=3Don: force-sha
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D33554432

 =3D=3D Creating test image =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D Launching QEMU, opts: '' =3D=3D

@@ -68,7 +68,7 @@ _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?

-_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow=
2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?

@@ -92,10 +92,11 @@ _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?

-_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.bas=
e
+_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.bas=
e -F qcow2
 qemu-img: TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 file format: IMGFMT
+backing file format: IMGFMT

 =3D=3D Running utility commands -U =3D=3D

@@ -130,7 +131,7 @@ _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information

-_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F q=
cow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?

@@ -152,7 +153,7 @@ Round done
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D33554432

 =3D=3D Creating test image =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D Launching QEMU, opts: 'read-only=3Don' =3D=3D

@@ -199,7 +200,7 @@ _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?

-_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow=
2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?

@@ -215,10 +216,11 @@ _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?

-_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.bas=
e
+_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.bas=
e -F qcow2
 qemu-img: TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 file format: IMGFMT
+backing file format: IMGFMT

 =3D=3D Running utility commands -U =3D=3D

@@ -253,7 +255,7 @@ _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information

-_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F q=
cow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?

@@ -275,7 +277,7 @@ Round done
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D33554432

 =3D=3D Creating test image =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D Launching QEMU, opts: 'read-only=3Don,force-share=3Don' =3D=3D

@@ -309,7 +311,7 @@ _qemu_img_wrapper commit TEST_DIR/t.qcow2

 _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M

-_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow=
2

 _qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2

@@ -321,8 +323,9 @@ _qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2

 _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2

-_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.bas=
e
+_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.bas=
e -F qcow2
 file format: IMGFMT
+backing file format: IMGFMT

 =3D=3D Running utility commands -U =3D=3D

@@ -357,7 +360,7 @@ _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information

-_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F q=
cow2

 _qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2

@@ -398,9 +401,9 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 =3D=3D Two devices with the same image (read-only=3Don,force-share=3Don - =
read-only=3Don,force-share=3Don) =3D=3D

 =3D=3D Creating TEST_DIR/t.qcow2.[abc] =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.a', fmt=3DIMGFMT size=3D33554432 backing_fil=
e=3DTEST_DIR/t.IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT.b', fmt=3DIMGFMT size=3D33554432 backing_fil=
e=3DTEST_DIR/t.IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT.c', fmt=3DIMGFMT size=3D33554432 backing_fil=
e=3DTEST_DIR/t.IMGFMT.b
+Formatting 'TEST_DIR/t.IMGFMT.a', fmt=3DIMGFMT size=3D33554432 backing_fil=
e=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.b', fmt=3DIMGFMT size=3D33554432 backing_fil=
e=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.c', fmt=3DIMGFMT size=3D33554432 backing_fil=
e=3DTEST_DIR/t.IMGFMT.b backing_fmt=3DIMGFMT

 =3D=3D Two devices sharing the same file in backing chain =3D=3D

@@ -430,7 +433,7 @@ qemu-io: can't open device TEST_DIR/t.qcow2: Failed to =
get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 Creating overlay with qemu-img when the guest is running should be allowed

-_qemu_img_wrapper create -f qcow2 -b TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.ove=
rlay
+_qemu_img_wrapper create -f qcow2 -b TEST_DIR/t.qcow2 -F qcow2 TEST_DIR/t.=
qcow2.overlay
 =3D=3D Closing an image should unlock it =3D=3D
 { 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'driv=
e_del d0' } }
 {"return": ""}
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index d68f66b9e058..7f1c0d9bd981 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -50,7 +50,7 @@ echo
 echo =3D=3D backing file contains zeros =3D=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Make sure that the whole cluster is allocated even for partial write_zer=
oes
 # when the backing file contains zeros
@@ -74,7 +74,7 @@ echo
 echo =3D=3D backing file contains non-zero data before write_zeroes =3D=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Single cluster; non-zero data at the cluster start
 # ... | XX -- 00 -- | ...
@@ -97,7 +97,7 @@ echo
 echo =3D=3D backing file contains non-zero data after write_zeroes =3D=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Single cluster; non-zero data directly after request
 # ... | -- 00 XX -- | ...
@@ -120,7 +120,7 @@ echo
 echo =3D=3D write_zeroes covers non-zero data =3D=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # non-zero data at front of request
 # Backing file: -- XX -- --
@@ -160,7 +160,7 @@ echo
 echo =3D=3D spanning two clusters, non-zero before request =3D=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Two clusters; non-zero data before request:
 # 1. At cluster start:          32k: XX -- -- 00 | 00 -- -- --
@@ -190,7 +190,7 @@ echo
 echo =3D=3D spanning two clusters, non-zero after request =3D=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Two clusters; non-zero data after request:
 # 1. Directly after request:    32k: -- -- -- 00 | 00 XX -- --
@@ -220,7 +220,7 @@ echo
 echo =3D=3D spanning two clusters, partially overwriting backing file =3D=
=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Backing file: -- -- XX XX | XX XX -- --
 # Active layer: -- -- XX 00 | 00 XX -- --
@@ -239,7 +239,7 @@ echo
 echo =3D=3D spanning multiple clusters, non-zero in first cluster =3D=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Backing file: 64k: XX XX -- -- | -- -- -- -- | -- -- -- --
 # Active layer: 64k: XX XX 00 00 | 00 00 00 00 | 00 -- -- --
@@ -255,7 +255,7 @@ echo
 echo =3D=3D spanning multiple clusters, non-zero in intermediate cluster =
=3D=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Backing file: 64k: -- -- -- -- | -- XX XX -- | -- -- -- --
 # Active layer: 64k: -- -- 00 00 | 00 00 00 00 | 00 -- -- --
@@ -270,7 +270,7 @@ echo
 echo =3D=3D spanning multiple clusters, non-zero in final cluster =3D=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Backing file: 64k: -- -- -- -- | -- -- -- -- | -- -- XX XX
 # Active layer: 64k: -- -- 00 00 | 00 00 00 00 | 00 -- XX XX
@@ -286,7 +286,7 @@ echo
 echo =3D=3D spanning multiple clusters, partially overwriting backing file=
 =3D=3D

 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Backing file: 64k: -- XX XX XX | XX XX XX XX | XX XX XX --
 # Active layer: 64k: -- XX 00 00 | 00 00 00 00 | 00 XX XX --
@@ -338,7 +338,7 @@ CLUSTER_SIZE=3D2048 TEST_IMG=3D"$TEST_IMG.base" _make_t=
est_img $((size + 1024))
 # Write at the front: sector-wise, the request is:
 # backing: 128m... | -- --
 # active:  128m... | 00 -- -- --
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $size 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
@@ -346,7 +346,7 @@ $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qem=
u_img_map
 # Write at the back: sector-wise, the request is:
 # backing: 128m... | -- --
 # active:  128m... | -- -- -- 00
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
@@ -354,7 +354,7 @@ $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qem=
u_img_map
 # Write at middle: sector-wise, the request is:
 # backing: 128m... | -- --
 # active:  128m... | -- 00 00 --
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $((size + 512)) 1024" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
@@ -362,7 +362,7 @@ $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qem=
u_img_map
 # Write entire cluster: sector-wise, the request is:
 # backing: 128m... | -- --
 # active:  128m... | 00 00 00 00
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
@@ -373,7 +373,7 @@ $QEMU_IO -c "write -z $size 512" "$TEST_IMG.base" | _fi=
lter_qemu_io
 # Write at the front: sector-wise, the request is:
 # backing: 128m... | 00 00
 # active:  128m... | 00 -- -- --
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $size 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
@@ -381,7 +381,7 @@ $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qem=
u_img_map
 # Write at the back: sector-wise, the request is:
 # backing: 128m... | 00 00
 # active:  128m... | -- -- -- 00
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
@@ -389,7 +389,7 @@ $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qem=
u_img_map
 # Write at middle: sector-wise, the request is:
 # backing: 128m... | 00 00
 # active:  128m... | -- 00 00 --
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $((size + 512)) 1024" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
@@ -397,7 +397,7 @@ $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qem=
u_img_map
 # Write entire cluster: sector-wise, the request is:
 # backing: 128m... | 00 00
 # active:  128m... | 00 00 00 00
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
@@ -427,7 +427,7 @@ echo =3D=3D unaligned image tail cluster, allocation re=
quired =3D=3D
 # Backing file: 128m... | XX --
 # Active layer: 128m... | -- -- 00 --
 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((size + 10=
24))
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -P 1 $((size)) 512" "$TEST_IMG.base" | _filter_qemu_io
 $QEMU_IO -c "write -z $((size + 1024)) 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "read -P 1 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
@@ -438,7 +438,7 @@ $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qem=
u_img_map
 # Backing file: 128m: ... | -- XX
 # Active layer: 128m: ... | 00 -- -- 00
 CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((size + 10=
24))
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -P 1 $((size + 512)) 512" "$TEST_IMG.base" | _filter_qe=
mu_io
 $QEMU_IO -c "write -z $((size)) 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "read -P 0 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
index fa3673317fd8..4863e2483864 100644
--- a/tests/qemu-iotests/154.out
+++ b/tests/qemu-iotests/154.out
@@ -2,7 +2,7 @@ QA output created by 154

 =3D=3D backing file contains zeros =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 2048/2048 bytes at offset 0
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 10240
@@ -22,7 +22,7 @@ wrote 2048/2048 bytes at offset 27648

 =3D=3D backing file contains non-zero data before write_zeroes =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 1024/1024 bytes at offset 32768
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1024/1024 bytes at offset 34816
@@ -49,7 +49,7 @@ read 2048/2048 bytes at offset 67584

 =3D=3D backing file contains non-zero data after write_zeroes =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 1024/1024 bytes at offset 34816
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1024/1024 bytes at offset 33792
@@ -76,7 +76,7 @@ read 3072/3072 bytes at offset 40960

 =3D=3D write_zeroes covers non-zero data =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 1024/1024 bytes at offset 5120
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 5120
@@ -113,7 +113,7 @@ read 4096/4096 bytes at offset 28672

 =3D=3D spanning two clusters, non-zero before request =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 1024/1024 bytes at offset 32768
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 35840
@@ -155,7 +155,7 @@ read 5120/5120 bytes at offset 68608

 =3D=3D spanning two clusters, non-zero after request =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 1024/1024 bytes at offset 37888
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 35840
@@ -197,7 +197,7 @@ read 1024/1024 bytes at offset 72704

 =3D=3D spanning two clusters, partially overwriting backing file =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 4096/4096 bytes at offset 2048
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 3072
@@ -217,7 +217,7 @@ read 2048/2048 bytes at offset 6144

 =3D=3D spanning multiple clusters, non-zero in first cluster =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 2048/2048 bytes at offset 65536
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 7168/7168 bytes at offset 67584
@@ -233,7 +233,7 @@ read 10240/10240 bytes at offset 67584

 =3D=3D spanning multiple clusters, non-zero in intermediate cluster =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 2048/2048 bytes at offset 70656
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 7168/7168 bytes at offset 67584
@@ -246,7 +246,7 @@ read 12288/12288 bytes at offset 65536

 =3D=3D spanning multiple clusters, non-zero in final cluster =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 2048/2048 bytes at offset 75776
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 7168/7168 bytes at offset 67584
@@ -262,7 +262,7 @@ read 2048/2048 bytes at offset 75776

 =3D=3D spanning multiple clusters, partially overwriting backing file =3D=
=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 10240/10240 bytes at offset 66560
 10 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 7168/7168 bytes at offset 67584
@@ -305,25 +305,25 @@ wrote 2048/2048 bytes at offset 134217728
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134219776, "depth": 0, "zero": true, "data": fals=
e}]
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134218752
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": fals=
e},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": fa=
lse}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 512/512 bytes at offset 134219264
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": fals=
e},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": fa=
lse}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": fals=
e},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": fa=
lse}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
@@ -331,25 +331,25 @@ wrote 2048/2048 bytes at offset 134217728
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": fa=
lse}]
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": fals=
e},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": fa=
lse}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 512/512 bytes at offset 134219264
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": fals=
e},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": fa=
lse}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": fals=
e},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": fa=
lse}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
@@ -377,7 +377,7 @@ read 1024/1024 bytes at offset 134217728

 =3D=3D unaligned image tail cluster, allocation required =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134218752
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 134218752
@@ -389,7 +389,7 @@ read 1536/1536 bytes at offset 134218240
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": fals=
e},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": t=
rue, "offset": OFFSET}]
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134218752
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 512/512 bytes at offset 134218240
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 134217728
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index 571bce9de460..ffa229f183eb 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -60,9 +60,12 @@ class BaseClass(iotests.QMPTestCase):

     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, back0_img, '1440K')
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back0_img, back1_im=
g)
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back1_img, back2_im=
g)
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back2_img, source_i=
mg)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', back0_img,
+                 '-F', iotests.imgfmt, back1_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', back1_img,
+                 '-F', iotests.imgfmt, back2_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', back2_img,
+                 '-F', iotests.imgfmt, source_img)

         self.vm =3D iotests.VM()
         # Add the BDS via blockdev-add so it stays around after the mirror=
 block
@@ -89,7 +92,8 @@ class BaseClass(iotests.QMPTestCase):
         if self.existing:
             if self.target_backing:
                 qemu_img('create', '-f', iotests.imgfmt,
-                         '-b', self.target_backing, target_img, '1440K')
+                         '-b', self.target_backing, '-F', 'raw',
+                         target_img, '1440K')
             else:
                 qemu_img('create', '-f', iotests.imgfmt, target_img, '1440=
K')

diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 5559df63a53e..7c69a6c3fa32 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -56,7 +56,7 @@ _unsupported_imgopts data_file

 # Create source disk
 TEST_IMG=3D"$TEST_IMG.backing" _make_test_img 1M
-_make_test_img -b "$TEST_IMG.backing" 1M
+_make_test_img -b "$TEST_IMG.backing" -F $IMGFMT 1M

 $QEMU_IO -c 'write -P 1 0 256k' "$TEST_IMG.backing" | _filter_qemu_io
 $QEMU_IO -c 'write -P 2 64k 192k' "$TEST_IMG" | _filter_qemu_io
@@ -68,7 +68,7 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'

 # Create snapshot
-TEST_IMG=3D"$TEST_IMG.overlay" _make_test_img -u -b "$TEST_IMG" 1M
+TEST_IMG=3D"$TEST_IMG.overlay" _make_test_img -u -b "$TEST_IMG" -F $IMGFMT=
 1M
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'blockdev-snapshot-sync',
        'arguments': { 'device': 'source',
@@ -85,7 +85,8 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'

 # Create target image
-TEST_IMG=3D"$TEST_IMG.target.overlay" _make_test_img -u -b "$TEST_IMG.targ=
et" 1M
+TEST_IMG=3D"$TEST_IMG.target.overlay" _make_test_img -u -b "$TEST_IMG.targ=
et" \
+    -F $IMGFMT 1M

 # Mirror snapshot
 _send_qemu_cmd $QEMU_HANDLE \
@@ -111,7 +112,7 @@ _send_qemu_cmd $QEMU_HANDLE \
 # Copy source backing chain to the target before completing the job
 cp "$TEST_IMG.backing" "$TEST_IMG.target.backing"
 cp "$TEST_IMG" "$TEST_IMG.target"
-$QEMU_IMG rebase -u -b "$TEST_IMG.target.backing" "$TEST_IMG.target"
+$QEMU_IMG rebase -u -b "$TEST_IMG.target.backing" -F $IMGFMT "$TEST_IMG.ta=
rget"

 # Complete block job
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index 084be5ad7151..cce167b63fe3 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -1,20 +1,20 @@
 QA output created by 156
 Formatting 'TEST_DIR/t.IMGFMT.backing', fmt=3DIMGFMT size=3D1048576
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.backing
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.backing backing_fmt=3DIMGFMT
 wrote 262144/262144 bytes at offset 0
 256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 196608/196608 bytes at offset 65536
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
-Formatting 'TEST_DIR/t.IMGFMT.overlay', fmt=3DIMGFMT size=3D1048576 backin=
g_file=3DTEST_DIR/t.IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.overlay', fmt=3DIMGFMT size=3D1048576 backin=
g_file=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'source', =
'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'format': 'IMGFMT', 'mode': '=
existing' } }
 {"return": {}}
 { 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io source "write -P 3 128k 128k"' } }
 wrote 131072/131072 bytes at offset 131072
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
-Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=3DIMGFMT size=3D1048576=
 backing_file=3DTEST_DIR/t.IMGFMT.target
+Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=3DIMGFMT size=3D1048576=
 backing_file=3DTEST_DIR/t.IMGFMT.target backing_fmt=3DIMGFMT
 { 'execute': 'drive-mirror', 'arguments': { 'device': 'source', 'target': =
'TEST_DIR/t.IMGFMT.target.overlay', 'mode': 'existing', 'sync': 'top' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "source"}}
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index ba4db6116ac3..3175968e2b6a 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -64,7 +64,7 @@ echo "=3D=3D verify pattern =3D=3D"
 $QEMU_IO --object $SECRET -c "read -P 0xa 0 $size" --image-opts $IMGSPECBA=
SE | _filter_qemu_io | _filter_testdir

 echo "=3D=3D create overlay =3D=3D"
-_make_test_img -u --object $SECRET -o "encryption=3Don,encrypt.key-secret=
=3Dsec0" -b "$TEST_IMG_BASE" $size
+_make_test_img -u --object $SECRET -o "encryption=3Don,encrypt.key-secret=
=3Dsec0" -b "$TEST_IMG_BASE" -F $IMGFMT $size

 echo
 echo "=3D=3D writing part of a cluster =3D=3D"
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
index 6def216e5574..d999f51ec0c0 100644
--- a/tests/qemu-iotests/158.out
+++ b/tests/qemu-iotests/158.out
@@ -10,7 +10,7 @@ wrote 134217728/134217728 bytes at offset 0
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base encryption=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT encryption=3Don encrypt.key-=
secret=3Dsec0

 =3D=3D writing part of a cluster =3D=3D
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index f572a19af28c..e270976d8783 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -49,8 +49,8 @@ IMG_SIZE=3D1M

 # Create the images
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_im=
gfmt
-_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT |=
 _filter_imgfmt
+_make_test_img -b "$TEST_IMG.int" -F $IMGFMT -F $IMGFMT | _filter_imgfmt

 # First test: reopen $TEST.IMG changing the detect-zeroes option on
 # its backing file ($TEST_IMG.int).
@@ -106,8 +106,8 @@ echo "*** Commit and then change an option on the backi=
ng file"
 echo
 # Create the images again
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_im=
gfmt
-_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT| =
_filter_imgfmt
+_make_test_img -b "$TEST_IMG.int" -F $IMGFMT | _filter_imgfmt

 _launch_qemu -drive if=3Dnone,file=3D"${TEST_IMG}"
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/161.out b/tests/qemu-iotests/161.out
index aef9741ed31c..3d8d89a9da3f 100644
--- a/tests/qemu-iotests/161.out
+++ b/tests/qemu-iotests/161.out
@@ -1,7 +1,7 @@
 QA output created by 161
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
-Formatting 'TEST_DIR/t.IMGFMT.int', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.int
+Formatting 'TEST_DIR/t.IMGFMT.int', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.int backing_fmt=3DIMGFMT

 *** Change an option on the backing file

@@ -29,8 +29,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485=
76 backing_file=3DTEST_DIR/t.
 *** Commit and then change an option on the backing file

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
-Formatting 'TEST_DIR/t.IMGFMT.int', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.int
+Formatting 'TEST_DIR/t.IMGFMT.int', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.int backing_fmt=3DIMGFMT
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'block-commit', 'arguments': { 'device': 'none0', 'top': 'TES=
T_DIR/t.IMGFMT.int' } }
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 117c8b695490..2565ff12eef8 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -84,8 +84,8 @@ echo

 len=3D$((2100 * 1024 * 1024 + 512)) # larger than 2G, and not cluster alig=
ned
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $len
-TEST_IMG=3D"$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" $len
-_make_test_img -b "$TEST_IMG.itmd" $len
+TEST_IMG=3D"$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT =
$len
+_make_test_img -b "$TEST_IMG.itmd" -F $IMGFMT $len
 # Update the top image to use a feature that is incompatible with fast pat=
h
 case $reason in
     snapshot) $QEMU_IMG snapshot -c snap "$TEST_IMG" ;;
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index cc33def96b25..9d09b6045202 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -3,8 +3,8 @@ QA output created by 176
 =3D=3D=3D Test pass snapshot.0 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -43,8 +43,8 @@ ID        TAG
 =3D=3D=3D Test pass snapshot.1 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -84,8 +84,8 @@ ID        TAG
 =3D=3D=3D Test pass snapshot.2 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -125,8 +125,8 @@ ID        TAG
 =3D=3D=3D Test pass snapshot.3 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -163,8 +163,8 @@ ID        TAG
 =3D=3D=3D Test pass bitmap.0 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 QMP_VERSION
 {"return": {}}
 {"return": {}}
@@ -212,8 +212,8 @@ QMP_VERSION
 =3D=3D=3D Test pass bitmap.1 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 QMP_VERSION
 {"return": {}}
 {"return": {}}
@@ -262,8 +262,8 @@ QMP_VERSION
 =3D=3D=3D Test pass bitmap.2 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 QMP_VERSION
 {"return": {}}
 {"return": {}}
@@ -312,8 +312,8 @@ QMP_VERSION
 =3D=3D=3D Test pass bitmap.3 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=3DIMGFMT size=3D2202010112 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2202010112 backing_fil=
e=3DTEST_DIR/t.IMGFMT.itmd backing_fmt=3DIMGFMT
 QMP_VERSION
 {"return": {}}
 {"return": {}}
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 752d29f8ad50..c201a9d6c64a 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -51,7 +51,7 @@ echo "=3D=3D setting up files =3D=3D"

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
 $QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG.base" | _filter_qemu_io
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 $QEMU_IO -c "write -P 22 0 $size" "$TEST_IMG" | _filter_qemu_io

 # Limited to 64k max-transfer
diff --git a/tests/qemu-iotests/177.out b/tests/qemu-iotests/177.out
index e887542678ba..ba1e1e212e47 100644
--- a/tests/qemu-iotests/177.out
+++ b/tests/qemu-iotests/177.out
@@ -4,7 +4,7 @@ QA output created by 177
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 9372dc30ef77..11a20cb1bfa8 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -49,7 +49,7 @@ echo '=3D=3D=3D Testing write zeroes with unmap =3D=3D=3D=
'
 echo

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 # Offsets chosen at or near 2M boundaries so test works at all cluster siz=
es
 # 8k and larger (smaller clusters fail due to non-contiguous allocations)
diff --git a/tests/qemu-iotests/179.out b/tests/qemu-iotests/179.out
index 80722b22891d..1f7680002ca6 100644
--- a/tests/qemu-iotests/179.out
+++ b/tests/qemu-iotests/179.out
@@ -3,7 +3,7 @@ QA output created by 179
 =3D=3D=3D Testing write zeroes with unmap =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 2097152/2097152 bytes at offset 2097152
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 6291456
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index c9ce9d3bede3..99a900c998c2 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -65,7 +65,7 @@ echo "=3D=3D verify pattern =3D=3D"
 $QEMU_IO --object $SECRET0 -c "read -P 0xa 0 $size" --image-opts $IMGSPECB=
ASE | _filter_qemu_io | _filter_testdir

 echo "=3D=3D create overlay =3D=3D"
-_make_test_img --object $SECRET1 -o "encrypt.format=3Dluks,encrypt.key-sec=
ret=3Dsec1,encrypt.iter-time=3D10" -u -b "$TEST_IMG_BASE" $size
+_make_test_img --object $SECRET1 -o "encrypt.format=3Dluks,encrypt.key-sec=
ret=3Dsec1,encrypt.iter-time=3D10" -u -b "$TEST_IMG_BASE" -F $IMGFMT $size

 echo
 echo "=3D=3D writing part of a cluster =3D=3D"
diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
index a0b7c9c24c24..035068764f73 100644
--- a/tests/qemu-iotests/189.out
+++ b/tests/qemu-iotests/189.out
@@ -10,7 +10,7 @@ wrote 16777216/16777216 bytes at offset 0
 read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base encrypt.format=3Dluks encrypt.key-secret=3Dsec1 e=
ncrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT encrypt.format=3Dluks encryp=
t.key-secret=3Dsec1 encrypt.iter-time=3D10

 =3D=3D writing part of a cluster =3D=3D
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index b05db6814157..d17462e1e42b 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -54,8 +54,8 @@ echo

 TEST_IMG=3D"${TEST_IMG}.base" _make_test_img $size
 TEST_IMG=3D"${TEST_IMG}.mid" _make_test_img -o "backing_fmt=3D$IMGFMT" -b =
"${TEST_IMG}.base"
-_make_test_img -b "${TEST_IMG}.mid"
-TEST_IMG=3D"${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
+_make_test_img -b "${TEST_IMG}.mid" -F $IMGFMT
+TEST_IMG=3D"${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid" -F $IMGF=
MT

 $QEMU_IO -c 'write -P 0x55 1M 64k' "${TEST_IMG}.mid" | _filter_qemu_io

@@ -102,10 +102,10 @@ echo =3D=3D=3D Preparing and starting VM with -drive =
=3D=3D=3D
 echo

 TEST_IMG=3D"${TEST_IMG}.base" _make_test_img $size
-TEST_IMG=3D"${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
-_make_test_img -b "${TEST_IMG}.mid"
-TEST_IMG=3D"${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
-TEST_IMG=3D"${TEST_IMG}.ovl3" _make_test_img -b "${TEST_IMG}.ovl2"
+TEST_IMG=3D"${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base" -F $IMGF=
MT
+_make_test_img -b "${TEST_IMG}.mid" -F $IMGFMT
+TEST_IMG=3D"${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid" -F $IMGF=
MT
+TEST_IMG=3D"${TEST_IMG}.ovl3" _make_test_img -b "${TEST_IMG}.ovl2" -F $IMG=
FMT

 $QEMU_IO -c 'write -P 0x55 1M 64k' "${TEST_IMG}.mid" | _filter_qemu_io

diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 34cec7b9ecf3..11aaf3b691fd 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -4,8 +4,8 @@ QA output created by 191

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
 Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid
-Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=3DIMGFMT size=3D67108864 backing_=
file=3DTEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=3DIMGFMT size=3D67108864 backing_=
file=3DTEST_DIR/t.IMGFMT.mid backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 1048576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -413,10 +413,10 @@ backing file format: IMGFMT
 =3D=3D=3D Preparing and starting VM with -drive =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid
-Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=3DIMGFMT size=3D67108864 backing_=
file=3DTEST_DIR/t.IMGFMT.mid
-Formatting 'TEST_DIR/t.IMGFMT.ovl3', fmt=3DIMGFMT size=3D67108864 backing_=
file=3DTEST_DIR/t.IMGFMT.ovl2
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=3DIMGFMT size=3D67108864 backing_=
file=3DTEST_DIR/t.IMGFMT.mid backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.ovl3', fmt=3DIMGFMT size=3D67108864 backing_=
file=3DTEST_DIR/t.IMGFMT.ovl2 backing_fmt=3DIMGFMT
 wrote 65536/65536 bytes at offset 1048576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index 48984b7ac1ed..2351d55fe1f1 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -56,8 +56,8 @@ run_qemu()

 size=3D64M
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
-TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
-_make_test_img -b "$TEST_IMG.mid"
+TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
+_make_test_img -b "$TEST_IMG.mid" -F $IMGFMT

 echo
 echo "Change backing file of mid (opened read-only)"
@@ -75,7 +75,7 @@ echo
 echo "Change backing file of top (opened writable)"
 echo

-TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
+TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 run_qemu -drive if=3Dnone,file=3D"$TEST_IMG",node-name=3Dtop <<EOF
 {"execute":"qmp_capabilities"}
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
index e6df0d6781ba..ec84df5012a3 100644
--- a/tests/qemu-iotests/195.out
+++ b/tests/qemu-iotests/195.out
@@ -1,7 +1,7 @@
 QA output created by 195
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid backing_fmt=3DIMGFMT

 Change backing file of mid (opened read-only)

@@ -42,7 +42,7 @@ backing file format: IMGFMT

 Change backing file of top (opened writable)

-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 Testing: -drive if=3Dnone,file=3DTEST_DIR/t.IMGFMT,node-name=3Dtop
 {
     QMP_VERSION
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index fb0d5a29d357..33853df1c8bd 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -62,7 +62,7 @@ echo "=3D=3D writing whole image base =3D=3D"
 $QEMU_IO --object $SECRET0 -c "write -P 0xa 0 $size" --image-opts $IMGSPEC=
BASE | _filter_qemu_io | _filter_testdir

 echo "=3D=3D create overlay =3D=3D"
-_make_test_img --object $SECRET1 -o "encrypt.format=3Dluks,encrypt.key-sec=
ret=3Dsec1,encrypt.iter-time=3D10" -u -b "$TEST_IMG_BASE" $size
+_make_test_img --object $SECRET1 -o "encrypt.format=3Dluks,encrypt.key-sec=
ret=3Dsec1,encrypt.iter-time=3D10" -u -b "$TEST_IMG_BASE" -F $IMGFMT $size

 echo
 echo "=3D=3D writing whole image layer =3D=3D"
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 831ce3a289d3..8bc39dd0d5ee 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -6,7 +6,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16=
777216 encrypt.format=3Dluk
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base encrypt.format=3Dluks encrypt.key-secret=3Dsec1 e=
ncrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT encrypt.format=3Dluks encryp=
t.key-secret=3Dsec1 encrypt.iter-time=3D10

 =3D=3D writing whole image layer =3D=3D
 wrote 16777216/16777216 bytes at offset 0
@@ -78,6 +78,7 @@ image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 16 MiB (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
 Format specific information:
     encrypt:
         ivgen alg: plain64
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index abb73dc381c9..6770fa9b9636 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -52,7 +52,7 @@ echo "=3D=3D setting up files =3D=3D"

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
 $QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG.base" | _filter_qemu_io
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 $QEMU_IO -c "write -P 22 0 110M" "$TEST_IMG" | _filter_qemu_io

 # Limited to 64k max-transfer
diff --git a/tests/qemu-iotests/204.out b/tests/qemu-iotests/204.out
index f3a10fbe9035..457f72df8f88 100644
--- a/tests/qemu-iotests/204.out
+++ b/tests/qemu-iotests/204.out
@@ -4,7 +4,7 @@ QA output created by 204
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 115343360/115343360 bytes at offset 0
 110 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
index 372f042d3ebf..088b318a3755 100755
--- a/tests/qemu-iotests/216
+++ b/tests/qemu-iotests/216
@@ -53,7 +53,7 @@ with iotests.FilePath('base.img') as base_img_path, \
     assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M') =
=3D=3D 0
     assert qemu_io_silent(base_img_path, '-c', 'write -P 1 0M 1M') =3D=3D =
0
     assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
-                    top_img_path) =3D=3D 0
+                    '-F', iotests.imgfmt, top_img_path) =3D=3D 0
     assert qemu_io_silent(top_img_path,  '-c', 'write -P 2 1M 1M') =3D=3D =
0

     log('Done')
diff --git a/tests/qemu-iotests/224 b/tests/qemu-iotests/224
index e91fb26fd8eb..94e412a680df 100755
--- a/tests/qemu-iotests/224
+++ b/tests/qemu-iotests/224
@@ -49,9 +49,9 @@ for filter_node_name in False, True:
         assert qemu_img('create', '-f', iotests.imgfmt,
                         base_img_path, '64M') =3D=3D 0
         assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_pat=
h,
-                        mid_img_path) =3D=3D 0
+                        '-F', iotests.imgfmt, mid_img_path) =3D=3D 0
         assert qemu_img('create', '-f', iotests.imgfmt, '-b', mid_img_path=
,
-                        top_img_path) =3D=3D 0
+                        '-F', iotests.imgfmt, top_img_path) =3D=3D 0

         # Something to commit
         assert qemu_io_silent(mid_img_path, '-c', 'write -P 1 0 1M') =3D=
=3D 0
diff --git a/tests/qemu-iotests/225 b/tests/qemu-iotests/225
index c9a334c7e998..0186ec815660 100755
--- a/tests/qemu-iotests/225
+++ b/tests/qemu-iotests/225
@@ -48,7 +48,7 @@ _unsupported_imgopts "subformat=3DmonolithicFlat" \

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 1M
 TEST_IMG=3D"$TEST_IMG.not_base" _make_test_img 1M
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT

 make_opts()
 {
diff --git a/tests/qemu-iotests/225.out b/tests/qemu-iotests/225.out
index 4dc8ee282fad..0998ae094c2b 100644
--- a/tests/qemu-iotests/225.out
+++ b/tests/qemu-iotests/225.out
@@ -1,7 +1,7 @@
 QA output created by 225
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
 Formatting 'TEST_DIR/t.IMGFMT.not_base', fmt=3DIMGFMT size=3D1048576
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT

 =3D=3D=3D Testing fitting VMDK backing image =3D=3D=3D

diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index 64bc82ee2346..98e92f750249 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -54,7 +54,8 @@ with iotests.FilePath('base.img') as base_img_path, \
     assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M') =
=3D=3D 0
     # Choose a funny way to describe the backing filename
     assert qemu_img('create', '-f', iotests.imgfmt, '-b',
-                    'file:' + base_img_path, top_img_path) =3D=3D 0
+                    'file:' + base_img_path, '-F', iotests.imgfmt,
+                    top_img_path) =3D=3D 0

     vm.launch()

@@ -169,7 +170,7 @@ with iotests.FilePath('base.img') as base_img_path, \
     # filename unless the backing file is opened implicitly with the
     # overlay)
     assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
-                    top_img_path) =3D=3D 0
+                    '-F', iotests.imgfmt, top_img_path) =3D=3D 0

     # You can only reliably override backing options by using a node
     # reference (or by specifying file.filename, but, well...)
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 1001275a4451..a3badee77043 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -44,7 +44,8 @@ class TestBlockdevReopen(iotests.QMPTestCase):

     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, hd_path[0], '3M')
-        qemu_img('create', '-f', iotests.imgfmt, '-b', hd_path[0], hd_path=
[1])
+        qemu_img('create', '-f', iotests.imgfmt, '-b', hd_path[0],
+                 '-F', iotests.imgfmt, hd_path[1])
         qemu_img('create', '-f', iotests.imgfmt, hd_path[2], '3M')
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xa0  0 1M', hd_path=
[0])
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xa1 1M 1M', hd_path=
[1])
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index 2b99c9789ed2..68f13ed32896 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -49,8 +49,8 @@ IMG_SIZE=3D1M

 # Create the images: base <- int <- active
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_im=
gfmt
-_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT |=
 _filter_imgfmt
+_make_test_img -b "$TEST_IMG.int" -F $IMGFMT | _filter_imgfmt

 # Launch QEMU with these two drives:
 # none0: base (read-only)
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
index 51307ed0f795..85acda4635b3 100644
--- a/tests/qemu-iotests/249.out
+++ b/tests/qemu-iotests/249.out
@@ -1,7 +1,7 @@
 QA output created by 249
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
-Formatting 'TEST_DIR/t.IMGFMT.int', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.int
+Formatting 'TEST_DIR/t.IMGFMT.int', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.int backing_fmt=3DIMGFMT
 { 'execute': 'qmp_capabilities' }
 {"return": {}}

diff --git a/tests/qemu-iotests/252 b/tests/qemu-iotests/252
index 83280c1715dc..6662f4c9dec7 100755
--- a/tests/qemu-iotests/252
+++ b/tests/qemu-iotests/252
@@ -101,7 +101,7 @@ $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qem=
u_img_map

 echo

-$QEMU_IMG rebase -b "$TEST_IMG.base_new" "$TEST_IMG"
+$QEMU_IMG rebase -b "$TEST_IMG.base_new" -F $IMGFMT "$TEST_IMG"

 # Verify the data is correct
 $QEMU_IO "$TEST_IMG" \
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 004a433b8be2..e1e60772195e 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -238,7 +238,8 @@ def compare_images(image, reference, baseimg=3DNone, ex=
pected_match=3DTrue):
     """
     expected_ret =3D 0 if expected_match else 1
     if baseimg:
-        assert qemu_img("rebase", "-u", "-b", baseimg, image) =3D=3D 0
+        assert qemu_img("rebase", "-u", "-b", baseimg, '-F', iotests.imgfm=
t,
+                        image) =3D=3D 0
     ret =3D qemu_img("compare", image, reference)
     log('qemu_img compare "{:s}" "{:s}" =3D=3D> {:s}, {:s}'.format(
         image, reference,
diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index 3146273eef33..e44be49c771d 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -73,7 +73,7 @@ size=3D128M
 run_test()
 {
     if [ -n "$BACKING_FILE" ]; then
-        _make_test_img -b "$BACKING_FILE" $size
+        _make_test_img -b "$BACKING_FILE" -F $IMGFMT $size
     else
         _make_test_img $size
     fi
@@ -149,7 +149,7 @@ echo
 echo "=3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=3D"
 echo

-_make_test_img -b "$TEST_IMG.base" $size
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
 cat <<EOF |
 nbd_server_start unix:$SOCK_DIR/nbd
 nbd_server_add -w backing-fmt
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 8dddb4baa443..d6d80c099f94 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -128,7 +128,7 @@ ID        TAG                 VM SIZE                DA=
TE       VM CLOCK
 =3D=3D=3D -blockdev with a backing file =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT.base,node-na=
me=3Dbacking-file -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node=
-name=3Dfile -blockdev driver=3DIMGFMT,file=3Dfile,backing=3Dbacking-file,n=
ode-name=3Dfmt
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
@@ -139,7 +139,7 @@ ID        TAG                 VM SIZE                DA=
TE       VM CLOCK
 (qemu) loadvm snap0
 (qemu) quit

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT.base,node-na=
me=3Dbacking-file -blockdev driver=3DIMGFMT,file=3Dbacking-file,node-name=
=3Dbacking-fmt -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-na=
me=3Dfile -blockdev driver=3DIMGFMT,file=3Dfile,backing=3Dbacking-fmt,node-=
name=3Dfmt
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
@@ -158,7 +158,7 @@ Internal snapshots on backing file:

 =3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=3D

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT.base,node-na=
me=3Dbacking-file -blockdev driver=3DIMGFMT,file=3Dbacking-file,node-name=
=3Dbacking-fmt -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-na=
me=3Dfile -blockdev driver=3DIMGFMT,file=3Dfile,backing=3Dbacking-fmt,node-=
name=3Dfmt
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) nbd_server_start unix:SOCK_DIR/nbd
diff --git a/tests/qemu-iotests/270 b/tests/qemu-iotests/270
index b9a12b908c3e..00339c0f7833 100755
--- a/tests/qemu-iotests/270
+++ b/tests/qemu-iotests/270
@@ -53,7 +53,7 @@ $QEMU_IO -c 'write 0 512' "$TEST_IMG.base" | _filter_qemu=
_io
 # We need a large cluster size, see below for why (above the $QEMU_IO
 # invocation)
 _make_test_img -o cluster_size=3D2M,data_file=3D"$TEST_IMG.orig" \
-    -b "$TEST_IMG.base" 4G
+    -b "$TEST_IMG.base" -F $IMGFMT 4G

 # We want a null-co as the data file, because it allows us to quickly
 # "write" 2G of data without using any space.
diff --git a/tests/qemu-iotests/270.out b/tests/qemu-iotests/270.out
index c7be1110142f..6dc3b23d5bfa 100644
--- a/tests/qemu-iotests/270.out
+++ b/tests/qemu-iotests/270.out
@@ -2,7 +2,7 @@ QA output created by 270
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D4294967296
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base data_file=3DTEST_DIR/t.IMGFMT.orig
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT data_file=3DTEST_DIR/t.IMGF=
MT.orig
 wrote 2147483136/2147483136 bytes at offset 768
 2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
diff --git a/tests/qemu-iotests/273 b/tests/qemu-iotests/273
index 00ff79bcf8f8..41ffbf39c4ef 100755
--- a/tests/qemu-iotests/273
+++ b/tests/qemu-iotests/273
@@ -56,8 +56,8 @@ run_qemu()
 }

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
-TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
-_make_test_img -b "$TEST_IMG.mid"
+TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
+_make_test_img -b "$TEST_IMG.mid" -F $IMGFMT

 run_qemu \
     -blockdev file,node-name=3Dbase,filename=3D"$TEST_IMG.base" \
diff --git a/tests/qemu-iotests/273.out b/tests/qemu-iotests/273.out
index 684b8d6f777e..87d475850387 100644
--- a/tests/qemu-iotests/273.out
+++ b/tests/qemu-iotests/273.out
@@ -1,7 +1,7 @@
 QA output created by 273
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid backing_fmt=3DIMGFMT
 Testing: -blockdev file,node-name=3Dbase,filename=3DTEST_DIR/t.IMGFMT.base=
 -blockdev file,node-name=3Dmidf,filename=3DTEST_DIR/t.IMGFMT.mid -blockdev=
 {"driver":"IMGFMT","node-name":"mid","file":"midf","backing":null} -blockd=
ev file,node-name=3Dtopf,filename=3DTEST_DIR/t.IMGFMT -blockdev {"driver":"=
IMGFMT","file":"topf","node-name":"top","backing":null}
 {
     QMP_VERSION
diff --git a/tests/qemu-iotests/279 b/tests/qemu-iotests/279
index 30d29b1cb2aa..5272c8fcfe0d 100755
--- a/tests/qemu-iotests/279
+++ b/tests/qemu-iotests/279
@@ -42,8 +42,8 @@ _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \

 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
-TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
-_make_test_img -b "$TEST_IMG.mid"
+TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
+_make_test_img -b "$TEST_IMG.mid" -F $IMGFMT

 echo
 echo '=3D=3D qemu-img info --backing-chain =3D=3D'
diff --git a/tests/qemu-iotests/279.out b/tests/qemu-iotests/279.out
index f4dc6c69cbb3..adb2e47a1a9c 100644
--- a/tests/qemu-iotests/279.out
+++ b/tests/qemu-iotests/279.out
@@ -1,7 +1,7 @@
 QA output created by 279
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid backing_fmt=3DIMGFMT

 =3D=3D qemu-img info --backing-chain =3D=3D
 image: TEST_DIR/t.IMGFMT
--=20
2.25.1


