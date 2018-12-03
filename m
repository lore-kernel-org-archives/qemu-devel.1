Received: from eggs.gnu.org ([2001:4830:134:3::10]:44117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTptW-0002cF-Iw
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTptV-0006PN-7v
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:12:22 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Dec 2018 16:12:09 +0100
Message-Id: <20181203151209.17331-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 v3] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, dplotnikov@virtuozzo.com

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This test is broken without previous commit fixing dead-lock in mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Based-on: 20181129101801.6421-2-vsementsov@virtuozzo.com

This is a v3 to the second patch of "[PATCH v2 0/2] mirror dead-lock" by
Vladimir.  Instead of mirroring from a fully allocated image, this
version mirrors from a preallocation=3Dmetadata image, and it mirrors not
to the real disk, but to a throttle/null-co combination.

The advantages are that it is an indicator of the bug independently of
disk speed (Vladimir's version always worked on tmpfs for me), and that
it allocates less than 1 MB of space in contrast to 2 GB.

The disadvantage is that it is not a real-life use case.  We may want to
add Vladimir's test, too, probably in a special group that is not
executed by default.

Also, this version fixes compatibility with python3 (by using
iotests.log()), and it kills the VM even on failure (by catching and
reraising the exception, after the VM has been shut down).

Finally, the test can still be in the quick group, because it turns out
that bps-total=3Dsize is enough to make it fail before the fix (so it run=
s
in 1 s if it passes).
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
