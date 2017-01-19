Received: from eggs.gnu.org ([2001:4830:134:3::10]:47436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0000xi-H8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPp-0005A1-0o
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPo-00051T-Oi
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:12 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPh-0003Al-Ao
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:39 +0000
Message-Id: <1484834995-26826-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 20/36] hw/intc/arm_gic: Add external IRQ lines
 for VIRQ and VFIQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Augment the GIC's QOM device interface by adding two
new sets of sysbus IRQ lines, to signal VIRQ and VFIQ to
each CPU.

We never use these, but it's helpful to keep the v2-and-earlier
GIC's external interface in line with that of the GICv3 to
avoid board code having to add extra code conditional on which
version of the GIC is in use.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 1483977924-14522-3-git-send-email-peter.maydell@linaro.org
---
 include/hw/intc/arm_gic_common.h | 2 ++
 hw/intc/arm_gic_common.c         | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index f4c349a..af3ca18 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -55,6 +55,8 @@ typedef struct GICState {
 
     qemu_irq parent_irq[GIC_NCPU];
     qemu_irq parent_fiq[GIC_NCPU];
+    qemu_irq parent_virq[GIC_NCPU];
+    qemu_irq parent_vfiq[GIC_NCPU];
     /* GICD_CTLR; for a GIC with the security extensions the NS banked version
      * of this register is just an alias of bit 1 of the S banked version.
      */
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 0a1f56a..4a8df44 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -110,6 +110,12 @@ void gic_init_irqs_and_mmio(GICState *s, qemu_irq_handler handler,
     for (i = 0; i < s->num_cpu; i++) {
         sysbus_init_irq(sbd, &s->parent_fiq[i]);
     }
+    for (i = 0; i < s->num_cpu; i++) {
+        sysbus_init_irq(sbd, &s->parent_virq[i]);
+    }
+    for (i = 0; i < s->num_cpu; i++) {
+        sysbus_init_irq(sbd, &s->parent_vfiq[i]);
+    }
 
     /* Distributor */
     memory_region_init_io(&s->iomem, OBJECT(s), ops, s, "gic_dist", 0x1000);
-- 
2.7.4
