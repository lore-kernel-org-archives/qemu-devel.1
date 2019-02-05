Received: from eggs.gnu.org ([209.51.188.92]:46577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gr77N-0007yy-VC
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gr77L-0001hu-Jo
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:14:53 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue,  5 Feb 2019 23:14:35 +0300
Message-Id: <1549397675-189741-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1549397675-189741-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1549397675-189741-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v12 3/3] qcow2: list of bitmaps new test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

A new test file 242 added to the qemu-iotests set. It checks
the format of qcow2 specific information for the new added
section that lists details of bitmaps.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/242     | 100 +++++++++++++++++++++++++++
 tests/qemu-iotests/242.out | 167 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 268 insertions(+)
 create mode 100755 tests/qemu-iotests/242
 create mode 100644 tests/qemu-iotests/242.out

diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
new file mode 100755
index 0000000..95c1f18
--- /dev/null
+++ b/tests/qemu-iotests/242
@@ -0,0 +1,100 @@
+#!/usr/bin/env python
+#
+# Test for qcow2 bitmap printed information
+#
+# Copyright (c) 2019 Virtuozzo International GmbH
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
+    file_path, img_info_log, log, filter_qemu_io
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+disk = file_path('disk')
+chunk = 256*1024
+bitmap_flag_unknown = 1 << 2
+flag_offset = 0x10002f
+
+
+def print_bitmap(extra_args):
+    log('qemu-img info dump:\n')
+    img_info_log(disk, extra_args=extra_args)
+    result = json.loads(qemu_img_pipe('info', '--force-share',
+                                      '--output=json', disk))
+    if 'bitmaps' in result['format-specific']['data']:
+        bitmaps = result['format-specific']['data']['bitmaps']
+        log('The same bitmaps in JSON format:')
+        log(bitmaps, indent=2)
+    else:
+        log('No bitmap in JSON format output')
+
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
+
+def write_to_disk(offset, size):
+    write = 'write {} {}'.format(offset, size)
+    log(qemu_io('-c', write, disk), filters=[filter_qemu_io])
+
+
+def toggle_flag(offset):
+    f = open(disk, "r+b")
+    f.seek(offset, 0)
+    c = f.read(1)
+    toggled = chr(ord(c) ^ bitmap_flag_unknown)
+    f.seek(-1, 1)
+    f.write(toggled)
+    f.close()
+
+
+qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+
+for num in range(1, 4):
+    disabled = False
+    if num == 2:
+        disabled = True
+    log('Test {}'.format(num))
+    add_bitmap(num, num > 1, disabled)
+    write_to_disk((num-1) * chunk, chunk)
+    print_bitmap([])
+    log('')
+
+vm = iotests.VM().add_drive(disk)
+vm.launch()
+num += 1
+log('Test {}\nChecking "in-use" flag...'.format(num))
+print_bitmap(['--force-share'])
+vm.shutdown()
+
+num += 1
+log('\nTest {}\nWrite bitmap flag \'{}\' into the QCOW2 image at offset {}'
+    .format(num, hex(bitmap_flag_unknown), flag_offset))
+toggle_flag(flag_offset)
+img_info_log(disk)
+toggle_flag(flag_offset)
+log('Unset the unknown bitmap flag \'{}\' in the bitmap directory entry:\n'
+    .format(hex(bitmap_flag_unknown)))
+img_info_log(disk)
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
new file mode 100644
index 0000000..cf2b310
--- /dev/null
+++ b/tests/qemu-iotests/242.out
@@ -0,0 +1,167 @@
+Test 1
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 16384, "name": "bitmap-0", "node": "drive0", "persistent": false}}
+{"return": {}}
+wrote 262144/262144 bytes at offset 0
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
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
+Test 2
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 32768, "name": "bitmap-1", "node": "drive0", "persistent": true}}
+{"return": {}}
+wrote 262144/262144 bytes at offset 262144
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
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
+Test 3
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "bitmap-2", "node": "drive0", "persistent": true}}
+{"return": {}}
+wrote 262144/262144 bytes at offset 524288
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
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
+Test 4
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
+
+Test 5
+Write bitmap flag '0x4' into the QCOW2 image at offset 1048623
+qemu-img: Could not open 'TEST_IMG': Bitmap 'bitmap-2' doesn't satisfy the constraints
+
+Unset the unknown bitmap flag '0x4' in the bitmap directory entry:
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
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0f1c3f9..32acdd7 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -235,3 +235,4 @@
 235 auto quick
 236 auto quick
 238 auto quick
+242 rw auto quick
-- 
1.8.3.1
