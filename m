Received: from eggs.gnu.org ([2001:4830:134:3::10]:42237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJfXX-0006ih-95
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJfXW-0001e8-Ei
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:51 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33305
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dJfXW-0001cp-6b
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:50 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 10 Jun 2017 13:30:20 +0100
Message-Id: <1497097821-32754-6-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 5/6] fw_cfg: use sysbus_init_mmio() in
 fw_cfg_io_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

This brings the function in line with fw_cfg_mem_realize(), deferring the
actual mapping until outside of the realize function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 87b4392..4159316 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -941,6 +941,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as)
 {
     DeviceState *dev;
+    SysBusDevice *sbd;
     FWCfgState *s;
     bool dma_requested = dma_iobase && dma_as;
 
@@ -953,12 +954,16 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
 
     qdev_init_nofail(dev);
 
+    sbd = SYS_BUS_DEVICE(dev);
+    sysbus_add_io(sbd, iobase, sysbus_mmio_get_region(sbd, 0));
+
     s = FW_CFG(dev);
 
     if (s->dma_enabled) {
         /* 64 bits for the address field */
         s->dma_as = dma_as;
         s->dma_addr = 0;
+        sysbus_add_io(sbd, dma_iobase, sysbus_mmio_get_region(sbd, 1));
     }
 
     return s;
@@ -1090,13 +1095,13 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
      * of the i/o region used is FW_CFG_CTL_SIZE */
     memory_region_init_io(&s->comb_iomem, OBJECT(s), &fw_cfg_comb_mem_ops,
                           FW_CFG(s), "fwcfg", FW_CFG_CTL_SIZE);
-    sysbus_add_io(sbd, s->iobase, &s->comb_iomem);
+    sysbus_init_mmio(sbd, &s->comb_iomem);
 
     if (FW_CFG(s)->dma_enabled) {
         memory_region_init_io(&FW_CFG(s)->dma_iomem, OBJECT(s),
                               &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
                               sizeof(dma_addr_t));
-        sysbus_add_io(sbd, s->dma_iobase, &FW_CFG(s)->dma_iomem);
+        sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
     }
 }
 
-- 
1.7.10.4
