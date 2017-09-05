Received: from eggs.gnu.org ([2001:4830:134:3::10]:55922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <portias@xilinx.com>) id 1dpLBI-0006yv-GY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <portias@xilinx.com>) id 1dpLBD-0003XM-JX
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:14:48 -0400
From: Portia Stephens <portia.stephens@xilinx.com>
Date: Tue, 5 Sep 2017 14:12:32 -0700
Message-ID: <20170905211232.11092-1-portia.stephens@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] target/arm: Add Jazelle feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, portia.stephens@xilinx.com, stephensportia@gmail.com

This adds the Jazelle execution state as a feature if ARM_FEATURE_V6 is
set or if the processor is arm926 or arm1026. This fixes the issue that any
BXJ instruction will result in an illegal_op. BXJ instructions will now
check if the architecture supports ARM_FEATURE_JAZELLE.

Signed-off-by: Portia Stephens <portia.stephens@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---

This is a rewrite from my previous patch, "target/arm: Remove 5J
architecture"
-Instead of removing 5J architecture, added a Jazelle feature.

 target/arm/cpu.c       | 3 +++
 target/arm/cpu.h       | 1 +
 target/arm/translate.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 41ae6ba3c2..0fb2fddae3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -681,6 +681,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     if (arm_feature(env, ARM_FEATURE_V6)) {
         set_feature(env, ARM_FEATURE_V5);
+        set_feature(env, ARM_FEATURE_JAZELLE);
         if (!arm_feature(env, ARM_FEATURE_M)) {
             set_feature(env, ARM_FEATURE_AUXCR);
         }
@@ -887,6 +888,7 @@ static void arm926_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
+    set_feature(&cpu->env, ARM_FEATURE_JAZELLE);
     cpu->midr = 0x41069265;
     cpu->reset_fpsid = 0x41011090;
     cpu->ctr = 0x1dd20d2;
@@ -916,6 +918,7 @@ static void arm1026_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
+    set_feature(&cpu->env, ARM_FEATURE_JAZELLE);
     cpu->midr = 0x4106a262;
     cpu->reset_fpsid = 0x410110a0;
     cpu->ctr = 0x1dd20d2;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 92771d3790..daa99169fd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1250,6 +1250,7 @@ enum arm_features {
     ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings */
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
+    ARM_FEATURE_JAZELLE, /* has Jazelle execution state */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e52a6d7622..3a9142cd7d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -41,7 +41,7 @@
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
 /* currently all emulated v5 cores are also v5TE, so don't bother */
 #define ENABLE_ARCH_5TE   arm_dc_feature(s, ARM_FEATURE_V5)
-#define ENABLE_ARCH_5J    0
+#define ENABLE_ARCH_5J    arm_dc_feature(s, ARM_FEATURE_JAZELLE)
 #define ENABLE_ARCH_6     arm_dc_feature(s, ARM_FEATURE_V6)
 #define ENABLE_ARCH_6K    arm_dc_feature(s, ARM_FEATURE_V6K)
 #define ENABLE_ARCH_6T2   arm_dc_feature(s, ARM_FEATURE_THUMB2)
-- 
2.14.1
