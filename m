Received: from eggs.gnu.org ([2001:4830:134:3::10]:57606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fOHpy-0002CX-KN
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fOHpx-0000hB-Pk
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:17:30 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Thu, 31 May 2018 15:16:34 +0800
Message-ID: <1527750994-14360-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] KVM: GIC: Fix memory leak due to calling
 kvm_init_irq_routing twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com

kvm_irqchip_create called by kvm_init will call kvm_init_irq_routing to
initialize global capability variables. If we call kvm_init_irq_routing in
GIC realize function, previous allocated memory will leak.

Fix this by deleting the unnecessary call.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
---
 hw/intc/arm_gic_kvm.c   | 1 -
 hw/intc/arm_gicv3_kvm.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 6f467e6..204369d 100644
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
index 001d82b..aa4c7c5 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -813,7 +813,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
     if (kvm_has_gsi_routing()) {
         /* set up irq routing */
-        kvm_init_irq_routing(kvm_state);
         for (i = 0; i < s->num_irq - GIC_INTERNAL; ++i) {
             kvm_irqchip_add_irq_route(kvm_state, i, 0, i);
         }
-- 
2.0.4
