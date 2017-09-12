Received: from eggs.gnu.org ([2001:4830:134:3::10]:43515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph4-0003V1-VD
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph2-0006SZ-Lx
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:54 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:13:57 +0100
Message-Id: <1505240046-11454-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 10/19] nvic: Make SHPR registers banked
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

Make the set_prio() function take a bool indicating
whether to pend the secure or non-secure version of a banked
interrupt, and use this to implement the correct banking
semantics for the SHPR registers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/intc/trace-events  |  2 +-
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 852db11..00c03b4 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -349,15 +349,40 @@ int armv7m_nvic_raw_execution_priority(void *opaque)
     return s->exception_prio;
 }
 
-/* caller must call nvic_irq_update() after this */
-static void set_prio(NVICState *s, unsigned irq, uint8_t prio)
+/* caller must call nvic_irq_update() after this.
+ * secure indicates the bank to use for banked exceptions (we assert if
+ * we are passed secure=true for a non-banked exception).
+ */
+static void set_prio(NVICState *s, unsigned irq, bool secure, uint8_t prio)
 {
     assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios */
     assert(irq < s->num_irq);
 
-    s->vectors[irq].prio = prio;
+    if (secure) {
+        assert(exc_is_banked(irq));
+        s->sec_vectors[irq].prio = prio;
+    } else {
+        s->vectors[irq].prio = prio;
+    }
+
+    trace_nvic_set_prio(irq, secure, prio);
+}
+
+/* Return the current raw priority register value.
+ * secure indicates the bank to use for banked exceptions (we assert if
+ * we are passed secure=true for a non-banked exception).
+ */
+static int get_prio(NVICState *s, unsigned irq, bool secure)
+{
+    assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios */
+    assert(irq < s->num_irq);
 
-    trace_nvic_set_prio(irq, prio);
+    if (secure) {
+        assert(exc_is_banked(irq));
+        return s->sec_vectors[irq].prio;
+    } else {
+        return s->vectors[irq].prio;
+    }
 }
 
 /* Recompute state and assert irq line accordingly.
@@ -1149,6 +1174,47 @@ static bool nvic_user_access_ok(NVICState *s, hwaddr offset, MemTxAttrs attrs)
     }
 }
 
+static int shpr_bank(NVICState *s, int exc, MemTxAttrs attrs)
+{
+    /* Behaviour for the SHPR register field for this exception:
+     * return M_REG_NS to use the nonsecure vector (including for
+     * non-banked exceptions), M_REG_S for the secure version of
+     * a banked exception, and -1 if this field should RAZ/WI.
+     */
+    switch (exc) {
+    case ARMV7M_EXCP_MEM:
+    case ARMV7M_EXCP_USAGE:
+    case ARMV7M_EXCP_SVC:
+    case ARMV7M_EXCP_PENDSV:
+    case ARMV7M_EXCP_SYSTICK:
+        /* Banked exceptions */
+        return attrs.secure;
+    case ARMV7M_EXCP_BUS:
+        /* Not banked, RAZ/WI from nonsecure if BFHFNMINS is zero */
+        if (!attrs.secure &&
+            !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            return -1;
+        }
+        return M_REG_NS;
+    case ARMV7M_EXCP_SECURE:
+        /* Not banked, RAZ/WI from nonsecure */
+        if (!attrs.secure) {
+            return -1;
+        }
+        return M_REG_NS;
+    case ARMV7M_EXCP_DEBUG:
+        /* Not banked. TODO should RAZ/WI if DEMCR.SDME is set */
+        return M_REG_NS;
+    case 8 ... 10:
+    case 13:
+        /* RES0 */
+        return -1;
+    default:
+        /* Not reachable due to decode of SHPR register addresses */
+        g_assert_not_reached();
+    }
+}
+
 static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
                                     uint64_t *data, unsigned size,
                                     MemTxAttrs attrs)
@@ -1213,10 +1279,16 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
             }
         }
         break;
-    case 0xd18 ... 0xd23: /* System Handler Priority.  */
+    case 0xd18 ... 0xd23: /* System Handler Priority (SHPR1, SHPR2, SHPR3) */
         val = 0;
         for (i = 0; i < size; i++) {
-            val |= s->vectors[(offset - 0xd14) + i].prio << (i * 8);
+            unsigned hdlidx = (offset - 0xd14) + i;
+            int sbank = shpr_bank(s, hdlidx, attrs);
+
+            if (sbank < 0) {
+                continue;
+            }
+            val = deposit32(val, i * 8, 8, get_prio(s, hdlidx, sbank));
         }
         break;
     case 0xfe0 ... 0xfff: /* ID.  */
@@ -1299,15 +1371,21 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
 
         for (i = 0; i < size && startvec + i < s->num_irq; i++) {
             if (attrs.secure || s->itns[startvec + i]) {
-                set_prio(s, startvec + i, (value >> (i * 8)) & 0xff);
+                set_prio(s, startvec + i, false, (value >> (i * 8)) & 0xff);
             }
         }
         nvic_irq_update(s);
         return MEMTX_OK;
-    case 0xd18 ... 0xd23: /* System Handler Priority.  */
+    case 0xd18 ... 0xd23: /* System Handler Priority (SHPR1, SHPR2, SHPR3) */
         for (i = 0; i < size; i++) {
             unsigned hdlidx = (offset - 0xd14) + i;
-            set_prio(s, hdlidx, (value >> (i * 8)) & 0xff);
+            int newprio = extract32(value, i * 8, 8);
+            int sbank = shpr_bank(s, hdlidx, attrs);
+
+            if (sbank < 0) {
+                continue;
+            }
+            set_prio(s, hdlidx, sbank, newprio);
         }
         nvic_irq_update(s);
         return MEMTX_OK;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 94038b6..29bd308 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -169,7 +169,7 @@ gicv3_redist_send_sgi(uint32_t cpu, int irq) "GICv3 redistributor 0x%x pending S
 # hw/intc/armv7m_nvic.c
 nvic_recompute_state(int vectpending, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d vectpending_prio %d exception_prio %d"
 nvic_recompute_state_secure(int vectpending, bool vectpending_is_s_banked, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d is_s_banked %d vectpending_prio %d exception_prio %d"
-nvic_set_prio(int irq, uint8_t prio) "NVIC set irq %d priority %d"
+nvic_set_prio(int irq, bool secure, uint8_t prio) "NVIC set irq %d secure-bank %d priority %d"
 nvic_irq_update(int vectpending, int pendprio, int exception_prio, int level) "NVIC vectpending %d pending prio %d exception_prio %d: setting irq line to %d"
 nvic_escalate_prio(int irq, int irqprio, int runprio) "NVIC escalating irq %d to HardFault: insufficient priority %d >= %d"
 nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
-- 
2.7.4
