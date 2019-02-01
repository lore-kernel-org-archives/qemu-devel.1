Received: from eggs.gnu.org ([209.51.188.92]:58902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0008Ds-2Q
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbM9-0003gR-2e
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:54 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbM7-0003cN-4u
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:52 -0500
Received: by mail-wr1-x42b.google.com with SMTP id q18so7636998wrx.9
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.39
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:41 +0000
Message-Id: <20190201160653.13829-36-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 35/47] target/arm: Send interrupts on PMU
 counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay OS <aaron@os.amperecomputing.com>

Whenever we notice that a counter overflow has occurred, send an
interrupt. This is made more reliable with the addition of a timer in a
follow-on commit.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190124162401.5111-2-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 61 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 66faebea8ec..c27e349dd05 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -977,6 +977,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 /* Definitions for the PMU registers */
 #define PMCRN_MASK  0xf800
 #define PMCRN_SHIFT 11
+#define PMCRLC  0x40
 #define PMCRDP  0x10
 #define PMCRD   0x8
 #define PMCRC   0x4
@@ -1293,6 +1294,13 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
     return enabled && !prohibited && !filtered;
 }
 
+static void pmu_update_irq(CPUARMState *env)
+{
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    qemu_set_irq(cpu->pmu_interrupt, (env->cp15.c9_pmcr & PMCRE) &&
+            (env->cp15.c9_pminten & env->cp15.c9_pmovsr));
+}
+
 /*
  * Ensure c15_ccnt is the guest-visible count so that operations such as
  * enabling/disabling the counter or filtering, modifying the count itself,
@@ -1310,7 +1318,16 @@ void pmccntr_op_start(CPUARMState *env)
             eff_cycles /= 64;
         }
 
-        env->cp15.c15_ccnt = eff_cycles - env->cp15.c15_ccnt_delta;
+        uint64_t new_pmccntr = eff_cycles - env->cp15.c15_ccnt_delta;
+
+        uint64_t overflow_mask = env->cp15.c9_pmcr & PMCRLC ? \
+                                 1ull << 63 : 1ull << 31;
+        if (env->cp15.c15_ccnt & ~new_pmccntr & overflow_mask) {
+            env->cp15.c9_pmovsr |= (1 << 31);
+            pmu_update_irq(env);
+        }
+
+        env->cp15.c15_ccnt = new_pmccntr;
     }
     env->cp15.c15_ccnt_delta = cycles;
 }
@@ -1345,8 +1362,13 @@ static void pmevcntr_op_start(CPUARMState *env, uint8_t counter)
     }
 
     if (pmu_counter_enabled(env, counter)) {
-        env->cp15.c14_pmevcntr[counter] =
-            count - env->cp15.c14_pmevcntr_delta[counter];
+        uint32_t new_pmevcntr = count - env->cp15.c14_pmevcntr_delta[counter];
+
+        if (env->cp15.c14_pmevcntr[counter] & ~new_pmevcntr & INT32_MIN) {
+            env->cp15.c9_pmovsr |= (1 << counter);
+            pmu_update_irq(env);
+        }
+        env->cp15.c14_pmevcntr[counter] = new_pmevcntr;
     }
     env->cp15.c14_pmevcntr_delta[counter] = count;
 }
@@ -1423,7 +1445,20 @@ static void pmswinc_write(CPUARMState *env, const ARMCPRegInfo *ri,
                 /* counter is SW_INCR */
                 (env->cp15.c14_pmevtyper[i] & PMXEVTYPER_EVTCOUNT) == 0x0) {
             pmevcntr_op_start(env, i);
-            env->cp15.c14_pmevcntr[i]++;
+
+            /*
+             * Detect if this write causes an overflow since we can't predict
+             * PMSWINC overflows like we can for other events
+             */
+            uint32_t new_pmswinc = env->cp15.c14_pmevcntr[i] + 1;
+
+            if (env->cp15.c14_pmevcntr[i] & ~new_pmswinc & INT32_MIN) {
+                env->cp15.c9_pmovsr |= (1 << i);
+                pmu_update_irq(env);
+            }
+
+            env->cp15.c14_pmevcntr[i] = new_pmswinc;
+
             pmevcntr_op_finish(env, i);
         }
     }
@@ -1508,6 +1543,7 @@ static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= pmu_counter_mask(env);
     env->cp15.c9_pmovsr &= ~value;
+    pmu_update_irq(env);
 }
 
 static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1515,6 +1551,7 @@ static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= pmu_counter_mask(env);
     env->cp15.c9_pmovsr |= value;
+    pmu_update_irq(env);
 }
 
 static void pmevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1701,6 +1738,7 @@ static void pmintenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* We have no event counters so only the C bit can be changed */
     value &= pmu_counter_mask(env);
     env->cp15.c9_pminten |= value;
+    pmu_update_irq(env);
 }
 
 static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1708,6 +1746,7 @@ static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     value &= pmu_counter_mask(env);
     env->cp15.c9_pminten &= ~value;
+    pmu_update_irq(env);
 }
 
 static void vbar_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1846,7 +1885,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcnten),
       .writefn = pmcntenclr_write },
     { .name = "PMOVSR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 3,
-      .access = PL0_RW,
+      .access = PL0_RW, .type = ARM_CP_IO,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
       .accessfn = pmreg_access,
       .writefn = pmovsr_write,
@@ -1854,16 +1893,18 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     { .name = "PMOVSCLR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 3,
       .access = PL0_RW, .accessfn = pmreg_access,
-      .type = ARM_CP_ALIAS,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
       .writefn = pmovsr_write,
       .raw_writefn = raw_write },
     { .name = "PMSWINC", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 4,
-      .access = PL0_W, .accessfn = pmreg_access_swinc, .type = ARM_CP_NO_RAW,
+      .access = PL0_W, .accessfn = pmreg_access_swinc,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO,
       .writefn = pmswinc_write },
     { .name = "PMSWINC_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 4,
-      .access = PL0_W, .accessfn = pmreg_access_swinc, .type = ARM_CP_NO_RAW,
+      .access = PL0_W, .accessfn = pmreg_access_swinc,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO,
       .writefn = pmswinc_write },
     { .name = "PMSELR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 5,
       .access = PL0_RW, .type = ARM_CP_ALIAS,
@@ -2050,14 +2091,14 @@ static const ARMCPRegInfo pmovsset_cp_reginfo[] = {
     /* PMOVSSET is not implemented in v7 before v7ve */
     { .name = "PMOVSSET", .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 3,
       .access = PL0_RW, .accessfn = pmreg_access,
-      .type = ARM_CP_ALIAS,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
       .writefn = pmovsset_write,
       .raw_writefn = raw_write },
     { .name = "PMOVSSET_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 14, .opc2 = 3,
       .access = PL0_RW, .accessfn = pmreg_access,
-      .type = ARM_CP_ALIAS,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
       .writefn = pmovsset_write,
       .raw_writefn = raw_write },
-- 
2.20.1
