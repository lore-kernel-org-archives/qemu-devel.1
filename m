Received: from eggs.gnu.org ([2001:4830:134:3::10]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG9G-0002Wm-TZ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG9F-0001Um-1V
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:46 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 12 Dec 2018 20:50:13 -0500
Message-Id: <20181213015013.15350-8-jsnow@redhat.com>
In-Reply-To: <20181213015013.15350-1-jsnow@redhat.com>
References: <20181213015013.15350-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/7] iotests: add iotest 236 for testing
 bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

New interface, new smoke test.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/236     | 123 +++++++++++++++++
 tests/qemu-iotests/236.out | 265 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 389 insertions(+)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
new file mode 100755
index 0000000000..3d162e967b
--- /dev/null
+++ b/tests/qemu-iotests/236
@@ -0,0 +1,123 @@
+#!/usr/bin/env python
+#
+# Test bitmap merges.
+#
+# Copyright (c) 2018 John Snow for Red Hat, Inc.
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
+# owner=jsnow@redhat.com
+
+import sys
+import os
+import iotests
+from iotests import log
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
+from qemu import QEMUMachine
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+patterns = [("0x5d", "0",         "64k"),
+            ("0xd5", "1M",        "64k"),
+            ("0xdc", "32M",       "64k"),
+            ("0xcd", "0x3ff0000", "64k")]  # 64M - 64K
+
+overwrite = [("0xab", "0",         "64k"), # Full overwrite
+             ("0xad", "0x00f8000", "64k"), # Partial-left (1M-32K)
+             ("0x1d", "0x2008000", "64k"), # Partial-right (32M+32K)
+             ("0xea", "0x3fe0000", "64k")] # Adjacent-left (64M - 128K)
+
+with iotests.FilePath('img') as img_path, \
+     iotests.VM() as vm:
+
+    log('--- Preparing image & VM ---\n')
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, img_path, '64M')
+    vm.add_drive(img_path)
+    vm.launch()
+
+    log('--- Adding preliminary bitmaps A & B ---\n')
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0", name="bitmapA")
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0", name="bitmapB")
+
+    # Dirties 4 clusters. count=262144
+    log('')
+    log('--- Emulating writes ---\n')
+    for p in patterns:
+        cmd = "write -P%s %s %s" % p
+        log(cmd)
+        log(vm.hmp_qemu_io("drive0", cmd))
+
+    vm.qmp_log("query-block", indent=2,
+               filters=[iotests.filter_generated_node_ids,
+                        iotests.filter_testfiles])
+
+    log('')
+    log('--- Disabling B & Adding C ---\n')
+    vm.qmp_log("transaction", actions=[
+        { "type": "block-dirty-bitmap-disable",
+          "data": { "node": "drive0", "name": "bitmapB" }},
+        { "type": "block-dirty-bitmap-add",
+          "data": { "node": "drive0", "name": "bitmapC" }}
+    ])
+
+    log('')
+    log('--- Emulating further writes ---\n')
+    # Dirties 6 clusters, 3 of which are new in contrast to "A".
+    # A = 64 * 1024 * (4 + 3) = 458752
+    # C = 64 * 1024 * 6       = 393216
+    for p in overwrite:
+        cmd = "write -P%s %s %s" % p
+        log(cmd)
+        log(vm.hmp_qemu_io("drive0", cmd))
+
+    log('')
+    log('--- Disabling A & C ---\n')
+    vm.qmp_log("transaction", actions=[
+        { "type": "block-dirty-bitmap-disable",
+          "data": { "node": "drive0", "name": "bitmapA" }},
+        { "type": "block-dirty-bitmap-disable",
+          "data": { "node": "drive0", "name": "bitmapC" }}
+    ])
+
+    # A: 7 clusters
+    # B: 4 clusters
+    # C: 6 clusters
+    vm.qmp_log("query-block", indent=2,
+               filters=[iotests.filter_generated_node_ids,
+                        iotests.filter_testfiles])
+
+    log('')
+    log('--- Creating D as a merge of B & C ---\n')
+    # Good hygiene: create a disabled bitmap as a merge target.
+    vm.qmp_log("transaction", actions=[
+        { "type": "block-dirty-bitmap-add",
+          "data": { "node": "drive0", "name": "bitmapD", "disabled": True }},
+        { "type": "block-dirty-bitmap-merge",
+          "data": { "node": "drive0", "target": "bitmapD",
+                    "bitmaps": ["bitmapB", "bitmapC"] }}
+    ])
+
+    # A and D should now both have 7 clusters apiece.
+    # B and C remain unchanged with 4 and 6 respectively.
+    vm.qmp_log("query-block", indent=2,
+               filters=[iotests.filter_generated_node_ids,
+                        iotests.filter_testfiles])
+
+    # A and D should be equivalent.
+    vm.qmp_log('x-debug-block-dirty-bitmap-sha256',
+               node="drive0", name="bitmapA")
+    vm.qmp_log('x-debug-block-dirty-bitmap-sha256',
+               node="drive0", name="bitmapD")
+
+    vm.shutdown()
diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
new file mode 100644
index 0000000000..5e4d1fe6d5
--- /dev/null
+++ b/tests/qemu-iotests/236.out
@@ -0,0 +1,265 @@
+--- Preparing image & VM ---
+
+--- Adding preliminary bitmaps A & B ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmapA", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmapB", "node": "drive0"}}
+{"return": {}}
+
+--- Emulating writes ---
+
+write -P0x5d 0 64k
+{"return": ""}
+write -P0xd5 1M 64k
+{"return": ""}
+write -P0xdc 32M 64k
+{"return": ""}
+write -P0xcd 0x3ff0000 64k
+{"return": ""}
+{"execute": "query-block", "arguments": {}}
+{
+  "return": [
+    {
+      "device": "drive0",
+      "dirty-bitmaps": [
+        {
+          "count": 262144,
+          "granularity": 65536,
+          "name": "bitmapB",
+          "status": "active"
+        },
+        {
+          "count": 262144,
+          "granularity": 65536,
+          "name": "bitmapA",
+          "status": "active"
+        }
+      ],
+      "inserted": {
+        "backing_file_depth": 0,
+        "bps": 0,
+        "bps_rd": 0,
+        "bps_wr": 0,
+        "cache": {
+          "direct": false,
+          "no-flush": false,
+          "writeback": true
+        },
+        "detect_zeroes": "off",
+        "drv": "qcow2",
+        "encrypted": false,
+        "encryption_key_missing": false,
+        "file": "TEST_DIR/PID-img",
+        "image": {
+          "actual-size": 528384,
+          "cluster-size": 65536,
+          "dirty-flag": false,
+          "filename": "TEST_DIR/PID-img",
+          "format": "qcow2",
+          "format-specific": {
+            "data": {
+              "compat": "1.1",
+              "corrupt": false,
+              "lazy-refcounts": false,
+              "refcount-bits": 16
+            },
+            "type": "qcow2"
+          },
+          "virtual-size": 67108864
+        },
+        "iops": 0,
+        "iops_rd": 0,
+        "iops_wr": 0,
+        "node-name": "NODE_NAME",
+        "ro": false,
+        "write_threshold": 0
+      },
+      "io-status": "ok",
+      "locked": false,
+      "qdev": "/machine/peripheral-anon/device[0]/virtio-backend",
+      "removable": false,
+      "type": "unknown"
+    }
+  ]
+}
+
+--- Disabling B & Adding C ---
+
+{"execute": "transaction", "arguments": {"actions": [{"data": {"name": "bitmapB", "node": "drive0"}, "type": "block-dirty-bitmap-disable"}, {"data": {"name": "bitmapC", "node": "drive0"}, "type": "block-dirty-bitmap-add"}]}}
+{"return": {}}
+
+--- Emulating further writes ---
+
+write -P0xab 0 64k
+{"return": ""}
+write -P0xad 0x00f8000 64k
+{"return": ""}
+write -P0x1d 0x2008000 64k
+{"return": ""}
+write -P0xea 0x3fe0000 64k
+{"return": ""}
+
+--- Disabling A & C ---
+
+{"execute": "transaction", "arguments": {"actions": [{"data": {"name": "bitmapA", "node": "drive0"}, "type": "block-dirty-bitmap-disable"}, {"data": {"name": "bitmapC", "node": "drive0"}, "type": "block-dirty-bitmap-disable"}]}}
+{"return": {}}
+{"execute": "query-block", "arguments": {}}
+{
+  "return": [
+    {
+      "device": "drive0",
+      "dirty-bitmaps": [
+        {
+          "count": 393216,
+          "granularity": 65536,
+          "name": "bitmapC",
+          "status": "disabled"
+        },
+        {
+          "count": 262144,
+          "granularity": 65536,
+          "name": "bitmapB",
+          "status": "disabled"
+        },
+        {
+          "count": 458752,
+          "granularity": 65536,
+          "name": "bitmapA",
+          "status": "disabled"
+        }
+      ],
+      "inserted": {
+        "backing_file_depth": 0,
+        "bps": 0,
+        "bps_rd": 0,
+        "bps_wr": 0,
+        "cache": {
+          "direct": false,
+          "no-flush": false,
+          "writeback": true
+        },
+        "detect_zeroes": "off",
+        "drv": "qcow2",
+        "encrypted": false,
+        "encryption_key_missing": false,
+        "file": "TEST_DIR/PID-img",
+        "image": {
+          "actual-size": 724992,
+          "cluster-size": 65536,
+          "dirty-flag": false,
+          "filename": "TEST_DIR/PID-img",
+          "format": "qcow2",
+          "format-specific": {
+            "data": {
+              "compat": "1.1",
+              "corrupt": false,
+              "lazy-refcounts": false,
+              "refcount-bits": 16
+            },
+            "type": "qcow2"
+          },
+          "virtual-size": 67108864
+        },
+        "iops": 0,
+        "iops_rd": 0,
+        "iops_wr": 0,
+        "node-name": "NODE_NAME",
+        "ro": false,
+        "write_threshold": 0
+      },
+      "io-status": "ok",
+      "locked": false,
+      "qdev": "/machine/peripheral-anon/device[0]/virtio-backend",
+      "removable": false,
+      "type": "unknown"
+    }
+  ]
+}
+
+--- Creating D as a merge of B & C ---
+
+{"execute": "transaction", "arguments": {"actions": [{"data": {"disabled": true, "name": "bitmapD", "node": "drive0"}, "type": "block-dirty-bitmap-add"}, {"data": {"bitmaps": ["bitmapB", "bitmapC"], "node": "drive0", "target": "bitmapD"}, "type": "block-dirty-bitmap-merge"}]}}
+{"return": {}}
+{"execute": "query-block", "arguments": {}}
+{
+  "return": [
+    {
+      "device": "drive0",
+      "dirty-bitmaps": [
+        {
+          "count": 458752,
+          "granularity": 65536,
+          "name": "bitmapD",
+          "status": "disabled"
+        },
+        {
+          "count": 393216,
+          "granularity": 65536,
+          "name": "bitmapC",
+          "status": "disabled"
+        },
+        {
+          "count": 262144,
+          "granularity": 65536,
+          "name": "bitmapB",
+          "status": "disabled"
+        },
+        {
+          "count": 458752,
+          "granularity": 65536,
+          "name": "bitmapA",
+          "status": "disabled"
+        }
+      ],
+      "inserted": {
+        "backing_file_depth": 0,
+        "bps": 0,
+        "bps_rd": 0,
+        "bps_wr": 0,
+        "cache": {
+          "direct": false,
+          "no-flush": false,
+          "writeback": true
+        },
+        "detect_zeroes": "off",
+        "drv": "qcow2",
+        "encrypted": false,
+        "encryption_key_missing": false,
+        "file": "TEST_DIR/PID-img",
+        "image": {
+          "actual-size": 724992,
+          "cluster-size": 65536,
+          "dirty-flag": false,
+          "filename": "TEST_DIR/PID-img",
+          "format": "qcow2",
+          "format-specific": {
+            "data": {
+              "compat": "1.1",
+              "corrupt": false,
+              "lazy-refcounts": false,
+              "refcount-bits": 16
+            },
+            "type": "qcow2"
+          },
+          "virtual-size": 67108864
+        },
+        "iops": 0,
+        "iops_rd": 0,
+        "iops_wr": 0,
+        "node-name": "NODE_NAME",
+        "ro": false,
+        "write_threshold": 0
+      },
+      "io-status": "ok",
+      "locked": false,
+      "qdev": "/machine/peripheral-anon/device[0]/virtio-backend",
+      "removable": false,
+      "type": "unknown"
+    }
+  ]
+}
+{"execute": "x-debug-block-dirty-bitmap-sha256", "arguments": {"name": "bitmapA", "node": "drive0"}}
+{"return": {"sha256": "7abe3d7e3c794cfaf9b08bc9ce599192c96a2206f07b42d9997ff78fdd7af744"}}
+{"execute": "x-debug-block-dirty-bitmap-sha256", "arguments": {"name": "bitmapD", "node": "drive0"}}
+{"return": {"sha256": "7abe3d7e3c794cfaf9b08bc9ce599192c96a2206f07b42d9997ff78fdd7af744"}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 61a6d98ebd..a61f9e83d6 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -233,3 +233,4 @@
 233 auto quick
 234 auto quick migration
 235 auto quick
+236 auto quick
\ No newline at end of file
-- 
2.17.2
