Received: from eggs.gnu.org ([2001:4830:134:3::10]:57874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dGKtu-0008VK-EY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dGKtq-0004dn-I7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:52:10 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu,  1 Jun 2017 08:51:58 +0100
Message-Id: <1496303518-25638-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH] spapr: Allow boot from vhost-*-scsi backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Felipe Franciosi <felipe@nutanix.com>, Mike Cui <cui@nutanix.com>

This makes VMs bootable on spapr when using vhost-*-scsi.

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
