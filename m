Received: from eggs.gnu.org ([2001:4830:134:3::10]:58972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5Xyh-0001Qn-Kl
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5Xye-0001rw-H1
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5Xye-0001ri-8r
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42DYK32031163
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 09:36:27 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6q0n54jt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:36:27 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 14:36:24 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue,  2 May 2017 15:36:04 +0200
In-Reply-To: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
References: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Message-Id: <20170502133604.17735-13-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 12/12] hw/s390x/ipl: Fix crash with
 virtio-scsi-pci device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Thomas Huth <thuth@redhat.com>

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
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <1493126327-13162-1-git-send-email-thuth@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/ipl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 0711ee927a..75d3c681a4 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -249,7 +249,13 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
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
2.11.0
