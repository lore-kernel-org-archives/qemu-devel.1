Received: from eggs.gnu.org ([2001:4830:134:3::10]:56763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVk-0004gY-8y
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVj-00066w-06
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 12 Jul 2018 18:31:50 +0200
Message-Id: <20180712163152.12521-6-kwolf@redhat.com>
In-Reply-To: <20180712163152.12521-1-kwolf@redhat.com>
References: <20180712163152.12521-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] iotests: add test 226 for file driver types
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

From: John Snow <jsnow@redhat.com>

Test that we're rejecting what we ought to for file,
host_driver and host_cdrom drivers. Test that we're
seeing the deprecated message for block and chardevs
on the file driver.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/226     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/226.out | 26 ++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 93 insertions(+)
 create mode 100755 tests/qemu-iotests/226
 create mode 100644 tests/qemu-iotests/226.out

diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
new file mode 100755
index 0000000000..460aea2fc9
--- /dev/null
+++ b/tests/qemu-iotests/226
@@ -0,0 +1,66 @@
+#!/bin/bash
+#
+# This test covers expected filetypes for the file, host_cdrom and
+# host_device drivers.
+#
+# Copyright (C) 2018 Red Hat, Inc.
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
+owner=jsnow@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1    # failure is the default!
+
+_cleanup()
+{
+    rmdir "$TEST_IMG"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.pattern
+
+# Generic format, but tests file-protocol specific error handling
+_supported_fmt generic
+_supported_proto file
+_supported_os Linux
+
+# Create something decidedly not a file, blockdev or chardev...
+mkdir "$TEST_IMG"
+
+for PROTO in "file" "host_device" "host_cdrom"; do
+    echo
+    echo "=== Testing with driver:$PROTO ==="
+    echo
+    echo "== Testing RO =="
+    $QEMU_IO -c "open -r -o driver=$PROTO,filename=$TEST_IMG" 2>&1 | _filter_imgfmt | _filter_testdir
+    $QEMU_IO -c "open -r -o driver=$PROTO,filename=/dev/null" 2>&1 | _filter_imgfmt
+    echo "== Testing RW =="
+    $QEMU_IO -c "open -o driver=$PROTO,filename=$TEST_IMG" 2>&1 | _filter_imgfmt | _filter_testdir
+    $QEMU_IO -c "open -o driver=$PROTO,filename=/dev/null" 2>&1 | _filter_imgfmt
+done
+
+# success, all done
+echo
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/226.out b/tests/qemu-iotests/226.out
new file mode 100644
index 0000000000..8c0d060ffc
--- /dev/null
+++ b/tests/qemu-iotests/226.out
@@ -0,0 +1,26 @@
+QA output created by 226
+
+=== Testing with driver:file ===
+
+== Testing RO ==
+can't open: A regular file was expected by the 'file' driver, but something else was given
+warning: Opening a character device as a file using the 'file' driver is deprecated
+== Testing RW ==
+can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+warning: Opening a character device as a file using the 'file' driver is deprecated
+
+=== Testing with driver:host_device ===
+
+== Testing RO ==
+can't open: 'host_device' driver expects either a character or block device
+== Testing RW ==
+can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+
+=== Testing with driver:host_cdrom ===
+
+== Testing RO ==
+can't open: 'host_cdrom' driver expects either a character or block device
+== Testing RW ==
+can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1c9f679821..68f66259b2 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -223,3 +223,4 @@
 222 rw auto quick
 223 rw auto quick
 225 rw auto quick
+226 auto quick
-- 
2.13.6
