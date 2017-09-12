Received: from eggs.gnu.org ([2001:4830:134:3::10]:43661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph9-0003bn-Jz
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph8-0006Wg-54
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:59 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:14:06 +0100
Message-Id: <1505240046-11454-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 19/19] nvic: Support banked exceptions in
 acknowledge and complete
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

Update armv7m_nvic_acknowledge_irq() and armv7m_nvic_complete_irq()
to handle banked exceptions:
 * acknowledge needs to use the correct vector, which may be
   in sec_vectors[]
 * acknowledge needs to return to its caller whether the
   exception should be taken to secure or non-secure state
 * complete needs its caller to tell it whether the exception
   being completed is a secure one or not

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      | 15 +++++++++++++--
 hw/intc/armv7m_nvic.c | 26 ++++++++++++++++++++------
 target/arm/helper.c   |  8 +++++---
 hw/intc/trace-events  |  4 ++--
 4 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 02be3ca..9c336bc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1476,18 +1476,29 @@ static inline bool armv7m_nvic_can_take_pending_exception(void *opaque)
  * of architecturally banked exceptions.
  */
 void armv7m_nvic_set_pending(void *opaque, int irq, bool secure);
-void armv7m_nvic_acknowledge_irq(void *opaque);
+/**
+ * armv7m_nvic_acknowledge_irq: make highest priority pending exception active
+ * @opaque: the NVIC
+ *
+ * Move the current highest priority pending exception from the pending
+ * state to the active state, and update v7m.exception to indicate that
+ * it is the exception currently being handled.
+ *
+ * Returns: true if exception should be taken to Secure state, false for NS
+ */
+bool armv7m_nvic_acknowledge_irq(void *opaque);
 /**
  * armv7m_nvic_complete_irq: complete specified interrupt or exception
  * @opaque: the NVIC
  * @irq: the exception number to complete
+ * @secure: true if this exception was secure
  *
  * Returns: -1 if the irq was not active
  *           1 if completing this irq brought us back to base (no active irqs)
  *           0 if there is still an irq active after this one was completed
  * (Ignoring -1, this is the same as the RETTOBASE value before completion.)
  */
-int armv7m_nvic_complete_irq(void *opaque, int irq);
+int armv7m_nvic_complete_irq(void *opaque, int irq, bool secure);
 /**
  * armv7m_nvic_raw_execution_priority: return the raw execution priority
  * @opaque: the NVIC
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 9613990..078532a 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -586,24 +586,32 @@ void armv7m_nvic_set_pending(void *opaque, int irq, bool secure)
 }
 
 /* Make pending IRQ active.  */
-void armv7m_nvic_acknowledge_irq(void *opaque)
+bool armv7m_nvic_acknowledge_irq(void *opaque)
 {
     NVICState *s = (NVICState *)opaque;
     CPUARMState *env = &s->cpu->env;
     const int pending = s->vectpending;
     const int running = nvic_exec_prio(s);
     VecInfo *vec;
+    bool targets_secure;
 
     assert(pending > ARMV7M_EXCP_RESET && pending < s->num_irq);
 
-    vec = &s->vectors[pending];
+    if (s->vectpending_is_s_banked) {
+        vec = &s->sec_vectors[pending];
+        targets_secure = true;
+    } else {
+        vec = &s->vectors[pending];
+        targets_secure = !exc_is_banked(s->vectpending) &&
+            exc_targets_secure(s, s->vectpending);
+    }
 
     assert(vec->enabled);
     assert(vec->pending);
 
     assert(s->vectpending_prio < running);
 
-    trace_nvic_acknowledge_irq(pending, s->vectpending_prio);
+    trace_nvic_acknowledge_irq(pending, s->vectpending_prio, targets_secure);
 
     vec->active = 1;
     vec->pending = 0;
@@ -611,9 +619,11 @@ void armv7m_nvic_acknowledge_irq(void *opaque)
     env->v7m.exception = s->vectpending;
 
     nvic_irq_update(s);
+
+    return targets_secure;
 }
 
-int armv7m_nvic_complete_irq(void *opaque, int irq)
+int armv7m_nvic_complete_irq(void *opaque, int irq, bool secure)
 {
     NVICState *s = (NVICState *)opaque;
     VecInfo *vec;
@@ -621,9 +631,13 @@ int armv7m_nvic_complete_irq(void *opaque, int irq)
 
     assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
 
-    vec = &s->vectors[irq];
+    if (secure && exc_is_banked(irq)) {
+        vec = &s->sec_vectors[irq];
+    } else {
+        vec = &s->vectors[irq];
+    }
 
-    trace_nvic_complete_irq(irq);
+    trace_nvic_complete_irq(irq, secure);
 
     if (!vec->active) {
         /* Tell the caller this was an illegal exception return */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b64acd8..8be78ea 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6218,6 +6218,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     bool return_to_sp_process = false;
     bool return_to_handler = false;
     bool rettobase = false;
+    bool exc_secure = false;
 
     /* We can only get here from an EXCP_EXCEPTION_EXIT, and
      * gen_bx_excret() enforces the architectural rule
@@ -6256,16 +6257,17 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
          * which security state's faultmask to clear. (v8M ARM ARM R_KBNF.)
          */
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-            int es = excret & R_V7M_EXCRET_ES_MASK;
+            exc_secure = excret & R_V7M_EXCRET_ES_MASK;
             if (armv7m_nvic_raw_execution_priority(env->nvic) >= 0) {
-                env->v7m.faultmask[es] = 0;
+                env->v7m.faultmask[exc_secure] = 0;
             }
         } else {
             env->v7m.faultmask[M_REG_NS] = 0;
         }
     }
 
-    switch (armv7m_nvic_complete_irq(env->nvic, env->v7m.exception)) {
+    switch (armv7m_nvic_complete_irq(env->nvic, env->v7m.exception,
+                                     exc_secure)) {
     case -1:
         /* attempt to exit an exception that isn't active */
         ufault = true;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 29bd308..b86f242 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -176,8 +176,8 @@ nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
 nvic_set_pending(int irq, bool secure, int en, int prio) "NVIC set pending irq %d secure-bank %d (enabled: %d priority %d)"
 nvic_clear_pending(int irq, bool secure, int en, int prio) "NVIC clear pending irq %d secure-bank %d (enabled: %d priority %d)"
 nvic_set_pending_level(int irq) "NVIC set pending: irq %d higher prio than vectpending: setting irq line to 1"
-nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (prio %d)"
-nvic_complete_irq(int irq) "NVIC complete IRQ %d"
+nvic_acknowledge_irq(int irq, int prio, bool targets_secure) "NVIC acknowledge IRQ: %d now active (prio %d targets_secure %d)"
+nvic_complete_irq(int irq, bool secure) "NVIC complete IRQ %d (secure %d)"
 nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
 nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-- 
2.7.4
