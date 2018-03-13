Received: from eggs.gnu.org ([2001:4830:134:3::10]:58257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiJ-0005wt-GU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiG-0003f6-3F
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:11 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiF-0003dq-OW
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:08 -0400
Received: by mail-wr0-x243.google.com with SMTP id h2so2480095wre.12
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:46 +0100
Message-Id: <20180313224719.4954-37-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 36/69] hw/isa/superio: Factor out the parallel
 code from pc87312.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-11-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-superio.c     | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/isa/pc87312.c         | 38 +++++++++++-----------------
 hw/isa/trace-events      |  4 ++-
 include/hw/isa/pc87312.h |  4 ---
 include/hw/isa/superio.h |  6 +++++
 5 files changed, 89 insertions(+), 28 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 14ec16f831..eb263fcc3a 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -10,14 +10,79 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "sysemu/sysemu.h"
+#include "chardev/char.h"
 #include "hw/isa/superio.h"
 #include "trace.h"
 
+static void isa_superio_realize(DeviceState *dev, Error **errp)
+{
+    ISASuperIODevice *sio = ISA_SUPERIO(dev);
+    ISASuperIOClass *k = ISA_SUPERIO_GET_CLASS(sio);
+    ISABus *bus = isa_bus_from_device(ISA_DEVICE(dev));
+    ISADevice *isa;
+    DeviceState *d;
+    Chardev *chr;
+    char *name;
+    int i;
+
+    /* Parallel port */
+    for (i = 0; i < k->parallel.count; i++) {
+        if (i >= ARRAY_SIZE(sio->parallel)) {
+            warn_report("superio: ignoring %td parallel controllers",
+                        k->parallel.count - ARRAY_SIZE(sio->parallel));
+            break;
+        }
+        if (!k->parallel.is_enabled || k->parallel.is_enabled(sio, i)) {
+            /* FIXME use a qdev chardev prop instead of parallel_hds[] */
+            chr = parallel_hds[i];
+            if (chr == NULL || chr->be) {
+                name = g_strdup_printf("discarding-parallel%d", i);
+                chr = qemu_chr_new(name, "null");
+            } else {
+                name = g_strdup_printf("parallel%d", i);
+            }
+            isa = isa_create(bus, "isa-parallel");
+            d = DEVICE(isa);
+            qdev_prop_set_uint32(d, "index", i);
+            if (k->parallel.get_iobase) {
+                qdev_prop_set_uint32(d, "iobase",
+                                     k->parallel.get_iobase(sio, i));
+            }
+            if (k->parallel.get_irq) {
+                qdev_prop_set_uint32(d, "irq", k->parallel.get_irq(sio, i));
+            }
+            qdev_prop_set_chr(d, "chardev", chr);
+            qdev_init_nofail(d);
+            sio->parallel[i] = isa;
+            trace_superio_create_parallel(i,
+                                          k->parallel.get_iobase ?
+                                          k->parallel.get_iobase(sio, i) : -1,
+                                          k->parallel.get_irq ?
+                                          k->parallel.get_irq(sio, i) : -1);
+            object_property_add_child(OBJECT(dev), name,
+                                      OBJECT(sio->parallel[i]), NULL);
+            g_free(name);
+        }
+    }
+}
+
+static void isa_superio_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = isa_superio_realize;
+    /* Reason: Uses parallel_hds[0] in realize(), so it can't be used twice */
+    dc->user_creatable = false;
+}
+
 static const TypeInfo isa_superio_type_info = {
     .name = TYPE_ISA_SUPERIO,
     .parent = TYPE_ISA_DEVICE,
     .abstract = true,
     .class_size = sizeof(ISASuperIOClass),
+    .class_init = isa_superio_class_init,
 };
 
 static void isa_superio_register_types(void)
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 6b8100ff56..1c15715c69 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -64,22 +64,25 @@
 
 /* Parallel port */
 
-static inline bool is_parallel_enabled(PC87312State *s)
+static bool is_parallel_enabled(ISASuperIODevice *sio, uint8_t index)
 {
-    return s->regs[REG_FER] & FER_PARALLEL_EN;
+    PC87312State *s = PC87312(sio);
+    return index ? false : s->regs[REG_FER] & FER_PARALLEL_EN;
 }
 
 static const uint16_t parallel_base[] = { 0x378, 0x3bc, 0x278, 0x00 };
 
