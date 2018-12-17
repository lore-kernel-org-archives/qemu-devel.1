Received: from eggs.gnu.org ([2001:4830:134:3::10]:43265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28r-0000Wl-Mh
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28q-0003mh-O7
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28q-0003lo-E6
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:40 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:41 +0100
Message-Id: <20181217231700.24482-17-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/35] esp-pci: Fix status register write erase
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

This bit controls the Write Erase feature on bits 3:1 and bit 6 of the DM=
A
Status Register ((B)+54h). When this bit is programmed to '1', the state
of bits 3:1 are preserved when read. Bits 3:1 are only cleared when a '1'
is written to the corresponding bit location. For example, to clear bit 1=
,
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
index 419fc668ac..d956909186 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -59,7 +59,7 @@
 #define DMA_STAT_SCSIINT 0x10
 #define DMA_STAT_BCMBLT  0x20
=20
-#define SBAC_STATUS 0x1000
+#define SBAC_STATUS (1 << 24)
=20
 typedef struct PCIESPState {
     /*< private >*/
@@ -136,7 +136,7 @@ static void esp_pci_dma_write(PCIESPState *pci, uint3=
2_t saddr, uint32_t val)
         pci->dma_regs[saddr] =3D val;
         break;
     case DMA_STAT:
-        if (!(pci->sbac & SBAC_STATUS)) {
+        if (pci->sbac & SBAC_STATUS) {
             /* clear some bits on write */
             uint32_t mask =3D DMA_STAT_ERROR | DMA_STAT_ABORT | DMA_STAT=
_DONE;
             pci->dma_regs[DMA_STAT] &=3D ~(val & mask);
@@ -157,7 +157,7 @@ static uint32_t esp_pci_dma_read(PCIESPState *pci, ui=
nt32_t saddr)
         if (pci->esp.rregs[ESP_RSTAT] & STAT_INT) {
             val |=3D DMA_STAT_SCSIINT;
         }
-        if (pci->sbac & SBAC_STATUS) {
+        if (!(pci->sbac & SBAC_STATUS)) {
             pci->dma_regs[DMA_STAT] &=3D ~(DMA_STAT_ERROR | DMA_STAT_ABO=
RT |
                                          DMA_STAT_DONE);
         }
--=20
2.20.1
