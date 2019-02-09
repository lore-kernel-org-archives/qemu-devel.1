Received: from eggs.gnu.org ([209.51.188.92]:46624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gsJqA-00013f-Br
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gsJq9-0000Nx-Hx
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:02:06 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  8 Feb 2019 23:01:31 -0500
Message-Id: <20190209040132.25573-2-crosa@redhat.com>
In-Reply-To: <20190209040132.25573-1-crosa@redhat.com>
References: <20190209040132.25573-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] qemu-iotests: only enable kvm if the host
 seems to support it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>

There are certainly some improvements to be made with regards
to kvm capabilities detection, but this seems good enough for
this specific case.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/235 | 5 +++--
 tests/qemu-iotests/238 | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index d6edd97ab4..c83b548adc 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -25,7 +25,7 @@ from iotests import qemu_img_create, qemu_io, file_path=
, log
=20
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
=20
-from qemu import QEMUMachine
+from qemu import QEMUMachine, kvm_available
=20
 # Note:
 # This test was added to check that mirror dead-lock was fixed (see prev=
ious
@@ -49,7 +49,8 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocat=
ion=3Dmetadata', disk,
                 str(size))
=20
 vm =3D QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'accel=3Dkvm')
+if kvm_available():
+        vm.add_args('-machine', 'accel=3Dkvm')
 if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
         vm.add_args('-no-shutdown')
 vm.add_args('-drive', 'id=3Dsrc,file=3D' + disk)
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index f81ee1112f..75ccd5f82f 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -25,7 +25,7 @@ from iotests import log
=20
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
=20
-from qemu import QEMUMachine
+from qemu import QEMUMachine, kvm_available
=20
 if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
     virtio_scsi_device =3D 'virtio-scsi-ccw'
@@ -33,7 +33,8 @@ else:
     virtio_scsi_device =3D 'virtio-scsi-pci'
=20
 vm =3D QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'accel=3Dkvm')
+if kvm_available():
+        vm.add_args('-machine', 'accel=3Dkvm')
 vm.launch()
=20
 log(vm.qmp('blockdev-add', node_name=3D'hd0', driver=3D'null-co'))
--=20
2.20.1
