Received: from eggs.gnu.org ([2001:4830:134:3::10]:59662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gPu1S-0003O9-Kz
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gPu1P-00074U-Ui
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:48:18 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu, 22 Nov 2018 21:48:07 +0300
Message-Id: <1542912487-279165-6-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1542912487-279165-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1542912487-279165-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/5] iotests: 030 with block-stream discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The classes that set tests for the block-stream command with discard
option on are inherited from the existent classes in the 030 file.
Some QMP commands do not have the optional 'discard' argument because
the WRITE permission is not being granted when the filter is inserted.
For instance, it is true while streaming into an inactive layer.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/030     | 143 ++++++++++++++++++++++++++++++++++-----------
 tests/qemu-iotests/030.out |   4 +-
 2 files changed, 111 insertions(+), 36 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 5d148b0..eba2fff 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -29,6 +29,7 @@ test_img = os.path.join(iotests.test_dir, 'test.img')
 
 class TestSingleDrive(iotests.QMPTestCase):
     image_len = 1 * 1024 * 1024 # MB
+    do_discard = False
 
     def setUp(self):
         iotests.create_image(backing_img, TestSingleDrive.image_len)
@@ -49,7 +50,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_stream(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0')
         self.assert_qmp(result, 'return', {})
 
         self.wait_until_completed()
@@ -84,7 +86,8 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp('block-stream', device='drive0')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0')
         self.assert_qmp(result, 'return', {})
 
         self.pause_job('drive0', wait=False)
@@ -117,7 +120,8 @@ class TestSingleDrive(iotests.QMPTestCase):
         empty_map = qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', test_img)
 
         # This is a no-op: no data should ever be copied from the base image
-        result = self.vm.qmp('block-stream', device='drive0', base=mid_img)
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0', base=mid_img)
         self.assert_qmp(result, 'return', {})
 
         self.wait_until_completed()
@@ -131,7 +135,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_stream_partial(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', base=backing_img)
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0', base=backing_img)
         self.assert_qmp(result, 'return', {})
 
         self.wait_until_completed()
@@ -144,11 +149,13 @@ class TestSingleDrive(iotests.QMPTestCase):
                          'image file map does not match backing file after streaming')
 
     def test_device_not_found(self):
-        result = self.vm.qmp('block-stream', device='nonexistent')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='nonexistent')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_job_id_missing(self):
-        result = self.vm.qmp('block-stream', device='mid')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='mid')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
 
@@ -157,6 +164,7 @@ class TestParallelOps(iotests.QMPTestCase):
     num_imgs = num_ops * 2 + 1
     image_len = num_ops * 512 * 1024
     imgs = []
+    do_discard = False
 
     def setUp(self):
         opts = []
@@ -241,13 +249,16 @@ class TestParallelOps(iotests.QMPTestCase):
         result = self.vm.qmp('block-stream', device='node4', job_id='stream-node4', base=self.imgs[1], speed=1024*1024)
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-stream', device='node5', job_id='stream-node5', base=self.imgs[2])
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node5', job_id='stream-node5', base=self.imgs[2])
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        result = self.vm.qmp('block-stream', device='node3', job_id='stream-node3', base=self.imgs[2])
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node3', job_id='stream-node3', base=self.imgs[2])
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        result = self.vm.qmp('block-stream', device='node4', job_id='stream-node4-v2')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node4', job_id='stream-node4-v2')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         # block-commit should also fail if it touches nodes used by the stream job
@@ -274,20 +285,29 @@ class TestParallelOps(iotests.QMPTestCase):
         result = self.vm.qmp('block-commit', device='drive0', top=self.imgs[5], base=self.imgs[3], job_id='commit-node3', speed=1024*1024)
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-stream', device='node3', job_id='stream-node3')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node3', job_id='stream-node3')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        result = self.vm.qmp('block-stream', device='node6', base=self.imgs[2], job_id='stream-node6')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node6', base=self.imgs[2],
+                             job_id='stream-node6')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        result = self.vm.qmp('block-stream', device='node4', base=self.imgs[2], job_id='stream-node4')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node4', base=self.imgs[2],
+                             job_id='stream-node4')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        result = self.vm.qmp('block-stream', device='node6', base=self.imgs[4], job_id='stream-node6-v2')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node6', base=self.imgs[4],
+                             job_id='stream-node6-v2')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         # This fails because block-commit currently blocks the active layer even if it's not used
-        result = self.vm.qmp('block-stream', device='drive0', base=self.imgs[5], job_id='stream-drive0')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0', base=self.imgs[5],
+                             job_id='stream-drive0')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         self.wait_until_completed(drive='commit-node3')
@@ -302,7 +322,9 @@ class TestParallelOps(iotests.QMPTestCase):
         result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[3], job_id='commit-drive0', speed=1024*1024)
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-stream', device='node5', base=self.imgs[3], job_id='stream-node6')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node5', base=self.imgs[3],
+                             job_id='stream-node6')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         event = self.vm.event_wait(name='BLOCK_JOB_READY')
@@ -389,19 +411,24 @@ class TestParallelOps(iotests.QMPTestCase):
                             'image file map matches backing file before streaming')
 
         # Error: the base node does not exist
