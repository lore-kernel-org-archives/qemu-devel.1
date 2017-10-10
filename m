Received: from eggs.gnu.org ([2001:4830:134:3::10]:51557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1wrX-0001PK-1T
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1wrR-0000Yd-LT
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:54:31 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 16:54:16 +0100
Message-Id: <1507650856-11718-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] nvic: Fix miscalculation of offsets into ITNS
 array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

This calculation of the first exception vector in
the ITNS<n> register being accessed:
        int startvec = 32 * (offset - 0x380) + NVIC_FIRST_IRQ;

is incorrect, because offset is in bytes, so we only want
to multiply by 8.

Spotted by Coverity (CID 1381484, CID 1381488), though it is
not correct that it actually overflows the buffer, because
we have a 'startvec + i < s->num_irq' guard.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Oops. I guess this is what Coverity is there to catch :-)

 hw/intc/armv7m_nvic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 22d5e6e..201e90f 100644
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
