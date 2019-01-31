Received: from eggs.gnu.org ([209.51.188.92]:55441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAQi-0002EF-Gb
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAQh-0008Cf-CT
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:48 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpAQh-0008C4-3w
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:47 -0500
Received: by mail-wr1-x444.google.com with SMTP id t6so2790372wrr.12
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 03:22:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 11:22:37 +0000
Message-Id: <20190131112240.8395-3-peter.maydell@linaro.org>
In-Reply-To: <20190131112240.8395-1-peter.maydell@linaro.org>
References: <20190131112240.8395-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/5] hw/arm/boot: Factor out "direct kernel
 boot" code into its own function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Igor Mammedov <imammedo@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>

Factor out the "direct kernel boot" code path from arm_load_kernel()
into its own function; this function is getting long enough that
the code flow is a bit confusing.

This commit only moves code around; no semantic changes.

We leave the "load the dtb" code in arm_load_kernel() -- this
is currently only used by the "direct kernel boot" path, but
this is a bug which we will fix shortly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 150 +++++++++++++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 70 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 6f9ceeb0e89..108e9b979f8 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -953,9 +953,12 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
     return size;
 }
 
-void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
+static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
+                                         struct arm_boot_info *info)
 {
+    /* Set up for a direct boot of a kernel image file. */
     CPUState *cs;
+    AddressSpace *as = arm_boot_address_space(cpu, info);
     int kernel_size;
     int initrd_size;
     int is_linux = 0;
@@ -963,75 +966,6 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     int elf_machine;
     hwaddr entry;
     static const ARMInsnFixup *primary_loader;
-    AddressSpace *as = arm_boot_address_space(cpu, info);
-
-    /*
-     * CPU objects (unlike devices) are not automatically reset on system
-     * reset, so we must always register a handler to do so. If we're
-     * actually loading a kernel, the handler is also responsible for
-     * arranging that we start it correctly.
-     */
-    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
-        qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
-    }
-
-    /*
-     * The board code is not supposed to set secure_board_setup unless
-     * running its code in secure mode is actually possible, and KVM
-     * doesn't support secure.
-     */
-    assert(!(info->secure_board_setup && kvm_enabled()));
-
-    info->dtb_filename = qemu_opt_get(qemu_get_machine_opts(), "dtb");
-    info->dtb_limit = 0;
-
-    /* Load the kernel.  */
-    if (!info->kernel_filename || info->firmware_loaded) {
-
-        if (have_dtb(info)) {
-            /*
-             * If we have a device tree blob, but no kernel to supply it to (or
-             * the kernel is supposed to be loaded by the bootloader), copy the
-             * DTB to the base of RAM for the bootloader to pick up.
-             */
-            info->dtb_start = info->loader_start;
-        }
-
-        if (info->kernel_filename) {
-            FWCfgState *fw_cfg;
-            bool try_decompressing_kernel;
-
-            fw_cfg = fw_cfg_find();
-            try_decompressing_kernel = arm_feature(&cpu->env,
-                                                   ARM_FEATURE_AARCH64);
-
-            /*
-             * Expose the kernel, the command line, and the initrd in fw_cfg.
-             * We don't process them here at all, it's all left to the
-             * firmware.
-             */
-            load_image_to_fw_cfg(fw_cfg,
-                                 FW_CFG_KERNEL_SIZE, FW_CFG_KERNEL_DATA,
-                                 info->kernel_filename,
-                                 try_decompressing_kernel);
-            load_image_to_fw_cfg(fw_cfg,
-                                 FW_CFG_INITRD_SIZE, FW_CFG_INITRD_DATA,
-                                 info->initrd_filename, false);
-
-            if (info->kernel_cmdline) {
-                fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
-                               strlen(info->kernel_cmdline) + 1);
-                fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
-                                  info->kernel_cmdline);
-            }
-        }
-
-        /*
-         * We will start from address 0 (typically a boot ROM image) in the
-         * same way as hardware.
-         */
-        return;
-    }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         primary_loader = bootloader_aarch64;
@@ -1206,6 +1140,82 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
         ARM_CPU(cs)->env.boot_info = info;
     }
+}
+
+void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
+{
+    CPUState *cs;
+    AddressSpace *as = arm_boot_address_space(cpu, info);
+
+    /*
+     * CPU objects (unlike devices) are not automatically reset on system
+     * reset, so we must always register a handler to do so. If we're
+     * actually loading a kernel, the handler is also responsible for
+     * arranging that we start it correctly.
+     */
+    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
+        qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
+    }
+
+    /*
+     * The board code is not supposed to set secure_board_setup unless
+     * running its code in secure mode is actually possible, and KVM
+     * doesn't support secure.
+     */
+    assert(!(info->secure_board_setup && kvm_enabled()));
+
+    info->dtb_filename = qemu_opt_get(qemu_get_machine_opts(), "dtb");
+    info->dtb_limit = 0;
+
+    /* Load the kernel.  */
+    if (!info->kernel_filename || info->firmware_loaded) {
+
+        if (have_dtb(info)) {
+            /*
+             * If we have a device tree blob, but no kernel to supply it to (or
+             * the kernel is supposed to be loaded by the bootloader), copy the
+             * DTB to the base of RAM for the bootloader to pick up.
+             */
+            info->dtb_start = info->loader_start;
+        }
+
+        if (info->kernel_filename) {
+            FWCfgState *fw_cfg;
+            bool try_decompressing_kernel;
+
+            fw_cfg = fw_cfg_find();
+            try_decompressing_kernel = arm_feature(&cpu->env,
+                                                   ARM_FEATURE_AARCH64);
+
+            /*
+             * Expose the kernel, the command line, and the initrd in fw_cfg.
+             * We don't process them here at all, it's all left to the
+             * firmware.
+             */
+            load_image_to_fw_cfg(fw_cfg,
+                                 FW_CFG_KERNEL_SIZE, FW_CFG_KERNEL_DATA,
+                                 info->kernel_filename,
+                                 try_decompressing_kernel);
+            load_image_to_fw_cfg(fw_cfg,
+                                 FW_CFG_INITRD_SIZE, FW_CFG_INITRD_DATA,
+                                 info->initrd_filename, false);
+
+            if (info->kernel_cmdline) {
+                fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
+                               strlen(info->kernel_cmdline) + 1);
+                fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
+                                  info->kernel_cmdline);
+            }
+        }
+
+        /*
+         * We will start from address 0 (typically a boot ROM image) in the
+         * same way as hardware.
+         */
+        return;
+    } else {
+        arm_setup_direct_kernel_boot(cpu, info);
+    }
 
     if (!info->skip_dtb_autoload && have_dtb(info)) {
         if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
-- 
2.20.1
