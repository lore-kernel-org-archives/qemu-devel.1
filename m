Received: from eggs.gnu.org ([2001:4830:134:3::10]:58254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiJ-0005wk-DR
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiH-0003gr-AU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:11 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiH-0003fX-09
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:09 -0400
Received: by mail-wr0-x241.google.com with SMTP id z12so2563187wrg.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:47 +0100
Message-Id: <20180313224719.4954-38-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/69] hw/isa/superio: Factor out the serial
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
Message-Id: <20180308223946.26784-12-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-superio.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/isa/pc87312.c         | 43 ++++++++++++-------------------------------
 hw/isa/trace-events      |  2 +-
 include/hw/isa/pc87312.h |  4 ----
 include/hw/isa/superio.h |  2 ++
 5 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index eb263fcc3a..6962421aad 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -14,6 +14,7 @@
 #include "sysemu/sysemu.h"
 #include "chardev/char.h"
 #include "hw/isa/superio.h"
+#include "hw/char/serial.h"
 #include "trace.h"
 
 static void isa_superio_realize(DeviceState *dev, Error **errp)
@@ -66,6 +67,46 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             g_free(name);
         }
     }
+
+    /* Serial */
+    for (i = 0; i < k->serial.count; i++) {
+        if (i >= ARRAY_SIZE(sio->serial)) {
+            warn_report("superio: ignoring %td serial controllers",
+                        k->serial.count - ARRAY_SIZE(sio->serial));
+            break;
+        }
+        if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
+            /* FIXME use a qdev chardev prop instead of serial_hds[] */
+            chr = serial_hds[i];
+            if (chr == NULL || chr->be) {
+                name = g_strdup_printf("discarding-serial%d", i);
+                chr = qemu_chr_new(name, "null");
+            } else {
+                name = g_strdup_printf("serial%d", i);
+            }
+            isa = isa_create(bus, TYPE_ISA_SERIAL);
+            d = DEVICE(isa);
+            qdev_prop_set_uint32(d, "index", i);
+            if (k->serial.get_iobase) {
+                qdev_prop_set_uint32(d, "iobase",
+                                     k->serial.get_iobase(sio, i));
+            }
+            if (k->serial.get_irq) {
+                qdev_prop_set_uint32(d, "irq", k->serial.get_irq(sio, i));
+            }
+            qdev_prop_set_chr(d, "chardev", chr);
+            qdev_init_nofail(d);
+            sio->serial[i] = isa;
+            trace_superio_create_serial(i,
+                                        k->serial.get_iobase ?
+                                        k->serial.get_iobase(sio, i) : -1,
+                                        k->serial.get_irq ?
+                                        k->serial.get_irq(sio, i) : -1);
+            object_property_add_child(OBJECT(dev), name,
+                                      OBJECT(sio->serial[0]), NULL);
+            g_free(name);
+        }
+    }
 }
 
 static void isa_superio_class_init(ObjectClass *oc, void *data)
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 1c15715c69..c2837bca43 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -29,8 +29,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
-#include "chardev/char.h"
 #include "trace.h"
 
 
@@ -100,8 +98,9 @@ static const uint16_t uart_base[2][4] = {
     { 0x2e8, 0x238, 0x2e0, 0x228 }
 };
 
-static inline uint16_t get_uart_iobase(PC87312State *s, int i)
+static uint16_t get_uart_iobase(ISASuperIODevice *sio, uint8_t i)
 {
+    PC87312State *s = PC87312(sio);
     int idx;
     idx = (s->regs[REG_FAR] >> (2 * i + 2)) & 0x3;
     if (idx == 0) {
@@ -113,15 +112,17 @@ static inline uint16_t get_uart_iobase(PC87312State *s, int i)
     }
 }
 
-static inline unsigned int get_uart_irq(PC87312State *s, int i)
+static unsigned int get_uart_irq(ISASuperIODevice *sio, uint8_t i)
 {
+    PC87312State *s = PC87312(sio);
     int idx;
     idx = (s->regs[REG_FAR] >> (2 * i + 2)) & 0x3;
     return (idx & 1) ? 3 : 4;
 }
 
