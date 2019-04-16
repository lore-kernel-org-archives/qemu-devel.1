Received: from eggs.gnu.org ([209.51.188.92]:44088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4W-0006XX-1i
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4V-0007qx-1d
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:40 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 15 Apr 2019 18:39:02 -0700
Message-Id: <20190416013902.4941-6-andrew.smirnov@gmail.com>
In-Reply-To: <20190416013902.4941-1-andrew.smirnov@gmail.com>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/5] i.mx7d: pci: Update PCI IRQ mapping to
 match HW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

Datasheet for i.MX7 is incorrect and i.MX7's PCI IRQ mapping matches
that of i.MX6:

    * INTD/MSI    122
    * INTC        123
    * INTB        124
    * INTA        125

Fix all of the relevant code to reflect that fact. Needed by latest
Linux kernels.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 include/hw/arm/fsl-imx7.h | 8 ++++----
 hw/pci-host/designware.c  | 6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 3efa697adc..9750003a4f 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -213,10 +213,10 @@ enum FslIMX7IRQs {
     FSL_IMX7_USB2_IRQ     = 42,
     FSL_IMX7_USB3_IRQ     = 40,
 
-    FSL_IMX7_PCI_INTA_IRQ = 122,
-    FSL_IMX7_PCI_INTB_IRQ = 123,
-    FSL_IMX7_PCI_INTC_IRQ = 124,
-    FSL_IMX7_PCI_INTD_IRQ = 125,
+    FSL_IMX7_PCI_INTA_IRQ = 125,
+    FSL_IMX7_PCI_INTB_IRQ = 124,
+    FSL_IMX7_PCI_INTC_IRQ = 123,
+    FSL_IMX7_PCI_INTD_IRQ = 122,
 
     FSL_IMX7_UART7_IRQ    = 126,
 
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index e80facc4a0..f4c58b25c1 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -50,6 +50,8 @@
 #define DESIGNWARE_PCIE_ATU_DEVFN(x)               (((x) >> 16) & 0xff)
 #define DESIGNWARE_PCIE_ATU_UPPER_TARGET           0x91C
 
+#define DESIGNWARE_PCIE_IRQ_MSI                    3
+
 static DesignwarePCIEHost *
 designware_pcie_root_to_host(DesignwarePCIERoot *root)
 {
@@ -66,7 +68,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
     root->msi.intr[0].status |= BIT(val) & root->msi.intr[0].enable;
 
     if (root->msi.intr[0].status & ~root->msi.intr[0].mask) {
-        qemu_set_irq(host->pci.irqs[0], 1);
+        qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 1);
     }
 }
 
@@ -310,7 +312,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     case DESIGNWARE_PCIE_MSI_INTR0_STATUS:
         root->msi.intr[0].status ^= val;
         if (!root->msi.intr[0].status) {
-            qemu_set_irq(host->pci.irqs[0], 0);
+            qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 0);
         }
         break;
 
-- 
2.20.1
