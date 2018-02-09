Received: from eggs.gnu.org ([2001:4830:134:3::10]:39795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sp-00011T-L5
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sn-0001x5-BT
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:31 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Sn-0001oy-2V
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:29 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sa-0002Xq-Uy
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:16 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:02:46 +0000
Message-Id: <20180209110314.11766-3-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/30] target/arm: Split "get pending exception
 info" from "acknowledge it"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently armv7m_nvic_acknowledge_irq() does three things:
 * make the current highest priority pending interrupt active
 * return a bool indicating whether that interrupt is targeting
   Secure or NonSecure state
 * implicitly tell the caller which is the highest priority
   pending interrupt by setting env->v7m.exception

We need to split these jobs, because v7m_exception_taken()
needs to know whether the pending interrupt targets Secure so
it can choose to stack callee-saves registers or not, but it
must not make the interrupt active until after it has done
that stacking, in case the stacking causes a derived exception.
Similarly, it needs to know the number of the pending interrupt
so it can read the correct vector table entry before the
interrupt is made active, because vector table reads might
also cause a derived exception.

Create a new armv7m_nvic_get_pending_irq_info() function which simply
returns information about the highest priority pending interrupt, and
use it to rearrange the v7m_exception_taken() code so we don't
acknowledge the exception until we've done all the things which could
possibly cause a derived exception.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1517324542-6607-3-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h      | 19 ++++++++++++++++---
 hw/intc/armv7m_nvic.c | 30 +++++++++++++++++++++++-------
 target/arm/helper.c   | 16 ++++++++++++----
 hw/intc/trace-events  |  3 ++-
 4 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b3d4da3048..3533bb8e9a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1518,6 +1518,21 @@ void armv7m_nvic_set_pending(void *opaque, int irq, bool secure);
  * a different exception).
  */
 void armv7m_nvic_set_pending_derived(void *opaque, int irq, bool secure);
+/**
+ * armv7m_nvic_get_pending_irq_info: return highest priority pending
+ *    exception, and whether it targets Secure state
+ * @opaque: the NVIC
+ * @pirq: set to pending exception number
+ * @ptargets_secure: set to whether pending exception targets Secure
+ *
+ * This function writes the number of the highest priority pending
+ * exception (the one which would be made active by
+ * armv7m_nvic_acknowledge_irq()) to @pirq, and sets @ptargets_secure
+ * to true if the current highest priority pending exception should
+ * be taken to Secure state, false for NS.
+ */
+void armv7m_nvic_get_pending_irq_info(void *opaque, int *pirq,
+                                      bool *ptargets_secure);
 /**
  * armv7m_nvic_acknowledge_irq: make highest priority pending exception active
  * @opaque: the NVIC
@@ -1525,10 +1540,8 @@ void armv7m_nvic_set_pending_derived(void *opaque, int irq, bool secure);
  * Move the current highest priority pending exception from the pending
  * state to the active state, and update v7m.exception to indicate that
  * it is the exception currently being handled.
- *
- * Returns: true if exception should be taken to Secure state, false for NS
  */
-bool armv7m_nvic_acknowledge_irq(void *opaque);
+void armv7m_nvic_acknowledge_irq(void *opaque);
 /**
  * armv7m_nvic_complete_irq: complete specified interrupt or exception
  * @opaque: the NVIC
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index b4a6e7c62e..360889d30b 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -650,24 +650,20 @@ void armv7m_nvic_set_pending_derived(void *opaque, int irq, bool secure)
 }
 
 /* Make pending IRQ active.  */
