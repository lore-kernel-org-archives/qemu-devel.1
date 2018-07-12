Received: from eggs.gnu.org ([2001:4830:134:3::10]:56788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVn-0004hP-HR
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVk-00067k-FQ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 12 Jul 2018 18:31:46 +0200
Message-Id: <20180712163152.12521-2-kwolf@redhat.com>
In-Reply-To: <20180712163152.12521-1-kwolf@redhat.com>
References: <20180712163152.12521-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] iotests: 153: Fix dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

This step was left behind my mistake. As suggested by the echoed text,
the intention was to test two devices with the same image, with
different options. The behavior should be the same as two QEMU
processes. Complete it.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/153     |  2 ++
 tests/qemu-iotests/153.out | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 673813cd39..0daeb1b005 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -162,6 +162,7 @@ for opts1 in "" "read-only=on" "read-only=on,force-share=on"; do
     _cleanup_qemu
 done
 
+test_opts="read-only=off read-only=on read-only=on,force-share=on"
 for opt1 in $test_opts; do
     for opt2 in $test_opts; do
         echo
@@ -170,6 +171,7 @@ for opt1 in $test_opts; do
     done
 done
 
+echo
 echo "== Creating ${TEST_IMG}.[abc] ==" | _filter_testdir
 (
     $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}"
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 3492ba7a29..93eaf10486 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -369,6 +369,31 @@ _qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': force-share=on can only be used with read-only images
 
 Round done
+
+== Two devices with the same image (read-only=off - read-only=off) ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,read-only=off: Failed to get "write" lock
+Is another process using the image?
+
+== Two devices with the same image (read-only=off - read-only=on) ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,read-only=on: Failed to get shared "write" lock
+Is another process using the image?
+
+== Two devices with the same image (read-only=off - read-only=on,force-share=on) ==
+
+== Two devices with the same image (read-only=on - read-only=off) ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,read-only=off: Failed to get "write" lock
+Is another process using the image?
+
+== Two devices with the same image (read-only=on - read-only=on) ==
+
+== Two devices with the same image (read-only=on - read-only=on,force-share=on) ==
+
+== Two devices with the same image (read-only=on,force-share=on - read-only=off) ==
+
+== Two devices with the same image (read-only=on,force-share=on - read-only=on) ==
+
+== Two devices with the same image (read-only=on,force-share=on - read-only=on,force-share=on) ==
+
 == Creating TEST_DIR/t.qcow2.[abc] ==
 Formatting 'TEST_DIR/t.IMGFMT.a', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT
 Formatting 'TEST_DIR/t.IMGFMT.b', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT
-- 
2.13.6
