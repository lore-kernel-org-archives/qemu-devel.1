Received: from eggs.gnu.org ([2001:4830:134:3::10]:47456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0000yE-Vk
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPp-0005Ai-HE
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPp-00055o-8O
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPg-0003AO-S8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:38 +0000
Message-Id: <1484834995-26826-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/36] hw/intc/arm_gicv3: Add external IRQ lines
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

Augment the GICv3's QOM device interface by adding two
new sets of sysbus IRQ lines, to signal VIRQ and VFIQ to
each CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 1483977924-14522-2-git-send-email-peter.maydell@linaro.org
---
 include/hw/intc/arm_gicv3_common.h | 2 ++
 hw/intc/arm_gicv3_common.c         | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 341a311..beb2c77 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -145,6 +145,8 @@ struct GICv3CPUState {
     CPUState *cpu;
     qemu_irq parent_irq;
     qemu_irq parent_fiq;
+    qemu_irq parent_virq;
+    qemu_irq parent_vfiq;
 
     /* Redistributor */
     uint32_t level;                  /* Current IRQ level */
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 0aa9b9c..0ee67a4 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -126,6 +126,12 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
     for (i = 0; i < s->num_cpu; i++) {
         sysbus_init_irq(sbd, &s->cpu[i].parent_fiq);
     }
+    for (i = 0; i < s->num_cpu; i++) {
+        sysbus_init_irq(sbd, &s->cpu[i].parent_virq);
+    }
+    for (i = 0; i < s->num_cpu; i++) {
+        sysbus_init_irq(sbd, &s->cpu[i].parent_vfiq);
+    }
 
     memory_region_init_io(&s->iomem_dist, OBJECT(s), ops, s,
                           "gicv3_dist", 0x10000);
-- 
2.7.4
