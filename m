Received: from eggs.gnu.org ([2001:4830:134:3::10]:47097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ecY7W-0002pF-AG
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ecY7V-0003mY-Ej
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:58:18 -0500
From: luc.michel@greensocs.com
Date: Fri, 19 Jan 2018 15:57:54 +0100
Message-Id: <20180119145756.7629-4-luc.michel@greensocs.com>
In-Reply-To: <20180119145756.7629-1-luc.michel@greensocs.com>
References: <20180119145756.7629-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 2/4] hw/intc/arm_gic: Fix C_RPR value on idle
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
Cc: Luc MICHEL <luc.michel@git.antfield.fr>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>

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
---
 hw/intc/arm_gic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index dad383ea12..713de3084f 100644
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
2.16.0
