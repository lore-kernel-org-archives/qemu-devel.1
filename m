Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6C1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416BD20672
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHAgPN6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416BD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsr0O-0000kW-GF
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZl-0008Ch-SS
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZf-0004EC-T1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594139763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKBEkMWJRVHrJFd804GRBsvFmzGWkyOHJQWpVK740qA=;
 b=cHAgPN6b8FQYM2NFdZmSuxvhd4JADVuAGmq8RuQf7cHuODbWj0Q9bQ6O7Oa5Dd/kpDEyNM
 H8H/OWReMTbg/Sr4Twl/pyxOLY1I0sLzzvbDCr4R90cTjIcxO5tHiI68/OFq7xTk+ea28L
 eg/VuhBgNQfBjBeRyIA64qGlVe1lKm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-mOTCHVlCOziYKANr6Jd1lw-1; Tue, 07 Jul 2020 12:35:58 -0400
X-MC-Unique: mOTCHVlCOziYKANr6Jd1lw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE573102C7F5;
 Tue,  7 Jul 2020 16:35:54 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-113.ams2.redhat.com
 [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 358E777892;
 Tue,  7 Jul 2020 16:35:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/12] iotests: Specify explicit backing format where sensible
Date: Tue,  7 Jul 2020 18:35:02 +0200
Message-Id: <20200707163504.194740-11-kwolf@redhat.com>
In-Reply-To: <20200707163504.194740-1-kwolf@redhat.com>
References: <20200707163504.194740-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

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
- while all of those accept -o backing_file=...,backing_fmt=..., the
shortcuts are different: create and rebase have -b and -F, while
convert has -B but no -F.  (amend has no shortcuts, but the previous
patch just deprecated the use of amend to change backing chains).

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200706203954.341758-9-eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
 tests/qemu-iotests/274        | 12 ++++-----
 tests/qemu-iotests/274.out    | 29 +++++++++++----------
 tests/qemu-iotests/279        |  4 +--
 tests/qemu-iotests/279.out    |  4 +--
 tests/qemu-iotests/290        |  2 +-
 tests/qemu-iotests/290.out    |  4 +--
 119 files changed, 435 insertions(+), 358 deletions(-)

diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 0a4b854e65..585512bb29 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -66,7 +66,7 @@ echo "Creating test image with backing file"
 echo
 
 TEST_IMG=$TEST_IMG_SAVE
-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G
 
 echo "Filling test image"
 echo
diff --git a/tests/qemu-iotests/017.out b/tests/qemu-iotests/017.out
index 8fc9241942..f439d3ece3 100644
--- a/tests/qemu-iotests/017.out
+++ b/tests/qemu-iotests/017.out
@@ -269,7 +269,7 @@ wrote 65536/65536 bytes at offset 4295032832
 No errors were found on the image.
 Creating test image with backing file
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Filling test image
 
 === IO: pattern 1
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index c69ce09209..191b461a4d 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -66,7 +66,7 @@ echo "Creating test image with backing file"
 echo
 
 TEST_IMG="$TEST_IMG_SAVE.orig"
-_make_test_img -b "$TEST_IMG_SAVE.base" 6G
+_make_test_img -b "$TEST_IMG_SAVE.base" -F $IMGFMT 6G
 
 echo "Filling test image"
 echo
diff --git a/tests/qemu-iotests/018.out b/tests/qemu-iotests/018.out
index 5df966727f..0ab664ca4b 100644
--- a/tests/qemu-iotests/018.out
+++ b/tests/qemu-iotests/018.out
@@ -269,7 +269,7 @@ wrote 65536/65536 bytes at offset 4295032832
 No errors were found on the image.
 Creating test image with backing file
 
-Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Filling test image
 
 === IO: pattern 1
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index 813a84acac..d3c11256dc 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -74,7 +74,7 @@ echo "Creating test image with backing file"
 echo
 
 TEST_IMG="$TEST_IMG_SAVE.orig"
-_make_test_img -b "$TEST_IMG_SAVE.base" 6G
+_make_test_img -b "$TEST_IMG_SAVE.base" -F $IMGFMT 6G
 
 echo "Filling test image"
 echo
@@ -98,7 +98,8 @@ for backing_option in "-B " "-o backing_file="; do
     echo
     echo Testing conversion with $backing_option"$TEST_IMG.base" | _filter_testdir | _filter_imgfmt
     echo
-    $QEMU_IMG convert -f $IMGFMT -O $IMGFMT $backing_option"$TEST_IMG.base" "$TEST_IMG.orig" "$TEST_IMG"
+    $QEMU_IMG convert -f $IMGFMT -O $IMGFMT $backing_option"$TEST_IMG.base" \
+        -o backing_fmt=$IMGFMT "$TEST_IMG.orig" "$TEST_IMG"
 
     echo "Checking if backing clusters are allocated when they shouldn't"
     echo
diff --git a/tests/qemu-iotests/019.out b/tests/qemu-iotests/019.out
index 17a7c036b9..0fa73bd69a 100644
--- a/tests/qemu-iotests/019.out
+++ b/tests/qemu-iotests/019.out
@@ -269,7 +269,7 @@ wrote 65536/65536 bytes at offset 4296015872
 No errors were found on the image.
 Creating test image with backing file
 
-Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Filling test image
 
 === IO: pattern 43
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 20f8f185d0..f90f133f12 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -70,7 +70,7 @@ echo "Creating test image with backing file"
 echo
 
 TEST_IMG="$TEST_IMG_SAVE"
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
index 4b722b2dd0..8c0bf238b2 100644
--- a/tests/qemu-iotests/020.out
+++ b/tests/qemu-iotests/020.out
@@ -269,7 +269,7 @@ wrote 65536/65536 bytes at offset 4295032832
 No errors were found on the image.
 Creating test image with backing file
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Filling test image
 
 === IO: pattern 1
@@ -1090,7 +1090,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=json:{'driv
                              'image': {
                                  'driver': 'file',,
                                  'filename': 'TEST_DIR/t.IMGFMT.base'
-                             }}}
+                             }}} backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Block job failed: No space left on device
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index e2e766241e..3c5d57310e 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -83,7 +83,7 @@ TEST_IMG="$TEST_IMG_SAVE"
 echo "Creating COW image"
 echo
 
-_make_test_img -b "$TEST_IMG.base_old" 1G
+_make_test_img -b "$TEST_IMG.base_old" -F $IMGFMT 1G
 io_pattern writev 0 $((4 * CLUSTER_SIZE)) 0 1 0x33
 io_pattern writev $((8 * CLUSTER_SIZE)) $((4 * CLUSTER_SIZE)) 0 1 0x33
 
@@ -109,7 +109,7 @@ io_pattern readv $((15 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x00
 echo
 echo Rebase and test again
 echo
-$QEMU_IMG rebase -b "$TEST_IMG.base_new" "$TEST_IMG"
+$QEMU_IMG rebase -b "$TEST_IMG.base_new" -F $IMGFMT "$TEST_IMG"
 io_pattern readv $((0 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x33
 io_pattern readv $((1 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x33
 io_pattern readv $((2 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x33
@@ -159,7 +159,7 @@ OVERLAY="$TEST_DIR/$OVERLAY_WREL"
 
 TEST_IMG=$BASE_OLD _make_test_img 1M
 TEST_IMG=$BASE_NEW _make_test_img 1M
-TEST_IMG=$OVERLAY _make_test_img -b "$BASE_OLD_OREL" 1M
+TEST_IMG=$OVERLAY _make_test_img -b "$BASE_OLD_OREL" -F $IMGFMT 1M
 
 echo
 
@@ -176,7 +176,7 @@ $QEMU_IO "$BASE_NEW" \
 echo
 
 pushd "$TEST_DIR" >/dev/null
-$QEMU_IMG rebase -f "$IMGFMT" -b "$BASE_NEW_OREL" "$OVERLAY_WREL"
+$QEMU_IMG rebase -f "$IMGFMT" -b "$BASE_NEW_OREL" -F $IMGFMT "$OVERLAY_WREL"
 popd >/dev/null
 
 # Verify the backing path is correct
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 024dc786b3..f4fd77fd5b 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -33,7 +33,7 @@ wrote 131072/131072 bytes at offset 786432
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Creating COW image
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=TEST_DIR/t.IMGFMT.base_old
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=TEST_DIR/t.IMGFMT.base_old backing_fmt=IMGFMT
 === IO: pattern 0x33
 wrote 262144/262144 bytes at offset 0
 256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -146,7 +146,7 @@ read 65536/65536 bytes at offset 983040
 
 Formatting 'TEST_DIR/subdir/t.IMGFMT.base_old', fmt=IMGFMT size=1048576
 Formatting 'TEST_DIR/subdir/t.IMGFMT.base_new', fmt=IMGFMT size=1048576
-Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.base_old
+Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.base_old backing_fmt=IMGFMT
 
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -158,6 +158,7 @@ wrote 65536/65536 bytes at offset 196608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 backing file: t.IMGFMT.base_new (actual path: TEST_DIR/subdir/t.IMGFMT.base_new)
+backing file format: IMGFMT
 
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 797dae5350..5d043cef92 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -76,7 +76,7 @@ echo "Creating test image with backing file"
 echo
 
 TEST_IMG="$TEST_IMG_SAVE"
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
index 37aed84436..12f82c6a6c 100644
--- a/tests/qemu-iotests/028.out
+++ b/tests/qemu-iotests/028.out
@@ -70,7 +70,7 @@ wrote 512/512 bytes at offset 3221225984
 No errors were found on the image.
 Creating test image with backing file
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294968832 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294968832 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Filling test image
 
 === IO: pattern 196
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 1cdd7e2999..256b2bfbc6 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -32,8 +32,12 @@ class TestSingleDrive(iotests.QMPTestCase):
 
     def setUp(self):
         iotests.create_image(backing_img, TestSingleDrive.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img,
+                 '-F', 'raw', mid_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % mid_img,
+                 '-F', iotests.imgfmt, test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 512', backing_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 524288 512', mid_img)
         self.vm = iotests.VM().add_drive("blkdebug::" + test_img,
@@ -199,7 +203,8 @@ class TestParallelOps(iotests.QMPTestCase):
         iotests.create_image(self.imgs[0], self.image_len)
         for i in range(1, self.num_imgs):
             qemu_img('create', '-f', iotests.imgfmt,
-                     '-o', 'backing_file=%s' % self.imgs[i-1], self.imgs[i])
+                     '-o', 'backing_file=%s' % self.imgs[i-1],
+                     '-F', 'raw' if i == 1 else iotests.imgfmt, self.imgs[i])
 
         # Put data into the images we are copying data from
         odd_img_indexes = [x for x in reversed(range(self.num_imgs)) if x % 2 == 1]
@@ -544,7 +549,8 @@ class TestQuorum(iotests.QMPTestCase):
             qemu_io('-f', iotests.imgfmt,
                     '-c', 'write -P 0x55 0 1024', backing_img)
             qemu_img('create', '-f', iotests.imgfmt,
-                     '-o', 'backing_file=%s' % backing_img, child_img)
+                     '-o', 'backing_file=%s' % backing_img,
+                     '-F', iotests.imgfmt, child_img)
             opts.append("children.%d.file.filename=%s" % (i, child_img))
             opts.append("children.%d.node-name=node%d" % (i, i))
 
@@ -585,7 +591,9 @@ class TestSmallerBackingFile(iotests.QMPTestCase):
 
     def setUp(self):
         iotests.create_image(backing_img, self.backing_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img, str(self.image_len))
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img,
+                 '-F', 'raw', test_img, str(self.image_len))
         self.vm = iotests.VM().add_drive(test_img)
         self.vm.launch()
 
@@ -848,7 +856,9 @@ class TestStreamStop(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', backing_img, str(TestStreamStop.image_len))
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 32M', backing_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img,
+                 '-F', 'raw', test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 32M 32M', test_img)
         self.vm = iotests.VM().add_drive("blkdebug::" + test_img)
         self.vm.launch()
@@ -879,7 +889,9 @@ class TestSetSpeed(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', backing_img, str(TestSetSpeed.image_len))
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 32M', backing_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img,
+                 '-F', 'raw', test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 32M 32M', test_img)
         self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
         self.vm.launch()
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index da4cea1571..ac2d687c71 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -58,7 +58,7 @@ $QEMU_IO -c "write -P 0x55 0 1M" "$TEST_IMG" | _filter_qemu_io
 
 TEST_IMG="$TEST_IMG_SAVE"
 
-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G
 
 echo
 echo "== zero write with backing file =="
diff --git a/tests/qemu-iotests/034.out b/tests/qemu-iotests/034.out
index 0764ead8b9..478205ad25 100644
--- a/tests/qemu-iotests/034.out
+++ b/tests/qemu-iotests/034.out
@@ -4,7 +4,7 @@ QA output created by 034
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 == zero write with backing file ==
 wrote 196608/196608 bytes at offset 65536
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index e6517acbd4..e1187ac24a 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -74,7 +74,7 @@ backing_io 0 256 write | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
 
 TEST_IMG="$TEST_IMG_SAVE"
 
-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G
 
 echo
 echo "== COW in a single cluster =="
diff --git a/tests/qemu-iotests/037.out b/tests/qemu-iotests/037.out
index cd6710c901..30ef989b64 100644
--- a/tests/qemu-iotests/037.out
+++ b/tests/qemu-iotests/037.out
@@ -514,7 +514,7 @@ wrote 512/512 bytes at offset 130048
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 130560
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 == COW in a single cluster ==
 wrote 2048/2048 bytes at offset 0
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index 707e2d72e9..a253231f5b 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -71,7 +71,7 @@ backing_io 0 256 write | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
 
 TEST_IMG="$TEST_IMG_SAVE"
 
-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G
 
 echo
 echo "== Some concurrent requests touching the same cluster =="
diff --git a/tests/qemu-iotests/038.out b/tests/qemu-iotests/038.out
index 0bdfb19faa..fe2108593a 100644
--- a/tests/qemu-iotests/038.out
+++ b/tests/qemu-iotests/038.out
@@ -514,7 +514,7 @@ wrote 65536/65536 bytes at offset 16646144
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 16711680
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 == Some concurrent requests touching the same cluster ==
 wrote 65536/65536 bytes at offset XXX
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index ddce48ab47..42f6503138 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -133,7 +133,8 @@ echo "== Committing to a backing file with lazy_refcounts=on =="
 
 TEST_IMG="$TEST_IMG".base _make_test_img -o "compat=1.1,lazy_refcounts=on" $size
 
-_make_test_img -o "compat=1.1,lazy_refcounts=on,backing_file=$TEST_IMG.base" $size
+_make_test_img -o "compat=1.1,lazy_refcounts=on,backing_file=$TEST_IMG.base" \
+    -F $IMGFMT $size
 
 $QEMU_IO -c "write 0 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG commit "$TEST_IMG"
diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index bdafa3ace3..e52484d4be 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -66,7 +66,7 @@ No errors were found on the image.
 
 == Committing to a backing file with lazy_refcounts=on ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 32c82b4ec6..f58f50d023 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -80,8 +80,11 @@ class TestSingleDrive(ImageCommitTestCase):
 
     def setUp(self):
         iotests.create_image(backing_img, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img, '-F', 'raw', mid_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % mid_img,
+                 '-F', iotests.imgfmt, test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', backing_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', mid_img)
         self.vm = iotests.VM().add_drive(test_img, "node-name=top,backing.node-name=mid,backing.backing.node-name=base", interface="none")
@@ -305,10 +308,16 @@ class TestRelativePaths(ImageCommitTestCase):
             if exception.errno != errno.EEXIST:
                 raise
         iotests.create_image(self.backing_img_abs, TestRelativePaths.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img_abs, self.mid_img_abs)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.mid_img_abs, self.test_img)
-        qemu_img('rebase', '-u', '-b', self.backing_img, self.mid_img_abs)
-        qemu_img('rebase', '-u', '-b', self.mid_img, self.test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % self.backing_img_abs,
+                 '-F', 'raw', self.mid_img_abs)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % self.mid_img_abs,
+                 '-F', iotests.imgfmt, self.test_img)
+        qemu_img('rebase', '-u', '-b', self.backing_img,
+                 '-F', 'raw', self.mid_img_abs)
+        qemu_img('rebase', '-u', '-b', self.mid_img,
+                 '-F', iotests.imgfmt, self.test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', self.backing_img_abs)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', self.mid_img_abs)
         self.vm = iotests.VM().add_drive(self.test_img)
@@ -371,8 +380,11 @@ class TestSetSpeed(ImageCommitTestCase):
 
     def setUp(self):
         qemu_img('create', backing_img, str(TestSetSpeed.image_len))
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img, '-F', 'raw', mid_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % mid_img,
+                 '-F', iotests.imgfmt, test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 0 512', test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', mid_img)
         self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
@@ -410,9 +422,14 @@ class TestReopenOverlay(ImageCommitTestCase):
 
     def setUp(self):
         iotests.create_image(self.img0, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.img0, self.img1)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.img1, self.img2)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.img2, self.img3)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % self.img0, '-F', 'raw', self.img1)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % self.img1,
+                 '-F', iotests.imgfmt, self.img2)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % self.img2,
+                 '-F', iotests.imgfmt, self.img3)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xab 0 128K', self.img1)
         self.vm = iotests.VM().add_drive(self.img3)
         self.vm.launch()
