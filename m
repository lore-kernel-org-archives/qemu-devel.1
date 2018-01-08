Received: from eggs.gnu.org ([2001:4830:134:3::10]:51858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTZ-0007q0-2i
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTX-0003Pc-1h
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:49 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:44110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTW-0003PL-SA
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:46 -0500
Received: by mail-qk0-x241.google.com with SMTP id v188so12537486qkh.11
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:46 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:57 -0300
Message-Id: <20180108024558.17983-29-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 28/29] piix: merge common code from isa/piix4.c
 with southbridge piix3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/isa/piix4.c        | 218 --------------------------------------------
 hw/southbridge/piix.c | 246 +++++++++++++++++++++++++++++++++++++++++---------
 hw/isa/Makefile.objs  |   1 -
 3 files changed, 203 insertions(+), 262 deletions(-)
 delete mode 100644 hw/isa/piix4.c

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
deleted file mode 100644
index c78516e595..0000000000
--- a/hw/isa/piix4.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- * QEMU PIIX4 PCI Bridge Emulation
- *
- * Copyright (c) 2006 Fabrice Bellard
- * Copyright (c) 2018 Hervé Poussineau
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "hw/hw.h"
-#include "hw/i386/pc.h"
-#include "hw/pci/pci.h"
-#include "hw/isa/isa.h"
-#include "hw/southbridge/i82371_piix.h"
-#include "hw/dma/i8257.h"
-#include "hw/sysbus.h"
-#include "hw/audio/pcspk.h"
-#include "hw/timer/i8254.h"
-
-PCIDevice *piix4_dev;
-
-typedef struct PIIX4State {
-    PCIDevice dev;
-    qemu_irq cpu_intr;
-    qemu_irq *isa;
-
-    /* Reset Control Register */
-    MemoryRegion rcr_mem;
-    uint8_t rcr;
-} PIIX4State;
-
-#define TYPE_PIIX4_PCI_DEVICE "PIIX4"
-#define PIIX4_PCI_DEVICE(obj) \
-    OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)
-
-static void piix4_reset(DeviceState *dev)
-{
-    PIIX4State *s = PIIX4_PCI_DEVICE(dev);
-    uint8_t *pci_conf = s->dev.config;
-
-    pci_conf[0x04] = 0x07; // master, memory and I/O
-    pci_conf[0x05] = 0x00;
-    pci_conf[0x06] = 0x00;
-    pci_conf[0x07] = 0x02; // PCI_status_devsel_medium
-    pci_conf[0x4c] = 0x4d;
-    pci_conf[0x4e] = 0x03;
-    pci_conf[0x4f] = 0x00;
-    pci_conf[0x60] = 0x0a; // PCI A -> IRQ 10
-    pci_conf[0x61] = 0x0a; // PCI B -> IRQ 10
-    pci_conf[0x62] = 0x0b; // PCI C -> IRQ 11
-    pci_conf[0x63] = 0x0b; // PCI D -> IRQ 11
-    pci_conf[0x69] = 0x02;
-    pci_conf[0x70] = 0x80;
-    pci_conf[0x76] = 0x0c;
-    pci_conf[0x77] = 0x0c;
-    pci_conf[0x78] = 0x02;
-    pci_conf[0x79] = 0x00;
-    pci_conf[0x80] = 0x00;
-    pci_conf[0x82] = 0x00;
-    pci_conf[0xa0] = 0x08;
-    pci_conf[0xa2] = 0x00;
-    pci_conf[0xa3] = 0x00;
-    pci_conf[0xa4] = 0x00;
-    pci_conf[0xa5] = 0x00;
-    pci_conf[0xa6] = 0x00;
-    pci_conf[0xa7] = 0x00;
-    pci_conf[0xa8] = 0x0f;
-    pci_conf[0xaa] = 0x00;
-    pci_conf[0xab] = 0x00;
-    pci_conf[0xac] = 0x00;
-    pci_conf[0xae] = 0x00;
-}
-
-static const VMStateDescription vmstate_piix4 = {
-    .name = "PIIX4",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, PIIX4State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void piix4_request_i8259_irq(void *opaque, int irq, int level)
-{
-    PIIX4State *s = opaque;
-    qemu_set_irq(s->cpu_intr, level);
-}
-
-static void piix4_set_i8259_irq(void *opaque, int irq, int level)
-{
-    PIIX4State *s = opaque;
-    qemu_set_irq(s->isa[irq], level);
-}
-
-static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
-                            unsigned int len)
-{
-    PIIX4State *s = opaque;
-
-    if (val & 4) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-        return;
-    }
-    s->rcr = val & 2; /* keep System Reset type only */
-}
-
-static uint64_t piix4_rcr_read(void *opaque, hwaddr addr, unsigned int len)
-{
-    PIIX4State *s = opaque;
-    return s->rcr;
-}
-
-static const MemoryRegionOps piix4_rcr_ops = {
-    .read = piix4_rcr_read,
-    .write = piix4_rcr_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-};
-
-static void piix4_realize(PCIDevice *pci_dev, Error **errp)
-{
-    DeviceState *dev = DEVICE(pci_dev);
-    PIIX4State *s = DO_UPCAST(PIIX4State, dev, pci_dev);
-    ISABus *isa_bus;
-    ISADevice *pit;
-    qemu_irq *i8259_out_irq;
-
-    isa_bus = isa_bus_new(dev, pci_address_space(pci_dev),
-                          pci_address_space_io(pci_dev), errp);
-    if (!isa_bus) {
-        return;
-    }
-
-    qdev_init_gpio_in_named(dev, piix4_set_i8259_irq, "isa", ISA_NUM_IRQS);
-    qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
-
-    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
-                          "reset-control", 1);
-    memory_region_add_subregion_overlap(pci_address_space_io(pci_dev), 0xcf9,
-                                        &s->rcr_mem, 1);
-
-    /* initialize i8259 pic */
-    i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
-    s->isa = i8259_init(isa_bus, *i8259_out_irq);
-
-    /* initialize ISA irqs */
-    isa_bus_irqs(isa_bus, s->isa);
-
-    /* initialize pit */
-    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-
-    /* speaker */
-    pcspk_init(isa_bus, pit);
-
-    /* DMA */
-    i8257_dma_init(isa_bus, 0);
-
-    piix4_dev = pci_dev;
-}
-
-static void piix4_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->realize = piix4_realize;
-    k->vendor_id = PCI_VENDOR_ID_INTEL;
-    k->device_id = PCI_DEVICE_ID_INTEL_82371AB_0;
-    k->class_id = PCI_CLASS_BRIDGE_ISA;
-    dc->reset = piix4_reset;
-    dc->desc = "ISA bridge";
-    dc->vmsd = &vmstate_piix4;
-    /*
-     * Reason: part of PIIX4 southbridge, needs to be wired up,
-     * e.g. by mips_malta_init()
-     */
-    dc->user_creatable = false;
-    dc->hotpluggable = false;
-}
-
-static const TypeInfo piix4_info = {
-    .name          = TYPE_PIIX4_PCI_DEVICE,
-    .parent        = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(PIIX4State),
-    .class_init    = piix4_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
-static void piix4_register_types(void)
-{
-    type_register_static(&piix4_info);
-}
-
-type_init(piix4_register_types)
diff --git a/hw/southbridge/piix.c b/hw/southbridge/piix.c
index 2d429d6b29..53ee177866 100644
--- a/hw/southbridge/piix.c
+++ b/hw/southbridge/piix.c
@@ -24,17 +24,26 @@
 
 #include "qemu/osdep.h"
 #include "qemu/range.h"
+#include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "hw/hw.h"
+#include "hw/i386/pc.h"
 #include "hw/southbridge/i82371_piix.h"
+#include "hw/dma/i8257.h"
+#include "hw/audio/pcspk.h"
+#include "hw/timer/i8254.h"
 #include "hw/xen/xen.h"
 
 #define PIIX_NUM_PIC_IRQS       16      /* i8259 * 2 */
 #define XEN_PIIX_NUM_PIRQS      128ULL
 #define PIIX_PIRQC              0x60
 
-typedef struct PIIX3State {
+typedef struct PIIXState {
+    /*< private >*/
     PCIDevice dev;
+    /*< public >*/
+
+    ISABus *isa_bus;
 
     /*
      * bitmap to track pic levels.
@@ -50,6 +59,7 @@ typedef struct PIIX3State {
 #endif
     uint64_t pic_levels;
 
+    qemu_irq cpu_intr;
     qemu_irq *pic;
 
     /* This member isn't used. Just for save/load compatibility */
@@ -57,14 +67,43 @@ typedef struct PIIX3State {
 
     /* Reset Control Register contents */
     uint8_t rcr;
-
     /* IO memory region for Reset Control Register (RCR_IOPORT) */
     MemoryRegion rcr_mem;
-} PIIX3State;
+} PIIXState;
 
-#define TYPE_PIIX3_PCI_DEVICE "pci-piix3"
-#define PIIX3_PCI_DEVICE(obj) \
-    OBJECT_CHECK(PIIX3State, (obj), TYPE_PIIX3_PCI_DEVICE)
+static void piix_rcr_write(void *opaque, hwaddr addr, uint64_t val,
+                           unsigned int len)
+{
+    PIIXState *s = opaque;
+
+    if (val & 4) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        return;
+    }
+    s->rcr = val & 2; /* keep System Reset type only */
+}
+
+static uint64_t piix_rcr_read(void *opaque, hwaddr addr, unsigned int len)
+{
+    PIIXState *s = opaque;
+    return s->rcr;
+}
+
+static const MemoryRegionOps rcr_ops = {
+    .read = piix_rcr_read,
+    .write = piix_rcr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void piix_rcr_init(PIIXState *s, MemoryRegion *io, const char *regname)
+{
+    memory_region_init_io(&s->rcr_mem, OBJECT(s), &rcr_ops, s, regname, 1);
+    memory_region_add_subregion_overlap(io, RCR_IOPORT, &s->rcr_mem, 1);
+}
 
 /* return the global irq number corresponding to a given device irq
    pin. We could also use the bus number to have a more precise
@@ -76,6 +115,28 @@ static int pci_slot_get_pirq(PCIDevice *pci_dev, int pci_intx)
     return (pci_intx + slot_addend) & 3;
 }
 
+static void piix_realize(PCIDevice *pci_dev, PIIXState *s, Error **errp)
+{
+    MemoryRegion *pci_io = pci_address_space_io(pci_dev);
+
+    s->isa_bus = isa_bus_new(DEVICE(s), pci_address_space(pci_dev),
+                             pci_io, errp);
+    if (!s->isa_bus) {
+        if (!errp) {
+            error_setg(errp, "can not create ISA bus");
+        }
+        return;
+    }
+
+    piix_rcr_init(s, pci_io, "reset-control");
+}
+
+typedef struct PIIXState PIIX3State;
+
+#define TYPE_PIIX3_PCI_DEVICE "pci-piix3"
+#define PIIX3_PCI_DEVICE(obj) \
+    OBJECT_CHECK(PIIX3State, (obj), TYPE_PIIX3_PCI_DEVICE)
+
 /* PIIX3 PCI to ISA bridge */
 static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
 {
@@ -314,44 +375,9 @@ static const VMStateDescription vmstate_piix3 = {
     }
 };
 
-
-static void rcr_write(void *opaque, hwaddr addr, uint64_t val, unsigned len)
-{
-    PIIX3State *d = opaque;
-
-    if (val & 4) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-        return;
-    }
-    d->rcr = val & 2; /* keep System Reset type only */
-}
-
-static uint64_t rcr_read(void *opaque, hwaddr addr, unsigned len)
-{
-    PIIX3State *d = opaque;
-
-    return d->rcr;
-}
-
-static const MemoryRegionOps rcr_ops = {
-    .read = rcr_read,
-    .write = rcr_write,
-    .endianness = DEVICE_LITTLE_ENDIAN
-};
-
-static void piix3_realize(PCIDevice *dev, Error **errp)
+static void piix3_realize(PCIDevice *pci_dev, Error **errp)
 {
-    PIIX3State *d = PIIX3_PCI_DEVICE(dev);
-
-    if (!isa_bus_new(DEVICE(d), get_system_memory(),
-                     pci_address_space_io(dev), errp)) {
-        return;
-    }
-
-    memory_region_init_io(&d->rcr_mem, OBJECT(dev), &rcr_ops, d,
-                          "piix3-reset-control", 1);
-    memory_region_add_subregion_overlap(pci_address_space_io(dev), RCR_IOPORT,
-                                        &d->rcr_mem, 1);
+    piix_realize(pci_dev, PIIX3_PCI_DEVICE(pci_dev), errp);
 }
 
 static void pci_piix3_class_init(ObjectClass *klass, void *data)
@@ -413,11 +439,145 @@ static const TypeInfo piix3_xen_info = {
     .class_init    = piix3_xen_class_init,
 };
 
+typedef struct PIIXState PIIX4State;
+
+#define TYPE_PIIX4_PCI_DEVICE "PIIX4"
+#define PIIX4_PCI_DEVICE(obj) \
+    OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)
+
+static const VMStateDescription vmstate_piix4 = {
+    .name = "PIIX4",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, PIIX4State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void piix4_request_i8259_irq(void *opaque, int irq, int level)
+{
+    PIIX4State *s = opaque;
+    qemu_set_irq(s->cpu_intr, level);
+}
+
+static void piix4_set_i8259_irq(void *opaque, int irq, int level)
+{
+    PIIX4State *s = opaque;
+    qemu_set_irq(s->pic[irq], level);
+}
+
+static void piix4_reset(DeviceState *dev)
+{
+    PIIX4State *s = PIIX4_PCI_DEVICE(dev);
+    uint8_t *pci_conf = s->dev.config;
+
+    pci_conf[0x04] = 0x07; /* master, memory and I/O */
+    pci_conf[0x05] = 0x00;
+    pci_conf[0x06] = 0x00;
+    pci_conf[0x07] = 0x02; /* PCI_status_devsel_medium */
+    pci_conf[0x4c] = 0x4d;
+    pci_conf[0x4e] = 0x03;
+    pci_conf[0x4f] = 0x00;
+    pci_conf[0x60] = 0x0a; /* PCI A -> IRQ 10 */
+    pci_conf[0x61] = 0x0a; /* PCI B -> IRQ 10 */
+    pci_conf[0x62] = 0x0b; /* PCI C -> IRQ 11 */
+    pci_conf[0x63] = 0x0b; /* PCI D -> IRQ 11 */
+    pci_conf[0x69] = 0x02;
+    pci_conf[0x70] = 0x80;
+    pci_conf[0x76] = 0x0c;
+    pci_conf[0x77] = 0x0c;
+    pci_conf[0x78] = 0x02;
+    pci_conf[0x79] = 0x00;
+    pci_conf[0x80] = 0x00;
+    pci_conf[0x82] = 0x00;
+    pci_conf[0xa0] = 0x08;
+    pci_conf[0xa2] = 0x00;
+    pci_conf[0xa3] = 0x00;
+    pci_conf[0xa4] = 0x00;
+    pci_conf[0xa5] = 0x00;
+    pci_conf[0xa6] = 0x00;
+    pci_conf[0xa7] = 0x00;
+    pci_conf[0xa8] = 0x0f;
+    pci_conf[0xaa] = 0x00;
+    pci_conf[0xab] = 0x00;
+    pci_conf[0xac] = 0x00;
+    pci_conf[0xae] = 0x00;
+}
+
+PCIDevice *piix4_dev;
+
+static void piix4_realize(PCIDevice *pci_dev, Error **errp)
+{
+    DeviceState *dev = DEVICE(pci_dev);
+    PIIX4State *s = DO_UPCAST(PIIX4State, dev, pci_dev);
+    ISADevice *pit;
+    qemu_irq *i8259_out_irq;
+
+    piix_realize(pci_dev, s, errp);
+    if (errp) {
+        return;
+    }
+
+    qdev_init_gpio_in_named(dev, piix4_set_i8259_irq, "isa", ISA_NUM_IRQS);
+    qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
+
+    /* initialize i8259 pic */
+    i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
+    s->pic = i8259_init(s->isa_bus, *i8259_out_irq);
+
+    /* initialize ISA irqs */
+    isa_bus_irqs(s->isa_bus, s->pic);
+
+    /* initialize pit */
+    pit = i8254_pit_init(s->isa_bus, 0x40, 0, NULL);
+
+    /* speaker */
+    pcspk_init(s->isa_bus, pit);
+
+    /* DMA */
+    i8257_dma_init(s->isa_bus, 0);
+
+    piix4_dev = pci_dev;
+}
+
+static void piix4_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = piix4_realize;
+    k->vendor_id = PCI_VENDOR_ID_INTEL;
+    k->device_id = PCI_DEVICE_ID_INTEL_82371AB_0;
+    k->class_id = PCI_CLASS_BRIDGE_ISA;
+    dc->reset = piix4_reset;
+    dc->desc = "ISA bridge";
+    dc->vmsd = &vmstate_piix4;
+    /*
+     * Reason: part of PIIX4 southbridge, needs to be wired up,
+     * e.g. by mips_malta_init()
+     */
+    dc->user_creatable = false;
+    dc->hotpluggable = false;
+}
+
+static const TypeInfo piix4_info = {
+    .name          = TYPE_PIIX4_PCI_DEVICE,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PIIX4State),
+    .class_init    = piix4_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
 static void piix_register_types(void)
 {
     type_register_static(&piix3_pci_type_info);
     type_register_static(&piix3_info);
     type_register_static(&piix3_xen_info);
+    type_register_static(&piix4_info);
 }
 
 type_init(piix_register_types)
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index fa071082d4..40c34ba184 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -3,7 +3,6 @@ common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
 common-obj-$(CONFIG_APM) += apm.o
 common-obj-$(CONFIG_I82378) += i82378.o
 common-obj-$(CONFIG_PC87312) += pc87312.o
-common-obj-$(CONFIG_PCI_PIIX) += piix4.o
 common-obj-$(CONFIG_VT82C686) += vt82c686.o
 
 obj-$(CONFIG_LPC_ICH9) += lpc_ich9.o
-- 
2.15.1
