Received: from eggs.gnu.org ([2001:4830:134:3::10]:48355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEYHc-0003Gf-Uy
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEYHY-0007K4-RO
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:17:32 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 14 Nov 2017 13:16:53 +0300
Message-Id: <1510654613-47868-6-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 5/5] iotest 030: add compressed block-stream
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 tests/qemu-iotests/030     | 69 +++++++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/030.out |  4 +--
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 1883894..52cbe5d 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -21,7 +21,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_img_pipe, qemu_io
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 mid_img = os.path.join(iotests.test_dir, 'mid.img')
@@ -800,5 +800,72 @@ class TestSetSpeed(iotests.QMPTestCase):
 
         self.cancel_and_wait()
 
+class TestCompressed(iotests.QMPTestCase):
+    supported_fmts = ['qcow2']
+    cluster_size = 64 * 1024;
+    image_len = 1 * 1024 * 1024;
+
+    def setUp(self):
+        qemu_img('create', backing_img, str(TestCompressed.image_len))
+        qemu_io('-f', 'raw', '-c', 'write -P 1 0 ' + str(TestCompressed.image_len), backing_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
+
+        # write '4' in every 4th cluster
+        step=4
+        for i in range(TestCompressed.image_len / TestCompressed.cluster_size / step + 1):
+            qemu_io('-c', 'write -P %d %d %d' %
+                    (step, step * i * TestCompressed.cluster_size,
+                     TestCompressed.cluster_size),
+                    test_img)
+
+        self.vm = iotests.VM().add_drive(test_img)
+        self.vm.launch()
+
+    def tearDown(self):
+        os.remove(test_img)
+        os.remove(backing_img)
+
+    def _pattern(self, x, divs):
+        return divs[-1] if not x%divs[-1] else self._pattern(x, divs[:-1])
+
+    def test_compressed(self):
+        self.assert_no_active_block_jobs()
+
+        result = self.vm.qmp('block-stream', device='drive0', compress=True)
+        if iotests.imgfmt not in TestCompressed.supported_fmts:
+            self.assert_qmp(
+                result, 'error/desc',
+                'Compression is not supported for this drive drive0')
+            return
+        self.assert_qmp(result, 'return', {})
+
+        # write '2' in every 2nd cluster
+        step = 2
+        for i in range(TestCompressed.image_len / TestCompressed.cluster_size / step + 1):
+            result = self.vm.qmp('human-monitor-command',
+                                 command_line=
+                                 'qemu-io drive0 \"write -P %d %d %d\"' %
+                                 (step, step * i * TestCompressed.cluster_size,
+                                  TestCompressed.cluster_size))
+            self.assert_qmp(result, 'return', "")
+
+        self.wait_until_completed()
+        self.assert_no_active_block_jobs()
+
+        self.vm.shutdown()
+
+        for i in range(TestCompressed.image_len / TestCompressed.cluster_size):
+            outp = qemu_io('-c', 'read -P %d %d %d' %
+                           (self._pattern(i, [1,4,2]),
+                            i * TestCompressed.cluster_size,
+                            TestCompressed.cluster_size),
+                           test_img)
+            self.assertTrue(not 'fail' in outp)
+            self.assertTrue('read' in outp and 'at offset' in outp)
+
+        self.assertTrue(
+            "File contains external, encrypted or compressed clusters."
+            in qemu_img_pipe('map', test_img))
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 391c857..42314e9 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-.......................
+........................
 ----------------------------------------------------------------------
-Ran 23 tests
+Ran 24 tests
 
 OK
-- 
2.7.4
