Received: from eggs.gnu.org ([2001:4830:134:3::10]:56311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36J-0001JR-Dx
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36H-0005MM-Br
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:47 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35125
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV36H-0005Lr-3z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:45 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 22:53:21 +0100
Message-Id: <1499810007-28613-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/8] sun4u: switch to using qdev to instantiate
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
index 7738856..8932be9 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -512,7 +512,15 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                            graphic_width, graphic_height, graphic_depth,
                            (uint8_t *)&nd_table[0].macaddr);
 
-    fw_cfg = fw_cfg_init_io(BIOS_CFG_IOPORT);
+    dev = qdev_create(NULL, TYPE_FW_CFG_IO);
+    qdev_prop_set_bit(dev, "dma_enabled", false);
+    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
+                              OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
+    memory_region_add_subregion(get_system_io(), BIOS_CFG_IOPORT,
+                                &FW_CFG_IO(dev)->comb_iomem);
+
+    fw_cfg = FW_CFG(dev);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
-- 
1.7.10.4
