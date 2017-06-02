Received: from eggs.gnu.org ([2001:4830:134:3::10]:51305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGtrz-0000Dt-Ix
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGtry-0003Eh-Ir
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:12:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Jun 2017 23:12:10 +0200
Message-Id: <1496437930-12654-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496437930-12654-1-git-send-email-kwolf@redhat.com>
References: <1496437930-12654-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-iotests: Test automatic commit job
 cancel on hot unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/040     | 35 +++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/040.out |  4 ++--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 5bdaf3d..9d381d9 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -70,7 +70,9 @@ class ImageCommitTestCase(iotests.QMPTestCase):
         self.wait_for_complete()
 
 class TestSingleDrive(ImageCommitTestCase):
-    image_len = 1 * 1024 * 1024
+    # Need some space after the copied data so that throttling is effective in
+    # tests that use it rather than just completing the job immediately
+    image_len = 2 * 1024 * 1024
     test_len = 1 * 1024 * 256
 
     def setUp(self):
@@ -79,7 +81,9 @@ class TestSingleDrive(ImageCommitTestCase):
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', backing_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', mid_img)
-        self.vm = iotests.VM().add_drive(test_img)
+        self.vm = iotests.VM().add_drive(test_img, interface="none")
+        self.vm.add_device("virtio-scsi-pci")
+        self.vm.add_device("scsi-hd,id=scsi0,drive=drive0")
         self.vm.launch()
 
     def tearDown(self):
@@ -131,6 +135,33 @@ class TestSingleDrive(ImageCommitTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
         self.assert_qmp(result, 'error/desc', 'Base \'%s\' not found' % mid_img)
 
+    # When the job is running on a BB that is automatically deleted on hot
+    # unplug, the job is cancelled when the device disappears
+    def test_hot_unplug(self):
+        if self.image_len == 0:
+            return
+
+        self.assert_no_active_block_jobs()
+        result = self.vm.qmp('block-commit', device='drive0', top=mid_img,
+                             base=backing_img, speed=(self.image_len / 4))
+        self.assert_qmp(result, 'return', {})
+        result = self.vm.qmp('device_del', id='scsi0')
+        self.assert_qmp(result, 'return', {})
+
+        cancelled = False
+        deleted = False
+        while not cancelled or not deleted:
+            for event in self.vm.get_qmp_events(wait=True):
+                if event['event'] == 'DEVICE_DELETED':
+                    self.assert_qmp(event, 'data/device', 'scsi0')
+                    deleted = True
+                elif event['event'] == 'BLOCK_JOB_CANCELLED':
+                    self.assert_qmp(event, 'data/device', 'drive0')
+                    cancelled = True
+                else:
+                    self.fail("Unexpected event %s" % (event['event']))
+
+        self.assert_no_active_block_jobs()
 
 class TestRelativePaths(ImageCommitTestCase):
     image_len = 1 * 1024 * 1024
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 4fd1c2d..6d9bee1 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-.........................
+...........................
 ----------------------------------------------------------------------
-Ran 25 tests
+Ran 27 tests
 
 OK
-- 
1.8.3.1
