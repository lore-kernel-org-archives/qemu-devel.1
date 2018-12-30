Received: from eggs.gnu.org ([208.118.235.92]:43332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gdhOq-0001g0-KY
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gdhOn-0008FB-MH
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:09:28 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Sun, 30 Dec 2018 23:09:16 +0300
Message-Id: <1546200557-774583-6-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 5/6] iotests: prepare 030 for graph change
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

The discard option for block-stream command requires insertion of the
filter to write into the backing chain. In that case, the job will not
resume by device name. So, the node name is specified.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/030 | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 276e06b..5d148b0 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -36,7 +36,8 @@ class TestSingleDrive(iotests.QMPTestCase):
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 512', backing_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 524288 512', mid_img)
-        self.vm = iotests.VM().add_drive("blkdebug::" + test_img, "backing.node-name=mid")
+        self.vm = iotests.VM().add_drive("blkdebug::" + test_img,
+                               "node-name=source,backing.node-name=mid")
         self.vm.launch()
 
     def tearDown(self):
@@ -87,7 +88,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
         self.pause_job('drive0', wait=False)
-        self.vm.resume_drive('drive0')
+        self.vm.resume_drive('source')
         self.pause_wait('drive0')
 
         result = self.vm.qmp('query-block-jobs')
@@ -743,7 +744,8 @@ class TestStreamStop(iotests.QMPTestCase):
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 32M', backing_img)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 32M 32M', test_img)
-        self.vm = iotests.VM().add_drive("blkdebug::" + test_img)
+        self.vm = iotests.VM().add_drive("blkdebug::" + test_img,
+                                         "node-name=source")
         self.vm.launch()
 
     def tearDown(self):
@@ -764,7 +766,7 @@ class TestStreamStop(iotests.QMPTestCase):
             self.assert_qmp(e, 'event', 'JOB_STATUS_CHANGE')
             self.assert_qmp(e, 'data/id', 'drive0')
 
-        self.cancel_and_wait(resume=True)
+        self.cancel_and_wait(resume=True, resume_node='source')
 
 class TestSetSpeed(iotests.QMPTestCase):
     image_len = 80 * 1024 * 1024 # MB
@@ -774,7 +776,8 @@ class TestSetSpeed(iotests.QMPTestCase):
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 32M', backing_img)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 32M 32M', test_img)
-        self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
+        self.vm = iotests.VM().add_drive('blkdebug::' + test_img,
+                                         "node-name=source")
         self.vm.launch()
 
     def tearDown(self):
@@ -817,7 +820,7 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_qmp(result, 'return[0]/device', 'drive0')
         self.assert_qmp(result, 'return[0]/speed', 8 * 1024 * 1024)
 
-        self.cancel_and_wait(resume=True)
+        self.cancel_and_wait(resume=True, resume_node='source')
         self.vm.pause_drive('drive0')
 
         # Check setting speed in block-stream works
@@ -828,7 +831,7 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_qmp(result, 'return[0]/device', 'drive0')
         self.assert_qmp(result, 'return[0]/speed', 4 * 1024 * 1024)
 
-        self.cancel_and_wait(resume=True)
+        self.cancel_and_wait(resume=True, resume_node='source')
 
     def test_set_speed_invalid(self):
         self.assert_no_active_block_jobs()
@@ -845,7 +848,8 @@ class TestSetSpeed(iotests.QMPTestCase):
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        self.cancel_and_wait(resume=True)
+        self.cancel_and_wait(resume=True, resume_node='source')
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'])
-- 
1.8.3.1
