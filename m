Received: from eggs.gnu.org ([2001:4830:134:3::10]:37465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0f-0008Gk-CT
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0e-0006Hs-Ke
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:29 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eGq0e-0006H1-DG
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:28 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0d-0006N8-1q
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:37:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 17:37:21 +0000
Message-Id: <1511199444-17922-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
References: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/5] nvic: Fix ARMv7M MPU_RBAR reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix an incorrect mask expression in the handling of v7M MPU_RBAR
reads that meant that we would always report the ADDR field as zero.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1509732813-22957-1-git-send-email-peter.maydell@linaro.org
---
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
