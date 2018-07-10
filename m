Received: from eggs.gnu.org ([2001:4830:134:3::10]:41811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fcuec-0005kJ-EG
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fcueX-0005Jq-Dz
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:34:14 -0400
Received: from smtp38.i.mail.ru ([94.100.177.98]:37930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fcueX-0005Ix-1B
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:34:09 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Tue, 10 Jul 2018 18:33:35 +0300
Message-Id: <20180710153335.1232-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] nvic: Change NVIC to support ARMv6-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

The differences from ARMv7-M NVIC are:
  * ARMv6-M only supports up to 32 external interrupts
   (configurable feature already). The ICTR is reserved.
  * Active Bit Register is reserved.
  * ARMv6-M supports 4 priority levels against 256 in ARMv7-M.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 hw/intc/armv7m_nvic.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 38aaf3dc8e..8545c87caa 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -420,6 +420,10 @@ static void set_prio(NVICState *s, unsigned irq, bool secure, uint8_t prio)
     assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios */
     assert(irq < s->num_irq);
 
+    if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+        prio &= 0xc0;
+    }
+
     if (secure) {
         assert(exc_is_banked(irq));
         s->sec_vectors[irq].prio = prio;
@@ -777,6 +781,9 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
 
     switch (offset) {
     case 4: /* Interrupt Control Type.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
         return ((s->num_irq - NVIC_FIRST_IRQ) / 32) - 1;
     case 0xc: /* CPPWR */
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
@@ -850,7 +857,10 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd08: /* Vector Table Offset.  */
         return cpu->env.v7m.vecbase[attrs.secure];
     case 0xd0c: /* Application Interrupt/Reset Control (AIRCR) */
-        val = 0xfa050000 | (s->prigroup[attrs.secure] << 8);
+        val = 0xfa050000;
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            val |= (s->prigroup[attrs.secure] << 8);
+        }
         if (attrs.secure) {
             /* s->aircr stores PRIS, BFHFNMINS, SYSRESETREQS */
             val |= cpu->env.v7m.aircr;
@@ -1274,6 +1284,10 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
                               "Setting VECTRESET when not in DEBUG mode "
                               "is UNPREDICTABLE\n");
             }
+            if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+                nvic_irq_update(s);
+                break;
+            }
             s->prigroup[attrs.secure] = extract32(value,
                                                   R_V7M_AIRCR_PRIGROUP_SHIFT,
                                                   R_V7M_AIRCR_PRIGROUP_LENGTH);
@@ -1785,6 +1799,11 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
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
@@ -2160,13 +2179,15 @@ static Property props_nvic[] = {
 
 static void armv7m_nvic_reset(DeviceState *dev)
 {
-    int resetprio;
+    int resetprio, resetprigroup;
     NVICState *s = NVIC(dev);
 
     memset(s->vectors, 0, sizeof(s->vectors));
     memset(s->sec_vectors, 0, sizeof(s->sec_vectors));
-    s->prigroup[M_REG_NS] = 0;
-    s->prigroup[M_REG_S] = 0;
+
+    resetprigroup = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 0 : 5;
+    s->prigroup[M_REG_NS] = resetprigroup;
+    s->prigroup[M_REG_S] = resetprigroup;
 
     s->vectors[ARMV7M_EXCP_NMI].enabled = 1;
     /* MEM, BUS, and USAGE are enabled through
-- 
2.17.1
