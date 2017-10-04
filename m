Received: from eggs.gnu.org ([2001:4830:134:3::10]:55446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dzk3h-00066Y-Ec
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dzk3d-0003mN-HF
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:49:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1dzk3d-0003ko-8d
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:49:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94DmxuZ103723
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 09:49:52 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcyrhmd23-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 09:49:51 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 14:49:49 +0100
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 15:49:38 +0200
In-Reply-To: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1507124979-8880-5-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 4/5] s390x/pci: Refuse to realize VFIO-PCI
 if AIS needed but supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

In S390x the Adapter Interrupt Suppression facility is used to mask
interrupts of other PCI devices during interruption handling.

VFIO PCI allows the interrupts to be delivered rapidely through KVM via
IRQfd or to be delivered through QEMU.
The choice is made through the x-kvm-intx and x-kvo-misx properties of
the VFIO PCI device.

If the VFIO PCI device is using the direct KVM access through IRQfd and
we know that KVM does not implement AIS support we refuse to realize the
VFIO PCI device.

In all other cases, emulation and VFIO PCI sending interrupts through
QEMU, we intercept the propagated IRQ, and protect it with the QEMU AIS
implementation before to send it to the guest through KVM.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index d9c294a..4afe49b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -21,18 +21,21 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
+#include "hw/vfio/pci.h"
 #include "qemu/error-report.h"
 
 #ifndef DEBUG_S390PCI_BUS
 #define DEBUG_S390PCI_BUS  0
 #endif
 
+#ifndef DPRINTF
 #define DPRINTF(fmt, ...)                                         \
     do {                                                          \
         if (DEBUG_S390PCI_BUS) {                                  \
             fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); \
         }                                                         \
     } while (0)
+#endif
 
 S390pciState *s390_get_phb(void)
 {
@@ -751,6 +754,15 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
         }
 
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
+            S390FLICState *fs = s390_get_flic();
+            VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+
+            if ((!vdev->no_kvm_msix || !vdev->no_kvm_msix) &&
+                (!fs || !fs->ais_supported)) {
+                error_setg(errp, "VFIO PCI is not supported "
+                           "because kernel has no AIS capability.");
+                return;
+            }
             pbdev->fh |= FH_SHM_VFIO;
         } else {
             pbdev->fh |= FH_SHM_EMUL;
-- 
2.3.0
