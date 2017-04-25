Received: from eggs.gnu.org ([2001:4830:134:3::10]:39353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d30Mn-0005S6-QX
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d30Mn-0007Up-2C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d30Mm-0007Tv-SC
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:18:52 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 25 Apr 2017 15:18:47 +0200
Message-Id: <1493126327-13162-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/s390x/ipl: Fix crash with virtio-scsi-pci
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

qemu-system-s390x currently crashes when it is started with a
virtio-scsi-pci device, e.g.:

 qemu-system-s390x -nographic -enable-kvm -device virtio-scsi-pci \
                   -drive file=/tmp/disk.dat,if=none,id=d1,format=raw \
                   -device scsi-cd,drive=d1,bootindex=1

The problem is that the code in s390_gen_initial_iplb() currently assumes
that all SCSI devices are also CCW devices, which is not the case for
virtio-scsi-pci of course. Fix it by adding an appropriate check for
TYPE_CCW_DEVICE here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7978c7d..f674d50 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -248,7 +248,13 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             SCSIBus *bus = scsi_bus_from_device(sd);
             VirtIOSCSI *vdev = container_of(bus, VirtIOSCSI, bus);
             VirtIOSCSICcw *scsi_ccw = container_of(vdev, VirtIOSCSICcw, vdev);
-            CcwDevice *ccw_dev = CCW_DEVICE(scsi_ccw);
+            CcwDevice *ccw_dev;
+
+            ccw_dev = (CcwDevice *)object_dynamic_cast(OBJECT(scsi_ccw),
+                                                       TYPE_CCW_DEVICE);
+            if (!ccw_dev) {       /* It might be a PCI device instead */
+                return false;
+            }
 
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             ipl->iplb.blk0_len =
-- 
1.8.3.1
