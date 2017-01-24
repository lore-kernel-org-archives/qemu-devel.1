Received: from eggs.gnu.org ([2001:4830:134:3::10]:35342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6Zy-0000cs-Cx
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6Zx-0000bn-9E
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:30 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 19:16:18 +0000
Message-Id: <1485285380-10565-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 08/10] armv7m: Honour CCR.USERSETMPEND
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Liviu Ionescu <ilg@livius.net>

From: Michael Davidsaver <mdavidsaver@gmail.com>

The CCR.USERSETMPEND bit has to be set to permit unprivileged code to
write to the Software Triggered Interrupt register; honour this bit
rather than letting any code write to the register.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
[PMM: Tweak commit message, comment, phrasing of condition]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 60e72d7..fe5c303 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -409,7 +409,10 @@ static void nvic_writel(nvic_state *s, uint32_t offset, uint32_t value)
                       "NVIC: Aux fault status registers unimplemented\n");
         break;
     case 0xf00: /* Software Triggered Interrupt Register */
-        if ((value & 0x1ff) < s->num_irq) {
+        /* user mode can only write to STIR if CCR.USERSETMPEND permits it */
+        if ((value & 0x1ff) < s->num_irq &&
+            (arm_current_el(&cpu->env) ||
+             (cpu->env.v7m.ccr & R_V7M_CCR_USERSETMPEND_MASK))) {
             gic_set_pending_private(&s->gic, 0, value & 0x1ff);
         }
         break;
-- 
2.7.4
