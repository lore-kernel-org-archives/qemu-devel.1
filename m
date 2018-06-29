Received: from eggs.gnu.org ([2001:4830:134:3::10]:34267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun7-0007ps-H0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun6-0007fm-Az
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun6-0007dX-1t
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:28 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun5-0004oK-20
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:38 +0100
Message-Id: <20180629145347.652-47-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 46/55] target/arm: Add ARM_FEATURE_V7VE for v7
 Virtualization Extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <alindsay@codeaurora.org>

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Message-id: 1529699547-17044-5-git-send-email-alindsay@codeaurora.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h   |  1 +
 target/arm/cpu.c   | 21 ++++++++++++++-------
 target/arm/kvm32.c |  8 ++++----
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6a8441c2dd6..7ac909448ea 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1442,6 +1442,7 @@ enum arm_features {
     ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
     ARM_FEATURE_THUMB2EE,
     ARM_FEATURE_V7MP,    /* v7 Multiprocessing Extensions */
+    ARM_FEATURE_V7VE, /* v7 Virtualization Extensions (non-EL2 parts) */
     ARM_FEATURE_V4T,
     ARM_FEATURE_V5,
     ARM_FEATURE_STRONGARM,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index aa62315cea2..4584cd01bc1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -800,9 +800,20 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     /* Some features automatically imply others: */
     if (arm_feature(env, ARM_FEATURE_V8)) {
-        set_feature(env, ARM_FEATURE_V7);
+        set_feature(env, ARM_FEATURE_V7VE);
+    }
+    if (arm_feature(env, ARM_FEATURE_V7VE)) {
+        /* v7 Virtualization Extensions. In real hardware this implies
+         * EL2 and also the presence of the Security Extensions.
+         * For QEMU, for backwards-compatibility we implement some
+         * CPUs or CPU configs which have no actual EL2 or EL3 but do
+         * include the various other features that V7VE implies.
+         * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
+         * Security Extensions is ARM_FEATURE_EL3.
+         */
         set_feature(env, ARM_FEATURE_ARM_DIV);
         set_feature(env, ARM_FEATURE_LPAE);
+        set_feature(env, ARM_FEATURE_V7);
     }
     if (arm_feature(env, ARM_FEATURE_V7)) {
         set_feature(env, ARM_FEATURE_VAPA);
@@ -1524,15 +1535,13 @@ static void cortex_a7_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     cpu->dtb_compatible = "arm,cortex-a7";
-    set_feature(&cpu->env, ARM_FEATURE_V7);
+    set_feature(&cpu->env, ARM_FEATURE_V7VE);
     set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
-    set_feature(&cpu->env, ARM_FEATURE_ARM_DIV);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
-    set_feature(&cpu->env, ARM_FEATURE_LPAE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A7;
     cpu->midr = 0x410fc075;
@@ -1569,15 +1578,13 @@ static void cortex_a15_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     cpu->dtb_compatible = "arm,cortex-a15";
-    set_feature(&cpu->env, ARM_FEATURE_V7);
+    set_feature(&cpu->env, ARM_FEATURE_V7VE);
     set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
-    set_feature(&cpu->env, ARM_FEATURE_ARM_DIV);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
-    set_feature(&cpu->env, ARM_FEATURE_LPAE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A15;
     cpu->midr = 0x412fc0f1;
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 1740cda47da..fb9ea37a318 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -98,12 +98,12 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     /* Now we've retrieved all the register information we can
      * set the feature bits based on the ID register fields.
      * We can assume any KVM supporting CPU is at least a v7
-     * with VFPv3, LPAE and the generic timers; this in turn implies
-     * most of the other feature bits, but a few must be tested.
+     * with VFPv3, virtualization extensions, and the generic
+     * timers; this in turn implies most of the other feature
+     * bits, but a few must be tested.
      */
-    set_feature(&features, ARM_FEATURE_V7);
+    set_feature(&features, ARM_FEATURE_V7VE);
     set_feature(&features, ARM_FEATURE_VFP3);
-    set_feature(&features, ARM_FEATURE_LPAE);
     set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
 
     switch (extract32(id_isar0, 24, 4)) {
-- 
2.17.1