-static inline bool is_uart_enabled(PC87312State *s, int i)
+static bool is_uart_enabled(ISASuperIODevice *sio, uint8_t i)
 {
+    PC87312State *s = PC87312(sio);
     return s->regs[REG_FER] & (FER_UART1_EN << i);
 }
 
@@ -271,11 +272,8 @@ static void pc87312_realize(DeviceState *dev, Error **errp)
     DeviceState *d;
     ISADevice *isa;
     ISABus *bus;
-    Chardev *chr;
     DriveInfo *drive;
     Error *local_err = NULL;
-    char name[5];
-    int i;
 
     s = PC87312(dev);
     isa = ISA_DEVICE(dev);
@@ -289,27 +287,6 @@ static void pc87312_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    for (i = 0; i < 2; i++) {
-        if (is_uart_enabled(s, i)) {
-            /* FIXME use a qdev chardev prop instead of serial_hds[] */
-            chr = serial_hds[i];
-            if (chr == NULL) {
-                snprintf(name, sizeof(name), "ser%d", i);
-                chr = qemu_chr_new(name, "null");
-            }
-            isa = isa_create(bus, "isa-serial");
-            d = DEVICE(isa);
-            qdev_prop_set_uint32(d, "index", i);
-            qdev_prop_set_uint32(d, "iobase", get_uart_iobase(s, i));
-            qdev_prop_set_uint32(d, "irq", get_uart_irq(s, i));
-            qdev_prop_set_chr(d, "chardev", chr);
-            qdev_init_nofail(d);
-            s->uart[i].dev = isa;
-            trace_pc87312_info_serial(i, get_uart_iobase(s, i),
-                                      get_uart_irq(s, i));
-        }
-    }
-
     if (is_fdc_enabled(s)) {
         isa = isa_create(bus, "isa-fdc");
         d = DEVICE(isa);
@@ -380,8 +357,6 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
     dc->reset = pc87312_reset;
     dc->vmsd = &vmstate_pc87312;
     dc->props = pc87312_properties;
-    /* Reason: Uses serial_hds[0] in realize(), so it can't be used twice */
-    dc->user_creatable = false;
 
     sc->parallel = (ISASuperIOFuncs){
         .count = 1,
@@ -389,6 +364,12 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
         .get_iobase = get_parallel_iobase,
         .get_irq    = get_parallel_irq,
     };
+    sc->serial = (ISASuperIOFuncs){
+        .count = 2,
+        .is_enabled = is_uart_enabled,
+        .get_iobase = get_uart_iobase,
+        .get_irq    = get_uart_irq,
+    };
 }
 
 static const TypeInfo pc87312_type_info = {
diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index 97b1949981..c78dd6c353 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -2,10 +2,10 @@
 
 # hw/isa/isa-superio.c
 superio_create_parallel(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x, irq %u"
+superio_create_serial(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x, irq %u"
 
 # hw/isa/pc87312.c
 pc87312_io_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 pc87312_io_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 pc87312_info_floppy(uint32_t base) "base 0x%x"
 pc87312_info_ide(uint32_t base) "base 0x%x"
-pc87312_info_serial(int n, uint32_t base, uint32_t irq) "id=%d, base 0x%x, irq %u"
diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
index bcc4578479..1480615a2c 100644
--- a/include/hw/isa/pc87312.h
+++ b/include/hw/isa/pc87312.h
@@ -39,10 +39,6 @@ typedef struct PC87312State {
     uint16_t iobase;
     uint8_t config; /* initial configuration */
 
-    struct {
-        ISADevice *dev;
-    } uart[2];
-
     struct {
         ISADevice *dev;
     } fdc;
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index e9879cfde1..0b516721c3 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -28,6 +28,7 @@ typedef struct ISASuperIODevice {
     /*< public >*/
 
     ISADevice *parallel[MAX_PARALLEL_PORTS];
+    ISADevice *serial[MAX_SERIAL_PORTS];
 } ISASuperIODevice;
 
 typedef struct ISASuperIOFuncs {
@@ -45,6 +46,7 @@ typedef struct ISASuperIOClass {
     DeviceRealize parent_realize;
 
     ISASuperIOFuncs parallel;
+    ISASuperIOFuncs serial;
 } ISASuperIOClass;
 
 #endif /* HW_ISA_SUPERIO_H */
-- 
2.14.3
