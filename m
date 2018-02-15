Received: from eggs.gnu.org ([2001:4830:134:3::10]:36471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP8-0006Bd-9u
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP7-0004FK-C4
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emOP7-0004EX-5K
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:09 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP5-000262-VE
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:37:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:36:49 +0000
Message-Id: <20180215183700.26101-10-peter.maydell@linaro.org>
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/20] hw/intc/armv7m_nvic: Fix ICSR
 PENDNMISET/CLR handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The PENDNMISET/CLR bits in the ICSR should be RAZ/WI from
NonSecure state if the AIRCR.BFHFNMINS bit is zero. We had
misimplemented this as making the bits RAZ/WI from both
Secure and NonSecure states. Fix this bug by checking
attrs.secure so that Secure code can pend and unpend NMIs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180209165810.6668-3-peter.maydell@linaro.org
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
