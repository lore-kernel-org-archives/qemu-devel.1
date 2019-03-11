Received: from eggs.gnu.org ([209.51.188.92]:56267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Q1i-0004sh-D0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Q1g-0005NN-6N
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:51:54 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Mar 2019 21:51:47 +0300
Message-Id: <20190311185147.52309-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190311185147.52309-1-vsementsov@virtuozzo.com>
References: <20190311185147.52309-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 4/4] tests/qemu-iotests: add bitmap resize
 test 246
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, eblake@redhat.com, den@virtuozzo.com

From: John Snow <jsnow@redhat.com>

Test that we can actually resize qcow2 images with persistent bitmaps
correctly. Throw some other goofy stuff at the test while we're at it,
like adding bitmaps of different granularities and at different times.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
   [vsmentsov: drop \n from the end of test output,
      test output changed a bit: some bitmaps goes in other order
      int the output]
---
 tests/qemu-iotests/246     | 114 ++++++++++++++
 tests/qemu-iotests/246.out | 295 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 410 insertions(+)
 create mode 100755 tests/qemu-iotests/246
 create mode 100644 tests/qemu-iotests/246.out

diff --git a/tests/qemu-iotests/246 b/tests/qemu-iotests/246
new file mode 100755
index 0000000000..b0997a392f
--- /dev/null
+++ b/tests/qemu-iotests/246
@@ -0,0 +1,114 @@
+#!/usr/bin/env python
+#
+# Test persistent bitmap resizing.
+#
+# Copyright (c) 2019 John Snow for Red Hat, Inc.
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
+import iotests
+from iotests import log
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+size = 64 * 1024 * 1024 * 1024
+gran_small = 32 * 1024
+gran_large = 128 * 1024
+
+def query_bitmaps(vm):
+    res = vm.qmp("query-block")
+    return { "bitmaps": { device['device']: device.get('dirty-bitmaps', []) for
+                          device in res['return'] } }
+
+with iotests.FilePath('img') as img_path, \
+     iotests.VM() as vm:
+
+    log('--- Preparing image & VM ---\n')
+    iotests.qemu_img_create('-f', iotests.imgfmt, img_path, str(size))
+    vm.add_drive(img_path)
+
+
+    log('--- 1st Boot (Establish Baseline Image) ---\n')
+    vm.launch()
+
+    log('\n--- Adding bitmaps Small, Medium, Large, and Transient ---\n')
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0",
+               name="Small", granularity=gran_small, persistent=True)
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0",
+               name="Medium", persistent=True)
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0",
+               name="Large", granularity=gran_large, persistent=True)
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0",
+               name="Transient", persistent=False)
+
+    log('--- Forcing flush of bitmaps to disk ---\n')
+    log(query_bitmaps(vm), indent=2)
+    vm.shutdown()
+
+
+    log('--- 2nd Boot (Grow Image) ---\n')
+    vm.launch()
+    log(query_bitmaps(vm), indent=2)
+
+    log('--- Adding new bitmap, growing image, and adding 2nd new bitmap ---')
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0",
+               name="New", persistent=True)
+    vm.qmp_log("human-monitor-command",
+               command_line="block_resize drive0 70G")
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0",
+               name="Newtwo", persistent=True)
+    log(query_bitmaps(vm), indent=2)
+
+    log('--- Forcing flush of bitmaps to disk ---\n')
+    vm.shutdown()
+
+
+    log('--- 3rd Boot (Shrink Image) ---\n')
+    vm.launch()
+    log(query_bitmaps(vm), indent=2)
+
+    log('--- Adding "NewB" bitmap, removing "New" bitmap ---')
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0",
+               name="NewB", persistent=True)
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0",
+               name="New")
+
+    log('--- Truncating image ---\n')
+    vm.qmp_log("human-monitor-command",
+               command_line="block_resize drive0 50G")
+
+    log('--- Adding "NewC" bitmap, removing "NewTwo" bitmap ---')
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0",
+               name="NewC", persistent=True)
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="Newtwo")
+
+    log('--- Forcing flush of bitmaps to disk ---\n')
+    vm.shutdown()
+
+
+    log('--- 4th Boot (Verification and Cleanup) ---\n')
+    vm.launch()
+    log(query_bitmaps(vm), indent=2)
+
+    log('--- Removing all Bitmaps ---\n')
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="Small")
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="Medium")
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="Large")
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="NewB")
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="NewC")
+    log(query_bitmaps(vm), indent=2)
+
+    log('\n--- Done ---')
+    vm.shutdown()
diff --git a/tests/qemu-iotests/246.out b/tests/qemu-iotests/246.out
new file mode 100644
index 0000000000..6671a11fdd
--- /dev/null
+++ b/tests/qemu-iotests/246.out
@@ -0,0 +1,295 @@
+--- Preparing image & VM ---
+
+--- 1st Boot (Establish Baseline Image) ---
+
+
+--- Adding bitmaps Small, Medium, Large, and Transient ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 32768, "name": "Small", "node": "drive0", "persistent": true}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "Medium", "node": "drive0", "persistent": true}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 131072, "name": "Large", "node": "drive0", "persistent": true}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "Transient", "node": "drive0", "persistent": false}}
+{"return": {}}
+--- Forcing flush of bitmaps to disk ---
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "Transient",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 131072,
+        "name": "Large",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "Medium",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 32768,
+        "name": "Small",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+--- 2nd Boot (Grow Image) ---
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 32768,
+        "name": "Small",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "Medium",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 131072,
+        "name": "Large",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+--- Adding new bitmap, growing image, and adding 2nd new bitmap ---
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "New", "node": "drive0", "persistent": true}}
+{"return": {}}
+{"execute": "human-monitor-command", "arguments": {"command-line": "block_resize drive0 70G"}}
+{"return": ""}
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "Newtwo", "node": "drive0", "persistent": true}}
+{"return": {}}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "Newtwo",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "New",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 32768,
+        "name": "Small",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "Medium",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 131072,
+        "name": "Large",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+--- Forcing flush of bitmaps to disk ---
+
+--- 3rd Boot (Shrink Image) ---
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "New",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "Newtwo",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 32768,
+        "name": "Small",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "Medium",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 131072,
+        "name": "Large",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+--- Adding "NewB" bitmap, removing "New" bitmap ---
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "NewB", "node": "drive0", "persistent": true}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "New", "node": "drive0"}}
+{"return": {}}
+--- Truncating image ---
+
+{"execute": "human-monitor-command", "arguments": {"command-line": "block_resize drive0 50G"}}
+{"return": ""}
+--- Adding "NewC" bitmap, removing "NewTwo" bitmap ---
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "NewC", "node": "drive0", "persistent": true}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "Newtwo", "node": "drive0"}}
+{"return": {}}
+--- Forcing flush of bitmaps to disk ---
+
+--- 4th Boot (Verification and Cleanup) ---
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "NewB",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "NewC",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 32768,
+        "name": "Small",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "Medium",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 131072,
+        "name": "Large",
+        "persistent": true,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+--- Removing all Bitmaps ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "Small", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "Medium", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "Large", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "NewB", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "NewC", "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "drive0": []
+  }
+}
+
+--- Done ---
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b5ca63cf72..0683f6e10d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -241,3 +241,4 @@
 239 rw auto quick
 240 auto quick
 242 rw auto quick
+246 rw auto quick
-- 
2.18.0
