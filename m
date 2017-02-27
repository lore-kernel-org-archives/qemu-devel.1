Received: from eggs.gnu.org ([2001:4830:134:3::10]:51901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfc-0002IB-IS
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfb-0001rQ-JX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:12 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPfb-0001qs-De
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:11 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfa-0002Pg-HJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:10 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:49 +0000
Message-Id: <1488218699-31035-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/30] armv7m: VECTCLRACTIVE and VECTRESET are
 UNPREDICTABLE
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

The VECTCLRACTIVE and VECTRESET bits in the AIRCR are both
documented as UNPREDICTABLE if you write a 1 to them when
the processor is not halted in Debug state (ie stopped
and under the control of an external JTAG debugger).
Since we don't implement Debug state or emulated JTAG
these bits are always UNPREDICTABLE for us. Instead of
logging them as unimplemented we can simply log writes
as guest errors and ignore them.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
[PMM: change extracted from another patch; commit message
 constructed from scratch]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/intc/armv7m_nvic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 9336bca..456480a 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -716,10 +716,14 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
                 qemu_irq_pulse(s->sysresetreq);
             }
             if (value & 2) {
-                qemu_log_mask(LOG_UNIMP, "VECTCLRACTIVE unimplemented\n");
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Setting VECTCLRACTIVE when not in DEBUG mode "
+                              "is UNPREDICTABLE\n");
             }
             if (value & 1) {
-                qemu_log_mask(LOG_UNIMP, "AIRCR system reset unimplemented\n");
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Setting VECTRESET when not in DEBUG mode "
+                              "is UNPREDICTABLE\n");
             }
             s->prigroup = extract32(value, 8, 3);
             nvic_irq_update(s);
-- 
2.7.4
