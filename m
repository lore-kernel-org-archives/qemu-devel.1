Received: from eggs.gnu.org ([2001:4830:134:3::10]:33943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1emFyA-0006CR-EK
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1emFy5-0006XA-MS
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:36:46 -0500
From: David Engraf <david.engraf@sysgo.com>
Date: Thu, 15 Feb 2018 10:36:00 +0100
Message-Id: <20180215093600.18505-1-david.engraf@sysgo.com>
In-Reply-To: <20180213102258.26145-1-david.engraf@sysgo.com>
References: <20180213102258.26145-1-david.engraf@sysgo.com>
Subject: [Qemu-devel] [PATCH v3] PPC: e500: Fix duplicate kernel load and
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
load_elf/load_uimage and skips loading the raw image.

When here do not use bios_name/size for the kernel and use a more generic
name called payload_name/size.

New in v3: dtb must be stored between kernel and initrd because Linux can
           handle the dtb only within the first 64MB. Add a comment to
           clarify the behavior.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 hw/ppc/e500.c | 116 +++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 70 insertions(+), 46 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index c4fe06ea2a..414c4beaab 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -784,8 +784,10 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     int initrd_size = 0;
     hwaddr cur_base = 0;
     char *filename;
+    const char *payload_name;
+    bool kernel_as_payload;
     hwaddr bios_entry = 0;
-    target_long bios_size;
+    target_long payload_size;
     struct boot_info *boot_info;
     int dt_size;
     int i;
@@ -913,11 +915,6 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     /* Register spinning region */
     sysbus_create_simple("e500-spin", params->spin_base, NULL);
 
-    if (cur_base < (32 * 1024 * 1024)) {
-        /* u-boot occupies memory up to 32MB, so load blobs above */
-        cur_base = (32 * 1024 * 1024);
-    }
-
     if (params->has_mpc8xxx_gpio) {
         qemu_irq poweroff_irq;
 
@@ -952,8 +949,61 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
                                     sysbus_mmio_get_region(s, 0));
     }
 
-    /* Load kernel. */
-    if (machine->kernel_filename) {
+    /*
+     * Smart firmware defaults ahead!
+     *
+     * We follow the following table to select which payload we execute.
+     *
+     *  -kernel | -bios | payload
+     * ---------+-------+---------
+     *     N    |   Y   | u-boot
+     *     N    |   N   | u-boot
+     *     Y    |   Y   | u-boot
+     *     Y    |   N   | kernel
+     *
+     * This ensures backwards compatibility with how we used to expose
+     * -kernel to users but allows them to run through u-boot as well.
+     */
+    kernel_as_payload = false;
+    if (bios_name == NULL) {
+        if (machine->kernel_filename) {
+            payload_name = machine->kernel_filename;
+            kernel_as_payload = true;
+        } else {
+            payload_name = "u-boot.e500";
+        }
+    } else {
+        payload_name = bios_name;
+    }
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
+
+    payload_size = load_elf(filename, NULL, NULL, &bios_entry, &loadaddr, NULL,
+                            1, PPC_ELF_MACHINE, 0, 0);
+    if (payload_size < 0) {
+        /*
+         * Hrm. No ELF image? Try a uImage, maybe someone is giving us an
+         * ePAPR compliant kernel
+         */
+        payload_size = load_uimage(filename, &bios_entry, &loadaddr, NULL,
+                                   NULL, NULL);
+        if (payload_size < 0) {
+            fprintf(stderr, "qemu: could not load firmware '%s'\n", filename);
+            exit(1);
+        }
+    }
+
+    g_free(filename);
+
+    if (kernel_as_payload) {
+        kernel_base = loadaddr;
+        kernel_size = payload_size;
+    }
+
+    cur_base = loadaddr + payload_size;
+
+    /* Load bare kernel only if no bios/u-boot has been provided */
+    if (machine->kernel_filename && !kernel_as_payload) {
         kernel_base = cur_base;
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           cur_base,
@@ -967,6 +1017,11 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         cur_base += kernel_size;
     }
 
+    if (cur_base < (32 * 1024 * 1024)) {
+        /* u-boot occupies memory up to 32MB, so load blobs above */
+        cur_base = (32 * 1024 * 1024);
+    }
+
     /* Load initrd. */
     if (machine->initrd_filename) {
         initrd_base = (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
@@ -983,47 +1038,16 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     }
 
     /*
-     * Smart firmware defaults ahead!
-     *
-     * We follow the following table to select which payload we execute.
-     *
-     *  -kernel | -bios | payload
-     * ---------+-------+---------
-     *     N    |   Y   | u-boot
-     *     N    |   N   | u-boot
-     *     Y    |   Y   | u-boot
-     *     Y    |   N   | kernel
-     *
-     * This ensures backwards compatibility with how we used to expose
-     * -kernel to users but allows them to run through u-boot as well.
+     * Reserve space for dtb behind the kernel image because Linux has a bug
+     * where it can only handle the dtb if it's within the first 64MB of where
+     * <kernel> starts. dtb cannot not reach initrd_base because INITRD_LOAD_PAD
+     * ensures enough space between kernel and initrd.
      */
-    if (bios_name == NULL) {
-        if (machine->kernel_filename) {
-            bios_name = machine->kernel_filename;
-        } else {
-            bios_name = "u-boot.e500";
-        }
-    }
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-
-    bios_size = load_elf(filename, NULL, NULL, &bios_entry, &loadaddr, NULL,
-                         1, PPC_ELF_MACHINE, 0, 0);
-    if (bios_size < 0) {
-        /*
-         * Hrm. No ELF image? Try a uImage, maybe someone is giving us an
-         * ePAPR compliant kernel
-         */
-        kernel_size = load_uimage(filename, &bios_entry, &loadaddr, NULL,
-                                  NULL, NULL);
-        if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load firmware '%s'\n", filename);
+    dt_base = (loadaddr + payload_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
+    if (dt_base + DTB_MAX_SIZE > ram_size) {
+            fprintf(stderr, "qemu: not enough memory for device tree\n");
             exit(1);
-        }
     }
-    g_free(filename);
-
-    /* Reserve space for dtb */
-    dt_base = (loadaddr + bios_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
 
     dt_size = ppce500_prep_device_tree(machine, params, dt_base,
                                        initrd_base, initrd_size,
-- 
2.14.1
