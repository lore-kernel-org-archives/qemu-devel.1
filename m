Received: from eggs.gnu.org ([2001:4830:134:3::10]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAno-0006QJ-Da
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnm-0003D1-VV
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:12 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:46 +0100
Message-Id: <1503414539-28762-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 07/20] target/arm: Make PRIMASK register banked
 for v8M
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

Make the PRIMASK register banked if v8M security extensions are enabled.

Note that we do not yet implement the functionality of the new
AIRCR.PRIS bit (which allows the effect of the NS copy of PRIMASK to
be restricted).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      | 2 +-
 hw/intc/armv7m_nvic.c | 2 +-
 target/arm/helper.c   | 4 ++--
 target/arm/machine.c  | 9 +++++++--
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0c28dfd..fee337b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -431,7 +431,7 @@ typedef struct CPUARMState {
         uint32_t bfar; /* BusFault Address */
         unsigned mpu_ctrl; /* MPU_CTRL */
         int exception;
-        uint32_t primask;
+        uint32_t primask[2];
         uint32_t faultmask;
         uint32_t secure; /* Is CPU in Secure state? (not guest visible) */
     } v7m;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 2a41e5d..a654792 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -169,7 +169,7 @@ static inline int nvic_exec_prio(NVICState *s)
 
     if (env->v7m.faultmask) {
         running = -1;
-    } else if (env->v7m.primask) {
+    } else if (env->v7m.primask[env->v7m.secure]) {
         running = 0;
     } else if (env->v7m.basepri[env->v7m.secure] > 0) {
         running = env->v7m.basepri[env->v7m.secure] & nvic_gprio_mask(s);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1087f19..c0a6dbd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8835,7 +8835,7 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         return (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) ?
             env->regs[13] : env->v7m.other_sp;
     case 16: /* PRIMASK */
-        return env->v7m.primask;
+        return env->v7m.primask[env->v7m.secure];
     case 17: /* BASEPRI */
     case 18: /* BASEPRI_MAX */
         return env->v7m.basepri[env->v7m.secure];
@@ -8895,7 +8895,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         }
         break;
     case 16: /* PRIMASK */
-        env->v7m.primask = val & 1;
+        env->v7m.primask[env->v7m.secure] = val & 1;
         break;
     case 17: /* BASEPRI */
         env->v7m.basepri[env->v7m.secure] = val & 0xff;
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 8476efd..6f0f6c9 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -103,7 +103,7 @@ static const VMStateDescription vmstate_m_faultmask_primask = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(env.v7m.faultmask, ARMCPU),
-        VMSTATE_UINT32(env.v7m.primask, ARMCPU),
+        VMSTATE_UINT32(env.v7m.primask[M_REG_NS], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -251,6 +251,7 @@ static const VMStateDescription vmstate_m_security = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(env.v7m.secure, ARMCPU),
         VMSTATE_UINT32(env.v7m.basepri[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.v7m.primask[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -271,9 +272,13 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
              * differences are that the T bit is not in the same place, the
              * primask/faultmask info may be in the CPSR I and F bits, and
              * we do not want the mode bits.
+             * We know that this cleanup happened before v8M, so there
+             * is no complication with banked primask/faultmask.
              */
             uint32_t newval = val;
 
+            assert(!arm_feature(env, ARM_FEATURE_M_SECURITY));
+
             newval &= (CPSR_NZCV | CPSR_Q | CPSR_IT | CPSR_GE);
             if (val & CPSR_T) {
                 newval |= XPSR_T;
@@ -287,7 +292,7 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
                 env->v7m.faultmask = 1;
             }
             if (val & CPSR_I) {
-                env->v7m.primask = 1;
+                env->v7m.primask[M_REG_NS] = 1;
             }
             val = newval;
         }
-- 
2.7.4
