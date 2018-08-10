Received: from eggs.gnu.org ([2001:4830:134:3::10]:56291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo5pO-0006FA-Jj
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo5pL-0000VX-HJ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:43:34 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45455
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fo5pL-0000Ud-A1
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:43:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 10 Aug 2018 12:43:20 +0100
Message-Id: <20180810114320.4091-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] sun4m: don't use legacy fw_cfg_init_mem()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Instead initialise the device via qdev to allow us to set device properties
directly as required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc/sun4m.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d981de1841..3c29b68e67 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1035,7 +1035,17 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         ecc_init(hwdef->ecc_base, slavio_irq[28],
                  hwdef->ecc_version);
 
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
