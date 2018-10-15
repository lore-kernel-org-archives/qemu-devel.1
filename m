Received: from eggs.gnu.org ([2001:4830:134:3::10]:48714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC3eT-00006o-1w
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC3eK-0007QL-OJ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:15:18 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Oct 2018 16:14:49 +0200
Message-Id: <20181015141453.32632-6-mreitz@redhat.com>
In-Reply-To: <20181015141453.32632-1-mreitz@redhat.com>
References: <20181015141453.32632-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 5/9] iotests: Different iterator behavior in
 Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

In Python 3, several functions now return iterators instead of lists.
This includes range(), items(), map(), and filter().  This means that if
we really want a list, we have to wrap those instances with list().  On
the other hand, sometimes we do just want an iterator, in which case we
have sometimes used xrange() and iteritems() which no longer exist in
Python 3.  Just change these calls to be range() and items(), which
costs a bit of performance in Python 2, but will do the right thing in
Python 3 (which is what is important).

In one instance, we only wanted the first instance of the result of a
filter() call.  Instead of using next(filter()) which would work only in
Python 3, or list(filter())[0] which would work everywhere but is a bit
weird, this instance is changed to a single-line for with next() wrapped
around, which works both in 2.7 and 3.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/044 | 12 ++++++------
 tests/qemu-iotests/056 |  2 +-
 tests/qemu-iotests/065 |  4 ++--
 tests/qemu-iotests/124 |  4 ++--
 tests/qemu-iotests/139 |  2 +-
 tests/qemu-iotests/163 |  6 +++---
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 7ef5e46fe9..e2d6c9b189 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -52,23 +52,23 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
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
@@ -79,14 +79,14 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
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
index 72aa9707c7..a339bf6069 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -59,7 +59,7 @@ class TestQemuImgInfo(TestImageInfoSpecific):
                     :data.index('')]
         for field in data:
             self.assertTrue(re.match('^ {4}[^ ]', field) is not None)
-        data = map(lambda line: line.strip(), data)
+        data = list(map(lambda line: line.strip(), data))
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
index cc7fe337f3..e00f10b8c8 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -51,7 +51,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
     # Check whether a BlockDriverState exists
     def checkBlockDriverState(self, node, must_exist = True):
         result = self.vm.qmp('query-named-block-nodes')
-        nodes = filter(lambda x: x['node-name'] == node, result['return'])
+        nodes = list(filter(lambda x: x['node-name'] == node, result['return']))
         self.assertLessEqual(len(nodes), 1)
         self.assertEqual(must_exist, len(nodes) == 1)
 
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index 5fd424761b..35c1a2bafc 100755
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -41,7 +41,7 @@ class ShrinkBaseClass(iotests.QMPTestCase):
         div_roundup = lambda n, d: (n + d - 1) // d
 
         def split_by_n(data, n):
-            for x in xrange(0, len(data), n):
+            for x in range(0, len(data), n):
                 yield struct.unpack('>Q', data[x:x + n])[0] & l1_mask
 
         def check_l1_table(h, l1_data):
@@ -135,8 +135,8 @@ class ShrinkBaseClass(iotests.QMPTestCase):
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
2.17.1
