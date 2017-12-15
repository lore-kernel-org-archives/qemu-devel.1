Received: from eggs.gnu.org ([2001:4830:134:3::10]:59617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePkzU-0007L7-Hr
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePkzO-0001L8-S9
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:05:08 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 15 Dec 2017 16:04:46 +0800
Message-Id: <20171215080446.10671-3-famz@redhat.com>
In-Reply-To: <20171215080446.10671-1-famz@redhat.com>
References: <20171215080446.10671-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] iotests: Test creating overlay when guest
 running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/153     | 4 ++++
 tests/qemu-iotests/153.out | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index fa25eb24bd..22cb9c69a7 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -32,6 +32,7 @@ _cleanup()
 {
     _cleanup_test_img
     rm -f "${TEST_IMG}.base"
+    rm -f "${TEST_IMG}.overlay"
     rm -f "${TEST_IMG}.convert"
     rm -f "${TEST_IMG}.a"
     rm -f "${TEST_IMG}.b"
@@ -218,6 +219,9 @@ _send_qemu_cmd $QEMU_HANDLE \
 
 _run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
 
+echo "Creating overlay with qemu-img when the guest is running should be allowed"
+_run_cmd $QEMU_IMG create -f $IMGFMT -b "${TEST_IMG}" "${TEST_IMG}.overlay"
+
 echo "Closing the other"
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'human-monitor-command',
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 5b917b177c..8131180c49 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -390,6 +390,9 @@ _qemu_img_wrapper info TEST_DIR/t.qcow2
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image?
+Creating overlay with qemu-img when the guest is running should be allowed
+
+_qemu_img_wrapper create -f qcow2 -b TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.overlay
 Closing the other
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
-- 
2.14.3
