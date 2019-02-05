Received: from eggs.gnu.org ([209.51.188.92]:36134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AX-0001xx-Fe
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AS-0000bW-QI
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:57 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AS-0000S3-D6
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:52 -0500
Received: by mail-wr1-x443.google.com with SMTP id q18so4437537wrx.9
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.38
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:05:06 +0000
Message-Id: <20190205170510.21984-19-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/22] hw/arm/boot: Factor out "direct kernel
 boot" code into its own function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Factor out the "direct kernel boot" code path from arm_load_kernel()
into its own function; this function is getting long enough that
the code flow is a bit confusing.

This commit only moves code around; no semantic changes.

We leave the "load the dtb" code in arm_load_kernel() -- this
is currently only used by the "direct kernel boot" path, but
this is a bug which we will fix shortly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190131112240.8395-3-peter.maydell@linaro.org
---
 hw/arm/boot.c | 150 +++++++++++++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 70 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index dcb93fdbe2c..cd7373a8da2 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -949,9 +949,12 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
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
@@ -959,75 +962,6 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
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
@@ -1202,6 +1136,82 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
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