-        result = self.vm.qmp('block-stream', device='node4', base_node='none', job_id='stream')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node4', base_node='none', job_id='stream')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         # Error: the base node is not a backing file of the top node
-        result = self.vm.qmp('block-stream', device='node4', base_node='node6', job_id='stream')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node4',base_node='node6', job_id='stream')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         # Error: the base node is the same as the top node
-        result = self.vm.qmp('block-stream', device='node4', base_node='node4', job_id='stream')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node4',base_node='node4', job_id='stream')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         # Error: cannot specify 'base' and 'base-node' at the same time
-        result = self.vm.qmp('block-stream', device='node4', base=self.imgs[2], base_node='node2', job_id='stream')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node4', base=self.imgs[2],
+                             base_node='node2', job_id='stream')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         # Success: the base node is a backing file of the top node
@@ -421,6 +448,7 @@ class TestQuorum(iotests.QMPTestCase):
     num_children = 3
     children = []
     backing = []
+    do_discard = False
 
     def setUp(self):
         opts = ['driver=quorum', 'vote-threshold=2']
@@ -446,10 +474,12 @@ class TestQuorum(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        for img in self.children:
+        for img in self.children[:]:
             os.remove(img)
-        for img in self.backing:
+            self.children.remove(img)
+        for img in self.backing[:]:
             os.remove(img)
+            self.backing.remove(img)
 
     def test_stream_quorum(self):
         if not iotests.supports_quorum():
@@ -461,7 +491,8 @@ class TestQuorum(iotests.QMPTestCase):
 
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='node0', job_id='stream-node0')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='node0', job_id='stream-node0')
         self.assert_qmp(result, 'return', {})
 
         self.wait_until_completed(drive='stream-node0')
@@ -476,6 +507,7 @@ class TestQuorum(iotests.QMPTestCase):
 class TestSmallerBackingFile(iotests.QMPTestCase):
     backing_len = 1 * 1024 * 1024 # MB
     image_len = 2 * backing_len
+    do_discard = False
 
     def setUp(self):
         iotests.create_image(backing_img, self.backing_len)
