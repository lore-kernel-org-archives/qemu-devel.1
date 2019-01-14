Received: from eggs.gnu.org ([209.51.188.92]:40708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj2Mf-0006d7-GC
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj2Me-0002Ye-9B
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:33:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 14 Jan 2019 13:32:57 +0000
Message-Id: <20190114133257.30299-3-stefanha@redhat.com>
In-Reply-To: <20190114133257.30299-1-stefanha@redhat.com>
References: <20190114133257.30299-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] iotests: add 238 for throttling tgm
 unregister iothread segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hot-unplug a scsi-hd using an iothread.  The previous patch fixes a
segfault in this scenario.

This patch adds a regression test.

Suggested-by: Alberto Garcia <berto@igalia.com>
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
 * Added qemu-iotests test case [Kevin, Alberto]
---
 tests/qemu-iotests/238     | 47 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/238.out |  6 +++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 54 insertions(+)
 create mode 100755 tests/qemu-iotests/238
 create mode 100644 tests/qemu-iotests/238.out

diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
new file mode 100755
index 0000000000..f81ee1112f
--- /dev/null
+++ b/tests/qemu-iotests/238
@@ -0,0 +1,47 @@
+#!/usr/bin/env python
+#
+# Regression test for throttle group member unregister segfault with iot=
hread
+#
+# Copyright (c) 2019 Red Hat, Inc.
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
+from iotests import log
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
+
+from qemu import QEMUMachine
+
+if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
+    virtio_scsi_device =3D 'virtio-scsi-ccw'
+else:
+    virtio_scsi_device =3D 'virtio-scsi-pci'
+
+vm =3D QEMUMachine(iotests.qemu_prog)
+vm.add_args('-machine', 'accel=3Dkvm')
+vm.launch()
+
+log(vm.qmp('blockdev-add', node_name=3D'hd0', driver=3D'null-co'))
+log(vm.qmp('object-add', qom_type=3D'iothread', id=3D'iothread0'))
+log(vm.qmp('device_add', id=3D'scsi0', driver=3Dvirtio_scsi_device, ioth=
read=3D'iothread0'))
+log(vm.qmp('device_add', id=3D'scsi-hd0', driver=3D'scsi-hd', drive=3D'h=
d0'))
+log(vm.qmp('block_set_io_throttle', id=3D'scsi-hd0', bps=3D0, bps_rd=3D0=
, bps_wr=3D0,
+           iops=3D1000, iops_rd=3D0, iops_wr=3D0, conv_keys=3DFalse))
+log(vm.qmp('device_del', id=3D'scsi-hd0'))
+
+vm.shutdown()
diff --git a/tests/qemu-iotests/238.out b/tests/qemu-iotests/238.out
new file mode 100644
index 0000000000..4de840ba8c
--- /dev/null
+++ b/tests/qemu-iotests/238.out
@@ -0,0 +1,6 @@
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 61a6d98ebd..1f55bcf4e6 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -233,3 +233,4 @@
 233 auto quick
 234 auto quick migration
 235 auto quick
+238 auto quick
--=20
2.20.1