@@ -435,8 +452,12 @@ class TestErrorHandling(iotests.QMPTestCase):
 
     def setUp(self):
         iotests.create_image(backing_img, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img,
+                 '-F', 'raw', mid_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % mid_img,
+                 '-F', iotests.imgfmt, test_img)
 
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x11 0 512k', mid_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x22 0 512k', test_img)
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index b843f88a66..f0a7bf6650 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -44,7 +44,8 @@ class TestSingleDrive(iotests.QMPTestCase):
 
     def setUp(self):
         iotests.create_image(backing_img, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img, '-F', 'raw', test_img)
         self.vm = iotests.VM().add_drive(test_img, "node-name=top,backing.node-name=base")
         if iotests.qemu_default_machine == 'pc':
             self.vm.add_drive(None, 'media=cdrom', 'ide')
@@ -157,7 +158,8 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=%d,backing_file=%s'
-                        % (self.image_len, backing_img), target_img)
+                        % (self.image_len, backing_img),
+                 '-F', 'raw', target_img)
         result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
                              mode='existing', target=self.qmp_target)
         self.assert_qmp(result, 'return', {})
@@ -227,7 +229,8 @@ class TestSingleBlockdev(TestSingleDrive):
 
     def setUp(self):
         TestSingleDrive.setUp(self)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, target_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img, '-F', 'raw', target_img)
         args = {'driver': iotests.imgfmt,
                 'node-name': self.qmp_target,
                 'file': { 'filename': target_img, 'driver': 'file' } }
@@ -312,7 +315,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
 
     def setUp(self):
         iotests.create_image(backing_img, TestMirrorNoBacking.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img, '-F', 'raw', test_img)
         self.vm = iotests.VM().add_drive(test_img)
         self.vm.launch()
 
@@ -329,7 +333,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
     def test_complete(self):
         self.assert_no_active_block_jobs()
 
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, target_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img, '-F', 'raw', target_img)
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
                              mode='existing', target=target_img)
         self.assert_qmp(result, 'return', {})
@@ -344,7 +349,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
     def test_cancel(self):
         self.assert_no_active_block_jobs()
 
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, target_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img, '-F', 'raw', target_img)
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
                              mode='existing', target=target_img)
         self.assert_qmp(result, 'return', {})
@@ -363,7 +369,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'size=%d'
                         %(TestMirrorNoBacking.image_len), target_backing_img)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=%d,backing_file=%s'
-                        % (TestMirrorNoBacking.image_len, target_backing_img), target_img)
+                        % (TestMirrorNoBacking.image_len, target_backing_img),
+                 '-F', iotests.imgfmt, target_img)
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
                              mode='existing', target=target_img)
@@ -382,7 +389,8 @@ class TestMirrorResized(iotests.QMPTestCase):
 
     def setUp(self):
         iotests.create_image(backing_img, TestMirrorResized.backing_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img, '-F', 'raw', test_img)
         qemu_img('resize', test_img, '2M')
         self.vm = iotests.VM().add_drive(test_img)
         self.vm.launch()
@@ -528,7 +536,9 @@ new_state = "1"
         # Test COW into the target image.  The first half of the
         # cluster at MIRROR_GRANULARITY has to be copied from
         # backing_img, even though sync='top'.
-        qemu_img('create', '-f', iotests.imgfmt, '-ocluster_size=131072,backing_file=%s' %(backing_img), target_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-ocluster_size=131072,backing_file=%s' %(backing_img),
+                 '-F', 'raw', target_img)
         result = self.vm.qmp('drive-mirror', device='drive0', sync='top',
                              on_source_error='ignore',
                              mode='existing', target=target_img)
@@ -548,7 +558,8 @@ new_state = "1"
         self.vm.shutdown()
 
         # Detach blkdebug to compare images successfully
-        qemu_img('rebase', '-f', iotests.imgfmt, '-u', '-b', backing_img, test_img)
+        qemu_img('rebase', '-f', iotests.imgfmt, '-u', '-b', backing_img,
+                 '-F', 'raw', test_img)
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirroring')
 
@@ -620,7 +631,8 @@ new_state = "1"
         self.blkdebug_file = target_img + ".blkdebug"
         iotests.create_image(backing_img, TestWriteErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "write_aio", 5)
-        qemu_img('create', '-f', iotests.imgfmt, '-obacking_file=%s' %(backing_img), test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-obacking_file=%s' %(backing_img), '-F', 'raw', test_img)
         self.vm = iotests.VM().add_drive(test_img)
         self.target_img = 'blkdebug:%s:%s' % (self.blkdebug_file, target_img)
         qemu_img('create', '-f', iotests.imgfmt, '-osize=%d' %(TestWriteErrors.image_len), target_img)
@@ -715,7 +727,8 @@ class TestSetSpeed(iotests.QMPTestCase):
 
     def setUp(self):
         qemu_img('create', backing_img, str(TestSetSpeed.image_len))
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img, '-F', 'raw', test_img)
         self.vm = iotests.VM().add_drive(test_img)
         self.vm.launch()
 
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index 0e85b356b7..e8f23a174c 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -64,8 +64,8 @@ _check_test_img
 echo
 echo "== Rebasing the image =="
 
-$QEMU_IMG rebase -u -b "$TEST_IMG.orig" "$TEST_IMG"
-$QEMU_IMG rebase -b "$TEST_IMG.orig" "$TEST_IMG"
+$QEMU_IMG rebase -u -b "$TEST_IMG.orig" -F $IMGFMT "$TEST_IMG"
+$QEMU_IMG rebase -b "$TEST_IMG.orig" -F $IMGFMT "$TEST_IMG"
 _check_test_img
 
 # success, all done
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index b102e49208..e4022b7044 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -46,7 +46,7 @@ _supported_proto file
 
 size=128M
 _make_test_img $size
-$QEMU_IMG rebase -u -b "$TEST_IMG" "$TEST_IMG"
+$QEMU_IMG rebase -u -b "$TEST_IMG" -F $IMGFMT "$TEST_IMG"
 
 echo
 echo "== backing file references self =="
@@ -54,8 +54,8 @@ _img_info --backing-chain
 
 _make_test_img $size
 mv "$TEST_IMG" "$TEST_IMG.base"
-_make_test_img -b "$TEST_IMG.base" $size
-$QEMU_IMG rebase -u -b "$TEST_IMG" "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
+$QEMU_IMG rebase -u -b "$TEST_IMG" -F $IMGFMT "$TEST_IMG.base"
 
 echo
 echo "== parent references self =="
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
 echo "== ancestor references another ancestor =="
@@ -76,9 +76,9 @@ _img_info --backing-chain
 
 _make_test_img $size
 mv "$TEST_IMG" "$TEST_IMG.1.base"
-_make_test_img -b "$TEST_IMG.1.base" $size
+_make_test_img -b "$TEST_IMG.1.base" -F $IMGFMT $size
 mv "$TEST_IMG" "$TEST_IMG.2.base"
-_make_test_img -b "$TEST_IMG.2.base" $size
+_make_test_img -b "$TEST_IMG.2.base" -F $IMGFMT $size
 
 echo
 echo "== finite chain of length 3 (human) =="