@@ -488,7 +520,8 @@ class TestSmallerBackingFile(iotests.QMPTestCase):
     def test_stream(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0')
         self.assert_qmp(result, 'return', {})
 
         self.wait_until_completed()
@@ -526,6 +559,8 @@ new_state = "1"
         file.close()
 
 class TestEIO(TestErrors):
+    do_discard = False
+
     def setUp(self):
         self.blkdebug_file = backing_img + ".blkdebug"
         iotests.create_image(backing_img, TestErrors.image_len)
@@ -546,7 +581,8 @@ class TestEIO(TestErrors):
     def test_report(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0')
         self.assert_qmp(result, 'return', {})
 
         completed = False
@@ -574,7 +610,8 @@ class TestEIO(TestErrors):
     def test_ignore(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', on_error='ignore')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0', on_error='ignore')
         self.assert_qmp(result, 'return', {})
 
         error = False
@@ -607,7 +644,8 @@ class TestEIO(TestErrors):
     def test_stop(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', on_error='stop')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0', on_error='stop')
         self.assert_qmp(result, 'return', {})
 
         error = False
@@ -650,7 +688,8 @@ class TestEIO(TestErrors):
     def test_enospc(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', on_error='enospc')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0', on_error='enospc')
         self.assert_qmp(result, 'return', {})
 
         completed = False
@@ -676,6 +715,8 @@ class TestEIO(TestErrors):
         self.vm.shutdown()
 
 class TestENOSPC(TestErrors):
+    do_discard = False
+
     def setUp(self):
         self.blkdebug_file = backing_img + ".blkdebug"
         iotests.create_image(backing_img, TestErrors.image_len)
@@ -696,7 +737,8 @@ class TestENOSPC(TestErrors):
     def test_enospc(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', on_error='enospc')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0', on_error='enospc')
         self.assert_qmp(result, 'return', {})
 
         error = False
@@ -738,6 +780,7 @@ class TestENOSPC(TestErrors):
 
 class TestStreamStop(iotests.QMPTestCase):
     image_len = 8 * 1024 * 1024 * 1024 # GB
+    do_discard = False
 
     def setUp(self):
         qemu_img('create', backing_img, str(TestStreamStop.image_len))
@@ -757,7 +800,8 @@ class TestStreamStop(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp('block-stream', device='drive0')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0')
         self.assert_qmp(result, 'return', {})
 
         time.sleep(0.1)
@@ -770,6 +814,7 @@ class TestStreamStop(iotests.QMPTestCase):
 
 class TestSetSpeed(iotests.QMPTestCase):
     image_len = 80 * 1024 * 1024 # MB
+    do_discard = False
 
     def setUp(self):
         qemu_img('create', backing_img, str(TestSetSpeed.image_len))
@@ -790,7 +835,8 @@ class TestSetSpeed(iotests.QMPTestCase):
     def perf_test_throughput(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0')
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=8 * 1024 * 1024)
@@ -804,7 +850,8 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp('block-stream', device='drive0')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0')
         self.assert_qmp(result, 'return', {})
 
         # Default speed is 0
@@ -824,7 +871,8 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.vm.pause_drive('drive0')
 
         # Check setting speed in block-stream works
-        result = self.vm.qmp('block-stream', device='drive0', speed=4 * 1024 * 1024)
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0', speed=4 * 1024 * 1024)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block-jobs')
@@ -836,13 +884,15 @@ class TestSetSpeed(iotests.QMPTestCase):
     def test_set_speed_invalid(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', speed=-1)
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0', speed=-1)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp('block-stream', device='drive0')
+        result = self.vm.qmp('block-stream', discard=self.do_discard,
+                             device='drive0')
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
@@ -851,5 +901,30 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.cancel_and_wait(resume=True, resume_node='source')
 
 
+class TestSingleDriveDiscard(TestSingleDrive):
+    do_discard = True
+
+class TestParallelOpsDiscard(TestParallelOps):
+    do_discard = True
+
+class TestQuorumDiscard(TestQuorum):
+    do_discard = True
+
+class TestSmallerBackingFileDiscard(TestSmallerBackingFile):
+    do_discard = True
+
+class TestEIODiscard(TestEIO):
+    do_discard = True
+
+class TestENOSPCDiscard(TestENOSPC):
+    do_discard = True
+
+class TestStreamStopDiscard(TestStreamStop):
+    do_discard = True
+
+class TestSetSpeedDiscard(TestSetSpeed):
+    do_discard = True
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 42314e9..dea5c5a 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-........................
+................................................
 ----------------------------------------------------------------------
-Ran 24 tests
+Ran 48 tests
 
 OK
-- 
1.8.3.1
