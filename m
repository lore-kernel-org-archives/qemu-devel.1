Received: from eggs.gnu.org ([2001:4830:134:3::10]:59848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhgC-00058U-4w
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhg9-0001le-Mm
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:37:40 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Mar 2018 18:37:10 +0100
Message-Id: <20180321173714.14741-9-kwolf@redhat.com>
In-Reply-To: <20180321173714.14741-1-kwolf@redhat.com>
References: <20180321173714.14741-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 v2 08/12] qemu-iotests: Test parallels
 image creation with QMP
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
 tests/qemu-iotests/212     | 326 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/212.out | 111 +++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 438 insertions(+)
 create mode 100755 tests/qemu-iotests/212
 create mode 100644 tests/qemu-iotests/212.out

diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
new file mode 100755
index 0000000000..e5a1ba77ce
--- /dev/null
+++ b/tests/qemu-iotests/212
@@ -0,0 +1,326 @@
+#!/bin/bash
+#
+# Test parallels and file image creation
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
+_supported_fmt parallels
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
+      "cluster-size": 1048576
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
+      "cluster-size": 65536
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
+      "size": 4503599627369984
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
+# 1. Misaligned image size
+# 2. 2^64 - 512
+# 3. 2^63 = 8 EB (qemu-img enforces image sizes less than this)
+# 4. 2^63 - 512 (generally valid, but with the image header the file will
+#                exceed 63 bits)
+# 5. 2^52 (512 bytes more than maximum image size)
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 1234
+  }
+}
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
+      "size": 4503599627370497
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "=== Invalid cluster size ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "cluster-size": 1234
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "cluster-size": 128
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "cluster-size": 4294967296
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "cluster-size": 9223372036854775808
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "cluster-size": 18446744073709551104
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "cluster-size": 0
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 281474976710656,
+      "cluster-size": 512
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
diff --git a/tests/qemu-iotests/212.out b/tests/qemu-iotests/212.out
new file mode 100644
index 0000000000..587de6fad0
--- /dev/null
+++ b/tests/qemu-iotests/212.out
@@ -0,0 +1,111 @@
+QA output created by 212
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
+virtual size: 4096T (4503599627369984 bytes)
+
+=== Invalid sizes ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Image size must be a multiple of 512 bytes"}}
+{"error": {"class": "GenericError", "desc": "Image size is too large for this cluster size"}}
+{"error": {"class": "GenericError", "desc": "Image size is too large for this cluster size"}}
+{"error": {"class": "GenericError", "desc": "Image size is too large for this cluster size"}}
+{"error": {"class": "GenericError", "desc": "Image size is too large for this cluster size"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+=== Invalid cluster size ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Cluster size must be a multiple of 512 bytes"}}
+{"error": {"class": "GenericError", "desc": "Cluster size must be a multiple of 512 bytes"}}
+{"error": {"class": "GenericError", "desc": "Cluster size is too large"}}
+{"error": {"class": "GenericError", "desc": "Cluster size is too large"}}
+{"error": {"class": "GenericError", "desc": "Cluster size is too large"}}
+{"error": {"class": "GenericError", "desc": "Image size is too large for this cluster size"}}
+{"error": {"class": "GenericError", "desc": "Image size is too large for this cluster size"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0d11d40aec..f706346f86 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -210,3 +210,4 @@
 209 rw auto quick
 210 rw auto
 211 rw auto quick
+212 rw auto quick
-- 
2.13.6
