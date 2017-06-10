Received: from eggs.gnu.org ([2001:4830:134:3::10]:42248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJfXX-0006ii-Pw
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJfXW-0001eJ-RX
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:51 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33310
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dJfXW-0001cs-Ke
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:50 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 10 Jun 2017 13:30:18 +0100
Message-Id: <1497097821-32754-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/6] fw_cfg: move setting of FW_CFG_ID into
 fw_cfg_init1()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

The dma_enabled property enables us to set the FW_CFG_ID version
accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 1313bfd..f7b78a9 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -914,12 +914,19 @@ static void fw_cfg_init1(DeviceState *dev)
 {
     FWCfgState *s = FW_CFG(dev);
     MachineState *machine = MACHINE(qdev_get_machine());
+    uint32_t version = FW_CFG_VERSION;
 
     assert(!object_resolve_path(FW_CFG_PATH, NULL));
 
     object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
 
     fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
+
+    if (s->dma_enabled) {
+        version |= FW_CFG_VERSION_DMA;
+    }
+
+    fw_cfg_add_i32(s, FW_CFG_ID, version);
     fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
     fw_cfg_add_i16(s, FW_CFG_NOGRAPHIC, (uint16_t)!machine->enable_graphics);
     fw_cfg_add_i16(s, FW_CFG_BOOT_MENU, (uint16_t)boot_menu);
@@ -935,7 +942,6 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
 {
     DeviceState *dev;
     FWCfgState *s;
-    uint32_t version = FW_CFG_VERSION;
     bool dma_requested = dma_iobase && dma_as;
 
     dev = qdev_create(NULL, TYPE_FW_CFG_IO);
@@ -954,12 +960,8 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
         /* 64 bits for the address field */
         s->dma_as = dma_as;
         s->dma_addr = 0;
-
-        version |= FW_CFG_VERSION_DMA;
     }
 
-    fw_cfg_add_i32(s, FW_CFG_ID, version);
-
     return s;
 }
 
@@ -975,7 +977,6 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
     DeviceState *dev;
     SysBusDevice *sbd;
     FWCfgState *s;
-    uint32_t version = FW_CFG_VERSION;
     bool dma_requested = dma_addr && dma_as;
 
     dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
@@ -997,11 +998,8 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
         s->dma_as = dma_as;
         s->dma_addr = 0;
         sysbus_mmio_map(sbd, 2, dma_addr);
-        version |= FW_CFG_VERSION_DMA;
     }
 
-    fw_cfg_add_i32(s, FW_CFG_ID, version);
-
     return s;
 }
 
-- 
1.7.10.4
