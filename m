Received: from eggs.gnu.org ([2001:4830:134:3::10]:60196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbN1-0007TV-6u
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbN0-0002zA-0j
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  9 Jul 2018 20:58:27 +0200
Message-Id: <20180709185828.4248-7-mreitz@redhat.com>
In-Reply-To: <20180709185828.4248-1-mreitz@redhat.com>
References: <20180709185828.4248-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] iotests: Add VMDK backing file correlation
 test
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

This new test verifies that VMDK backing file reads fail when the
backing file has a non-matching CID.  This includes non-VMDK backing
files.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180702210721.4847-3-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/225     | 132 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/225.out |  24 +++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 157 insertions(+)
 create mode 100755 tests/qemu-iotests/225
 create mode 100644 tests/qemu-iotests/225.out

diff --git a/tests/qemu-iotests/225 b/tests/qemu-iotests/225
new file mode 100755
index 0000000000..f2ee715685
--- /dev/null
+++ b/tests/qemu-iotests/225
@@ -0,0 +1,132 @@
+#!/bin/bash
+#
+# Test vmdk backing file correlation
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
+owner=mreitz@redhat.com
+
+seq=$(basename $0)
+echo "QA output created by $seq"
+
+here=$PWD
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$TEST_IMG.not_base"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+# This tests vmdk-specific low-level functionality
+_supported_fmt vmdk
+_supported_proto file
+_supported_os Linux
+_unsupported_imgopts "subformat=monolithicFlat" \
+                     "subformat=twoGbMaxExtentFlat" \
+                     "subformat=twoGbMaxExtentSparse"
+
+TEST_IMG="$TEST_IMG.base" _make_test_img 1M
+TEST_IMG="$TEST_IMG.not_base" _make_test_img 1M
+_make_test_img -b "$TEST_IMG.base"
+
+make_opts()
+{
+    node_name=$1
+    filename=$2
+    backing=$3
+
+    if [ -z "$backing" ]; then
+        backing="null"
+    else
+        backing="'$backing'"
+    fi
+
+    echo "{ 'node-name': '$node_name',
+            'driver': 'vmdk',
+            'file': {
+                'driver': 'file',
+                'filename': '$filename'
+            },
+            'backing': $backing }"
+}
+
+overlay_opts=$(make_opts overlay "$TEST_IMG" backing)
+base_opts=$(make_opts backing "$TEST_IMG.base")
+not_base_opts=$(make_opts backing "$TEST_IMG.not_base")
+
+not_vmdk_opts="{ 'node-name': 'backing', 'driver': 'null-co' }"
+
+echo
+echo '=== Testing fitting VMDK backing image ==='
+echo
+
+qemu_comm_method=monitor \
+    _launch_qemu -blockdev "$base_opts" -blockdev "$overlay_opts"
+
+# Should not return an error
+_send_qemu_cmd $QEMU_HANDLE 'qemu-io overlay "read 0 512"' 'ops'
+
+_cleanup_qemu
+
+
+echo
+echo '=== Testing unrelated VMDK backing image ==='
+echo
+
+qemu_comm_method=monitor \
+    _launch_qemu -blockdev "$not_base_opts" -blockdev "$overlay_opts"
+
+# Should fail (gracefully)
+_send_qemu_cmd $QEMU_HANDLE 'qemu-io overlay "read 0 512"' 'failed'
+
+_cleanup_qemu
+
+
+echo
+echo '=== Testing non-VMDK backing image ==='
+echo
+
+# FIXME: This is the reason why we have to use two -blockdev
+# invocations.  You can only fully override the backing file options
+# if you either specify a node reference (as done here) or the new
+# options contain file.filename (which in this case they do not).
+# In other cases, file.filename will be set to whatever the image
+# header of the overlay contains (which we do not want).  I consider
+# this a FIXME because with -blockdev, you cannot specify "partial"
+# options, so setting file.filename but leaving the rest as specified
+# by the user does not make sense.
+qemu_comm_method=monitor \
+    _launch_qemu -blockdev "$not_vmdk_opts" -blockdev "$overlay_opts"
+
+# Should fail (gracefully)
+_send_qemu_cmd $QEMU_HANDLE 'qemu-io overlay "read 0 512"' 'failed'
+
+_cleanup_qemu
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/225.out b/tests/qemu-iotests/225.out
new file mode 100644
index 0000000000..4dc8ee282f
--- /dev/null
+++ b/tests/qemu-iotests/225.out
@@ -0,0 +1,24 @@
+QA output created by 225
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.not_base', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
+
+=== Testing fitting VMDK backing image ===
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io overlay "read 0 512"
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Testing unrelated VMDK backing image ===
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io overlay "read 0 512"
+read failed: Invalid argument
+
+=== Testing non-VMDK backing image ===
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io overlay "read 0 512"
+read failed: Invalid argument
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index af309ebba7..1c9f679821 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -222,3 +222,4 @@
 221 rw auto quick
 222 rw auto quick
 223 rw auto quick
+225 rw auto quick
-- 
2.17.1
