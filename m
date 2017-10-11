Received: from eggs.gnu.org ([2001:4830:134:3::10]:44814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2KkO-0007fH-HE
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2KkN-00043H-LW
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:24:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 18:24:36 +0100
Message-Id: <1507742676-9908-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] nvic: Add missing 'break'
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

Coverity points out that we forgot the 'break' for
the SAU_CTRL write case (CID1381683). This has
no actual visible consequences because it happens
that the following case is effectively a no-op.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 201e90f..be46639 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1447,6 +1447,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             return;
         }
         cpu->env.sau.ctrl = value & 3;
+        break;
     case 0xdd4: /* SAU_TYPE */
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
             goto bad_offset;
-- 
2.7.4