diff --git a/tests/qemu-iotests/043.out b/tests/qemu-iotests/043.out
index 0280f999ce..7251e26d4f 100644
--- a/tests/qemu-iotests/043.out
+++ b/tests/qemu-iotests/043.out
@@ -4,20 +4,20 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 == backing file references self ==
 qemu-img: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 == parent references self ==
 qemu-img: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.1.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.2.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.3.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.1.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.2.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.3.base backing_fmt=IMGFMT
 
 == ancestor references another ancestor ==
 qemu-img: Backing file 'TEST_DIR/t.IMGFMT.2.base' creates an infinite loop.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.1.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.2.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.1.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.2.base backing_fmt=IMGFMT
 
 == finite chain of length 3 (human) ==
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
 == finite chain of length 3 (json) ==
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
index ecbe5fc0f4..88b3363c19 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -69,7 +69,7 @@ backing_io 0 32 write | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
 
 mv "$TEST_IMG" "$TEST_IMG.base"
 
-_make_test_img -b "$TEST_IMG.base" 6G
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G
 
 echo
 echo "== Some concurrent requests touching the same cluster =="
diff --git a/tests/qemu-iotests/046.out b/tests/qemu-iotests/046.out
index 70783041e2..b022bcddd5 100644
--- a/tests/qemu-iotests/046.out
+++ b/tests/qemu-iotests/046.out
@@ -66,7 +66,7 @@ wrote 65536/65536 bytes at offset 1966080
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 2031616
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=6442450944 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 == Some concurrent requests touching the same cluster ==
 blkdebug: Suspended request 'A'
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index cdc5356541..4b0a390c43 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -58,13 +58,13 @@ $QEMU_IO -c "write -P 0x5a 0 1048576" "$TEST_IMG" | _filter_qemu_io
 
 TEST_IMG="$TEST_IMG_SAVE"
 
-_make_test_img -b "$TEST_IMG.old" $size
+_make_test_img -b "$TEST_IMG.old" -F $IMGFMT $size
 $QEMU_IO -c "write -z 0 1048576" "$TEST_IMG" | _filter_qemu_io
 
 echo
 echo "== Rebasing the image =="
 
-$QEMU_IMG rebase -b "$TEST_IMG.new" "$TEST_IMG"
+$QEMU_IMG rebase -b "$TEST_IMG.new" -F $IMGFMT "$TEST_IMG"
 $QEMU_IO -c "read -P 0x00 0 1048576" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
diff --git a/tests/qemu-iotests/050.out b/tests/qemu-iotests/050.out
index 3602d580dc..ab3daeddca 100644
--- a/tests/qemu-iotests/050.out
+++ b/tests/qemu-iotests/050.out
@@ -7,7 +7,7 @@ wrote 1048576/1048576 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT.new', fmt=IMGFMT size=10485760
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=10485760 backing_file=TEST_DIR/t.IMGFMT.old
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=10485760 backing_file=TEST_DIR/t.IMGFMT.old backing_fmt=IMGFMT
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 034d3a3250..bee26075b2 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -70,7 +70,7 @@ device_id="drive0"
 _make_test_img $size
 cp "$TEST_IMG" "$TEST_IMG.orig"
 mv "$TEST_IMG" "$TEST_IMG.base"
