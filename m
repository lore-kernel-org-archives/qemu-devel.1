Received: from eggs.gnu.org ([2001:4830:134:3::10]:49690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGI7j-00063M-Ed
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGI7h-0001No-Eg
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:58:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  9 May 2018 13:58:02 +0800
Message-Id: <20180509055802.28423-6-famz@redhat.com>
In-Reply-To: <20180509055802.28423-1-famz@redhat.com>
References: <20180509055802.28423-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] iotests: Add VMDK tests for blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/214     | 268 +++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/214.out | 304 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 573 insertions(+)
 create mode 100755 tests/qemu-iotests/214
 create mode 100644 tests/qemu-iotests/214.out

diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
new file mode 100755
index 0000000000..d089859b7f
--- /dev/null
+++ b/tests/qemu-iotests/214
@@ -0,0 +1,268 @@
+#!/bin/bash
+#
+# Test vmdk and file image creation
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
+owner=famz@redhat.com
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
+_supported_fmt vmdk
+_supported_proto file
+_supported_os Linux
+
+function do_run_qemu()
+{
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
+size=$((5 * 1024 * 1024 * 1024))
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
+      "extents": [],
+      "subformat": "monolithicsparse",
+      "adapter-type": "ide",
+      "hwversion": "4",
+      "zeroed-grain": false
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
+      "extents": [],
+      "subformat": "monolithicsparse",
+      "adapter-type": "buslogic",
+      "zeroed-grain": true
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
+echo "=== Other subformats ==="
+echo
+
+TEST_IMG="$TEST_IMG.1" _make_test_img 0
+TEST_IMG="$TEST_IMG.2" _make_test_img 0
+TEST_IMG="$TEST_IMG.3" _make_test_img 0
+
+echo
+echo "== Missing extent =="
+run_qemu \
+    -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": $size,
+      "subformat": "monolithicflat"
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "== Correct extent =="
+run_qemu \
+    -blockdev driver=file,filename="$TEST_IMG",node-name=node0 \
+    -blockdev driver=file,filename="$TEST_IMG.1",node-name=ext1 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": $size,
+      "subformat": "monolithicflat",
+      "extents": ["ext1"]
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "== Extra extent =="
+run_qemu \
+    -blockdev driver=file,filename="$TEST_IMG",node-name=node0 \
+    -blockdev driver=file,filename="$TEST_IMG.1",node-name=ext1 \
+    -blockdev driver=file,filename="$TEST_IMG.2",node-name=ext2 \
+    -blockdev driver=file,filename="$TEST_IMG.3",node-name=ext3 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 512,
+      "subformat": "monolithicflat",
+      "extents": ["ext1", "ext2", "ext3"]
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "== Split formats =="
+echo
+
+for size in 512 1073741824 2147483648 5368709120; do
+    for subfmt in twogbmaxextentflat twogbmaxextentsparse; do
+        echo
+        echo "= $subfmt $size ="
+        echo
+        run_qemu \
+            -blockdev driver=file,filename="$TEST_IMG",node-name=node0 \
+            -blockdev driver=file,filename="$TEST_IMG.1",node-name=ext1 \
+            -blockdev driver=file,filename="$TEST_IMG.2",node-name=ext2 \
+            -blockdev driver=file,filename="$TEST_IMG.3",node-name=ext3 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": $size,
+      "subformat": "$subfmt",
+      "extents": ["ext1", "ext2", "ext3"]
+  }
+}
+{ "execute": "quit" }
+EOF
+
+        _img_info --format-specific | _filter_img_info --format-specific
+    done
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/214.out b/tests/qemu-iotests/214.out
new file mode 100644
index 0000000000..1cf3e01a88
--- /dev/null
+++ b/tests/qemu-iotests/214.out
@@ -0,0 +1,304 @@
+QA output created by 214
+
+=== Successful image creation (defaults) ===
+
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
+virtual size: 5.0G (5368709120 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: monolithicSparse
+    extents:
+        [0]:
+            virtual size: 5368709120
+            filename: TEST_DIR/t.IMGFMT
+            cluster size: 65536
+            format:
+
+=== Successful image creation (explicit defaults) ===
+
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
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: monolithicSparse
+    extents:
+        [0]:
+            virtual size: 67108864
+            filename: TEST_DIR/t.IMGFMT
+            cluster size: 65536
+            format:
+
+=== Successful image creation (with non-default options) ===
+
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
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: monolithicSparse
+    extents:
+        [0]:
+            virtual size: 33554432
+            filename: TEST_DIR/t.IMGFMT
+            cluster size: 65536
+            format:
+
+=== Invalid BlockdevRef ===
+
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Cannot find device=this doesn't exist nor node_name=this doesn't exist"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+=== Other subformats ===
+
+Formatting 'TEST_DIR/t.IMGFMT.1', fmt=IMGFMT size=0
+Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=0
+Formatting 'TEST_DIR/t.IMGFMT.3', fmt=IMGFMT size=0
+
+== Missing extent ==
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Extent [0] not specified"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+== Correct extent ==
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+== Extra extent ==
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+== Split formats ==
+
+
+= twogbmaxextentflat 512 =
+
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 512 (512 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentFlat
+    extents:
+        [0]:
+            virtual size: 512
+            filename: TEST_DIR/t.IMGFMT.1
+            format: FLAT
+
+= twogbmaxextentsparse 512 =
+
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 512 (512 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentSparse
+    extents:
+        [0]:
+            virtual size: 512
+            filename: TEST_DIR/t.IMGFMT.1
+            cluster size: 65536
+            format: SPARSE
+
+= twogbmaxextentflat 1073741824 =
+
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 1.0G (1073741824 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentFlat
+    extents:
+        [0]:
+            virtual size: 1073741824
+            filename: TEST_DIR/t.IMGFMT.1
+            format: FLAT
+
+= twogbmaxextentsparse 1073741824 =
+
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 1.0G (1073741824 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentSparse
+    extents:
+        [0]:
+            virtual size: 1073741824
+            filename: TEST_DIR/t.IMGFMT.1
+            cluster size: 65536
+            format: SPARSE
+
+= twogbmaxextentflat 2147483648 =
+
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 2.0G (2147483648 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentFlat
+    extents:
+        [0]:
+            virtual size: 2147483648
+            filename: TEST_DIR/t.IMGFMT.1
+            format: FLAT
+
+= twogbmaxextentsparse 2147483648 =
+
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 2.0G (2147483648 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentSparse
+    extents:
+        [0]:
+            virtual size: 2147483648
+            filename: TEST_DIR/t.IMGFMT.1
+            cluster size: 65536
+            format: SPARSE
+
+= twogbmaxextentflat 5368709120 =
+
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 5.0G (5368709120 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentFlat
+    extents:
+        [0]:
+            virtual size: 2147483648
+            filename: TEST_DIR/t.IMGFMT.1
+            format: FLAT
+        [1]:
+            virtual size: 2147483648
+            filename: TEST_DIR/t.IMGFMT.2
+            format: FLAT
+        [2]:
+            virtual size: 1073741824
+            filename: TEST_DIR/t.IMGFMT.3
+            format: FLAT
+
+= twogbmaxextentsparse 5368709120 =
+
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 5.0G (5368709120 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentSparse
+    extents:
+        [0]:
+            virtual size: 2147483648
+            filename: TEST_DIR/t.IMGFMT.1
+            cluster size: 65536
+            format: SPARSE
+        [1]:
+            virtual size: 2147483648
+            filename: TEST_DIR/t.IMGFMT.2
+            cluster size: 65536
+            format: SPARSE
+        [2]:
+            virtual size: 1073741824
+            filename: TEST_DIR/t.IMGFMT.3
+            cluster size: 65536
+            format: SPARSE
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5daef24020..3bc4a8f0e7 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -212,4 +212,5 @@
 211 rw auto quick
 212 rw auto quick
 213 rw auto quick
+214 rw auto quick
 218 rw auto quick
-- 
2.14.3
