Received: from eggs.gnu.org ([2001:4830:134:3::10]:33531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabf-0001FY-0k
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabb-000209-B0
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:46 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  3 Jan 2018 15:24:18 +1100
Message-Id: <20180103042419.14520-15-david@gibson.dropbear.id.au>
In-Reply-To: <20180103042419.14520-1-david@gibson.dropbear.id.au>
References: <20180103042419.14520-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/15] hw/ide: Emulate SiI3112 SATA controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

This is a common generic PCI SATA controller that is also used in PCs
but more importantly guests running on the Sam460ex board prefer this
card and have a driver for it (unlike for other SATA controllers
already emulated).

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS                        |   6 +
 default-configs/ppcemb-softmmu.mak |   1 +
 hw/ide/Makefile.objs               |   1 +
 hw/ide/sii3112.c                   | 368 +++++++++++++++++++++++++++++++++++++
 hw/ide/trace-events                |   5 +
 5 files changed, 381 insertions(+)
 create mode 100644 hw/ide/sii3112.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 73a5555735..40cd7ee841 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -765,6 +765,12 @@ L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/virtex_ml507.c
 
+sam460ex
+M: BALATON Zoltan <balaton@eik.bme.hu>
+L: qemu-ppc@nongnu.org
+S: Maintained
+F: hw/ide/sii3112.c
+
 SH4 Machines
 ------------
 R2D
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
index 13917fb7a3..5db4618a5a 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -16,3 +16,4 @@ CONFIG_I8259=y
 CONFIG_XILINX=y
 CONFIG_XILINX_ETHLITE=y
 CONFIG_SM501=y
+CONFIG_IDE_SII3112=y
diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
index f0edca3300..fc328ffbe8 100644
--- a/hw/ide/Makefile.objs
+++ b/hw/ide/Makefile.objs
@@ -11,3 +11,4 @@ common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
 common-obj-$(CONFIG_AHCI) += ahci.o
 common-obj-$(CONFIG_AHCI) += ich.o
 common-obj-$(CONFIG_ALLWINNER_A10) += ahci-allwinner.o
