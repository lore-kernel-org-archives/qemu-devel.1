Received: from eggs.gnu.org ([2001:4830:134:3::10]:36532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAB-0001tr-Ll
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAA-00075F-Fb
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:55 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:26 +0200
Message-Id: <1494513181-7900-24-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 23/58] tests: Add POSIX image locking test case
 182
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/182     | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/182.out |  8 ++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 77 insertions(+)
 create mode 100755 tests/qemu-iotests/182
 create mode 100644 tests/qemu-iotests/182.out

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
new file mode 100755
index 0000000..7ecbb22
--- /dev/null
+++ b/tests/qemu-iotests/182
@@ -0,0 +1,68 @@
+#!/bin/bash
+#
+# Test image locking for POSIX locks
+#
+# Copyright 2017 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=famz@redhat.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+here="$PWD"
+tmp=/tmp/$$
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+size=32M
+
+_make_test_img $size
+
+echo "Starting QEMU"
+_launch_qemu -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
+    -device virtio-blk-pci,drive=drive0
+
+echo
+echo "Starting a second QEMU using the same image should fail"
+echo 'quit' | $QEMU -monitor stdio \
+    -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
+    -device virtio-blk-pci,drive=drive0 2>&1 | _filter_testdir 2>&1 |
+    _filter_qemu |
+    sed -e '/falling back to POSIX file/d' \
+        -e '/locks can be lost unexpectedly/d'
+
+_cleanup_qemu
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
new file mode 100644
index 0000000..23a4dbf
--- /dev/null
+++ b/tests/qemu-iotests/182.out
@@ -0,0 +1,8 @@
+QA output created by 182
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432
+Starting QEMU
+
+Starting a second QEMU using the same image should fail
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0,file.locking=on: Failed to get "write" lock
+Is another process using the image?
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index c8ae60e..a4549d8 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -171,3 +171,4 @@
 175 auto quick
 176 rw auto backing
 181 rw auto migration
+182 rw auto quick
-- 
1.8.3.1
