Received: from eggs.gnu.org ([2001:4830:134:3::10]:49027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCv-0001s8-TO
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCu-0006K8-4q
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42917
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCt-0006Jg-V5
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EAbU019556
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:39 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmsfn2wwu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:39 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:38 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:49 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-75-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 74/79] qemu-iotests: Test automatic commit job
 cancel on hot unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
(cherry picked from commit c3971b883a596abc6af45f53d2f43fb2f59ccd3b)
*prereq for d3c8c674
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
