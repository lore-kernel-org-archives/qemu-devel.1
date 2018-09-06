Received: from eggs.gnu.org ([2001:4830:134:3::10]:41406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxnIn-0008Ep-Dg
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxnIl-0008Rr-RA
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:58:01 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  6 Sep 2018 06:57:35 +0100
Message-Id: <20180906055736.20256-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
References: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/3] scsi: move lsi53c895a_create() and
 lsi53c810_create() callers to pci_create_simple()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com, hpoussin@reactos.org, rth@twiddle.net, peter.maydell@linaro.org, thuth@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

As part of commits a64aa5785d "hw: Deprecate -drive if=scsi with non-onboard
HBAs" and b891538e81 "hw/ppc/prep: Fix implicit creation of "-drive if=scsi"
devices" the lsi53c895a_create() and lsi53c810_create() functions were added
to wrap pci_create_simple() and scsi_bus_legacy_handle_cmdline().

Unfortunately this prevents us from changing qdev properties on the device
and/or changing the PCI configuration. Now that we have a separate header file
for these devices it is possible to return the LSI objects themselves, which
enables us to both modify the LSI device configuration as required and also
move the invocation of scsi_bus_legacy_handle_cmdline() to the caller as done
elsewhere.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/arm/realview.c    | 5 ++++-
 hw/arm/versatilepb.c | 5 ++++-
 hw/hppa/machine.c    | 5 ++++-
 hw/ppc/prep.c        | 6 +++++-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index ab8c14fde3..75168afd4d 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -16,6 +16,7 @@
 #include "hw/arm/primecell.h"
 #include "hw/devices.h"
 #include "hw/pci/pci.h"
+#include "hw/scsi/lsi53c895a.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -63,6 +64,7 @@ static void realview_init(MachineState *machine,
     MemoryRegion *ram_hack = g_new(MemoryRegion, 1);
     DeviceState *dev, *sysctl, *gpio2, *pl041;
     SysBusDevice *busdev;
+    LSIState *lsi;
     qemu_irq pic[64];
     qemu_irq mmc_irq[2];
     PCIBus *pci_bus = NULL;
@@ -257,7 +259,8 @@ static void realview_init(MachineState *machine,
         }
         n = drive_get_max_bus(IF_SCSI);
         while (n >= 0) {
-            lsi53c895a_create(pci_bus);
+            lsi = LSI53C895A(pci_create_simple(pci_bus, -1, TYPE_LSI53C895A));
+            scsi_bus_legacy_handle_cmdline(&lsi->bus);
             n--;
         }
     }
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 8b74857059..dd9962037e 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -19,6 +19,7 @@
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
 #include "hw/boards.h"
+#include "hw/scsi/lsi53c895a.h"
 #include "exec/address-spaces.h"
 #include "hw/block/flash.h"
 #include "qemu/error-report.h"
@@ -189,6 +190,7 @@ static void versatile_init(MachineState *machine, int board_id)
     DeviceState *dev, *sysctl;
     SysBusDevice *busdev;
     DeviceState *pl041;
+    LSIState *lsi;
     PCIBus *pci_bus;
     NICInfo *nd;
     I2CBus *i2c;
@@ -278,7 +280,8 @@ static void versatile_init(MachineState *machine, int board_id)
     }
     n = drive_get_max_bus(IF_SCSI);
     while (n >= 0) {
-        lsi53c895a_create(pci_bus);
+        lsi = LSI53C895A(pci_create_simple(pci_bus, -1, TYPE_LSI53C895A));
+        scsi_bus_legacy_handle_cmdline(&lsi->bus);
         n--;
     }
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cf7c61c6cc..ddd8ee45e4 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -16,6 +16,7 @@
 #include "hw/ide.h"
 #include "hw/timer/i8254.h"
 #include "hw/char/serial.h"
+#include "hw/scsi/lsi53c895a.h"
 #include "hppa_sys.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -61,6 +62,7 @@ static void machine_hppa_init(MachineState *machine)
     const char *initrd_filename = machine->initrd_filename;
     PCIBus *pci_bus;
     ISABus *isa_bus;
+    LSIState *lsi;
     qemu_irq rtc_irq, serial_irq;
     char *firmware_filename;
     uint64_t firmware_low, firmware_high;
@@ -115,7 +117,8 @@ static void machine_hppa_init(MachineState *machine)
     }
 
     /* SCSI disk setup. */
-    lsi53c895a_create(pci_bus);
+    lsi = LSI53C895A(pci_create_simple(pci_bus, -1, TYPE_LSI53C895A));
+    scsi_bus_legacy_handle_cmdline(&lsi->bus);
 
     /* Network setup.  e1000 is good enough, failing Tulip support.  */
     for (i = 0; i < nb_nics; i++) {
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 162b27a3b8..fcb2a41846 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -44,6 +44,7 @@
 #include "hw/input/i8042.h"
 #include "hw/isa/pc87312.h"
 #include "hw/net/ne2000-isa.h"
+#include "hw/scsi/lsi53c895a.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
@@ -623,6 +624,7 @@ static void ibm_40p_init(MachineState *machine)
     DeviceState *dev;
     SysBusDevice *pcihost, *s;
     Nvram *m48t59 = NULL;
+    LSIState *lsi;
     PCIBus *pci_bus;
     ISABus *isa_bus;
     void *fw_cfg;
@@ -702,7 +704,9 @@ static void ibm_40p_init(MachineState *machine)
         qdev_prop_set_uint32(dev, "equipment", 0xc0);
         qdev_init_nofail(dev);
 
-        lsi53c810_create(pci_bus, PCI_DEVFN(1, 0));
+        lsi = LSI53C810(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
+                                          TYPE_LSI53C810));
+        scsi_bus_legacy_handle_cmdline(&lsi->bus);
 
         /* XXX: s3-trio at PCI_DEVFN(2, 0) */
         pci_vga_init(pci_bus);
-- 
2.11.0
