Received: from eggs.gnu.org ([2001:4830:134:3::10]:32878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5aoI-00050F-IE
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5aoH-0001GB-78
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  3 May 2017 00:35:58 +0800
Message-Id: <20170502163558.7611-24-famz@redhat.com>
In-Reply-To: <20170502163558.7611-1-famz@redhat.com>
References: <20170502163558.7611-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v17 23/23] tests: Add POSIX image locking test
 case 182
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, famz@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/182     | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/182.out |  8 +++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 82 insertions(+)
 create mode 100755 tests/qemu-iotests/182
 create mode 100644 tests/qemu-iotests/182.out

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
new file mode 100755
index 0000000..ddc2f18
--- /dev/null
+++ b/tests/qemu-iotests/182
@@ -0,0 +1,73 @@
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
+_run_cmd()
+{
+    echo
+    (echo "$@"; "$@" 1>/dev/null) >&2 | _filter_testdir
+}
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
index 0000000..b4b8f77
--- /dev/null
+++ b/tests/qemu-iotests/182.out
@@ -0,0 +1,8 @@
+QA output created by 182
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432
+Starting QEMU
+
+Starting a second QEMU using the same image should fail
+qemu-system-x86_64: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0,file.locking=on: Failed to get "write" lock
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
2.9.3
