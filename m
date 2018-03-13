Received: from eggs.gnu.org ([2001:4830:134:3::10]:58361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiP-00063F-64
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiN-0003qq-U1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:17 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiN-0003pT-K2
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:15 -0400
Received: by mail-wm0-x241.google.com with SMTP id 139so880543wmn.2
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:52 +0100
Message-Id: <20180313224719.4954-43-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/69] hw/isa/superio: Factor out the FDC37M817
 Super I/O from mips_malta.c
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
Message-Id: <20180308223946.26784-17-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-superio.c     | 19 +++++++++++++++++++
 hw/mips/mips_malta.c     | 35 ++++++++++-------------------------
 include/hw/isa/superio.h |  2 ++
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index f98711beff..b95608a003 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -187,9 +187,28 @@ static const TypeInfo isa_superio_type_info = {
     .class_init = isa_superio_class_init,
 };
 
+/* SMS FDC37M817 Super I/O */
+static void fdc37m81x_class_init(ObjectClass *klass, void *data)
+{
+    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
+
+    sc->serial.count = 2; /* NS16C550A */
+    sc->parallel.count = 1;
+    sc->floppy.count = 1; /* SMSC 82077AA Compatible */
+    sc->ide.count = 0;
+}
+
+static const TypeInfo fdc37m81x_type_info = {
+    .name          = TYPE_FDC37M81X_SUPERIO,
+    .parent        = TYPE_ISA_SUPERIO,
+    .instance_size = sizeof(ISASuperIODevice),
+    .class_init    = fdc37m81x_class_init,
+};
+
 static void isa_superio_register_types(void)
 {
     type_register_static(&isa_superio_type_info);
+    type_register_static(&fdc37m81x_type_info);
 }
 
 type_init(isa_superio_register_types)
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 9e0724ca5a..f6513a4fd5 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -27,14 +27,12 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/isa/superio.h"
 #include "hw/dma/i8257.h"
 #include "hw/char/serial.h"
-#include "hw/char/parallel.h"
-#include "hw/block/fdc.h"
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/i2c/smbus.h"
-#include "sysemu/block-backend.h"
 #include "hw/block/flash.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
@@ -47,7 +45,6 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/timer/mc146818rtc.h"
-#include "hw/input/i8042.h"
 #include "hw/timer/i8254.h"
 #include "sysemu/blockdev.h"
 #include "exec/address-spaces.h"
@@ -1005,10 +1002,8 @@ void mips_malta_init(MachineState *machine)
     qemu_irq cbus_irq, i8259_irq;
     int piix4_devfn;
     I2CBus *smbus;
-    int i;
     DriveInfo *dinfo;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    DriveInfo *fd[MAX_FD];
     int fl_idx = 0;
     int fl_sectors = bios_size >> 16;
     int be;
@@ -1023,15 +1018,6 @@ void mips_malta_init(MachineState *machine)
 
     qdev_init_nofail(dev);
 
-    /* Make sure the first 3 serial ports are associated with a device. */
-    for(i = 0; i < 3; i++) {
-        if (!serial_hds[i]) {
-            char label[32];
-            snprintf(label, sizeof(label), "serial%d", i);
-            serial_hds[i] = qemu_chr_new(label, "null");
-        }
-    }
-
     /* create CPU */
     mips_create_cpu(s, machine->cpu_type, &cbus_irq, &i8259_irq);
 
@@ -1067,7 +1053,14 @@ void mips_malta_init(MachineState *machine)
 #else
     be = 0;
 #endif
+
     /* FPGA */
+
+    /* Make sure the second serial port is associated with a device. */
+    if (!serial_hds[2]) {
+        serial_hds[2] = qemu_chr_new("fpga-uart", "null");
+    }
+
     /* The CBUS UART is attached to the MIPS CPU INT2 pin, ie interrupt 4 */
     malta_fpga_init(system_memory, FPGA_ADDRESS, cbus_irq, serial_hds[2]);
 
@@ -1214,16 +1207,8 @@ void mips_malta_init(MachineState *machine)
     smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
 
-    /* Super I/O */
-    isa_create_simple(isa_bus, TYPE_I8042);
-
-    serial_hds_isa_init(isa_bus, 0, 2);
-    parallel_hds_isa_init(isa_bus, 1);
-
-    for(i = 0; i < MAX_FD; i++) {
-        fd[i] = drive_get(IF_FLOPPY, 0, i);
-    }
-    fdctrl_init_isa(isa_bus, fd);
+    /* Super I/O: SMS FDC37M817 */
+    isa_create_simple(isa_bus, TYPE_FDC37M81X_SUPERIO);
 
     /* Network card */
     network_init(pci_bus);
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index 3dd5448f8c..b47aac3cf8 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -54,4 +54,6 @@ typedef struct ISASuperIOClass {
     ISASuperIOFuncs ide;
 } ISASuperIOClass;
 
+#define TYPE_FDC37M81X_SUPERIO  "fdc37m81x-superio"
+
 #endif /* HW_ISA_SUPERIO_H */
-- 
2.14.3
