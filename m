Received: from eggs.gnu.org ([2001:4830:134:3::10]:35349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZg-00020j-OF
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZf-0001EV-T7
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:00 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZf-0001EG-MW
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:59 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZe-0003sz-Rf
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:21:58 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:01 +0000
Message-Id: <1482852077-19397-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/25] hw/intc/arm_gicv3: Don't signal
 Pending+Active interrupts to CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The GICv3 requires that we only signal Pending interrupts to
the CPU. This category does not include Pending+Active interrupts,
which means we need to check whether the interrupt is Active in
the gicr_int_pending() and gicd_int_pending() functions.

Interrupts are rarely in the Active+Pending state, but KVM
uses this as part of its handling of the virtual timer, so
this bug was causing KVM to go into an infinite loop of
taking the vtimer interrupt when the guest first triggered it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/intc/arm_gicv3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 8a6c647..f0c967b 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -54,6 +54,7 @@ static uint32_t gicd_int_pending(GICv3State *s, int irq)
      *  + the PENDING latch is set OR it is level triggered and the input is 1
      *  + its ENABLE bit is set
      *  + the GICD enable bit for its group is set
+     *  + its ACTIVE bit is not set (otherwise it would be Active+Pending)
      * Conveniently we can bulk-calculate this with bitwise operations.
      */
     uint32_t pend, grpmask;
@@ -63,9 +64,11 @@ static uint32_t gicd_int_pending(GICv3State *s, int irq)
     uint32_t group = *gic_bmp_ptr32(s->group, irq);
     uint32_t grpmod = *gic_bmp_ptr32(s->grpmod, irq);
     uint32_t enable = *gic_bmp_ptr32(s->enabled, irq);
+    uint32_t active = *gic_bmp_ptr32(s->active, irq);
 
     pend = pending | (~edge_trigger & level);
     pend &= enable;
+    pend &= ~active;
 
     if (s->gicd_ctlr & GICD_CTLR_DS) {
         grpmod = 0;
@@ -96,12 +99,14 @@ static uint32_t gicr_int_pending(GICv3CPUState *cs)
      *  + the PENDING latch is set OR it is level triggered and the input is 1
      *  + its ENABLE bit is set
      *  + the GICD enable bit for its group is set
+     *  + its ACTIVE bit is not set (otherwise it would be Active+Pending)
      * Conveniently we can bulk-calculate this with bitwise operations.
      */
     uint32_t pend, grpmask, grpmod;
 
     pend = cs->gicr_ipendr0 | (~cs->edge_trigger & cs->level);
     pend &= cs->gicr_ienabler0;
+    pend &= ~cs->gicr_iactiver0;
 
     if (cs->gic->gicd_ctlr & GICD_CTLR_DS) {
         grpmod = 0;
-- 
2.7.4