-_make_test_img -b "$TEST_IMG.base" $size
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
 
 echo
 echo === Unknown option ===
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 554c5ca90a..de4771bcb3 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -1,6 +1,6 @@
 QA output created by 051
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 === Unknown option ===
 
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index da8ad87187..f707471fb0 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -1,6 +1,6 @@
 QA output created by 051
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 === Unknown option ===
 
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index f73fc74457..052456aa00 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -54,7 +54,8 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
 
     def setUp(self):
         create_image(backing_img, TestSyncModesNoneAndTop.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', 'backing_file=%s' % backing_img, '-F', 'raw', test_img)
         qemu_io('-c', 'write -P0x41 0 512', test_img)
         qemu_io('-c', 'write -P0xd5 1M 32k', test_img)
         qemu_io('-c', 'write -P0xdc 32M 124k', test_img)
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 32c0ecce9e..94c0d5accc 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -160,7 +160,7 @@ TEST_IMG=$BACKING_IMG _make_test_img 1G
 
 $QEMU_IO -c 'write 0k 64k' "$BACKING_IMG" | _filter_qemu_io
 
-_make_test_img -b "$BACKING_IMG" 1G
+_make_test_img -b "$BACKING_IMG" -F $IMGFMT 1G
 # Write two clusters, the second one enforces creation of an L2 table after
 # the first data cluster.
 $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index be5f8707a3..e574c38797 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -101,7 +101,7 @@ read 512/512 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1073741824
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 536870912
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 10eb243164..08ddbdd10c 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -224,7 +224,7 @@ echo "=== Testing zero expansion on backed image ==="
 echo
 TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
-_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" 64M
+_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" -F $IMGFMT 64M
 $QEMU_IO -c "read -P 0x2a 0 128k" -c "write -z 0 64k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
 _check_test_img
@@ -235,7 +235,7 @@ echo "=== Testing zero expansion on backed inactive clusters ==="
 echo
 TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
-_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" 64M
+_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" -F $IMGFMT 64M
 $QEMU_IO -c "write -z 0 64k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG snapshot -c foo "$TEST_IMG"
 $QEMU_IO -c "write -P 0x42 0 128k" "$TEST_IMG" | _filter_qemu_io
@@ -251,7 +251,7 @@ echo "=== Testing zero expansion on backed image with shared L2 table ==="
 echo
 TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 64M
 $QEMU_IO -c "write -P 0x2a 0 128k" "$TEST_IMG.base" | _filter_qemu_io
-_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" 64M
+_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" -F $IMGFMT 64M
 $QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG snapshot -c foo "$TEST_IMG"
 $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
@@ -274,7 +274,7 @@ echo
 echo "=== Testing progress report without snapshot ==="
 echo
 TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 4G
-_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" 4G
+_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" -F $IMGFMT 4G
 $QEMU_IO -c "write -z 0  64k" \
          -c "write -z 1G 64k" \
          -c "write -z 2G 64k" \
@@ -286,7 +286,7 @@ echo
 echo "=== Testing progress report with snapshot ==="
 echo
 TEST_IMG="$TEST_IMG.base" _make_test_img -o "compat=1.1" 4G
-_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" 4G
+_make_test_img -o "compat=1.1" -b "$TEST_IMG.base" -F $IMGFMT 4G
 $QEMU_IO -c "write -z 0  64k" \
          -c "write -z 1G 64k" \
          -c "write -z 2G 64k" \
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index c549b139da..8c8b48cee9 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -424,7 +424,7 @@ read 131072/131072 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 0
@@ -440,7 +440,7 @@ read 65536/65536 bytes at offset 65536
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 0
@@ -459,7 +459,7 @@ read 65536/65536 bytes at offset 65536
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
@@ -483,7 +483,7 @@ read 67108864/67108864 bytes at offset 0
 === Testing progress report without snapshot ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=4294967296
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 1073741824
@@ -498,7 +498,7 @@ No errors were found on the image.
 === Testing progress report with snapshot ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=4294967296
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 1073741824
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index b997b127f0..a4da83b2d9 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -46,7 +46,7 @@ echo
 echo "=== Creating an image with a backing file and deleting that file ==="
 echo
 TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE
-_make_test_img -b "$TEST_IMG.base" $IMG_SIZE
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $IMG_SIZE
 _rm_test_img "$TEST_IMG.base"
 # Just open the image and close it right again (this should print an error message)
 $QEMU_IO -c quit "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
diff --git a/tests/qemu-iotests/069.out b/tests/qemu-iotests/069.out
index c78e8c2b72..126b4d2d51 100644
--- a/tests/qemu-iotests/069.out
+++ b/tests/qemu-iotests/069.out
@@ -3,6 +3,6 @@ QA output created by 069
 === Creating an image with a backing file and deleting that file ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=131072
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing file: Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
 *** done
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 23a1bdf890..1dce478709 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -52,7 +52,7 @@ echo "== creating backing file =="
 
 TEST_IMG="$TEST_IMG.base" _make_test_img $size
 
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 $QEMU_IO -c "write -P 0xa5 0 $size" "$TEST_IMG.base" | _filter_qemu_io
 
 echo
diff --git a/tests/qemu-iotests/073.out b/tests/qemu-iotests/073.out
index de5452492c..7a718b525e 100644
--- a/tests/qemu-iotests/073.out
+++ b/tests/qemu-iotests/073.out
@@ -2,7 +2,7 @@ QA output created by 073
 
 == creating backing file ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 1998965ed4..2135581867 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -84,8 +84,10 @@ run_qemu_img create -f $IMGFMT -o cluster_size=4k -o help "$TEST_IMG" $size
 run_qemu_img create -f $IMGFMT -o cluster_size=4k -o \? "$TEST_IMG" $size
 
 # Looks like a help option, but is part of the backing file name
-run_qemu_img create -f $IMGFMT -u -o backing_file="$TEST_IMG",,help "$TEST_IMG" $size
-run_qemu_img create -f $IMGFMT -u -o backing_file="$TEST_IMG",,\? "$TEST_IMG" $size
+run_qemu_img create -f $IMGFMT -u -o backing_file="$TEST_IMG",,help \
+    -F $IMGFMT "$TEST_IMG" $size
+run_qemu_img create -f $IMGFMT -u -o backing_file="$TEST_IMG",,\? \
+    -F $IMGFMT "$TEST_IMG" $size
 
 # Try to trick qemu-img into creating escaped commas
 run_qemu_img create -f $IMGFMT -o backing_file="$TEST_IMG", -o help "$TEST_IMG" $size
@@ -141,8 +143,8 @@ run_qemu_img convert -O $IMGFMT -o cluster_size=4k -o help "$TEST_IMG" "$TEST_IM
 run_qemu_img convert -O $IMGFMT -o cluster_size=4k -o \? "$TEST_IMG" "$TEST_IMG".base
 
 # Looks like a help option, but is part of the backing file name
-run_qemu_img convert -O $IMGFMT -o backing_file="$TEST_IMG",,help "$TEST_IMG" "$TEST_IMG".base
-run_qemu_img convert -O $IMGFMT -o backing_file="$TEST_IMG",,\? "$TEST_IMG" "$TEST_IMG".base
+run_qemu_img convert -O $IMGFMT -o backing_fmt=$IMGFMT,backing_file="$TEST_IMG",,help "$TEST_IMG" "$TEST_IMG".base
+run_qemu_img convert -O $IMGFMT -o backing_fmt=$IMGFMT,backing_file="$TEST_IMG",,\? "$TEST_IMG" "$TEST_IMG".base
 
 # Try to trick qemu-img into creating escaped commas
 run_qemu_img convert -O $IMGFMT -o backing_file="$TEST_IMG", -o help "$TEST_IMG" "$TEST_IMG".base
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index e878572a0d..0d7c5e8342 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -244,11 +244,11 @@ Supported options:
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help -F qcow2 TEST_DIR/t.qcow2 128M
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,? -F qcow2 TEST_DIR/t.qcow2 128M
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2, -o help TEST_DIR/t.qcow2 128M
 qemu-img: Invalid option list: backing_file=TEST_DIR/t.qcow2,
@@ -543,10 +543,10 @@ Supported options:
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
 
-Testing: convert -O qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
+Testing: convert -O qcow2 -o backing_fmt=qcow2,backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing file: Could not open 'TEST_DIR/t.qcow2,help': No such file or directory
 
-Testing: convert -O qcow2 -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
+Testing: convert -O qcow2 -o backing_fmt=qcow2,backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing file: Could not open 'TEST_DIR/t.qcow2,?': No such file or directory
 
 Testing: convert -O qcow2 -o backing_file=TEST_DIR/t.qcow2, -o help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index dd3c993a2d..e99eb44581 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -106,7 +106,7 @@ add_snapshot_image()
 {
     base_image="${TEST_DIR}/$((${1}-1))-${snapshot_virt0}"
     snapshot_file="${TEST_DIR}/${1}-${snapshot_virt0}"
-    TEST_IMG=$snapshot_file _make_test_img -u -b "${base_image}" "$size"
+    TEST_IMG=$snapshot_file _make_test_img -u -b "${base_image}" -F $IMGFMT "$size"
     do_blockdev_add "$1" "'backing': null, " "${snapshot_file}"
 }
 
@@ -225,7 +225,7 @@ echo
 SNAPSHOTS=$((${SNAPSHOTS}+1))
 
 TEST_IMG="$TEST_IMG.base" _make_test_img "$size"
-_make_test_img -b "${TEST_IMG}.base" "$size"
+_make_test_img -b "${TEST_IMG}.base" -F $IMGFMT "$size"
 do_blockdev_add ${SNAPSHOTS} "" "${TEST_IMG}"
 blockdev_snapshot ${SNAPSHOTS} error
 
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index a822ff4ef6..080a503c87 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -68,12 +68,12 @@ Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_fil
 
 === Create a couple of snapshots using blockdev-snapshot ===
 
-Formatting 'TEST_DIR/11-snapshot-v0.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/10-snapshot-v0.IMGFMT
+Formatting 'TEST_DIR/11-snapshot-v0.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/10-snapshot-v0.IMGFMT backing_fmt=IMGFMT
 { 'execute': 'blockdev-add', 'arguments': { 'driver': 'IMGFMT', 'node-name': 'snap_11', 'backing': null, 'file': { 'driver': 'file', 'filename': 'TEST_DIR/11-snapshot-v0.IMGFMT', 'node-name': 'file_11' } } }
 {"return": {}}
 { 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overlay':'snap_11' } }
 {"return": {}}
-Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/11-snapshot-v0.IMGFMT
+Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/11-snapshot-v0.IMGFMT backing_fmt=IMGFMT
 { 'execute': 'blockdev-add', 'arguments': { 'driver': 'IMGFMT', 'node-name': 'snap_12', 'backing': null, 'file': { 'driver': 'file', 'filename': 'TEST_DIR/12-snapshot-v0.IMGFMT', 'node-name': 'file_12' } } }
 {"return": {}}
 { 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overlay':'snap_12' } }
@@ -101,7 +101,7 @@ Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=IMGFMT size=134217728 backing_f
 === Invalid command - snapshot node has a backing image ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 { 'execute': 'blockdev-add', 'arguments': { 'driver': 'IMGFMT', 'node-name': 'snap_13', 'file': { 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'node-name': 'file_13' } } }
 {"return": {}}
 { 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overlay':'snap_13' } }
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 059ad75e28..66c5415abe 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -84,7 +84,7 @@ echo
 echo "=== Testing correct handling of 'backing':null ==="
 echo
 
-_make_test_img -b "$TEST_IMG.base" $IMG_SIZE
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $IMG_SIZE
 
 # This should read 42
 $QEMU_IO -c 'read -P 42 0 512' "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 20c8ce8f0e..15682c2886 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -21,7 +21,7 @@ read 512/512 bytes at offset 0
 
 === Testing correct handling of 'backing':null ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 512/512 bytes at offset 0
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 155ae86aa7..77a5f0f3f5 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -51,9 +51,9 @@ size_larger=100M
 
 TEST_IMG="$TEST_IMG.base" _make_test_img $size_smaller
 
-TEST_IMG="$TEST_IMG.snp1" _make_test_img -b "$TEST_IMG.base" $size_larger
+TEST_IMG="$TEST_IMG.snp1" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size_larger
 
-_make_test_img -b "${TEST_IMG}.snp1" $size_larger
+_make_test_img -b "${TEST_IMG}.snp1" -F $IMGFMT $size_larger
 
 echo
 echo "=== Base image info before commit and resize ==="
diff --git a/tests/qemu-iotests/095.out b/tests/qemu-iotests/095.out
index 614e5ccbbb..e66ced58f8 100644
--- a/tests/qemu-iotests/095.out
+++ b/tests/qemu-iotests/095.out
@@ -1,7 +1,7 @@
 QA output created by 095
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=5242880
-Formatting 'TEST_DIR/t.IMGFMT.snp1', fmt=IMGFMT size=104857600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=104857600 backing_file=TEST_DIR/t.IMGFMT.snp1
+Formatting 'TEST_DIR/t.IMGFMT.snp1', fmt=IMGFMT size=104857600 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=104857600 backing_file=TEST_DIR/t.IMGFMT.snp1 backing_fmt=IMGFMT
 
 === Base image info before commit and resize ===
 image: TEST_DIR/t.IMGFMT.base
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 690f3d3ce1..d910a8b107 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -67,8 +67,8 @@ echo
 
 len=$((2100 * 1024 * 1024 + 512)) # larger than 2G, and not cluster aligned
 TEST_IMG="$TEST_IMG.base" _make_test_img $len
-TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" $len
-_make_test_img -b "$TEST_IMG.itmd" $len
+TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT $len
+_make_test_img -b "$TEST_IMG.itmd" -F $IMGFMT $len
 
 $QEMU_IO -c "write -P 1 0x7ffd0000 192k" "$TEST_IMG.base" | _filter_qemu_io
 $QEMU_IO -c "write -P 2 0x7ffe0000 128k" "$TEST_IMG.itmd" | _filter_qemu_io
diff --git a/tests/qemu-iotests/097.out b/tests/qemu-iotests/097.out
index f6705a1cc7..3038ddab31 100644
--- a/tests/qemu-iotests/097.out
+++ b/tests/qemu-iotests/097.out
@@ -3,8 +3,8 @@ QA output created by 097
 === Test pass 0 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -40,8 +40,8 @@ Offset          Length          File
 === Test pass 1 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -78,8 +78,8 @@ Offset          Length          File
 === Test pass 2 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -116,8 +116,8 @@ Offset          Length          File
 === Test pass 3 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index 1e29d96b3d..f2ccdd7909 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -52,7 +52,7 @@ echo "=== $event ==="
 echo
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
-_make_test_img -b "$TEST_IMG.base" 64M
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 64M
 
 # Some data that can be leaked when emptying the top image
 $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/098.out b/tests/qemu-iotests/098.out
index 23cf371f53..6c73dd0977 100644
--- a/tests/qemu-iotests/098.out
+++ b/tests/qemu-iotests/098.out
@@ -3,7 +3,7 @@ QA output created by 098
 === l1_update ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
@@ -12,7 +12,7 @@ No errors were found on the image.
 === empty_image_prepare ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
@@ -25,7 +25,7 @@ No errors were found on the image.
 === reftable_update ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
@@ -39,7 +39,7 @@ No errors were found on the image.
 === refblock_alloc ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 139c02c2cf..f1813d0dfb 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -50,7 +50,7 @@ echo '=== Reconstructable filename ==='
 echo
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
-_make_test_img -b "$TEST_IMG_REL.base" 64M
+_make_test_img -b "$TEST_IMG_REL.base" -F $IMGFMT 64M
 # qemu should be able to reconstruct the filename, so relative backing names
 # should work
 # (We have to filter the backing file format because vmdk always
@@ -91,7 +91,7 @@ echo '=== Backing name is always relative to the backed image ==='
 echo
 
 # omit the image size; it should work anyway
-_make_test_img -b "$TEST_IMG_REL.base"
+_make_test_img -b "$TEST_IMG_REL.base" -F $IMGFMT
 
 echo
 echo '=== Nodes without a common directory ==='
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index f835553a99..cf8f6c025d 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -3,7 +3,7 @@ QA output created by 110
 === Reconstructable filename ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=t.IMGFMT.base backing_fmt=IMGFMT
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
@@ -18,7 +18,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
 
 === Backing name is always relative to the backed image ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=t.IMGFMT.base backing_fmt=IMGFMT
 
 === Nodes without a common directory ===
 
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 2dc16b2ca4..dfd1cd05d6 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -52,9 +52,10 @@ echo
 echo "=== Check allocation status regression with -B ==="
 echo
 
-_make_test_img -b "$TEST_IMG".base
+_make_test_img -b "$TEST_IMG".base -F $IMGFMT
 $QEMU_IO -c "write -P 0x22 0 3M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
-$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG".orig
+$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base \
+    -o backing_fmt=$IMGFMT "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IMG map "$TEST_IMG".orig | _filter_qemu_img_map
 
 
@@ -62,18 +63,22 @@ echo
 echo "=== Check that zero clusters are kept in overlay ==="
 echo
 
-_make_test_img -b "$TEST_IMG".base
+_make_test_img -b "$TEST_IMG".base -F $IMGFMT
 
 $QEMU_IO -c "write -P 0 0 3M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
-$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG".orig
+$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -o backing_fmt=$IMGFMT \
+    "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IO -c "read -P 0 0 3M" "$TEST_IMG".orig 2>&1 | _filter_qemu_io | _filter_testdir
-$QEMU_IMG convert -O $IMGFMT -c -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG".orig
+$QEMU_IMG convert -O $IMGFMT -c -B "$TEST_IMG".base -o backing_fmt=$IMGFMT \
+    "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IO -c "read -P 0 0 3M" "$TEST_IMG".orig 2>&1 | _filter_qemu_io | _filter_testdir
 
 $QEMU_IO -c "write -z 0 3M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
-$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG".orig
+$QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -o backing_fmt=$IMGFMT \
+    "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IO -c "read -P 0 0 3M" "$TEST_IMG".orig 2>&1 | _filter_qemu_io | _filter_testdir
-$QEMU_IMG convert -O $IMGFMT -c -B "$TEST_IMG".base "$TEST_IMG" "$TEST_IMG".orig
+$QEMU_IMG convert -O $IMGFMT -c -B "$TEST_IMG".base -o backing_fmt=$IMGFMT \
+    "$TEST_IMG" "$TEST_IMG".orig
 $QEMU_IO -c "read -P 0 0 3M" "$TEST_IMG".orig 2>&1 | _filter_qemu_io | _filter_testdir
 
 
@@ -94,11 +99,11 @@ TEST_IMG="$TEST_IMG".base _make_test_img 256M
 # We do not want such a zero write, however, because we are past the
 # end of the backing file on the target as well, so we do not need to
 # write anything there.
-_make_test_img -b "$TEST_IMG".base 768M
+_make_test_img -b "$TEST_IMG".base 768M -F $IMGFMT
 
 # Use compat=0.10 as the output so there is no zero cluster support
 $QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -o compat=0.10 \
-    "$TEST_IMG" "$TEST_IMG".orig
+    -o backing_fmt=$IMGFMT "$TEST_IMG" "$TEST_IMG".orig
 # See that nothing has been allocated past 64M
 $QEMU_IMG map "$TEST_IMG".orig | _filter_qemu_img_map
 
@@ -110,7 +115,7 @@ $QEMU_IO -c 'write -P 0x11 255M 1M' "$TEST_IMG".base 2>&1 | _filter_qemu_io
 $QEMU_IO -c 'write -P 0x22 600M 1M' "$TEST_IMG" 2>&1 | _filter_qemu_io
 
 $QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -o compat=0.10 \
-    "$TEST_IMG" "$TEST_IMG".orig
+    -o backing_fmt=$IMGFMT "$TEST_IMG" "$TEST_IMG".orig
 
 $QEMU_IMG map "$TEST_IMG".orig | _filter_qemu_img_map
 $QEMU_IO -c 'read -P 0x11 255M 1M' \
@@ -199,7 +204,7 @@ $QEMU_IMG map --output=json "$TEST_IMG".orig | _filter_qemu_img_map
 TEST_IMG="$TEST_IMG".base _make_test_img 64M
 $QEMU_IO -c "write -P 0x11 0 32M" "$TEST_IMG".base 2>&1 | _filter_qemu_io | _filter_testdir
 
-_make_test_img -b "$TEST_IMG".base 64M
+_make_test_img -b "$TEST_IMG".base 64M -F $IMGFMT
 $QEMU_IO -c "write -P 0x22 0 3M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index c2e154a1e5..f1f195ed77 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -5,7 +5,7 @@ wrote 67108864/67108864 bytes at offset 0
 
 === Check allocation status regression with -B ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 3145728/3145728 bytes at offset 0
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
@@ -14,7 +14,7 @@ Offset          Length          File
 
 === Check that zero clusters are kept in overlay ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 3145728/3145728 bytes at offset 0
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 3145728/3145728 bytes at offset 0
@@ -31,7 +31,7 @@ read 3145728/3145728 bytes at offset 0
 === Converting to an overlay larger than its backing file ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=268435456
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=805306368 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=805306368 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Offset          Length          File
 
 wrote 1048576/1048576 bytes at offset 267386880
@@ -141,7 +141,7 @@ read 63963136/63963136 bytes at offset 3145728
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 wrote 33554432/33554432 bytes at offset 0
 32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 3145728/3145728 bytes at offset 0
 3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index b7fce1e59d..dd5a211227 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -61,7 +61,7 @@ BASE_IMG="$TEST_DIR/image:base.$IMGFMT"
 TOP_IMG="$TEST_DIR/image:top.$IMGFMT"
 
 TEST_IMG=$BASE_IMG _make_test_img 64M
-TEST_IMG=$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
+TEST_IMG=$TOP_IMG _make_test_img -b ./image:base.$IMGFMT -F $IMGFMT
 
 # (1) The default cluster size depends on the image format
 # (2) vmdk only supports vmdk backing files, so it always reports the
@@ -82,7 +82,7 @@ BASE_IMG="base.$IMGFMT"
 TOP_IMG="file:image:top.$IMGFMT"
 
 TEST_IMG=$BASE_IMG _make_test_img 64M
-TEST_IMG=$TOP_IMG _make_test_img -b "$BASE_IMG"
+TEST_IMG=$TOP_IMG _make_test_img -b "$BASE_IMG" -F $IMGFMT
 
 TEST_IMG=$TOP_IMG _img_info | grep -ve 'cluster_size' -e 'backing file format'
 
diff --git a/tests/qemu-iotests/126.out b/tests/qemu-iotests/126.out
index e3c4d61916..7d6634685e 100644
--- a/tests/qemu-iotests/126.out
+++ b/tests/qemu-iotests/126.out
@@ -8,14 +8,14 @@ Formatting 'file:TEST_DIR/a:b.IMGFMT', fmt=IMGFMT size=67108864
 === Testing relative backing filename resolution ===
 
 Formatting 'TEST_DIR/image:base.IMGFMT', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/image:top.IMGFMT', fmt=IMGFMT size=67108864 backing_file=./image:base.IMGFMT
+Formatting 'TEST_DIR/image:top.IMGFMT', fmt=IMGFMT size=67108864 backing_file=./image:base.IMGFMT backing_fmt=IMGFMT
 image: TEST_DIR/image:top.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 backing file: ./image:base.IMGFMT (actual path: TEST_DIR/./image:base.IMGFMT)
 
 Formatting 'base.IMGFMT', fmt=IMGFMT size=67108864
-Formatting 'file:image:top.IMGFMT', fmt=IMGFMT size=67108864 backing_file=base.IMGFMT
+Formatting 'file:image:top.IMGFMT', fmt=IMGFMT size=67108864 backing_file=base.IMGFMT backing_fmt=IMGFMT
 image: ./image:top.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index a4fc866038..e2ac2f5536 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -48,8 +48,8 @@ _require_devices virtio-scsi scsi-hd
 IMG_SIZE=64K
 
 _make_test_img $IMG_SIZE
-TEST_IMG="$TEST_IMG.overlay0" _make_test_img -b "$TEST_IMG" $IMG_SIZE
-TEST_IMG="$TEST_IMG.overlay1" _make_test_img -b "$TEST_IMG" $IMG_SIZE
+TEST_IMG="$TEST_IMG.overlay0" _make_test_img -b "$TEST_IMG" -F $IMGFMT $IMG_SIZE
+TEST_IMG="$TEST_IMG.overlay1" _make_test_img -b "$TEST_IMG" -F $IMGFMT $IMG_SIZE
 
 # So that we actually have something to mirror and the job does not return
 # immediately (which may be bad because then we cannot know whether the
diff --git a/tests/qemu-iotests/127.out b/tests/qemu-iotests/127.out
index 623d52bbd1..efd6cb327f 100644
--- a/tests/qemu-iotests/127.out
+++ b/tests/qemu-iotests/127.out
@@ -1,7 +1,7 @@
 QA output created by 127
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
-Formatting 'TEST_DIR/t.IMGFMT.overlay0', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT.overlay1', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.overlay0', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.overlay1', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
 wrote 42/42 bytes at offset 0
 42 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index b0da4a5541..0e13244d85 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -29,7 +29,8 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
 
     def setUp(self):
         iotests.qemu_img('create', '-f', iotests.imgfmt, self.base_img, "1G")
-        iotests.qemu_img('create', '-f', iotests.imgfmt, self.test_img, "-b", self.base_img)
+        iotests.qemu_img('create', '-f', iotests.imgfmt, self.test_img,
+                         "-b", self.base_img, '-F', iotests.imgfmt)
         iotests.qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x5d 1M 128M', self.test_img)
         self.vm = iotests.VM().add_drive(self.test_img)
         self.vm.launch()
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 6f7cacc091..4070fd9457 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -40,7 +40,7 @@ _supported_fmt qcow2
 _supported_proto file
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 echo
 echo "=== Check that node-name can't be changed ==="
diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
index 1491ef45a9..d70c2e8041 100644
--- a/tests/qemu-iotests/133.out
+++ b/tests/qemu-iotests/133.out
@@ -1,6 +1,6 @@
 QA output created by 133
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 === Check that node-name can't be changed ===
 
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 7120d3142b..1452fd24b3 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -71,7 +71,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
     def addBlockDriverStateOverlay(self, node):
         self.checkBlockDriverState(node, False)
         iotests.qemu_img('create', '-u', '-f', iotests.imgfmt,
-                         '-b', base_img, new_img, '1M')
+                         '-b', base_img, '-F', iotests.imgfmt, new_img, '1M')
         opts = {'driver': iotests.imgfmt,
                 'node-name': node,
                 'backing': None,
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 5192d256e3..21aa0b42d8 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -89,8 +89,8 @@ test_blockjob()
 
 
 TEST_IMG="$TEST_DIR/b.$IMGFMT" _make_test_img 1M
-TEST_IMG="$TEST_DIR/m.$IMGFMT" _make_test_img -b "$TEST_DIR/b.$IMGFMT" 1M
-_make_test_img -b "$TEST_DIR/m.$IMGFMT" 1M
+TEST_IMG="$TEST_DIR/m.$IMGFMT" _make_test_img -b "$TEST_DIR/b.$IMGFMT" -F $IMGFMT 1M
+_make_test_img -b "$TEST_DIR/m.$IMGFMT" 1M -F $IMGFMT
 
 _launch_qemu -nodefaults
 
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 263b680bdf..08e0aecd65 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -1,7 +1,7 @@
 QA output created by 141
 Formatting 'TEST_DIR/b.IMGFMT', fmt=IMGFMT size=1048576
-Formatting 'TEST_DIR/m.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/b.IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/m.IMGFMT
+Formatting 'TEST_DIR/m.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/b.IMGFMT backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/m.IMGFMT backing_fmt=IMGFMT
 {'execute': 'qmp_capabilities'}
 {"return": {}}
 
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index daefcbaa58..69fd10ef51 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -67,7 +67,7 @@ size=128M
 
 TEST_IMG="$TEST_IMG.base" _make_test_img $size
 TEST_IMG="$TEST_IMG.snap" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base" $size
+_make_test_img -b "$TEST_IMG.base" $size -F $IMGFMT
 
 echo
 echo === Simple test for all cache modes ===
diff --git a/tests/qemu-iotests/142.out b/tests/qemu-iotests/142.out
index 3667e38def..a92b948edd 100644
--- a/tests/qemu-iotests/142.out
+++ b/tests/qemu-iotests/142.out
@@ -1,7 +1,7 @@
 QA output created by 142
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
 Formatting 'TEST_DIR/t.IMGFMT.snap', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 === Simple test for all cache modes ===
 
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index cf961d3609..adb9a2987f 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -94,7 +94,7 @@ for opts1 in "" "read-only=on" "read-only=on,force-share=on"; do
 
     echo
     echo "== Creating test image =="
-    _make_test_img -b "${TEST_IMG}.base"
+    _make_test_img -b "${TEST_IMG}.base" -F $IMGFMT
 
     echo
     echo "== Launching QEMU, opts: '$opts1' =="
@@ -125,7 +125,7 @@ for opts1 in "" "read-only=on" "read-only=on,force-share=on"; do
         _run_cmd $QEMU_IMG amend -o "size=$size" $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG commit      $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG resize      $L "${TEST_IMG}" $size
-        _run_cmd $QEMU_IMG rebase      $L "${TEST_IMG}" -b "${TEST_IMG}.base"
+        _run_cmd $QEMU_IMG rebase      $L "${TEST_IMG}" -b "${TEST_IMG}.base" -F $IMGFMT
         _run_cmd $QEMU_IMG snapshot -l $L "${TEST_IMG}"
         _run_cmd $QEMU_IMG convert     $L "${TEST_IMG}" "${TEST_IMG}.convert"
         _run_cmd $QEMU_IMG dd          $L if="${TEST_IMG}" of="${TEST_IMG}.convert" bs=512 count=1
@@ -135,7 +135,7 @@ for opts1 in "" "read-only=on" "read-only=on,force-share=on"; do
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
 echo "== Creating ${TEST_IMG}.[abc] ==" | _filter_testdir
 (
-    $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}"
-    $QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}"
-    $QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b"
+    $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}" -F $IMGFMT
+    $QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}" -F $IMGFMT
+    $QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b" -F $IMGFMT
 ) | _filter_img_create
 
 echo
