Received: from eggs.gnu.org ([2001:4830:134:3::10]:52849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmB-0004KT-0g
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNm9-0001cm-S9
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:31 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:45 +0200
Message-Id: <20180611142611.6609-4-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 03/29] iotests: Add creation test to 153
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This patch adds a test case to 153 which tries to overwrite an image
(using qemu-img create) while it is in use.  Without the original user
explicitly sharing the necessary permissions (writing and truncation),
this should not be allowed.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180509215336.31304-4-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/153     | 18 ++++++++++++++++++
 tests/qemu-iotests/153.out | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index ec508c758f..673813cd39 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -137,6 +137,24 @@ for opts1 in "" "read-only=on" "read-only=on,force-share=on"; do
         _run_cmd $QEMU_IMG dd          $L if="${TEST_IMG}" of="${TEST_IMG}.convert" bs=512 count=1
         _run_cmd $QEMU_IMG bench       $L -c 1 "${TEST_IMG}"
         _run_cmd $QEMU_IMG bench       $L -w -c 1 "${TEST_IMG}"
+
+        # qemu-img create does not support -U
+        if [ -z "$L" ]; then
+            _run_cmd $QEMU_IMG create -f $IMGFMT "${TEST_IMG}" \
+                                      -b ${TEST_IMG}.base
+            # Read the file format.  It used to be the case that
+            # file-posix simply truncated the file, but the qcow2
+            # driver then failed to format it because it was unable
+            # to acquire the necessary WRITE permission.  However, the
+            # truncation was already wrong, and the whole process
+            # resulted in the file being completely empty and thus its
+            # format would be detected to be raw.
+            # So we read it here to see that creation either completed
+            # successfully (thus the format is qcow2) or it aborted
+            # before the file was changed at all (thus the format stays
+            # qcow2).
+            _img_info -U | grep 'file format'
+        fi
     done
     _send_qemu_cmd $h "{ 'execute': 'quit', }" ""
     echo
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 2510762ba1..3492ba7a29 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -92,6 +92,11 @@ _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image?
 
+_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+qemu-img: TEST_DIR/t.qcow2: Failed to get "write" lock
+Is another process using the image?
+file format: IMGFMT
+
 == Running utility commands -U ==
 
 _qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
@@ -209,6 +214,11 @@ _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
 Is another process using the image?
 
+_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+qemu-img: TEST_DIR/t.qcow2: Failed to get "write" lock
+Is another process using the image?
+file format: IMGFMT
+
 == Running utility commands -U ==
 
 _qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
@@ -309,6 +319,9 @@ _qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
 
 _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
 
+_qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+file format: IMGFMT
+
 == Running utility commands -U ==
 
 _qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
-- 
2.17.1
