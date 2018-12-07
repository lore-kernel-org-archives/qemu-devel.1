Received: from eggs.gnu.org ([2001:4830:134:3::10]:51912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVEhy-0007A6-L2
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVEhw-00066a-AO
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:54:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Dec 2018 12:53:42 +0100
Message-Id: <20181207115343.6747-5-kwolf@redhat.com>
In-Reply-To: <20181207115343.6747-1-kwolf@redhat.com>
References: <20181207115343.6747-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/5] iotests: Add VMDK tests for
 blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/237     | 233 +++++++++++++++++++++++++
 tests/qemu-iotests/237.out | 347 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 581 insertions(+)
 create mode 100755 tests/qemu-iotests/237
 create mode 100644 tests/qemu-iotests/237.out

diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
new file mode 100755
index 0000000000..e04a1ac6be
--- /dev/null
+++ b/tests/qemu-iotests/237
@@ -0,0 +1,233 @@
+#!/usr/bin/env python
+#
+# Test vmdk and file image creation
+#
+# Copyright (C) 2018 Red Hat, Inc.
+#
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
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
+import iotests
+from iotests import imgfmt
+
+iotests.verify_image_format(supported_fmts=3D['vmdk'])
+
+def blockdev_create(vm, options):
+    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options)
+
+    if 'return' in result:
+        assert result['return'] =3D=3D {}
+        vm.run_job('job0')
+    iotests.log("")
+
+with iotests.FilePath('t.vmdk') as disk_path, \
+     iotests.FilePath('t.vmdk.1') as extent1_path, \
+     iotests.FilePath('t.vmdk.2') as extent2_path, \
+     iotests.FilePath('t.vmdk.3') as extent3_path, \
+     iotests.VM() as vm:
+
+    #
+    # Successful image creation (defaults)
+    #
+    iotests.log("=3D=3D=3D Successful image creation (defaults) =3D=3D=3D=
")
+    iotests.log("")
+
+    size =3D 5 * 1024 * 1024 * 1024
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'file',
+                          'filename': disk_path,
+                          'size': 0 })
+
+    vm.qmp_log('blockdev-add', driver=3D'file', filename=3Ddisk_path,
+               node_name=3D'imgfile')
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'imgfile',
+                          'size': size })
+    vm.shutdown()
+
+    iotests.img_info_log(disk_path)
+
+    #
+    # Successful image creation (inline blockdev-add, explicit defaults)
+    #
+    iotests.log("=3D=3D=3D Successful image creation (inline blockdev-ad=
d, explicit defaults) =3D=3D=3D")
+    iotests.log("")
+
+    # Choose a different size to show that we got a new image
+    size =3D 64 * 1024 * 1024
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'file',
+                          'filename': disk_path,
+                          'size': 0 })
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': {
+                              'driver': 'file',
+                              'filename': disk_path,
+                          },
+                          'size': size,
+                          'extents': [],
+                          'subformat': 'monolithicSparse',
+                          'adapter-type': 'ide',
+                          'hwversion': '4',
+                          'zeroed-grain': False })
+    vm.shutdown()
+
+    iotests.img_info_log(disk_path)
+
+    #
+    # Successful image creation (non-default options)
+    #
+    iotests.log("=3D=3D=3D Successful image creation (with non-default o=
ptions) =3D=3D=3D")
+    iotests.log("")
+
+    # Choose a different size to show that we got a new image
+    size =3D 32 * 1024 * 1024
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'file',
+                          'filename': disk_path,
+                          'size': 0 })
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': {
+                              'driver': 'file',
+                              'filename': disk_path,
+                          },
+                          'size': size,
+                          'extents': [],
+                          'subformat': 'monolithicSparse',
+                          'adapter-type': 'buslogic',
+                          'zeroed-grain': True })
+    vm.shutdown()
+
+    iotests.img_info_log(disk_path)
+
+    #
+    # Invalid BlockdevRef
+    #
+    iotests.log("=3D=3D=3D Invalid BlockdevRef =3D=3D=3D")
+    iotests.log("")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': "this doesn't exist",
+                          'size': size })
+    vm.shutdown()
+
+    #
+    # Adapter types
+    #
+
+    iotests.log("=3D=3D=3D Adapter types =3D=3D=3D")
+    iotests.log("")
+
+    vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dnode0' % (d=
isk_path))
+
+    # Valid
+    iotests.log("=3D=3D Valid adapter types =3D=3D")
+    iotests.log("")
+
+    vm.launch()
+    for adapter_type in [ 'ide', 'buslogic', 'lsilogic', 'legacyESX' ]:
+        blockdev_create(vm, { 'driver': imgfmt,
+                              'file': 'node0',
+                              'size': size,
+                              'adapter-type': adapter_type })
+    vm.shutdown()
+
+    # Invalid
+    iotests.log("=3D=3D Invalid adapter types =3D=3D")
+    iotests.log("")
+
+    vm.launch()
+    for adapter_type in [ 'foo', 'IDE', 'legacyesx', 1 ]:
+        blockdev_create(vm, { 'driver': imgfmt,
+                              'file': 'node0',
+                              'size': size,
+                              'adapter-type': adapter_type })
+    vm.shutdown()
+
+    #
+    # Other subformats
+    #
+    iotests.log("=3D=3D=3D Other subformats =3D=3D=3D")
+    iotests.log("")
+
+    for path in [ extent1_path, extent2_path, extent3_path ]:
+        msg =3D iotests.qemu_img_pipe('create', '-f', imgfmt, path, '0')
+        iotests.log(msg, [iotests.filter_testfiles])
+
+    vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dext1' % (ex=
tent1_path))
+    vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dext2' % (ex=
tent2_path))
+    vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dext3' % (ex=
tent3_path))
+
+    # Missing extent
+    iotests.log("=3D=3D Missing extent =3D=3D")
+    iotests.log("")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': size,
+                          'subformat': 'monolithicFlat' })
+    vm.shutdown()
+
+    # Correct extent
+    iotests.log("=3D=3D Correct extent =3D=3D")
+    iotests.log("")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': size,
+                          'subformat': 'monolithicFlat',
+                          'extents': ['ext1'] })
+    vm.shutdown()
+
+    # Extra extent
+    iotests.log("=3D=3D Extra extent =3D=3D")
+    iotests.log("")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 512,
+                          'subformat': 'monolithicFlat',
+                          'extents': ['ext1', 'ext2', 'ext3'] })
+    vm.shutdown()
+
+    # Split formats
+    iotests.log("=3D=3D Split formats =3D=3D")
+    iotests.log("")
+
+    for size in [ 512, 1073741824, 2147483648, 5368709120 ]:
+        for subfmt in [ 'twoGbMaxExtentFlat', 'twoGbMaxExtentSparse' ]:
+            iotests.log("=3D %s %d =3D" % (subfmt, size))
+            iotests.log("")
+
+            vm.launch()
+            blockdev_create(vm, { 'driver': imgfmt,
+                                  'file': 'node0',
+                                  'size': size,
+                                  'subformat': subfmt,
+                                  'extents': ['ext1', 'ext2', 'ext3'] })
+            vm.shutdown()
+
+            iotests.img_info_log(disk_path)
diff --git a/tests/qemu-iotests/237.out b/tests/qemu-iotests/237.out
new file mode 100644
index 0000000000..1aa9aad349
--- /dev/null
+++ b/tests/qemu-iotests/237.out
@@ -0,0 +1,347 @@
+=3D=3D=3D Successful image creation (defaults) =3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vmdk", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vmdk", "node_name": "imgfile"}}
+{"return": {}}
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "file": "imgfile", "size": 5368709120}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 5.0G (5368709120 bytes)
+cluster_size: 65536
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: monolithicSparse
+    extents:
+        [0]:
+            virtual size: 5368709120
+            filename: TEST_IMG
+            cluster size: 65536
+            format:=20
+
+=3D=3D=3D Successful image creation (inline blockdev-add, explicit defau=
lts) =3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vmdk", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "ide", "driver": "vmdk", "extents": [], "file": {"driv=
er": "file", "filename": "TEST_DIR/PID-t.vmdk"}, "hwversion": "4", "size"=
: 67108864, "subformat": "monolithicSparse", "zeroed-grain": false}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: monolithicSparse
+    extents:
+        [0]:
+            virtual size: 67108864
+            filename: TEST_IMG
+            cluster size: 65536
+            format:=20
+
+=3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vmdk", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "buslogic", "driver": "vmdk", "extents": [], "file": {=
"driver": "file", "filename": "TEST_DIR/PID-t.vmdk"}, "size": 33554432, "=
subformat": "monolithicSparse", "zeroed-grain": true}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 32M (33554432 bytes)
+cluster_size: 65536
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: monolithicSparse
+    extents:
+        [0]:
+            virtual size: 33554432
+            filename: TEST_IMG
+            cluster size: 65536
+            format:=20
+
+=3D=3D=3D Invalid BlockdevRef =3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "file": "this doesn't exist", "size": 33554432}}}
+{"return": {}}
+Job failed: Cannot find device=3Dthis doesn't exist nor node_name=3Dthis=
 doesn't exist
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+=3D=3D=3D Adapter types =3D=3D=3D
+
+=3D=3D Valid adapter types =3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "ide", "driver": "vmdk", "file": "node0", "size": 3355=
4432}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "buslogic", "driver": "vmdk", "file": "node0", "size":=
 33554432}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "lsilogic", "driver": "vmdk", "file": "node0", "size":=
 33554432}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "legacyESX", "driver": "vmdk", "file": "node0", "size"=
