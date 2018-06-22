Received: from eggs.gnu.org ([2001:4830:134:3::10]:54314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjd-00029F-Ei
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjc-0005Sk-De
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:45 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 22 Jun 2018 16:32:18 -0400
Message-Id: <1529699547-17044-5-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v5 04/13] target/arm: Add ARM_FEATURE_V7VE for
 v7 Virtualization Extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>, Aaron Lindsay <alindsay@codeaurora.org>

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.c   | 21 ++++++++++++++-------
 target/arm/cpu.h   |  1 +
 target/arm/kvm32.c |  8 ++++----
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 08ce1bc..98790b1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -793,9 +793,20 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
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
@@ -1509,15 +1520,13 @@ static void cortex_a7_initfn(Object *obj)
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
@@ -1554,15 +1563,13 @@ static void cortex_a15_initfn(Object *obj)
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
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 800c4ec..852743b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1474,6 +1474,7 @@ enum arm_features {
     ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
     ARM_FEATURE_THUMB2EE,
     ARM_FEATURE_V7MP,    /* v7 Multiprocessing Extensions */
+    ARM_FEATURE_V7VE, /* v7 Virtualization Extensions (non-EL2 parts) */
     ARM_FEATURE_V4T,
     ARM_FEATURE_V5,
     ARM_FEATURE_STRONGARM,
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 1740cda..fb9ea37 100644
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
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
