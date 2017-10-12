Received: from eggs.gnu.org ([2001:4830:134:3::10]:44190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxU-0003KQ-9A
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxT-0004dA-Hk
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxT-0004as-BV
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxS-0000gp-8y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:38 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:35 +0100
Message-Id: <1507824216-29058-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/13] nvic: Add missing 'break'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Coverity points out that we forgot the 'break' for
the SAU_CTRL write case (CID1381683). This has
no actual visible consequences because it happens
that the following case is effectively a no-op.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1507742676-9908-1-git-send-email-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/intc/armv7m_nvic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 22d5e6e..a42961c 100644
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
