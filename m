Received: from eggs.gnu.org ([2001:4830:134:3::10]:40073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eieSy-000685-BF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eieSx-0007H6-N5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:57:40 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Feb 2018 10:57:14 +0000
Message-Id: <20180205105720.14620-3-peter.maydell@linaro.org>
In-Reply-To: <20180205105720.14620-1-peter.maydell@linaro.org>
References: <20180205105720.14620-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/8] hw/intc/armv7m_nvic: Fix ICSR
 PENDNMISET/CLR handling
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

The PENDNMISET/CLR bits in the ICSR should be RAZ/WI from
NonSecure state if the AIRCR.BFHFNMINS bit is zero. We had
misimplemented this as making the bits RAZ/WI from both
Secure and NonSecure states. Fix this bug by checking
attrs.secure so that Secure code can pend and unpend NMIs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 63da0fee34..06b9598fbe 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -830,8 +830,8 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             }
         }
         /* NMIPENDSET */
-        if ((cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) &&
-            s->vectors[ARMV7M_EXCP_NMI].pending) {
+        if ((attrs.secure || (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK))
+            && s->vectors[ARMV7M_EXCP_NMI].pending) {
             val |= (1 << 31);
         }
         /* ISRPREEMPT: RES0 when halting debug not implemented */
@@ -1193,7 +1193,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         break;
     }
     case 0xd04: /* Interrupt Control State (ICSR) */
-        if (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) {
+        if (attrs.secure || cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) {
             if (value & (1 << 31)) {
                 armv7m_nvic_set_pending(s, ARMV7M_EXCP_NMI, false);
             } else if (value & (1 << 30) &&
-- 
2.16.1
