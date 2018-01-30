Received: from eggs.gnu.org ([2001:4830:134:3::10]:58188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1egQp6-0003fT-Al
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 02:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1egQp1-0001IH-Ma
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 02:59:20 -0500
From: David Engraf <david.engraf@sysgo.com>
Date: Tue, 30 Jan 2018 08:58:47 +0100
Message-Id: <20180130075847.6023-1-david.engraf@sysgo.com>
Subject: [Qemu-devel] [PATCH] PPC: e500: Fix duplicate kernel load and
 device tree overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Engraf <david.engraf@sysgo.com>

This patch fixes an incorrect behavior when the -kernel argument has been
specified without -bios. In this case the kernel was loaded twice. At address
32M as a raw image and afterwards by load_elf/load_uimage at the
corresponding load address. In this case the region for the device tree and
the raw kernel image may overlap.

The patch fixes the behavior by loading the kernel image once with
load_elf/load_uimage and skips loading the raw image. It also ensures that
the device tree is generated behind bios/kernel/initrd.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 hw/ppc/e500.c | 89 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index c4fe06ea2a..0321bd66a8 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -776,7 +776,6 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     PCIBus *pci_bus;
     CPUPPCState *env = NULL;
-    uint64_t loadaddr;
     hwaddr kernel_base = -1LL;
     int kernel_size = 0;
     hwaddr dt_base = 0;
@@ -913,11 +912,6 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     /* Register spinning region */
     sysbus_create_simple("e500-spin", params->spin_base, NULL);
 
-    if (cur_base < (32 * 1024 * 1024)) {
-        /* u-boot occupies memory up to 32MB, so load blobs above */
-        cur_base = (32 * 1024 * 1024);
-    }
-
     if (params->has_mpc8xxx_gpio) {
         qemu_irq poweroff_irq;
 
@@ -952,36 +946,6 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
                                     sysbus_mmio_get_region(s, 0));
     }
 
-    /* Load kernel. */
-    if (machine->kernel_filename) {
-        kernel_base = cur_base;
-        kernel_size = load_image_targphys(machine->kernel_filename,
-                                          cur_base,
-                                          ram_size - cur_base);
-        if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    machine->kernel_filename);
-            exit(1);
-        }
-
-        cur_base += kernel_size;
-    }
-
-    /* Load initrd. */
-    if (machine->initrd_filename) {
-        initrd_base = (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
-        initrd_size = load_image_targphys(machine->initrd_filename, initrd_base,
-                                          ram_size - initrd_base);
-
-        if (initrd_size < 0) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
-                    machine->initrd_filename);
-            exit(1);
-        }
-
-        cur_base = initrd_base + initrd_size;
-    }
-
     /*
      * Smart firmware defaults ahead!
      *
@@ -1006,24 +970,67 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
 
-    bios_size = load_elf(filename, NULL, NULL, &bios_entry, &loadaddr, NULL,
+    bios_size = load_elf(filename, NULL, NULL, &bios_entry, &cur_base, NULL,
                          1, PPC_ELF_MACHINE, 0, 0);
     if (bios_size < 0) {
         /*
          * Hrm. No ELF image? Try a uImage, maybe someone is giving us an
          * ePAPR compliant kernel
          */
-        kernel_size = load_uimage(filename, &bios_entry, &loadaddr, NULL,
-                                  NULL, NULL);
-        if (kernel_size < 0) {
+        bios_size = load_uimage(filename, &bios_entry, &cur_base, NULL,
+                                NULL, NULL);
+        if (bios_size < 0) {
             fprintf(stderr, "qemu: could not load firmware '%s'\n", filename);
             exit(1);
         }
     }
+    cur_base += bios_size;
     g_free(filename);
 
+    /* Load bare kernel only if no bios/u-boot has been provided */
+    if (machine->kernel_filename != bios_name) {
+        kernel_base = cur_base;
+        kernel_size = load_image_targphys(machine->kernel_filename,
+                                          cur_base,
+                                          ram_size - cur_base);
+        if (kernel_size < 0) {
+            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+                    machine->kernel_filename);
+            exit(1);
+        }
+
+        cur_base += kernel_size;
+    } else {
+        kernel_base = cur_base;
+        kernel_size = bios_size;
+    }
+
+    if (cur_base < (32 * 1024 * 1024)) {
+        /* u-boot occupies memory up to 32MB, so load blobs above */
+        cur_base = (32 * 1024 * 1024);
+    }
+
+    /* Load initrd. */
+    if (machine->initrd_filename) {
+        initrd_base = (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
+        initrd_size = load_image_targphys(machine->initrd_filename, initrd_base,
+                                          ram_size - initrd_base);
+
+        if (initrd_size < 0) {
+            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
+                    machine->initrd_filename);
+            exit(1);
+        }
+
+        cur_base = initrd_base + initrd_size;
+    }
+
     /* Reserve space for dtb */
-    dt_base = (loadaddr + bios_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
+    dt_base = (cur_base + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
+    if (dt_base + DTB_MAX_SIZE > ram_size) {
+            fprintf(stderr, "qemu: not enough memory for device tree\n");
+            exit(1);
+    }
 
     dt_size = ppce500_prep_device_tree(machine, params, dt_base,
                                        initrd_base, initrd_size,
-- 
2.14.1
