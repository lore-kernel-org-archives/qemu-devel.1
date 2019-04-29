Received: from eggs.gnu.org ([209.51.188.92]:34669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fM-0005Ol-CM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fG-0006yu-Jz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:33805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9fD-0006W5-Pp
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id b67so384646wmg.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.03
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:13 +0100
Message-Id: <20190429170030.11323-26-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/42] target/arm: Add lazy-FP-stacking support
 to v7m_stack_write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Pushing registers to the stack for v7M needs to handle three cases:
 * the "normal" case where we pend exceptions
 * an "ignore faults" case where we set FSR bits but
   do not pend exceptions (this is used when we are
   handling some kinds of derived exception on exception entry)
 * a "lazy FP stacking" case, where different FSR bits
   are set and the exception is pended differently

Implement this by changing the existing flag argument that
tells us whether to ignore faults or not into an enum that
specifies which of the 3 modes we should handle.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-23-peter.maydell@linaro.org
---
 target/arm/helper.c | 118 +++++++++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 39 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1ed5f1a2513..41531390853 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7575,8 +7575,18 @@ static bool v7m_cpacr_pass(CPUARMState *env, bool is_secure, bool is_priv)
     }
 }
 
+/*
+ * What kind of stack write are we doing? This affects how exceptions
+ * generated during the stacking are treated.
+ */
+typedef enum StackingMode {
+    STACK_NORMAL,
+    STACK_IGNFAULTS,
+    STACK_LAZYFP,
+} StackingMode;
+
 static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
-                            ARMMMUIdx mmu_idx, bool ignfault)
+                            ARMMMUIdx mmu_idx, StackingMode mode)
 {
     CPUState *cs = CPU(cpu);
     CPUARMState *env = &cpu->env;
@@ -7594,15 +7604,31 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
                       &attrs, &prot, &page_size, &fi, NULL)) {
         /* MPU/SAU lookup failed */
         if (fi.type == ARMFault_QEMU_SFault) {
-            qemu_log_mask(CPU_LOG_INT,
-                          "...SecureFault with SFSR.AUVIOL during stacking\n");
-            env->v7m.sfsr |= R_V7M_SFSR_AUVIOL_MASK | R_V7M_SFSR_SFARVALID_MASK;
+            if (mode == STACK_LAZYFP) {
+                qemu_log_mask(CPU_LOG_INT,
+                              "...SecureFault with SFSR.LSPERR "
+                              "during lazy stacking\n");
+                env->v7m.sfsr |= R_V7M_SFSR_LSPERR_MASK;
+            } else {
+                qemu_log_mask(CPU_LOG_INT,
+                              "...SecureFault with SFSR.AUVIOL "
+                              "during stacking\n");
+                env->v7m.sfsr |= R_V7M_SFSR_AUVIOL_MASK;
+            }
+            env->v7m.sfsr |= R_V7M_SFSR_SFARVALID_MASK;
             env->v7m.sfar = addr;
             exc = ARMV7M_EXCP_SECURE;
             exc_secure = false;
         } else {
-            qemu_log_mask(CPU_LOG_INT, "...MemManageFault with CFSR.MSTKERR\n");
-            env->v7m.cfsr[secure] |= R_V7M_CFSR_MSTKERR_MASK;
+            if (mode == STACK_LAZYFP) {
+                qemu_log_mask(CPU_LOG_INT,
+                              "...MemManageFault with CFSR.MLSPERR\n");
+                env->v7m.cfsr[secure] |= R_V7M_CFSR_MLSPERR_MASK;
+            } else {
+                qemu_log_mask(CPU_LOG_INT,
+                              "...MemManageFault with CFSR.MSTKERR\n");
+                env->v7m.cfsr[secure] |= R_V7M_CFSR_MSTKERR_MASK;
+            }
             exc = ARMV7M_EXCP_MEM;
             exc_secure = secure;
         }
@@ -7612,8 +7638,13 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
                          attrs, &txres);
     if (txres != MEMTX_OK) {
         /* BusFault trying to write the data */
-        qemu_log_mask(CPU_LOG_INT, "...BusFault with BFSR.STKERR\n");
-        env->v7m.cfsr[M_REG_NS] |= R_V7M_CFSR_STKERR_MASK;
+        if (mode == STACK_LAZYFP) {
+            qemu_log_mask(CPU_LOG_INT, "...BusFault with BFSR.LSPERR\n");
+            env->v7m.cfsr[M_REG_NS] |= R_V7M_CFSR_LSPERR_MASK;
+        } else {
+            qemu_log_mask(CPU_LOG_INT, "...BusFault with BFSR.STKERR\n");
+            env->v7m.cfsr[M_REG_NS] |= R_V7M_CFSR_STKERR_MASK;
+        }
         exc = ARMV7M_EXCP_BUS;
         exc_secure = false;
         goto pend_fault;
@@ -7628,11 +7659,19 @@ pend_fault:
      * later if we have two derived exceptions.
      * The only case when we must not pend the exception but instead
      * throw it away is if we are doing the push of the callee registers
-     * and we've already generated a derived exception. Even in this
-     * case we will still update the fault status registers.
+     * and we've already generated a derived exception (this is indicated
+     * by the caller passing STACK_IGNFAULTS). Even in this case we will
+     * still update the fault status registers.
      */
