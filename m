Received: from eggs.gnu.org ([209.51.188.92]:59438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqt-0002Ee-Ul
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqr-0002tX-RB
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  2 Apr 2019 14:48:59 +0200
Message-Id: <20190402124907.24421-2-kwolf@redhat.com>
In-Reply-To: <20190402124907.24421-1-kwolf@redhat.com>
References: <20190402124907.24421-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] iotests: Fix test 200 on s390x without
 virtio-pci
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

From: Thomas Huth <thuth@redhat.com>

virtio-pci is optional on s390x, e.g. in downstream RHEL builds, it
is disabled. On s390x, virtio-ccw should be used instead. Other tests
like 051 or 240 already use virtio-scsi-ccw instead of virtio-scsi-pci
on s390x, so let's do the same here and always use virtio-scsi-ccw on
s390x.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/200 | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index 12d25f4a1c..1c0f8cafc2 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -52,13 +52,21 @@ ${QEMU_IMG} create -f $IMGFMT -F $IMGFMT "${TEST_IMG}=
" -b "${BACKING_IMG}" 512M
=20
 ${QEMU_IO} -c "write -P 0xa5 512 300M" "${BACKING_IMG}" | _filter_qemu_i=
o
=20
+case "$QEMU_DEFAULT_MACHINE" in
+  s390-ccw-virtio)
+      virtio_scsi=3D"-device virtio-scsi-ccw,id=3Dscsi0,iothread=3Diothr=
ead0"
+      ;;
+  *)
+      virtio_scsi=3D"-device pci-bridge,id=3Dbridge1,chassis_nr=3D1,bus=3D=
pci.0
+          -device virtio-scsi-pci,bus=3Dbridge1,addr=3D0x1f,id=3Dscsi0,i=
othread=3Diothread0"
+      ;;
+esac
+
 echo
 echo =3D=3D=3D Starting QEMU VM =3D=3D=3D
 echo
 qemu_comm_method=3D"qmp"
-_launch_qemu -device pci-bridge,id=3Dbridge1,chassis_nr=3D1,bus=3Dpci.0 =
\
-             -object iothread,id=3Diothread0 \
-             -device virtio-scsi-pci,bus=3Dbridge1,addr=3D0x1f,id=3Dscsi=
0,iothread=3Diothread0 \
+_launch_qemu -object iothread,id=3Diothread0 $virtio_scsi \
              -drive file=3D"${TEST_IMG}",media=3Ddisk,if=3Dnone,cache=3D=
$CACHEMODE,id=3Ddrive_sysdisk,format=3D$IMGFMT \
              -device scsi-hd,drive=3Ddrive_sysdisk,bus=3Dscsi0.0,id=3Dsy=
sdisk,bootindex=3D0
 h1=3D$QEMU_HANDLE
--=20
2.20.1
