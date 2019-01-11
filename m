Received: from eggs.gnu.org ([209.51.188.92]:38028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghlYr-0006R2-Sl
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghlYq-0000tB-2i
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:37 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:50519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ghlYo-0000lF-Bb
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:35 -0500
Message-Id: <793b6a7934ef2bba26b8d066bec446019efa6c5d.1547166960.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1547166960.git.balaton@eik.bme.hu>
References: <cover.1547166960.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 11 Jan 2019 01:36:00 +0100
Subject: [Qemu-devel] [PATCH 5/5] sii3112: Remove duplicated code and use
 PCI IDE ops instead
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

Parts of the SiI3112 mmio are identical to PCI IDE registers so we can
use the corresponding functions that were factored out into ide/pci.c.
This removes code duplication and simplifies the SiI3112 model which
also helped to spot a copy paste error where reading status of the
2nd channel read the 1st channel instead. This is also fixed here.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ide/sii3112.c | 52 ++++++++--------------------------------------------
 1 file changed, 8 insertions(+), 44 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 743a50ed51..59db09cfe4 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -88,35 +88,19 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr addr,
         val |= (uint32_t)d->i.bmdma[1].status << 16;
         break;
     case 0x80 ... 0x87:
-        if (size == 1) {
-            val = ide_ioport_read(&d->i.bus[0], addr - 0x80);
-        } else if (addr == 0x80) {
-            val = (size == 2) ? ide_data_readw(&d->i.bus[0], 0) :
-                                ide_data_readl(&d->i.bus[0], 0);
-        } else {
-            val = (1ULL << (size * 8)) - 1;
-        }
+        val = pci_ide_data_le_ops.read(&d->i.bus[0], addr - 0x80, size);
         break;
     case 0x8a:
-        val = (size == 1) ? ide_status_read(&d->i.bus[0], 4) :
-                            (1ULL << (size * 8)) - 1;
+        val = pci_ide_cmd_le_ops.read(&d->i.bus[0], 2, size);
         break;
     case 0xa0:
         val = d->regs[0].confstat;
         break;
     case 0xc0 ... 0xc7:
-        if (size == 1) {
-            val = ide_ioport_read(&d->i.bus[1], addr - 0xc0);
-        } else if (addr == 0xc0) {
-            val = (size == 2) ? ide_data_readw(&d->i.bus[1], 0) :
-                                ide_data_readl(&d->i.bus[1], 0);
-        } else {
-            val = (1ULL << (size * 8)) - 1;
-        }
+        val = pci_ide_data_le_ops.read(&d->i.bus[1], addr - 0xc0, size);
         break;
     case 0xca:
-        val = (size == 1) ? ide_status_read(&d->i.bus[0], 4) :
-                            (1ULL << (size * 8)) - 1;
+        val = pci_ide_cmd_le_ops.read(&d->i.bus[1], 2, size);
         break;
     case 0xe0:
         val = d->regs[1].confstat;
@@ -186,36 +170,16 @@ static void sii3112_reg_write(void *opaque, hwaddr addr,
         bmdma_addr_ioport_ops.write(&d->i.bmdma[1], addr - 12, val, size);
         break;
     case 0x80 ... 0x87:
-        if (size == 1) {
-            ide_ioport_write(&d->i.bus[0], addr - 0x80, val);
-        } else if (addr == 0x80) {
-            if (size == 2) {
-                ide_data_writew(&d->i.bus[0], 0, val);
-            } else {
-                ide_data_writel(&d->i.bus[0], 0, val);
-            }
-        }
+        pci_ide_data_le_ops.write(&d->i.bus[0], addr - 0x80, val, size);
         break;
     case 0x8a:
-        if (size == 1) {
-            ide_cmd_write(&d->i.bus[0], 4, val);
-        }
+        pci_ide_cmd_le_ops.write(&d->i.bus[0], 2, val, size);
         break;
     case 0xc0 ... 0xc7:
-        if (size == 1) {
-            ide_ioport_write(&d->i.bus[1], addr - 0xc0, val);
-        } else if (addr == 0xc0) {
-            if (size == 2) {
-                ide_data_writew(&d->i.bus[1], 0, val);
-            } else {
-                ide_data_writel(&d->i.bus[1], 0, val);
-            }
-        }
+        pci_ide_data_le_ops.write(&d->i.bus[1], addr - 0xc0, val, size);
         break;
     case 0xca:
-        if (size == 1) {
-            ide_cmd_write(&d->i.bus[1], 4, val);
-        }
+        pci_ide_cmd_le_ops.write(&d->i.bus[1], 2, val, size);
         break;
     case 0x100:
         d->regs[0].scontrol = val & 0xfff;
-- 
2.13.7
