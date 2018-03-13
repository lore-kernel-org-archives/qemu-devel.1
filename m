Received: from eggs.gnu.org ([2001:4830:134:3::10]:46482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eviZj-0006ls-Nu
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eviZj-0006LF-1m
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:58:39 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 13 Mar 2018 19:58:14 +0800
Message-Id: <20180313115814.23774-3-famz@redhat.com>
In-Reply-To: <20180313115814.23774-1-famz@redhat.com>
References: <20180313115814.23774-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] iotests: Add regression test for commit
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
 tests/qemu-iotests/153     | 8 ++++++++
 tests/qemu-iotests/153.out | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index adfd02695b..a7875e6899 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -178,6 +178,14 @@ rm -f "${TEST_IMG}.lnk" &>/dev/null
 ln -s ${TEST_IMG} "${TEST_IMG}.lnk" || echo "Failed to create link"
 _run_qemu_with_images "${TEST_IMG}.lnk" "${TEST_IMG}"
 
+echo
+echo "== Active commit to intermediate layer should work when base in use =="
+_launch_qemu -drive format=$IMGFMT,file="${TEST_IMG}.a",id=drive0 \
+             -device virtio-blk,drive=drive0
+_run_cmd $QEMU_IMG commit -b "${TEST_IMG}.b" "${TEST_IMG}.c"
+
+_cleanup_qemu
+
 _launch_qemu
 
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 34309cfb20..28f8250dd2 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -372,6 +372,10 @@ Is another process using the image?
 == Symbolic link ==
 QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image?
+
+== Active commit to intermediate layer should work when base in use ==
+
+_qemu_img_wrapper commit -b TEST_DIR/t.qcow2.b TEST_DIR/t.qcow2.c
 {"return": {}}
 Adding drive
 
-- 
2.14.3
