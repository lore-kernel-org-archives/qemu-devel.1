Received: from eggs.gnu.org ([2001:4830:134:3::10]:45715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEn-0003NS-Bb
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEj-0004Ny-4b
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:36:00 +0200
Message-Id: <20180326143600.7724-20-kwolf@redhat.com>
In-Reply-To: <20180326143600.7724-1-kwolf@redhat.com>
References: <20180326143600.7724-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/19] qemu-iotests: Test vhdx image creation
 with QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/213     | 349 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/213.out | 121 ++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 471 insertions(+)
 create mode 100755 tests/qemu-iotests/213
 create mode 100644 tests/qemu-iotests/213.out

diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
new file mode 100755
index 0000000000..3a00a0f6d6
--- /dev/null
+++ b/tests/qemu-iotests/213
@@ -0,0 +1,349 @@
+#!/bin/bash
+#
+# Test vhdx and file image creation
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
+owner=kwolf@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt vhdx
+_supported_proto file
+_supported_os Linux
+
+function do_run_qemu()
+{
+    echo Testing: "$@"
+    $QEMU -nographic -qmp stdio -serial none "$@"
+    echo
+}
+
+function run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
+                          | _filter_qemu | _filter_imgfmt \
+                          | _filter_actual_image_size
+}
+
+echo
+echo "=== Successful image creation (defaults) ==="
+echo
+
+size=$((128 * 1024 * 1024))
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "file",
+      "filename": "$TEST_IMG",
+      "size": 0
+  }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+      "driver": "file",
+      "node-name": "imgfile",
+      "filename": "$TEST_IMG"
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "imgfile",
+      "size": $size
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific | _filter_img_info --format-specific
+
+echo
+echo "=== Successful image creation (explicit defaults) ==="
+echo
+
+# Choose a different size to show that we got a new image
+size=$((64 * 1024 * 1024))
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "file",
+      "filename": "$TEST_IMG",
+      "size": 0
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG"
+      },
+      "size": $size,
+      "log-size": 1048576,
+      "block-size": 8388608,
+      "subformat": "dynamic",
+      "block-state-zero": true
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific | _filter_img_info --format-specific
+
+echo
+echo "=== Successful image creation (with non-default options) ==="
+echo
+
+# Choose a different size to show that we got a new image
+size=$((32 * 1024 * 1024))
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "file",
+      "filename": "$TEST_IMG",
+      "size": 0
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG"
+      },
+      "size": $size,
+      "log-size": 8388608,
+      "block-size": 268435456,
+      "subformat": "fixed",
+      "block-state-zero": false
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific | _filter_img_info --format-specific
+
+echo
+echo "=== Invalid BlockdevRef ==="
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "this doesn't exist",
+      "size": $size
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "=== Zero size ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 0
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info | _filter_img_info
+
+echo
+echo "=== Maximum size ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 70368744177664
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info | _filter_img_info
+
+echo
+echo "=== Invalid sizes ==="
+echo
+
+# TODO Negative image sizes aren't handled correctly, but this is a problem
+# with QAPI's implementation of the 'size' type and affects other commands as
+# well. Once this is fixed, we may want to add a test case here.
+
+# 1. 2^64 - 512
+# 2. 2^63 = 8 EB (qemu-img enforces image sizes less than this)
+# 3. 2^63 - 512 (generally valid, but with the image header the file will
+#                exceed 63 bits)
+# 4. 2^46 + 1 (one byte more than maximum image size)
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 18446744073709551104
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 9223372036854775808
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 9223372036854775296
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 70368744177665
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "=== Invalid block size ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "block-size": 1234567
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "block-size": 128
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "block-size": 3145728
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "block-size": 536870912
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "block-size": 0
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "=== Invalid log size ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "log-size": 1234567
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "log-size": 128
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "log-size": 4294967296
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "log-size": 0
+  }
+}
+{ "execute": "quit" }
+EOF
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/213.out b/tests/qemu-iotests/213.out
new file mode 100644
index 0000000000..8e8fc29cbc
--- /dev/null
+++ b/tests/qemu-iotests/213.out
@@ -0,0 +1,121 @@
+QA output created by 213
+
+=== Successful image creation (defaults) ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 128M (134217728 bytes)
+
+=== Successful image creation (explicit defaults) ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+
+=== Successful image creation (with non-default options) ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32M (33554432 bytes)
+
+=== Invalid BlockdevRef ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Cannot find device=this doesn't exist nor node_name=this doesn't exist"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+=== Zero size ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 0 (0 bytes)
+
+=== Maximum size ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64T (70368744177664 bytes)
+
+=== Invalid sizes ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Image size too large; max of 64TB"}}
+{"error": {"class": "GenericError", "desc": "Image size too large; max of 64TB"}}
+{"error": {"class": "GenericError", "desc": "Image size too large; max of 64TB"}}
+{"error": {"class": "GenericError", "desc": "Image size too large; max of 64TB"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+=== Invalid block size ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Block size must be a multiple of 1 MB"}}
+{"error": {"class": "GenericError", "desc": "Block size must be a multiple of 1 MB"}}
+{"error": {"class": "GenericError", "desc": "Block size must be a power of two"}}
+{"error": {"class": "GenericError", "desc": "Block size must not exceed 268435456"}}
+{"error": {"class": "GenericError", "desc": "Block size must be a multiple of 1 MB"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+=== Invalid log size ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Log size must be a multiple of 1 MB"}}
+{"error": {"class": "GenericError", "desc": "Log size must be a multiple of 1 MB"}}
+{"error": {"class": "GenericError", "desc": "Log size must be smaller than 4 GB"}}
+{"error": {"class": "GenericError", "desc": "Log size must be a multiple of 1 MB"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index f706346f86..52a80f3f9e 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -211,3 +211,4 @@
 210 rw auto
 211 rw auto quick
 212 rw auto quick
+213 rw auto quick
-- 
2.13.6
