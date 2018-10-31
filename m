Received: from eggs.gnu.org ([2001:4830:134:3::10]:43040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQM-0002BL-Vq
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQJ-0003r7-MW
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:31:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:31:11 -0300
Message-Id: <20181031003120.26771-7-ehabkost@redhat.com>
In-Reply-To: <20181031003120.26771-1-ehabkost@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] iotests: Different iterator behavior in
 Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Max Reitz <mreitz@redhat.com>

In Python 3, several functions now return iterators instead of lists.
This includes range(), items(), map(), and filter().  This means that if
we really want a list, we have to wrap those instances with list().  But
then again, the two instances where this is the case for map() and
filter(), there are shorter expressions which work without either
function.

On the other hand, sometimes we do just want an iterator, in which case
we have sometimes used xrange() and iteritems() which no longer exist in
Python 3.  Just change these calls to be range() and items(), works in
both Python 2 and 3, and is really what we want in 3 (which is what
matters).  But because it is so simple to do (and to find and remove
once we completely switch to Python 3), make range() be an alias for
xrange() in the two affected tests (044 and 163).

In one instance, we only wanted the first instance of the result of a
filter() call.  Instead of using next(filter()) which would work only in
Python 3, or list(filter())[0] which would work everywhere but is a bit
weird, this instance is changed to use a generator expression with a
next() wrapped around, which works both in 2.7 and 3.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20181022135307.14398-6-mreitz@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/qemu-iotests/044 | 16 ++++++++++------
 tests/qemu-iotests/056 |  2 +-
 tests/qemu-iotests/065 |  4 ++--
 tests/qemu-iotests/124 |  4 ++--
 tests/qemu-iotests/139 |  2 +-
 tests/qemu-iotests/163 | 11 +++++++----
 6 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 7ef5e46fe9..9ec3dba734 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -26,6 +26,10 @@ import iotests
 from iotests import qemu_img, qemu_img_verbose, qemu_io
 import struct
 import subprocess
+import sys
+
+if sys.version_info.major == 2:
+    range = xrange
 
 test_img = os.path.join(iotests.test_dir, 'test.img')
 
@@ -52,23 +56,23 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
             # Write a refcount table
             fd.seek(off_reftable)
 
-            for i in xrange(0, h.refcount_table_clusters):
+            for i in range(0, h.refcount_table_clusters):
                 sector = b''.join(struct.pack('>Q',
                     off_refblock + i * 64 * 512 + j * 512)
-                    for j in xrange(0, 64))
+                    for j in range(0, 64))
                 fd.write(sector)
 
             # Write the refcount blocks
             assert(fd.tell() == off_refblock)
             sector = b''.join(struct.pack('>H', 1) for j in range(0, 64 * 256))
-            for block in xrange(0, h.refcount_table_clusters):
+            for block in range(0, h.refcount_table_clusters):
                 fd.write(sector)
 
             # Write the L1 table
             assert(fd.tell() == off_l1)
             assert(off_l2 + 512 * h.l1_size == off_data)
             table = b''.join(struct.pack('>Q', (1 << 63) | off_l2 + 512 * j)
-                for j in xrange(0, h.l1_size))
+                for j in range(0, h.l1_size))
             fd.write(table)
 
             # Write the L2 tables
