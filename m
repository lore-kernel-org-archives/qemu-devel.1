Received: from eggs.gnu.org ([2001:4830:134:3::10]:39218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg6-0000Cc-2D
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg4-0006Fg-Rn
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:30 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:38319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eUvg4-0006F6-Ho
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:28 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Fri, 29 Dec 2017 15:29:17 +0100
Message-Id: <20171229142922.31701-12-hpoussin@reactos.org>
In-Reply-To: <20171229142922.31701-1-hpoussin@reactos.org>
References: <20171229142922.31701-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/16] piix4: add a floppy controller,
 1 parallel port and 2 serial ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Remove their instanciation from malta board, to not have them twice.
Automatically create serial/parallel ports in PIIX4 if not provided.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/mips/mips_malta.c | 41 +++++++++++++++++---------------
 2 files changed, 89 insertions(+), 19 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index c5639f7640..f672af21cd 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -28,8 +28,10 @@
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
+#include "hw/char/isa.h"
 #include "hw/sysbus.h"
 #include "hw/timer/i8254.h"
+#include "qapi/error.h"
 
 PCIDevice *piix4_dev;
 
@@ -38,6 +40,10 @@ typedef struct PIIX4State {
     qemu_irq cpu_intr;
     qemu_irq *isa;
 
+    FDCtrlISABus floppy;
+    ISASerialState serial[2];
+    ISAParallelState parallel;
+
     /* Reset Control Register */
     MemoryRegion rcr_mem;
     uint8_t rcr;
@@ -137,6 +143,8 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
     PIIX4State *s = DO_UPCAST(PIIX4State, dev, pci);
     ISABus *isa_bus;
     qemu_irq *i8259_out_irq;
+    int i;
+    Error *err = NULL;
 
     isa_bus = isa_bus_new(dev, pci_address_space(pci),
                           pci_address_space_io(pci), errp);
@@ -168,10 +176,68 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
     /* Super I/O */
     isa_create_simple(isa_bus, "i8042");
 
+    /* floppy */
+    qdev_set_parent_bus(DEVICE(&s->floppy), BUS(isa_bus));
+    object_property_set_bool(OBJECT(&s->floppy), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* serial ports */
+    for (i = 0; i < 2; i++) {
+        qdev_set_parent_bus(DEVICE(&s->serial[i]), BUS(isa_bus));
+        if (!qemu_chr_fe_backend_connected(&s->serial[i].state.chr)) {
+            char prop[] = "serial?";
+            char label[] = "piix4.serial?";
+            prop[6] = i + '0';
+            label[12] = i + '0';
+            qdev_prop_set_chr(dev, prop, qemu_chr_new(label, "null"));
+        }
+        object_property_set_bool(OBJECT(&s->serial[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
+    /* parallel port */
+    qdev_set_parent_bus(DEVICE(&s->parallel), BUS(isa_bus));
+    if (!qemu_chr_fe_backend_connected(&s->parallel.state.chr)) {
+        qdev_prop_set_chr(dev, "parallel",
+                          qemu_chr_new("pii4x.parallel", "null"));
+    }
+    object_property_set_bool(OBJECT(&s->parallel), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
     piix4_dev = pci;
     qemu_register_reset(piix4_reset, s);
 }
 
+static void piix4_init(Object *obj)
+{
+    PIIX4State *s = PIIX4_PCI_DEVICE(obj);
+    int i;
+
+    object_initialize(&s->floppy, sizeof(s->floppy), TYPE_ISA_FDC);
+    for (i = 0; i < 2; i++) {
+        object_initialize(&s->serial[i], sizeof(s->serial[i]), TYPE_ISA_SERIAL);
+    }
+    object_initialize(&s->parallel, sizeof(s->parallel), TYPE_ISA_PARALLEL);
+
+    object_property_add_alias(obj, "floppy", OBJECT(&s->floppy), "driveA",
+                              &error_abort);
+    object_property_add_alias(obj, "serial0", OBJECT(&s->serial[0]), "chardev",
+                              &error_abort);
+    object_property_add_alias(obj, "serial1", OBJECT(&s->serial[1]), "chardev",
+                              &error_abort);
+    object_property_add_alias(obj, "parallel", OBJECT(&s->parallel), "chardev",
+                              &error_abort);
+}
+
 static void piix4_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -195,6 +261,7 @@ static const TypeInfo piix4_info = {
     .name          = TYPE_PIIX4_PCI_DEVICE,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PIIX4State),
+    .instance_init = piix4_init,
     .class_init    = piix4_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 7498fad006..30fb30fc0e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1003,7 +1003,7 @@ void mips_malta_init(MachineState *machine)
     int i;
     DriveInfo *dinfo;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    DriveInfo *fd[MAX_FD];
+    DriveInfo *fd;
     int fl_idx = 0;
     int fl_sectors = bios_size >> 16;
     int be;
@@ -1018,15 +1018,6 @@ void mips_malta_init(MachineState *machine)
 
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
 
@@ -1069,6 +1060,9 @@ void mips_malta_init(MachineState *machine)
 #endif
     /* FPGA */
     /* The CBUS UART is attached to the MIPS CPU INT2 pin, ie interrupt 4 */
+    if (!serial_hds[2]) {
+        serial_hds[2] = qemu_chr_new("serial2", "null");
+    }
     malta_fpga_init(system_memory, FPGA_ADDRESS, cbus_irq, serial_hds[2]);
 
     /* Load firmware in flash / BIOS. */
@@ -1184,9 +1178,25 @@ void mips_malta_init(MachineState *machine)
     /* Southbridge */
     ide_drive_get(hd, ARRAY_SIZE(hd));
 
-    pci = pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
-                                          true, "PIIX4");
+    pci = pci_create_multifunction(pci_bus, PCI_DEVFN(10, 0),
+                                   true, "PIIX4");
     dev = DEVICE(pci);
+
+    /* Floppy */
+    fd = drive_get(IF_FLOPPY, 0, 0);
+    if (fd) {
+        qdev_prop_set_drive(dev, "floppy", blk_by_legacy_dinfo(fd),
+                            &error_fatal);
+    }
+
+    /* Serial ports */
+    qdev_prop_set_chr(dev, "serial0", serial_hds[0]);
+    qdev_prop_set_chr(dev, "serial1", serial_hds[1]);
+
+    /* Parallel port */
+    qdev_prop_set_chr(dev, "parallel", parallel_hds[0]);
+
+    qdev_init_nofail(dev);
     isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
     piix4_devfn = pci->devfn;
 
@@ -1205,13 +1215,6 @@ void mips_malta_init(MachineState *machine)
 
     /* Super I/O */
     mc146818_rtc_init(isa_bus, 2000, NULL);
-    serial_hds_isa_init(isa_bus, 0, 2);
-    parallel_hds_isa_init(isa_bus, 1);
-
-    for(i = 0; i < MAX_FD; i++) {
-        fd[i] = drive_get(IF_FLOPPY, 0, i);
-    }
-    fdctrl_init_isa(isa_bus, fd);
 
     /* Network card */
     network_init(pci_bus);
-- 
2.11.0
