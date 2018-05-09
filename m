Received: from eggs.gnu.org ([2001:4830:134:3::10]:52961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwr-00069n-4w
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwq-00039G-04
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:36 +0200
Message-Id: <20180509162637.15575-42-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 41/42] iotests: Move qmp_to_opts() to VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

qmp_to_opts() used to be a method of QMPTestCase, but recently we
started to add more Python test cases that don't make use of
QMPTestCase. In order to make the method usable there, move it to VM.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/041        |  6 +++---
 tests/qemu-iotests/155        |  2 +-
 tests/qemu-iotests/iotests.py | 45 ++++++++++++++++++++++---------------------
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index e94587950c..c20ac7da87 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1030,9 +1030,9 @@ class TestOrphanedSource(iotests.QMPTestCase):
                  'read-only': 'on' }
 
         self.vm = iotests.VM()
-        self.vm.add_blockdev(self.qmp_to_opts(blk0))
-        self.vm.add_blockdev(self.qmp_to_opts(blk1))
-        self.vm.add_blockdev(self.qmp_to_opts(blk2))
+        self.vm.add_blockdev(self.vm.qmp_to_opts(blk0))
+        self.vm.add_blockdev(self.vm.qmp_to_opts(blk1))
+        self.vm.add_blockdev(self.vm.qmp_to_opts(blk2))
         self.vm.launch()
 
     def tearDown(self):
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index 42dae04c83..63a5b5e2c0 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -63,7 +63,7 @@ class BaseClass(iotests.QMPTestCase):
                     'driver': iotests.imgfmt,
                     'file': {'driver': 'file',
                              'filename': source_img}}
-        self.vm.add_blockdev(self.qmp_to_opts(blockdev))
+        self.vm.add_blockdev(self.vm.qmp_to_opts(blockdev))
         self.vm.add_device('virtio-blk,id=qdev0,drive=source')
         self.vm.launch()
 
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b25d48a91b..7040f71b57 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -363,6 +363,27 @@ class VM(qtest.QEMUQtestMachine):
         return self.qmp('human-monitor-command',
                         command_line='qemu-io %s "%s"' % (drive, cmd))
 
+    def flatten_qmp_object(self, obj, output=None, basestr=''):
+        if output is None:
+            output = dict()
+        if isinstance(obj, list):
+            for i in range(len(obj)):
+                self.flatten_qmp_object(obj[i], output, basestr + str(i) + '.')
+        elif isinstance(obj, dict):
+            for key in obj:
+                self.flatten_qmp_object(obj[key], output, basestr + key + '.')
+        else:
+            output[basestr[:-1]] = obj # Strip trailing '.'
+        return output
+
+    def qmp_to_opts(self, obj):
+        obj = self.flatten_qmp_object(obj)
+        output_list = list()
+        for key in obj:
+            output_list += [key + '=' + obj[key]]
+        return ','.join(output_list)
+
+
 
 index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
 
@@ -390,26 +411,6 @@ class QMPTestCase(unittest.TestCase):
                     self.fail('invalid index "%s" in path "%s" in "%s"' % (idx, path, str(d)))
         return d
 
-    def flatten_qmp_object(self, obj, output=None, basestr=''):
-        if output is None:
-            output = dict()
-        if isinstance(obj, list):
-            for i in range(len(obj)):
-                self.flatten_qmp_object(obj[i], output, basestr + str(i) + '.')
-        elif isinstance(obj, dict):
-            for key in obj:
-                self.flatten_qmp_object(obj[key], output, basestr + key + '.')
-        else:
-            output[basestr[:-1]] = obj # Strip trailing '.'
-        return output
-
-    def qmp_to_opts(self, obj):
-        obj = self.flatten_qmp_object(obj)
-        output_list = list()
-        for key in obj:
-            output_list += [key + '=' + obj[key]]
-        return ','.join(output_list)
-
     def assert_qmp_absent(self, d, path):
         try:
             result = self.dictpath(d, path)
@@ -444,8 +445,8 @@ class QMPTestCase(unittest.TestCase):
         '''Asserts that the given filename is a json: filename and that its
            content is equal to the given reference object'''
         self.assertEqual(json_filename[:5], 'json:')
-        self.assertEqual(self.flatten_qmp_object(json.loads(json_filename[5:])),
-                         self.flatten_qmp_object(reference))
+        self.assertEqual(self.vm.flatten_qmp_object(json.loads(json_filename[5:])),
+                         self.vm.flatten_qmp_object(reference))
 
     def cancel_and_wait(self, drive='drive0', force=False, resume=False):
         '''Cancel a block job and wait for it to finish, returning the event'''
-- 
2.13.6
