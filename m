Received: from eggs.gnu.org ([209.51.188.92]:42537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gou1X-0006Ob-98
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gou1V-0000A3-9u
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:51:43 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed, 30 Jan 2019 20:51:30 +0300
Message-Id: <1548870690-647481-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548870690-647481-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1548870690-647481-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v10 3/3] qemu-img info: bitmaps extension new
 test 239
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

A new test file 239 added to the qemu-iotests set. It checks
the output format of 'qemu-img info' for bitmaps extension of
qcow2 specific information.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/239     |  74 ++++++++++++++++++++++++++
 tests/qemu-iotests/239.out | 130 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 205 insertions(+)
 create mode 100755 tests/qemu-iotests/239
 create mode 100644 tests/qemu-iotests/239.out

diff --git a/tests/qemu-iotests/239 b/tests/qemu-iotests/239
new file mode 100755
index 0000000..bee7943
--- /dev/null
+++ b/tests/qemu-iotests/239
@@ -0,0 +1,74 @@
+#!/usr/bin/env python
+#
+# Test for qcow2 bitmap printed information
+#
+# Copyright (c) 2018 Virtuozzo International GmbH
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
+import iotests
+import json
+from iotests import qemu_img_create, qemu_io, qemu_img_pipe, \
+                    file_path, log
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+disk = file_path('disk')
+chunk = 256
+
+def print_bitmap():
+    log('qemu-img info dump:\n')
+    iotests.img_info_log(disk, extra_args=['--force-share'])
+    result = json.loads(qemu_img_pipe('info', '--force-share',
+                                      '--output=json', disk))
+    if 'bitmaps' in result['format-specific']['data']:
+        bitmaps = result['format-specific']['data']['bitmaps']
+        log('The same bitmaps in JSON format:')
+        log(bitmaps, indent=2)
+    else:
+        log('No bitmap in JSON format output')
+
+def add_bitmap(bitmap_number, persistent, disabled):
+    granularity = 2**(13 + bitmap_number)
+    bitmap_name = 'bitmap-' + str(bitmap_number-1)
+    vm = iotests.VM().add_drive(disk)
+    vm.launch()
+    vm.qmp_log('block-dirty-bitmap-add', node='drive0', name=bitmap_name,
+               granularity=granularity, persistent=persistent,
+               disabled=disabled)
+    vm.shutdown()
+
+def write_to_disk(offset, size):
+    write = 'write {} {}K'.format(offset, size)
+    qemu_io('-f', iotests.imgfmt, '-c', write, disk)
+    log('Write ' + str(size) + 'K to disk at offset ' + str(hex(offset)))
+
+
+qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+
+for num in range(1, 4):
+    disabled = False
+    if num == 2:
+        disabled = True
+    add_bitmap(num, bool(num-1), disabled)
+    write_to_disk((num-1)*chunk, chunk)
+    print_bitmap()
+    log('')
+
+vm = iotests.VM().add_drive(disk)
+vm.launch()
+log('Checking \"in-use\" flag...')
+print_bitmap()
+vm.shutdown()
diff --git a/tests/qemu-iotests/239.out b/tests/qemu-iotests/239.out
new file mode 100644
index 0000000..0abcac7
--- /dev/null
+++ b/tests/qemu-iotests/239.out
@@ -0,0 +1,130 @@
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 16384, "name": "bitmap-0", "node": "drive0", "persistent": false}}
+{"return": {}}
+Write 256K to disk at offset 0x0
+qemu-img info dump:
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1.0M (1048576 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+No bitmap in JSON format output
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 32768, "name": "bitmap-1", "node": "drive0", "persistent": true}}
+{"return": {}}
+Write 256K to disk at offset 0x100
+qemu-img info dump:
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1.0M (1048576 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    bitmaps:
+        [0]:
+            flags:
+            name: bitmap-1
+            granularity: 32768
+    refcount bits: 16
+    corrupt: false
+
+The same bitmaps in JSON format:
+[
+  {
+    "flags": [],
+    "granularity": 32768,
+    "name": "bitmap-1"
+  }
+]
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "bitmap-2", "node": "drive0", "persistent": true}}
+{"return": {}}
+Write 256K to disk at offset 0x200
+qemu-img info dump:
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1.0M (1048576 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    bitmaps:
+        [0]:
+            flags:
+            name: bitmap-1
+            granularity: 32768
+        [1]:
+            flags:
+                [0]: auto
+            name: bitmap-2
+            granularity: 65536
+    refcount bits: 16
+    corrupt: false
+
+The same bitmaps in JSON format:
+[
+  {
+    "flags": [],
+    "granularity": 32768,
+    "name": "bitmap-1"
+  },
+  {
+    "flags": [
+      "auto"
+    ],
+    "granularity": 65536,
+    "name": "bitmap-2"
+  }
+]
+
+Checking "in-use" flag...
+qemu-img info dump:
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1.0M (1048576 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    bitmaps:
+        [0]:
+            flags:
+                [0]: in-use
+            name: bitmap-1
+            granularity: 32768
+        [1]:
+            flags:
+                [0]: in-use
+                [1]: auto
+            name: bitmap-2
+            granularity: 65536
+    refcount bits: 16
+    corrupt: false
+
+The same bitmaps in JSON format:
+[
+  {
+    "flags": [
+      "in-use"
+    ],
+    "granularity": 32768,
+    "name": "bitmap-1"
+  },
+  {
+    "flags": [
+      "in-use",
+      "auto"
+    ],
+    "granularity": 65536,
+    "name": "bitmap-2"
+  }
+]
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0f1c3f9..3e310c7 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -235,3 +235,4 @@
 235 auto quick
 236 auto quick
 238 auto quick
+239 rw auto quick
-- 
1.8.3.1
