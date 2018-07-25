Received: from eggs.gnu.org ([2001:4830:134:3::10]:42608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fiCOC-0003RH-Dj
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 01:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fiCO9-0007vf-Ek
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 01:31:08 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:43099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fiCO9-0007vS-1G
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 01:31:05 -0400
Received: by mail-qk0-x242.google.com with SMTP id z74-v6so4160708qkb.10
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 22:31:04 -0700 (PDT)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 25 Jul 2018 13:30:51 +0800
Message-Id: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/2] hw/arm: check fw_cfg return value
 before using it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: radoslaw.biernacki@linaro.org, ard.biesheuvel@linaro.org, leif.lindholm@linaro.org, Hongbo Zhang <hongbo.zhang@linaro.org>

The fw_cfg value returned from fw_cfg_find() may be NULL, so check it
before using.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 hw/arm/boot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e09201c..43b217f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -930,6 +930,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     hwaddr entry;
     static const ARMInsnFixup *primary_loader;
     AddressSpace *as = arm_boot_address_space(cpu, info);
+    FWCfgState *fw_cfg;
 
     /* CPU objects (unlike devices) are not automatically reset on system
      * reset, so we must always register a handler to do so. If we're
@@ -960,11 +961,10 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
             info->dtb_start = info->loader_start;
         }
 
-        if (info->kernel_filename) {
-            FWCfgState *fw_cfg;
+        fw_cfg = fw_cfg_find();
+        if (info->kernel_filename && fw_cfg) {
             bool try_decompressing_kernel;
 
-            fw_cfg = fw_cfg_find();
             try_decompressing_kernel = arm_feature(&cpu->env,
                                                    ARM_FEATURE_AARCH64);
 
-- 
2.7.4
