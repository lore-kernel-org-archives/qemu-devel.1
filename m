Received: from eggs.gnu.org ([2001:4830:134:3::10]:56173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2Y-0008Ey-8m
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2X-0007cK-Gt
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:18 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 16:36:03 +0000
Message-Id: <1487262963-11519-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 13/13] armv7m: Allow SHCSR writes to change
 pending and active bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Implement the NVIC SHCSR write behaviour which allows pending and
active status of some exceptions to be changed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a8c5a9e..1d34e0d 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -755,8 +755,17 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
         cpu->env.v7m.ccr = value;
         break;
     case 0xd24: /* System Handler Control.  */
-        /* TODO: Real hardware allows you to set/clear the active bits
-           under some circumstances.  We don't implement this.  */
+        s->vectors[ARMV7M_EXCP_MEM].active = (value & (1 << 0)) != 0;
+        s->vectors[ARMV7M_EXCP_BUS].active = (value & (1 << 1)) != 0;
+        s->vectors[ARMV7M_EXCP_USAGE].active = (value & (1 << 3)) != 0;
+        s->vectors[ARMV7M_EXCP_SVC].active = (value & (1 << 7)) != 0;
+        s->vectors[ARMV7M_EXCP_DEBUG].active = (value & (1 << 8)) != 0;
+        s->vectors[ARMV7M_EXCP_PENDSV].active = (value & (1 << 10)) != 0;
+        s->vectors[ARMV7M_EXCP_SYSTICK].active = (value & (1 << 11)) != 0;
+        s->vectors[ARMV7M_EXCP_USAGE].pending = (value & (1 << 12)) != 0;
+        s->vectors[ARMV7M_EXCP_MEM].pending = (value & (1 << 13)) != 0;
+        s->vectors[ARMV7M_EXCP_BUS].pending = (value & (1 << 14)) != 0;
+        s->vectors[ARMV7M_EXCP_SVC].pending = (value & (1 << 15)) != 0;
         s->vectors[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
         s->vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
         s->vectors[ARMV7M_EXCP_USAGE].enabled = (value & (1 << 18)) != 0;
-- 
2.7.4
