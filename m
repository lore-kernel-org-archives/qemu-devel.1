Received: from eggs.gnu.org ([2001:4830:134:3::10]:60377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XR-0003Ae-Qp
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XO-00039R-75
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XN-0002Bq-TX
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:18 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XB-00053d-Np
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:12 +0100
Message-Id: <1506012099-13605-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/31] nvic: Add cached vectpending_prio state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of looking up the pending priority
in nvic_pending_prio(), cache it in a new state struct
field. The calculation of the pending priority given
the interrupt number is more complicated in v8M with
the security extension, so the caching will be worthwhile.

This changes nvic_pending_prio() from returning a full
(group + subpriority) priority value to returning a group
priority. This doesn't require changes to its callsites
because we use it only in comparisons of the form
  execution_prio > nvic_pending_prio()
and execution priority is always a group priority, so
a test (exec prio > full prio) is true if and only if
(execprio > group_prio).

(Architecturally the expected comparison is with the
group priority for this sort of "would we preempt" test;
we were only doing a test with a full priority as an
optimisation to avoid the mask, which is possible
precisely because the two comparisons always give the
same answer.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505240046-11454-5-git-send-email-peter.maydell@linaro.org
---
 include/hw/intc/armv7m_nvic.h |  2 ++
 hw/intc/armv7m_nvic.c         | 23 +++++++++++++----------
 hw/intc/trace-events          |  2 +-
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 87c78b3..329774e 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -62,6 +62,7 @@ typedef struct NVICState {
      *  - vectpending
      *  - vectpending_is_secure
      *  - exception_prio
+     *  - vectpending_prio
      */
     unsigned int vectpending; /* highest prio pending enabled exception */
     /* true if vectpending is a banked secure exception, ie it is in
@@ -69,6 +70,7 @@ typedef struct NVICState {
      */
     bool vectpending_is_s_banked;
     int exception_prio; /* group prio of the highest prio active exception */
+    int vectpending_prio; /* group prio of the exeception in vectpending */
 
     MemoryRegion sysregmem;
     MemoryRegion sysreg_ns_mem;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a11df3d..fa5dd23 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -61,10 +61,10 @@ static const uint8_t nvic_id[] = {
 
 static int nvic_pending_prio(NVICState *s)
 {
-    /* return the priority of the current pending interrupt,
+    /* return the group priority of the current pending interrupt,
      * or NVIC_NOEXC_PRIO if no interrupt is pending
      */
-    return s->vectpending ? s->vectors[s->vectpending].prio : NVIC_NOEXC_PRIO;
+    return s->vectpending_prio;
 }
 
 /* Return the value of the ISCR RETTOBASE bit:
@@ -156,10 +156,17 @@ static void nvic_recompute_state(NVICState *s)
         active_prio &= nvic_gprio_mask(s);
     }
 
+    if (pend_prio > 0) {
+        pend_prio &= nvic_gprio_mask(s);
+    }
+
     s->vectpending = pend_irq;
+    s->vectpending_prio = pend_prio;
     s->exception_prio = active_prio;
 
-    trace_nvic_recompute_state(s->vectpending, s->exception_prio);
+    trace_nvic_recompute_state(s->vectpending,
+                               s->vectpending_prio,
+                               s->exception_prio);
 }
 
 /* Return the current execution priority of the CPU
@@ -323,7 +330,6 @@ void armv7m_nvic_acknowledge_irq(void *opaque)
     CPUARMState *env = &s->cpu->env;
     const int pending = s->vectpending;
     const int running = nvic_exec_prio(s);
-    int pendgroupprio;
     VecInfo *vec;
 
     assert(pending > ARMV7M_EXCP_RESET && pending < s->num_irq);
@@ -333,13 +339,9 @@ void armv7m_nvic_acknowledge_irq(void *opaque)
     assert(vec->enabled);
     assert(vec->pending);
 
-    pendgroupprio = vec->prio;
-    if (pendgroupprio > 0) {
-        pendgroupprio &= nvic_gprio_mask(s);
-    }
-    assert(pendgroupprio < running);
+    assert(s->vectpending_prio < running);
 
-    trace_nvic_acknowledge_irq(pending, vec->prio);
+    trace_nvic_acknowledge_irq(pending, s->vectpending_prio);
 
     vec->active = 1;
     vec->pending = 0;
@@ -1255,6 +1257,7 @@ static void armv7m_nvic_reset(DeviceState *dev)
     s->exception_prio = NVIC_NOEXC_PRIO;
     s->vectpending = 0;
     s->vectpending_is_s_banked = false;
+    s->vectpending_prio = NVIC_NOEXC_PRIO;
 }
 
 static void nvic_systick_trigger(void *opaque, int n, int level)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 4762329..5635a5f 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -167,7 +167,7 @@ gicv3_redist_set_irq(uint32_t cpu, int irq, int level) "GICv3 redistributor 0x%x
 gicv3_redist_send_sgi(uint32_t cpu, int irq) "GICv3 redistributor 0x%x pending SGI %d"
 
 # hw/intc/armv7m_nvic.c
-nvic_recompute_state(int vectpending, int exception_prio) "NVIC state recomputed: vectpending %d exception_prio %d"
+nvic_recompute_state(int vectpending, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d vectpending_prio %d exception_prio %d"
 nvic_set_prio(int irq, uint8_t prio) "NVIC set irq %d priority %d"
 nvic_irq_update(int vectpending, int pendprio, int exception_prio, int level) "NVIC vectpending %d pending prio %d exception_prio %d: setting irq line to %d"
 nvic_escalate_prio(int irq, int irqprio, int runprio) "NVIC escalating irq %d to HardFault: insufficient priority %d >= %d"
-- 
2.7.4
