Received: from eggs.gnu.org ([2001:4830:134:3::10]:44098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxR-0003IF-0T
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxP-0004a2-Do
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxP-0004Xg-5S
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxN-0000cy-AO
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:27 +0100
Message-Id: <1507824216-29058-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/13] target/arm: Implement SG instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement the SG instruction, which we emulate 'by hand' in the
exception handling code path.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1507556919-24992-3-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 127 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1d689f0..9cc881e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -41,6 +41,10 @@ typedef struct V8M_SAttributes {
     bool irvalid;
 } V8M_SAttributes;
 
+static void v8m_security_lookup(CPUARMState *env, uint32_t address,
+                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                                V8M_SAttributes *sattrs);
+
 /* Definitions for the PMCCNTR and PMCR registers */
 #define PMCRD   0x8
 #define PMCRC   0x4
@@ -6736,6 +6740,126 @@ static void arm_log_exception(int idx)
     }
 }
 
+static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
+                               uint32_t addr, uint16_t *insn)
+{
+    /* Load a 16-bit portion of a v7M instruction, returning true on success,
+     * or false on failure (in which case we will have pended the appropriate
+     * exception).
+     * We need to do the instruction fetch's MPU and SAU checks
+     * like this because there is no MMU index that would allow
+     * doing the load with a single function call. Instead we must
+     * first check that the security attributes permit the load
+     * and that they don't mismatch on the two halves of the instruction,
+     * and then we do the load as a secure load (ie using the security
+     * attributes of the address, not the CPU, as architecturally required).
+     */
+    CPUState *cs = CPU(cpu);
+    CPUARMState *env = &cpu->env;
+    V8M_SAttributes sattrs = {};
+    MemTxAttrs attrs = {};
+    ARMMMUFaultInfo fi = {};
+    MemTxResult txres;
+    target_ulong page_size;
+    hwaddr physaddr;
+    int prot;
+    uint32_t fsr;
+
+    v8m_security_lookup(env, addr, MMU_INST_FETCH, mmu_idx, &sattrs);
+    if (!sattrs.nsc || sattrs.ns) {
+        /* This must be the second half of the insn, and it straddles a
+         * region boundary with the second half not being S&NSC.
+         */
+        env->v7m.sfsr |= R_V7M_SFSR_INVEP_MASK;
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+        qemu_log_mask(CPU_LOG_INT,
+                      "...really SecureFault with SFSR.INVEP\n");
+        return false;
+    }
+    if (get_phys_addr(env, addr, MMU_INST_FETCH, mmu_idx,
+                      &physaddr, &attrs, &prot, &page_size, &fsr, &fi)) {
+        /* the MPU lookup failed */
+        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_IACCVIOL_MASK;
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM, env->v7m.secure);
+        qemu_log_mask(CPU_LOG_INT, "...really MemManage with CFSR.IACCVIOL\n");
+        return false;
+    }
+    *insn = address_space_lduw_le(arm_addressspace(cs, attrs), physaddr,
+                                 attrs, &txres);
+    if (txres != MEMTX_OK) {
+        env->v7m.cfsr[M_REG_NS] |= R_V7M_CFSR_IBUSERR_MASK;
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_BUS, false);
+        qemu_log_mask(CPU_LOG_INT, "...really BusFault with CFSR.IBUSERR\n");
+        return false;
+    }
+    return true;
+}
+
+static bool v7m_handle_execute_nsc(ARMCPU *cpu)
+{
+    /* Check whether this attempt to execute code in a Secure & NS-Callable
+     * memory region is for an SG instruction; if so, then emulate the
+     * effect of the SG instruction and return true. Otherwise pend
+     * the correct kind of exception and return false.
+     */
+    CPUARMState *env = &cpu->env;
+    ARMMMUIdx mmu_idx;
+    uint16_t insn;
+
+    /* We should never get here unless get_phys_addr_pmsav8() caused
+     * an exception for NS executing in S&NSC memory.
+     */
+    assert(!env->v7m.secure);
+    assert(arm_feature(env, ARM_FEATURE_M_SECURITY));
+
+    /* We want to do the MPU lookup as secure; work out what mmu_idx that is */
+    mmu_idx = arm_v7m_mmu_idx_for_secstate(env, true);
+
+    if (!v7m_read_half_insn(cpu, mmu_idx, env->regs[15], &insn)) {
+        return false;
+    }
+
+    if (!env->thumb) {
+        goto gen_invep;
+    }
+
+    if (insn != 0xe97f) {
+        /* Not an SG instruction first half (we choose the IMPDEF
+         * early-SG-check option).
+         */
+        goto gen_invep;
+    }
+
+    if (!v7m_read_half_insn(cpu, mmu_idx, env->regs[15] + 2, &insn)) {
+        return false;
+    }
+
+    if (insn != 0xe97f) {
+        /* Not an SG instruction second half (yes, both halves of the SG
+         * insn have the same hex value)
+         */
+        goto gen_invep;
+    }
+
+    /* OK, we have confirmed that we really have an SG instruction.
+     * We know we're NS in S memory so don't need to repeat those checks.
+     */
+    qemu_log_mask(CPU_LOG_INT, "...really an SG instruction at 0x%08" PRIx32
+                  ", executing it\n", env->regs[15]);
+    env->regs[14] &= ~1;
+    switch_v7m_security_state(env, true);
+    xpsr_write(env, 0, XPSR_IT);
+    env->regs[15] += 4;
+    return true;
+
+gen_invep:
+    env->v7m.sfsr |= R_V7M_SFSR_INVEP_MASK;
+    armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+    qemu_log_mask(CPU_LOG_INT,
+                  "...really SecureFault with SFSR.INVEP\n");
+    return false;
+}
+
 void arm_v7m_cpu_do_interrupt(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -6778,12 +6902,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
              * the SG instruction have the same security attributes.)
              * Everything else must generate an INVEP SecureFault, so we
              * emulate the SG instruction here.
-             * TODO: actually emulate SG.
              */
-            env->v7m.sfsr |= R_V7M_SFSR_INVEP_MASK;
-            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
-            qemu_log_mask(CPU_LOG_INT,
-                          "...really SecureFault with SFSR.INVEP\n");
+            if (v7m_handle_execute_nsc(cpu)) {
+                return;
+            }
             break;
         case M_FAKE_FSR_SFAULT:
             /* Various flavours of SecureFault for attempts to execute or
-- 
2.7.4
