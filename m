Received: from eggs.gnu.org ([2001:4830:134:3::10]:39860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fT2NS-0007mu-5U
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fT2NP-0006cg-Te
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:47:42 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60048
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fT2NP-0006bL-MG
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:47:39 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 13 Jun 2018 10:47:27 +0100
Message-Id: <20180613094727.11326-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180613094727.11326-1-mark.cave-ayland@ilande.co.uk>
References: <20180613094727.11326-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/2] esp: remove legacy esp_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, hpoussin@reactos.org, pbonzini@redhat.com, famz@redhat.com

Remove the legacy esp_init() function now that there are no more remaining
users.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 30 ------------------------------
 include/hw/scsi/esp.h |  5 -----
 2 files changed, 35 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9ed9727744..630d923623 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -619,36 +619,6 @@ static const MemoryRegionOps sysbus_esp_mem_ops = {
     .valid.accepts = esp_mem_accepts,
 };
 
-ESPState *esp_init(hwaddr espaddr, int it_shift,
-                   ESPDMAMemoryReadWriteFunc dma_memory_read,
-                   ESPDMAMemoryReadWriteFunc dma_memory_write,
-                   void *dma_opaque, qemu_irq irq, qemu_irq *reset,
-                   qemu_irq *dma_enable)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-    SysBusESPState *sysbus;
-    ESPState *esp;
-
-    dev = qdev_create(NULL, TYPE_ESP);
-    sysbus = ESP_STATE(dev);
-    esp = &sysbus->esp;
-    esp->dma_memory_read = dma_memory_read;
-    esp->dma_memory_write = dma_memory_write;
-    esp->dma_opaque = dma_opaque;
-    sysbus->it_shift = it_shift;
-    /* XXX for now until rc4030 has been changed to use DMA enable signal */
-    esp->dma_enabled = 1;
-    qdev_init_nofail(dev);
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_connect_irq(s, 0, irq);
-    sysbus_mmio_map(s, 0, espaddr);
-    *reset = qdev_get_gpio_in(dev, 0);
-    *dma_enable = qdev_get_gpio_in(dev, 1);
-
-    return esp;
-}
-
 static const struct SCSIBusInfo esp_scsi_info = {
     .tcq = false,
     .max_target = ESP_MAX_DEVS,
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 93fdaced67..682a0d2de0 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -131,11 +131,6 @@ typedef struct {
 #define TCHI_FAS100A 0x4
 #define TCHI_AM53C974 0x12
 
-ESPState *esp_init(hwaddr espaddr, int it_shift,
-                   ESPDMAMemoryReadWriteFunc dma_memory_read,
-                   ESPDMAMemoryReadWriteFunc dma_memory_write,
-                   void *dma_opaque, qemu_irq irq, qemu_irq *reset,
-                   qemu_irq *dma_enable);
 void esp_dma_enable(ESPState *s, int irq, int level);
 void esp_request_cancelled(SCSIRequest *req);
 void esp_command_complete(SCSIRequest *req, uint32_t status, size_t resid);
-- 
2.11.0
