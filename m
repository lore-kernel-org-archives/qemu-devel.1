Received: from eggs.gnu.org ([2001:4830:134:3::10]:60368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntT2-00083t-Ia
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntT1-0002hf-9o
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:40 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Aug 2018 00:31:12 +0200
Message-Id: <20180809223117.7846-7-mreitz@redhat.com>
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
References: <20180809223117.7846-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/11] iotests: Add tests for mirror
 @replaces loops
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

This adds two tests for cases where our old check_to_replace_node()
function failed to detect that executing this job with these parameters
would result in a cyclic graph.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041     | 124 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |   4 +-
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index c20ac7da87..186bd0f031 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1061,5 +1061,129 @@ class TestOrphanedSource(iotests.QMPTestCase):
                              target='dest-ro')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
+# Various tests for the @replaces option (independent of quorum)
+class TestReplaces(iotests.QMPTestCase):
+    def setUp(self):
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+    def test_drive_mirror_loop(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, '1M')
+
+        result = self.vm.qmp('object-add', qom_type='throttle-group', id='tg')
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('blockdev-add', **{
+                    'node-name': 'source',
+                    'driver': 'throttle',
+                    'throttle-group': 'tg',
+                    'file': {
+                        'node-name': 'filtered',
+                        'driver': 'qcow2',
+                        'file': {
+                            'driver': 'file',
+                            'filename': test_img
+                        }
+                    }
+                })
+        self.assert_qmp(result, 'return', {})
+
+        # Mirror from @source to @target in sync=none, so that @source
+        # will be @target's backing file; but replace @filtered.
+        # Then, @target's backing file will be @source, whose backing
+        # file is now @target instead of @filtered.  That is a loop.
+        # (But apart from the loop, replacing @filtered instead of
+        # @source is fine, because both are just filtered versions of
+        # each other.)
+        result = self.vm.qmp('drive-mirror',
+                             job_id='mirror',
+                             device='source',
+                             target=target_img,
+                             format=iotests.imgfmt,
+                             node_name='target',
+                             sync='none',
+                             replaces='filtered')
+        if 'error' in result:
+            # This is the correct result
+            self.assert_qmp(result, 'error/class', 'GenericError')
+        else:
+            # This is wrong, but let's run it to the bitter conclusion
+            self.complete_and_wait(drive='mirror')
+            # Fail for good measure, although qemu should have crashed
+            # anyway
+            self.fail('Loop creation was successful')
+
+        os.remove(test_img)
+        try:
+            os.remove(target_img)
+        except OSError:
+            pass
+
+    def test_blockdev_mirror_loop(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, target_img, '1M')
+
+        result = self.vm.qmp('object-add', qom_type='throttle-group', id='tg')
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('blockdev-add', **{
+                    'node-name': 'source',
+                    'driver': 'throttle',
+                    'throttle-group': 'tg',
+                    'file': {
+                        'node-name': 'middle',
+                        'driver': 'throttle',
+                        'throttle-group': 'tg',
+                        'file': {
+                            'node-name': 'bottom',
+                            'driver': 'qcow2',
+                            'file': {
+                                'driver': 'file',
+                                'filename': test_img
+                            }
+                        }
+                    }
+                })
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('blockdev-add', **{
+                    'node-name': 'target',
+                    'driver': 'qcow2',
+                    'file': {
+                        'driver': 'file',
+                        'filename': target_img
+                    },
+                    'backing': 'middle'
+                })
+
+        # Mirror from @source to @target.  With blockdev-mirror, the
+        # current (old) backing file is retained (which is @middle).
+        # By replacing @bottom, @middle's file will be @target, whose
+        # backing file is @middle again.  That is a loop.
+        # (But apart from the loop, replacing @bottom instead of
+        # @source is fine, because both are just filtered versions of
+        # each other.)
+        result = self.vm.qmp('blockdev-mirror',
+                             job_id='mirror',
+                             device='source',
+                             target='target',
+                             sync='full',
+                             replaces='bottom')
+        if 'error' in result:
+            # This is the correct result
+            self.assert_qmp(result, 'error/class', 'GenericError')
+        else:
+            # This is wrong, but let's run it to the bitter conclusion
+            self.complete_and_wait(drive='mirror')
+            # Fail for good measure, although qemu should have crashed
+            # anyway
+            self.fail('Loop creation was successful')
+
+        os.remove(test_img)
+        os.remove(target_img)
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index c28b392b87..d71481b010 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-.....................................................................................
+.......................................................................................
 ----------------------------------------------------------------------
-Ran 85 tests
+Ran 87 tests
 
 OK
-- 
2.17.1
