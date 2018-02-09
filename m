Received: from eggs.gnu.org ([2001:4830:134:3::10]:40976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0B-0003wQ-UL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0A-0007ll-KG
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:19 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 16:58:02 +0000
Message-Id: <20180209165810.6668-4-peter.maydell@linaro.org>
In-Reply-To: <20180209165810.6668-1-peter.maydell@linaro.org>
References: <20180209165810.6668-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 03/11] hw/intc/armv7m_nvic: Implement M
 profile cache maintenance ops
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

For M profile cores, cache maintenance operations are done by
writing to special registers in the system register space.
For QEMU, cache operations are always NOPs, since we don't
implement the cache. Implementing these explicitly avoids
a spurious LOG_GUEST_ERROR when the guest uses them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
