Received: from eggs.gnu.org ([2001:4830:134:3::10]:45671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAy-00065L-La
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAt-0006A9-My
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 17 Sep 2017 18:15:44 +0100
Message-Id: <1505668548-16616-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/8] macio: convert pmac_ide_ops from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c |  154 +++++++++++++++++++++-----------------------------------
 1 file changed, 56 insertions(+), 98 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index db5db39..428fbfc 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -255,131 +255,89 @@ static void pmac_ide_flush(DBDMA_io *io)
 }
 
 /* PowerMac IDE memory IO */
-static void pmac_ide_writeb (void *opaque,
-                             hwaddr addr, uint32_t val)
+static uint64_t pmac_ide_read(void *opaque, hwaddr addr, unsigned size)
 {
     MACIOIDEState *d = opaque;
+    uint64_t retval;
+    addr = (addr & 0xfff) >> 4;
 
-    addr = (addr & 0xFFF) >> 4;
     switch (addr) {
-    case 1 ... 7:
-        ide_ioport_write(&d->bus, addr, val);
-        break;
-    case 8:
-    case 22:
-        ide_cmd_write(&d->bus, 0, val);
-        break;
-    default:
+    case 0x0:
+        if (size == 2) {
+            retval = ide_data_readw(&d->bus, 0);
+        } else if (size == 4) {
+            retval = ide_data_readl(&d->bus, 0);
+        } else {
+            retval = 0xffffffff;
+        }
         break;
-    }
-}
-
-static uint32_t pmac_ide_readb (void *opaque,hwaddr addr)
-{
-    uint8_t retval;
-    MACIOIDEState *d = opaque;
-
-    addr = (addr & 0xFFF) >> 4;
-    switch (addr) {
-    case 1 ... 7:
+    case 0x1 ... 0x7:
         retval = ide_ioport_read(&d->bus, addr);
         break;
-    case 8:
-    case 22:
+    case 0x8:
+    case 0x16:
         retval = ide_status_read(&d->bus, 0);
         break;
+    case 0x20:
+        retval = d->timing_reg;
+        break;
+    case 0x30:
+        /* This is an interrupt state register that only exists
+         * in the KeyLargo and later variants. Bit 0x8000_0000
+         * latches the DMA interrupt and has to be written to
+         * clear. Bit 0x4000_0000 is an image of the disk
+         * interrupt. MacOS X relies on this and will hang if
+         * we don't provide at least the disk interrupt
+         */
+        retval = d->irq_reg;
+        break;
     default:
-        retval = 0xFF;
+        retval = 0xffffffff;
         break;
     }
-    return retval;
-}
-
-static void pmac_ide_writew (void *opaque,
-                             hwaddr addr, uint32_t val)
-{
-    MACIOIDEState *d = opaque;
-
-    addr = (addr & 0xFFF) >> 4;
-    val = bswap16(val);
-    if (addr == 0) {
-        ide_data_writew(&d->bus, 0, val);
-    }
-}
 
-static uint32_t pmac_ide_readw (void *opaque,hwaddr addr)
-{
-    uint16_t retval;
-    MACIOIDEState *d = opaque;
-
-    addr = (addr & 0xFFF) >> 4;
-    if (addr == 0) {
-        retval = ide_data_readw(&d->bus, 0);
-    } else {
-        retval = 0xFFFF;
-    }
-    retval = bswap16(retval);
     return retval;
 }
 
-static void pmac_ide_writel (void *opaque,
-                             hwaddr addr, uint32_t val)
+
+static void pmac_ide_write(void *opaque, hwaddr addr, uint64_t val,
+                           unsigned size)
 {
     MACIOIDEState *d = opaque;
+    addr = (addr & 0xfff) >> 4;
 
-    addr = (addr & 0xFFF) >> 4;
-    val = bswap32(val);
-    if (addr == 0) {
-        ide_data_writel(&d->bus, 0, val);
-    } else if (addr == 0x20) {
+    switch (addr) {
+    case 0x0:
+        if (size == 2) {
+            ide_data_writew(&d->bus, 0, val);
+        } else if (size == 4) {
+            ide_data_writel(&d->bus, 0, val);
+        }
+        break;
+    case 0x1 ... 0x7:
+        ide_ioport_write(&d->bus, addr, val);
+        break;
+    case 0x8:
+    case 0x16:
+        ide_cmd_write(&d->bus, 0, val);
+        break;
+    case 0x20:
         d->timing_reg = val;
-    } else if (addr == 0x30) {
+        break;
+    case 0x30:
         if (val & 0x80000000u) {
             d->irq_reg &= 0x7fffffff;
         }
+        break;
     }
 }
 
-static uint32_t pmac_ide_readl (void *opaque,hwaddr addr)
-{
-    uint32_t retval;
-    MACIOIDEState *d = opaque;
-
-    addr = (addr & 0xFFF) >> 4;
-    if (addr == 0) {
-        retval = ide_data_readl(&d->bus, 0);
-    } else if (addr == 0x20) {
-        retval = d->timing_reg;
-    } else if (addr == 0x30) {
-        /* This is an interrupt state register that only exists
-         * in the KeyLargo and later variants. Bit 0x8000_0000
-         * latches the DMA interrupt and has to be written to
-         * clear. Bit 0x4000_0000 is an image of the disk
-         * interrupt. MacOS X relies on this and will hang if
-         * we don't provide at least the disk interrupt
-         */
-        retval = d->irq_reg;
-    } else {
-        retval = 0xFFFFFFFF;
-    }
-    retval = bswap32(retval);
-    return retval;
-}
-
 static const MemoryRegionOps pmac_ide_ops = {
-    .old_mmio = {
-        .write = {
-            pmac_ide_writeb,
-            pmac_ide_writew,
-            pmac_ide_writel,
-        },
-        .read = {
-            pmac_ide_readb,
-            pmac_ide_readw,
-            pmac_ide_readl,
-        },
-    },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .read = pmac_ide_read,
+    .write = pmac_ide_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_pmac = {
-- 
1.7.10.4