@@ -219,7 +219,7 @@ _send_qemu_cmd $QEMU_HANDLE \
 _run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
 
 echo "Creating overlay with qemu-img when the guest is running should be allowed"
-_run_cmd $QEMU_IMG create -f $IMGFMT -b "${TEST_IMG}" "${TEST_IMG}.overlay"
+_run_cmd $QEMU_IMG create -f $IMGFMT -b "${TEST_IMG}" -F $IMGFMT "${TEST_IMG}.overlay"
 
 echo "== Closing an image should unlock it =="
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index b2a90caa6b..8a79e1ee87 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -6,7 +6,7 @@ QEMU_PROG: -drive if=none,file=null-co://,readonly=off,force-share=on: force-sha
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
 
 == Creating test image ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 == Launching QEMU, opts: '' ==
 
@@ -68,7 +68,7 @@ _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
-_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
@@ -92,10 +92,11 @@ _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
-_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 qemu-img: TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 file format: IMGFMT
+backing file format: IMGFMT
 
 == Running utility commands -U ==
 
@@ -130,7 +131,7 @@ _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
 
-_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
@@ -152,7 +153,7 @@ Round done
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
 
 == Creating test image ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 == Launching QEMU, opts: 'read-only=on' ==
 
@@ -199,7 +200,7 @@ _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
-_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
@@ -215,10 +216,11 @@ _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
-_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 qemu-img: TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 file format: IMGFMT
+backing file format: IMGFMT
 
 == Running utility commands -U ==
 
@@ -253,7 +255,7 @@ _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
 
-_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
@@ -275,7 +277,7 @@ Round done
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
 
 == Creating test image ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 == Launching QEMU, opts: 'read-only=on,force-share=on' ==
 
@@ -309,7 +311,7 @@ _qemu_img_wrapper commit TEST_DIR/t.qcow2
 
 _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
 
-_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 
 _qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
 
@@ -321,8 +323,9 @@ _qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
 
 _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
 
-_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 file format: IMGFMT
+backing file format: IMGFMT
 
 == Running utility commands -U ==
 
@@ -357,7 +360,7 @@ _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
 qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
 
-_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 
 _qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
 
@@ -398,9 +401,9 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 == Two devices with the same image (read-only=on,force-share=on - read-only=on,force-share=on) ==
 
 == Creating TEST_DIR/t.qcow2.[abc] ==
-Formatting 'TEST_DIR/t.IMGFMT.a', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT.b', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT.c', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.b
+Formatting 'TEST_DIR/t.IMGFMT.a', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.b', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.c', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.b backing_fmt=IMGFMT
 
 == Two devices sharing the same file in backing chain ==
 
@@ -430,7 +433,7 @@ qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 Creating overlay with qemu-img when the guest is running should be allowed
 
-_qemu_img_wrapper create -f qcow2 -b TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.overlay
+_qemu_img_wrapper create -f qcow2 -b TEST_DIR/t.qcow2 -F qcow2 TEST_DIR/t.qcow2.overlay
 == Closing an image should unlock it ==
 { 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'drive_del d0' } }
 {"return": ""}
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index d68f66b9e0..7f1c0d9bd9 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -50,7 +50,7 @@ echo
 echo == backing file contains zeros ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Make sure that the whole cluster is allocated even for partial write_zeroes
 # when the backing file contains zeros
@@ -74,7 +74,7 @@ echo
 echo == backing file contains non-zero data before write_zeroes ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Single cluster; non-zero data at the cluster start
 # ... | XX -- 00 -- | ...
@@ -97,7 +97,7 @@ echo
 echo == backing file contains non-zero data after write_zeroes ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Single cluster; non-zero data directly after request
 # ... | -- 00 XX -- | ...
