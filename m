Received: from eggs.gnu.org ([2001:4830:134:3::10]:60542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhp-00040C-Al
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFho-0000e4-4w
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:57 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMFhn-0008MG-S4
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:56 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhP-0005tL-Vc
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:08:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 17:08:12 +0000
Message-Id: <20181112170816.500-13-peter.maydell@linaro.org>
In-Reply-To: <20181112170816.500-1-peter.maydell@linaro.org>
References: <20181112170816.500-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/16] Revert "target/arm: Implement HCR.VI and
 VF"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This reverts commit 8a0fc3a29fc2315325400c738f807d0d4ae0ab7f.

The implementation of HCR.VI and VF in that commit is not
correct -- they do not track the overall "is there a pending
VIRQ or VFIQ" status, but whether there is a pending interrupt
due to "this mechanism", ie the hypervisor having set the VI/VF
bits. The overall pending state for VIRQ and VFIQ is effectively
the logical OR of the inbound lines from the GIC with the
VI and VF bits. Commit 8a0fc3a29fc231 would result in pending
VIRQ/VFIQ possibly being lost when the hypervisor wrote to HCR.

As a preliminary to implementing the HCR.VI/VF feature properly,
revert the broken one entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20181109134731.11605-2-peter.maydell@linaro.org
---
 target/arm/helper.c | 47 ++++-----------------------------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d167bc5deff..3c0c485a3a3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3931,7 +3931,6 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
-    CPUState *cs = ENV_GET_CPU(env);
     uint64_t valid_mask = HCR_MASK;
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
@@ -3950,28 +3949,6 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     /* Clear RES0 bits.  */
     value &= valid_mask;
 
-    /*
-     * VI and VF are kept in cs->interrupt_request. Modifying that
-     * requires that we have the iothread lock, which is done by
-     * marking the reginfo structs as ARM_CP_IO.
-     * Note that if a write to HCR pends a VIRQ or VFIQ it is never
-     * possible for it to be taken immediately, because VIRQ and
-     * VFIQ are masked unless running at EL0 or EL1, and HCR
-     * can only be written at EL2.
-     */
-    g_assert(qemu_mutex_iothread_locked());
-    if (value & HCR_VI) {
-        cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
-    } else {
-        cs->interrupt_request &= ~CPU_INTERRUPT_VIRQ;
-    }
-    if (value & HCR_VF) {
-        cs->interrupt_request |= CPU_INTERRUPT_VFIQ;
-    } else {
-        cs->interrupt_request &= ~CPU_INTERRUPT_VFIQ;
-    }
-    value &= ~(HCR_VI | HCR_VF);
-
     /* These bits change the MMU setup:
      * HCR_VM enables stage 2 translation
      * HCR_PTW forbids certain page-table setups
@@ -3999,32 +3976,16 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
     hcr_write(env, NULL, value);
 }
 
-static uint64_t hcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
-{
-    /* The VI and VF bits live in cs->interrupt_request */
-    uint64_t ret = env->cp15.hcr_el2 & ~(HCR_VI | HCR_VF);
-    CPUState *cs = ENV_GET_CPU(env);
-
-    if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
-        ret |= HCR_VI;
-    }
-    if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
-        ret |= HCR_VF;
-    }
-    return ret;
-}
-
 static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HCR_EL2", .state = ARM_CP_STATE_AA64,
-      .type = ARM_CP_IO,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
-      .writefn = hcr_write, .readfn = hcr_read },
+      .writefn = hcr_write },
     { .name = "HCR", .state = ARM_CP_STATE_AA32,
-      .type = ARM_CP_ALIAS | ARM_CP_IO,
+      .type = ARM_CP_ALIAS,
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
-      .writefn = hcr_writelow, .readfn = hcr_read },
+      .writefn = hcr_writelow },
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
@@ -4261,7 +4222,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
 
 static const ARMCPRegInfo el2_v8_cp_reginfo[] = {
     { .name = "HCR2", .state = ARM_CP_STATE_AA32,
-      .type = ARM_CP_ALIAS | ARM_CP_IO,
+      .type = ARM_CP_ALIAS,
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 4,
       .access = PL2_RW,
       .fieldoffset = offsetofhigh32(CPUARMState, cp15.hcr_el2),
-- 
2.19.1
