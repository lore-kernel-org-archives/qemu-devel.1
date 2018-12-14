Received: from eggs.gnu.org ([2001:4830:134:3::10]:39956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXwgW-0000yI-4d
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 18:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXwgU-0003HZ-86
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 18:15:56 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 14 Dec 2018 18:15:12 -0500
Message-Id: <20181214231512.5295-8-jsnow@redhat.com>
In-Reply-To: <20181214231512.5295-1-jsnow@redhat.com>
References: <20181214231512.5295-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 7/7] iotests: add iotest 236 for testing
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
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

New interface, new smoke test.
---
 tests/qemu-iotests/236     | 124 +++++++++++++++++++++++
 tests/qemu-iotests/236.out | 200 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 325 insertions(+)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
new file mode 100755
index 0000000000..edf16c4ab1
--- /dev/null
+++ b/tests/qemu-iotests/236
@@ -0,0 +1,124 @@
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
+import json
+import iotests
+from iotests import log
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
+def query_bitmaps(vm):
+    res = vm.qmp("query-block")
+    return {device['device']: device['dirty-bitmaps'] for
+            device in res['return']}
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
+    log(json.dumps(query_bitmaps(vm), indent=2, separators=(',', ': ')))
+
+    log('')
+    log('--- Disabling B & Adding C ---\n')
+    vm.qmp_log("transaction", indent=2, actions=[
+        { "type": "block-dirty-bitmap-disable",
+          "data": { "node": "drive0", "name": "bitmapB" }},
+        { "type": "block-dirty-bitmap-add",
+          "data": { "node": "drive0", "name": "bitmapC" }},
+        # Purely extraneous, but test that it works:
+        { "type": "block-dirty-bitmap-disable",
+          "data": { "node": "drive0", "name": "bitmapC" }},
+        { "type": "block-dirty-bitmap-enable",
+          "data": { "node": "drive0", "name": "bitmapC" }},
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
+    vm.qmp_log("transaction", indent=2, actions=[
+        { "type": "block-dirty-bitmap-disable",
+          "data": { "node": "drive0", "name": "bitmapA" }},
+        { "type": "block-dirty-bitmap-disable",
+          "data": { "node": "drive0", "name": "bitmapC" }}
+    ])
+
+    # A: 7 clusters
+    # B: 4 clusters
+    # C: 6 clusters
+    log(json.dumps(query_bitmaps(vm), indent=2, separators=(',', ': ')))
+
+    log('')
+    log('--- Creating D as a merge of B & C ---\n')
+    # Good hygiene: create a disabled bitmap as a merge target.
+    vm.qmp_log("transaction", indent=2, actions=[
+        { "type": "block-dirty-bitmap-add",
+          "data": { "node": "drive0", "name": "bitmapD", "disabled": True }},
+        { "type": "block-dirty-bitmap-merge",
+          "data": { "node": "drive0", "target": "bitmapD",
+                    "bitmaps": ["bitmapB", "bitmapC"] }}
+    ])
+
+    # A and D should now both have 7 clusters apiece.
+    # B and C remain unchanged with 4 and 6 respectively.
+    log(json.dumps(query_bitmaps(vm), indent=2, separators=(',', ': ')))
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
index 0000000000..42c131504d
--- /dev/null
+++ b/tests/qemu-iotests/236.out
@@ -0,0 +1,200 @@
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
+{
+  "drive0": [
+    {
+      "status": "active",
+      "count": 262144,
+      "name": "bitmapB",
+      "granularity": 65536
+    },
+    {
+      "status": "active",
+      "count": 262144,
+      "name": "bitmapA",
+      "granularity": 65536
+    }
+  ]
+}
+
+--- Disabling B & Adding C ---
+
+{
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "name": "bitmapB",
+          "node": "drive0"
+        },
+        "type": "block-dirty-bitmap-disable"
+      },
+      {
+        "data": {
+          "name": "bitmapC",
+          "node": "drive0"
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "name": "bitmapC",
+          "node": "drive0"
+        },
+        "type": "block-dirty-bitmap-disable"
+      },
+      {
+        "data": {
+          "name": "bitmapC",
+          "node": "drive0"
+        },
+        "type": "block-dirty-bitmap-enable"
+      }
+    ]
+  },
+  "execute": "transaction"
+}
+{
+  "return": {}
+}
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
+{
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "name": "bitmapA",
+          "node": "drive0"
+        },
+        "type": "block-dirty-bitmap-disable"
+      },
+      {
+        "data": {
+          "name": "bitmapC",
+          "node": "drive0"
+        },
+        "type": "block-dirty-bitmap-disable"
+      }
+    ]
+  },
+  "execute": "transaction"
+}
+{
+  "return": {}
+}
+{
+  "drive0": [
+    {
+      "status": "disabled",
+      "count": 393216,
+      "name": "bitmapC",
+      "granularity": 65536
+    },
+    {
+      "status": "disabled",
+      "count": 262144,
+      "name": "bitmapB",
+      "granularity": 65536
+    },
+    {
+      "status": "disabled",
+      "count": 458752,
+      "name": "bitmapA",
+      "granularity": 65536
+    }
+  ]
+}
+
+--- Creating D as a merge of B & C ---
+
+{
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "disabled": true,
+          "name": "bitmapD",
+          "node": "drive0"
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "bitmaps": [
+            "bitmapB",
+            "bitmapC"
+          ],
+          "node": "drive0",
+          "target": "bitmapD"
+        },
+        "type": "block-dirty-bitmap-merge"
+      }
+    ]
+  },
+  "execute": "transaction"
+}
+{
+  "return": {}
+}
+{
+  "drive0": [
+    {
+      "status": "disabled",
+      "count": 458752,
+      "name": "bitmapD",
+      "granularity": 65536
+    },
+    {
+      "status": "disabled",
+      "count": 393216,
+      "name": "bitmapC",
+      "granularity": 65536
+    },
+    {
+      "status": "disabled",
+      "count": 262144,
+      "name": "bitmapB",
+      "granularity": 65536
+    },
+    {
+      "status": "disabled",
+      "count": 458752,
+      "name": "bitmapA",
+      "granularity": 65536
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