@@ -120,7 +120,7 @@ echo
 echo == write_zeroes covers non-zero data ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # non-zero data at front of request
 # Backing file: -- XX -- --
@@ -160,7 +160,7 @@ echo
 echo == spanning two clusters, non-zero before request ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Two clusters; non-zero data before request:
 # 1. At cluster start:          32k: XX -- -- 00 | 00 -- -- --
@@ -190,7 +190,7 @@ echo
 echo == spanning two clusters, non-zero after request ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Two clusters; non-zero data after request:
 # 1. Directly after request:    32k: -- -- -- 00 | 00 XX -- --
@@ -220,7 +220,7 @@ echo
 echo == spanning two clusters, partially overwriting backing file ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Backing file: -- -- XX XX | XX XX -- --
 # Active layer: -- -- XX 00 | 00 XX -- --
@@ -239,7 +239,7 @@ echo
 echo == spanning multiple clusters, non-zero in first cluster ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Backing file: 64k: XX XX -- -- | -- -- -- -- | -- -- -- --
 # Active layer: 64k: XX XX 00 00 | 00 00 00 00 | 00 -- -- --
@@ -255,7 +255,7 @@ echo
 echo == spanning multiple clusters, non-zero in intermediate cluster ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Backing file: 64k: -- -- -- -- | -- XX XX -- | -- -- -- --
 # Active layer: 64k: -- -- 00 00 | 00 00 00 00 | 00 -- -- --
@@ -270,7 +270,7 @@ echo
 echo == spanning multiple clusters, non-zero in final cluster ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Backing file: 64k: -- -- -- -- | -- -- -- -- | -- -- XX XX
 # Active layer: 64k: -- -- 00 00 | 00 00 00 00 | 00 -- XX XX
@@ -286,7 +286,7 @@ echo
 echo == spanning multiple clusters, partially overwriting backing file ==
 
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Backing file: 64k: -- XX XX XX | XX XX XX XX | XX XX XX --
 # Active layer: 64k: -- XX 00 00 | 00 00 00 00 | 00 XX XX --
@@ -338,7 +338,7 @@ CLUSTER_SIZE=2048 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))
 # Write at the front: sector-wise, the request is:
 # backing: 128m... | -- --
 # active:  128m... | 00 -- -- --
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $size 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
@@ -346,7 +346,7 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 # Write at the back: sector-wise, the request is:
 # backing: 128m... | -- --
 # active:  128m... | -- -- -- 00
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
@@ -354,7 +354,7 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 # Write at middle: sector-wise, the request is:
 # backing: 128m... | -- --
 # active:  128m... | -- 00 00 --
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $((size + 512)) 1024" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
@@ -362,7 +362,7 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 # Write entire cluster: sector-wise, the request is:
 # backing: 128m... | -- --
 # active:  128m... | 00 00 00 00
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
@@ -373,7 +373,7 @@ $QEMU_IO -c "write -z $size 512" "$TEST_IMG.base" | _filter_qemu_io
 # Write at the front: sector-wise, the request is:
 # backing: 128m... | 00 00
 # active:  128m... | 00 -- -- --
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $size 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
@@ -381,7 +381,7 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 # Write at the back: sector-wise, the request is:
 # backing: 128m... | 00 00
 # active:  128m... | -- -- -- 00
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
@@ -389,7 +389,7 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 # Write at middle: sector-wise, the request is:
 # backing: 128m... | 00 00
 # active:  128m... | -- 00 00 --
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $((size + 512)) 1024" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
@@ -397,7 +397,7 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 # Write entire cluster: sector-wise, the request is:
 # backing: 128m... | 00 00
 # active:  128m... | 00 00 00 00
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -z $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
@@ -427,7 +427,7 @@ echo == unaligned image tail cluster, allocation required ==
 # Backing file: 128m... | XX --
 # Active layer: 128m... | -- -- 00 --
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -P 1 $((size)) 512" "$TEST_IMG.base" | _filter_qemu_io
 $QEMU_IO -c "write -z $((size + 1024)) 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "read -P 1 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
@@ -438,7 +438,7 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 # Backing file: 128m: ... | -- XX
 # Active layer: 128m: ... | 00 -- -- 00
 CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))
-_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $((size + 2048))
 $QEMU_IO -c "write -P 1 $((size + 512)) 512" "$TEST_IMG.base" | _filter_qemu_io
 $QEMU_IO -c "write -z $((size)) 512" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -c "read -P 0 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
index fa3673317f..4863e24838 100644
--- a/tests/qemu-iotests/154.out
+++ b/tests/qemu-iotests/154.out
@@ -2,7 +2,7 @@ QA output created by 154
 
 == backing file contains zeros ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 2048/2048 bytes at offset 0
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 10240
@@ -22,7 +22,7 @@ wrote 2048/2048 bytes at offset 27648
 
 == backing file contains non-zero data before write_zeroes ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 1024/1024 bytes at offset 32768
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1024/1024 bytes at offset 34816
@@ -49,7 +49,7 @@ read 2048/2048 bytes at offset 67584
 
 == backing file contains non-zero data after write_zeroes ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 1024/1024 bytes at offset 34816
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1024/1024 bytes at offset 33792
@@ -76,7 +76,7 @@ read 3072/3072 bytes at offset 40960
 
 == write_zeroes covers non-zero data ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 1024/1024 bytes at offset 5120
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 5120
@@ -113,7 +113,7 @@ read 4096/4096 bytes at offset 28672
 
 == spanning two clusters, non-zero before request ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 1024/1024 bytes at offset 32768
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 35840
@@ -155,7 +155,7 @@ read 5120/5120 bytes at offset 68608
 
 == spanning two clusters, non-zero after request ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 1024/1024 bytes at offset 37888
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 35840
@@ -197,7 +197,7 @@ read 1024/1024 bytes at offset 72704
 
 == spanning two clusters, partially overwriting backing file ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 4096/4096 bytes at offset 2048
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2048/2048 bytes at offset 3072
@@ -217,7 +217,7 @@ read 2048/2048 bytes at offset 6144
 
 == spanning multiple clusters, non-zero in first cluster ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 2048/2048 bytes at offset 65536
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 7168/7168 bytes at offset 67584
@@ -233,7 +233,7 @@ read 10240/10240 bytes at offset 67584
 
 == spanning multiple clusters, non-zero in intermediate cluster ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 2048/2048 bytes at offset 70656
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 7168/7168 bytes at offset 67584
@@ -246,7 +246,7 @@ read 12288/12288 bytes at offset 65536
 
 == spanning multiple clusters, non-zero in final cluster ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 2048/2048 bytes at offset 75776
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 7168/7168 bytes at offset 67584
@@ -262,7 +262,7 @@ read 2048/2048 bytes at offset 75776
 
 == spanning multiple clusters, partially overwriting backing file ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 10240/10240 bytes at offset 66560
 10 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 7168/7168 bytes at offset 67584
@@ -305,25 +305,25 @@ wrote 2048/2048 bytes at offset 134217728
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134219776, "depth": 0, "zero": true, "data": false}]
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134219264
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
@@ -331,25 +331,25 @@ wrote 2048/2048 bytes at offset 134217728
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134219264
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
@@ -377,7 +377,7 @@ read 1024/1024 bytes at offset 134217728
 
 == unaligned image tail cluster, allocation required ==
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 134218752
@@ -389,7 +389,7 @@ read 1536/1536 bytes at offset 134218240
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
 { "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 512/512 bytes at offset 134218240
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 134217728
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index cb371d4649..988f986144 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -60,9 +60,12 @@ class BaseClass(iotests.QMPTestCase):
 
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, back0_img, '1440K')
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back0_img, back1_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back1_img, back2_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back2_img, source_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', back0_img,
+                 '-F', iotests.imgfmt, back1_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', back1_img,
+                 '-F', iotests.imgfmt, back2_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', back2_img,
+                 '-F', iotests.imgfmt, source_img)
 
         self.vm = iotests.VM()
         # Add the BDS via blockdev-add so it stays around after the mirror block
@@ -89,7 +92,8 @@ class BaseClass(iotests.QMPTestCase):
         if self.existing:
             if self.target_backing:
                 qemu_img('create', '-f', iotests.imgfmt,
-                         '-b', self.target_backing, target_img, '1440K')
+                         '-b', self.target_backing, '-F', 'raw',
+                         target_img, '1440K')
             else:
                 qemu_img('create', '-f', iotests.imgfmt, target_img, '1440K')
 
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 5559df63a5..7c69a6c3fa 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -56,7 +56,7 @@ _unsupported_imgopts data_file
 
 # Create source disk
 TEST_IMG="$TEST_IMG.backing" _make_test_img 1M
-_make_test_img -b "$TEST_IMG.backing" 1M
+_make_test_img -b "$TEST_IMG.backing" -F $IMGFMT 1M
 
 $QEMU_IO -c 'write -P 1 0 256k' "$TEST_IMG.backing" | _filter_qemu_io
 $QEMU_IO -c 'write -P 2 64k 192k' "$TEST_IMG" | _filter_qemu_io
@@ -68,7 +68,7 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
 
 # Create snapshot
-TEST_IMG="$TEST_IMG.overlay" _make_test_img -u -b "$TEST_IMG" 1M
+TEST_IMG="$TEST_IMG.overlay" _make_test_img -u -b "$TEST_IMG" -F $IMGFMT 1M
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'blockdev-snapshot-sync',
        'arguments': { 'device': 'source',
@@ -85,7 +85,8 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
 
 # Create target image
-TEST_IMG="$TEST_IMG.target.overlay" _make_test_img -u -b "$TEST_IMG.target" 1M
+TEST_IMG="$TEST_IMG.target.overlay" _make_test_img -u -b "$TEST_IMG.target" \
+    -F $IMGFMT 1M
 
 # Mirror snapshot
 _send_qemu_cmd $QEMU_HANDLE \
@@ -111,7 +112,7 @@ _send_qemu_cmd $QEMU_HANDLE \
 # Copy source backing chain to the target before completing the job
 cp "$TEST_IMG.backing" "$TEST_IMG.target.backing"
 cp "$TEST_IMG" "$TEST_IMG.target"
-$QEMU_IMG rebase -u -b "$TEST_IMG.target.backing" "$TEST_IMG.target"
+$QEMU_IMG rebase -u -b "$TEST_IMG.target.backing" -F $IMGFMT "$TEST_IMG.target"
 
 # Complete block job
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index 084be5ad71..cce167b63f 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -1,20 +1,20 @@
 QA output created by 156
 Formatting 'TEST_DIR/t.IMGFMT.backing', fmt=IMGFMT size=1048576
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing backing_fmt=IMGFMT
 wrote 262144/262144 bytes at offset 0
 256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 196608/196608 bytes at offset 65536
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
-Formatting 'TEST_DIR/t.IMGFMT.overlay', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.overlay', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'source', 'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'format': 'IMGFMT', 'mode': 'existing' } }
 {"return": {}}
 { 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu-io source "write -P 3 128k 128k"' } }
 wrote 131072/131072 bytes at offset 131072
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
-Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.target
+Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.target backing_fmt=IMGFMT
 { 'execute': 'drive-mirror', 'arguments': { 'device': 'source', 'target': 'TEST_DIR/t.IMGFMT.target.overlay', 'mode': 'existing', 'sync': 'top' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "source"}}
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index ba4db6116a..3175968e2b 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -64,7 +64,7 @@ echo "== verify pattern =="
 $QEMU_IO --object $SECRET -c "read -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
 
 echo "== create overlay =="
-_make_test_img -u --object $SECRET -o "encryption=on,encrypt.key-secret=sec0" -b "$TEST_IMG_BASE" $size
+_make_test_img -u --object $SECRET -o "encryption=on,encrypt.key-secret=sec0" -b "$TEST_IMG_BASE" -F $IMGFMT $size
 
 echo
 echo "== writing part of a cluster =="
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
index 6def216e55..d999f51ec0 100644
--- a/tests/qemu-iotests/158.out
+++ b/tests/qemu-iotests/158.out
@@ -10,7 +10,7 @@ wrote 134217728/134217728 bytes at offset 0
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT encryption=on encrypt.key-secret=sec0
 
 == writing part of a cluster ==
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index f572a19af2..e270976d87 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -49,8 +49,8 @@ IMG_SIZE=1M
 
 # Create the images
 TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_imgfmt
-_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT | _filter_imgfmt
+_make_test_img -b "$TEST_IMG.int" -F $IMGFMT -F $IMGFMT | _filter_imgfmt
 
 # First test: reopen $TEST.IMG changing the detect-zeroes option on
 # its backing file ($TEST_IMG.int).
@@ -106,8 +106,8 @@ echo "*** Commit and then change an option on the backing file"
 echo
 # Create the images again
 TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_imgfmt
-_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT| _filter_imgfmt
+_make_test_img -b "$TEST_IMG.int" -F $IMGFMT | _filter_imgfmt
 
 _launch_qemu -drive if=none,file="${TEST_IMG}"
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/161.out b/tests/qemu-iotests/161.out
index aef9741ed3..3d8d89a9da 100644
--- a/tests/qemu-iotests/161.out
+++ b/tests/qemu-iotests/161.out
@@ -1,7 +1,7 @@
 QA output created by 161
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
-Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int
+Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int backing_fmt=IMGFMT
 
 *** Change an option on the backing file
 
@@ -29,8 +29,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 *** Commit and then change an option on the backing file
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
-Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int
+Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int backing_fmt=IMGFMT
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 { 'execute': 'block-commit', 'arguments': { 'device': 'none0', 'top': 'TEST_DIR/t.IMGFMT.int' } }
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 117c8b6954..2565ff12ee 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -84,8 +84,8 @@ echo
 
 len=$((2100 * 1024 * 1024 + 512)) # larger than 2G, and not cluster aligned
 TEST_IMG="$TEST_IMG.base" _make_test_img $len
-TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" $len
-_make_test_img -b "$TEST_IMG.itmd" $len
+TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT $len
+_make_test_img -b "$TEST_IMG.itmd" -F $IMGFMT $len
 # Update the top image to use a feature that is incompatible with fast path
 case $reason in
     snapshot) $QEMU_IMG snapshot -c snap "$TEST_IMG" ;;
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index cc33def96b..9d09b60452 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -3,8 +3,8 @@ QA output created by 176
 === Test pass snapshot.0 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -43,8 +43,8 @@ ID        TAG
 === Test pass snapshot.1 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -84,8 +84,8 @@ ID        TAG
 === Test pass snapshot.2 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -125,8 +125,8 @@ ID        TAG
 === Test pass snapshot.3 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -163,8 +163,8 @@ ID        TAG
 === Test pass bitmap.0 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 QMP_VERSION
 {"return": {}}
 {"return": {}}
