Received: from eggs.gnu.org ([2001:4830:134:3::10]:42566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1csune-0006uv-6o
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1csund-0002Dp-EI
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:20:54 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 28 Mar 2017 19:20:40 +0200
Message-Id: <1490721640-13052-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/intc/arm_gicv3_kvm: Check
 KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS in reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, christoffer.dall@linaro.org, bjsprakash.linux@gmail.com, bprakash@caviumnetworks.com, sgoutham@cavium.com

KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS needs to be checked before
attempting to read ICC_CTLR_EL1; otherwise kernel versions not
exposing this kvm device group will be incompatible with qemu 2.9.

Fixes: 07a5628  ("hw/intc/arm_gicv3_kvm: Reset GICv3 cpu interface registers")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Prakash B <bjsprakash.linux@gmail.com>

---
v1 -> v2:
- use migration_blocker instead of kvm_device_check_attr

I understand the ICC_CTLR_EL1 state only is used in the put() function
which is used for migration
---
 hw/intc/arm_gicv3_kvm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 81f0403..19aab56 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -614,12 +614,6 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     s = c->gic;
     cpu = ARM_CPU(c->cpu);
 
-    /* Initialize to actual HW supported configuration */
-    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
-                      KVM_VGIC_ATTR(ICC_CTLR_EL1, cpu->mp_affinity),
-                      &c->icc_ctlr_el1[GICV3_NS], false);
-
-    c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
     c->icc_pmr_el1 = 0;
     c->icc_bpr[GICV3_G0] = GIC_MIN_BPR;
     c->icc_bpr[GICV3_G1] = GIC_MIN_BPR;
@@ -628,6 +622,17 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     c->icc_sre_el1 = 0x7;
     memset(c->icc_apr, 0, sizeof(c->icc_apr));
     memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
+
+    if (s->migration_blocker) {
+        return;
+    }
+
+    /* Initialize to actual HW supported configuration */
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                      KVM_VGIC_ATTR(ICC_CTLR_EL1, cpu->mp_affinity),
+                      &c->icc_ctlr_el1[GICV3_NS], false);
+
+    c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
 }
 
 static void kvm_arm_gicv3_reset(DeviceState *dev)
-- 
2.5.5
