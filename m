Received: from eggs.gnu.org ([2001:4830:134:3::10]:56739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwrJ-0001G3-7s
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr4-0007j3-C3
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwr4-0007iZ-57
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr3-0001j3-4c
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:24 +0100
Message-Id: <1504790904-17018-32-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 31/31] target/arm: Add Jazelle feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Portia Stephens <portia.stephens@xilinx.com>

This adds a feature bit indicating support of the (trivial) Jazelle
implementation if ARM_FEATURE_V6 is set or if the processor is arm926
or arm1026.  This fixes the issue that any BXJ instruction will
result in an illegal_op.  BXJ instructions will now check if the
architecture supports ARM_FEATURE_JAZELLE.

Signed-off-by: Portia Stephens <portia.stephens@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20170905211232.11092-1-portia.stephens@xilinx.com
[PMM: edited commit message and comment text a bit]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       | 1 +
 target/arm/cpu.c       | 3 +++
 target/arm/translate.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0f40a64..98b9b26 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1296,6 +1296,7 @@ enum arm_features {
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
+    ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f8b2fdb..a1acce3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -712,6 +712,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     if (arm_feature(env, ARM_FEATURE_V6)) {
         set_feature(env, ARM_FEATURE_V5);
+        set_feature(env, ARM_FEATURE_JAZELLE);
         if (!arm_feature(env, ARM_FEATURE_M)) {
             set_feature(env, ARM_FEATURE_AUXCR);
         }
@@ -927,6 +928,7 @@ static void arm926_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
+    set_feature(&cpu->env, ARM_FEATURE_JAZELLE);
     cpu->midr = 0x41069265;
     cpu->reset_fpsid = 0x41011090;
     cpu->ctr = 0x1dd20d2;
@@ -956,6 +958,7 @@ static void arm1026_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
+    set_feature(&cpu->env, ARM_FEATURE_JAZELLE);
     cpu->midr = 0x4106a262;
     cpu->reset_fpsid = 0x410110a0;
     cpu->ctr = 0x1dd20d2;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e7966e2..57899fa 100644
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
2.7.4
