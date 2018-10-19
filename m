Received: from eggs.gnu.org ([2001:4830:134:3::10]:49030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY8W-0003v5-A0
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY8R-0005RD-KX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY8M-00020Y-9l
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5y-0006j2-2w
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:54 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:06 +0100
Message-Id: <20181019165735.22511-17-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/45] target/arm: Implement HCR.VI and VF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The HCR_EL2 VI and VF bits are supposed to track whether there is
a pending virtual IRQ or virtual FIQ. For QEMU we store the
pending VIRQ/VFIQ status in cs->interrupt_request, so this means:
 * if the register is read we must get these bit values from
   cs->interrupt_request
 * if the register is written then we must write the bit
   values back into cs->interrupt_request

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181012144235.19646-7-peter.maydell@linaro.org
---
 target/arm/helper.c | 47 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0ecef3c1360..af2f63c31b0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3931,6 +3931,7 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
+    CPUState *cs = ENV_GET_CPU(env);
     uint64_t valid_mask = HCR_MASK;
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
@@ -3949,6 +3950,28 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     /* Clear RES0 bits.  */
     value &= valid_mask;
 
+    /*
+     * VI and VF are kept in cs->interrupt_request. Modifying that
+     * requires that we have the iothread lock, which is done by
+     * marking the reginfo structs as ARM_CP_IO.
+     * Note that if a write to HCR pends a VIRQ or VFIQ it is never
+     * possible for it to be taken immediately, because VIRQ and
+     * VFIQ are masked unless running at EL0 or EL1, and HCR
+     * can only be written at EL2.
+     */
+    g_assert(qemu_mutex_iothread_locked());
+    if (value & HCR_VI) {
+        cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
+    } else {
+        cs->interrupt_request &= ~CPU_INTERRUPT_VIRQ;
+    }
+    if (value & HCR_VF) {
+        cs->interrupt_request |= CPU_INTERRUPT_VFIQ;
+    } else {
+        cs->interrupt_request &= ~CPU_INTERRUPT_VFIQ;
+    }
+    value &= ~(HCR_VI | HCR_VF);
+
     /* These bits change the MMU setup:
      * HCR_VM enables stage 2 translation
      * HCR_PTW forbids certain page-table setups
@@ -3976,16 +3999,32 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
     hcr_write(env, NULL, value);
 }
 
+static uint64_t hcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* The VI and VF bits live in cs->interrupt_request */
+    uint64_t ret = env->cp15.hcr_el2 & ~(HCR_VI | HCR_VF);
+    CPUState *cs = ENV_GET_CPU(env);
+
+    if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+        ret |= HCR_VI;
+    }
+    if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
+        ret |= HCR_VF;
+    }
+    return ret;
+}
+
 static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HCR_EL2", .state = ARM_CP_STATE_AA64,
+      .type = ARM_CP_IO,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
-      .writefn = hcr_write },
+      .writefn = hcr_write, .readfn = hcr_read },
     { .name = "HCR", .state = ARM_CP_STATE_AA32,
-      .type = ARM_CP_ALIAS,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
-      .writefn = hcr_writelow },
+      .writefn = hcr_writelow, .readfn = hcr_read },
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
@@ -4222,7 +4261,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
 
 static const ARMCPRegInfo el2_v8_cp_reginfo[] = {
     { .name = "HCR2", .state = ARM_CP_STATE_AA32,
-      .type = ARM_CP_ALIAS,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 4,
       .access = PL2_RW,
       .fieldoffset = offsetofhigh32(CPUARMState, cp15.hcr_el2),
-- 
2.19.1
