Received: from eggs.gnu.org ([2001:4830:134:3::10]:39848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sr-00013u-QF
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sm-0001wM-FL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:33 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Sm-0001td-8E
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:28 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sc-0002YJ-9j
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:18 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:02:48 +0000
Message-Id: <20180209110314.11766-5-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/30] target/arm: Make v7M exception entry
 stack push check MPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The memory writes done to push registers on the stack
on exception entry in M profile CPUs are supposed to
go via MPU permissions checks, which may cause us to
take a derived exception instead of the original one of
the MPU lookup fails. We were implementing these as
always-succeeds direct writes to physical memory.
Rewrite v7m_push_stack() to do the necessary checks.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1517324542-6607-5-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 103 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 87 insertions(+), 16 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c713eea424..f31472a044 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6161,12 +6161,66 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
     return target_el;
 }
 
-static void v7m_push(CPUARMState *env, uint32_t val)
+static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
+                            ARMMMUIdx mmu_idx, bool ignfault)
 {
-    CPUState *cs = CPU(arm_env_get_cpu(env));
+    CPUState *cs = CPU(cpu);
+    CPUARMState *env = &cpu->env;
+    MemTxAttrs attrs = {};
+    MemTxResult txres;
+    target_ulong page_size;
+    hwaddr physaddr;
+    int prot;
+    ARMMMUFaultInfo fi;
+    bool secure = mmu_idx & ARM_MMU_IDX_M_S;
+    int exc;
+    bool exc_secure;
 
-    env->regs[13] -= 4;
-    stl_phys(cs->as, env->regs[13], val);
+    if (get_phys_addr(env, addr, MMU_DATA_STORE, mmu_idx, &physaddr,
+                      &attrs, &prot, &page_size, &fi, NULL)) {
+        /* MPU/SAU lookup failed */
+        if (fi.type == ARMFault_QEMU_SFault) {
+            qemu_log_mask(CPU_LOG_INT,
+                          "...SecureFault with SFSR.AUVIOL during stacking\n");
+            env->v7m.sfsr |= R_V7M_SFSR_AUVIOL_MASK | R_V7M_SFSR_SFARVALID_MASK;
+            env->v7m.sfar = addr;
+            exc = ARMV7M_EXCP_SECURE;
+            exc_secure = false;
+        } else {
+            qemu_log_mask(CPU_LOG_INT, "...MemManageFault with CFSR.MSTKERR\n");
+            env->v7m.cfsr[secure] |= R_V7M_CFSR_MSTKERR_MASK;
+            exc = ARMV7M_EXCP_MEM;
+            exc_secure = secure;
+        }
+        goto pend_fault;
+    }
+    address_space_stl_le(arm_addressspace(cs, attrs), physaddr, value,
+                         attrs, &txres);
+    if (txres != MEMTX_OK) {
+        /* BusFault trying to write the data */
+        qemu_log_mask(CPU_LOG_INT, "...BusFault with BFSR.STKERR\n");
+        env->v7m.cfsr[M_REG_NS] |= R_V7M_CFSR_STKERR_MASK;
+        exc = ARMV7M_EXCP_BUS;
+        exc_secure = false;
+        goto pend_fault;
+    }
+    return true;
+
+pend_fault:
+    /* By pending the exception at this point we are making
+     * the IMPDEF choice "overridden exceptions pended" (see the
+     * MergeExcInfo() pseudocode). The other choice would be to not
+     * pend them now and then make a choice about which to throw away
+     * later if we have two derived exceptions.
+     * The only case when we must not pend the exception but instead
+     * throw it away is if we are doing the push of the callee registers
+     * and we've already generated a derived exception. Even in this
+     * case we will still update the fault status registers.
+     */
+    if (!ignfault) {
+        armv7m_nvic_set_pending_derived(env->nvic, exc, exc_secure);
+    }
+    return false;
 }
 
 /* Return true if we're using the process stack pointer (not the MSP) */
@@ -6562,26 +6616,43 @@ static bool v7m_push_stack(ARMCPU *cpu)
      * should ignore further stack faults trying to process
      * that derived exception.)
      */
+    bool stacked_ok;
     CPUARMState *env = &cpu->env;
     uint32_t xpsr = xpsr_read(env);
+    uint32_t frameptr = env->regs[13];
+    ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
 
     /* Align stack pointer if the guest wants that */
-    if ((env->regs[13] & 4) &&
+    if ((frameptr & 4) &&
         (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKALIGN_MASK)) {
-        env->regs[13] -= 4;
+        frameptr -= 4;
         xpsr |= XPSR_SPREALIGN;
     }
-    /* Switch to the handler mode.  */
-    v7m_push(env, xpsr);
-    v7m_push(env, env->regs[15]);
-    v7m_push(env, env->regs[14]);
-    v7m_push(env, env->regs[12]);
-    v7m_push(env, env->regs[3]);
-    v7m_push(env, env->regs[2]);
-    v7m_push(env, env->regs[1]);
-    v7m_push(env, env->regs[0]);
 
-    return false;
+    frameptr -= 0x20;
+
+    /* Write as much of the stack frame as we can. If we fail a stack
+     * write this will result in a derived exception being pended
+     * (which may be taken in preference to the one we started with
+     * if it has higher priority).
+     */
+    stacked_ok =
+        v7m_stack_write(cpu, frameptr, env->regs[0], mmu_idx, false) &&
+        v7m_stack_write(cpu, frameptr + 4, env->regs[1], mmu_idx, false) &&
+        v7m_stack_write(cpu, frameptr + 8, env->regs[2], mmu_idx, false) &&
+        v7m_stack_write(cpu, frameptr + 12, env->regs[3], mmu_idx, false) &&
+        v7m_stack_write(cpu, frameptr + 16, env->regs[12], mmu_idx, false) &&
+        v7m_stack_write(cpu, frameptr + 20, env->regs[14], mmu_idx, false) &&
+        v7m_stack_write(cpu, frameptr + 24, env->regs[15], mmu_idx, false) &&
+        v7m_stack_write(cpu, frameptr + 28, xpsr, mmu_idx, false);
+
+    /* Update SP regardless of whether any of the stack accesses failed.
+     * When we implement v8M stack limit checking then this attempt to
+     * update SP might also fail and result in a derived exception.
+     */
+    env->regs[13] = frameptr;
+
+    return !stacked_ok;
 }
 
 static void do_v7m_exception_exit(ARMCPU *cpu)
-- 
2.16.1
