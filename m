Received: from eggs.gnu.org ([2001:4830:134:3::10]:38286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAw-0007aN-LN
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAu-0000tv-IU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:54 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:45170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAu-0000so-As
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:52 -0400
Received: by mail-wr0-x22e.google.com with SMTP id u7-v6so6680497wrn.12
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:48 +0200
Message-Id: <1530216310-52873-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 38/60] hw/mips/jazz: create ESP device directly
 via qdev
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

MIPS jazz is the last user of the legacy esp_init() function so move creation
of the ESP device over to use qdev.

Note that the esp_reset and dma_enable qemu_irqs are currently unused and so
we do not wire these up and instead remove the variables to prevent the
compiler emitting unused variable warnings.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20180613094727.11326-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/mips/mips_jazz.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 90cb306..1afbe3c 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -145,10 +145,10 @@ static void mips_jazz_init(MachineState *machine,
     ISABus *isa_bus;
     ISADevice *pit;
     DriveInfo *fds[MAX_FD];
-    qemu_irq esp_reset, dma_enable;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     MemoryRegion *bios2 = g_new(MemoryRegion, 1);
+    SysBusESPState *sysbus_esp;
     ESPState *esp;
 
     /* init CPUs */
@@ -281,8 +281,21 @@ static void mips_jazz_init(MachineState *machine,
     }
 
     /* SCSI adapter */
-    esp = esp_init(0x80002000, 0, rc4030_dma_read, rc4030_dma_write, dmas[0],
-                   qdev_get_gpio_in(rc4030, 5), &esp_reset, &dma_enable);
+    dev = qdev_create(NULL, TYPE_ESP);
+    sysbus_esp = ESP_STATE(dev);
+    esp = &sysbus_esp->esp;
+    esp->dma_memory_read = rc4030_dma_read;
+    esp->dma_memory_write = rc4030_dma_write;
+    esp->dma_opaque = dmas[0];
+    sysbus_esp->it_shift = 0;
+    /* XXX for now until rc4030 has been changed to use DMA enable signal */
+    esp->dma_enabled = 1;
+    qdev_init_nofail(dev);
+
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 5));
+    sysbus_mmio_map(sysbus, 0, 0x80002000);
+
     scsi_bus_legacy_handle_cmdline(&esp->bus);
 
     /* Floppy */
-- 
1.8.3.1
