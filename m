Received: from eggs.gnu.org ([2001:4830:134:3::10]:33075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkh-0001iw-UK
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkg-0005as-Bb
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:27 +0200
Message-Id: <20170926142133.2498-19-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 18/24] qemu-iotests: Test change-backing-file
 command
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

This involves a temporary read-write reopen if the backing file link in
the middle of a backing file chain should be changed and is therefore a
good test for the latest bdrv_reopen() vs. op blockers fixes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/195     | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/195.out | 78 +++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 171 insertions(+)
 create mode 100755 tests/qemu-iotests/195
 create mode 100644 tests/qemu-iotests/195.out

diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
new file mode 100755
index 0000000000..05a239cbf5
--- /dev/null
+++ b/tests/qemu-iotests/195
@@ -0,0 +1,92 @@
+#!/bin/bash
+#
+# Test change-backing-file command
+#
+# Copyright (C) 2017 Red Hat, Inc.
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
+status=1 # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$TEST_IMG.mid"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+function do_run_qemu()
+{
+    echo Testing: "$@" | _filter_imgfmt
+    $QEMU -nographic -qmp-pretty stdio -serial none "$@"
+    echo
+}
+
+function run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp \
+                          | _filter_qemu_io | _filter_generated_node_ids
+}
+
+size=64M
+TEST_IMG="$TEST_IMG.base" _make_test_img $size
+TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.mid"
+
+echo
+echo "Change backing file of mid (opened read-only)"
+echo
+
+run_qemu -drive if=none,file="$TEST_IMG",backing.node-name=mid <<EOF
+{"execute":"qmp_capabilities"}
+{"execute":"change-backing-file", "arguments":{"device":"none0","image-node-name":"mid","backing-file":"/dev/null"}}
+{"execute":"quit"}
+EOF
+
+TEST_IMG="$TEST_IMG.mid" _img_info
+
+echo
+echo "Change backing file of top (opened writable)"
+echo
+
+TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
+
+run_qemu -drive if=none,file="$TEST_IMG",node-name=top <<EOF
+{"execute":"qmp_capabilities"}
+{"execute":"change-backing-file", "arguments":{"device":"none0","image-node-name":"top","backing-file":"/dev/null"}}
+{"execute":"quit"}
+EOF
+
+_img_info
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
new file mode 100644
index 0000000000..7613575c64
--- /dev/null
+++ b/tests/qemu-iotests/195.out
@@ -0,0 +1,78 @@
+QA output created by 195
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
+
+Change backing file of mid (opened read-only)
+
+Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,backing.node-name=mid
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+
+image: TEST_DIR/t.IMGFMT.mid
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+backing file: /dev/null
+backing file format: IMGFMT
+
+Change backing file of top (opened writable)
+
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,node-name=top
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+backing file: /dev/null
+backing file format: IMGFMT
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 94e764865a..108339cd03 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -189,3 +189,4 @@
 190 rw auto quick
 192 rw auto quick
 194 rw auto migration quick
+195 rw auto quick
-- 
2.13.5
