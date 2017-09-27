Received: from eggs.gnu.org ([2001:4830:134:3::10]:56711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70R-0001Vi-0c
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70O-00047z-S4
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:06 +1000
Message-Id: <20170927074316.4454-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/26] macio: convert pmac_ide_ops from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ide/macio.c | 181 ++++++++++++++++++++++++---------------------------------
 1 file changed, 75 insertions(+), 106 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index db5db390e7..18ae952934 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -255,131 +255,100 @@ static void pmac_ide_flush(DBDMA_io *io)
 }
 
 /* PowerMac IDE memory IO */
-static void pmac_ide_writeb (void *opaque,
-                             hwaddr addr, uint32_t val)
+static uint64_t pmac_ide_read(void *opaque, hwaddr addr, unsigned size)
 {
     MACIOIDEState *d = opaque;
-
-    addr = (addr & 0xFFF) >> 4;
-    switch (addr) {
-    case 1 ... 7:
-        ide_ioport_write(&d->bus, addr, val);
-        break;
-    case 8:
-    case 22:
-        ide_cmd_write(&d->bus, 0, val);
+    uint64_t retval = 0xffffffff;
+    int reg = addr >> 4;
+
+    switch (reg) {
+    case 0x0:
+        if (size == 2) {
+            retval = ide_data_readw(&d->bus, 0);
+        } else if (size == 4) {
+            retval = ide_data_readl(&d->bus, 0);
+        }
         break;
-    default:
+    case 0x1 ... 0x7:
+        if (size == 1) {
+            retval = ide_ioport_read(&d->bus, reg);
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
-        retval = ide_ioport_read(&d->bus, addr);
+    case 0x8:
+    case 0x16:
+        if (size == 1) {
+            retval = ide_status_read(&d->bus, 0);
+        }
         break;
-    case 8:
-    case 22:
-        retval = ide_status_read(&d->bus, 0);
+    case 0x20:
+        if (size == 4) {
+            retval = d->timing_reg;
+        }
         break;
-    default:
-        retval = 0xFF;
+    case 0x30:
+        /* This is an interrupt state register that only exists
+         * in the KeyLargo and later variants. Bit 0x8000_0000
+         * latches the DMA interrupt and has to be written to
+         * clear. Bit 0x4000_0000 is an image of the disk
+         * interrupt. MacOS X relies on this and will hang if
+         * we don't provide at least the disk interrupt
+         */
+        if (size == 4) {
+            retval = d->irq_reg;
+        }
         break;
     }
-    return retval;
-}
 
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
-
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
-{
-    MACIOIDEState *d = opaque;
 
-    addr = (addr & 0xFFF) >> 4;
-    val = bswap32(val);
-    if (addr == 0) {
-        ide_data_writel(&d->bus, 0, val);
-    } else if (addr == 0x20) {
-        d->timing_reg = val;
-    } else if (addr == 0x30) {
-        if (val & 0x80000000u) {
-            d->irq_reg &= 0x7fffffff;
-        }
-    }
-}
-
-static uint32_t pmac_ide_readl (void *opaque,hwaddr addr)
+static void pmac_ide_write(void *opaque, hwaddr addr, uint64_t val,
+                           unsigned size)
 {
-    uint32_t retval;
     MACIOIDEState *d = opaque;
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
+    int reg = addr >> 4;
+
+    switch (reg) {
+    case 0x0:
+        if (size == 2) {
+            ide_data_writew(&d->bus, 0, val);
+        } else if (size == 4) {
+            ide_data_writel(&d->bus, 0, val);
+        }
+        break;
+    case 0x1 ... 0x7:
+        if (size == 1) {
+            ide_ioport_write(&d->bus, reg, val);
+        }
+        break;
+    case 0x8:
+    case 0x16:
+        if (size == 1) {
+            ide_cmd_write(&d->bus, 0, val);
+        }
+        break;
+    case 0x20:
+        if (size == 4) {
+            d->timing_reg = val;
+        }
+        break;
+    case 0x30:
+        if (size == 4) {
+            if (val & 0x80000000u) {
+                d->irq_reg &= 0x7fffffff;
+            }
+        }
+        break;
     }
-    retval = bswap32(retval);
-    return retval;
 }
 
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
2.13.5
