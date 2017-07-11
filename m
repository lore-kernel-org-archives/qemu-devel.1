Received: from eggs.gnu.org ([2001:4830:134:3::10]:34647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dUuXZ-0006O9-QV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dUuXY-0005ms-CZ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:45:21 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Tue, 11 Jul 2017 15:40:24 +0300
Message-Id: <20170711124024.1396-5-pbutsykin@virtuozzo.com>
In-Reply-To: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
References: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 4/4] qemu-iotests: add shrinking image test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org, pbutsykin@virtuozzo.com

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 tests/qemu-iotests/163     | 170 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/163.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 176 insertions(+)
 create mode 100644 tests/qemu-iotests/163
 create mode 100644 tests/qemu-iotests/163.out

diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
new file mode 100644
index 0000000000..403842354e
--- /dev/null
+++ b/tests/qemu-iotests/163
@@ -0,0 +1,170 @@
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
+import os, random, iotests, struct, qcow2
+from iotests import qemu_img, qemu_io, image_size
+
+test_img = os.path.join(iotests.test_dir, 'test.img')
+check_img = os.path.join(iotests.test_dir, 'check.img')
+
+def size_to_int(str):
+    suff = ['B', 'K', 'M', 'G', 'T']
+    return int(str[:-1]) * 1024**suff.index(str[-1:])
+
+class ShrinkBaseClass(iotests.QMPTestCase):
+    image_len = '128M'
+    shrink_size = '10M'
+    chunk_size = '16M'
+    refcount_bits = '16'
+
+    def __qcow2_check(self, filename):
+        entry_bits = 3
+        entry_size = 1 << entry_bits
+        l1_mask = 0x00fffffffffffe00
+        div_roundup = lambda n, d: (n + d - 1) / d
+
+        def split_by_n(data, n):
+            for x in xrange(0, len(data), n):
+                yield struct.unpack('>Q', data[x:x + n])[0] & l1_mask
+
+        def check_l1_table(h, l1_data):
+            l1_list = list(split_by_n(l1_data, entry_size))
+            real_l1_size = div_roundup(h.size,
+                                       1 << (h.cluster_bits*2 - entry_size))
+            used, unused = l1_list[:real_l1_size], l1_list[real_l1_size:]
+
+            self.assertTrue(len(used) != 0, "Verifying l1 table content")
+            self.assertFalse(any(unused), "Verifying l1 table content")
+
+        def check_reftable(fd, h, reftable):
+            for offset in split_by_n(reftable, entry_size):
+                if offset != 0:
+                    fd.seek(offset)
+                    cluster = fd.read(1 << h.cluster_bits)
+                    self.assertTrue(any(cluster), "Verifying reftable content")
+
+        with open(filename, "rb") as fd:
+            h = qcow2.QcowHeader(fd)
+
+            fd.seek(h.l1_table_offset)
+            l1_table = fd.read(h.l1_size << entry_bits)
+
+            fd.seek(h.refcount_table_offset)
+            reftable = fd.read(h.refcount_table_clusters << h.cluster_bits)
+
+            check_l1_table(h, l1_table)
+            check_reftable(fd, h, reftable)
+
+    def __raw_check(self, filename):
+        pass
+
+    image_check = {
+        'qcow2' : __qcow2_check,
+        'raw' : __raw_check
+    }
+
+    def setUp(self):
+        if iotests.imgfmt == 'raw':
+            qemu_img('create', '-f', iotests.imgfmt, test_img, self.image_len)
+            qemu_img('create', '-f', iotests.imgfmt, check_img,
+                     self.shrink_size)
+        else:
+            qemu_img('create', '-f', iotests.imgfmt,
+                     '-o', 'cluster_size=' + self.cluster_size +
+                     ',refcount_bits=' + self.refcount_bits,
+                     test_img, self.image_len)
+            qemu_img('create', '-f', iotests.imgfmt,
+                     '-o', 'cluster_size=%s'% self.cluster_size,
+                     check_img, self.shrink_size)
+        qemu_io('-c', 'write -P 0xff 0 ' + self.shrink_size, check_img)
+
+    def tearDown(self):
+        os.remove(test_img)
+        os.remove(check_img)
+
+    def image_verify(self):
+        self.assertEqual(image_size(test_img), image_size(check_img),
+                         "Verifying image size")
+        self.image_check[iotests.imgfmt](self, test_img)
+
+        if iotests.imgfmt == 'raw':
+            return
+        self.assertEqual(qemu_img('check', test_img), 0,
+                         "Verifying image corruption")
+
+    def test_empty_image(self):
+        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', test_img,
+                 self.shrink_size)
+
+        self.assertEqual(
+            qemu_io('-c', 'read -P 0x00 %s'%self.shrink_size, test_img),
+            qemu_io('-c', 'read -P 0x00 %s'%self.shrink_size, check_img),
+            "Verifying image content")
+
+        self.image_verify()
+
+    def test_sequential_write(self):
+        for offs in range(0, size_to_int(self.image_len),
+                          size_to_int(self.chunk_size)):
+            qemu_io('-c', 'write -P 0xff %d %s' % (offs, self.chunk_size),
+                    test_img)
+
+        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', test_img,
+                 self.shrink_size)
+
+        self.assertEqual(qemu_img("compare", test_img, check_img), 0,
+                         "Verifying image content")
+
+        self.image_verify()
+
+    def test_random_write(self):
+        offs_list = range(0, size_to_int(self.image_len),
+                          size_to_int(self.chunk_size))
+        random.shuffle(offs_list)
+        for offs in offs_list:
+            qemu_io('-c', 'write -P 0xff %d %s' % (offs, self.chunk_size),
+                    test_img)
+
+        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', test_img,
+                 self.shrink_size)
+
+        self.assertEqual(qemu_img("compare", test_img, check_img), 0,
+                         "Verifying image content")
+
+        self.image_verify()
+
+class TestShrink512(ShrinkBaseClass):
+    image_len = '3M'
+    shrink_size = '1M'
+    chunk_size = '256K'
+    cluster_size = '512'
+    refcount_bits = '64'
+
+class TestShrink64K(ShrinkBaseClass):
+    cluster_size = '64K'
+
+class TestShrink1M(ShrinkBaseClass):
+    cluster_size = '1M'
+    refcount_bits = '1'
+
+ShrinkBaseClass = None
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['raw', 'qcow2'])
diff --git a/tests/qemu-iotests/163.out b/tests/qemu-iotests/163.out
new file mode 100644
index 0000000000..dae404e278
--- /dev/null
+++ b/tests/qemu-iotests/163.out
@@ -0,0 +1,5 @@
+.........
+----------------------------------------------------------------------
+Ran 9 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 318ae74b10..542947eeba 100644
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
