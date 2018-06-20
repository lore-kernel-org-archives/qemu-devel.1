Received: from eggs.gnu.org ([2001:4830:134:3::10]:50911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVcq1-0004RN-8i
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVcq0-0005gX-1F
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:07:53 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 20 Jun 2018 15:07:28 +0200
Message-Id: <1529500053-21704-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
References: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 1/6] linux-headers: Partial update for KVM/ARM
 KVM_ARM_GET_MAX_VM_PHYS_SHIFT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com, suzuki.poulose@arm.com

This is a partial header to get the KVM_ARM_GET_MAX_VM_PHYS_SHIFT
ioctl. This allows to retrieve the IPA address range KVM supports.

This is based on branch:
https://github.com/eauger/linux/tree/4.16.0-rc3-Suzuki-52b-IPA-v2
itself derived from Suzuki's branch (just incremented the IOCTL index)
git://linux-arm.org/linux-skp.git ipa52/v2

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 linux-headers/asm-arm/kvm.h   | 15 ---------------
 linux-headers/asm-arm64/kvm.h |  6 ------
 linux-headers/linux/kvm.h     |  6 ++++++
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 670b43c..4392955 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -135,15 +135,6 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_CRM_SHIFT		7
 #define KVM_REG_ARM_32_CRN_MASK		0x0000000000007800
 #define KVM_REG_ARM_32_CRN_SHIFT	11
-/*
- * For KVM currently all guest registers are nonsecure, but we reserve a bit
- * in the encoding to distinguish secure from nonsecure for AArch32 system
- * registers that are banked by security. This is 1 for the secure banked
- * register, and 0 for the nonsecure banked register or if the register is
- * not banked by security.
- */
-#define KVM_REG_ARM_SECURE_MASK	0x0000000010000000
-#define KVM_REG_ARM_SECURE_SHIFT	28
 
 #define ARM_CP15_REG_SHIFT_MASK(x,n) \
 	(((x) << KVM_REG_ARM_ ## n ## _SHIFT) & KVM_REG_ARM_ ## n ## _MASK)
@@ -195,12 +186,6 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_VFP_FPINST		0x1009
 #define KVM_REG_ARM_VFP_FPINST2		0x100A
 
-/* KVM-as-firmware specific pseudo-registers */
-#define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
-#define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
-					 KVM_REG_ARM_FW | ((r) & 0xffff))
-#define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
-
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 17315ab..4e80651 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -206,12 +206,6 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
 #define KVM_REG_ARM_TIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 0, 2)
 
-/* KVM-as-firmware specific pseudo-registers */
-#define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
-#define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
-					 KVM_REG_ARM_FW | ((r) & 0xffff))
-#define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
-
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index cdb148e..a6c4e24 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -774,6 +774,12 @@ struct kvm_ppc_resize_hpt {
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
+ /*
+ * Get the maximum physical address size supported by the host.
+ * Returns log2(Max-Physical-Address-Size)
+ */
+#define KVM_ARM_GET_MAX_VM_PHYS_SHIFT	_IO(KVMIO, 0x0b)
+
 /*
  * Extension capability list.
  */
-- 
2.5.5
