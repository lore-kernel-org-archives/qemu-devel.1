Received: from eggs.gnu.org ([2001:4830:134:3::10]:37060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dHuMR-0003tz-4n
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dHuMO-0008Sy-0p
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:56:07 -0400
Received: from [62.254.189.133] (port=23817 helo=centos.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dHuMN-0007us-C1
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:56:03 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Mon,  5 Jun 2017 16:55:18 +0100
Message-Id: <1496678118-27350-2-git-send-email-felipe@nutanix.com>
In-Reply-To: <1496678118-27350-1-git-send-email-felipe@nutanix.com>
References: <1496678118-27350-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH v2] spapr: Allow boot from vhost-*-scsi backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mike Cui <cui@nutanix.com>, Felipe Franciosi <felipe@nutanix.com>

The current implementation of spapr_get_fw_dev_path() doesn't take into
consideration vhost-*-scsi devices. This makes said devices unbootable
on PPC as SLOF is unable to work out the path to scan boot disks.

This makes VMs bootable on spapr when using vhost-*-scsi by implementing
a disk path for VHostSCSICommon (which currently includes both
vhost-user-scsi and vhost-scsi).

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Signed-off-by: Mike Cui <cui@nutanix.com>
---
 hw/ppc/spapr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ab3aab1..1c87886 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -57,6 +57,7 @@
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
 #include "hw/virtio/virtio-scsi.h"
+#include "hw/virtio/vhost-scsi-common.h"
 
 #include "exec/address-spaces.h"
 #include "hw/usb.h"
@@ -2388,6 +2389,7 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
     ((type *)object_dynamic_cast(OBJECT(obj), (name)))
     SCSIDevice *d = CAST(SCSIDevice,  dev, TYPE_SCSI_DEVICE);
     sPAPRPHBState *phb = CAST(sPAPRPHBState, dev, TYPE_SPAPR_PCI_HOST_BRIDGE);
+    VHostSCSICommon *vsc = CAST(VHostSCSICommon, dev, TYPE_VHOST_SCSI_COMMON);
 
     if (d) {
         void *spapr = CAST(void, bus->parent, "spapr-vscsi");
@@ -2444,6 +2446,12 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
         return g_strdup_printf("pci@%"PRIX64, phb->buid);
     }
 
+    if (vsc) {
+        /* Same logic as virtio above */
+        unsigned id = 0x1000000 | (vsc->target << 16) | vsc->lun;
+        return g_strdup_printf("disk@%"PRIX64, (uint64_t)id << 32);
+    }
+
     return NULL;
 }
 
-- 
1.9.5
