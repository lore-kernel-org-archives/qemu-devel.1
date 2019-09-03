Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D23C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD48623697
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD48623697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59Bf-0001Nm-1C
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i58z3-0002lZ-OX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i58z2-0006nx-CI
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i58yz-0006h6-3z; Tue, 03 Sep 2019 09:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A5BC18927A4;
 Tue,  3 Sep 2019 13:36:28 +0000 (UTC)
Received: from localhost (ovpn-204-98.brq.redhat.com [10.40.204.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0426B5D6B2;
 Tue,  3 Sep 2019 13:36:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 15:35:51 +0200
Message-Id: <20190903133553.6500-15-mreitz@redhat.com>
In-Reply-To: <20190903133553.6500-1-mreitz@redhat.com>
References: <20190903133553.6500-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 03 Sep 2019 13:36:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 14/16] iotests: Check for enabled drivers
 before testing them
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

It is possible to enable only a subset of the block drivers with the
"--block-drv-rw-whitelist" option of the "configure" script. All other
drivers are marked as unusable (or only included as read-only with the
"--block-drv-ro-whitelist" option). If an iotest is now using such a
disabled block driver, it is failing - which is bad, since at least the
tests in the "auto" group should be able to deal with this situation.
Thus let's introduce a "_require_drivers" function that can be used by
the shell tests to check for the availability of certain drivers first,
and marks the test as "not run" if one of the drivers is missing.

This patch mainly targets the test in the "auto" group which should
never fail in such a case, but also improves some of the other tests
along the way. Note that we also assume that the "qcow2" and "file"
drivers are always available - otherwise it does not make sense to
run "make check-block" at all (which only tests with qcow2 by default).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20190823133552.11680-1-thuth@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/071       |  1 +
 tests/qemu-iotests/081       |  4 +---
 tests/qemu-iotests/099       |  1 +
 tests/qemu-iotests/120       |  1 +
 tests/qemu-iotests/162       |  4 +---
 tests/qemu-iotests/184       |  1 +
 tests/qemu-iotests/186       |  1 +
 tests/qemu-iotests/common.rc | 14 ++++++++++++++
 8 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 1cca9233d0..fab526666b 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
+_require_drivers blkdebug blkverify
=20
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index c418bab093..85acdf76d4 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
+_require_drivers quorum
=20
 do_run_qemu()
 {
@@ -55,9 +56,6 @@ run_qemu()
                           | _filter_qemu_io | _filter_generated_node_ids
 }
=20
-test_quorum=3D$($QEMU_IMG --help|grep quorum)
-[ "$test_quorum" =3D "" ] && _supported_fmt quorum
-
 quorum=3D"driver=3Draw,file.driver=3Dquorum,file.vote-threshold=3D2"
 quorum=3D"$quorum,file.children.0.file.filename=3D$TEST_DIR/1.raw"
 quorum=3D"$quorum,file.children.1.file.filename=3D$TEST_DIR/2.raw"
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index ae02f27afe..c3cf66798a 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2 qed vdi vhdx vmdk vpc
 _supported_proto file
 _supported_os Linux
+_require_drivers blkdebug blkverify
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat" \
     "subformat=3DtwoGbMaxExtentSparse"
=20
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index e9b4fbb009..2931a7550f 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto file
 _unsupported_fmt luks
+_require_drivers raw
=20
 _make_test_img 64M
=20
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 4e5ed74fd5..2d719afbed 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -39,9 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt generic
-
-test_ssh=3D$($QEMU_IMG --help | grep '^Supported formats:.* ssh\( \|$\)'=
)
-[ "$test_ssh" =3D "" ] && _notrun "ssh support required"
+_require_drivers ssh
=20
 echo
 echo '=3D=3D=3D NBD =3D=3D=3D'
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index cb0c181228..33dd8d2a4f 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -33,6 +33,7 @@ trap "exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_os Linux
+_require_drivers throttle
=20
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 5f6b18c150..3ea0442d44 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
+_require_drivers null-co
=20
 if [ "$QEMU_DEFAULT_MACHINE" !=3D "pc" ]; then
     _notrun "Requires a PC machine"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 5502c3da2f..ee20be8920 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -520,5 +520,19 @@ _require_command()
     [ -x "$c" ] || _notrun "$1 utility required, skipped this test"
 }
=20
+# Check that a set of drivers has been whitelisted in the QEMU binary
+#
+_require_drivers()
+{
+    available=3D$($QEMU -drive format=3Dhelp | \
+                sed -e '/Supported formats:/!d' -e 's/Supported formats:=
//')
+    for driver
+    do
+        if ! echo "$available" | grep -q " $driver\( \|$\)"; then
+            _notrun "$driver not available"
+        fi
+    done
+}
+
 # make sure this script returns success
 true
--=20
2.21.0


