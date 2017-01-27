Received: from eggs.gnu.org ([2001:4830:134:3::10]:59629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vs-00012d-3P
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vr-00057r-DA
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:32 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vr-000541-7B
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:31 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vm-0003Qj-1T
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:26 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:11 +0000
Message-Id: <1485531137-2362-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/22] armv7m: Honour CCR.USERSETMPEND
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Davidsaver <mdavidsaver@gmail.com>

The CCR.USERSETMPEND bit has to be set to permit unprivileged code to
write to the Software Triggered Interrupt register; honour this bit
rather than letting any code write to the register.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1485285380-10565-9-git-send-email-peter.maydell@linaro.org
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
