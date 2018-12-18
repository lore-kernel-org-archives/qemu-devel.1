Received: from eggs.gnu.org ([2001:4830:134:3::10]:51064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6pR-0005De-57
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6pL-0007AA-V2
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:17:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZ6pI-000731-91
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:17:50 -0500
Date: Mon, 17 Dec 2018 23:17:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218041625.24969-15-mst@redhat.com>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 14/31] pcie: Fill PCIESlot link fields to
 support higher speeds and widths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Geoffrey McRae <geoff@hostfission.com>

From: Alex Williamson <alex.williamson@redhat.com>

Make use of the PCIESlot speed and width fields to update link
information beyond those configured in pcie_cap_v1_fill().  This is
only called for devices supporting a version 2 capability and
automatically skips any non-PCIESlot devices.  Only devices with
increased link values generate any visible config space differences.

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6891deb711..d91a615193 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -27,6 +27,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pcie_regs.h"
+#include "hw/pci/pcie_port.h"
 #include "qemu/range.h"
 
 //#define DEBUG_PCIE
@@ -87,6 +88,76 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
     pci_set_word(cmask + PCI_EXP_LNKSTA, 0);
 }
 
+static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
+{
+    PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
+    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
+
+    /* Skip anything that isn't a PCIESlot */
+    if (!s) {
+        return;
+    }
+
+    /* Clear and fill LNKCAP from what was configured above */
+    pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
+                                 PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
+    pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
+                               QEMU_PCI_EXP_LNKCAP_MLW(s->width) |
+                               QEMU_PCI_EXP_LNKCAP_MLS(s->speed));
+
+    /*
+     * Link bandwidth notification is required for all root ports and
+     * downstream ports supporting links wider than x1 or multiple link
+     * speeds.
+     */
+    if (s->width > QEMU_PCI_EXP_LNK_X1 ||
+        s->speed > QEMU_PCI_EXP_LNK_2_5GT) {
+        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
+                                   PCI_EXP_LNKCAP_LBNC);
+    }
+
+    if (s->speed > QEMU_PCI_EXP_LNK_2_5GT) {
+        /*
+         * Hot-plug capable downstream ports and downstream ports supporting
+         * link speeds greater than 5GT/s must hardwire PCI_EXP_LNKCAP_DLLLARC
+         * to 1b.  PCI_EXP_LNKCAP_DLLLARC implies PCI_EXP_LNKSTA_DLLLA, which
+         * we also hardwire to 1b here.  2.5GT/s hot-plug slots should also
+         * technically implement this, but it's not done here for compatibility.
+         */
+        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
+                                   PCI_EXP_LNKCAP_DLLLARC);
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                                   PCI_EXP_LNKSTA_DLLLA);
+
+        /*
+         * Target Link Speed defaults to the highest link speed supported by
+         * the component.  2.5GT/s devices are permitted to hardwire to zero.
+         */
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKCTL2,
+                                     PCI_EXP_LNKCTL2_TLS);
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKCTL2,
+                                   QEMU_PCI_EXP_LNKCAP_MLS(s->speed) &
+                                   PCI_EXP_LNKCTL2_TLS);
+    }
+
+    /*
+     * 2.5 & 5.0GT/s can be fully described by LNKCAP, but 8.0GT/s is
+     * actually a reference to the highest bit supported in this register.
+     * We assume the device supports all link speeds.
+     */
+    if (s->speed > QEMU_PCI_EXP_LNK_5GT) {
+        pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP2, ~0U);
+        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
+                                   PCI_EXP_LNKCAP2_SLS_2_5GB |
+                                   PCI_EXP_LNKCAP2_SLS_5_0GB |
+                                   PCI_EXP_LNKCAP2_SLS_8_0GB);
+        if (s->speed > QEMU_PCI_EXP_LNK_8GT) {
+            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
+                                       PCI_EXP_LNKCAP2_SLS_16_0GB);
+        }
+    }
+}
+
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
                   uint8_t type, uint8_t port,
                   Error **errp)
@@ -108,6 +179,9 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
     /* Filling values common with v1 */
     pcie_cap_v1_fill(dev, port, type, PCI_EXP_FLAGS_VER2);
 
+    /* Fill link speed and width options */
+    pcie_cap_fill_slot_lnk(dev);
+
     /* Filling v2 specific values */
     pci_set_long(exp_cap + PCI_EXP_DEVCAP2,
                  PCI_EXP_DEVCAP2_EFF | PCI_EXP_DEVCAP2_EETLPP);
-- 
MST
