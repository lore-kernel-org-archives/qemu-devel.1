Received: from eggs.gnu.org ([2001:4830:134:3::10]:41773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOV0-0000zU-LL
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUz-0006ca-O4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUz-0006b8-GD
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:17 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUy-0002z4-Bc
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:57 +0100
Message-Id: <20180531142357.904-26-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 25/25] KVM: GIC: Fix memory leak due to calling
 kvm_init_irq_routing twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Shannon Zhao <zhaoshenglong@huawei.com>

kvm_irqchip_create called by kvm_init will call kvm_init_irq_routing to
initialize global capability variables. If we call kvm_init_irq_routing in
GIC realize function, previous allocated memory will leak.

Fix this by deleting the unnecessary call.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1527750994-14360-1-git-send-email-zhaoshenglong@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic_kvm.c   | 1 -
 hw/intc/arm_gicv3_kvm.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 6f467e68a8..204369d0e2 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -572,7 +572,6 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
 
     if (kvm_has_gsi_routing()) {
         /* set up irq routing */
-        kvm_init_irq_routing(kvm_state);
         for (i = 0; i < s->num_irq - GIC_INTERNAL; ++i) {
             kvm_irqchip_add_irq_route(kvm_state, i, 0, i);
         }
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3536795501..0279b86cd9 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -761,7 +761,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
     if (kvm_has_gsi_routing()) {
         /* set up irq routing */
-        kvm_init_irq_routing(kvm_state);
         for (i = 0; i < s->num_irq - GIC_INTERNAL; ++i) {
             kvm_irqchip_add_irq_route(kvm_state, i, 0, i);
         }
-- 
2.17.1
