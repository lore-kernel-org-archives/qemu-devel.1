Received: from eggs.gnu.org ([2001:4830:134:3::10]:52921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKWm8-00023t-DF
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 17:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKWm7-0007oV-LE
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 17:21:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40073
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dKWm7-0007np-DE
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 17:21:27 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 12 Jun 2017 22:21:07 +0100
Message-Id: <1497302470-10776-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 1/4] fw_cfg: don't map the fw_cfg IO ports in
 fw_cfg_io_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, imammedo@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

As indicated by Laszlo it is a QOM bug for the realize() method to actually
map the device. Set up the IO regions with sysbus_init_mmio() and defer
the mapping to the caller, as already done in fw_cfg_init_mem_wide().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 316fca9..be5b04e 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -936,6 +936,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as)
 {
     DeviceState *dev;
+    SysBusDevice *sbd;
     FWCfgState *s;
     uint32_t version = FW_CFG_VERSION;
     bool dma_requested = dma_iobase && dma_as;
@@ -948,12 +949,17 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     }
 
     fw_cfg_init1(dev);
+
+    sbd = SYS_BUS_DEVICE(dev);
+    sysbus_add_io(sbd, iobase, sysbus_mmio_get_region(sbd, 0));
+
     s = FW_CFG(dev);
 
     if (s->dma_enabled) {
         /* 64 bits for the address field */
         s->dma_as = dma_as;
         s->dma_addr = 0;
+        sysbus_add_io(sbd, dma_iobase, sysbus_mmio_get_region(sbd, 1));
 
         version |= FW_CFG_VERSION_DMA;
     }
@@ -1085,13 +1091,13 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
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
