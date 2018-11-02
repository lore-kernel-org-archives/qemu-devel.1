Received: from eggs.gnu.org ([2001:4830:134:3::10]:38516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIWhK-0007xf-Hw
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIWZ6-0006qz-Cn
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:20:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIWZ4-0006o3-DX
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:20:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id d10-v6so1424598wrs.5
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 03:20:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  2 Nov 2018 10:20:25 +0000
Message-Id: <20181102102025.3546-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2] target/arm: Conditionalize some asserts on
 aarch32 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org

When populating id registers from kvm, on a host that doesn't support
aarch32 mode at all, neither arm_div nor jazelle will be supported either.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

v2: Test aa64pfr.el0 >= 2; rename to isar_feature_aa64_aa32.
    Pull out realizefn test to no_aa32 bool; use it for jazelle as well.

Alex, can you give this a test please?


r~

---
 target/arm/cpu.h |  5 +++++
 target/arm/cpu.c | 15 +++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 895f9909d8..5c2c77c31d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3300,6 +3300,11 @@ static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
 }
 
+static inline bool isar_feature_aa64_aa32(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) >= 2;
+}
+
 static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e08a2d2d79..d4dc0bc225 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -774,6 +774,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUARMState *env = &cpu->env;
     int pagebits;
     Error *local_err = NULL;
+    bool no_aa32 = false;
 
     /* If we needed to query the host kernel for the CPU features
      * then it's possible that might have failed in the initfn, but
@@ -820,6 +821,16 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             set_feature(env, ARM_FEATURE_V7VE);
         }
     }
+
+    /*
+     * There exist AArch64 cpus without AArch32 support.  When KVM
+     * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
+     * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
+     */
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        no_aa32 = !cpu_isar_feature(aa64_aa32, cpu);
+    }
+
     if (arm_feature(env, ARM_FEATURE_V7VE)) {
         /* v7 Virtualization Extensions. In real hardware this implies
          * EL2 and also the presence of the Security Extensions.
@@ -829,7 +840,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
          * Security Extensions is ARM_FEATURE_EL3.
          */
-        assert(cpu_isar_feature(arm_div, cpu));
+        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
         set_feature(env, ARM_FEATURE_LPAE);
         set_feature(env, ARM_FEATURE_V7);
     }
@@ -855,7 +866,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_V6)) {
         set_feature(env, ARM_FEATURE_V5);
         if (!arm_feature(env, ARM_FEATURE_M)) {
-            assert(cpu_isar_feature(jazelle, cpu));
+            assert(no_aa32 || cpu_isar_feature(jazelle, cpu));
             set_feature(env, ARM_FEATURE_AUXCR);
         }
     }
-- 
2.17.2
