Received: from eggs.gnu.org ([2001:4830:134:3::10]:43628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gS7on-0002rE-Qt
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gS7oj-0006Ya-39
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:56:24 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1gS7oh-0006VO-4K
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:56:19 -0500
Received: by mail-pl1-x641.google.com with SMTP id u18so5467983plq.7
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 13:56:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 28 Nov 2018 13:56:10 -0800
Message-Id: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] esp-pci: Fix status register write erase
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>

Per AM53C974 datasheet, definition of "SCSI Bus and Control (SBAC)"
register:

Bit 24 – STATUS – Write Erase Control

This bit controls the Write Erase feature on bits 3:1 and bit 6 of the DMA
Status Register ((B)+54h). When this bit is programmed to ‘1’, the state
of bits 3:1 are preserved when read. Bits 3:1 are only cleared when a ‘1’
is written to the corresponding bit location. For example, to clear bit 1,
the value of ‘0000_0010b’ should be written to the register. When the DMA
Status Preserve bit is ‘0’, bits 3:1 are cleared when read.

The status register is currently defined to bit 12, not bit 24.
Also, its implementation is reversed: The status is auto-cleared if
the bit is set to 1, and must be cleared explicitly when the bit is
set to 0. This results in spurious interrupts reported by the Linux
kernel, and in some cases even results in stalled SCSI operations.

Set SBAC_STATUS to bit 24 and reverse the logic to fix the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
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
2.7.4
