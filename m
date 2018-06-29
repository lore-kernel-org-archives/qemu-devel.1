Received: from eggs.gnu.org ([2001:4830:134:3::10]:36626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrOa-0000Fs-Ba
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrOZ-0002k9-2M
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:56 -0400
Received: from foss.arm.com ([217.140.101.70]:39460)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrOY-0002iT-OM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:54 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Fri, 29 Jun 2018 12:15:35 +0100
Message-Id: <1530270944-11351-16-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 15/20] kvm: arm/arm64: Allow tuning the
 physical address size for VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Suzuki K Poulose <suzuki.poulose@arm.com>, Peter Maydel <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

Allow specifying the physical address size for a new VM via
the kvm_type argument for KVM_CREATE_VM ioctl. This allows
us to finalise the stage2 page table format as early as possible
and hence perform the right checks on the memory slots without
complication. The size is encoded as Log2(PA_Size) in the bits[7:0]
of the type field and can encode more information in the future if
required. The IPA size is still capped at 40bits.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Cc: Peter Maydel <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   |  2 ++
 arch/arm64/include/asm/kvm_arm.h | 10 +++-------
 arch/arm64/include/asm/kvm_mmu.h |  2 ++
 include/uapi/linux/kvm.h         | 10 ++++++++++
 virt/kvm/arm/arm.c               | 24 ++++++++++++++++++++++--
 5 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mm=
u.h
index d86f8dd..bcc3dd9 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -385,6 +385,8 @@ static inline u32 kvm_get_ipa_limit(void)
 	return KVM_PHYS_SHIFT;
 }
=20
+static inline void kvm_config_stage2(struct kvm *kvm, u32 ipa_shift) {}
+
 #endif	/* !__ASSEMBLY__ */
=20
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kv=
m_arm.h
index b02c316..2e90942 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -128,19 +128,15 @@
 #define VTCR_EL2_T0SZ(x)	TCR_T0SZ(x)
=20
 /*
- * We configure the Stage-2 page tables to always restrict the IPA space=
 to be
- * 40 bits wide (T0SZ =3D 24).  Systems with a PARange smaller than 40 b=
its are
- * not known to exist and will break with this configuration.
+ * We configure the Stage-2 page tables based on the requested size of
+ * IPA for each VM. The default size is set to 40bits and is not allowed
+ * go below that limit (for backward compatibility).
  *
  * VTCR_EL2.PS is extracted from ID_AA64MMFR0_EL1.PARange at boot time
  * (see hyp-init.S).
  *
  * VTCR_EL2.SL0 and T0SZ are configured per VM at runtime before switchi=
ng to
  * the VM.
- *
- * Note that when using 4K pages, we concatenate two first level page ta=
bles
- * together. With 16K pages, we concatenate 16 first level page tables.
- *
  */
=20
 #define VTCR_EL2_COMMON_BITS	(VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA |=
 \
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kv=
m_mmu.h
index b4564d8..f3fb05a3 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -537,5 +537,7 @@ static inline u32 kvm_get_ipa_limit(void)
 	return KVM_PHYS_SHIFT;
 }
=20
+static inline void kvm_config_stage2(struct kvm *kvm, u32 ipa_shift) {}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4df9bb6..fa4cab0 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -751,6 +751,16 @@ struct kvm_ppc_resize_hpt {
 #define KVM_S390_SIE_PAGE_OFFSET 1
=20
 /*
+ * On arm/arm64, machine type can be used to request the physical
+ * address size for the VM. Bits [7-0] have been reserved for the
+ * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
+ * value 0 implies the default IPA size, which is 40bits.
+ */
+#define KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK	0xff
+#define KVM_VM_TYPE_ARM_PHYS_SHIFT(x)		\
+	((x) & KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK)
+
+/*
  * ioctls for /dev/kvm fds:
  */
 #define KVM_GET_API_VERSION       _IO(KVMIO,   0x00)
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 0d99e67..1085761 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -112,6 +112,25 @@ void kvm_arch_check_processor_compat(void *rtn)
 }
=20
=20
+static int kvm_arch_config_vm(struct kvm *kvm, unsigned long type)
+{
+	u32 ipa_shift =3D KVM_VM_TYPE_ARM_PHYS_SHIFT(type);
+
+	/*
+	 * Make sure the size, if specified, is within the range of
+	 * default size and supported maximum limit.
+	 */
+	if (ipa_shift) {
+		if (ipa_shift < KVM_PHYS_SHIFT || ipa_shift > kvm_ipa_limit)
+			return -EINVAL;
+	} else {
+		ipa_shift =3D KVM_PHYS_SHIFT;
+	}
+
+	kvm_config_stage2(kvm, ipa_shift);
+	return 0;
+}
+
 /**
  * kvm_arch_init_vm - initializes a VM data structure
  * @kvm:	pointer to the KVM struct
@@ -120,8 +139,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long t=
ype)
 {
 	int ret, cpu;
=20
-	if (type)
-		return -EINVAL;
+	ret =3D kvm_arch_config_vm(kvm, type);
+	if (ret)
+		return ret;
=20
 	kvm->arch.last_vcpu_ran =3D alloc_percpu(typeof(*kvm->arch.last_vcpu_ra=
n));
 	if (!kvm->arch.last_vcpu_ran)
--=20
2.7.4
