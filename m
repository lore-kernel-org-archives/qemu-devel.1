Received: from eggs.gnu.org ([2001:4830:134:3::10]:45411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6r-0004Vc-FS
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6p-00087D-OK
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:49 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Dec 2018 21:29:52 -0500
Message-Id: <20181220022952.20493-12-jsnow@redhat.com>
In-Reply-To: <20181220022952.20493-1-jsnow@redhat.com>
References: <20181220022952.20493-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 11/11] iotests: add iotest 236 for testing
 bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

New interface, new smoke test.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/236     | 161 +++++++++++++++++
 tests/qemu-iotests/236.out | 351 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 513 insertions(+)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
new file mode 100755
index 0000000000..42b93da3ad
--- /dev/null
+++ b/tests/qemu-iotests/236
@@ -0,0 +1,161 @@
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
+import iotests
+from iotests import log
+
+iotests.verify_image_format(supported_fmts=['generic'])
+size = 64 * 1024 * 1024
+granularity = 64 * 1024
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
+    return { "bitmaps": { device['device']: device.get('dirty-bitmaps', []) for
+                          device in res['return'] } }
+
+with iotests.FilePath('img') as img_path, \
+     iotests.VM() as vm:
+
+    log('--- Preparing image & VM ---\n')
+    iotests.qemu_img_create('-f', iotests.imgfmt, img_path, str(size))
+    vm.add_drive(img_path)
+    vm.launch()
+
+    log('\n--- Adding preliminary bitmaps A & B ---\n')
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0",
+               name="bitmapA", granularity=granularity)
+    vm.qmp_log("block-dirty-bitmap-add", node="drive0",
+               name="bitmapB", granularity=granularity)
+
+    # Dirties 4 clusters. count=262144
+    log('\n--- Emulating writes ---\n')
+    for p in patterns:
+        cmd = "write -P%s %s %s" % p
+        log(cmd)
+        log(vm.hmp_qemu_io("drive0", cmd))
+
+    log(query_bitmaps(vm), indent=2)
+
+    log('\n--- Submitting Bad Transaction ---\n')
+    vm.qmp_log("transaction", indent=2, actions=[
+        { "type": "block-dirty-bitmap-disable",
+          "data": { "node": "drive0", "name": "bitmapB" }},
+        { "type": "block-dirty-bitmap-add",
+          "data": { "node": "drive0", "name": "bitmapC",
+                    "granularity": granularity }},
+        { "type": "block-dirty-bitmap-clear",
+          "data": { "node": "drive0", "name": "bitmapA" }},
+        { "type": "abort", "data": {}}
+    ])
+    log(query_bitmaps(vm), indent=2)
+
+    log('\n--- Disabling B & Adding C ---\n')
+    vm.qmp_log("transaction", indent=2, actions=[
+        { "type": "block-dirty-bitmap-disable",
+          "data": { "node": "drive0", "name": "bitmapB" }},
+        { "type": "block-dirty-bitmap-add",
+          "data": { "node": "drive0", "name": "bitmapC",
+                    "granularity": granularity }},
+        # Purely extraneous, but test that it works:
+        { "type": "block-dirty-bitmap-disable",
+          "data": { "node": "drive0", "name": "bitmapC" }},
+        { "type": "block-dirty-bitmap-enable",
+          "data": { "node": "drive0", "name": "bitmapC" }},
+    ])
+
+    log('\n--- Emulating further writes ---\n')
+    # Dirties 6 clusters, 3 of which are new in contrast to "A".
+    # A = 64 * 1024 * (4 + 3) = 458752
+    # C = 64 * 1024 * 6       = 393216
+    for p in overwrite:
+        cmd = "write -P%s %s %s" % p
+        log(cmd)
+        log(vm.hmp_qemu_io("drive0", cmd))
+
+    log('\n--- Disabling A & C ---\n')
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
+    log(query_bitmaps(vm), indent=2)
+
+    log('\n--- Submitting Bad Merge ---\n')
+    vm.qmp_log("transaction", indent=2, actions=[
+        { "type": "block-dirty-bitmap-add",
+          "data": { "node": "drive0", "name": "bitmapD",
+                    "disabled": True, "granularity": granularity }},
+        { "type": "block-dirty-bitmap-merge",
+          "data": { "node": "drive0", "target": "bitmapD",
+                    "bitmaps": ["bitmapB", "bitmapC"] }},
+        { "type": "abort", "data": {}}
+    ])
+    log(query_bitmaps(vm), indent=2)
+
+    log('\n--- Creating D as a merge of B & C ---\n')
+    # Good hygiene: create a disabled bitmap as a merge target.
+    vm.qmp_log("transaction", indent=2, actions=[
+        { "type": "block-dirty-bitmap-add",
+          "data": { "node": "drive0", "name": "bitmapD",
+                    "disabled": True, "granularity": granularity }},
+        { "type": "block-dirty-bitmap-merge",
+          "data": { "node": "drive0", "target": "bitmapD",
+                    "bitmaps": ["bitmapB", "bitmapC"] }}
+    ])
+
+    # A and D should now both have 7 clusters apiece.
+    # B and C remain unchanged with 4 and 6 respectively.
+    log(query_bitmaps(vm), indent=2)
+
+    # A and D should be equivalent.
+    # Some formats round the size of the disk, so don't print the checksums.
+    check_a = vm.qmp('x-debug-block-dirty-bitmap-sha256',
+                     node="drive0", name="bitmapA")['return']['sha256']
+    check_b = vm.qmp('x-debug-block-dirty-bitmap-sha256',
+                     node="drive0", name="bitmapD")['return']['sha256']
+    assert(check_a == check_b)
+
+    log('\n--- Removing bitmaps A, B, C, and D ---\n')
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="bitmapA")
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="bitmapB")
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="bitmapC")
+    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="bitmapD")
+
+    log('\n--- Final Query ---\n')
+    log(query_bitmaps(vm), indent=2)
+
+    log('\n--- Done ---\n')
+    vm.shutdown()
diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
new file mode 100644
index 0000000000..1934035795
--- /dev/null
+++ b/tests/qemu-iotests/236.out
@@ -0,0 +1,351 @@
+--- Preparing image & VM ---
+
+
+--- Adding preliminary bitmaps A & B ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmapA", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmapB", "node": "drive0"}}
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
+  "bitmaps": {
+    "drive0": [
+      {
+        "count": 262144,
+        "granularity": 65536,
+        "name": "bitmapB",
+        "status": "active"
+      },
+      {
+        "count": 262144,
+        "granularity": 65536,
+        "name": "bitmapA",
+        "status": "active"
+      }
+    ]
+  }
+}
+
+--- Submitting Bad Transaction ---
+
+{
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "node": "drive0",
+          "name": "bitmapB"
+        },
+        "type": "block-dirty-bitmap-disable"
+      },
+      {
+        "data": {
+          "node": "drive0",
+          "name": "bitmapC",
+          "granularity": 65536
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "node": "drive0",
+          "name": "bitmapA"
+        },
+        "type": "block-dirty-bitmap-clear"
+      },
+      {
+        "data": {},
+        "type": "abort"
+      }
+    ]
+  }
+}
+{
+  "error": {
+    "class": "GenericError",
+    "desc": "Transaction aborted using Abort action"
+  }
+}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "count": 262144,
+        "granularity": 65536,
+        "name": "bitmapB",
+        "status": "active"
+      },
+      {
+        "count": 262144,
+        "granularity": 65536,
+        "name": "bitmapA",
+        "status": "active"
+      }
+    ]
+  }
+}
+
+--- Disabling B & Adding C ---
+
+{
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "node": "drive0",
+          "name": "bitmapB"
+        },
+        "type": "block-dirty-bitmap-disable"
+      },
+      {
+        "data": {
+          "node": "drive0",
+          "name": "bitmapC",
+          "granularity": 65536
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "node": "drive0",
+          "name": "bitmapC"
+        },
+        "type": "block-dirty-bitmap-disable"
+      },
+      {
+        "data": {
+          "node": "drive0",
+          "name": "bitmapC"
+        },
+        "type": "block-dirty-bitmap-enable"
+      }
+    ]
+  }
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
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "node": "drive0",
+          "name": "bitmapA"
+        },
+        "type": "block-dirty-bitmap-disable"
+      },
+      {
+        "data": {
+          "node": "drive0",
+          "name": "bitmapC"
+        },
+        "type": "block-dirty-bitmap-disable"
+      }
+    ]
+  }
+}
+{
+  "return": {}
+}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmapC",
+        "status": "disabled"
+      },
+      {
+        "count": 262144,
+        "granularity": 65536,
+        "name": "bitmapB",
+        "status": "disabled"
+      },
+      {
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmapA",
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+--- Submitting Bad Merge ---
+
+{
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "node": "drive0",
+          "disabled": true,
+          "name": "bitmapD",
+          "granularity": 65536
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "node": "drive0",
+          "target": "bitmapD",
+          "bitmaps": [
+            "bitmapB",
+            "bitmapC"
+          ]
+        },
+        "type": "block-dirty-bitmap-merge"
+      },
+      {
+        "data": {},
+        "type": "abort"
+      }
+    ]
+  }
+}
+{
+  "error": {
+    "class": "GenericError",
+    "desc": "Transaction aborted using Abort action"
+  }
+}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmapC",
+        "status": "disabled"
+      },
+      {
+        "count": 262144,
+        "granularity": 65536,
+        "name": "bitmapB",
+        "status": "disabled"
+      },
+      {
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmapA",
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+--- Creating D as a merge of B & C ---
+
+{
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "node": "drive0",
+          "disabled": true,
+          "name": "bitmapD",
+          "granularity": 65536
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "node": "drive0",
+          "target": "bitmapD",
+          "bitmaps": [
+            "bitmapB",
+            "bitmapC"
+          ]
+        },
+        "type": "block-dirty-bitmap-merge"
+      }
+    ]
+  }
+}
+{
+  "return": {}
+}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmapD",
+        "status": "disabled"
+      },
+      {
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmapC",
+        "status": "disabled"
+      },
+      {
+        "count": 262144,
+        "granularity": 65536,
+        "name": "bitmapB",
+        "status": "disabled"
+      },
+      {
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmapA",
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+--- Removing bitmaps A, B, C, and D ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmapA", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmapB", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmapC", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmapD", "node": "drive0"}}
+{"return": {}}
+
+--- Final Query ---
+
+{
+  "bitmaps": {
+    "drive0": []
+  }
+}
+
+--- Done ---
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 61a6d98ebd..f6b245917a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -233,3 +233,4 @@
 233 auto quick
 234 auto quick migration
 235 auto quick
+236 auto quick
-- 
2.17.2
