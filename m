Received: from eggs.gnu.org ([2001:4830:134:3::10]:34144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duYMu-0003LW-Ob
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duYMr-0006Vi-Kf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:20:20 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 20 Sep 2017 07:20:00 +0100
Message-Id: <1505888401-10130-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1505888401-10130-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505888401-10130-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/2] ppc/ide/macio: Add missing registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The timing register exists on all variants of MacIO IDE, we just
store and return its value.

The interrupts register only exists on KeyLargo but it doesn't
hurt to have it. The lack of this register causes MacOS X to
hangs under some circumstances.

Both are 32-bit only. The HW might support smaller access sizes
but no known OS uses them.

Because the core IDE subsystem doesn't provide us with a way
to query the main (level) interrupt state, nor do we have a way
to know that DBDMA issued a (edge) interrupt, we reflect both
through a private pair of qirq's in order to maintain the
register state.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 hw/ide/macio.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 hw/ppc/mac.h   |    6 +++++-
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 9742c00..db5db39 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -331,6 +331,12 @@ static void pmac_ide_writel (void *opaque,
     val = bswap32(val);
     if (addr == 0) {
         ide_data_writel(&d->bus, 0, val);
+    } else if (addr == 0x20) {
+        d->timing_reg = val;
+    } else if (addr == 0x30) {
+        if (val & 0x80000000u) {
+            d->irq_reg &= 0x7fffffff;
+        }
     }
 }
 
@@ -342,6 +348,17 @@ static uint32_t pmac_ide_readl (void *opaque,hwaddr addr)
     addr = (addr & 0xFFF) >> 4;
     if (addr == 0) {
         retval = ide_data_readl(&d->bus, 0);
+    } else if (addr == 0x20) {
+        retval = d->timing_reg;
+    } else if (addr == 0x30) {
+        /* This is an interrupt state register that only exists
+         * in the KeyLargo and later variants. Bit 0x8000_0000
+         * latches the DMA interrupt and has to be written to
+         * clear. Bit 0x4000_0000 is an image of the disk
+         * interrupt. MacOS X relies on this and will hang if
+         * we don't provide at least the disk interrupt
+         */
+        retval = d->irq_reg;
     } else {
         retval = 0xFFFFFFFF;
     }
@@ -426,13 +443,32 @@ static void macio_ide_realizefn(DeviceState *dev, Error **errp)
 {
     MACIOIDEState *s = MACIO_IDE(dev);
 
-    ide_init2(&s->bus, s->irq);
+    ide_init2(&s->bus, s->ide_irq);
 
     /* Register DMA callbacks */
     s->dma.ops = &dbdma_ops;
     s->bus.dma = &s->dma;
 }
 
+static void pmac_ide_irq(void *opaque, int n, int level)
+{
+    MACIOIDEState *s = opaque;
+    uint32_t mask = 0x80000000u >> n;
+
+    /* We need to reflect the IRQ state in the irq register */
+    if (level) {
+        s->irq_reg |= mask;
+    } else {
+        s->irq_reg &= ~mask;
+    }
+
+    if (n) {
+        qemu_set_irq(s->real_ide_irq, level);
+    } else {
+        qemu_set_irq(s->real_dma_irq, level);
+    }
+}
+
 static void macio_ide_initfn(Object *obj)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(obj);
@@ -441,8 +477,10 @@ static void macio_ide_initfn(Object *obj)
     ide_bus_new(&s->bus, sizeof(s->bus), DEVICE(obj), 0, 2);
     memory_region_init_io(&s->mem, obj, &pmac_ide_ops, s, "pmac-ide", 0x1000);
     sysbus_init_mmio(d, &s->mem);
-    sysbus_init_irq(d, &s->irq);
-    sysbus_init_irq(d, &s->dma_irq);
+    sysbus_init_irq(d, &s->real_ide_irq);
+    sysbus_init_irq(d, &s->real_dma_irq);
+    s->dma_irq = qemu_allocate_irq(pmac_ide_irq, s, 0);
+    s->ide_irq = qemu_allocate_irq(pmac_ide_irq, s, 1);
 }
 
 static void macio_ide_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 20cbddb..300fc8a 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -132,7 +132,9 @@ typedef struct MACIOIDEState {
     SysBusDevice parent_obj;
     /*< public >*/
 
-    qemu_irq irq;
+    qemu_irq real_ide_irq;
+    qemu_irq real_dma_irq;
+    qemu_irq ide_irq;
     qemu_irq dma_irq;
 
     MemoryRegion mem;
@@ -140,6 +142,8 @@ typedef struct MACIOIDEState {
     IDEDMA dma;
     void *dbdma;
     bool dma_active;
+    uint32_t timing_reg;
+    uint32_t irq_reg;
 } MACIOIDEState;
 
 void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
-- 
1.7.10.4
