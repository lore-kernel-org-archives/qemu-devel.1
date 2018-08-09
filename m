Received: from eggs.gnu.org ([2001:4830:134:3::10]:43332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbs-0003HL-Dj
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbn-0000Ok-CS
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:28 +0200
Message-Id: <20180809213528.14738-32-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 31/31] iotests: Test json:{}
 filenames of internal BDSs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/224     | 139 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/224.out |  18 +++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 158 insertions(+)
 create mode 100755 tests/qemu-iotests/224
 create mode 100644 tests/qemu-iotests/224.out

diff --git a/tests/qemu-iotests/224 b/tests/qemu-iotests/224
new file mode 100755
index 0000000000..f1b7aa801b
--- /dev/null
+++ b/tests/qemu-iotests/224
@@ -0,0 +1,139 @@
+#!/usr/bin/env python
+#
+# Test json:{} filenames with qemu-internal BDSs
+# (the one of commit, to be precise)
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
+# Creator/Owner: Max Reitz <mreitz@redhat.com>
+
+import iotests
+from iotests import log, qemu_img, qemu_io_silent, filter_testfiles, \
+                    filter_imgfmt
+import json
+
+# Need backing file support (for arbitrary backing formats)
+iotests.verify_image_format(supported_fmts=['qcow2', 'qcow', 'qed'])
+iotests.verify_platform(['linux'])
+
+
+# There are two variations of this test:
+# (1) We do not set filter_node_name.  In that case, the commit_top
+#     driver should not appear anywhere.
+# (2) We do set filter_node_name.  In that case, it should appear.
+#
+# This for loop executes both.
+for filter_node_name in False, True:
+    log('')
+    log('--- filter_node_name: %s ---' % filter_node_name)
+    log('')
+
+    with iotests.FilePath('base.img') as base_img_path, \
+         iotests.FilePath('mid.img') as mid_img_path, \
+         iotests.FilePath('top.img') as top_img_path, \
+         iotests.VM() as vm:
+
+        assert qemu_img('create', '-f', iotests.imgfmt,
+                        base_img_path, '64M') == 0
+        assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
+                        mid_img_path) == 0
+        assert qemu_img('create', '-f', iotests.imgfmt, '-b', mid_img_path,
+                        top_img_path) == 0
+
+        # Something to commit
+        assert qemu_io_silent(mid_img_path, '-c', 'write -P 1 0 1M') == 0
+
+        vm.launch()
+
+        # Change the bottom-most image's backing file (to null-co://)
+        # to enforce json:{} filenames
+        vm.qmp_log('blockdev-add',
+                    node_name='top',
+                    driver=iotests.imgfmt,
+                    file={
+                        'driver': 'file',
+                        'filename': top_img_path
+                    },
+                    backing={
+                        'node-name': 'mid',
+                        'driver': iotests.imgfmt,
+                        'file': {
+                            'driver': 'file',
+                            'filename': mid_img_path
+                        },
+                        'backing': {
+                            'node-name': 'base',
+                            'driver': iotests.imgfmt,
+                            'file': {
+                                'driver': 'file',
+                                'filename': base_img_path
+                            },
+                            'backing': {
+                                'driver': 'null-co'
+                            }
+                        }
+                    },
+                    filters=[filter_testfiles, filter_imgfmt])
+
+        # As long as block-commit does not accept node names, we have to
+        # get our mid/base filenames here
+        mid_name = vm.node_info('mid')['image']['filename']
+        base_name = vm.node_info('base')['image']['filename']
+
+        #assert mid_name[:5] == 'json:'
+        #assert base_name[:5] == 'json:'
+
+        # Start the block job
+        if filter_node_name:
+            vm.qmp_log('block-commit',
+                        job_id='commit',
+                        device='top',
+                        filter_node_name='filter_node',
+                        top=mid_name,
+                        base=base_name,
+                        speed=1,
+                        filters=[filter_testfiles, filter_imgfmt])
+        else:
+            vm.qmp_log('block-commit',
+                        job_id='commit',
+                        device='top',
+                        top=mid_name,
+                        base=base_name,
+                        speed=1,
+                        filters=[filter_testfiles, filter_imgfmt])
+
+        vm.qmp_log('job-pause', id='commit')
+
+        # Get and parse top's json:{} filename
+        top_name = vm.node_info('top')['image']['filename']
+
+        vm.shutdown()
+
+        #assert top_name[:5] == 'json:'
+        #top_options = json.loads(top_name[5:])
+
+        #if filter_node_name:
+        #    # This should be present and set
+        #    assert top_options['backing']['driver'] == 'commit_top'
+        #    # And the mid image is commit_top's backing image
+        #    mid_options = top_options['backing']['backing']
+        #else:
+        #    # The mid image should appear as the immediate backing BDS
+        #    # of top
+        #    mid_options = top_options['backing']
+
+        #assert mid_options['driver'] == iotests.imgfmt
+        #assert mid_options['file']['filename'] == mid_img_path
diff --git a/tests/qemu-iotests/224.out b/tests/qemu-iotests/224.out
new file mode 100644
index 0000000000..0230ae2c54
--- /dev/null
+++ b/tests/qemu-iotests/224.out
@@ -0,0 +1,18 @@
+
+--- filter_node_name: False ---
+
+{'execute': 'blockdev-add', 'arguments': {'backing': {'backing': {'backing': {'driver': 'null-co'}, 'node-name': 'base', 'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-base.img'}}, 'node-name': 'mid', 'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-mid.img'}}, 'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-top.img'}, 'node_name': 'top'}}
+{u'return': {}}
+{'execute': 'block-commit', 'arguments': {'device': 'top', 'top': u'json:{"backing": {"backing": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-base.img"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-mid.img"}}', 'base': u'json:{"backing": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-base.img"}}', 'speed': 1, 'job_id': 'commit'}}
+{u'return': {}}
+{'execute': 'job-pause', 'arguments': {'id': 'commit'}}
+{u'return': {}}
+
+--- filter_node_name: True ---
+
+{'execute': 'blockdev-add', 'arguments': {'backing': {'backing': {'backing': {'driver': 'null-co'}, 'node-name': 'base', 'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-base.img'}}, 'node-name': 'mid', 'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-mid.img'}}, 'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-top.img'}, 'node_name': 'top'}}
+{u'return': {}}
+{'execute': 'block-commit', 'arguments': {'job_id': 'commit', 'top': u'json:{"backing": {"backing": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-base.img"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-mid.img"}}', 'base': u'json:{"backing": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-base.img"}}', 'device': 'top', 'filter_node_name': 'filter_node', 'speed': 1}}
+{u'return': {}}
+{'execute': 'job-pause', 'arguments': {'id': 'commit'}}
+{u'return': {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5bfe2e246d..3bf4f13527 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -222,6 +222,7 @@
 221 rw auto quick
 222 rw auto quick
 223 rw auto quick
+224 rw auto quick
 225 rw auto quick
 226 auto quick
 227 auto quick
-- 
2.17.1
