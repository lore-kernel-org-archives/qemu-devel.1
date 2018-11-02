Received: from eggs.gnu.org ([2001:4830:134:3::10]:50323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId4T-0007jV-2w
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId4O-0002wS-Mw
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:17:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gId4O-0002Zn-31
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:17:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gId3w-0003az-Rk
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 17:16:48 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Nov 2018 17:16:36 +0000
Message-Id: <20181102171638.24069-9-peter.maydell@linaro.org>
In-Reply-To: <20181102171638.24069-1-peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some asserts
 on aarch32 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

When populating id registers from kvm, on a host that doesn't support
aarch32 mode at all, neither arm_div nor jazelle will be supported either.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20181102102025.3546-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h |  5 +++++
 target/arm/cpu.c | 15 +++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8e6779936eb..b5eff79f73b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3296,6 +3296,11 @@ static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
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
index 8f16e96b6c8..784a4c2dfcc 100644
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
2.19.1
