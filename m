Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF89FECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989FD20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989FD20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNw1-0006Kp-T8
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNng-0006YP-IY
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNnf-0008MD-2G
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNnc-0008Jy-3J; Tue, 15 Oct 2019 10:27:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56E00308624A;
 Tue, 15 Oct 2019 14:27:43 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E933A1001947;
 Tue, 15 Oct 2019 14:27:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 04/21] iotests: Filter refcount_order in 036
Date: Tue, 15 Oct 2019 16:27:12 +0200
Message-Id: <20191015142729.18123-5-mreitz@redhat.com>
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 15 Oct 2019 14:27:43 +0000 (UTC)
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

This test can run just fine with other values for refcount_bits, so we
should filter the value from qcow2.py's dump-header.  In fact, we can
filter everything but the feature bits and header extensions, because
that is what the test is about.

(036 currently ignores user-specified image options, but that will be
fixed in the next patch.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/036     |  9 ++++---
 tests/qemu-iotests/036.out | 48 --------------------------------------
 2 files changed, 6 insertions(+), 51 deletions(-)

diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index f06ff67408..5f929ad3be 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -55,7 +55,8 @@ $PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatib=
le 63
=20
 # Without feature table
 $PYTHON qcow2.py "$TEST_IMG" del-header-ext 0x6803f857
-$PYTHON qcow2.py "$TEST_IMG" dump-header
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep features
+$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
 _img_info
=20
 # With feature table containing bit 63
@@ -103,14 +104,16 @@ echo =3D=3D=3D Create image with unknown autoclear =
feature bit =3D=3D=3D
 echo
 _make_test_img 64M
 $PYTHON qcow2.py "$TEST_IMG" set-feature-bit autoclear 63
-$PYTHON qcow2.py "$TEST_IMG" dump-header
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep features
+$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
=20
 echo
 echo =3D=3D=3D Repair image =3D=3D=3D
 echo
 _check_test_img -r all
=20
-$PYTHON qcow2.py "$TEST_IMG" dump-header
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep features
+$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
=20
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index 15229a9604..0b52b934e1 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -3,25 +3,9 @@ QA output created by 036
 =3D=3D=3D Image with unknown incompatible feature bit =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-magic                     0x514649fb
-version                   3
-backing_file_offset       0x0
-backing_file_size         0x0
-cluster_bits              16
-size                      67108864
-crypt_method              0
-l1_size                   1
-l1_table_offset           0x30000
-refcount_table_offset     0x10000
-refcount_table_clusters   1
-nb_snapshots              0
-snapshot_offset           0x0
 incompatible_features     [63]
 compatible_features       []
 autoclear_features        []
-refcount_order            4
-header_length             104
-
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature=
(s): Unknown incompatible feature: 8000000000000000
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature=
(s): Test feature
=20
@@ -37,25 +21,9 @@ qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsuppor=
ted IMGFMT feature(s): tes
 =3D=3D=3D Create image with unknown autoclear feature bit =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-magic                     0x514649fb
-version                   3
-backing_file_offset       0x0
-backing_file_size         0x0
-cluster_bits              16
-size                      67108864
-crypt_method              0
-l1_size                   1
-l1_table_offset           0x30000
-refcount_table_offset     0x10000
-refcount_table_clusters   1
-nb_snapshots              0
-snapshot_offset           0x0
 incompatible_features     []
 compatible_features       []
 autoclear_features        [63]
-refcount_order            4
-header_length             104
-
 Header extension:
 magic                     0x6803f857
 length                    192
@@ -65,25 +33,9 @@ data                      <binary>
 =3D=3D=3D Repair image =3D=3D=3D
=20
 No errors were found on the image.
-magic                     0x514649fb
-version                   3
-backing_file_offset       0x0
-backing_file_size         0x0
-cluster_bits              16
-size                      67108864
-crypt_method              0
-l1_size                   1
-l1_table_offset           0x30000
-refcount_table_offset     0x10000
-refcount_table_clusters   1
-nb_snapshots              0
-snapshot_offset           0x0
 incompatible_features     []
 compatible_features       []
 autoclear_features        []
-refcount_order            4
-header_length             104
-
 Header extension:
 magic                     0x6803f857
 length                    192
--=20
2.21.0


