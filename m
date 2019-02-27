Received: from eggs.gnu.org ([209.51.188.92]:41291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gz0RZ-0003Xv-Hr
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gz0RY-0007Qd-Qg
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:44:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 27 Feb 2019 14:44:13 +0000
Message-Id: <20190227144413.30975-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4] iotests: use iotests.VM in 238
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>

Test 238 does not require the kvm accelerator.  Using the qtest
accelerator allows the test to run in both non-kvm and non-tcg
environments.

iotests.VM implicitly uses the qtest accelerator and is really the class
that this test should be using.  Switch to that instead of
qemu.QEMUMachine.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/238 | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index f81ee1112f..1c0a46fa90 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -23,17 +23,12 @@ import os
 import iotests
 from iotests import log
=20
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
-
-from qemu import QEMUMachine
-
 if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
     virtio_scsi_device =3D 'virtio-scsi-ccw'
 else:
     virtio_scsi_device =3D 'virtio-scsi-pci'
=20
-vm =3D QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'accel=3Dkvm')
+vm =3D iotests.VM()
 vm.launch()
=20
 log(vm.qmp('blockdev-add', node_name=3D'hd0', driver=3D'null-co'))
--=20
2.20.1