-static inline uint16_t get_parallel_iobase(PC87312State *s)
+static uint16_t get_parallel_iobase(ISASuperIODevice *sio, uint8_t index)
 {
+    PC87312State *s = PC87312(sio);
     return parallel_base[s->regs[REG_FAR] & FAR_PARALLEL_ADDR];
 }
 
 static const unsigned int parallel_irq[] = { 5, 7, 5, 0 };
 
-static inline unsigned int get_parallel_irq(PC87312State *s)
+static unsigned int get_parallel_irq(ISASuperIODevice *sio, uint8_t index)
 {
+    PC87312State *s = PC87312(sio);
     int idx;
     idx = (s->regs[REG_FAR] & FAR_PARALLEL_ADDR);
     if (idx == 0) {
@@ -286,24 +289,6 @@ static void pc87312_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (is_parallel_enabled(s)) {
-        /* FIXME use a qdev chardev prop instead of parallel_hds[] */
-        chr = parallel_hds[0];
-        if (chr == NULL) {
-            chr = qemu_chr_new("par0", "null");
-        }
-        isa = isa_create(bus, "isa-parallel");
-        d = DEVICE(isa);
-        qdev_prop_set_uint32(d, "index", 0);
-        qdev_prop_set_uint32(d, "iobase", get_parallel_iobase(s));
-        qdev_prop_set_uint32(d, "irq", get_parallel_irq(s));
-        qdev_prop_set_chr(d, "chardev", chr);
-        qdev_init_nofail(d);
-        s->parallel.dev = isa;
-        trace_pc87312_info_parallel(get_parallel_iobase(s),
-                                    get_parallel_irq(s));
-    }
-
     for (i = 0; i < 2; i++) {
         if (is_uart_enabled(s, i)) {
             /* FIXME use a qdev chardev prop instead of serial_hds[] */
@@ -395,8 +380,15 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
     dc->reset = pc87312_reset;
     dc->vmsd = &vmstate_pc87312;
     dc->props = pc87312_properties;
-    /* Reason: Uses parallel_hds[0] in realize(), so it can't be used twice */
+    /* Reason: Uses serial_hds[0] in realize(), so it can't be used twice */
     dc->user_creatable = false;
+
+    sc->parallel = (ISASuperIOFuncs){
+        .count = 1,
+        .is_enabled = is_parallel_enabled,
+        .get_iobase = get_parallel_iobase,
+        .get_irq    = get_parallel_irq,
+    };
 }
 
 static const TypeInfo pc87312_type_info = {
diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index a4ab4e3634..97b1949981 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -1,9 +1,11 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/isa/isa-superio.c
+superio_create_parallel(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x, irq %u"
+
 # hw/isa/pc87312.c
 pc87312_io_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 pc87312_io_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 pc87312_info_floppy(uint32_t base) "base 0x%x"
 pc87312_info_ide(uint32_t base) "base 0x%x"
-pc87312_info_parallel(uint32_t base, uint32_t irq) "base 0x%x, irq %u"
 pc87312_info_serial(int n, uint32_t base, uint32_t irq) "id=%d, base 0x%x, irq %u"
diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
index f3761d6fe1..bcc4578479 100644
--- a/include/hw/isa/pc87312.h
+++ b/include/hw/isa/pc87312.h
@@ -39,10 +39,6 @@ typedef struct PC87312State {
     uint16_t iobase;
     uint8_t config; /* initial configuration */
 
-    struct {
-        ISADevice *dev;
-    } parallel;
-
     struct {
         ISADevice *dev;
     } uart[2];
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index cff6ad6c08..e9879cfde1 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -23,7 +23,11 @@
     OBJECT_CLASS_CHECK(ISASuperIOClass, (klass), TYPE_ISA_SUPERIO)
 
 typedef struct ISASuperIODevice {
+    /*< private >*/
     ISADevice parent_obj;
+    /*< public >*/
+
+    ISADevice *parallel[MAX_PARALLEL_PORTS];
 } ISASuperIODevice;
 
 typedef struct ISASuperIOFuncs {
@@ -39,6 +43,8 @@ typedef struct ISASuperIOClass {
     ISADeviceClass parent_class;
     /*< public >*/
     DeviceRealize parent_realize;
+
+    ISASuperIOFuncs parallel;
 } ISASuperIOClass;
 
 #endif /* HW_ISA_SUPERIO_H */
-- 
2.14.3
