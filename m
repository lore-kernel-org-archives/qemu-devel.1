Received: from eggs.gnu.org ([2001:4830:134:3::10]:54415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4b1-0003YV-3F
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4az-00031A-Bs
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:29 +1000
Message-Id: <20170606025135.2685-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/17] spapr: Allow boot from vhost-*-scsi
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Felipe Franciosi <felipe@nutanix.com>, Mike Cui <cui@nutanix.com>, David Gibson <david@gibson.dropbear.id.au>

From: Felipe Franciosi <felipe@nutanix.com>

The current implementation of spapr_get_fw_dev_path() doesn't take into
consideration vhost-*-scsi devices. This makes said devices unbootable
on PPC as SLOF is unable to work out the path to scan boot disks.

This makes VMs bootable on spapr when using vhost-*-scsi by implementing
a disk path for VHostSCSICommon (which currently includes both
vhost-user-scsi and vhost-scsi).

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Signed-off-by: Mike Cui <cui@nutanix.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5d10366..c1c0951 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -57,6 +57,7 @@
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
 #include "hw/virtio/virtio-scsi.h"
+#include "hw/virtio/vhost-scsi-common.h"
 
 #include "exec/address-spaces.h"
 #include "hw/usb.h"
@@ -2384,6 +2385,7 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
     ((type *)object_dynamic_cast(OBJECT(obj), (name)))
     SCSIDevice *d = CAST(SCSIDevice,  dev, TYPE_SCSI_DEVICE);
     sPAPRPHBState *phb = CAST(sPAPRPHBState, dev, TYPE_SPAPR_PCI_HOST_BRIDGE);
+    VHostSCSICommon *vsc = CAST(VHostSCSICommon, dev, TYPE_VHOST_SCSI_COMMON);
 
     if (d) {
         void *spapr = CAST(void, bus->parent, "spapr-vscsi");
@@ -2440,6 +2442,12 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
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
2.9.4
