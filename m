Received: from eggs.gnu.org ([2001:4830:134:3::10]:58337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiN-00061O-I6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiL-0003o4-Rk
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:15 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:54381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiL-0003m9-J7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:13 -0400
Received: by mail-wm0-x236.google.com with SMTP id h76so871629wme.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:50 +0100
Message-Id: <20180313224719.4954-41-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/69] hw/isa/superio: Factor out the IDE code
 from pc87312.c
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
Message-Id: <20180308223946.26784-15-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-superio.c     | 22 ++++++++++++++++++++++
 hw/isa/pc87312.c         | 36 ++++++++++++++++++++----------------
 hw/isa/trace-events      |  2 +-
 include/hw/isa/superio.h |  2 ++
 4 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 041b47bdbf..f98711beff 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -146,6 +146,28 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
 
     /* Keyboard, mouse */
     sio->kbc = isa_create_simple(bus, TYPE_I8042);
+
+    /* IDE */
+    if (k->ide.count && (!k->ide.is_enabled || k->ide.is_enabled(sio, 0))) {
+        isa = isa_create(bus, "isa-ide");
+        d = DEVICE(isa);
+        if (k->ide.get_iobase) {
+            qdev_prop_set_uint32(d, "iobase", k->ide.get_iobase(sio, 0));
+        }
+        if (k->ide.get_iobase) {
+            qdev_prop_set_uint32(d, "iobase2", k->ide.get_iobase(sio, 1));
+        }
+        if (k->ide.get_irq) {
+            qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
+        }
+        qdev_init_nofail(d);
+        sio->ide = isa;
+        trace_superio_create_ide(0,
+                                 k->ide.get_iobase ?
+                                 k->ide.get_iobase(sio, 0) : -1,
+                                 k->ide.get_irq ?
+                                 k->ide.get_irq(sio, 0) : -1);
+    }
 }
 
 static void isa_superio_class_init(ObjectClass *oc, void *data)
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index a1845a91c3..5cf64505fe 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -150,16 +150,28 @@ static unsigned int get_fdc_irq(ISASuperIODevice *sio, uint8_t index)
 
 /* IDE controller */
 
-static inline bool is_ide_enabled(PC87312State *s)
+static bool is_ide_enabled(ISASuperIODevice *sio, uint8_t index)
 {
+    PC87312State *s = PC87312(sio);
+
     return s->regs[REG_FER] & FER_IDE_EN;
 }
 
-static inline uint16_t get_ide_iobase(PC87312State *s)
+static uint16_t get_ide_iobase(ISASuperIODevice *sio, uint8_t index)
 {
+    PC87312State *s = PC87312(sio);
+
+    if (index == 1) {
+        return get_ide_iobase(sio, 0) + 0x206;
+    }
     return (s->regs[REG_FER] & FER_IDE_ADDR) ? 0x170 : 0x1f0;
 }
 
+static unsigned int get_ide_irq(ISASuperIODevice *sio, uint8_t index)
+{
+    assert(index == 0);
+    return 14;
+}
 
 static void reconfigure_devices(PC87312State *s)
 {
@@ -277,14 +289,11 @@ static void pc87312_reset(DeviceState *d)
 static void pc87312_realize(DeviceState *dev, Error **errp)
 {
     PC87312State *s;
-    DeviceState *d;
     ISADevice *isa;
-    ISABus *bus;
     Error *local_err = NULL;
 
     s = PC87312(dev);
     isa = ISA_DEVICE(dev);
-    bus = isa_bus_from_device(isa);
     isa_register_ioport(isa, &s->io, s->iobase);
     pc87312_hard_reset(s);
 
@@ -293,17 +302,6 @@ static void pc87312_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
-
-    if (is_ide_enabled(s)) {
-        isa = isa_create(bus, "isa-ide");
-        d = DEVICE(isa);
-        qdev_prop_set_uint32(d, "iobase", get_ide_iobase(s));
-        qdev_prop_set_uint32(d, "iobase2", get_ide_iobase(s) + 0x206);
-        qdev_prop_set_uint32(d, "irq", 14);
-        qdev_init_nofail(d);
-        s->ide.dev = isa;
-        trace_pc87312_info_ide(get_ide_iobase(s));
-    }
 }
 
 static void pc87312_initfn(Object *obj)
@@ -361,6 +359,12 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
         .get_iobase = get_fdc_iobase,
         .get_irq    = get_fdc_irq,
     };
+    sc->ide = (ISASuperIOFuncs){
+        .count = 1,
+        .is_enabled = is_ide_enabled,
+        .get_iobase = get_ide_iobase,
+        .get_irq    = get_ide_irq,
+    };
 }
 
 static const TypeInfo pc87312_type_info = {
diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index 8d9900882f..80ac6175d6 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -4,8 +4,8 @@
 superio_create_parallel(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x, irq %u"
 superio_create_serial(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x, irq %u"
 superio_create_floppy(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x, irq %u"
+superio_create_ide(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x, irq %u"
 
 # hw/isa/pc87312.c
 pc87312_io_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 pc87312_io_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
-pc87312_info_ide(uint32_t base) "base 0x%x"
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index 2fc33bf3d3..3dd5448f8c 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -31,6 +31,7 @@ typedef struct ISASuperIODevice {
     ISADevice *serial[MAX_SERIAL_PORTS];
     ISADevice *floppy;
     ISADevice *kbc;
+    ISADevice *ide;
 } ISASuperIODevice;
 
 typedef struct ISASuperIOFuncs {
@@ -50,6 +51,7 @@ typedef struct ISASuperIOClass {
     ISASuperIOFuncs parallel;
     ISASuperIOFuncs serial;
     ISASuperIOFuncs floppy;
+    ISASuperIOFuncs ide;
 } ISASuperIOClass;
 
 #endif /* HW_ISA_SUPERIO_H */
-- 
2.14.3