: 33554432}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+=3D=3D Invalid adapter types =3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "foo", "driver": "vmdk", "file": "node0", "size": 3355=
4432}}}
+{"error": {"class": "GenericError", "desc": "Invalid parameter 'foo'"}}
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "IDE", "driver": "vmdk", "file": "node0", "size": 3355=
4432}}}
+{"error": {"class": "GenericError", "desc": "Invalid parameter 'IDE'"}}
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "legacyesx", "driver": "vmdk", "file": "node0", "size"=
: 33554432}}}
+{"error": {"class": "GenericError", "desc": "Invalid parameter 'legacyes=
x'"}}
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": 1, "driver": "vmdk", "file": "node0", "size": 33554432=
}}}
+{"error": {"class": "GenericError", "desc": "Invalid parameter type for =
'options.adapter-type', expected: string"}}
+
+=3D=3D=3D Other subformats =3D=3D=3D
+
+Formatting 'TEST_DIR/PID-t.vmdk.1', fmt=3Dvmdk size=3D0 compat6=3Doff hw=
version=3Dundefined
+
+Formatting 'TEST_DIR/PID-t.vmdk.2', fmt=3Dvmdk size=3D0 compat6=3Doff hw=
version=3Dundefined
+
+Formatting 'TEST_DIR/PID-t.vmdk.3', fmt=3Dvmdk size=3D0 compat6=3Doff hw=
version=3Dundefined
+
+=3D=3D Missing extent =3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "file": "node0", "size": 33554432, "subformat": "mon=
olithicFlat"}}}
+{"return": {}}
+Job failed: Extent [0] not specified
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+=3D=3D Correct extent =3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 335544=
32, "subformat": "monolithicFlat"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+=3D=3D Extra extent =3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 512, "subformat": "monolithicFlat"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+=3D=3D Split formats =3D=3D
+
+=3D twoGbMaxExtentFlat 512 =3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 512, "subformat": "twoGbMaxExtentFlat"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 512 (512 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentFlat
+    extents:
+        [0]:
+            virtual size: 512
+            filename: TEST_IMG.1
+            format: FLAT
+
+=3D twoGbMaxExtentSparse 512 =3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 512, "subformat": "twoGbMaxExtentSparse"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 512 (512 bytes)
+cluster_size: 65536
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentSparse
+    extents:
+        [0]:
+            virtual size: 512
+            filename: TEST_IMG.1
+            cluster size: 65536
+            format: SPARSE
+
+=3D twoGbMaxExtentFlat 1073741824 =3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 1073741824, "subformat": "twoGbMaxExtentFlat"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1.0G (1073741824 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentFlat
+    extents:
+        [0]:
+            virtual size: 1073741824
+            filename: TEST_IMG.1
+            format: FLAT
+
+=3D twoGbMaxExtentSparse 1073741824 =3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 1073741824, "subformat": "twoGbMaxExtentSparse"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1.0G (1073741824 bytes)
+cluster_size: 65536
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentSparse
+    extents:
+        [0]:
+            virtual size: 1073741824
+            filename: TEST_IMG.1
+            cluster size: 65536
+            format: SPARSE
+
+=3D twoGbMaxExtentFlat 2147483648 =3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 2147483648, "subformat": "twoGbMaxExtentFlat"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 2.0G (2147483648 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentFlat
+    extents:
+        [0]:
+            virtual size: 2147483648
+            filename: TEST_IMG.1
+            format: FLAT
+
+=3D twoGbMaxExtentSparse 2147483648 =3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 2147483648, "subformat": "twoGbMaxExtentSparse"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 2.0G (2147483648 bytes)
+cluster_size: 65536
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentSparse
+    extents:
+        [0]:
+            virtual size: 2147483648
+            filename: TEST_IMG.1
+            cluster size: 65536
+            format: SPARSE
+
+=3D twoGbMaxExtentFlat 5368709120 =3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 5368709120, "subformat": "twoGbMaxExtentFlat"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 5.0G (5368709120 bytes)
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentFlat
+    extents:
+        [0]:
+            virtual size: 2147483648
+            filename: TEST_IMG.1
+            format: FLAT
+        [1]:
+            virtual size: 2147483648
+            filename: TEST_IMG.2
+            format: FLAT
+        [2]:
+            virtual size: 1073741824
+            filename: TEST_IMG.3
+            format: FLAT
+
+=3D twoGbMaxExtentSparse 5368709120 =3D
+
+{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 5368709120, "subformat": "twoGbMaxExtentSparse"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 5.0G (5368709120 bytes)
+cluster_size: 65536
+Format specific information:
+    cid: XXXXXXXXXX
+    parent cid: XXXXXXXXXX
+    create type: twoGbMaxExtentSparse
+    extents:
+        [0]:
+            virtual size: 2147483648
+            filename: TEST_IMG.1
+            cluster size: 65536
+            format: SPARSE
+        [1]:
+            virtual size: 2147483648
+            filename: TEST_IMG.2
+            cluster size: 65536
+            format: SPARSE
+        [2]:
+            virtual size: 1073741824
+            filename: TEST_IMG.3
+            cluster size: 65536
+            format: SPARSE
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 61a6d98ebd..c4de595f29 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -233,3 +233,4 @@
 233 auto quick
 234 auto quick migration
 235 auto quick
+237 rw auto quick
--=20
2.19.2
