Received: from eggs.gnu.org ([2001:4830:134:3::10]:42644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsb4-0002L7-Mv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsb2-0007r0-Ez
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:35:54 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:05 +0200
Message-Id: <20180809213528.14738-9-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 08/31] iotests: Add test for
 backing file overrides
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
 tests/qemu-iotests/228     | 235 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/228.out |  84 +++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 320 insertions(+)
 create mode 100755 tests/qemu-iotests/228
 create mode 100644 tests/qemu-iotests/228.out

diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
new file mode 100755
index 0000000000..a2200efba5
--- /dev/null
+++ b/tests/qemu-iotests/228
@@ -0,0 +1,235 @@
+#!/usr/bin/env python
+#
+# Test for when a backing file is considered overridden (thus, a
+# json:{} filename is generated for the overlay) and when it is not
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
+from iotests import log, qemu_img, filter_testfiles, filter_imgfmt
+
+# Need backing file and change-backing-file support
+iotests.verify_image_format(supported_fmts=['qcow2', 'qed'])
+iotests.verify_platform(['linux'])
+
+
+def log_node_info(node):
+    log('')
+
+    log('bs->filename: ' + node['image']['filename'],
+        filters=[filter_testfiles, filter_imgfmt])
+    log('bs->backing_file: ' + node['backing_file'],
+        filters=[filter_testfiles, filter_imgfmt])
+
+    if 'backing-image' in node['image']:
+        log('bs->backing->bs->filename: ' +
+            node['image']['backing-image']['filename'],
+            filters=[filter_testfiles, filter_imgfmt])
+    else:
+        log('bs->backing: (none)')
+
+    log('')
+
+
+with iotests.FilePath('base.img') as base_img_path, \
+     iotests.FilePath('top.img') as top_img_path, \
+     iotests.VM() as vm:
+
+    assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M') == 0
+    # Choose a funny way to describe the backing filename
+    assert qemu_img('create', '-f', iotests.imgfmt, '-b',
+                    'file:' + base_img_path, top_img_path) == 0
+
+    vm.launch()
+
+    log('--- Implicit backing file ---')
+    log('')
+
+    vm.qmp_log('blockdev-add',
+                node_name='node0',
+                driver=iotests.imgfmt,
+                file={
+                    'driver': 'file',
+                    'filename': top_img_path
+                },
+                filters=[filter_testfiles, filter_imgfmt])
+
+    # Filename should be plain, and the backing filename should not
+    # contain the "file:" prefix
+    log_node_info(vm.node_info('node0'))
+
+    vm.qmp_log('blockdev-del', node_name='node0')
+
+    log('')
+    log('--- change-backing-file ---')
+    log('')
+
+    vm.qmp_log('blockdev-add',
+               node_name='node0',
+               driver=iotests.imgfmt,
+               file={
+                   'driver': 'file',
+                   'filename': top_img_path
+               },
+               filters=[filter_testfiles, filter_imgfmt])
+
+    # Changing the backing file to a qemu-reported filename should
+    # result in qemu accepting the corresponding BDS as the implicit
+    # backing BDS (and thus not generate a json:{} filename).
+    # So, first, query the backing filename.
+
+    backing_filename = \
+        vm.node_info('node0')['image']['backing-image']['filename']
+
+    # Next, change the backing file to something different
+
+    vm.qmp_log('change-backing-file',
+               image_node_name='node0',
+               device='node0',
+               backing_file='null-co://')
+
+    # Now, verify that we get a json:{} filename
+    # (Image header says "null-co://", actual backing file still is
+    # base_img_path)
+
+    log_node_info(vm.node_info('node0'))
+
+    # Change it back
+    # (To get header and backing file in sync)
+
+    vm.qmp_log('change-backing-file',
+               image_node_name='node0',
+               device='node0',
+               backing_file=backing_filename)
+
+    # And verify that we get our original results
+
+    log_node_info(vm.node_info('node0'))
+
+    # Finally, try a "file:" prefix.  While this is actually what we
+    # originally had in the image header, qemu will not reopen the
+    # backing file here, so it cannot verify that this filename
+    # "resolves" to the actual backing BDS's filename and will thus
+    # consider both to be different.
+    # (This may be fixed in the future.)
+
+    vm.qmp_log('change-backing-file',
+               image_node_name='node0',
+               device='node0',
+               backing_file=('file:' + backing_filename))
+
+    # So now we should get a json:{} filename
+
+    log_node_info(vm.node_info('node0'))
+
+    # Remove and re-attach so we can see that (as in our first try),
+    # opening the image anew helps qemu resolve the header backing
+    # filename.
+
+    vm.qmp_log('blockdev-del', node_name='node0')
+
+    vm.qmp_log('blockdev-add',
+               node_name='node0',
+               driver=iotests.imgfmt,
+               file={
+                   'driver': 'file',
+                   'filename': top_img_path
+               },
+               filters=[filter_testfiles, filter_imgfmt])
+
+    log_node_info(vm.node_info('node0'))
+
+    vm.qmp_log('blockdev-del', node_name='node0')
+
+    log('')
+    log('--- Override backing file ---')
+    log('')
+
+    # For this test, we need the plain filename in the image header
+    # (because qemu cannot "canonicalize"/"resolve" the backing
+    # filename unless the backing file is opened implicitly with the
+    # overlay)
+    assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
+                    top_img_path) == 0
+
+    # You can only reliably override backing options by using a node
+    # reference (or by specifying file.filename, but, well...)
+    vm.qmp_log('blockdev-add', node_name='null', driver='null-co')
+
+    vm.qmp_log('blockdev-add',
+               node_name='node0',
+               driver=iotests.imgfmt,
+               file={
+                   'driver': 'file',
+                   'filename': top_img_path
+               },
+               backing='null',
+               filters=[filter_testfiles, filter_imgfmt])
+
+    # Should get a json:{} filename (and bs->backing_file is
+    # null-co://, because that field actually has not much to do
+    # with the header backing filename (except that it is changed by
+    # change-backing-file))
+
+    log_node_info(vm.node_info('node0'))
+
+    # Detach the backing file by reopening the whole thing
+
+    vm.qmp_log('blockdev-del', node_name='node0')
+    vm.qmp_log('blockdev-del', node_name='null')
+
+    vm.qmp_log('blockdev-add',
+               node_name='node0',
+               driver=iotests.imgfmt,
+               file={
+                   'driver': 'file',
+                   'filename': top_img_path
+               },
+               backing=None,
+               filters=[filter_testfiles, filter_imgfmt])
+
+    # Should get a json:{} filename (because we overrode the backing
+    # file to not be there)
+
+    log_node_info(vm.node_info('node0'))
+
+    # Open the original backing file
+
+    vm.qmp_log('blockdev-add',
+               node_name='original-backing',
+               driver=iotests.imgfmt,
+               file={
+                   'driver': 'file',
+                   'filename': base_img_path
+               },
+               filters=[filter_testfiles, filter_imgfmt])
+
+    # Attach the original backing file to its overlay
+
+    vm.qmp_log('blockdev-snapshot',
+               node='original-backing',
+               overlay='node0')
+
+    # This should give us the original plain result
+
+    log_node_info(vm.node_info('node0'))
+
+    vm.qmp_log('blockdev-del', node_name='node0')
+    vm.qmp_log('blockdev-del', node_name='original-backing')
+
+    vm.shutdown()
diff --git a/tests/qemu-iotests/228.out b/tests/qemu-iotests/228.out
new file mode 100644
index 0000000000..b01de766bc
--- /dev/null
+++ b/tests/qemu-iotests/228.out
@@ -0,0 +1,84 @@
+--- Implicit backing file ---
+
+{'execute': 'blockdev-add', 'arguments': {'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-top.img'}, 'node_name': 'node0'}}
+{u'return': {}}
+
+bs->filename: TEST_DIR/PID-top.img
+bs->backing_file: TEST_DIR/PID-base.img
+bs->backing->bs->filename: TEST_DIR/PID-base.img
+
+{'execute': 'blockdev-del', 'arguments': {'node_name': 'node0'}}
+{u'return': {}}
+
+--- change-backing-file ---
+
+{'execute': 'blockdev-add', 'arguments': {'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-top.img'}, 'node_name': 'node0'}}
+{u'return': {}}
+{'execute': 'change-backing-file', 'arguments': {'device': 'node0', 'image_node_name': 'node0', 'backing_file': 'null-co://'}}
+{u'return': {}}
+
+bs->filename: json:{"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-base.img"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
+bs->backing_file: null-co://
+bs->backing->bs->filename: TEST_DIR/PID-base.img
+
+{'execute': 'change-backing-file', 'arguments': {'device': 'node0', 'image_node_name': 'node0', 'backing_file': u'TEST_DIR/PID-base.img'}}
+{u'return': {}}
+
+bs->filename: TEST_DIR/PID-top.img
+bs->backing_file: TEST_DIR/PID-base.img
+bs->backing->bs->filename: TEST_DIR/PID-base.img
+
+{'execute': 'change-backing-file', 'arguments': {'device': 'node0', 'image_node_name': 'node0', 'backing_file': u'file:TEST_DIR/PID-base.img'}}
+{u'return': {}}
+
+bs->filename: json:{"backing": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-base.img"}}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
+bs->backing_file: file:TEST_DIR/PID-base.img
+bs->backing->bs->filename: TEST_DIR/PID-base.img
+
+{'execute': 'blockdev-del', 'arguments': {'node_name': 'node0'}}
+{u'return': {}}
+{'execute': 'blockdev-add', 'arguments': {'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-top.img'}, 'node_name': 'node0'}}
+{u'return': {}}
+
+bs->filename: TEST_DIR/PID-top.img
+bs->backing_file: TEST_DIR/PID-base.img
+bs->backing->bs->filename: TEST_DIR/PID-base.img
+
+{'execute': 'blockdev-del', 'arguments': {'node_name': 'node0'}}
+{u'return': {}}
+
+--- Override backing file ---
+
+{'execute': 'blockdev-add', 'arguments': {'driver': 'null-co', 'node_name': 'null'}}
+{u'return': {}}
+{'execute': 'blockdev-add', 'arguments': {'backing': 'null', 'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-top.img'}, 'node_name': 'node0'}}
+{u'return': {}}
+
+bs->filename: json:{"backing": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
+bs->backing_file: null-co://
+bs->backing->bs->filename: null-co://
+
+{'execute': 'blockdev-del', 'arguments': {'node_name': 'node0'}}
+{u'return': {}}
+{'execute': 'blockdev-del', 'arguments': {'node_name': 'null'}}
+{u'return': {}}
+{'execute': 'blockdev-add', 'arguments': {'backing': None, 'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-top.img'}, 'node_name': 'node0'}}
+{u'return': {}}
+
+bs->filename: json:{"backing": null, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
+bs->backing_file: TEST_DIR/PID-base.img
+bs->backing: (none)
+
+{'execute': 'blockdev-add', 'arguments': {'driver': 'IMGFMT', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-base.img'}, 'node_name': 'original-backing'}}
+{u'return': {}}
+{'execute': 'blockdev-snapshot', 'arguments': {'node': 'original-backing', 'overlay': 'node0'}}
+{u'return': {}}
+
+bs->filename: TEST_DIR/PID-top.img
+bs->backing_file: TEST_DIR/PID-base.img
+bs->backing->bs->filename: TEST_DIR/PID-base.img
+
+{'execute': 'blockdev-del', 'arguments': {'node_name': 'node0'}}
+{u'return': {}}
+{'execute': 'blockdev-del', 'arguments': {'node_name': 'original-backing'}}
+{u'return': {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b973dc842d..5bfe2e246d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -225,3 +225,4 @@
 225 rw auto quick
 226 auto quick
 227 auto quick
+228 rw auto quick
-- 
2.17.1
