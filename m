Received: from eggs.gnu.org ([209.51.188.92]:50828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1goBpT-0001d0-Tf
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1goBpR-0005Zq-DK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:40:19 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 28 Jan 2019 21:40:05 +0300
Message-Id: <1548700805-1016533-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v8 2/2] qemu-img info: bitmaps extension new
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
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

A new test file 239 added to the qemu-iotests set. It checks
the output format of 'qemu-img info' for bitmaps extension of
qcow2 specific information.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/239     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/239.out | 33 ++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 92 insertions(+)
 create mode 100755 tests/qemu-iotests/239
 create mode 100644 tests/qemu-iotests/239.out

diff --git a/tests/qemu-iotests/239 b/tests/qemu-iotests/239
new file mode 100755
index 0000000..db05096
--- /dev/null
+++ b/tests/qemu-iotests/239
@@ -0,0 +1,58 @@
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
+disk = file_path('disk')
+chunk = 256
+
+def add_bitmap(bitmap_number):
+    granularity = 2**(13 + bitmap_number)
+    bitmap_name = 'bitmap-' + str(bitmap_number)
+    vm = iotests.VM().add_drive(disk)
+    vm.launch()
+    vm.qmp_log('block-dirty-bitmap-add', node='drive0', name=bitmap_name,
+               granularity=granularity, persistent=True)
+    vm.shutdown()
+
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+
+
+for num in range(1, 4):
+    add_bitmap(num)
+    write = 'write {} {}K'.format((num-1)*chunk, chunk)
+    qemu_io('-f', iotests.imgfmt, '-c', write, disk)
+
+vm = iotests.VM().add_drive(disk)
+vm.launch()
+
+result = json.loads(qemu_img_pipe('info', '--force-share', '--output=json', disk))
+bitmaps = result['format-specific']['data']['bitmaps']
+
+vm.shutdown()
+
+log('bitmaps')
+log(bitmaps, indent=2)
diff --git a/tests/qemu-iotests/239.out b/tests/qemu-iotests/239.out
new file mode 100644
index 0000000..9085fc7
--- /dev/null
+++ b/tests/qemu-iotests/239.out
@@ -0,0 +1,33 @@
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 16384, "name": "bitmap-1", "node": "drive0", "persistent": true}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 32768, "name": "bitmap-2", "node": "drive0", "persistent": true}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap-3", "node": "drive0", "persistent": true}}
+{"return": {}}
+bitmaps
+[
+  {
+    "flags": [
+      "in-use",
+      "auto"
+    ],
+    "granularity": 16384,
+    "name": "bitmap-1"
+  },
+  {
+    "flags": [
+      "in-use",
+      "auto"
+    ],
+    "granularity": 32768,
+    "name": "bitmap-2"
+  },
+  {
+    "flags": [
+      "in-use",
+      "auto"
+    ],
+    "granularity": 65536,
+    "name": "bitmap-3"
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
