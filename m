Received: from eggs.gnu.org ([2001:4830:134:3::10]:56463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr3-00010B-KL
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqt-0007as-Qr
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqt-0007Xf-Iq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:15 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqs-0001bg-GR
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:09 +0100
Message-Id: <1504790904-17018-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/31] target/arm: Make CONTROL register banked
 for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the CONTROL register banked if v8M security extensions are enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1503414539-28762-10-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h       |  5 +++--
 target/arm/helper.c    | 21 +++++++++++----------
 target/arm/machine.c   |  3 ++-
 target/arm/translate.c |  2 +-
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5cf2e76..1d9eb36 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -422,7 +422,7 @@ typedef struct CPUARMState {
         uint32_t other_sp;
         uint32_t vecbase;
         uint32_t basepri[2];
-        uint32_t control;
+        uint32_t control[2];
         uint32_t ccr; /* Configuration and Control */
         uint32_t cfsr; /* Configurable Fault Status */
         uint32_t hfsr; /* HardFault Status */
@@ -1681,7 +1681,8 @@ static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
 static inline int arm_current_el(CPUARMState *env)
 {
     if (arm_feature(env, ARM_FEATURE_M)) {
-        return arm_v7m_is_handler_mode(env) || !(env->v7m.control & 1);
+        return arm_v7m_is_handler_mode(env) ||
+            !(env->v7m.control[env->v7m.secure] & 1);
     }
 
     if (is_a64(env)) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4f53ea1..aa64596 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6048,14 +6048,15 @@ static uint32_t v7m_pop(CPUARMState *env)
 static void switch_v7m_sp(CPUARMState *env, bool new_spsel)
 {
     uint32_t tmp;
-    bool old_spsel = env->v7m.control & R_V7M_CONTROL_SPSEL_MASK;
+    uint32_t old_control = env->v7m.control[env->v7m.secure];
+    bool old_spsel = old_control & R_V7M_CONTROL_SPSEL_MASK;
 
     if (old_spsel != new_spsel) {
         tmp = env->v7m.other_sp;
         env->v7m.other_sp = env->regs[13];
         env->regs[13] = tmp;
 
-        env->v7m.control = deposit32(env->v7m.control,
+        env->v7m.control[env->v7m.secure] = deposit32(old_control,
                                      R_V7M_CONTROL_SPSEL_SHIFT,
                                      R_V7M_CONTROL_SPSEL_LENGTH, new_spsel);
     }
@@ -6409,7 +6410,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     }
 
     lr = 0xfffffff1;
-    if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
+    if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) {
         lr |= 4;
     }
     if (!arm_v7m_is_handler_mode(env)) {
@@ -8827,7 +8828,7 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         return xpsr_read(env) & mask;
         break;
     case 20: /* CONTROL */
-        return env->v7m.control;
+        return env->v7m.control[env->v7m.secure];
     }
 
     if (el == 0) {
@@ -8836,10 +8837,10 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
 
     switch (reg) {
     case 8: /* MSP */
-        return (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) ?
+        return (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) ?
             env->v7m.other_sp : env->regs[13];
     case 9: /* PSP */
-        return (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) ?
+        return (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) ?
             env->regs[13] : env->v7m.other_sp;
     case 16: /* PRIMASK */
         return env->v7m.primask[env->v7m.secure];
@@ -8888,14 +8889,14 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         }
         break;
     case 8: /* MSP */
-        if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
+        if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) {
             env->v7m.other_sp = val;
         } else {
             env->regs[13] = val;
         }
         break;
     case 9: /* PSP */
-        if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
+        if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) {
             env->regs[13] = val;
         } else {
             env->v7m.other_sp = val;
@@ -8926,8 +8927,8 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         if (!arm_v7m_is_handler_mode(env)) {
             switch_v7m_sp(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
-        env->v7m.control &= ~R_V7M_CONTROL_NPRIV_MASK;
-        env->v7m.control |= val & R_V7M_CONTROL_NPRIV_MASK;
+        env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
+        env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "Attempt to write unknown special"
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 94f7279..5e379ed 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -116,7 +116,7 @@ static const VMStateDescription vmstate_m = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(env.v7m.vecbase, ARMCPU),
         VMSTATE_UINT32(env.v7m.basepri[M_REG_NS], ARMCPU),
-        VMSTATE_UINT32(env.v7m.control, ARMCPU),
+        VMSTATE_UINT32(env.v7m.control[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.ccr, ARMCPU),
         VMSTATE_UINT32(env.v7m.cfsr, ARMCPU),
         VMSTATE_UINT32(env.v7m.hfsr, ARMCPU),
@@ -253,6 +253,7 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.v7m.basepri[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.primask[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.faultmask[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.v7m.control[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/arm/translate.c b/target/arm/translate.c
index dea0a6f..6aa2d7c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12241,7 +12241,7 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         if (xpsr & XPSR_EXCP) {
             mode = "handler";
         } else {
-            if (env->v7m.control & R_V7M_CONTROL_NPRIV_MASK) {
+            if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_NPRIV_MASK) {
                 mode = "unpriv-thread";
             } else {
                 mode = "priv-thread";
-- 
2.7.4
