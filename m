Received: from eggs.gnu.org ([2001:4830:134:3::10]:60091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0q-0001fy-Mb
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0o-0004Uf-V7
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:36 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 23 Jun 2017 15:47:00 +0300
Message-Id: <20170623124700.1389-9-el13635@mail.ntua.gr>
In-Reply-To: <20170623124700.1389-1-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v3 8/8] block: add throttle block filter
 driver interface tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 tests/qemu-iotests/184     | 144 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/184.out |  31 ++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 176 insertions(+)
 create mode 100755 tests/qemu-iotests/184
 create mode 100644 tests/qemu-iotests/184.out

diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
new file mode 100755
index 0000000000..529f9edbec
--- /dev/null
+++ b/tests/qemu-iotests/184
@@ -0,0 +1,144 @@
+#!/bin/bash
+#
+# Test I/O throttle block filter driver interface
+#
+# Copyright (C) 2017 Manos Pitsidianakis
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
+owner=
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
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
+
+_supported_fmt raw qcow2
+_supported_proto file
+_supported_os Linux
+
+function do_run_qemu()
+{
+    echo Testing: "$@" | _filter_imgfmt
+    $QEMU -nographic -qmp stdio -serial none "$@"
+    echo
+}
+
+function run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp\
+                          | _filter_qemu_io | _filter_generated_node_ids
+}
+
+_make_test_img 64M
+test_throttle=$($QEMU_IMG --help|grep throttle)
+[ "$test_throttle" = "" ] && _supported_fmt throttle
+
+throttle="driver=throttle"
+
+echo
+echo "== checking interface =="
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add",
+    "arguments":
+    {
+        "driver" : "$IMGFMT",
+        "node-name" : "disk0",
+        "file" : {
+        "driver" :	"file",
+        "filename": "$TEST_IMG"
+    }
+}
+}
+{ "execute" : "object-add",
+    "arguments" : {
+    "qom-type": "throttling-group",
+    "id" : "foobar",
+    "props" : {
+    "iops-total" : 1000
+}
+    }
+}
+{ "execute": "blockdev-add",
+    "arguments":
+    {
+        "driver" : "throttle",
+        "node-name" : "throttle0",
+        "throttling-group" : "foobar",
+        "file" : "disk0"
+    }
+}
+{ "execute": "query-named-block-nodes" }
+{ "execute" : "query-block" }
+{ "execute": "quit" }
+EOF
+
+echo
+echo "== checking legacy interface =="
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "human-monitor-command",
+    "arguments": { "command-line": "drive_add 0 file=$TEST_IMG,format=$IMGFMT,if=none,id=disk" } }
+    { "execute": "device_add",
+        "arguments": { "driver": "virtio-blk", "drive": "disk",
+        "id": "virtio0" } }
+        { "execute": "block_set_io_throttle",
+            "arguments": {
+            "device": "disk",
+            "group" : "foobar",
+            "iops": 100,
+            "iops_rd": 0,
+            "iops_wr": 0,
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0
+        }
+    }
+    { "execute" : "query-block" }
+    { "execute": "block_set_io_throttle",
+        "arguments": {
+        "device": "disk",
+        "group" : "foobar",
+        "iops": 0,
+        "iops_rd": 0,
+        "iops_wr": 0,
+        "bps": 0,
+        "bps_rd": 0,
+        "bps_wr": 0
+    }
+}
+{ "execute" : "query-block" }
+{ "execute": "quit" }
+EOF
+
+echo
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
new file mode 100644
index 0000000000..ed791c6fbe
--- /dev/null
+++ b/tests/qemu-iotests/184.out
@@ -0,0 +1,31 @@
+QA output created by 184
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+
+== checking interface ==
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "image": {"virtual-size": 67108864, "filename": "json:{\"throttling-group\": \"foobar\", \"driver\": \"throttle\", \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}", "format": "throttle", "actual-size": 200704}, "iops_wr": 0, "ro": false, "node-name": "throttle0", "backing_file_depth": 0, "drv": "throttle", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"throttling-group\": \"foobar\", \"driver\": \"throttle\", \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}", "encryption_key_missing": false}, {"iops_rd": 0, "detect_zeroes": "off", "image": {"virtual-size": 67108864, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": 200704, "format-specific": {"type": "!
 qcow2", "data": {"compat": "1.1", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "node-name": "disk0", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2", "encryption_key_missing": false}, {"iops_rd": 0, "detect_zeroes": "off", "image": {"virtual-size": 197120, "filename": "TEST_DIR/t.qcow2", "format": "file", "actual-size": 200704, "dirty-flag": false}, "iops_wr": 0, "ro": false, "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2", "encryption_key_missing": false}]}
+{"return": []}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+== checking legacy interface ==
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": "OK\r\n"}
+{"return": {}}
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "disk", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "image": {"virtual-size": 67108864, "filename": "", "format": "throttle", "actual-size": 200704}, "iops_wr": 0, "group": "foobar", "ro": false, "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "throttle", "iops": 100, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "", "encryption_key_missing": false}, "type": "unknown"}]}
+{"return": {}}
+{"return": [{"io-status": "ok", "device": "disk", "locked": false, "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "image": {"virtual-size": 67108864, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": 200704, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "node-name": "NODE_NAME", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2", "encryption_key_missing": false}, "type": "unknown"}]}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a6acafffd7..0c1f46c7ca 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -175,3 +175,4 @@
 181 rw auto migration
 182 rw auto quick
 183 rw auto migration
+184 rw auto quick
-- 
2.11.0
