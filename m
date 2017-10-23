Received: from eggs.gnu.org ([2001:4830:134:3::10]:58858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e6hmQ-0004OO-Lr
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 14:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e6hmP-0002z8-7k
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 14:48:54 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 23 Oct 2017 20:48:29 +0200
Message-Id: <1508784509-29377-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ide/ahci: Move allwinner code into a
 separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

The allwinner code is only needed for the allwinner board (for which
we also have a separate CONFIG_ALLWINNER_A10 config switch), so it
does not make sense that we compile this for all the other boards
that need AHCI, too. Let's move it to a separate file that is only
compiled when CONFIG_ALLWINNER_A10 is set.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ide/Makefile.objs    |   1 +
 hw/ide/ahci-allwinner.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ide/ahci.c           |  95 ------------------------------------
 3 files changed, 128 insertions(+), 95 deletions(-)
 create mode 100644 hw/ide/ahci-allwinner.c

diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
index 729e9bd..f0edca3 100644
--- a/hw/ide/Makefile.objs
+++ b/hw/ide/Makefile.objs
@@ -10,3 +10,4 @@ common-obj-$(CONFIG_IDE_VIA) += via.o
 common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
 common-obj-$(CONFIG_AHCI) += ahci.o
 common-obj-$(CONFIG_AHCI) += ich.o
+common-obj-$(CONFIG_ALLWINNER_A10) += ahci-allwinner.o
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
new file mode 100644
index 0000000..c3f1604
--- /dev/null
+++ b/hw/ide/ahci-allwinner.c
@@ -0,0 +1,127 @@
+/*
+ * QEMU Allwinner AHCI Emulation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "qemu/error-report.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/dma.h"
+#include "hw/ide/internal.h"
+#include "hw/ide/ahci_internal.h"
+
+#include "trace.h"
+
+#define ALLWINNER_AHCI_BISTAFR    ((0xa0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_BISTCR     ((0xa4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_BISTFCTR   ((0xa8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_BISTSR     ((0xac - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_BISTDECR   ((0xb0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_DIAGNR0    ((0xb4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_DIAGNR1    ((0xb8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_OOBR       ((0xbc - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_PHYCS0R    ((0xc0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_PHYCS1R    ((0xc4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_PHYCS2R    ((0xc8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_TIMER1MS   ((0xe0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_GPARAM1R   ((0xe8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_GPARAM2R   ((0xec - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_PPARAMR    ((0xf0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_TESTR      ((0xf4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_VERSIONR   ((0xf8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_IDR        ((0xfc - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_RWCR       ((0xfc - ALLWINNER_AHCI_MMIO_OFF) / 4)
+
+static uint64_t allwinner_ahci_mem_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    AllwinnerAHCIState *a = opaque;
+    AHCIState *s = &(SYSBUS_AHCI(a)->ahci);
+    uint64_t val = a->regs[addr / 4];
+
+    switch (addr / 4) {
+    case ALLWINNER_AHCI_PHYCS0R:
+        val |= 0x2 << 28;
+        break;
+    case ALLWINNER_AHCI_PHYCS2R:
+        val &= ~(0x1 << 24);
+        break;
+    }
+    trace_allwinner_ahci_mem_read(s, a, addr, val, size);
+    return  val;
+}
+
+static void allwinner_ahci_mem_write(void *opaque, hwaddr addr,
+                                     uint64_t val, unsigned size)
+{
+    AllwinnerAHCIState *a = opaque;
+    AHCIState *s = &(SYSBUS_AHCI(a)->ahci);
+
+    trace_allwinner_ahci_mem_write(s, a, addr, val, size);
+    a->regs[addr / 4] = val;
+}
+
+static const MemoryRegionOps allwinner_ahci_mem_ops = {
+    .read = allwinner_ahci_mem_read,
+    .write = allwinner_ahci_mem_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void allwinner_ahci_init(Object *obj)
+{
+    SysbusAHCIState *s = SYSBUS_AHCI(obj);
+    AllwinnerAHCIState *a = ALLWINNER_AHCI(obj);
+
+    memory_region_init_io(&a->mmio, OBJECT(obj), &allwinner_ahci_mem_ops, a,
+                          "allwinner-ahci", ALLWINNER_AHCI_MMIO_SIZE);
+    memory_region_add_subregion(&s->ahci.mem, ALLWINNER_AHCI_MMIO_OFF,
+                                &a->mmio);
+}
+
+static const VMStateDescription vmstate_allwinner_ahci = {
+    .name = "allwinner-ahci",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AllwinnerAHCIState,
+                             ALLWINNER_AHCI_MMIO_SIZE / 4),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_ahci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_allwinner_ahci;
+}
+
+static const TypeInfo allwinner_ahci_info = {
+    .name          = TYPE_ALLWINNER_AHCI,
+    .parent        = TYPE_SYSBUS_AHCI,
+    .instance_size = sizeof(AllwinnerAHCIState),
+    .instance_init = allwinner_ahci_init,
+    .class_init    = allwinner_ahci_class_init,
+};
+
+static void sysbus_ahci_register_types(void)
+{
+    type_register_static(&allwinner_ahci_info);
+}
+
+type_init(sysbus_ahci_register_types)
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 32d1296..373311f 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1737,104 +1737,9 @@ static const TypeInfo sysbus_ahci_info = {
     .class_init    = sysbus_ahci_class_init,
 };
 
-#define ALLWINNER_AHCI_BISTAFR    ((0xa0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_BISTCR     ((0xa4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_BISTFCTR   ((0xa8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_BISTSR     ((0xac - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_BISTDECR   ((0xb0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_DIAGNR0    ((0xb4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_DIAGNR1    ((0xb8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_OOBR       ((0xbc - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_PHYCS0R    ((0xc0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_PHYCS1R    ((0xc4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_PHYCS2R    ((0xc8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_TIMER1MS   ((0xe0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_GPARAM1R   ((0xe8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_GPARAM2R   ((0xec - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_PPARAMR    ((0xf0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_TESTR      ((0xf4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_VERSIONR   ((0xf8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_IDR        ((0xfc - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_RWCR       ((0xfc - ALLWINNER_AHCI_MMIO_OFF) / 4)
-
-static uint64_t allwinner_ahci_mem_read(void *opaque, hwaddr addr,
-                                        unsigned size)
-{
-    AllwinnerAHCIState *a = opaque;
-    AHCIState *s = &(SYSBUS_AHCI(a)->ahci);
-    uint64_t val = a->regs[addr/4];
-
-    switch (addr / 4) {
-    case ALLWINNER_AHCI_PHYCS0R:
-        val |= 0x2 << 28;
-        break;
-    case ALLWINNER_AHCI_PHYCS2R:
-        val &= ~(0x1 << 24);
-        break;
-    }
-    trace_allwinner_ahci_mem_read(s, a, addr, val, size);
-    return  val;
-}
-
-static void allwinner_ahci_mem_write(void *opaque, hwaddr addr,
-                                     uint64_t val, unsigned size)
-{
-    AllwinnerAHCIState *a = opaque;
-    AHCIState *s = &(SYSBUS_AHCI(a)->ahci);
-
-    trace_allwinner_ahci_mem_write(s, a, addr, val, size);
-    a->regs[addr/4] = val;
-}
-
-static const MemoryRegionOps allwinner_ahci_mem_ops = {
-    .read = allwinner_ahci_mem_read,
-    .write = allwinner_ahci_mem_write,
-    .valid.min_access_size = 4,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void allwinner_ahci_init(Object *obj)
-{
-    SysbusAHCIState *s = SYSBUS_AHCI(obj);
-    AllwinnerAHCIState *a = ALLWINNER_AHCI(obj);
-
-    memory_region_init_io(&a->mmio, OBJECT(obj), &allwinner_ahci_mem_ops, a,
-                          "allwinner-ahci", ALLWINNER_AHCI_MMIO_SIZE);
-    memory_region_add_subregion(&s->ahci.mem, ALLWINNER_AHCI_MMIO_OFF,
-                                &a->mmio);
-}
-
-static const VMStateDescription vmstate_allwinner_ahci = {
-    .name = "allwinner-ahci",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, AllwinnerAHCIState,
-                             ALLWINNER_AHCI_MMIO_SIZE/4),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void allwinner_ahci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->vmsd = &vmstate_allwinner_ahci;
-}
-
-static const TypeInfo allwinner_ahci_info = {
-    .name          = TYPE_ALLWINNER_AHCI,
-    .parent        = TYPE_SYSBUS_AHCI,
-    .instance_size = sizeof(AllwinnerAHCIState),
-    .instance_init = allwinner_ahci_init,
-    .class_init    = allwinner_ahci_class_init,
-};
-
 static void sysbus_ahci_register_types(void)
 {
     type_register_static(&sysbus_ahci_info);
-    type_register_static(&allwinner_ahci_info);
 }
 
 type_init(sysbus_ahci_register_types)
-- 
1.8.3.1