@@ -212,8 +212,8 @@ QMP_VERSION
 === Test pass bitmap.1 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 QMP_VERSION
 {"return": {}}
 {"return": {}}
@@ -262,8 +262,8 @@ QMP_VERSION
 === Test pass bitmap.2 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 QMP_VERSION
 {"return": {}}
 {"return": {}}
@@ -312,8 +312,8 @@ QMP_VERSION
 === Test pass bitmap.3 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
 QMP_VERSION
 {"return": {}}
 {"return": {}}
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index eadc2c7ef6..5d4a77a6ab 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -51,7 +51,7 @@ echo "== setting up files =="
 
 TEST_IMG="$TEST_IMG.base" _make_test_img $size
 $QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG.base" | _filter_qemu_io
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 $QEMU_IO -c "write -P 22 0 $size" "$TEST_IMG" | _filter_qemu_io
 
 # Limited to 64k max-transfer
diff --git a/tests/qemu-iotests/177.out b/tests/qemu-iotests/177.out
index e887542678..ba1e1e212e 100644
--- a/tests/qemu-iotests/177.out
+++ b/tests/qemu-iotests/177.out
@@ -4,7 +4,7 @@ QA output created by 177
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 9372dc30ef..11a20cb1bf 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -49,7 +49,7 @@ echo '=== Testing write zeroes with unmap ==='
 echo
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 # Offsets chosen at or near 2M boundaries so test works at all cluster sizes
 # 8k and larger (smaller clusters fail due to non-contiguous allocations)
diff --git a/tests/qemu-iotests/179.out b/tests/qemu-iotests/179.out
index 80722b2289..1f7680002c 100644
--- a/tests/qemu-iotests/179.out
+++ b/tests/qemu-iotests/179.out
@@ -3,7 +3,7 @@ QA output created by 179
 === Testing write zeroes with unmap ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 2097152/2097152 bytes at offset 2097152
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 6291456
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index c9ce9d3bed..99a900c998 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -65,7 +65,7 @@ echo "== verify pattern =="
 $QEMU_IO --object $SECRET0 -c "read -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
 
 echo "== create overlay =="
-_make_test_img --object $SECRET1 -o "encrypt.format=luks,encrypt.key-secret=sec1,encrypt.iter-time=10" -u -b "$TEST_IMG_BASE" $size
+_make_test_img --object $SECRET1 -o "encrypt.format=luks,encrypt.key-secret=sec1,encrypt.iter-time=10" -u -b "$TEST_IMG_BASE" -F $IMGFMT $size
 
 echo
 echo "== writing part of a cluster =="
diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
index a0b7c9c24c..035068764f 100644
--- a/tests/qemu-iotests/189.out
+++ b/tests/qemu-iotests/189.out
@@ -10,7 +10,7 @@ wrote 16777216/16777216 bytes at offset 0
 read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
 
 == writing part of a cluster ==
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index b05db68141..d17462e1e4 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -54,8 +54,8 @@ echo
 
 TEST_IMG="${TEST_IMG}.base" _make_test_img $size
 TEST_IMG="${TEST_IMG}.mid" _make_test_img -o "backing_fmt=$IMGFMT" -b "${TEST_IMG}.base"
-_make_test_img -b "${TEST_IMG}.mid"
-TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
+_make_test_img -b "${TEST_IMG}.mid" -F $IMGFMT
+TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid" -F $IMGFMT
 
 $QEMU_IO -c 'write -P 0x55 1M 64k' "${TEST_IMG}.mid" | _filter_qemu_io
 
@@ -102,10 +102,10 @@ echo === Preparing and starting VM with -drive ===
 echo
 
 TEST_IMG="${TEST_IMG}.base" _make_test_img $size
-TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
-_make_test_img -b "${TEST_IMG}.mid"
-TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
-TEST_IMG="${TEST_IMG}.ovl3" _make_test_img -b "${TEST_IMG}.ovl2"
+TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base" -F $IMGFMT
+_make_test_img -b "${TEST_IMG}.mid" -F $IMGFMT
+TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid" -F $IMGFMT
+TEST_IMG="${TEST_IMG}.ovl3" _make_test_img -b "${TEST_IMG}.ovl2" -F $IMGFMT
 
 $QEMU_IO -c 'write -P 0x55 1M 64k' "${TEST_IMG}.mid" | _filter_qemu_io
 
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 34cec7b9ec..11aaf3b691 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -4,8 +4,8 @@ QA output created by 191
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
-Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 1048576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -413,10 +413,10 @@ backing file format: IMGFMT
 === Preparing and starting VM with -drive ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
-Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
-Formatting 'TEST_DIR/t.IMGFMT.ovl3', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.ovl2
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.ovl3', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.ovl2 backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 1048576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index 48984b7ac1..2351d55fe1 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -56,8 +56,8 @@ run_qemu()
 
 size=64M
 TEST_IMG="$TEST_IMG.base" _make_test_img $size
-TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
-_make_test_img -b "$TEST_IMG.mid"
+TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
+_make_test_img -b "$TEST_IMG.mid" -F $IMGFMT
 
 echo
 echo "Change backing file of mid (opened read-only)"
@@ -75,7 +75,7 @@ echo
 echo "Change backing file of top (opened writable)"
 echo
 
-TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
+TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 run_qemu -drive if=none,file="$TEST_IMG",node-name=top <<EOF
 {"execute":"qmp_capabilities"}
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
index e6df0d6781..ec84df5012 100644
--- a/tests/qemu-iotests/195.out
+++ b/tests/qemu-iotests/195.out
@@ -1,7 +1,7 @@
 QA output created by 195
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid backing_fmt=IMGFMT
 
 Change backing file of mid (opened read-only)
 
@@ -42,7 +42,7 @@ backing file format: IMGFMT
 
 Change backing file of top (opened writable)
 
-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,node-name=top
 {
     QMP_VERSION
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index fb0d5a29d3..33853df1c8 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -62,7 +62,7 @@ echo "== writing whole image base =="
 $QEMU_IO --object $SECRET0 -c "write -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
 
 echo "== create overlay =="
-_make_test_img --object $SECRET1 -o "encrypt.format=luks,encrypt.key-secret=sec1,encrypt.iter-time=10" -u -b "$TEST_IMG_BASE" $size
+_make_test_img --object $SECRET1 -o "encrypt.format=luks,encrypt.key-secret=sec1,encrypt.iter-time=10" -u -b "$TEST_IMG_BASE" -F $IMGFMT $size
 
 echo
 echo "== writing whole image layer =="
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 6280ae6eed..d306fb99ef 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -6,7 +6,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216 encrypt.format=luk
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
 
 == writing whole image layer ==
 wrote 16777216/16777216 bytes at offset 0
@@ -79,6 +79,7 @@ image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 16 MiB (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
 Format specific information:
     compression type: zlib
     encrypt:
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index abb73dc381..6770fa9b96 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -52,7 +52,7 @@ echo "== setting up files =="
 
 TEST_IMG="$TEST_IMG.base" _make_test_img $size
 $QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG.base" | _filter_qemu_io
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 $QEMU_IO -c "write -P 22 0 110M" "$TEST_IMG" | _filter_qemu_io
 
 # Limited to 64k max-transfer
diff --git a/tests/qemu-iotests/204.out b/tests/qemu-iotests/204.out
index f3a10fbe90..457f72df8f 100644
--- a/tests/qemu-iotests/204.out
+++ b/tests/qemu-iotests/204.out
@@ -4,7 +4,7 @@ QA output created by 204
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 115343360/115343360 bytes at offset 0
 110 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
index de11d85b5d..f93c61aad6 100755
--- a/tests/qemu-iotests/216
+++ b/tests/qemu-iotests/216
@@ -53,7 +53,7 @@ with iotests.FilePath('base.img') as base_img_path, \
     assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M') == 0
     assert qemu_io_silent(base_img_path, '-c', 'write -P 1 0M 1M') == 0
     assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
-                    top_img_path) == 0
+                    '-F', iotests.imgfmt, top_img_path) == 0
     assert qemu_io_silent(top_img_path,  '-c', 'write -P 2 1M 1M') == 0
 
     log('Done')
diff --git a/tests/qemu-iotests/224 b/tests/qemu-iotests/224
index 81ca1e4898..017b0685ba 100755
--- a/tests/qemu-iotests/224
+++ b/tests/qemu-iotests/224
@@ -49,9 +49,9 @@ for filter_node_name in False, True:
         assert qemu_img('create', '-f', iotests.imgfmt,
                         base_img_path, '64M') == 0
         assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
-                        mid_img_path) == 0
+                        '-F', iotests.imgfmt, mid_img_path) == 0
         assert qemu_img('create', '-f', iotests.imgfmt, '-b', mid_img_path,
-                        top_img_path) == 0
+                        '-F', iotests.imgfmt, top_img_path) == 0
 
         # Something to commit
         assert qemu_io_silent(mid_img_path, '-c', 'write -P 1 0 1M') == 0
diff --git a/tests/qemu-iotests/225 b/tests/qemu-iotests/225
index c9a334c7e9..0186ec8156 100755
--- a/tests/qemu-iotests/225
+++ b/tests/qemu-iotests/225
@@ -48,7 +48,7 @@ _unsupported_imgopts "subformat=monolithicFlat" \
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 1M
 TEST_IMG="$TEST_IMG.not_base" _make_test_img 1M
-_make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 
 make_opts()
 {
diff --git a/tests/qemu-iotests/225.out b/tests/qemu-iotests/225.out
index 4dc8ee282f..0998ae094c 100644
--- a/tests/qemu-iotests/225.out
+++ b/tests/qemu-iotests/225.out
@@ -1,7 +1,7 @@
 QA output created by 225
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
 Formatting 'TEST_DIR/t.IMGFMT.not_base', fmt=IMGFMT size=1048576
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 
 === Testing fitting VMDK backing image ===
 
diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index da0900fb82..60db986d84 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -56,7 +56,8 @@ with iotests.FilePath('base.img') as base_img_path, \
     assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M') == 0
     # Choose a funny way to describe the backing filename
     assert qemu_img('create', '-f', iotests.imgfmt, '-b',
-                    'file:' + base_img_path, top_img_path) == 0
+                    'file:' + base_img_path, '-F', iotests.imgfmt,
+                    top_img_path) == 0
 
     vm.launch()
 
