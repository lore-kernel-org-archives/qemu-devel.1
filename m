Received: from eggs.gnu.org ([209.51.188.92]:55461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAQj-0002Em-Bo
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAQi-0008DY-H6
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpAQi-0008D3-Ac
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id y185so1866735wmd.1
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 03:22:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 11:22:38 +0000
Message-Id: <20190131112240.8395-4-peter.maydell@linaro.org>
In-Reply-To: <20190131112240.8395-1-peter.maydell@linaro.org>
References: <20190131112240.8395-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/5] hw/arm/boot: Factor out "set up firmware
 boot" code
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

Factor out the "boot via firmware" code path from arm_load_kernel()
into its own function.

This commit only moves code around; no semantic changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 92 +++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 108e9b979f8..a2e724ac68a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1142,6 +1142,54 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     }
 }
 
+static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
+{
+    /* Set up for booting firmware (which might load a kernel via fw_cfg) */
+
+    if (have_dtb(info)) {
+        /*
+         * If we have a device tree blob, but no kernel to supply it to (or
+         * the kernel is supposed to be loaded by the bootloader), copy the
+         * DTB to the base of RAM for the bootloader to pick up.
+         */
+        info->dtb_start = info->loader_start;
+    }
+
+    if (info->kernel_filename) {
+        FWCfgState *fw_cfg;
+        bool try_decompressing_kernel;
+
+        fw_cfg = fw_cfg_find();
+        try_decompressing_kernel = arm_feature(&cpu->env,
+                                               ARM_FEATURE_AARCH64);
+
+        /*
+         * Expose the kernel, the command line, and the initrd in fw_cfg.
+         * We don't process them here at all, it's all left to the
+         * firmware.
+         */
+        load_image_to_fw_cfg(fw_cfg,
+                             FW_CFG_KERNEL_SIZE, FW_CFG_KERNEL_DATA,
+                             info->kernel_filename,
+                             try_decompressing_kernel);
+        load_image_to_fw_cfg(fw_cfg,
+                             FW_CFG_INITRD_SIZE, FW_CFG_INITRD_DATA,
+                             info->initrd_filename, false);
+
+        if (info->kernel_cmdline) {
+            fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
+                           strlen(info->kernel_cmdline) + 1);
+            fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
+                              info->kernel_cmdline);
+        }
+    }
+
+    /*
+     * We will start from address 0 (typically a boot ROM image) in the
+     * same way as hardware.
+     */
+}
+
 void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
 {
     CPUState *cs;
@@ -1169,49 +1217,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
 
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
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
+        arm_setup_firmware_boot(cpu, info);
         return;
     } else {
         arm_setup_direct_kernel_boot(cpu, info);
-- 
2.20.1
