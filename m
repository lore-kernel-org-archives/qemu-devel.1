Received: from eggs.gnu.org ([2001:4830:134:3::10]:57355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAMh-0003m6-0c
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAMf-0007LC-Hl
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:19:27 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Jun 2018 20:18:23 +0200
Message-Id: <20180613181823.13618-15-mreitz@redhat.com>
In-Reply-To: <20180613181823.13618-1-mreitz@redhat.com>
References: <20180613181823.13618-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 14/14] iotests: Add test for active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/151     | 120 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/151.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 126 insertions(+)
 create mode 100755 tests/qemu-iotests/151
 create mode 100644 tests/qemu-iotests/151.out

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
new file mode 100755
index 0000000000..fe53b9f446
--- /dev/null
+++ b/tests/qemu-iotests/151
@@ -0,0 +1,120 @@
+#!/usr/bin/env python
+#
+# Tests for active mirroring
+#
+# Copyright (C) 2018 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+import iotests
+from iotests import qemu_img
+
+source_img = os.path.join(iotests.test_dir, 'source.' + iotests.imgfmt)
+target_img = os.path.join(iotests.test_dir, 'target.' + iotests.imgfmt)
+
+class TestActiveMirror(iotests.QMPTestCase):
+    image_len = 128 * 1024 * 1024 # MB
+    potential_writes_in_flight = True
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, source_img, '128M')
+        qemu_img('create', '-f', iotests.imgfmt, target_img, '128M')
+
+        blk_source = {'id': 'source',
+                      'if': 'none',
+                      'node-name': 'source-node',
+                      'driver': iotests.imgfmt,
+                      'file': {'driver': 'file',
+                               'filename': source_img}}
+
+        blk_target = {'node-name': 'target-node',
+                      'driver': iotests.imgfmt,
+                      'file': {'driver': 'file',
+                               'filename': target_img}}
+
+        self.vm = iotests.VM()
+        self.vm.add_drive_raw(self.vm.qmp_to_opts(blk_source))
+        self.vm.add_blockdev(self.vm.qmp_to_opts(blk_target))
+        self.vm.add_device('virtio-blk,drive=source')
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+        if not self.potential_writes_in_flight:
+            self.assertTrue(iotests.compare_images(source_img, target_img),
+                            'mirror target does not match source')
+
+        os.remove(source_img)
+        os.remove(target_img)
+
+    def doActiveIO(self, sync_source_and_target):
+        # Fill the source image
+        self.vm.hmp_qemu_io('source',
+                            'write -P 1 0 %i' % self.image_len);
+
+        # Start some background requests
+        for offset in range(1 * self.image_len / 8, 3 * self.image_len / 8, 1024 * 1024):
+            self.vm.hmp_qemu_io('source', 'aio_write -P 2 %i 1M' % offset)
+        for offset in range(2 * self.image_len / 8, 3 * self.image_len / 8, 1024 * 1024):
+            self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
+
+        # Start the block job
+        result = self.vm.qmp('blockdev-mirror',
+                             job_id='mirror',
+                             filter_node_name='mirror-node',
+                             device='source-node',
+                             target='target-node',
+                             sync='full',
+                             copy_mode='write-blocking')
+        self.assert_qmp(result, 'return', {})
+
+        # Start some more requests
+        for offset in range(3 * self.image_len / 8, 5 * self.image_len / 8, 1024 * 1024):
+            self.vm.hmp_qemu_io('source', 'aio_write -P 3 %i 1M' % offset)
+        for offset in range(4 * self.image_len / 8, 5 * self.image_len / 8, 1024 * 1024):
+            self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
+
+        # Wait for the READY event
+        self.wait_ready(drive='mirror')
+
+        # Now start some final requests; all of these (which land on
+        # the source) should be settled using the active mechanism.
+        # The mirror code itself asserts that the source BDS's dirty
+        # bitmap will stay clean between READY and COMPLETED.
+        for offset in range(5 * self.image_len / 8, 7 * self.image_len / 8, 1024 * 1024):
+            self.vm.hmp_qemu_io('source', 'aio_write -P 3 %i 1M' % offset)
+        for offset in range(6 * self.image_len / 8, 7 * self.image_len / 8, 1024 * 1024):
+            self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
+
+        if sync_source_and_target:
+            # If source and target should be in sync after the mirror,
+            # we have to flush before completion
+            self.vm.hmp_qemu_io('source', 'aio_flush')
+            self.potential_writes_in_flight = False
+
+        self.complete_and_wait(drive='mirror', wait_ready=False)
+
+    def testActiveIO(self):
+        self.doActiveIO(False)
+
+    def testActiveIOFlushed(self):
+        self.doActiveIO(True)
+
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2', 'raw'])
diff --git a/tests/qemu-iotests/151.out b/tests/qemu-iotests/151.out
new file mode 100644
index 0000000000..fbc63e62f8
--- /dev/null
+++ b/tests/qemu-iotests/151.out
@@ -0,0 +1,5 @@
+..
+----------------------------------------------------------------------
+Ran 2 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 937a3d0a4d..eea75819d2 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -157,6 +157,7 @@
 148 rw auto quick
 149 rw auto sudo
 150 rw auto quick
+151 rw auto
 152 rw auto quick
 153 rw auto quick
 154 rw auto backing quick
-- 
2.17.1
