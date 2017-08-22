Received: from eggs.gnu.org ([2001:4830:134:3::10]:53648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnz-0006hE-23
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnu-0003Kj-CX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:23 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:55 +0100
Message-Id: <1503414539-28762-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 16/20] target/arm: Make CCR register banked for
 v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Make the CCR register banked if v8M security extensions are enabled.

This is slightly more complicated than the other "add banking"
patches because there is one bit in the register which is not
banked. We keep the live data in the NS copy of the register,
and adjust it on register reads and writes. (Since we don't
currently implement the behaviour that the bit controls, there
is nowhere else that needs to care.)

This patch includes the enforcement of the bits which are newly
RES1 in ARMv8M.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |  2 +-
 hw/intc/armv7m_nvic.c | 36 ++++++++++++++++++++++++++++++------
 target/arm/cpu.c      | 12 +++++++++---
 target/arm/helper.c   |  5 +++--
 target/arm/machine.c  |  3 ++-
 5 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 78cd3f0..25ebf9e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -423,7 +423,7 @@ typedef struct CPUARMState {
         uint32_t vecbase[2];
         uint32_t basepri[2];
         uint32_t control[2];
-        uint32_t ccr; /* Configuration and Control */
+        uint32_t ccr[2]; /* Configuration and Control */
         uint32_t cfsr; /* Configurable Fault Status */
         uint32_t hfsr; /* HardFault Status */
         uint32_t dfsr; /* Debug Fault Status Register */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a4c298f..f071649 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -448,7 +448,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         /* TODO: Implement SLEEPONEXIT.  */
         return 0;
     case 0xd14: /* Configuration Control.  */
-        return cpu->env.v7m.ccr;
+        /* The BFHFNMIGN bit is the only non-banked bit; we
+         * keep it in the non-secure copy of the register.
+         */
+        val = cpu->env.v7m.ccr[attrs.secure];
+        val |= cpu->env.v7m.ccr[M_REG_NS] & R_V7M_CCR_BFHFNMIGN_MASK;
+        return val;
     case 0xd24: /* System Handler Status.  */
         val = 0;
         if (s->vectors[ARMV7M_EXCP_MEM].active) {
@@ -673,7 +678,23 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
                   R_V7M_CCR_USERSETMPEND_MASK |
                   R_V7M_CCR_NONBASETHRDENA_MASK);
 
-        cpu->env.v7m.ccr = value;
+        if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            /* v8M makes NONBASETHRDENA and STKALIGN be RES1 */
+            value |= R_V7M_CCR_NONBASETHRDENA_MASK
+                | R_V7M_CCR_STKALIGN_MASK;
+        }
+        if (attrs.secure) {
+            /* the BFHFNMIGN bit is not banked; keep that in the NS copy */
+            int new_bfhnmign = !!(value & R_V7M_CCR_BFHFNMIGN_MASK);
+
+            cpu->env.v7m.ccr[M_REG_NS] = deposit32(cpu->env.v7m.ccr[M_REG_NS],
+                                                    R_V7M_CCR_BFHFNMIGN_SHIFT,
+                                                    R_V7M_CCR_BFHFNMIGN_LENGTH,
+                                                    new_bfhnmign);
+            value &= ~R_V7M_CCR_BFHFNMIGN_MASK;
+        }
+
+        cpu->env.v7m.ccr[attrs.secure] = value;
         break;
     case 0xd24: /* System Handler Control.  */
         s->vectors[ARMV7M_EXCP_MEM].active = (value & (1 << 0)) != 0;
@@ -860,12 +881,15 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
     }
 }
 
