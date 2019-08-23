Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA83C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E462173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E462173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i19kT-0005jB-0A
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 09:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i19jX-0005Do-6h
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i19jV-0002cr-RI
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:36:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i19jS-0002Z1-Mc; Fri, 23 Aug 2019 09:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5DF67C05683F;
 Fri, 23 Aug 2019 13:35:57 +0000 (UTC)
Received: from thuth.com (ovpn-116-236.ams2.redhat.com [10.36.116.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1910D5DD63;
 Fri, 23 Aug 2019 13:35:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Date: Fri, 23 Aug 2019 15:35:52 +0200
Message-Id: <20190823133552.11680-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 23 Aug 2019 13:35:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] iotests: Check for enabled drivers before
 testing them
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 v2:
 - Update the check in _require_drivers() according to Max' suggestion
 - Remove superfluous check in test 081
 - Mark 120 to require "raw"
 - Replaced the check in 162 to use the new _require_drivers() function
 - Mark 186 to require "null-co"

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
 
 _supported_fmt qcow2
 _supported_proto file
+_require_drivers blkdebug blkverify
 
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
 
 do_run_qemu()
 {
@@ -55,9 +56,6 @@ run_qemu()
                           | _filter_qemu_io | _filter_generated_node_ids
 }
 
-test_quorum=$($QEMU_IMG --help|grep quorum)
-[ "$test_quorum" = "" ] && _supported_fmt quorum
-
 quorum="driver=raw,file.driver=quorum,file.vote-threshold=2"
 quorum="$quorum,file.children.0.file.filename=$TEST_DIR/1.raw"
 quorum="$quorum,file.children.1.file.filename=$TEST_DIR/2.raw"
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index ae02f27afe..c3cf66798a 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2 qed vdi vhdx vmdk vpc
 _supported_proto file
 _supported_os Linux
+_require_drivers blkdebug blkverify
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat" \
     "subformat=twoGbMaxExtentSparse"
 
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index e9b4fbb009..2931a7550f 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto file
 _unsupported_fmt luks
+_require_drivers raw
 
 _make_test_img 64M
 
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 4e5ed74fd5..2d719afbed 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -39,9 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
-
-test_ssh=$($QEMU_IMG --help | grep '^Supported formats:.* ssh\( \|$\)')
-[ "$test_ssh" = "" ] && _notrun "ssh support required"
+_require_drivers ssh
 
 echo
 echo '=== NBD ==='
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index cb0c181228..33dd8d2a4f 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -33,6 +33,7 @@ trap "exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_os Linux
+_require_drivers throttle
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 5f6b18c150..3ea0442d44 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
+_require_drivers null-co
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
     _notrun "Requires a PC machine"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 5502c3da2f..ee20be8920 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -520,5 +520,19 @@ _require_command()
     [ -x "$c" ] || _notrun "$1 utility required, skipped this test"
 }
 
+# Check that a set of drivers has been whitelisted in the QEMU binary
+#
+_require_drivers()
+{
+    available=$($QEMU -drive format=help | \
+                sed -e '/Supported formats:/!d' -e 's/Supported formats://')
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
-- 
2.18.1


