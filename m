Received: from eggs.gnu.org ([2001:4830:134:3::10]:60515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntT9-0008AF-Gn
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntT8-0002sC-IU
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Aug 2018 00:31:17 +0200
Message-Id: <20180809223117.7846-12-mreitz@redhat.com>
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
References: <20180809223117.7846-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/11] iotests: Test committing to
 overridden backing
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
 tests/qemu-iotests/040     | 61 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out |  4 +--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index f0544d6107..90c03e745b 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -476,5 +476,66 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/desc',
                         'Top image file %s not found' % cow3_name)
 
+class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
+    img_base_a = os.path.join(iotests.test_dir, 'base_a.img')
+    img_base_b = os.path.join(iotests.test_dir, 'base_b.img')
+    img_top = os.path.join(iotests.test_dir, 'top.img')
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, self.img_base_a, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, self.img_base_b, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, '-b', self.img_base_a, \
+                 self.img_top)
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        # Use base_b instead of base_a as the backing of top
+        result = self.vm.qmp('blockdev-add', **{
+                                'node-name': 'top',
+                                'driver': iotests.imgfmt,
+                                'file': {
+                                    'driver': 'file',
+                                    'filename': self.img_top
+                                },
+                                'backing': {
+                                    'node-name': 'base',
+                                    'driver': iotests.imgfmt,
+                                    'file': {
+                                        'driver': 'file',
+                                        'filename': self.img_base_b
+                                    }
+                                }
+                            })
+        self.assert_qmp(result, 'return', {})
+
+    def tearDown(self):
+        self.vm.shutdown()
+        os.remove(self.img_top)
+        os.remove(self.img_base_a)
+        os.remove(self.img_base_b)
+
+    def test_commit_to_a(self):
+        # Try committing to base_a (which should fail, as top's
+        # backing image is base_b instead)
+        result = self.vm.qmp('block-commit',
+                             job_id='commit',
+                             device='top',
+                             base=self.img_base_a)
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
+    def test_commit_to_b(self):
+        # Try committing to base_b (which should work, since that is
+        # actually top's backing image)
+        result = self.vm.qmp('block-commit',
+                             job_id='commit',
+                             device='top',
+                             base=self.img_base_b)
+        self.assert_qmp(result, 'return', {})
+
+        self.vm.event_wait('BLOCK_JOB_READY')
+        self.vm.qmp('block-job-complete', device='commit')
+        self.vm.event_wait('BLOCK_JOB_COMPLETED')
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 49f84261d0..cfa5c0d0e6 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-.................................
+...................................
 ----------------------------------------------------------------------
-Ran 33 tests
+Ran 35 tests
 
 OK
-- 
2.17.1
