Received: from eggs.gnu.org ([2001:4830:134:3::10]:34181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1dX-00086O-LB
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1dW-0006jY-3p
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:45:19 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:48 +0100
Message-Id: <20181217224348.14922-32-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 31/31] iotests: Test json:{} filenames of
 internal BDSs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/224     | 139 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/224.out |  18 +++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 158 insertions(+)
 create mode 100755 tests/qemu-iotests/224
 create mode 100644 tests/qemu-iotests/224.out

diff --git a/tests/qemu-iotests/224 b/tests/qemu-iotests/224
new file mode 100755
index 0000000000..ef652ad488
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
+iotests.verify_image_format(supported_fmts=3D['qcow2', 'qcow', 'qed'])
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
+                        base_img_path, '64M') =3D=3D 0
+        assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_p=
ath,
+                        mid_img_path) =3D=3D 0
+        assert qemu_img('create', '-f', iotests.imgfmt, '-b', mid_img_pa=
th,
+                        top_img_path) =3D=3D 0
+
+        # Something to commit
+        assert qemu_io_silent(mid_img_path, '-c', 'write -P 1 0 1M') =3D=
=3D 0
+
+        vm.launch()
+
+        # Change the bottom-most image's backing file (to null-co://)
+        # to enforce json:{} filenames
+        vm.qmp_log('blockdev-add',
+                    node_name=3D'top',
+                    driver=3Diotests.imgfmt,
+                    file=3D{
+                        'driver': 'file',
+                        'filename': top_img_path
+                    },
+                    backing=3D{
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
+                    filters=3D[filter_testfiles, filter_imgfmt])
+
+        # As long as block-commit does not accept node names, we have to
+        # get our mid/base filenames here
+        mid_name =3D vm.node_info('mid')['image']['filename']
+        base_name =3D vm.node_info('base')['image']['filename']
+
+        assert mid_name[:5] =3D=3D 'json:'
+        assert base_name[:5] =3D=3D 'json:'
+
+        # Start the block job
+        if filter_node_name:
+            vm.qmp_log('block-commit',
+                        job_id=3D'commit',
+                        device=3D'top',
+                        filter_node_name=3D'filter_node',
+                        top=3Dmid_name,
+                        base=3Dbase_name,
+                        speed=3D1,
+                        filters=3D[filter_testfiles, filter_imgfmt])
+        else:
+            vm.qmp_log('block-commit',
+                        job_id=3D'commit',
+                        device=3D'top',
+                        top=3Dmid_name,
+                        base=3Dbase_name,
+                        speed=3D1,
+                        filters=3D[filter_testfiles, filter_imgfmt])
+
+        vm.qmp_log('job-pause', id=3D'commit')
+
+        # Get and parse top's json:{} filename
+        top_name =3D vm.node_info('top')['image']['filename']
+
+        vm.shutdown()
+
+        assert top_name[:5] =3D=3D 'json:'
+        top_options =3D json.loads(top_name[5:])
+
+        if filter_node_name:
+            # This should be present and set
+            assert top_options['backing']['driver'] =3D=3D 'commit_top'
+            # And the mid image is commit_top's backing image
+            mid_options =3D top_options['backing']['backing']
+        else:
+            # The mid image should appear as the immediate backing BDS
+            # of top
+            mid_options =3D top_options['backing']
+
+        assert mid_options['driver'] =3D=3D iotests.imgfmt
+        assert mid_options['file']['filename'] =3D=3D mid_img_path
diff --git a/tests/qemu-iotests/224.out b/tests/qemu-iotests/224.out
new file mode 100644
index 0000000000..2eb34438cf
--- /dev/null
+++ b/tests/qemu-iotests/224.out
@@ -0,0 +1,18 @@
+
+--- filter_node_name: False ---
+
+{"execute": "blockdev-add", "arguments": {"backing": {"backing": {"backi=
ng": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file"=
, "filename": "TEST_DIR/PID-base.img"}, "node-name": "base"}, "driver": "=
IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-mid.img"}, =
"node-name": "mid"}, "driver": "IMGFMT", "file": {"driver": "file", "file=
name": "TEST_DIR/PID-top.img"}, "node_name": "top"}}
+{"return": {}}
+{"execute": "block-commit", "arguments": {"base": "json:{\"backing\": {\=
"driver\": \"null-co\"}, \"driver\": \"IMGFMT\", \"file\": {\"driver\": \=
"file\", \"filename\": \"TEST_DIR/PID-base.img\"}}", "device": "top", "jo=
b_id": "commit", "speed": 1, "top": "json:{\"backing\": {\"backing\": {\"=
driver\": \"null-co\"}, \"driver\": \"IMGFMT\", \"file\": {\"driver\": \"=
file\", \"filename\": \"TEST_DIR/PID-base.img\"}}, \"driver\": \"IMGFMT\"=
, \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/PID-mid.img\"=
}}"}}
+{"return": {}}
+{"execute": "job-pause", "arguments": {"id": "commit"}}
+{"return": {}}
+
+--- filter_node_name: True ---
+
+{"execute": "blockdev-add", "arguments": {"backing": {"backing": {"backi=
ng": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file"=
, "filename": "TEST_DIR/PID-base.img"}, "node-name": "base"}, "driver": "=
IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-mid.img"}, =
"node-name": "mid"}, "driver": "IMGFMT", "file": {"driver": "file", "file=
name": "TEST_DIR/PID-top.img"}, "node_name": "top"}}
+{"return": {}}
+{"execute": "block-commit", "arguments": {"base": "json:{\"backing\": {\=
"driver\": \"null-co\"}, \"driver\": \"IMGFMT\", \"file\": {\"driver\": \=
"file\", \"filename\": \"TEST_DIR/PID-base.img\"}}", "device": "top", "fi=
lter_node_name": "filter_node", "job_id": "commit", "speed": 1, "top": "j=
son:{\"backing\": {\"backing\": {\"driver\": \"null-co\"}, \"driver\": \"=
IMGFMT\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/PID-b=
ase.img\"}}, \"driver\": \"IMGFMT\", \"file\": {\"driver\": \"file\", \"f=
ilename\": \"TEST_DIR/PID-mid.img\"}}"}}
+{"return": {}}
+{"execute": "job-pause", "arguments": {"id": "commit"}}
+{"return": {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 98a895e7e8..2f70e0f8cb 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -224,6 +224,7 @@
 221 rw auto quick
 222 rw auto quick
 223 rw auto quick
+224 rw auto quick
 225 rw auto quick
 226 auto quick
 227 auto quick
--=20
2.19.2
