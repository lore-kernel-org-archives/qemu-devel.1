Received: from eggs.gnu.org ([2001:4830:134:3::10]:52293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MZ-0000qc-Oe
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MY-0000Fu-7b
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:36633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MX-0008WP-RA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:50 -0500
Received: by mail-wm1-x32f.google.com with SMTP id a18so6413088wmj.1
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:37 +0100
Message-Id: <1544628195-37728-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/54] esp-pci: Fix status register write erase
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>

From: Guenter Roeck <linux@roeck-us.net>

Per AM53C974 datasheet, definition of "SCSI Bus and Control (SBAC)"
register:

Bit 24 'STATUS' Write Erase Control

This bit controls the Write Erase feature on bits 3:1 and bit 6 of the DMA
Status Register ((B)+54h). When this bit is programmed to '1', the state
of bits 3:1 are preserved when read. Bits 3:1 are only cleared when a '1'
is written to the corresponding bit location. For example, to clear bit 1,
the value of '0000_0010b' should be written to the register. When the DMA
Status Preserve bit is '0', bits 3:1 are cleared when read.

The status register is currently defined to bit 12, not bit 24.
Also, its implementation is reversed: The status is auto-cleared if
the bit is set to 1, and must be cleared explicitly when the bit is
set to 0. This results in spurious interrupts reported by the Linux
kernel, and in some cases even results in stalled SCSI operations.

Set SBAC_STATUS to bit 24 and reverse the logic to fix the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-Id: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/esp-pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 419fc66..d956909 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -59,7 +59,7 @@
 #define DMA_STAT_SCSIINT 0x10
 #define DMA_STAT_BCMBLT  0x20
 
-#define SBAC_STATUS 0x1000
+#define SBAC_STATUS (1 << 24)
 
 typedef struct PCIESPState {
     /*< private >*/
@@ -136,7 +136,7 @@ static void esp_pci_dma_write(PCIESPState *pci, uint32_t saddr, uint32_t val)
         pci->dma_regs[saddr] = val;
         break;
     case DMA_STAT:
-        if (!(pci->sbac & SBAC_STATUS)) {
+        if (pci->sbac & SBAC_STATUS) {
             /* clear some bits on write */
             uint32_t mask = DMA_STAT_ERROR | DMA_STAT_ABORT | DMA_STAT_DONE;
             pci->dma_regs[DMA_STAT] &= ~(val & mask);
@@ -157,7 +157,7 @@ static uint32_t esp_pci_dma_read(PCIESPState *pci, uint32_t saddr)
         if (pci->esp.rregs[ESP_RSTAT] & STAT_INT) {
             val |= DMA_STAT_SCSIINT;
         }
-        if (pci->sbac & SBAC_STATUS) {
+        if (!(pci->sbac & SBAC_STATUS)) {
             pci->dma_regs[DMA_STAT] &= ~(DMA_STAT_ERROR | DMA_STAT_ABORT |
                                          DMA_STAT_DONE);
         }
-- 
1.8.3.1
