Received: from eggs.gnu.org ([2001:4830:134:3::10]:42812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1d4hOo-0004Qn-UL
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 01:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1d4hOm-0000a5-PL
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 01:27:58 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Sun, 30 Apr 2017 13:37:57 +0800
Message-ID: <1493530677-4919-3-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 3/3] arm/arm64: signal SIBGUS and inject SEA
 Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: james.morse@arm.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, linux@armlinux.org.uk, tbaicar@codeaurora.org, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, lersek@redhat.com, ard.biesheuvel@linaro.org, mtsirkin@redhat.com, drjones@redhat.com, ben@skyportsystems.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, songwenjun@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, gengdongjiu@huawei.com

when happen SEA, deliver signal bus and handle the ioctl that
inject SEA abort to guest, so that guest can handle the SEA error.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm/include/asm/kvm_host.h   |  1 +
 arch/arm/kvm/arm.c                |  3 +++
 arch/arm/kvm/guest.c              |  5 +++++
 arch/arm/kvm/mmu.c                | 37 +++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/guest.c            |  7 +++++++
 include/uapi/linux/kvm.h          |  1 +
 7 files changed, 55 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 31ee468..ad19f80 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -244,6 +244,7 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
 
 int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		int exception_index);
+int kvm_vcpu_ioctl_sea(struct kvm_vcpu *vcpu);
 
 static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 				       unsigned long hyp_stack_ptr,
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 96dba7c..907ba4a 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -972,6 +972,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			return -E2BIG;
 		return kvm_arm_copy_reg_indices(vcpu, user_list->reg);
 	}
+	case KVM_ARM_SEA: {
+		return kvm_vcpu_ioctl_sea(vcpu);
+	}
 	case KVM_SET_DEVICE_ATTR: {
 		if (copy_from_user(&attr, argp, sizeof(attr)))
 			return -EFAULT;
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index fa6182a..48e5b53 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -247,6 +247,11 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 {
 	return -EINVAL;
 }
+int kvm_vcpu_ioctl_sea(struct kvm_vcpu *vcpu)
+{
+	return 0;
+
+}
 
 int __attribute_const__ kvm_target_cpu(void)
 {
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 105b6ab..a96594f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -20,8 +20,10 @@
 #include <linux/kvm_host.h>
 #include <linux/io.h>
 #include <linux/hugetlb.h>
+#include <linux/sched/signal.h>
 #include <trace/events/kvm.h>
 #include <asm/pgalloc.h>
+#include <asm/siginfo.h>
 #include <asm/cacheflush.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
@@ -1238,6 +1240,36 @@ static void coherent_cache_guest_page(struct kvm_vcpu *vcpu, kvm_pfn_t pfn,
 	__coherent_cache_guest_page(vcpu, pfn, size);
 }
 
+static void kvm_send_signal(unsigned long address, bool hugetlb, bool hwpoison)
+{
+	siginfo_t info;
+
+	info.si_signo   = SIGBUS;
+	info.si_errno   = 0;
+	if (hwpoison)
+		info.si_code    = BUS_MCEERR_AR;
+	else
+		info.si_code    = 0;
+
+	info.si_addr    = (void __user *)address;
+	if (hugetlb)
+		info.si_addr_lsb = PMD_SHIFT;
+	else
+		info.si_addr_lsb = PAGE_SHIFT;
+
+	send_sig_info(SIGBUS, &info, current);
+}
+
+static void kvm_handle_bad_page(unsigned long address,
+					bool hugetlb, bool hwpoison)
+{
+	/* handle both hwpoison and other synchronous external Abort */
+	if (hwpoison)
+		kvm_send_signal(address, hugetlb, true);
+	else
+		kvm_send_signal(address, hugetlb, false);
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -1307,6 +1339,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	smp_rmb();
 
 	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
+	if (pfn == KVM_PFN_ERR_HWPOISON) {
+		kvm_handle_bad_page(hva, hugetlb, true);
+		return 0;
+	}
+
 	if (is_error_noslot_pfn(pfn))
 		return -EFAULT;
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 84ed239..4a80c3b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -386,6 +386,7 @@ int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
 			       struct kvm_device_attr *attr);
 int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 			       struct kvm_device_attr *attr);
+int kvm_vcpu_ioctl_sea(struct kvm_vcpu *vcpu);
 
 static inline void __cpu_init_stage2(void)
 {
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index b37446a..780e3c4 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -277,6 +277,13 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
+int kvm_vcpu_ioctl_sea(struct kvm_vcpu *vcpu)
+{
+	kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
+
+	return 0;
+}
+
 int __attribute_const__ kvm_target_cpu(void)
 {
 	unsigned long implementor = read_cpuid_implementor();
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index bb02909..1d2e2e7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1306,6 +1306,7 @@ struct kvm_s390_ucas_mapping {
 #define KVM_S390_GET_IRQ_STATE	  _IOW(KVMIO, 0xb6, struct kvm_s390_irq_state)
 /* Available with KVM_CAP_X86_SMM */
 #define KVM_SMI                   _IO(KVMIO,   0xb7)
+#define KVM_ARM_SEA               _IO(KVMIO,   0xb8)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
-- 
2.10.1
