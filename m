Received: from eggs.gnu.org ([209.51.188.92]:36206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AZ-0001zf-W7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AT-0000cJ-7u
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:59 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:55007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AS-0000TV-OX
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:52 -0500
Received: by mail-wm1-x336.google.com with SMTP id a62so4449531wmh.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.39
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:05:07 +0000
Message-Id: <20190205170510.21984-20-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/22] hw/arm/boot: Factor out "set up firmware
 boot" code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Factor out the "boot via firmware" code path from arm_load_kernel()
into its own function.

This commit only moves code around; no semantic changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190131112240.8395-4-peter.maydell@linaro.org
---
 hw/arm/boot.c | 92 +++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index cd7373a8da2..2d4f710395f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1138,6 +1138,54 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
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
@@ -1165,49 +1213,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
 
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