@@ -79,14 +83,14 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
             off = off_data
             while remaining > 1024 * 512:
                 pytable = list((1 << 63) | off + 512 * j
-                    for j in xrange(0, 1024))
+                    for j in range(0, 1024))
                 table = struct.pack('>1024Q', *pytable)
                 fd.write(table)
                 remaining = remaining - 1024 * 512
                 off = off + 1024 * 512
 
             table = b''.join(struct.pack('>Q', (1 << 63) | off + 512 * j)
-                for j in xrange(0, remaining // 512))
+                for j in range(0, remaining // 512))
             fd.write(table)
 
 
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 223292175a..3df323984d 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -32,7 +32,7 @@ target_img = os.path.join(iotests.test_dir, 'target.img')
 def img_create(img, fmt=iotests.imgfmt, size='64M', **kwargs):
     fullname = os.path.join(iotests.test_dir, '%s.%s' % (img, fmt))
     optargs = []
-    for k,v in kwargs.iteritems():
+    for k,v in kwargs.items():
         optargs = optargs + ['-o', '%s=%s' % (k,v)]
     args = ['create', '-f', fmt] + optargs + [fullname, size]
     iotests.qemu_img(*args)
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 72aa9707c7..8bac383ea7 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -59,7 +59,7 @@ class TestQemuImgInfo(TestImageInfoSpecific):
                     :data.index('')]
         for field in data:
             self.assertTrue(re.match('^ {4}[^ ]', field) is not None)
-        data = map(lambda line: line.strip(), data)
+        data = [line.strip() for line in data]
         self.assertEqual(data, self.human_compare)
 
 class TestQMP(TestImageInfoSpecific):
@@ -80,7 +80,7 @@ class TestQMP(TestImageInfoSpecific):
 
     def test_qmp(self):
         result = self.vm.qmp('query-block')['return']
-        drive = filter(lambda drive: drive['device'] == 'drive0', result)[0]
+        drive = next(drive for drive in result if drive['device'] == 'drive0')
         data = drive['inserted']['image']['format-specific']
         self.assertEqual(data['type'], iotests.imgfmt)
         self.assertEqual(data['data'], self.compare)
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 3ea4ac53f5..9f189e3b54 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -39,7 +39,7 @@ def try_remove(img):
 def transaction_action(action, **kwargs):
     return {
         'type': action,
-        'data': dict((k.replace('_', '-'), v) for k, v in kwargs.iteritems())
+        'data': dict((k.replace('_', '-'), v) for k, v in kwargs.items())
     }
 
 
@@ -134,7 +134,7 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
     def img_create(self, img, fmt=iotests.imgfmt, size='64M',
                    parent=None, parentFormat=None, **kwargs):
         optargs = []
-        for k,v in kwargs.iteritems():
+        for k,v in kwargs.items():
             optargs = optargs + ['-o', '%s=%s' % (k,v)]
         args = ['create', '-f', fmt] + optargs + [img, size]
         if parent:
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index cc7fe337f3..62402c1c35 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -51,7 +51,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
     # Check whether a BlockDriverState exists
     def checkBlockDriverState(self, node, must_exist = True):
         result = self.vm.qmp('query-named-block-nodes')
-        nodes = filter(lambda x: x['node-name'] == node, result['return'])
+        nodes = [x for x in result['return'] if x['node-name'] == node]
         self.assertLessEqual(len(nodes), 1)
         self.assertEqual(must_exist, len(nodes) == 1)
 
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index 5fd424761b..158ba5d092 100755
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -18,9 +18,12 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-import os, random, iotests, struct, qcow2
+import os, random, iotests, struct, qcow2, sys
 from iotests import qemu_img, qemu_io, image_size
 
+if sys.version_info.major == 2:
+    range = xrange
+
 test_img = os.path.join(iotests.test_dir, 'test.img')
 check_img = os.path.join(iotests.test_dir, 'check.img')
 
@@ -41,7 +44,7 @@ class ShrinkBaseClass(iotests.QMPTestCase):
         div_roundup = lambda n, d: (n + d - 1) // d
 
         def split_by_n(data, n):
-            for x in xrange(0, len(data), n):
+            for x in range(0, len(data), n):
                 yield struct.unpack('>Q', data[x:x + n])[0] & l1_mask
 
         def check_l1_table(h, l1_data):
@@ -135,8 +138,8 @@ class ShrinkBaseClass(iotests.QMPTestCase):
         self.image_verify()
 
     def test_random_write(self):
-        offs_list = range(0, size_to_int(self.image_len),
-                          size_to_int(self.chunk_size))
+        offs_list = list(range(0, size_to_int(self.image_len),
+                               size_to_int(self.chunk_size)))
         random.shuffle(offs_list)
         for offs in offs_list:
             qemu_io('-c', 'write -P 0xff %d %s' % (offs, self.chunk_size),
-- 
2.18.0.rc1.1.g3f1ff2140
