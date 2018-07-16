Received: from eggs.gnu.org ([2001:4830:134:3::10]:50636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aY-0008Th-02
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aX-0005ZC-2B
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ff6aW-0005Yr-R4
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aV-0000zr-Qe
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:43:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 17:42:55 +0100
Message-Id: <20180716164300.6731-4-peter.maydell@linaro.org>
In-Reply-To: <20180716164300.6731-1-peter.maydell@linaro.org>
References: <20180716164300.6731-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 3/8] hw/intc/arm_gic: Check interrupt number in
 gic_deactivate_irq()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180712154152.32183-2-peter.maydell@linaro.org
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
