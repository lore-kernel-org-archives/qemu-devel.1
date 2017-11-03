Received: from eggs.gnu.org ([2001:4830:134:3::10]:50560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eAgSu-0004dG-Jl
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eAgSq-0008Ns-Ox
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:13:12 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Nov 2017 18:13:33 +0000
Message-Id: <1509732813-22957-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] nvic: Fix ARMv7M MPU_RBAR reads
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

Fix an incorrect mask expression in the handling of v7M MPU_RBAR
reads that meant that we would always report the ADDR field as zero.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Doesn't affect v8M, which is a different codepath.

 hw/intc/armv7m_nvic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index be46639..5d9c883 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -977,7 +977,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (region >= cpu->pmsav7_dregion) {
             return 0;
         }
-        return (cpu->env.pmsav7.drbar[region] & 0x1f) | (region & 0xf);
+        return (cpu->env.pmsav7.drbar[region] & ~0x1f) | (region & 0xf);
     }
     case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
     case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
-- 
2.7.4
