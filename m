Received: from eggs.gnu.org ([2001:4830:134:3::10]:60479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyGK9-0000hy-IR
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyGK7-0007fZ-UU
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:57:21 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Sep 2018 13:56:52 +0100
Message-Id: <20180907125653.5010-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
References: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 2/3] scsi: move lsi53c8xx_create() callers
 to lsi53c8xx_handle_legacy_cmdline()
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
and/or changing the PCI configuration. By switching over to using the new
lsi53c8xx_handle_legacy_cmdline() function then the caller can now configure
and realize the LSI SCSI device exactly as required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/arm/realview.c    | 3 ++-
 hw/arm/versatilepb.c | 3 ++-
 hw/hppa/machine.c    | 4 +++-
 hw/ppc/prep.c        | 4 +++-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index ab8c14fde3..242f5a87b6 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -257,7 +257,8 @@ static void realview_init(MachineState *machine,
         }
         n = drive_get_max_bus(IF_SCSI);
         while (n >= 0) {
-            lsi53c895a_create(pci_bus);
+            dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+            lsi53c8xx_handle_legacy_cmdline(dev);
             n--;
         }
     }
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 8b74857059..22b09a1e61 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -278,7 +278,8 @@ static void versatile_init(MachineState *machine, int board_id)
     }
     n = drive_get_max_bus(IF_SCSI);
     while (n >= 0) {
-        lsi53c895a_create(pci_bus);
+        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+        lsi53c8xx_handle_legacy_cmdline(dev);
         n--;
     }
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cf7c61c6cc..0fb8fb877e 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -59,6 +59,7 @@ static void machine_hppa_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
+    DeviceState *dev;
     PCIBus *pci_bus;
     ISABus *isa_bus;
     qemu_irq rtc_irq, serial_irq;
@@ -115,7 +116,8 @@ static void machine_hppa_init(MachineState *machine)
     }
 
     /* SCSI disk setup. */
-    lsi53c895a_create(pci_bus);
+    dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
+    lsi53c8xx_handle_legacy_cmdline(dev);
 
     /* Network setup.  e1000 is good enough, failing Tulip support.  */
     for (i = 0; i < nb_nics; i++) {
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 162b27a3b8..b0ea20416e 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -702,7 +702,9 @@ static void ibm_40p_init(MachineState *machine)
         qdev_prop_set_uint32(dev, "equipment", 0xc0);
         qdev_init_nofail(dev);
 
-        lsi53c810_create(pci_bus, PCI_DEVFN(1, 0));
+        dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
+                                       "lsi53c810"));
+        lsi53c8xx_handle_legacy_cmdline(dev);
 
         /* XXX: s3-trio at PCI_DEVFN(2, 0) */
         pci_vga_init(pci_bus);
-- 
2.11.0