+common-obj-$(CONFIG_IDE_SII3112) += sii3112.o
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
new file mode 100644
index 0000000000..e2f5562bb7
--- /dev/null
+++ b/hw/ide/sii3112.c
@@ -0,0 +1,368 @@
+/*
+ * QEMU SiI3112A PCI to Serial ATA Controller Emulation
+ *
+ * Copyright (C) 2017 BALATON Zoltan <balaton@eik.bme.hu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+/* For documentation on this and similar cards see:
+ * http://wiki.osdev.org/User:Quok/Silicon_Image_Datasheets
+ */
+
+#include <qemu/osdep.h>
+#include <hw/ide/pci.h>
+#include "trace.h"
+
+#define TYPE_SII3112_PCI "sii3112"
+#define SII3112_PCI(obj) OBJECT_CHECK(SiI3112PCIState, (obj), \
+                         TYPE_SII3112_PCI)
+
+typedef struct SiI3112Regs {
+    uint32_t confstat;
+    uint32_t scontrol;
+    uint16_t sien;
+    uint8_t swdata;
+} SiI3112Regs;
+
+typedef struct SiI3112PCIState {
+    PCIIDEState i;
+    MemoryRegion mmio;
+    SiI3112Regs regs[2];
+} SiI3112PCIState;
+
+/* The sii3112_reg_read and sii3112_reg_write functions implement the
+ * Internal Register Space - BAR5 (section 6.7 of the data sheet).
+ */
+
+static uint64_t sii3112_reg_read(void *opaque, hwaddr addr,
+                                unsigned int size)
+{
+    SiI3112PCIState *d = opaque;
+    uint64_t val = 0;
+
+    switch (addr) {
+    case 0x00:
+        val = d->i.bmdma[0].cmd;
+        break;
+    case 0x01:
+        val = d->regs[0].swdata;
+        break;
+    case 0x02:
+        val = d->i.bmdma[0].status;
+        break;
+    case 0x03:
+        val = 0;
+        break;
+    case 0x04 ... 0x07:
+        val = bmdma_addr_ioport_ops.read(&d->i.bmdma[0], addr - 4, size);
+        break;
+    case 0x08:
+        val = d->i.bmdma[1].cmd;
+        break;
+    case 0x09:
+        val = d->regs[1].swdata;
+        break;
+    case 0x0a:
+        val = d->i.bmdma[1].status;
+        break;
+    case 0x0b:
+        val = 0;
+        break;
+    case 0x0c ... 0x0f:
+        val = bmdma_addr_ioport_ops.read(&d->i.bmdma[1], addr - 12, size);
+        break;
+    case 0x10:
+        val = d->i.bmdma[0].cmd;
+        val |= (d->regs[0].confstat & (1UL << 11) ? (1 << 4) : 0); /*SATAINT0*/
+        val |= (d->regs[1].confstat & (1UL << 11) ? (1 << 6) : 0); /*SATAINT1*/
+        val |= (d->i.bmdma[1].status & BM_STATUS_INT ? (1 << 14) : 0);
+        val |= d->i.bmdma[0].status << 16;
+        val |= d->i.bmdma[1].status << 24;
+        break;
+    case 0x18:
+        val = d->i.bmdma[1].cmd;
+        val |= (d->regs[1].confstat & (1UL << 11) ? (1 << 4) : 0);
+        val |= d->i.bmdma[1].status << 16;
+        break;
+    case 0x80 ... 0x87:
+        if (size == 1) {
+            val = ide_ioport_read(&d->i.bus[0], addr - 0x80);
+        } else if (addr == 0x80) {
+            val = (size == 2) ? ide_data_readw(&d->i.bus[0], 0) :
+                                ide_data_readl(&d->i.bus[0], 0);
+        } else {
+            val = (1ULL << (size * 8)) - 1;
+        }
+        break;
+    case 0x8a:
+        val = (size == 1) ? ide_status_read(&d->i.bus[0], 4) :
+                            (1ULL << (size * 8)) - 1;
+        break;
+    case 0xa0:
+        val = d->regs[0].confstat;
+        break;
+    case 0xc0 ... 0xc7:
+        if (size == 1) {
+            val = ide_ioport_read(&d->i.bus[1], addr - 0xc0);
+        } else if (addr == 0xc0) {
+            val = (size == 2) ? ide_data_readw(&d->i.bus[1], 0) :
+                                ide_data_readl(&d->i.bus[1], 0);
+        } else {
+            val = (1ULL << (size * 8)) - 1;
+        }
+        break;
+    case 0xca:
+        val = (size == 1) ? ide_status_read(&d->i.bus[0], 4) :
+                            (1ULL << (size * 8)) - 1;
+        break;
+    case 0xe0:
+        val = d->regs[1].confstat;
+        break;
+    case 0x100:
+        val = d->regs[0].scontrol;
+        break;
+    case 0x104:
+        val = (d->i.bus[0].ifs[0].blk) ? 0x113 : 0;
+        break;
+    case 0x148:
+        val = d->regs[0].sien << 16;
+        break;
+    case 0x180:
+        val = d->regs[1].scontrol;
+        break;
+    case 0x184:
+        val = (d->i.bus[1].ifs[0].blk) ? 0x113 : 0;
+        break;
+    case 0x1c8:
+        val = d->regs[1].sien << 16;
+        break;
+    default:
+        val = 0;
+    }
+    trace_sii3112_read(size, addr, val);
+    return val;
+}
+
+static void sii3112_reg_write(void *opaque, hwaddr addr,
+                              uint64_t val, unsigned int size)
+{
+    SiI3112PCIState *d = opaque;
+
+    trace_sii3112_write(size, addr, val);
+    switch (addr) {
+    case 0x00:
+    case 0x10:
+        bmdma_cmd_writeb(&d->i.bmdma[0], val);
+        break;
+    case 0x01:
+    case 0x11:
+        d->regs[0].swdata = val & 0x3f;
+        break;
+    case 0x02:
+    case 0x12:
+        d->i.bmdma[0].status = (val & 0x60) | (d->i.bmdma[0].status & 1) |
+                               (d->i.bmdma[0].status & ~val & 6);
+        break;
+    case 0x04 ... 0x07:
+        bmdma_addr_ioport_ops.write(&d->i.bmdma[0], addr - 4, val, size);
+        break;
+    case 0x08:
+    case 0x18:
+        bmdma_cmd_writeb(&d->i.bmdma[1], val);
+        break;
+    case 0x09:
+    case 0x19:
+        d->regs[1].swdata = val & 0x3f;
+        break;
+    case 0x0a:
+    case 0x1a:
+        d->i.bmdma[1].status = (val & 0x60) | (d->i.bmdma[1].status & 1) |
+                               (d->i.bmdma[1].status & ~val & 6);
+        break;
+    case 0x0c ... 0x0f:
+        bmdma_addr_ioport_ops.write(&d->i.bmdma[1], addr - 12, val, size);
+        break;
+    case 0x80 ... 0x87:
+        if (size == 1) {
+            ide_ioport_write(&d->i.bus[0], addr - 0x80, val);
+        } else if (addr == 0x80) {
+            if (size == 2) {
+                ide_data_writew(&d->i.bus[0], 0, val);
+            } else {
+                ide_data_writel(&d->i.bus[0], 0, val);
+            }
+        }
+        break;
+    case 0x8a:
+        if (size == 1) {
+            ide_cmd_write(&d->i.bus[0], 4, val);
+        }
+        break;
+    case 0xc0 ... 0xc7:
+        if (size == 1) {
+            ide_ioport_write(&d->i.bus[1], addr - 0xc0, val);
+        } else if (addr == 0xc0) {
+            if (size == 2) {
+                ide_data_writew(&d->i.bus[1], 0, val);
+            } else {
+                ide_data_writel(&d->i.bus[1], 0, val);
+            }
+        }
+        break;
+    case 0xca:
+        if (size == 1) {
+            ide_cmd_write(&d->i.bus[1], 4, val);
+        }
+        break;
+    case 0x100:
+        d->regs[0].scontrol = val & 0xfff;
+        if (val & 1) {
+            ide_bus_reset(&d->i.bus[0]);
+        }
+        break;
+    case 0x148:
+        d->regs[0].sien = (val >> 16) & 0x3eed;
+        break;
+    case 0x180:
+        d->regs[1].scontrol = val & 0xfff;
+        if (val & 1) {
+            ide_bus_reset(&d->i.bus[1]);
+        }
+        break;
+    case 0x1c8:
+        d->regs[1].sien = (val >> 16) & 0x3eed;
+        break;
+    default:
+        val = 0;
+    }
+}
+
+static const MemoryRegionOps sii3112_reg_ops = {
+    .read = sii3112_reg_read,
+    .write = sii3112_reg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+/* the PCI irq level is the logical OR of the two channels */
+static void sii3112_update_irq(SiI3112PCIState *s)
+{
+    int i, set = 0;
+
+    for (i = 0; i < 2; i++) {
+        set |= s->regs[i].confstat & (1UL << 11);
+    }
+    pci_set_irq(PCI_DEVICE(s), (set ? 1 : 0));
+}
+
+static void sii3112_set_irq(void *opaque, int channel, int level)
+{
+    SiI3112PCIState *s = opaque;
+
+    trace_sii3112_set_irq(channel, level);
+    if (level) {
+        s->regs[channel].confstat |= (1UL << 11);
+    } else {
+        s->regs[channel].confstat &= ~(1UL << 11);
+    }
+
+    sii3112_update_irq(s);
+}
+
+static void sii3112_reset(void *opaque)
+{
+    SiI3112PCIState *s = opaque;
+    int i;
+
+    for (i = 0; i < 2; i++) {
+        s->regs[i].confstat = 0x6515 << 16;
+        ide_bus_reset(&s->i.bus[i]);
+    }
+}
+
+static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
+{
+    SiI3112PCIState *d = SII3112_PCI(dev);
+    PCIIDEState *s = PCI_IDE(dev);
+    MemoryRegion *mr;
+    qemu_irq *irq;
+    int i;
+
+    pci_config_set_interrupt_pin(dev->config, 1);
+    pci_set_byte(dev->config + PCI_CACHE_LINE_SIZE, 8);
+
+    /* BAR5 is in PCI memory space */
+    memory_region_init_io(&d->mmio, OBJECT(d), &sii3112_reg_ops, d,
+                         "sii3112.bar5", 0x200);
+    pci_register_bar(dev, 5, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
+
+    /* BAR0-BAR4 are PCI I/O space aliases into BAR5 */
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar0", &d->mmio, 0x80, 8);
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, mr);
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar1", &d->mmio, 0x88, 4);
+    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, mr);
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar2", &d->mmio, 0xc0, 8);
+    pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_IO, mr);
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar3", &d->mmio, 0xc8, 4);
+    pci_register_bar(dev, 3, PCI_BASE_ADDRESS_SPACE_IO, mr);
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0, 16);
+    pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
+
+    irq = qemu_allocate_irqs(sii3112_set_irq, d, 2);
+    for (i = 0; i < 2; i++) {
+        ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1);
+        ide_init2(&s->bus[i], irq[i]);
+
+        bmdma_init(&s->bus[i], &s->bmdma[i], s);
+        s->bmdma[i].bus = &s->bus[i];
+        ide_register_restart_cb(&s->bus[i]);
+    }
+    qemu_register_reset(sii3112_reset, s);
+}
+
+static void sii3112_pci_exitfn(PCIDevice *dev)
+{
+    PCIIDEState *d = PCI_IDE(dev);
+    int i;
+
+    for (i = 0; i < 2; ++i) {
+        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].extra_io);
+        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].addr_ioport);
+    }
+}
+
+static void sii3112_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pd = PCI_DEVICE_CLASS(klass);
+
+    pd->vendor_id = 0x1095;
+    pd->device_id = 0x3112;
+    pd->class_id = PCI_CLASS_STORAGE_RAID;
+    pd->revision = 1;
+    pd->realize = sii3112_pci_realize;
+    pd->exit = sii3112_pci_exitfn;
+    dc->desc = "SiI3112A SATA controller";
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo sii3112_pci_info = {
+    .name = TYPE_SII3112_PCI,
+    .parent = TYPE_PCI_IDE,
+    .instance_size = sizeof(SiI3112PCIState),
+    .class_init = sii3112_pci_class_init,
+};
+
+static void sii3112_register_types(void)
+{
+    type_register_static(&sii3112_pci_info);
+}
+
+type_init(sii3112_register_types)
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 601bd97d81..0c39cabe72 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -37,6 +37,11 @@ bmdma_addr_write(uint64_t data) "data: 0x%016"PRIx64
 bmdma_read(uint64_t addr, uint8_t val) "bmdma: readb 0x%"PRIx64" : 0x%02x"
 bmdma_write(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x%02"PRIx64
 
+# hw/ide/sii3112.c
+sii3112_read(int size, uint64_t addr, uint64_t val) "bmdma: read (size %d) 0x%"PRIx64" : 0x%02"PRIx64
+sii3112_write(int size, uint64_t addr, uint64_t val) "bmdma: write (size %d) 0x%"PRIx64" : 0x%02"PRIx64
+sii3112_set_irq(int channel, int level) "channel %d level %d"
+
 # hw/ide/via.c
 bmdma_read_via(uint64_t addr, uint32_t val) "bmdma: readb 0x%"PRIx64" : 0x%02x"
 bmdma_write_via(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x%02"PRIx64
-- 
2.14.3
