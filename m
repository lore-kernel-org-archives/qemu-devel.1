Received: from eggs.gnu.org ([2001:4830:134:3::10]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntT8-000891-MR
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntT7-0002qT-GY
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:46 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Aug 2018 00:31:15 +0200
Message-Id: <20180809223117.7846-10-mreitz@redhat.com>
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
References: <20180809223117.7846-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/11] iotests: Add filter mirror test cases
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

This patch adds some test cases how mirroring relates to filters.  One
of them tests what happens when you mirror off a filtered COW node, two
others use the mirror filter node as basically our only example of an
implicitly created filter node so far (besides the commit filter).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041     | 146 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/041.out |   4 +-
 2 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 186bd0f031..c21c8b36d5 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -20,8 +20,9 @@
 
 import time
 import os
+import json
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_img_pipe, qemu_io
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 target_backing_img = os.path.join(iotests.test_dir, 'target-backing.img')
@@ -1185,5 +1186,148 @@ class TestReplaces(iotests.QMPTestCase):
         os.remove(test_img)
         os.remove(target_img)
 
+# Tests for mirror with filters (and how the mirror filter behaves, as
+# an example for an implicit filter)
+class TestFilters(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, backing_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, '-b', backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', backing_img, target_img)
+
+        qemu_io('-c', 'write -P 1 0 512k', backing_img)
+        qemu_io('-c', 'write -P 2 512k 512k', test_img)
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        result = self.vm.qmp('blockdev-add', **{
+                                'node-name': 'target',
+                                'driver': iotests.imgfmt,
+                                'file': {
+                                    'driver': 'file',
+                                    'filename': target_img
+                                },
+                                'backing': None
+                            })
+        self.assert_qmp(result, 'return', {})
+
+        self.filterless_chain = {
+                'node-name': 'source',
+                'driver': iotests.imgfmt,
+                'file': {
+                    'driver': 'file',
+                    'filename': test_img
+                },
+                'backing': {
+                    'node-name': 'backing',
+                    'driver': iotests.imgfmt,
+                    'file': {
+                        'driver': 'file',
+                        'filename': backing_img
+                    }
+                }
+            }
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+        os.remove(test_img)
+        os.remove(target_img)
+        os.remove(backing_img)
+
+    def test_cor(self):
+        result = self.vm.qmp('blockdev-add', **{
+                                'node-name': 'filter',
+                                'driver': 'copy-on-read',
+                                'file': self.filterless_chain
+                            })
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('blockdev-mirror',
+                             job_id='mirror',
+                             device='filter',
+                             target='target',
+                             sync='top')
+        self.assert_qmp(result, 'return', {})
+
+        self.complete_and_wait('mirror')
+
+        self.vm.qmp('blockdev-del', node_name='target')
+
+        target_map = qemu_img_pipe('map', '--output=json', target_img)
+        target_map = json.loads(target_map)
+
+        assert target_map[0]['start'] == 0
+        assert target_map[0]['length'] == 512 * 1024
+        assert target_map[0]['depth'] == 1
+
+        assert target_map[1]['start'] == 512 * 1024
+        assert target_map[1]['length'] == 512 * 1024
+        assert target_map[1]['depth'] == 0
+
+    def test_implicit_mirror_filter(self):
+        result = self.vm.qmp('blockdev-add', **self.filterless_chain)
+        self.assert_qmp(result, 'return', {})
+
+        # We need this so we can query from above the mirror node
+        result = self.vm.qmp('device_add',
+                             driver='virtio-blk',
+                             id='virtio',
+                             bus='pci.0',
+                             drive='source')
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('blockdev-mirror',
+                             job_id='mirror',
+                             device='source',
+                             target='target',
+                             sync='top')
+        self.assert_qmp(result, 'return', {})
+
+        # The mirror filter is now an implicit node, so it should be
+        # invisible when querying the backing chain
+        device_info = self.vm.qmp('query-block')['return'][0]
+        assert device_info['qdev'] == '/machine/peripheral/virtio/virtio-backend'
+
+        assert device_info['inserted']['node-name'] == 'source'
+
+        image_info = device_info['inserted']['image']
+        assert image_info['filename'] == test_img
+        assert image_info['backing-image']['filename'] == backing_img
+
+        self.complete_and_wait('mirror')
+
+    def test_explicit_mirror_filter(self):
+        # Same test as above, but this time we give the mirror filter
+        # a node-name so it will not be invisible
+        result = self.vm.qmp('blockdev-add', **self.filterless_chain)
+        self.assert_qmp(result, 'return', {})
+
+        # We need this so we can query from above the mirror node
+        result = self.vm.qmp('device_add',
+                             driver='virtio-blk',
+                             id='virtio',
+                             bus='pci.0',
+                             drive='source')
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('blockdev-mirror',
+                             job_id='mirror',
+                             device='source',
+                             target='target',
+                             sync='top',
+                             filter_node_name='mirror-filter')
+        self.assert_qmp(result, 'return', {})
+
+        # With a node-name given to it, the mirror filter should now
+        # be visible
+        device_info = self.vm.qmp('query-block')['return'][0]
+        assert device_info['qdev'] == '/machine/peripheral/virtio/virtio-backend'
+
+        assert device_info['inserted']['node-name'] == 'mirror-filter'
+
+        self.complete_and_wait('mirror')
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index d71481b010..2c448b4239 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-.......................................................................................
+..........................................................................................
 ----------------------------------------------------------------------
-Ran 87 tests
+Ran 90 tests
 
 OK
-- 
2.17.1
