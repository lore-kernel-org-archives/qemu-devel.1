Received: from eggs.gnu.org ([2001:4830:134:3::10]:52974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dNFGR-0000DD-AP
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dNFGM-0007qq-Dc
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:15:59 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dNFGM-0007qY-7p
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 05:15:54 -0400
Received: by mail-pg0-x243.google.com with SMTP id j186so20089633pge.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 02:15:54 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 20 Jun 2017 17:15:23 +0800
Message-Id: <20170620091526.4287-5-xiaoguangrong@tencent.com>
In-Reply-To: <20170620091526.4287-1-xiaoguangrong@tencent.com>
References: <20170620091526.4287-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 4/7] KVM: MMU: enable
 KVM_WRITE_PROTECT_ALL_MEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

The functionality of write protection for all guest memory is ready,
it is the time to make its usable for userspace which is indicated
by KVM_CAP_X86_WRITE_PROTECT_ALL_MEM

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 arch/x86/kvm/x86.c       | 21 +++++++++++++++++++++
 include/uapi/linux/kvm.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a2cd099..ad62c44 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2723,6 +2723,17 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_X2APIC_API:
 		r = KVM_X2APIC_API_VALID_FLAGS;
 		break;
+	case KVM_CAP_X86_WRITE_PROTECT_ALL_MEM:
+		/*
+		 * do not enable it if PML is supported, this is also the
+		 * hint to tell userspace write-protect is not needed for
+		 * dirty log.
+		 */
+		if (kvm_x86_ops->slot_enable_log_dirty)
+			r = 0;
+		else
+			r = 1;
+		break;
 	default:
 		r = 0;
 		break;
@@ -4208,6 +4219,16 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
+	case KVM_WRITE_PROTECT_ALL_MEM: {
+		if (kvm_x86_ops->slot_enable_log_dirty) {
+			r = -EINVAL;
+			break;
+		}
+
+		kvm_mmu_write_protect_all_pages(kvm, !!arg);
+		r = 0;
+		break;
+	}
 	case KVM_ENABLE_CAP: {
 		struct kvm_enable_cap cap;
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 577429a..7d4a395 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -895,6 +895,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_SPAPR_TCE_VFIO 142
 #define KVM_CAP_X86_GUEST_MWAIT 143
 #define KVM_CAP_ARM_USER_IRQ 144
+#define KVM_CAP_X86_WRITE_PROTECT_ALL_MEM 145
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1144,6 +1145,7 @@ struct kvm_vfio_spapr_tce {
 					struct kvm_userspace_memory_region)
 #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
 #define KVM_SET_IDENTITY_MAP_ADDR _IOW(KVMIO,  0x48, __u64)
+#define KVM_WRITE_PROTECT_ALL_MEM _IO(KVMIO,  0x49)
 
 /* enable ucontrol for s390 */
 struct kvm_s390_ucas_mapping {
-- 
2.9.4
