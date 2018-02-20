Received: from eggs.gnu.org ([2001:4830:134:3::10]:36537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCrv-00054W-V7
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCru-0000V6-65
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:23 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 20 Feb 2018 18:41:51 +0000
Message-Id: <20180220184159.16483-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
References: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 03/11] heathrow: QOMify heathrow PIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/intc/heathrow_pic.c         | 126 +++++++++++++++++++++++------------------
 include/hw/intc/heathrow_pic.h |  49 ++++++++++++++++
 2 files changed, 119 insertions(+), 56 deletions(-)
 create mode 100644 include/hw/intc/heathrow_pic.h

diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 171f5ed814..7bf44e0d86 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
+#include "hw/intc/heathrow_pic.h"
 
 /* debug PIC */
 //#define DEBUG_PIC
@@ -36,39 +37,27 @@
 #define PIC_DPRINTF(fmt, ...)
 #endif
 
-typedef struct HeathrowPIC {
-    uint32_t events;
-    uint32_t mask;
-    uint32_t levels;
-    uint32_t level_triggered;
-} HeathrowPIC;
-
-typedef struct HeathrowPICS {
-    MemoryRegion mem;
-    HeathrowPIC pics[2];
-    qemu_irq *irqs;
-} HeathrowPICS;
-
-static inline int check_irq(HeathrowPIC *pic)
+static inline int heathrow_check_irq(HeathrowPICState *pic)
 {
     return (pic->events | (pic->levels & pic->level_triggered)) & pic->mask;
 }
 
 /* update the CPU irq state */
