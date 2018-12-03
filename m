Received: from eggs.gnu.org ([2001:4830:134:3::10]:54073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gTrYH-0007gI-0n
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:58:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gTrYF-0008LW-AP
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:58:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  3 Dec 2018 17:58:10 +0100
Message-Id: <20181203165810.14509-3-kwolf@redhat.com>
In-Reply-To: <20181203165810.14509-1-kwolf@redhat.com>
References: <20181203165810.14509-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] iotests: simple mirror test with kvm on 1G
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This test is broken without previous commit fixing dead-lock in mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/235     | 76 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/235.out |  3 ++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100755 tests/qemu-iotests/235
 create mode 100644 tests/qemu-iotests/235.out

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
new file mode 100755
index 0000000000..da044ed34e
--- /dev/null
+++ b/tests/qemu-iotests/235
@@ -0,0 +1,76 @@
+#!/usr/bin/env python
+#
+# Simple mirror test
+#
+# Copyright (c) 2018 Virtuozzo International GmbH. All rights reserved.
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
+import sys
+import os
+import iotests
+from iotests import qemu_img_create, qemu_io, file_path, log
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
+
+from qemu import QEMUMachine
+
+# Note:
+# This test was added to check that mirror dead-lock was fixed (see prev=
ious
+# commit before this test addition).
+# And it didn't reproduce if at least one of the following:
+# 1. use small image size
+# 2. use raw format (not qcow2)
+# 3. drop kvm and use iotests.VM() (maybe, because of qtest) (however, i=
t still
+#    reproduces, if just drop kvm, but gdb failed to produce full backtr=
aces
+#    for me)
+# 4. add iothread
+
+size =3D 1 * 1024 * 1024 * 1024
+
+iotests.verify_image_format(supported_fmts=3D['qcow2'])
+
+disk =3D file_path('disk')
+
+# prepare source image
+qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=3Dmetadata', =
disk,
+                str(size))
+
+vm =3D QEMUMachine(iotests.qemu_prog)
+vm.add_args('-machine', 'pc,accel=3Dkvm')
+vm.add_args('-drive', 'id=3Dsrc,file=3D' + disk)
+vm.launch()
+
+log(vm.qmp('object-add', qom_type=3D'throttle-group', id=3D'tg0',
+           props=3D{ 'x-bps-total': size }))
+
+log(vm.qmp('blockdev-add',
+           **{ 'node-name': 'target',
+               'driver': 'throttle',
+               'throttle-group': 'tg0',
+               'file': {
+                   'driver': 'null-co',
+                   'size': size
+                } }))
+
+log(vm.qmp('blockdev-mirror', device=3D'src', target=3D'target', sync=3D=
'full'))
+
+try:
+    vm.event_wait('BLOCK_JOB_READY', timeout=3D10.0)
+except:
+    vm.shutdown()
+    raise
+
+vm.shutdown()
diff --git a/tests/qemu-iotests/235.out b/tests/qemu-iotests/235.out
new file mode 100644
index 0000000000..39db621e04
--- /dev/null
+++ b/tests/qemu-iotests/235.out
@@ -0,0 +1,3 @@
+{"return": {}}
+{"return": {}}
+{"return": {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 8c56a0ad11..61a6d98ebd 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -232,3 +232,4 @@
 232 auto quick
 233 auto quick
 234 auto quick migration
+235 auto quick
--=20
2.19.2
