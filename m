Received: from eggs.gnu.org ([2001:4830:134:3::10]:44191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oY-0003Ra-Lx
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oW-0008Oo-W4
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:58 +0200
Message-Id: <20180730150958.14607-14-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/13] qemu-iotests: Test query-blockstats with
 -drive and -blockdev
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

Make sure that query-blockstats returns information for every
BlockBackend that is named or attached to a device model (or both).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/227     | 101 ++++++++++++++++++++++
 tests/qemu-iotests/227.out | 205 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 307 insertions(+)
 create mode 100755 tests/qemu-iotests/227
 create mode 100644 tests/qemu-iotests/227.out

diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
new file mode 100755
index 0000000000..9a5f7f9f14
--- /dev/null
+++ b/tests/qemu-iotests/227
@@ -0,0 +1,101 @@
+#!/bin/bash
+#
+# Test query-blockstats with different ways to create a BB
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
+seq=$(basename $0)
+echo "QA output created by $seq"
+
+here=$PWD
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
+_supported_fmt generic
+_supported_proto file
+_supported_os Linux
+
+function do_run_qemu()
+{
+    echo Testing: "$@"
+    $QEMU -nographic -qmp-pretty stdio -serial none "$@"
+    echo
+}
+
+function run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
+                          | _filter_qemu | _filter_imgfmt \
+                          | _filter_generated_node_ids
+}
+
+echo
+echo '=== blockstats with -drive if=virtio ==='
+echo
+
+run_qemu -drive driver=null-co,if=virtio <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "query-blockstats"}
+{ "execute": "quit" }
+EOF
+
+echo
+echo '=== blockstats with -drive if=none ==='
+echo
+
+run_qemu -drive driver=null-co,if=none <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "query-blockstats"}
+{ "execute": "quit" }
+EOF
+
+echo
+echo '=== blockstats with -blockdev ==='
+echo
+
+run_qemu -blockdev driver=null-co,node-name=null <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "query-blockstats"}
+{ "execute": "quit" }
+EOF
+
+echo
+echo '=== blockstats with -blockdev and -device ==='
+echo
+
+run_qemu -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,id=virtio0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "query-blockstats"}
+{ "execute": "quit" }
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
new file mode 100644
index 0000000000..736f2e3b11
--- /dev/null
+++ b/tests/qemu-iotests/227.out
@@ -0,0 +1,205 @@
+QA output created by 227
+
+=== blockstats with -drive if=virtio ===
+
+Testing: -drive driver=null-co,if=virtio
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "virtio0",
+            "stats": {
+                "flush_total_time_ns": 0,
+                "wr_highest_offset": 0,
+                "wr_total_time_ns": 0,
+                "failed_wr_operations": 0,
+                "failed_rd_operations": 0,
+                "wr_merged": 0,
+                "wr_bytes": 0,
+                "timed_stats": [
+                ],
+                "failed_flush_operations": 0,
+                "account_invalid": true,
+                "rd_total_time_ns": 0,
+                "flush_operations": 0,
+                "wr_operations": 0,
+                "rd_merged": 0,
+                "rd_bytes": 0,
+                "invalid_flush_operations": 0,
+                "account_failed": true,
+                "rd_operations": 0,
+                "invalid_wr_operations": 0,
+                "invalid_rd_operations": 0
+            },
+            "node-name": "NODE_NAME",
+            "qdev": "/machine/peripheral-anon/device[0]/virtio-backend"
+        }
+    ]
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
+
+=== blockstats with -drive if=none ===
+
+Testing: -drive driver=null-co,if=none
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "none0",
+            "stats": {
+                "flush_total_time_ns": 0,
+                "wr_highest_offset": 0,
+                "wr_total_time_ns": 0,
+                "failed_wr_operations": 0,
+                "failed_rd_operations": 0,
+                "wr_merged": 0,
+                "wr_bytes": 0,
+                "timed_stats": [
+                ],
+                "failed_flush_operations": 0,
+                "account_invalid": true,
+                "rd_total_time_ns": 0,
+                "flush_operations": 0,
+                "wr_operations": 0,
+                "rd_merged": 0,
+                "rd_bytes": 0,
+                "invalid_flush_operations": 0,
+                "account_failed": true,
+                "rd_operations": 0,
+                "invalid_wr_operations": 0,
+                "invalid_rd_operations": 0
+            },
+            "node-name": "NODE_NAME"
+        }
+    ]
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
+
+=== blockstats with -blockdev ===
+
+Testing: -blockdev driver=null-co,node-name=null
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+    ]
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
+
+=== blockstats with -blockdev and -device ===
+
+Testing: -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,id=virtio0
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "",
+            "stats": {
+                "flush_total_time_ns": 0,
+                "wr_highest_offset": 0,
+                "wr_total_time_ns": 0,
+                "failed_wr_operations": 0,
+                "failed_rd_operations": 0,
+                "wr_merged": 0,
+                "wr_bytes": 0,
+                "timed_stats": [
+                ],
+                "failed_flush_operations": 0,
+                "account_invalid": false,
+                "rd_total_time_ns": 0,
+                "flush_operations": 0,
+                "wr_operations": 0,
+                "rd_merged": 0,
+                "rd_bytes": 0,
+                "invalid_flush_operations": 0,
+                "account_failed": false,
+                "rd_operations": 0,
+                "invalid_wr_operations": 0,
+                "invalid_rd_operations": 0
+            },
+            "node-name": "null",
+            "qdev": "/machine/peripheral/virtio0/virtio-backend"
+        }
+    ]
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
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 68f66259b2..b973dc842d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -224,3 +224,4 @@
 223 rw auto quick
 225 rw auto quick
 226 auto quick
+227 auto quick
-- 
2.13.6
