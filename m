Received: from eggs.gnu.org ([2001:4830:134:3::10]:41259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fddjM-0004cr-F0
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fddjL-0008T5-Fp
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:42:08 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 16:41:51 +0100
Message-Id: <20180712154152.32183-2-peter.maydell@linaro.org>
In-Reply-To: <20180712154152.32183-1-peter.maydell@linaro.org>
References: <20180712154152.32183-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 1/2] hw/intc/arm_gic: Check interrupt
 number in gic_deactivate_irq()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Jan Kiszka <jan.kiszka@web.de>, Luc Michel <luc.michel@greensocs.com>

In gic_deactivate_irq() the interrupt number comes from the guest
(on a write to the GICC_DIR register), so we need to sanity check
that it isn't out of range before we use it as an array index.
Handle this in a similar manner to the check we do in
gic_complete_irq() for the GICC_EOI register.

The array overrun is not disastrous because the calling code
uses (value & 0x3ff) to extract the interrupt field, so the
only out-of-range values possible are 1020..1023, which allow
overrunning only from irq_state[] into the following
irq_target[] array which the guest can already manipulate.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index ea0323f9691..b0a69d6386e 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -543,7 +543,21 @@ static bool gic_eoi_split(GICState *s, int cpu, MemTxAttrs attrs)
 static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
 {
     int cm = 1 << cpu;
-    int group = gic_has_groups(s) && GIC_TEST_GROUP(irq, cm);
+    int group;
+
+    if (irq >= s->num_irq) {
+        /*
+         * This handles two cases:
+         * 1. If software writes the ID of a spurious interrupt [ie 1023]
+         * to the GICC_DIR, the GIC ignores that write.
+         * 2. If software writes the number of a non-existent interrupt
+         * this must be a subcase of "value written is not an active interrupt"
+         * and so this is UNPREDICTABLE. We choose to ignore it.
+         */
+        return;
+    }
+
+    group = gic_has_groups(s) && GIC_TEST_GROUP(irq, cm);
 
     if (!gic_eoi_split(s, cpu, attrs)) {
         /* This is UNPREDICTABLE; we choose to ignore it */
-- 
2.17.1
