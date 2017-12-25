Received: from eggs.gnu.org ([2001:4830:134:3::10]:33147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTIrH-0007tv-AS
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTIrG-0005DP-BT
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:51:19 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon, 25 Dec 2017 10:51:07 +0800
Message-Id: <20171225025107.23985-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] iotests: Test creating overlay when guest
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
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>

---

v2: Actually test the thing. [Kevin]
---
 tests/qemu-iotests/153     | 8 +++++---
 tests/qemu-iotests/153.out | 7 ++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index fa25eb24bd..adfd02695b 100755
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
@@ -177,8 +178,6 @@ rm -f "${TEST_IMG}.lnk" &>/dev/null
 ln -s ${TEST_IMG} "${TEST_IMG}.lnk" || echo "Failed to create link"
 _run_qemu_with_images "${TEST_IMG}.lnk" "${TEST_IMG}"
 
-echo
-echo "== Closing an image should unlock it =="
 _launch_qemu
 
 _send_qemu_cmd $QEMU_HANDLE \
@@ -193,7 +192,10 @@ _send_qemu_cmd $QEMU_HANDLE \
 
 _run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
 
-echo "Closing drive"
+echo "Creating overlay with qemu-img when the guest is running should be allowed"
+_run_cmd $QEMU_IMG create -f $IMGFMT -b "${TEST_IMG}" "${TEST_IMG}.overlay"
+
+echo "== Closing an image should unlock it =="
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'human-monitor-command',
        'arguments': { 'command-line': 'drive_del d0' } }" \
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 5b917b177c..34309cfb20 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -372,15 +372,16 @@ Is another process using the image?
 == Symbolic link ==
 QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image?
-
-== Closing an image should unlock it ==
 {"return": {}}
 Adding drive
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image?
-Closing drive
+Creating overlay with qemu-img when the guest is running should be allowed
+
+_qemu_img_wrapper create -f qcow2 -b TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.overlay
+== Closing an image should unlock it ==
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 Adding two and closing one
-- 
2.14.3
