Received: from eggs.gnu.org ([2001:4830:134:3::10]:36847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrOx-0000VU-PM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrOw-0003CV-PX
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:17:19 -0400
Received: from foss.arm.com ([217.140.101.70]:39614)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrOw-0003Br-Ih
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:17:18 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Fri, 29 Jun 2018 12:15:44 +0100
Message-Id: <1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Subject: [Qemu-devel] [kvmtool test PATCH 24/24] kvmtool: arm: Add support
 for creating VM with PA size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Suzuki K Poulose <suzuki.poulose@arm.com>

Specify the physical size for the VM encoded in the vm type.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arm/include/arm-common/kvm-arch.h |  6 +++++-
 arm/kvm.c                         | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
index b29b4b1..d77f3ac 100644
--- a/arm/include/arm-common/kvm-arch.h
+++ b/arm/include/arm-common/kvm-arch.h
@@ -44,7 +44,11 @@
 
 #define KVM_IRQ_OFFSET		GIC_SPI_IRQ_BASE
 
-#define KVM_VM_TYPE		0
+extern unsigned long		kvm_arm_type;
+extern void kvm__arch_init_hyp(struct kvm *kvm);
+
+#define KVM_VM_TYPE		kvm_arm_type
+#define kvm__arch_init_hyp	kvm__arch_init_hyp
 
 #define VIRTIO_DEFAULT_TRANS(kvm)	\
 	((kvm)->cfg.arch.virtio_trans_pci ? VIRTIO_PCI : VIRTIO_MMIO)
diff --git a/arm/kvm.c b/arm/kvm.c
index 5701d41..b1969be 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -11,6 +11,8 @@
 #include <linux/kvm.h>
 #include <linux/sizes.h>
 
+unsigned long kvm_arm_type;
+
 struct kvm_ext kvm_req_ext[] = {
 	{ DEFINE_KVM_EXT(KVM_CAP_IRQCHIP) },
 	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
@@ -18,6 +20,26 @@ struct kvm_ext kvm_req_ext[] = {
 	{ 0, 0 },
 };
 
+#ifndef KVM_ARM_GET_MAX_VM_PHYS_SHIFT
+#define KVM_ARM_GET_MAX_VM_PHYS_SHIFT		_IO(KVMIO, 0x0b)
+#endif
+
+void kvm__arch_init_hyp(struct kvm *kvm)
+{
+	int max_ipa;
+
+	max_ipa = ioctl(kvm->sys_fd, KVM_ARM_GET_MAX_VM_PHYS_SHIFT);
+	if (max_ipa < 0)
+		max_ipa = 40;
+	if (!kvm->cfg.arch.phys_shift)
+		kvm->cfg.arch.phys_shift = 40;
+	if (kvm->cfg.arch.phys_shift > max_ipa)
+		die("Requested PA size (%u) is not supported by the host (%ubits)\n",
+		    kvm->cfg.arch.phys_shift, max_ipa);
+	if (kvm->cfg.arch.phys_shift != 40)
+		kvm_arm_type = kvm->cfg.arch.phys_shift;
+}
+
 bool kvm__arch_cpu_supports_vm(void)
 {
 	/* The KVM capability check is enough. */
-- 
2.7.4
