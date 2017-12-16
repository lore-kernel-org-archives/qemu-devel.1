Received: from eggs.gnu.org ([2001:4830:134:3::10]:53177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N1-0004jA-KX
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N0-000256-4r
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:59 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:58846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eQ8Mz-00023c-Rb
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:58 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 16 Dec 2017 10:02:24 +0100
Message-Id: <20171216090228.28505-12-hpoussin@reactos.org>
In-Reply-To: <20171216090228.28505-1-hpoussin@reactos.org>
References: <20171216090228.28505-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/15] piix4: add a floppy controller,
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
Also, always create a parallel port in Malta board, as requested by PIIX4.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c       | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/mips/mips_malta.c | 32 ++++++++++++++++++++----------
 2 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index cf134b01ee..bc13169a00 100644
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
@@ -168,10 +176,57 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
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
+    /* serial ports (ignore errors) */
+    for (i = 0; i < 2; i++) {
+        qdev_set_parent_bus(DEVICE(&s->serial[i]), BUS(isa_bus));
+        object_property_set_bool(OBJECT(&s->serial[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
+    /* parallel port (ignore errors) */
+    qdev_set_parent_bus(DEVICE(&s->parallel), BUS(isa_bus));
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
@@ -195,6 +250,7 @@ static const TypeInfo piix4_info = {
     .name          = TYPE_PIIX4_PCI_DEVICE,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PIIX4State),
+    .instance_init = piix4_init,
     .class_init    = piix4_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 78049ccf86..d3db2b503e 100644
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
@@ -1026,6 +1026,9 @@ void mips_malta_init(MachineState *machine)
             serial_hds[i] = qemu_chr_new(label, "null");
         }
     }
+    if (!parallel_hds[0]) {
+        parallel_hds[0] = qemu_chr_new("parallel", "null");
+    }
 
     /* create CPU */
     mips_create_cpu(s, machine->cpu_type, &cbus_irq, &i8259_irq);
@@ -1184,9 +1187,25 @@ void mips_malta_init(MachineState *machine)
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
 
@@ -1204,13 +1223,6 @@ void mips_malta_init(MachineState *machine)
     g_free(smbus_eeprom_buf);
 
     rtc_init(isa_bus, 2000, NULL);
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
