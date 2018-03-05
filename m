Received: from eggs.gnu.org ([2001:4830:134:3::10]:49419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWY-0004T3-Cn
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWX-0001e4-1T
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:19:58 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 18:19:17 -0300
Message-Id: <20180305211928.466-12-f4bug@amsat.org>
In-Reply-To: <20180305211928.466-1-f4bug@amsat.org>
References: <20180305211928.466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 11/22] hw/isa/superio: Factor out the
 floppy disc controller code from pc87312.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "open list:PReP" <qemu-ppc@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/pc87312.h |  4 ----
 include/hw/isa/superio.h |  2 ++
 hw/isa/isa-superio.c     | 36 ++++++++++++++++++++++++++++++++++++
 hw/isa/pc87312.c         | 46 +++++++++++++++++++---------------------------
 hw/isa/trace-events      |  2 +-
 5 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
index 1480615a2c..e16263d4b1 100644
--- a/include/hw/isa/pc87312.h
+++ b/include/hw/isa/pc87312.h
@@ -39,10 +39,6 @@ typedef struct PC87312State {
     uint16_t iobase;
     uint8_t config; /* initial configuration */
 
-    struct {
-        ISADevice *dev;
-    } fdc;
-
     struct {
         ISADevice *dev;
     } ide;
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index 0b516721c3..e8007b9eee 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -29,6 +29,7 @@ typedef struct ISASuperIODevice {
 
     ISADevice *parallel[MAX_PARALLEL_PORTS];
     ISADevice *serial[MAX_SERIAL_PORTS];
+    ISADevice *floppy;
 } ISASuperIODevice;
 
 typedef struct ISASuperIOFuncs {
@@ -47,6 +48,7 @@ typedef struct ISASuperIOClass {
 
     ISASuperIOFuncs parallel;
     ISASuperIOFuncs serial;
+    ISASuperIOFuncs floppy;
 } ISASuperIOClass;
 
 #endif /* HW_ISA_SUPERIO_H */
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index bd4671655e..22bf79d3c3 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -11,7 +11,10 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/blockdev.h"
 #include "chardev/char.h"
 #include "hw/isa/superio.h"
 #include "hw/char/serial.h"
@@ -25,6 +28,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
     ISADevice *isa;
     DeviceState *d;
     Chardev *chr;
+    DriveInfo *drive;
     char *name;
     int i;
 
@@ -103,6 +107,38 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             g_free(name);
         }
     }
+
+    /* Floppy disc */
+    if (!k->floppy.is_enabled || k->floppy.is_enabled(sio, 0)) {
+        isa = isa_create(bus, "isa-fdc");
+        d = DEVICE(isa);
+        if (k->floppy.get_iobase) {
+            qdev_prop_set_uint32(d, "iobase", k->floppy.get_iobase(sio, 0));
+        }
+        if (k->floppy.get_irq) {
+            qdev_prop_set_uint32(d, "irq", k->floppy.get_irq(sio, 0));
+        }
+        /* FIXME use a qdev drive property instead of drive_get() */
+        drive = drive_get(IF_FLOPPY, 0, 0);
+        if (drive != NULL) {
+            qdev_prop_set_drive(d, "driveA", blk_by_legacy_dinfo(drive),
+                                &error_fatal);
+        }
+        /* FIXME use a qdev drive property instead of drive_get() */
+        drive = drive_get(IF_FLOPPY, 0, 1);
+        if (drive != NULL) {
+            qdev_prop_set_drive(d, "driveB", blk_by_legacy_dinfo(drive),
+                                &error_fatal);
+        }
+        qdev_init_nofail(d);
+        sio->floppy = isa;
+        trace_superio_create_floppy(0,
+                                    k->floppy.get_iobase ?
+                                    k->floppy.get_iobase(sio, 0) : -1,
+                                    k->floppy.get_irq ?
+                                    k->floppy.get_irq(sio, 0) : -1);
+    }
+
 }
 
 static void isa_superio_class_init(ObjectClass *oc, void *data)
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index c2837bca43..a1845a91c3 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -27,8 +27,6 @@
 #include "hw/isa/pc87312.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
 #include "trace.h"
 
 
