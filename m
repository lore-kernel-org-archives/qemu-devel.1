Received: from eggs.gnu.org ([2001:4830:134:3::10]:60294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XP-00036c-Cm
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XM-00034Y-Sl
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:19 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XM-0002Bq-HY
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XD-00054z-Nd
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:15 +0100
Message-Id: <1506012099-13605-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/31] nvic: Implement NVIC_ITNS<n> registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For v8M, the NVIC has a new set of registers per interrupt,
NVIC_ITNS<n>. These determine whether the interrupt targets Secure
or Non-secure state. Implement the register read/write code for
these, and make them cause NVIC_IABR, NVIC_ICER, NVIC_ISER,
NVIC_ICPR, NVIC_IPR and NVIC_ISPR to RAZ/WI for non-secure
accesses to fields corresponding to interrupts which are
configured to target secure state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505240046-11454-8-git-send-email-peter.maydell@linaro.org
---
 include/hw/intc/armv7m_nvic.h |  3 ++
 hw/intc/armv7m_nvic.c         | 74 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index e96e488..ac7997c 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -58,6 +58,9 @@ typedef struct NVICState {
     /* The PRIGROUP field in AIRCR is banked */
     uint32_t prigroup[M_REG_NUM_BANKS];
 
+    /* v8M NVIC_ITNS state (stored as a bool per bit) */
+    bool itns[NVIC_MAX_VECTORS];
+
     /* The following fields are all cached state that can be recalculated
      * from the vectors[] and sec_vectors[] arrays and the prigroup field:
      *  - vectpending
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 0df5eaf..150c719 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -423,6 +423,25 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     switch (offset) {
     case 4: /* Interrupt Control Type.  */
         return ((s->num_irq - NVIC_FIRST_IRQ) / 32) - 1;
+    case 0x380 ... 0x3bf: /* NVIC_ITNS<n> */
+    {
+        int startvec = 32 * (offset - 0x380) + NVIC_FIRST_IRQ;
+        int i;
+
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return 0;
+        }
+        val = 0;
+        for (i = 0; i < 32 && startvec + i < s->num_irq; i++) {
+            if (s->itns[startvec + i]) {
+                val |= (1 << i);
+            }
+        }
+        return val;
+    }
     case 0xd00: /* CPUID Base.  */
         return cpu->midr;
     case 0xd04: /* Interrupt Control State.  */
@@ -658,6 +677,23 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
     ARMCPU *cpu = s->cpu;
 
     switch (offset) {
+    case 0x380 ... 0x3bf: /* NVIC_ITNS<n> */
+    {
+        int startvec = 32 * (offset - 0x380) + NVIC_FIRST_IRQ;
+        int i;
+
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            break;
+        }
+        for (i = 0; i < 32 && startvec + i < s->num_irq; i++) {
+            s->itns[startvec + i] = (value >> i) & 1;
+        }
+        nvic_irq_update(s);
+        break;
+    }
     case 0xd04: /* Interrupt Control State.  */
         if (value & (1 << 31)) {
             armv7m_nvic_set_pending(s, ARMV7M_EXCP_NMI);
@@ -966,7 +1002,8 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         startvec = offset - 0x180 + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
-            if (s->vectors[startvec + i].enabled) {
+            if (s->vectors[startvec + i].enabled &&
+                (attrs.secure || s->itns[startvec + i])) {
                 val |= (1 << i);
             }
         }
@@ -978,7 +1015,8 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         val = 0;
         startvec = offset - 0x280 + NVIC_FIRST_IRQ; /* vector # */
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
-            if (s->vectors[startvec + i].pending) {
+            if (s->vectors[startvec + i].pending &&
+                (attrs.secure || s->itns[startvec + i])) {
                 val |= (1 << i);
             }
         }
@@ -988,7 +1026,8 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         startvec = offset - 0x300 + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
-            if (s->vectors[startvec + i].active) {
+            if (s->vectors[startvec + i].active &&
+                (attrs.secure || s->itns[startvec + i])) {
                 val |= (1 << i);
             }
         }
@@ -998,7 +1037,9 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         startvec = offset - 0x400 + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0; i < size && startvec + i < s->num_irq; i++) {
-            val |= s->vectors[startvec + i].prio << (8 * i);
+            if (attrs.secure || s->itns[startvec + i]) {
+                val |= s->vectors[startvec + i].prio << (8 * i);
+            }
         }
         break;
     case 0xd18 ... 0xd23: /* System Handler Priority.  */
@@ -1055,7 +1096,8 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         startvec = 8 * (offset - 0x180) + NVIC_FIRST_IRQ;
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
-            if (value & (1 << i)) {
+            if (value & (1 << i) &&
+                (attrs.secure || s->itns[startvec + i])) {
                 s->vectors[startvec + i].enabled = setval;
             }
         }
@@ -1072,7 +1114,8 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         startvec = 8 * (offset - 0x280) + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
-            if (value & (1 << i)) {
+            if (value & (1 << i) &&
+                (attrs.secure || s->itns[startvec + i])) {
                 s->vectors[startvec + i].pending = setval;
             }
         }
@@ -1084,7 +1127,9 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         startvec = 8 * (offset - 0x400) + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0; i < size && startvec + i < s->num_irq; i++) {
-            set_prio(s, startvec + i, (value >> (i * 8)) & 0xff);
+            if (attrs.secure || s->itns[startvec + i]) {
+                set_prio(s, startvec + i, (value >> (i * 8)) & 0xff);
+            }
         }
         nvic_irq_update(s);
         return MEMTX_OK;
@@ -1223,6 +1268,7 @@ static const VMStateDescription vmstate_nvic_security = {
         VMSTATE_STRUCT_ARRAY(sec_vectors, NVICState, NVIC_INTERNAL_VECTORS, 1,
                              vmstate_VecInfo, VecInfo),
         VMSTATE_UINT32(prigroup[M_REG_S], NVICState),
+        VMSTATE_BOOL_ARRAY(itns, NVICState, NVIC_MAX_VECTORS),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -1288,6 +1334,20 @@ static void armv7m_nvic_reset(DeviceState *dev)
     s->vectpending = 0;
     s->vectpending_is_s_banked = false;
     s->vectpending_prio = NVIC_NOEXC_PRIO;
+
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY)) {
+        memset(s->itns, 0, sizeof(s->itns));
+    } else {
+        /* This state is constant and not guest accessible in a non-security
+         * NVIC; we set the bits to true to avoid having to do a feature
+         * bit check in the NVIC enable/pend/etc register accessors.
+         */
+        int i;
+
+        for (i = NVIC_FIRST_IRQ; i < ARRAY_SIZE(s->itns); i++) {
+            s->itns[i] = true;
+        }
+    }
 }
 
 static void nvic_systick_trigger(void *opaque, int n, int level)
-- 
2.7.4