-    if (!ignfault) {
+    switch (mode) {
+    case STACK_NORMAL:
         armv7m_nvic_set_pending_derived(env->nvic, exc, exc_secure);
+        break;
+    case STACK_LAZYFP:
+        armv7m_nvic_set_pending_lazyfp(env->nvic, exc, exc_secure);
+        break;
+    case STACK_IGNFAULTS:
+        break;
     }
     return false;
 }
@@ -8009,6 +8048,7 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     uint32_t limit;
     bool want_psp;
     uint32_t sig;
+    StackingMode smode = ignore_faults ? STACK_IGNFAULTS : STACK_NORMAL;
 
     if (dotailchain) {
         bool mode = lr & R_V7M_EXCRET_MODE_MASK;
@@ -8052,23 +8092,15 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
      */
     sig = v7m_integrity_sig(env, lr);
     stacked_ok =
-        v7m_stack_write(cpu, frameptr, sig, mmu_idx, ignore_faults) &&
-        v7m_stack_write(cpu, frameptr + 0x8, env->regs[4], mmu_idx,
-                        ignore_faults) &&
-        v7m_stack_write(cpu, frameptr + 0xc, env->regs[5], mmu_idx,
-                        ignore_faults) &&
-        v7m_stack_write(cpu, frameptr + 0x10, env->regs[6], mmu_idx,
-                        ignore_faults) &&
-        v7m_stack_write(cpu, frameptr + 0x14, env->regs[7], mmu_idx,
-                        ignore_faults) &&
-        v7m_stack_write(cpu, frameptr + 0x18, env->regs[8], mmu_idx,
-                        ignore_faults) &&
-        v7m_stack_write(cpu, frameptr + 0x1c, env->regs[9], mmu_idx,
-                        ignore_faults) &&
-        v7m_stack_write(cpu, frameptr + 0x20, env->regs[10], mmu_idx,
-                        ignore_faults) &&
-        v7m_stack_write(cpu, frameptr + 0x24, env->regs[11], mmu_idx,
-                        ignore_faults);
+        v7m_stack_write(cpu, frameptr, sig, mmu_idx, smode) &&
+        v7m_stack_write(cpu, frameptr + 0x8, env->regs[4], mmu_idx, smode) &&
+        v7m_stack_write(cpu, frameptr + 0xc, env->regs[5], mmu_idx, smode) &&
+        v7m_stack_write(cpu, frameptr + 0x10, env->regs[6], mmu_idx, smode) &&
+        v7m_stack_write(cpu, frameptr + 0x14, env->regs[7], mmu_idx, smode) &&
+        v7m_stack_write(cpu, frameptr + 0x18, env->regs[8], mmu_idx, smode) &&
+        v7m_stack_write(cpu, frameptr + 0x1c, env->regs[9], mmu_idx, smode) &&
+        v7m_stack_write(cpu, frameptr + 0x20, env->regs[10], mmu_idx, smode) &&
+        v7m_stack_write(cpu, frameptr + 0x24, env->regs[11], mmu_idx, smode);
 
     /* Update SP regardless of whether any of the stack accesses failed. */
     *frame_sp_p = frameptr;
@@ -8347,14 +8379,20 @@ static bool v7m_push_stack(ARMCPU *cpu)
      * if it has higher priority).
      */
     stacked_ok = stacked_ok &&
