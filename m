Received: from eggs.gnu.org ([2001:4830:134:3::10]:44208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxU-0003Ka-Q9
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxU-0004dV-1j
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxT-0004d0-RV
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxS-0000hJ-Qv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:38 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:36 +0100
Message-Id: <1507824216-29058-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 13/13] nvic: Fix miscalculation of offsets into
 ITNS array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This calculation of the first exception vector in
the ITNS<n> register being accessed:
        int startvec = 32 * (offset - 0x380) + NVIC_FIRST_IRQ;

is incorrect, because offset is in bytes, so we only want
to multiply by 8.

Spotted by Coverity (CID 1381484, CID 1381488), though it is
not correct that it actually overflows the buffer, because
we have a 'startvec + i < s->num_irq' guard.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1507650856-11718-1-git-send-email-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a42961c..be46639 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -698,7 +698,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         return ((s->num_irq - NVIC_FIRST_IRQ) / 32) - 1;
     case 0x380 ... 0x3bf: /* NVIC_ITNS<n> */
     {
-        int startvec = 32 * (offset - 0x380) + NVIC_FIRST_IRQ;
+        int startvec = 8 * (offset - 0x380) + NVIC_FIRST_IRQ;
         int i;
 
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
@@ -1102,7 +1102,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
     switch (offset) {
     case 0x380 ... 0x3bf: /* NVIC_ITNS<n> */
     {
-        int startvec = 32 * (offset - 0x380) + NVIC_FIRST_IRQ;
+        int startvec = 8 * (offset - 0x380) + NVIC_FIRST_IRQ;
         int i;
 
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
-- 
2.7.4
