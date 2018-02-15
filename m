Received: from eggs.gnu.org ([2001:4830:134:3::10]:36476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP8-0006Bw-Jt
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP7-0004FY-Qb
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emOP7-0004F9-K7
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:09 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP6-00026I-Lb
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:37:08 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:36:50 +0000
Message-Id: <20180215183700.26101-11-peter.maydell@linaro.org>
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/20] hw/intc/armv7m_nvic: Implement M profile
 cache maintenance ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For M profile cores, cache maintenance operations are done by
writing to special registers in the system register space.
For QEMU, cache operations are always NOPs, since we don't
implement the cache. Implementing these explicitly avoids
a spurious LOG_GUEST_ERROR when the guest uses them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180209165810.6668-4-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 06b9598fbe..74b25ce92c 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1594,6 +1594,18 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         break;
     }
+    case 0xf50: /* ICIALLU */
+    case 0xf58: /* ICIMVAU */
+    case 0xf5c: /* DCIMVAC */
+    case 0xf60: /* DCISW */
+    case 0xf64: /* DCCMVAU */
+    case 0xf68: /* DCCMVAC */
+    case 0xf6c: /* DCCSW */
+    case 0xf70: /* DCCIMVAC */
+    case 0xf74: /* DCCISW */
+    case 0xf78: /* BPIALL */
+        /* Cache and branch predictor maintenance: for QEMU these always NOP */
+        break;
     default:
     bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.16.1
