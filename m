Received: from eggs.gnu.org ([2001:4830:134:3::10]:42172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo4eb-0004LA-F4
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo4ea-0002Pz-AU
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:28:21 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 10 Aug 2018 11:27:57 +0100
Message-Id: <20180810102757.21010-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180810102757.21010-1-mark.cave-ayland@ilande.co.uk>
References: <20180810102757.21010-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/2] mac_newworld: don't use legacy
 fw_cfg_init_mem() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Instead initialise the device via qdev to allow us to set device properties
directly as required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_newworld.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 2ca294664b..a6b95f024c 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -454,7 +454,17 @@ static void ppc_core99_init(MachineState *machine)
     pmac_format_nvram_partition(nvr, 0x2000);
     /* No PCI init: the BIOS will do it */
 
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
+
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
-- 
2.11.0
