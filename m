Received: from eggs.gnu.org ([2001:4830:134:3::10]:59768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdQ-0001gW-R7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdP-0004nL-U6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:54 +0100
Message-Id: <20180313161803.1814-33-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 32/41] iotests: Add regression test for commit
 base locking
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

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/153     | 12 ++++++++++++
 tests/qemu-iotests/153.out |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index adfd02695b..a0fd815483 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -178,6 +178,18 @@ rm -f "${TEST_IMG}.lnk" &>/dev/null
 ln -s ${TEST_IMG} "${TEST_IMG}.lnk" || echo "Failed to create link"
 _run_qemu_with_images "${TEST_IMG}.lnk" "${TEST_IMG}"
 
+echo
+echo "== Active commit to intermediate layer should work when base in use =="
+_launch_qemu -drive format=$IMGFMT,file="${TEST_IMG}.a",id=drive0,if=none \
+             -device virtio-blk,drive=drive0
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+_run_cmd $QEMU_IMG commit -b "${TEST_IMG}.b" "${TEST_IMG}.c"
+
+_cleanup_qemu
+
 _launch_qemu
 
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 34309cfb20..bb721cb747 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -372,6 +372,11 @@ Is another process using the image?
 == Symbolic link ==
 QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image?
+
+== Active commit to intermediate layer should work when base in use ==
+{"return": {}}
+
+_qemu_img_wrapper commit -b TEST_DIR/t.qcow2.b TEST_DIR/t.qcow2.c
 {"return": {}}
 Adding drive
 
-- 
2.13.6