-bool armv7m_nvic_acknowledge_irq(void *opaque)
+void armv7m_nvic_acknowledge_irq(void *opaque)
 {
     NVICState *s = (NVICState *)opaque;
     CPUARMState *env = &s->cpu->env;
     const int pending = s->vectpending;
     const int running = nvic_exec_prio(s);
     VecInfo *vec;
-    bool targets_secure;
 
     assert(pending > ARMV7M_EXCP_RESET && pending < s->num_irq);
 
     if (s->vectpending_is_s_banked) {
         vec = &s->sec_vectors[pending];
-        targets_secure = true;
     } else {
         vec = &s->vectors[pending];
-        targets_secure = !exc_is_banked(s->vectpending) &&
-            exc_targets_secure(s, s->vectpending);
     }
 
     assert(vec->enabled);
@@ -675,7 +671,7 @@ bool armv7m_nvic_acknowledge_irq(void *opaque)
 
     assert(s->vectpending_prio < running);
 
-    trace_nvic_acknowledge_irq(pending, s->vectpending_prio, targets_secure);
+    trace_nvic_acknowledge_irq(pending, s->vectpending_prio);
 
     vec->active = 1;
     vec->pending = 0;
@@ -683,8 +679,28 @@ bool armv7m_nvic_acknowledge_irq(void *opaque)
     write_v7m_exception(env, s->vectpending);
 
     nvic_irq_update(s);
+}
+
+void armv7m_nvic_get_pending_irq_info(void *opaque,
+                                      int *pirq, bool *ptargets_secure)
+{
+    NVICState *s = (NVICState *)opaque;
+    const int pending = s->vectpending;
+    bool targets_secure;
+
+    assert(pending > ARMV7M_EXCP_RESET && pending < s->num_irq);
+
+    if (s->vectpending_is_s_banked) {
+        targets_secure = true;
+    } else {
+        targets_secure = !exc_is_banked(pending) &&
+            exc_targets_secure(s, pending);
+    }
+
+    trace_nvic_get_pending_irq_info(pending, targets_secure);
 
-    return targets_secure;
+    *ptargets_secure = targets_secure;
+    *pirq = pending;
 }
 
 int armv7m_nvic_complete_irq(void *opaque, int irq, bool secure)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bfce09643b..6062f380d4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6395,12 +6395,12 @@ static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
     }
 }
 
-static uint32_t arm_v7m_load_vector(ARMCPU *cpu, bool targets_secure)
+static uint32_t arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure)
 {
     CPUState *cs = CPU(cpu);
     CPUARMState *env = &cpu->env;
     MemTxResult result;
-    hwaddr vec = env->v7m.vecbase[targets_secure] + env->v7m.exception * 4;
+    hwaddr vec = env->v7m.vecbase[targets_secure] + exc * 4;
     uint32_t addr;
 
     addr = address_space_ldl(cs->as, vec,
@@ -6462,8 +6462,9 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain)
     CPUARMState *env = &cpu->env;
     uint32_t addr;
     bool targets_secure;
+    int exc;
 
-    targets_secure = armv7m_nvic_acknowledge_irq(env->nvic);
+    armv7m_nvic_get_pending_irq_info(env->nvic, &exc, &targets_secure);
 
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
@@ -6531,6 +6532,14 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain)
         }
     }
 
+    addr = arm_v7m_load_vector(cpu, exc, targets_secure);
+
+    /* Now we've done everything that might cause a derived exception
+     * we can go ahead and activate whichever exception we're going to
+     * take (which might now be the derived exception).
+     */
+    armv7m_nvic_acknowledge_irq(env->nvic);
+
     /* Switch to target security state -- must do this before writing SPSEL */
     switch_v7m_security_state(env, targets_secure);
     write_v7m_control_spsel(env, 0);
@@ -6538,7 +6547,6 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain)
     /* Clear IT bits */
     env->condexec_bits = 0;
     env->regs[14] = lr;
-    addr = arm_v7m_load_vector(cpu, targets_secure);
     env->regs[15] = addr & 0xfffffffe;
     env->thumb = addr & 1;
 }
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 09e87d14bd..4092d2825e 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -180,7 +180,8 @@ nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
 nvic_set_pending(int irq, bool secure, bool derived, int en, int prio) "NVIC set pending irq %d secure-bank %d derived %d (enabled: %d priority %d)"
 nvic_clear_pending(int irq, bool secure, int en, int prio) "NVIC clear pending irq %d secure-bank %d (enabled: %d priority %d)"
 nvic_set_pending_level(int irq) "NVIC set pending: irq %d higher prio than vectpending: setting irq line to 1"
-nvic_acknowledge_irq(int irq, int prio, bool targets_secure) "NVIC acknowledge IRQ: %d now active (prio %d targets_secure %d)"
+nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (prio %d)"
+nvic_get_pending_irq_info(int irq, bool secure) "NVIC next IRQ %d: targets_secure: %d"
 nvic_complete_irq(int irq, bool secure) "NVIC complete IRQ %d (secure %d)"
 nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
 nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-- 
2.16.1
