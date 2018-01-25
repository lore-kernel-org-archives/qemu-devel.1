Received: from eggs.gnu.org ([2001:4830:134:3::10]:33715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoh-0003Fh-Ce
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehog-00039g-Dr
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:47 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehog-00038r-6e
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:46 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoe-0006w0-S5
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:44 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:23 +0000
Message-Id: <1516887809-6265-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/21] hw/intc/arm_gic: Fix C_RPR value on idle
 priority
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc MICHEL <luc.michel@git.antfield.fr>

When there is no active interrupts in the GIC, a read to the C_RPR
register should return the value of the "Idle priority", which is either
the maximum value an IRQ priority field can be set to, or 0xff.

Since the QEMU GIC model implements all the 8 priority bits, the Idle
priority is 0xff.

Internally, when there is no active interrupt, the running priority
value is 0x100. The gic_get_running_priority function returns an uint8_t
and thus, truncate this value to 0x00 when returning it. This is wrong since
a value of 0x00 correspond to the maximum possible priority.

This commit fixes the returned value when the internal value is 0x100.

Note that it is correct for the Non-Secure view to return 0xff even
though from the NS world point of view, only 7 priority bits are
implemented. The specification states that the Idle priority can be 0xff
even when not all the 8 priority bits are implemented. This has been
verified against a real GICv2 hardware on a Xilinx ZynqMP based board.

Regarding the ARM11MPCore version of the GIC, the specification is not
clear on that point, so this commit does not alter its behavior.

Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
Message-id: 20180119145756.7629-4-luc.michel@greensocs.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index dad383e..713de30 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -504,6 +504,11 @@ static void gic_set_cpu_control(GICState *s, int cpu, uint32_t value,
 
 static uint8_t gic_get_running_priority(GICState *s, int cpu, MemTxAttrs attrs)
 {
+    if ((s->revision != REV_11MPCORE) && (s->running_priority[cpu] > 0xff)) {
+        /* Idle priority */
+        return 0xff;
+    }
+
     if (s->security_extn && !attrs.secure) {
         if (s->running_priority[cpu] & 0x80) {
             /* Running priority in upper half of range: return the Non-secure
-- 
2.7.4