-static bool nvic_user_access_ok(NVICState *s, hwaddr offset)
+static bool nvic_user_access_ok(NVICState *s, hwaddr offset, MemTxAttrs attrs)
 {
     /* Return true if unprivileged access to this register is permitted. */
     switch (offset) {
     case 0xf00: /* STIR: accessible only if CCR.USERSETMPEND permits */
-        return s->cpu->env.v7m.ccr & R_V7M_CCR_USERSETMPEND_MASK;
+        /* For access via STIR_NS it is the NS CCR.USERSETMPEND that
+         * controls access even though the CPU is in Secure state (I_QDKX).
+         */
+        return s->cpu->env.v7m.ccr[attrs.secure] & R_V7M_CCR_USERSETMPEND_MASK;
     default:
         /* All other user accesses cause a BusFault unconditionally */
         return false;
@@ -881,7 +905,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
     unsigned i, startvec, end;
     uint32_t val;
 
-    if (attrs.user && !nvic_user_access_ok(s, addr)) {
+    if (attrs.user && !nvic_user_access_ok(s, addr, attrs)) {
         /* Generate BusFault for unprivileged accesses */
         return MEMTX_ERROR;
     }
@@ -971,7 +995,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
 
     trace_nvic_sysreg_write(addr, value, size);
 
-    if (attrs.user && !nvic_user_access_ok(s, addr)) {
+    if (attrs.user && !nvic_user_access_ok(s, addr, attrs)) {
         /* Generate BusFault for unprivileged accesses */
         return MEMTX_ERROR;
     }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 11038b8..3c2ff11 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -189,11 +189,17 @@ static void arm_cpu_reset(CPUState *s)
             env->v7m.secure = true;
         }
 
-        /* The reset value of this bit is IMPDEF, but ARM recommends
+        /* In v7M the reset value of this bit is IMPDEF, but ARM recommends
          * that it resets to 1, so QEMU always does that rather than making
-         * it dependent on CPU model.
+         * it dependent on CPU model. In v8M it is RES1.
          */
-        env->v7m.ccr = R_V7M_CCR_STKALIGN_MASK;
+        env->v7m.ccr[M_REG_NS] = R_V7M_CCR_STKALIGN_MASK;
+        env->v7m.ccr[M_REG_S] = R_V7M_CCR_STKALIGN_MASK;
+        if (arm_feature(env, ARM_FEATURE_V8)) {
+            /* in v8M the NONBASETHRDENA bit [0] is RES1 */
+            env->v7m.ccr[M_REG_NS] |= R_V7M_CCR_NONBASETHRDENA_MASK;
+            env->v7m.ccr[M_REG_S] |= R_V7M_CCR_NONBASETHRDENA_MASK;
+        }
 
         /* Unlike A/R profile, M profile defines the reset LR value */
         env->regs[14] = 0xffffffff;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4a2148c..28b3d6c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6118,7 +6118,8 @@ static void v7m_push_stack(ARMCPU *cpu)
     uint32_t xpsr = xpsr_read(env);
 
     /* Align stack pointer if the guest wants that */
-    if ((env->regs[13] & 4) && (env->v7m.ccr & R_V7M_CCR_STKALIGN_MASK)) {
+    if ((env->regs[13] & 4) &&
+        (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKALIGN_MASK)) {
         env->regs[13] -= 4;
         xpsr |= XPSR_SPREALIGN;
     }
@@ -6216,7 +6217,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         /* fall through */
     case 9: /* Return to Thread using Main stack */
         if (!rettobase &&
-            !(env->v7m.ccr & R_V7M_CCR_NONBASETHRDENA_MASK)) {
+            !(env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_NONBASETHRDENA_MASK)) {
             ufault = true;
         }
         break;
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 5cc95e8..4457ec6 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -117,7 +117,7 @@ static const VMStateDescription vmstate_m = {
         VMSTATE_UINT32(env.v7m.vecbase[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.basepri[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.control[M_REG_NS], ARMCPU),
-        VMSTATE_UINT32(env.v7m.ccr, ARMCPU),
+        VMSTATE_UINT32(env.v7m.ccr[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.cfsr, ARMCPU),
         VMSTATE_UINT32(env.v7m.hfsr, ARMCPU),
         VMSTATE_UINT32(env.v7m.dfsr, ARMCPU),
@@ -271,6 +271,7 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.pmsav7.rnr[M_REG_S], ARMCPU),
         VMSTATE_VALIDATE("secure MPU_RNR is valid", s_rnr_vmstate_validate),
         VMSTATE_UINT32(env.v7m.mpu_ctrl[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.v7m.ccr[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
