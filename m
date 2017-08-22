Received: from eggs.gnu.org ([2001:4830:134:3::10]:53442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnr-0006Vm-DI
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnm-0003Ca-Jb
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:47 +0100
Message-Id: <1503414539-28762-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 08/20] target/arm: Make FAULTMASK register
 banked for v8M
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

Make the FAULTMASK register banked if v8M security extensions are enabled.

Note that we do not yet implement the functionality of the new
AIRCR.PRIS bit (which allows the effect of the NS copy of FAULTMASK to
be restricted).

This patch includes the code to determine for v8M which copy
of FAULTMASK should be updated on exception exit; further
changes will be required to the exception exit code in general
to support v8M, so this is just a small piece of that.

The v8M ARM ARM introduces a notation where individual paragraphs
are labelled with R (for rule) or I (for information) followed
by a random group of subscript letters. In comments where we want
to refer to a particular part of the manual we use this convention,
which should be more stable across document revisions than using
section or page numbers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      | 14 ++++++++++++--
 hw/intc/armv7m_nvic.c |  9 ++++++++-
 target/arm/helper.c   | 20 ++++++++++++++++----
 target/arm/machine.c  |  5 +++--
 4 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fee337b..edd4c9e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -432,7 +432,7 @@ typedef struct CPUARMState {
         unsigned mpu_ctrl; /* MPU_CTRL */
         int exception;
         uint32_t primask[2];
-        uint32_t faultmask;
+        uint32_t faultmask[2];
         uint32_t secure; /* Is CPU in Secure state? (not guest visible) */
     } v7m;
 
@@ -1443,6 +1443,16 @@ void armv7m_nvic_acknowledge_irq(void *opaque);
  * (Ignoring -1, this is the same as the RETTOBASE value before completion.)
  */
 int armv7m_nvic_complete_irq(void *opaque, int irq);
+/**
+ * armv7m_nvic_raw_execution_priority: return the raw execution priority
+ * @opaque: the NVIC
+ *
+ * Returns: the raw execution priority as defined by the v8M architecture.
+ * This is the execution priority minus the effects of AIRCR.PRIS,
+ * and minus any PRIMASK/FAULTMASK/BASEPRI priority boosting.
+ * (v8M ARM ARM I_PKLD.)
+ */
+int armv7m_nvic_raw_execution_priority(void *opaque);
 
 /* Interface for defining coprocessor registers.
  * Registers are defined in tables of arm_cp_reginfo structs
@@ -2228,7 +2238,7 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
          * we're in a HardFault or NMI handler.
          */
         if ((env->v7m.exception > 0 && env->v7m.exception <= 3)
-            || env->v7m.faultmask) {
+            || env->v7m.faultmask[env->v7m.secure]) {
             mmu_idx = ARMMMUIdx_MNegPri;
         }
 
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a654792..babdc3b 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -167,7 +167,7 @@ static inline int nvic_exec_prio(NVICState *s)
     CPUARMState *env = &s->cpu->env;
     int running;
 
-    if (env->v7m.faultmask) {
+    if (env->v7m.faultmask[env->v7m.secure]) {
         running = -1;
     } else if (env->v7m.primask[env->v7m.secure]) {
         running = 0;
@@ -187,6 +187,13 @@ bool armv7m_nvic_can_take_pending_exception(void *opaque)
     return nvic_exec_prio(s) > nvic_pending_prio(s);
 }
 
+int armv7m_nvic_raw_execution_priority(void *opaque)
+{
+    NVICState *s = opaque;
+
+    return s->exception_prio;
+}
+
 /* caller must call nvic_irq_update() after this */
 static void set_prio(NVICState *s, unsigned irq, uint8_t prio)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c0a6dbd..b8f3b23 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6171,8 +6171,20 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     }
 
     if (env->v7m.exception != ARMV7M_EXCP_NMI) {
-        /* Auto-clear FAULTMASK on return from other than NMI */
-        env->v7m.faultmask = 0;
+        /* Auto-clear FAULTMASK on return from other than NMI.
+         * If the security extension is implemented then this only
+         * happens if the raw execution priority is >= 0; the
+         * value of the ES bit in the exception return value indicates
+         * which security state's faultmask to clear. (v8M ARM ARM R_KBNF.)
+         */
+        if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+            int es = type & 1;
+            if (armv7m_nvic_raw_execution_priority(env->nvic) >= 0) {
+                env->v7m.faultmask[es] = 0;
+            }
+        } else {
+            env->v7m.faultmask[M_REG_NS] = 0;
+        }
     }
 
     switch (armv7m_nvic_complete_irq(env->nvic, env->v7m.exception)) {
@@ -8840,7 +8852,7 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
     case 18: /* BASEPRI_MAX */
         return env->v7m.basepri[env->v7m.secure];
     case 19: /* FAULTMASK */
-        return env->v7m.faultmask;
+        return env->v7m.faultmask[env->v7m.secure];
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "Attempt to read unknown special"
                                        " register %d\n", reg);
@@ -8908,7 +8920,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         }
         break;
     case 19: /* FAULTMASK */
-        env->v7m.faultmask = val & 1;
+        env->v7m.faultmask[env->v7m.secure] = val & 1;
         break;
     case 20: /* CONTROL */
         /* Writing to the SPSEL bit only has an effect if we are in
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6f0f6c9..bd7aba1 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -102,7 +102,7 @@ static const VMStateDescription vmstate_m_faultmask_primask = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(env.v7m.faultmask, ARMCPU),
+        VMSTATE_UINT32(env.v7m.faultmask[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.primask[M_REG_NS], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -252,6 +252,7 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.v7m.secure, ARMCPU),
         VMSTATE_UINT32(env.v7m.basepri[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.primask[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.v7m.faultmask[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -289,7 +290,7 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
              * transferred using the vmstate_m_faultmask_primask subsection.
              */
             if (val & CPSR_F) {
-                env->v7m.faultmask = 1;
+                env->v7m.faultmask[M_REG_NS] = 1;
             }
             if (val & CPSR_I) {
                 env->v7m.primask[M_REG_NS] = 1;
-- 
2.7.4
