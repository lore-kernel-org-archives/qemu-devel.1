Received: from eggs.gnu.org ([2001:4830:134:3::10]:36609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrOY-0000Di-05
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrOV-0002d7-TC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:53 -0400
Received: from foss.arm.com ([217.140.101.70]:39448)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrOV-0002br-K3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:51 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Fri, 29 Jun 2018 12:15:34 +0100
Message-Id: <1530270944-11351-15-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Subject: [Qemu-devel] [PATCH v3 14/20] kvm: arm/arm64: Expose supported
 physical address limit for VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Suzuki K Poulose <suzuki.poulose@arm.com>, Peter Maydel <peter.maydell@linaro.org>

Expose the maximum physical address size supported by the host
for a VM. This could be later used by the userspace to choose the
appropriate size for a given VM. The limit is determined as the
minimum of actual CPU limit, the kernel limit (i.e, either 48 or 52)
and the stage2 page table support limit (which is 40bits at the moment).
For backward compatibility, we support a minimum of 40bits. The limit
will be lifted as we add support for the stage2 to support the host
kernel PA limit.

This value may be different from what is exposed to the VM via
CPU ID registers. The limit only applies to the stage2 page table.

Cc: Christoffer Dall <cdall@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peter Maydel <peter.maydell@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V2:
 - Bump the ioctl number
---
 Documentation/virtual/kvm/api.txt | 15 +++++++++++++++
 arch/arm/include/asm/kvm_mmu.h    |  5 +++++
 arch/arm64/include/asm/kvm_mmu.h  |  5 +++++
 include/uapi/linux/kvm.h          |  6 ++++++
 virt/kvm/arm/arm.c                |  6 ++++++
 5 files changed, 37 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index d10944e..662374b 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3561,6 +3561,21 @@ Returns: 0 on success,
 	-ENOENT on deassign if the conn_id isn't registered
 	-EEXIST on assign if the conn_id is already registered
 
+4.113 KVM_ARM_GET_MAX_VM_PHYS_SHIFT
+Capability: basic
+Architectures: arm, arm64
+Type: system ioctl
+Parameters: none
+Returns: log2(Maximum Guest physical address space size) supported by the
+hypervisor.
+
+This ioctl can be used to identify the maximum guest physical address
+space size supported by the hypervisor. The returned value indicates the
+maximum size of the address that can be resolved by the stage2
+translation table on arm/arm64. On arm64, the value is decided based
+on the host kernel configuration and the system wide safe value of
+ID_AA64MMFR0_EL1:PARange. This may not match the value exposed to the
+VM in CPU ID registers.
 
 5. The kvm_run structure
 ------------------------
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index b2da5a4..d86f8dd 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -380,6 +380,11 @@ static inline void *stage2_alloc_pgd(struct kvm *kvm)
 
 #define kvm_phys_to_vttbr(addr)		(addr)
 
+static inline u32 kvm_get_ipa_limit(void)
+{
+	return KVM_PHYS_SHIFT;
+}
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 813a72a..b4564d8 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -532,5 +532,10 @@ static inline void *stage2_alloc_pgd(struct kvm *kvm)
 				 GFP_KERNEL | __GFP_ZERO);
 }
 
+static inline u32 kvm_get_ipa_limit(void)
+{
+	return KVM_PHYS_SHIFT;
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b6270a3..4df9bb6 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -775,6 +775,12 @@ struct kvm_ppc_resize_hpt {
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
 /*
+ * Get the maximum physical address size supported by the host.
+ * Returns log2(Max-Physical-Address-Size)
+ */
+#define KVM_ARM_GET_MAX_VM_PHYS_SHIFT	_IO(KVMIO, 0x0b)
+
+/*
  * Extension capability list.
  */
 #define KVM_CAP_IRQCHIP	  0
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index d2637bb..0d99e67 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -66,6 +66,7 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u32 kvm_next_vmid;
 static unsigned int kvm_vmid_bits __read_mostly;
 static DEFINE_RWLOCK(kvm_vmid_lock);
+static u32 kvm_ipa_limit;
 
 static bool vgic_present;
 
@@ -248,6 +249,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg)
 {
+	if (ioctl == KVM_ARM_GET_MAX_VM_PHYS_SHIFT)
+		return kvm_ipa_limit;
+
 	return -EINVAL;
 }
 
@@ -1361,6 +1365,8 @@ static int init_common_resources(void)
 	kvm_vmid_bits = kvm_get_vmid_bits();
 	kvm_info("%d-bit VMID\n", kvm_vmid_bits);
 
+	kvm_ipa_limit = kvm_get_ipa_limit();
+
 	return 0;
 }
 
-- 
2.7.4
