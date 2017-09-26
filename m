Received: from eggs.gnu.org ([2001:4830:134:3::10]:32793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkN-0001Pd-LW
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkK-0005KZ-Nc
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:03 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:15 +0200
Message-Id: <20170926142133.2498-7-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/24] iotests: use -ccw on s390x for 051
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

From: Cornelia Huck <cohuck@redhat.com>

The default cpu model on s390x does not provide zPCI, which is
not yet wired up on tcg. Moreover, virtio-ccw is the standard
on s390x, so use the -ccw instead of the -pci versions of virtio
devices on s390x.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/051        | 12 +++++++++++-
 tests/qemu-iotests/051.out    |  2 +-
 tests/qemu-iotests/051.pc.out |  2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index c8cfc764bc..dba8816c9f 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -103,7 +103,17 @@ echo
 echo === Device without drive ===
 echo
 
-run_qemu -device virtio-scsi-pci -device scsi-hd
+case "$QEMU_DEFAULT_MACHINE" in
+  s390-ccw-virtio)
+      virtio_scsi=virtio-scsi-ccw
+      ;;
+  *)
+      virtio_scsi=virtio-scsi-pci
+      ;;
+esac
+
+run_qemu -device $virtio_scsi -device scsi-hd |
+    sed -e "s/$virtio_scsi/VIRTIO_SCSI/"
 
 echo
 echo === Overriding backing file ===
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 4d3b1ff316..e3c6eaba57 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -49,7 +49,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2: Cannot specif
 
 === Device without drive ===
 
-Testing: -device virtio-scsi-pci -device scsi-hd
+Testing: -device VIRTIO_SCSI -device scsi-hd
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -device scsi-hd: drive property not set
 
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 762fb9f42c..f2c5622cee 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -49,7 +49,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2: Cannot specif
 
 === Device without drive ===
 
-Testing: -device virtio-scsi-pci -device scsi-hd
+Testing: -device VIRTIO_SCSI -device scsi-hd
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -device scsi-hd: drive property not set
 
-- 
2.13.5
