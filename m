Received: from eggs.gnu.org ([209.51.188.92]:53330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDsAw-0001ut-2u
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDsAu-0006mS-NZ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:56:38 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue,  9 Apr 2019 17:56:32 +0300
Message-Id: <1554821792-968307-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] iotests: new test 253 check qemu-img
 convert force read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

A new test for the patch 'qemu-img convert: ignore read errors'

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/253     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/253.out |  4 +++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 74 insertions(+)
 create mode 100755 tests/qemu-iotests/253
 create mode 100644 tests/qemu-iotests/253.out

diff --git a/tests/qemu-iotests/253 b/tests/qemu-iotests/253
new file mode 100755
index 0000000..671a3c4
--- /dev/null
+++ b/tests/qemu-iotests/253
@@ -0,0 +1,69 @@
+#!/usr/bin/env python
+#
+# Test of the 'qemu-img convert' for a damaged image.
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
+import os
+from iotests import qemu_img_create, qemu_io, qemu_img_pipe, \
+    file_path, log
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+disk = file_path('disk')
+chunk = 256 * 1024
+bad_sector = 768
+blkdebug_file = os.path.join(iotests.test_dir, 'blkdebug.conf')
+
+
+def create_blkdebug_file():
+    file = open(blkdebug_file, 'w')
+    file.write('''
+[inject-error]
+event = "read_aio"
+errno = "5"
+once ="off"
+sector = "%d"
+''' % (bad_sector))
+    file.close()
+
+
+def write_to_disk(offset, size):
+    write = 'write -P 7 {} {}'.format(offset, size)
+    qemu_io('-c', write, disk)
+
+
+qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+
+for num in range(1, 4):
+    write_to_disk((num-1) * chunk, chunk)
+
+create_blkdebug_file()
+disk_converted = disk + '_converted'
+log(qemu_img_pipe('convert', '-O', iotests.imgfmt, 'blkdebug:%s:%s'
+                  % (blkdebug_file, disk), disk_converted))
+log(qemu_img_pipe('convert', '-O', iotests.imgfmt, '-R', 'blkdebug:%s:%s'
+                  % (blkdebug_file, disk), disk_converted))
+
+# TODO: with a class, self.assertNotEqual(
+#       qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', disk),
+#       qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', disk_converted),
+#               'image file map matches the copied file after conversion')
+
+os.remove(disk_converted)
+os.remove(blkdebug_file)
diff --git a/tests/qemu-iotests/253.out b/tests/qemu-iotests/253.out
new file mode 100644
index 0000000..b972541
--- /dev/null
+++ b/tests/qemu-iotests/253.out
@@ -0,0 +1,4 @@
+qemu-img: error while reading sector 0: Input/output error
+
+qemu-img: failed to read 786432 bytes at offset 0: Input/output error
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index bae7718..4cd2fe8 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -248,3 +248,4 @@
 246 rw auto quick
 247 rw auto quick
 248 rw auto quick
+253 rw auto quick
-- 
1.8.3.1