-        v7m_stack_write(cpu, frameptr, env->regs[0], mmu_idx, false) &&
-        v7m_stack_write(cpu, frameptr + 4, env->regs[1], mmu_idx, false) &&
-        v7m_stack_write(cpu, frameptr + 8, env->regs[2], mmu_idx, false) &&
-        v7m_stack_write(cpu, frameptr + 12, env->regs[3], mmu_idx, false) &&
-        v7m_stack_write(cpu, frameptr + 16, env->regs[12], mmu_idx, false) &&
-        v7m_stack_write(cpu, frameptr + 20, env->regs[14], mmu_idx, false) &&
-        v7m_stack_write(cpu, frameptr + 24, env->regs[15], mmu_idx, false) &&
-        v7m_stack_write(cpu, frameptr + 28, xpsr, mmu_idx, false);
+        v7m_stack_write(cpu, frameptr, env->regs[0], mmu_idx, STACK_NORMAL) &&
+        v7m_stack_write(cpu, frameptr + 4, env->regs[1],
+                        mmu_idx, STACK_NORMAL) &&
+        v7m_stack_write(cpu, frameptr + 8, env->regs[2],
+                        mmu_idx, STACK_NORMAL) &&
+        v7m_stack_write(cpu, frameptr + 12, env->regs[3],
+                        mmu_idx, STACK_NORMAL) &&
+        v7m_stack_write(cpu, frameptr + 16, env->regs[12],
+                        mmu_idx, STACK_NORMAL) &&
+        v7m_stack_write(cpu, frameptr + 20, env->regs[14],
+                        mmu_idx, STACK_NORMAL) &&
+        v7m_stack_write(cpu, frameptr + 24, env->regs[15],
+                        mmu_idx, STACK_NORMAL) &&
+        v7m_stack_write(cpu, frameptr + 28, xpsr, mmu_idx, STACK_NORMAL);
 
     if (env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) {
         /* FPU is active, try to save its registers */
@@ -8404,12 +8442,14 @@ static bool v7m_push_stack(ARMCPU *cpu)
                         faddr += 8; /* skip the slot for the FPSCR */
                     }
                     stacked_ok = stacked_ok &&
-                        v7m_stack_write(cpu, faddr, slo, mmu_idx, false) &&
-                        v7m_stack_write(cpu, faddr + 4, shi, mmu_idx, false);
+                        v7m_stack_write(cpu, faddr, slo,
+                                        mmu_idx, STACK_NORMAL) &&
+                        v7m_stack_write(cpu, faddr + 4, shi,
+                                        mmu_idx, STACK_NORMAL);
                 }
                 stacked_ok = stacked_ok &&
                     v7m_stack_write(cpu, frameptr + 0x60,
-                                    vfp_get_fpscr(env), mmu_idx, false);
+                                    vfp_get_fpscr(env), mmu_idx, STACK_NORMAL);
                 if (cpacr_pass) {
                     for (i = 0; i < ((framesize == 0xa8) ? 32 : 16); i += 2) {
                         *aa32_vfp_dreg(env, i / 2) = 0;
-- 
2.20.1
