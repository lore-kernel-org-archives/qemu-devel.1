Received: from eggs.gnu.org ([2001:4830:134:3::10]:51589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBq-0000EV-UU
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBp-0000SL-53
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Mar 2018 18:36:23 +0100
Message-Id: <20180320173632.25480-4-kwolf@redhat.com>
In-Reply-To: <20180320173632.25480-1-kwolf@redhat.com>
References: <20180320173632.25480-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 03/12] qemu-iotests: Test vdi image
 creation with QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/211     | 256 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/211.out |  98 +++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 355 insertions(+)
 create mode 100755 tests/qemu-iotests/211
 create mode 100644 tests/qemu-iotests/211.out

diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
new file mode 100755
index 0000000000..6bf1ca784c
--- /dev/null
+++ b/tests/qemu-iotests/211
@@ -0,0 +1,256 @@
+#!/bin/bash
+#
+# Test VDI and file image creation
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
+_supported_fmt vdi
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
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
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
+      "preallocation": "off"
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific | _filter_img_info --format-specific
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
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
+      "preallocation": "metadata"
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific | _filter_img_info --format-specific
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
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
+      "size": 562949819203584
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
+# 3. 2^63 - 512 (generally valid, but with the crypto header the file will
+#                exceed 63 bits)
+# 4. 0x1fffff8000000 (maximum image size for VDI)
+# 5. (one byte more than maximum image size for VDI)
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
+      "size": 562949819203585
+  }
+}
+{ "execute": "quit" }
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/211.out b/tests/qemu-iotests/211.out
new file mode 100644
index 0000000000..a570cec04f
--- /dev/null
+++ b/tests/qemu-iotests/211.out
@@ -0,0 +1,98 @@
+QA output created by 211
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
+[{ "start": 0, "length": 134217728, "depth": 0, "zero": true, "data": false}]
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
+[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": false}]
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
+[{ "start": 0, "length": 3072, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 3072, "length": 33551360, "depth": 0, "zero": true, "data": true, "offset": OFFSET}]
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
+virtual size: 512T (562949819203584 bytes)
+
+=== Invalid sizes ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Unsupported VDI image size (size is 0xfffffffffffffe00, max supported is 0x1fffff8000000)"}}
+{"error": {"class": "GenericError", "desc": "Unsupported VDI image size (size is 0x8000000000000000, max supported is 0x1fffff8000000)"}}
+{"error": {"class": "GenericError", "desc": "Unsupported VDI image size (size is 0x7ffffffffffffe00, max supported is 0x1fffff8000000)"}}
+{"error": {"class": "GenericError", "desc": "Unsupported VDI image size (size is 0x1fffff8000001, max supported is 0x1fffff8000000)"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0c2983f4cd..0d11d40aec 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -209,3 +209,4 @@
 208 rw auto quick
 209 rw auto quick
 210 rw auto
+211 rw auto quick
-- 
2.13.6
