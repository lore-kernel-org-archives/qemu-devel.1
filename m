Received: from eggs.gnu.org ([2001:4830:134:3::10]:60306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euD5q-0001hi-KB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euD5p-0008Oh-QM
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:09:34 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  9 Mar 2018 16:09:10 +0800
Message-Id: <20180309080910.7274-5-famz@redhat.com>
In-Reply-To: <20180309080910.7274-1-famz@redhat.com>
References: <20180309080910.7274-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] iotests: Add regression test for commit
 base locking
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
 tests/qemu-iotests/153     | 6 ++++++
 tests/qemu-iotests/153.out | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index fa25eb24bd..5a82acebd3 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -177,6 +177,12 @@ rm -f "${TEST_IMG}.lnk" &>/dev/null
 ln -s ${TEST_IMG} "${TEST_IMG}.lnk" || echo "Failed to create link"
 _run_qemu_with_images "${TEST_IMG}.lnk" "${TEST_IMG}"
 
+echo
+echo "== Active commit to intermediate layer should work when base in use =="
+_launch_qemu -drive format=$IMGFMT,file="${TEST_IMG}.a",id=drive0 \
+             -device virtio-blk,drive=drive0
+_run_cmd $QEMU_IMG commit -b "${TEST_IMG}.b" "${TEST_IMG}.c"
+
 echo
 echo "== Closing an image should unlock it =="
 _launch_qemu
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 5b917b177c..60d2d661f1 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -373,6 +373,10 @@ Is another process using the image?
 QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image?
 
+== Active commit to intermediate layer should work when base in use ==
+
+_qemu_img_wrapper commit -b TEST_DIR/t.qcow2.b TEST_DIR/t.qcow2.c
+
 == Closing an image should unlock it ==
 {"return": {}}
 Adding drive
-- 
2.14.3
