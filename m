Received: from eggs.gnu.org ([2001:4830:134:3::10]:36201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv695-0002c8-MC
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv694-0004Bp-S9
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:52:03 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 19:51:50 +0200
Message-Id: <20170403175150.15253-3-mreitz@redhat.com>
In-Reply-To: <20170403175150.15253-1-mreitz@redhat.com>
References: <20170403175150.15253-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 2/2] iotests: Add mirror tests for
 orphaned source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041        | 46 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out    |  4 ++--
 tests/qemu-iotests/iotests.py | 15 ++++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index bc6cf782fe..2f54986434 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -966,5 +966,51 @@ class TestRepairQuorum(iotests.QMPTestCase):
         #       to check that this file is really driven by quorum
         self.vm.shutdown()
 
+# Test mirroring with a source that does not have any parents (not even a
+# BlockBackend)
+class TestOrphanedSource(iotests.QMPTestCase):
+    def setUp(self):
+        blk0 = { 'node-name': 'src',
+                 'driver': 'null-co' }
+
+        blk1 = { 'node-name': 'dest',
+                 'driver': 'null-co' }
+
+        blk2 = { 'node-name': 'dest-ro',
+                 'driver': 'null-co',
+                 'read-only': 'on' }
+
+        self.vm = iotests.VM()
+        self.vm.add_blockdev(self.qmp_to_opts(blk0))
+        self.vm.add_blockdev(self.qmp_to_opts(blk1))
+        self.vm.add_blockdev(self.qmp_to_opts(blk2))
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+    def test_no_job_id(self):
+        self.assert_no_active_block_jobs()
+
+        result = self.vm.qmp('blockdev-mirror', device='src', sync='full',
+                             target='dest')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
+    def test_success(self):
+        self.assert_no_active_block_jobs()
+
+        result = self.vm.qmp('blockdev-mirror', job_id='job', device='src',
+                             sync='full', target='dest')
+        self.assert_qmp(result, 'return', {})
+
+        self.complete_and_wait('job')
+
+    def test_failing_permissions(self):
+        self.assert_no_active_block_jobs()
+
+        result = self.vm.qmp('blockdev-mirror', device='src', sync='full',
+                             target='dest-ro')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index b67d0504a6..e30fd3b05b 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-............................................................................
+...............................................................................
 ----------------------------------------------------------------------
-Ran 76 tests
+Ran 79 tests
 
 OK
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index bec8eb4b8d..abcf3c10e2 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -177,6 +177,14 @@ class VM(qtest.QEMUQtestMachine):
         self._num_drives += 1
         return self
 
+    def add_blockdev(self, opts):
+        self._args.append('-blockdev')
+        if isinstance(opts, str):
+            self._args.append(opts)
+        else:
+            self._args.append(','.join(opts))
+        return self
+
     def pause_drive(self, drive, event=None):
         '''Pause drive r/w operations'''
         if not event:
@@ -235,6 +243,13 @@ class QMPTestCase(unittest.TestCase):
             output[basestr[:-1]] = obj # Strip trailing '.'
         return output
 
+    def qmp_to_opts(self, obj):
+        obj = self.flatten_qmp_object(obj)
+        output_list = list()
+        for key in obj:
+            output_list += [key + '=' + obj[key]]
+        return ','.join(output_list)
+
     def assert_qmp_absent(self, d, path):
         try:
             result = self.dictpath(d, path)
-- 
2.12.1
