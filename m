Received: from eggs.gnu.org ([2001:4830:134:3::10]:41024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0C-0003y9-Vs
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0C-0007og-2F
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:21 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 16:58:03 +0000
Message-Id: <20180209165810.6668-5-peter.maydell@linaro.org>
In-Reply-To: <20180209165810.6668-1-peter.maydell@linaro.org>
References: <20180209165810.6668-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 04/11] hw/intc/armv7m_nvic: Implement v8M
 CPPWR register
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

The Coprocessor Power Control Register (CPPWR) is new in v8M.
It allows software to control whether coprocessors are allowed
to power down and lose their state. QEMU doesn't have any
notion of power control, so we choose the IMPDEF option of
making the whole register RAZ/WI (indicating that no coprocessors
can ever power down and lose state).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 74b25ce92c..eb49fd77c7 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -776,6 +776,14 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     switch (offset) {
     case 4: /* Interrupt Control Type.  */
         return ((s->num_irq - NVIC_FIRST_IRQ) / 32) - 1;
+    case 0xc: /* CPPWR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        /* We make the IMPDEF choice that nothing can ever go into a
+         * non-retentive power state, which allows us to RAZ/WI this.
+         */
+        return 0;
     case 0x380 ... 0x3bf: /* NVIC_ITNS<n> */
     {
         int startvec = 8 * (offset - 0x380) + NVIC_FIRST_IRQ;
@@ -1175,6 +1183,12 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
     ARMCPU *cpu = s->cpu;
 
     switch (offset) {
+    case 0xc: /* CPPWR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        /* Make the IMPDEF choice to RAZ/WI this. */
+        break;
     case 0x380 ... 0x3bf: /* NVIC_ITNS<n> */
     {
         int startvec = 8 * (offset - 0x380) + NVIC_FIRST_IRQ;
-- 
2.16.1
