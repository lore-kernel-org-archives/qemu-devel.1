Received: from eggs.gnu.org ([2001:4830:134:3::10]:46397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJg0K-0008JL-M2
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJg0F-0002cQ-R6
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:00:36 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33399
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dJg0F-0002cE-Jw
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:00:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 10 Jun 2017 14:00:14 +0100
Message-Id: <1497099616-2615-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497099616-2615-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497099616-2615-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/3] sun4u: switch to using qdev to instantiate
 fw_cfg interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 69f565d..98ee6f5 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -512,7 +512,15 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                            graphic_width, graphic_height, graphic_depth,
                            (uint8_t *)&nd_table[0].macaddr);
 
-    fw_cfg = fw_cfg_init_io(BIOS_CFG_IOPORT);
+    dev = qdev_create(NULL, TYPE_FW_CFG_IO);
+    qdev_prop_set_uint32(dev, "iobase", BIOS_CFG_IOPORT);
+    qdev_prop_set_bit(dev, "dma_enabled", false);
+    qdev_init_nofail(dev);
+    s = SYS_BUS_DEVICE(dev);
+    memory_region_add_subregion(get_system_io(), BIOS_CFG_IOPORT,
+                                sysbus_mmio_get_region(s, 0));
+
+    fw_cfg = FW_CFG(dev);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
-- 
1.7.10.4
