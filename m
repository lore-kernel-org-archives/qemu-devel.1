Received: from eggs.gnu.org ([2001:4830:134:3::10]:60442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZNaY-00009P-6O
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZNaX-0007z5-74
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:02:38 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Feb 2017 20:02:22 +0000
Message-Id: <1486065742-28639-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 9/9] armv7m: VECTCLRACTIVE and VECTRESET are
 UNPREDICTABLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>

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
---
 hw/intc/armv7m_nvic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 7b61fe6..18c0e60 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -698,10 +698,14 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
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
