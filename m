Received: from eggs.gnu.org ([209.51.188.92]:53671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtIYY-0007DF-A9
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtIYW-0006gq-8w
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:51:57 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Feb 2019 14:51:28 -0600
Message-Id: <20190211205128.27146-5-eblake@redhat.com>
In-Reply-To: <20190211205128.27146-1-eblake@redhat.com>
References: <20190211205128.27146-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] qcow2: list of bitmaps new test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

A new test file 242 added to the qemu-iotests set. It checks
the format of qcow2 specific information for the new added
section that lists details of bitmaps.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <1549638368-530182-4-git-send-email-andrey.shinkevich@virtuoz=
zo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: pep8 compliance, avoid trailing blank line]
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/242     | 104 +++++++++++++++++++++++
 tests/qemu-iotests/242.out | 166 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 271 insertions(+)
 create mode 100755 tests/qemu-iotests/242
 create mode 100644 tests/qemu-iotests/242.out

diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
new file mode 100755
index 00000000000..16c65edcd7f
--- /dev/null
+++ b/tests/qemu-iotests/242
@@ -0,0 +1,104 @@
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
+iotests.verify_image_format(supported_fmts=3D['qcow2'])
+
+disk =3D file_path('disk')
+chunk =3D 256 * 1024
+bitmap_flag_unknown =3D 1 << 2
+# flag_offset =3D 5*cluster_size + flag_offset_in_bitmap_directory_entry
+flag_offset =3D 0x5000f
+
+
+def print_bitmap(extra_args):
+    log('qemu-img info dump:\n')
+    img_info_log(disk, extra_args=3Dextra_args)
+    result =3D json.loads(qemu_img_pipe('info', '--force-share',
+                                      '--output=3Djson', disk))
+    if 'bitmaps' in result['format-specific']['data']:
+        bitmaps =3D result['format-specific']['data']['bitmaps']
+        log('The same bitmaps in JSON format:')
+        log(bitmaps, indent=3D2)
+    else:
+        log('No bitmap in JSON format output')
+
+
+def add_bitmap(bitmap_number, persistent, disabled):
+    granularity =3D 1 << (13 + bitmap_number)
+    bitmap_name =3D 'bitmap-' + str(bitmap_number-1)
+    vm =3D iotests.VM().add_drive(disk)
+    vm.launch()
+    vm.qmp_log('block-dirty-bitmap-add', node=3D'drive0', name=3Dbitmap_=
name,
+               granularity=3Dgranularity, persistent=3Dpersistent,
+               disabled=3Ddisabled)
+    vm.shutdown()
+
+
+def write_to_disk(offset, size):
+    write =3D 'write {} {}'.format(offset, size)
+    log(qemu_io('-c', write, disk), filters=3D[filter_qemu_io])
+
+
+def toggle_flag(offset):
+    with open(disk, "r+b") as f:
+        f.seek(offset, 0)
+        c =3D f.read(1)
+        toggled =3D chr(ord(c) ^ bitmap_flag_unknown)
+        f.seek(-1, 1)
+        f.write(toggled)
+
+
+qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+
+for num in range(1, 4):
+    disabled =3D False
+    if num =3D=3D 2:
+        disabled =3D True
+    log('Test {}'.format(num))
+    add_bitmap(num, num > 1, disabled)
+    write_to_disk((num-1) * chunk, chunk)
+    print_bitmap([])
+    log('')
+
+vm =3D iotests.VM().add_drive(disk)
+vm.launch()
+num +=3D 1
+log('Test {}\nChecking "in-use" flag...'.format(num))
+print_bitmap(['--force-share'])
+vm.shutdown()
+
+num +=3D 1
+log('\nTest {}'.format(num))
+qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+add_bitmap(1, True, False)
+log('Write an unknown bitmap flag \'{}\' into a new QCOW2 image at offse=
t {}'
+    .format(hex(bitmap_flag_unknown), flag_offset))
+toggle_flag(flag_offset)
+img_info_log(disk)
+toggle_flag(flag_offset)
+log('Unset the unknown bitmap flag \'{}\' in the bitmap directory entry:=
\n'
+    .format(hex(bitmap_flag_unknown)))
+img_info_log(disk)
+log('Test complete')
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
new file mode 100644
index 00000000000..fbe05d71c09
--- /dev/null
+++ b/tests/qemu-iotests/242.out
@@ -0,0 +1,166 @@
+Test 1
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "=
granularity": 16384, "name": "bitmap-0", "node": "drive0", "persistent": =
false}}
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
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "g=
ranularity": 32768, "name": "bitmap-1", "node": "drive0", "persistent": t=
rue}}
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
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "=
granularity": 65536, "name": "bitmap-2", "node": "drive0", "persistent": =
true}}
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
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "=
granularity": 16384, "name": "bitmap-0", "node": "drive0", "persistent": =
true}}
+{"return": {}}
+Write an unknown bitmap flag '0x4' into a new QCOW2 image at offset 3276=
95
+qemu-img: Could not open 'TEST_IMG': Bitmap 'bitmap-0' doesn't satisfy t=
he constraints
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
+                [0]: auto
+            name: bitmap-0
+            granularity: 16384
+    refcount bits: 16
+    corrupt: false
+
+Test complete
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 959ffe85fc3..fc4c416fa3a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -238,3 +238,4 @@
 238 auto quick
 239 rw auto quick
 240 auto quick
+242 rw auto quick
--=20
2.20.1