@@ -129,16 +127,26 @@ static bool is_uart_enabled(ISASuperIODevice *sio, uint8_t i)
 
 /* Floppy controller */
 
-static inline bool is_fdc_enabled(PC87312State *s)
+static bool is_fdc_enabled(ISASuperIODevice *sio, uint8_t index)
 {
+    PC87312State *s = PC87312(sio);
+    assert(!index);
     return s->regs[REG_FER] & FER_FDC_EN;
 }
 
-static inline uint16_t get_fdc_iobase(PC87312State *s)
+static uint16_t get_fdc_iobase(ISASuperIODevice *sio, uint8_t index)
 {
+    PC87312State *s = PC87312(sio);
+    assert(!index);
     return (s->regs[REG_FER] & FER_FDC_ADDR) ? 0x370 : 0x3f0;
 }
 
+static unsigned int get_fdc_irq(ISASuperIODevice *sio, uint8_t index)
+{
+    assert(!index);
+    return 6;
+}
+
 
 /* IDE controller */
 
@@ -272,7 +280,6 @@ static void pc87312_realize(DeviceState *dev, Error **errp)
     DeviceState *d;
     ISADevice *isa;
     ISABus *bus;
-    DriveInfo *drive;
     Error *local_err = NULL;
 
     s = PC87312(dev);
@@ -287,28 +294,6 @@ static void pc87312_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (is_fdc_enabled(s)) {
-        isa = isa_create(bus, "isa-fdc");
-        d = DEVICE(isa);
-        qdev_prop_set_uint32(d, "iobase", get_fdc_iobase(s));
-        qdev_prop_set_uint32(d, "irq", 6);
-        /* FIXME use a qdev drive property instead of drive_get() */
-        drive = drive_get(IF_FLOPPY, 0, 0);
-        if (drive != NULL) {
-            qdev_prop_set_drive(d, "driveA", blk_by_legacy_dinfo(drive),
-                                &error_fatal);
-        }
-        /* FIXME use a qdev drive property instead of drive_get() */
-        drive = drive_get(IF_FLOPPY, 0, 1);
-        if (drive != NULL) {
-            qdev_prop_set_drive(d, "driveB", blk_by_legacy_dinfo(drive),
-                                &error_fatal);
-        }
-        qdev_init_nofail(d);
-        s->fdc.dev = isa;
-        trace_pc87312_info_floppy(get_fdc_iobase(s));
-    }
-
     if (is_ide_enabled(s)) {
         isa = isa_create(bus, "isa-ide");
         d = DEVICE(isa);
@@ -370,6 +355,12 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
         .get_iobase = get_uart_iobase,
         .get_irq    = get_uart_irq,
     };
+    sc->floppy = (ISASuperIOFuncs){
+        .count = 1,
+        .is_enabled = is_fdc_enabled,
+        .get_iobase = get_fdc_iobase,
+        .get_irq    = get_fdc_irq,
+    };
 }
 
 static const TypeInfo pc87312_type_info = {
@@ -378,6 +369,7 @@ static const TypeInfo pc87312_type_info = {
     .instance_size = sizeof(PC87312State),
     .instance_init = pc87312_initfn,
     .class_init    = pc87312_class_init,
+    /* FIXME use a qdev drive property instead of drive_get() */
 };
 
 static void pc87312_register_types(void)
diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index c78dd6c353..8d9900882f 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -3,9 +3,9 @@
 # hw/isa/isa-superio.c
 superio_create_parallel(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x, irq %u"
 superio_create_serial(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x, irq %u"
+superio_create_floppy(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x, irq %u"
 
 # hw/isa/pc87312.c
 pc87312_io_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 pc87312_io_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
-pc87312_info_floppy(uint32_t base) "base 0x%x"
 pc87312_info_ide(uint32_t base) "base 0x%x"
-- 
2.16.2