@@ -171,7 +172,7 @@ with iotests.FilePath('base.img') as base_img_path, \
     # filename unless the backing file is opened implicitly with the
     # overlay)
     assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
-                    top_img_path) == 0
+                    '-F', iotests.imgfmt, top_img_path) == 0
 
     # You can only reliably override backing options by using a node
     # reference (or by specifying file.filename, but, well...)
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 4f5f0bb901..ad91a6f5b4 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -44,7 +44,8 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, hd_path[0], '3M')
-        qemu_img('create', '-f', iotests.imgfmt, '-b', hd_path[0], hd_path[1])
+        qemu_img('create', '-f', iotests.imgfmt, '-b', hd_path[0],
+                 '-F', iotests.imgfmt, hd_path[1])
         qemu_img('create', '-f', iotests.imgfmt, hd_path[2], '3M')
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xa0  0 1M', hd_path[0])
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xa1 1M 1M', hd_path[1])
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index 2b99c9789e..68f13ed328 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -49,8 +49,8 @@ IMG_SIZE=1M
 
 # Create the images: base <- int <- active
 TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_imgfmt
-_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT | _filter_imgfmt
+_make_test_img -b "$TEST_IMG.int" -F $IMGFMT | _filter_imgfmt
 
 # Launch QEMU with these two drives:
 # none0: base (read-only)
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
index 51307ed0f7..85acda4635 100644
--- a/tests/qemu-iotests/249.out
+++ b/tests/qemu-iotests/249.out
@@ -1,7 +1,7 @@
 QA output created by 249
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
-Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int
+Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int backing_fmt=IMGFMT
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 
diff --git a/tests/qemu-iotests/252 b/tests/qemu-iotests/252
index 83280c1715..6662f4c9de 100755
--- a/tests/qemu-iotests/252
+++ b/tests/qemu-iotests/252
@@ -101,7 +101,7 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 
 echo
 
-$QEMU_IMG rebase -b "$TEST_IMG.base_new" "$TEST_IMG"
+$QEMU_IMG rebase -b "$TEST_IMG.base_new" -F $IMGFMT "$TEST_IMG"
 
 # Verify the data is correct
 $QEMU_IO "$TEST_IMG" \
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 004a433b8b..e1e6077219 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -238,7 +238,8 @@ def compare_images(image, reference, baseimg=None, expected_match=True):
     """
     expected_ret = 0 if expected_match else 1
     if baseimg:
-        assert qemu_img("rebase", "-u", "-b", baseimg, image) == 0
+        assert qemu_img("rebase", "-u", "-b", baseimg, '-F', iotests.imgfmt,
+                        image) == 0
     ret = qemu_img("compare", image, reference)
     log('qemu_img compare "{:s}" "{:s}" ==> {:s}, {:s}'.format(
         image, reference,
diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index 3146273eef..e44be49c77 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -73,7 +73,7 @@ size=128M
 run_test()
 {
     if [ -n "$BACKING_FILE" ]; then
-        _make_test_img -b "$BACKING_FILE" $size
+        _make_test_img -b "$BACKING_FILE" -F $IMGFMT $size
     else
         _make_test_img $size
     fi
@@ -149,7 +149,7 @@ echo
 echo "=== -blockdev with NBD server on the backing file ==="
 echo
 
-_make_test_img -b "$TEST_IMG.base" $size
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
 cat <<EOF |
 nbd_server_start unix:$SOCK_DIR/nbd
 nbd_server_add -w backing-fmt
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 8dddb4baa4..d6d80c099f 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -128,7 +128,7 @@ ID        TAG                 VM SIZE                DATE       VM CLOCK
 === -blockdev with a backing file ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-file,node-name=fmt
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
@@ -139,7 +139,7 @@ ID        TAG                 VM SIZE                DATE       VM CLOCK
 (qemu) loadvm snap0
 (qemu) quit
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=IMGFMT,file=backing-file,node-name=backing-fmt -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-fmt,node-name=fmt
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
@@ -158,7 +158,7 @@ Internal snapshots on backing file:
 
 === -blockdev with NBD server on the backing file ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=IMGFMT,file=backing-file,node-name=backing-fmt -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-fmt,node-name=fmt
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) nbd_server_start unix:SOCK_DIR/nbd
diff --git a/tests/qemu-iotests/270 b/tests/qemu-iotests/270
index b9a12b908c..00339c0f78 100755
--- a/tests/qemu-iotests/270
+++ b/tests/qemu-iotests/270
@@ -53,7 +53,7 @@ $QEMU_IO -c 'write 0 512' "$TEST_IMG.base" | _filter_qemu_io
 # We need a large cluster size, see below for why (above the $QEMU_IO
 # invocation)
 _make_test_img -o cluster_size=2M,data_file="$TEST_IMG.orig" \
-    -b "$TEST_IMG.base" 4G
+    -b "$TEST_IMG.base" -F $IMGFMT 4G
 
 # We want a null-co as the data file, because it allows us to quickly
 # "write" 2G of data without using any space.
diff --git a/tests/qemu-iotests/270.out b/tests/qemu-iotests/270.out
index c7be111014..6dc3b23d5b 100644
--- a/tests/qemu-iotests/270.out
+++ b/tests/qemu-iotests/270.out
@@ -2,7 +2,7 @@ QA output created by 270
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=4294967296
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=TEST_DIR/t.IMGFMT.base data_file=TEST_DIR/t.IMGFMT.orig
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT data_file=TEST_DIR/t.IMGFMT.orig
 wrote 2147483136/2147483136 bytes at offset 768
 2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
diff --git a/tests/qemu-iotests/273 b/tests/qemu-iotests/273
index 00ff79bcf8..41ffbf39c4 100755
--- a/tests/qemu-iotests/273
+++ b/tests/qemu-iotests/273
@@ -56,8 +56,8 @@ run_qemu()
 }
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
-TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
-_make_test_img -b "$TEST_IMG.mid"
+TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
+_make_test_img -b "$TEST_IMG.mid" -F $IMGFMT
 
 run_qemu \
     -blockdev file,node-name=base,filename="$TEST_IMG.base" \
diff --git a/tests/qemu-iotests/273.out b/tests/qemu-iotests/273.out
index 684b8d6f77..87d4758503 100644
--- a/tests/qemu-iotests/273.out
+++ b/tests/qemu-iotests/273.out
@@ -1,7 +1,7 @@
 QA output created by 273
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid backing_fmt=IMGFMT
 Testing: -blockdev file,node-name=base,filename=TEST_DIR/t.IMGFMT.base -blockdev file,node-name=midf,filename=TEST_DIR/t.IMGFMT.mid -blockdev {"driver":"IMGFMT","node-name":"mid","file":"midf","backing":null} -blockdev file,node-name=topf,filename=TEST_DIR/t.IMGFMT -blockdev {"driver":"IMGFMT","file":"topf","node-name":"top","backing":null}
 {
     QMP_VERSION
diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
index 5d1bf34dff..d4571c5465 100755
--- a/tests/qemu-iotests/274
+++ b/tests/qemu-iotests/274
@@ -31,10 +31,10 @@ size_diff = size_long - size_short
 def create_chain() -> None:
     iotests.qemu_img_log('create', '-f', iotests.imgfmt, base,
                          str(size_long))
-    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, mid,
-                         str(size_short))
-    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', mid, top,
-                         str(size_long))
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base,
+                         '-F', iotests.imgfmt, mid, str(size_short))
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', mid,
+                         '-F', iotests.imgfmt, top, str(size_long))
 
     iotests.qemu_io_log('-c', 'write -P 1 0 %d' % size_long, base)
 
@@ -139,8 +139,8 @@ with iotests.FilePath('base') as base, \
 
         iotests.log('=== preallocation=%s ===' % prealloc)
         iotests.qemu_img_log('create', '-f', iotests.imgfmt, base, base_size)
-        iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, top,
-                             top_size_old)
+        iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base,
+                             '-F', iotests.imgfmt, top, top_size_old)
         iotests.qemu_io_log('-c', 'write -P 1 %s 64k' % off, base)
 
         # After this, top_size_old to base_size should be allocated/zeroed.
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
index d24ff681af..14d2042e26 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -1,9 +1,9 @@
 == Commit tests ==
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -50,6 +50,7 @@ file format: IMGFMT
 virtual size: 2 MiB (2097152 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/PID-base
+backing file format: IMGFMT
 Format specific information:
     compat: 1.1
     compression type: zlib
@@ -66,9 +67,9 @@ read 1048576/1048576 bytes at offset 1048576
 === Testing HMP commit (top -> mid) ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -80,6 +81,7 @@ file format: IMGFMT
 virtual size: 2 MiB (2097152 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/PID-base
+backing file format: IMGFMT
 Format specific information:
     compat: 1.1
     compression type: zlib
@@ -96,9 +98,9 @@ read 1048576/1048576 bytes at offset 1048576
 === Testing QMP active commit (top -> mid) ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -116,6 +118,7 @@ file format: IMGFMT
 virtual size: 2 MiB (2097152 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/PID-base
+backing file format: IMGFMT
 Format specific information:
     compat: 1.1
     compression type: zlib
@@ -133,7 +136,7 @@ read 1048576/1048576 bytes at offset 1048576
 === preallocation=off ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=6442450944 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=1073741824 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=1073741824 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 5368709120
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -152,7 +155,7 @@ read 65536/65536 bytes at offset 5368709120
 === preallocation=metadata ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=34359738368 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=32212254720 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=32212254720 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 33285996544
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -176,7 +179,7 @@ read 65536/65536 bytes at offset 33285996544
 === preallocation=falloc ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=10485760 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=5242880 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=5242880 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 9437184
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -195,7 +198,7 @@ read 65536/65536 bytes at offset 9437184
 === preallocation=full ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=16777216 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=8388608 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=8388608 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 11534336
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -214,7 +217,7 @@ read 65536/65536 bytes at offset 11534336
 === preallocation=off ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=393216 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=259072 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=259072 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 259072
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -234,7 +237,7 @@ read 65536/65536 bytes at offset 259072
 === preallocation=off ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=409600 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 344064
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -253,7 +256,7 @@ read 65536/65536 bytes at offset 344064
 === preallocation=off ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=524288 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
-Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=262144 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 
 wrote 65536/65536 bytes at offset 446464
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/279 b/tests/qemu-iotests/279
index 75a4747e6b..5515d4ed01 100755
--- a/tests/qemu-iotests/279
+++ b/tests/qemu-iotests/279
@@ -42,8 +42,8 @@ _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
-TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
-_make_test_img -b "$TEST_IMG.mid"
+TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
+_make_test_img -b "$TEST_IMG.mid" -F $IMGFMT
 
 echo
 echo '== qemu-img info --backing-chain =='
diff --git a/tests/qemu-iotests/279.out b/tests/qemu-iotests/279.out
index f4dc6c69cb..adb2e47a1a 100644
--- a/tests/qemu-iotests/279.out
+++ b/tests/qemu-iotests/279.out
@@ -1,7 +1,7 @@
 QA output created by 279
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid backing_fmt=IMGFMT
 
 == qemu-img info --backing-chain ==
 image: TEST_DIR/t.IMGFMT
diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 776b65e915..01ee14dcfb 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -71,7 +71,7 @@ $QEMU_IO -c 'write -P 0xff 0 128k' "$BACKING_IMG" | _filter_qemu_io
 
 for qcow2_compat in 0.10 1.1; do
     echo "# Create an image with compat=$qcow2_compat and a backing file"
-    _make_test_img -o "compat=$qcow2_compat" -b "$BACKING_IMG"
+    _make_test_img -o "compat=$qcow2_compat" -b "$BACKING_IMG" -F $IMGFMT
 
     echo "# Fill all clusters with data and then discard them"
     $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
index d2259c823b..22b476594f 100644
--- a/tests/qemu-iotests/290.out
+++ b/tests/qemu-iotests/290.out
@@ -34,7 +34,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=131072
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 # Create an image with compat=0.10 and a backing file
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 # Fill all clusters with data and then discard them
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -47,7 +47,7 @@ read 131072/131072 bytes at offset 0
 Offset          Length          Mapped to       File
 0               0x20000         0x50000         TEST_DIR/t.qcow2
 # Create an image with compat=1.1 and a backing file
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 # Fill all clusters with data and then discard them
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.25.4


