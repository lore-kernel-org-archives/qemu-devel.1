Received: from eggs.gnu.org ([2001:4830:134:3::10]:52345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduq-0004PI-9J
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdth-0006Vt-4D
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdtg-0006Ug-P8
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdte-00078T-3f
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:34 +0100
Message-Id: <20180814181815.23348-5-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/45] nvic: Change NVIC to support ARMv6-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julia Suvorova <jusual@mail.ru>

The differences from ARMv7-M NVIC are:
  * ARMv6-M only supports up to 32 external interrupts
   (configurable feature already). The ICTR is reserved.
  * Active Bit Register is reserved.
  * ARMv6-M supports 4 priority levels against 256 in ARMv7-M.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/armv7m_nvic.h |  1 +
 hw/intc/armv7m_nvic.c         | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 8bc29112e3a..a472c9b8f05 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -57,6 +57,7 @@ typedef struct NVICState {
     VecInfo sec_vectors[NVIC_INTERNAL_VECTORS];
     /* The PRIGROUP field in AIRCR is banked */
     uint32_t prigroup[M_REG_NUM_BANKS];
+    uint8_t num_prio_bits;
 
     /* v8M NVIC_ITNS state (stored as a bool per bit) */
     bool itns[NVIC_MAX_VECTORS];
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 49e8e2b94d4..351b69ab40b 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -420,6 +420,8 @@ static void set_prio(NVICState *s, unsigned irq, bool secure, uint8_t prio)
     assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios */
     assert(irq < s->num_irq);
 
+    prio &= MAKE_64BIT_MASK(8 - s->num_prio_bits, s->num_prio_bits);
+
     if (secure) {
         assert(exc_is_banked(irq));
         s->sec_vectors[irq].prio = prio;
@@ -779,6 +781,9 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
 
     switch (offset) {
     case 4: /* Interrupt Control Type.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
         return ((s->num_irq - NVIC_FIRST_IRQ) / 32) - 1;
     case 0xc: /* CPPWR */
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
@@ -1278,9 +1283,12 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
                               "Setting VECTRESET when not in DEBUG mode "
                               "is UNPREDICTABLE\n");
             }
-            s->prigroup[attrs.secure] = extract32(value,
-                                                  R_V7M_AIRCR_PRIGROUP_SHIFT,
-                                                  R_V7M_AIRCR_PRIGROUP_LENGTH);
+            if (arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+                s->prigroup[attrs.secure] =
+                    extract32(value,
+                              R_V7M_AIRCR_PRIGROUP_SHIFT,
+                              R_V7M_AIRCR_PRIGROUP_LENGTH);
+            }
             if (attrs.secure) {
                 /* These bits are only writable by secure */
                 cpu->env.v7m.aircr = value &
@@ -1791,6 +1799,11 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         break;
     case 0x300 ... 0x33f: /* NVIC Active */
         val = 0;
+
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+            break;
+        }
+
         startvec = 8 * (offset - 0x300) + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
@@ -2260,6 +2273,8 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     /* include space for internal exception vectors */
     s->num_irq += NVIC_FIRST_IRQ;
 
+    s->num_prio_bits = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 8 : 2;
+
     object_property_set_bool(OBJECT(&s->systick[M_REG_NS]), true,
                              "realized", &err);
     if (err != NULL) {
-- 
2.18.0
