Received: from eggs.gnu.org ([2001:4830:134:3::10]:47100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ecY7W-0002pR-HX
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ecY7V-0003mw-Ls
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:58:18 -0500
From: luc.michel@greensocs.com
Date: Fri, 19 Jan 2018 15:57:53 +0100
Message-Id: <20180119145756.7629-3-luc.michel@greensocs.com>
In-Reply-To: <20180119145756.7629-1-luc.michel@greensocs.com>
References: <20180119145756.7629-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 1/4] hw/intc/arm_gic: Prevent the GIC from
 signaling an IRQ when it's "active and pending"
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

In the GIC, when an IRQ is acknowledged, its state goes from "pending"
to:
   - "active" if the corresponding IRQ pin has been de-asserted
   - "active and pending" otherwise.
The GICv2 manual states that when a IRQ becomes active (or active and
pending), the GIC should either signal another (higher priority) IRQ to
the CPU if there is one, or de-assert the CPU IRQ pin.

The current implementation of the GIC in QEMU does not check if the
IRQ is already active when looking for pending interrupts with
sufficient priority in gic_update(). This can lead to signaling an
interrupt that is already active.

This usually happens when splitting priority drop and interrupt
deactivation. On priority drop, the IRQ stays active until deactivation.
If it becomes pending again, chances are that it will be incorrectly
selected as best_irq in gic_update().

This commit fixes this by checking if the IRQ is not already active when
looking for best_irq in gic_update().

Note that regarding the ARM11MPCore GIC version, the corresponding
manual is not clear on that point, but it has has no priority
drop/interrupt deactivation separation, so this case should not happen.

Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
---
 hw/intc/arm_gic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index d701e49ff9..dad383ea12 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -93,6 +93,7 @@ void gic_update(GICState *s)
         best_irq = 1023;
         for (irq = 0; irq < s->num_irq; irq++) {
             if (GIC_TEST_ENABLED(irq, cm) && gic_test_pending(s, irq, cm) &&
+                (!GIC_TEST_ACTIVE(irq, cm)) &&
                 (irq < GIC_INTERNAL || GIC_TARGET(irq) & cm)) {
                 if (GIC_GET_PRIORITY(irq, cpu) < best_prio) {
                     best_prio = GIC_GET_PRIORITY(irq, cpu);
-- 
2.16.0
