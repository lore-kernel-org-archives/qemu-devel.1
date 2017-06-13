Received: from eggs.gnu.org ([2001:4830:134:3::10]:60695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dKkmP-00011u-QU
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dKkmL-0007Fg-Pp
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:18:41 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Tue, 13 Jun 2017 15:16:39 +0300
Message-Id: <20170613121639.17853-5-pbutsykin@virtuozzo.com>
In-Reply-To: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/4] qemu-iotests: add shrinking image test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, pbutsykin@virtuozzo.com, den@openvz.org

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 tests/qemu-iotests/163     | 113 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/163.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 119 insertions(+)
 create mode 100644 tests/qemu-iotests/163
 create mode 100644 tests/qemu-iotests/163.out

diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
new file mode 100644
index 0000000000..2cb0116173
--- /dev/null
+++ b/tests/qemu-iotests/163
@@ -0,0 +1,113 @@
+#!/usr/bin/env python
+#
+# Tests for shrinking images
+#
+# Copyright (c) 2016-2017 Parallels International GmbH
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
+import os, random, iotests
+from iotests import qemu_img, qemu_io, image_size
+
+test_img = os.path.join(iotests.test_dir, 'test.img')
+check_img = os.path.join(iotests.test_dir, 'check.img')
+
+def size_to_int(str):
+    suff = ['B', 'K', 'M', 'G', 'T']
+    return int(str[:-1]) * 1024**suff.index(str[-1:])
+
+class TestShrink(iotests.QMPTestCase):
+    image_len = '1G'
+    shrink_size = '128M'
+    chank_size = '256M'
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, TestShrink.image_len)
+        qemu_img('create', '-f', iotests.imgfmt, check_img,
+                 TestShrink.shrink_size)
+
+    def tearDown(self):
+        os.remove(test_img)
+        os.remove(check_img)
+
+    def image_verify(self):
+        self.assertEqual(image_size(test_img), image_size(check_img),
+                         "Verifying image size")
+
+        if iotests.imgfmt == 'raw':
+            return
+
+        self.assertEqual(qemu_img('check', test_img),
+                         qemu_img('check', check_img),
+                         "Verifying image corruption")
+
+    def test_empty_image(self):
+        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', test_img,
+                 TestShrink.shrink_size)
+
+        self.assertEqual(
+            qemu_io('-c', 'read -P 0x00 %s'%TestShrink.shrink_size, test_img),
+            qemu_io('-c', 'read -P 0x00 %s'%TestShrink.shrink_size, check_img),
+            "Verifying image content")
+
+        TestShrink.image_verify(self)
+
+    def test_sequential_write(self):
+        for offs in range(0, size_to_int(TestShrink.image_len),
+                          size_to_int(TestShrink.chank_size)):
+            qemu_io('-c', 'write -P 0xff %d %s' % (offs, TestShrink.chank_size),
+                    test_img)
+
+        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', test_img,
+                 TestShrink.shrink_size)
+
+        self.assertEqual(
+            qemu_io('-c', 'read -P 0xff %s'%TestShrink.image_len, test_img),
+            qemu_io('-c', 'read -P 0xff %s'%TestShrink.image_len, check_img),
+            "Verifying image content")
+
+        self.assertEqual(
+            qemu_io('-c', 'read -P 0xff %s'%TestShrink.shrink_size, test_img),
+            qemu_io('-c', 'read -P 0xff %s'%TestShrink.shrink_size, check_img),
+            "Verifying image content")
+
+        TestShrink.image_verify(self)
+
+    def test_random_write(self):
+        offs_list = range(0, size_to_int(TestShrink.image_len),
+                          size_to_int(TestShrink.chank_size))
+        random.shuffle(offs_list)
+        for offs in offs_list:
+            qemu_io('-c', 'write -P 0xff %d %s' % (offs, TestShrink.chank_size),
+                    test_img)
+
+        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', test_img,
+                 TestShrink.shrink_size)
+
+        self.assertEqual(
+            qemu_io('-c', 'read -P 0xff %s'%TestShrink.image_len, test_img),
+            qemu_io('-c', 'read -P 0xff %s'%TestShrink.image_len, check_img),
+            "Verifying image content")
+
+        self.assertEqual(
+            qemu_io('-c', 'read -P 0xff %s'%TestShrink.shrink_size, test_img),
+            qemu_io('-c', 'read -P 0xff %s'%TestShrink.shrink_size, check_img),
+            "Verifying image content")
+
+        TestShrink.image_verify(self)
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['raw', 'qcow2'])
diff --git a/tests/qemu-iotests/163.out b/tests/qemu-iotests/163.out
new file mode 100644
index 0000000000..8d7e996700
--- /dev/null
+++ b/tests/qemu-iotests/163.out
@@ -0,0 +1,5 @@
+...
+----------------------------------------------------------------------
+Ran 3 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5c8ea0f95c..a2f42e7165 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -163,6 +163,7 @@
 159 rw auto quick
 160 rw auto quick
 162 auto quick
+163 rw auto quick
 170 rw auto quick
 171 rw auto quick
 172 auto
-- 
2.13.0