-static void heathrow_pic_update(HeathrowPICS *s)
+static void heathrow_update_irq(HeathrowState *s)
 {
-    if (check_irq(&s->pics[0]) || check_irq(&s->pics[1])) {
+    if (heathrow_check_irq(&s->pics[0]) ||
+            heathrow_check_irq(&s->pics[1])) {
         qemu_irq_raise(s->irqs[0]);
     } else {
         qemu_irq_lower(s->irqs[0]);
     }
 }
 
-static void pic_write(void *opaque, hwaddr addr,
-                      uint64_t value, unsigned size)
+static void heathrow_write(void *opaque, hwaddr addr,
+                           uint64_t value, unsigned size)
 {
-    HeathrowPICS *s = opaque;
-    HeathrowPIC *pic;
+    HeathrowState *s = opaque;
+    HeathrowPICState *pic;
     unsigned int n;
 
     n = ((addr & 0xfff) - 0x10) >> 4;
@@ -79,24 +68,24 @@ static void pic_write(void *opaque, hwaddr addr,
     switch(addr & 0xf) {
     case 0x04:
         pic->mask = value;
-        heathrow_pic_update(s);
+        heathrow_update_irq(s);
         break;
     case 0x08:
         /* do not reset level triggered IRQs */
         value &= ~pic->level_triggered;
         pic->events &= ~value;
-        heathrow_pic_update(s);
+        heathrow_update_irq(s);
         break;
     default:
         break;
     }
 }
 
-static uint64_t pic_read(void *opaque, hwaddr addr,
-                         unsigned size)
+static uint64_t heathrow_read(void *opaque, hwaddr addr,
+                              unsigned size)
 {
-    HeathrowPICS *s = opaque;
-    HeathrowPIC *pic;
+    HeathrowState *s = opaque;
+    HeathrowPICState *pic;
     unsigned int n;
     uint32_t value;
 
@@ -124,16 +113,16 @@ static uint64_t pic_read(void *opaque, hwaddr addr,
     return value;
 }
 
-static const MemoryRegionOps heathrow_pic_ops = {
-    .read = pic_read,
-    .write = pic_write,
+static const MemoryRegionOps heathrow_ops = {
+    .read = heathrow_read,
+    .write = heathrow_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void heathrow_pic_set_irq(void *opaque, int num, int level)
+static void heathrow_set_irq(void *opaque, int num, int level)
 {
-    HeathrowPICS *s = opaque;
-    HeathrowPIC *pic;
+    HeathrowState *s = opaque;
+    HeathrowPICState *pic;
     unsigned int irq_bit;
 
 #if defined(DEBUG)
@@ -153,7 +142,7 @@ static void heathrow_pic_set_irq(void *opaque, int num, int level)
     } else {
         pic->levels &= ~irq_bit;
     }
-    heathrow_pic_update(s);
+    heathrow_update_irq(s);
 }
 
 static const VMStateDescription vmstate_heathrow_pic_one = {
@@ -161,54 +150,79 @@ static const VMStateDescription vmstate_heathrow_pic_one = {
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(events, HeathrowPIC),
-        VMSTATE_UINT32(mask, HeathrowPIC),
-        VMSTATE_UINT32(levels, HeathrowPIC),
-        VMSTATE_UINT32(level_triggered, HeathrowPIC),
+        VMSTATE_UINT32(events, HeathrowPICState),
+        VMSTATE_UINT32(mask, HeathrowPICState),
+        VMSTATE_UINT32(levels, HeathrowPICState),
+        VMSTATE_UINT32(level_triggered, HeathrowPICState),
         VMSTATE_END_OF_LIST()
     }
 };
 
-static const VMStateDescription vmstate_heathrow_pic = {
+static const VMStateDescription vmstate_heathrow = {
     .name = "heathrow_pic",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_STRUCT_ARRAY(pics, HeathrowPICS, 2, 1,
-                             vmstate_heathrow_pic_one, HeathrowPIC),
+        VMSTATE_STRUCT_ARRAY(pics, HeathrowState, 2, 1,
+                             vmstate_heathrow_pic_one, HeathrowPICState),
         VMSTATE_END_OF_LIST()
     }
 };
 
-static void heathrow_pic_reset_one(HeathrowPIC *s)
+static void heathrow_reset(DeviceState *d)
 {
-    memset(s, '\0', sizeof(HeathrowPIC));
+    HeathrowState *s = HEATHROW(d);
+
+    s->pics[0].level_triggered = 0;
+    s->pics[1].level_triggered = 0x1ff00000;
 }
 
-static void heathrow_pic_reset(void *opaque)
+static void heathrow_init(Object *obj)
 {
-    HeathrowPICS *s = opaque;
-
-    heathrow_pic_reset_one(&s->pics[0]);
-    heathrow_pic_reset_one(&s->pics[1]);
+    HeathrowState *s = HEATHROW(obj);
 
-    s->pics[0].level_triggered = 0;
-    s->pics[1].level_triggered = 0x1ff00000;
+    memory_region_init_io(&s->mem, OBJECT(s), &heathrow_ops, s,
+                          "heathrow-pic", 0x1000);
 }
 
 qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
                             int nb_cpus, qemu_irq **irqs)
 {
-    HeathrowPICS *s;
+    DeviceState *d;
+    HeathrowState *s;
 
-    s = g_malloc0(sizeof(HeathrowPICS));
+    d = qdev_create(NULL, TYPE_HEATHROW);
+    qdev_init_nofail(d);
+
+    s = HEATHROW(d);
     /* only 1 CPU */
     s->irqs = irqs[0];
-    memory_region_init_io(&s->mem, NULL, &heathrow_pic_ops, s,
-                          "heathrow-pic", 0x1000);
+
     *pmem = &s->mem;
 
-    vmstate_register(NULL, -1, &vmstate_heathrow_pic, s);
-    qemu_register_reset(heathrow_pic_reset, s);
-    return qemu_allocate_irqs(heathrow_pic_set_irq, s, 64);
+    return qemu_allocate_irqs(heathrow_set_irq, s, HEATHROW_NUM_IRQS);
+}
+
+static void heathrow_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->reset = heathrow_reset;
+    dc->vmsd = &vmstate_heathrow;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
+
+static const TypeInfo heathrow_type_info = {
+    .name = TYPE_HEATHROW,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(HeathrowState),
+    .instance_init = heathrow_init,
+    .class_init = heathrow_class_init,
+};
+
+static void heathrow_register_types(void)
+{
+    type_register_static(&heathrow_type_info);
+}
+
+type_init(heathrow_register_types)
diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pic.h
new file mode 100644
index 0000000000..bc3ffaab87
--- /dev/null
+++ b/include/hw/intc/heathrow_pic.h
@@ -0,0 +1,49 @@
+/*
+ * Heathrow PIC support (OldWorld PowerMac)
+ *
+ * Copyright (c) 2005-2007 Fabrice Bellard
+ * Copyright (c) 2007 Jocelyn Mayer
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HEATHROW_H
+#define HEATHROW_H
+
+#define TYPE_HEATHROW "heathrow"
+#define HEATHROW(obj) OBJECT_CHECK(HeathrowState, (obj), TYPE_HEATHROW)
+
+typedef struct HeathrowPICState {
+    uint32_t events;
+    uint32_t mask;
+    uint32_t levels;
+    uint32_t level_triggered;
+} HeathrowPICState;
+
+typedef struct HeathrowState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mem;
+    HeathrowPICState pics[2];
+    qemu_irq *irqs;
+} HeathrowState;
+
+#define HEATHROW_NUM_IRQS 64
+
+#endif /* HEATHROW_H */
-- 
2.11.0
