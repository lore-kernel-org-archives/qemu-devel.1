Received: from eggs.gnu.org ([2001:4830:134:3::10]:38285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAw-0007aM-LI
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAv-0000vU-EY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:54 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAv-0000u7-7Y
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:53 -0400
Received: by mail-wr0-x244.google.com with SMTP id p12-v6so6676349wrn.11
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:49 +0200
Message-Id: <1530216310-52873-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 39/60] esp: remove legacy esp_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Remove the legacy esp_init() function now that there are no more remaining
users.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20180613094727.11326-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/scsi/esp.c         | 30 ------------------------------
 include/hw/scsi/esp.h |  5 -----
 2 files changed, 35 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9ed9727..630d923 100644
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
index 93fdace..682a0d2 100644
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
1.8.3.1
