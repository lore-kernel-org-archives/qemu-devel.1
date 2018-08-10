Received: from eggs.gnu.org ([2001:4830:134:3::10]:33782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo69k-0006Ng-VB
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo69g-0003PK-1Y
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:04:36 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 10 Aug 2018 13:04:18 +0100
Message-Id: <20180810120418.6695-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] 40p: don't use legacy fw_cfg_init_mem()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hpoussin@reactos.org, david@gibson.dropbear.id.au

Instead initialise the device via qdev to allow us to set device properties
directly as required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/prep.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 3401570d98..9cf4a2adc3 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -706,7 +706,7 @@ static void ibm_40p_init(MachineState *machine)
     uint16_t cmos_checksum;
     PowerPCCPU *cpu;
     DeviceState *dev;
-    SysBusDevice *pcihost;
+    SysBusDevice *pcihost, *s;
     Nvram *m48t59 = NULL;
     PCIBus *pci_bus;
     ISABus *isa_bus;
@@ -799,7 +799,16 @@ static void ibm_40p_init(MachineState *machine)
     }
 
     /* Prepare firmware configuration for OpenBIOS */
-    fw_cfg = fw_cfg_init_mem(CFG_ADDR, CFG_ADDR + 2);
+    dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
+    fw_cfg = FW_CFG(dev);
+    qdev_prop_set_uint32(dev, "data_width", 1);
+    qdev_prop_set_bit(dev, "dma_enabled", false);
+    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
+                              OBJECT(fw_cfg), NULL);
+    qdev_init_nofail(dev);
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(s, 0, CFG_ADDR);
+    sysbus_mmio_map(s, 1, CFG_ADDR + 2);
 
     if (machine->kernel_filename) {
         /* load kernel */
-- 
2.11.0
