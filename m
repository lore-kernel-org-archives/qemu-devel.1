Received: from eggs.gnu.org ([2001:4830:134:3::10]:40192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFNRm-0001R8-LT
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFNRl-0007T2-0j
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:55:26 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 16 Nov 2017 19:54:58 +0300
Message-Id: <1510851298-59922-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1510851298-59922-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1510851298-59922-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/4] iotests: 030: add compressed
 block-stream test
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
 tests/qemu-iotests/030     | 66 +++++++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/030.out |  4 +--
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 457984b..831d6f3 100755
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
@@ -804,5 +804,69 @@ class TestSetSpeed(iotests.QMPTestCase):
 
         self.cancel_and_wait(resume=True)
 
+class TestCompressed(iotests.QMPTestCase):
+    supported_fmts = ['qcow2']
+    cluster_size = 64 * 1024;
+    image_len = 1 * 1024 * 1024;
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=%d' % TestCompressed.cluster_size, backing_img, str(TestCompressed.image_len))
+        qemu_io('-c', 'write -P 1 0 ' + str(TestCompressed.image_len), backing_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s,cluster_size=%d' % (backing_img, TestCompressed.cluster_size), test_img)
+
+        # write '3' in every 3rd cluster
+        step = 3
+        for off in range(0, TestCompressed.image_len, TestCompressed.cluster_size * step):
+            qemu_io('-c', 'write -P %d %d %d' %
+                    (step, off, TestCompressed.cluster_size), test_img)
+
+        self.vm = iotests.VM().add_drive(test_img)
+        self.vm.launch()
+
+    def tearDown(self):
+        os.remove(test_img)
+        os.remove(backing_img)
+
+    def _first_divider(self, x, divs):
+        return divs[0] if not x%divs[0] else self._first_divider(x, divs[1:])
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
+        # write '4' in every 4th cluster
+        step = 4
+        for off in range(0, TestCompressed.image_len, TestCompressed.cluster_size * step):
+            result = self.vm.qmp('human-monitor-command',
+                                 command_line=
+                                 'qemu-io drive0 "write -P %d %d %d"' %
+                                 (step, off, TestCompressed.cluster_size))
+            self.assert_qmp(result, 'return', "")
+
+        self.wait_until_completed()
+        self.assert_no_active_block_jobs()
+
+        self.vm.shutdown()
+
+        for i in range(TestCompressed.image_len / TestCompressed.cluster_size):
+            outp = qemu_io('-c', 'read -P %d %d %d' %
+                           (self._first_divider(i, [4, 3, 1]),
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
