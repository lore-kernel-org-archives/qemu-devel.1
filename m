Received: from eggs.gnu.org ([2001:4830:134:3::10]:32997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d5ruK-0005NB-UJ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d5ruJ-0006k7-T8
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:21 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d5ruJ-0006iv-N0
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:53:19 -0400
Received: by mail-pf0-x243.google.com with SMTP id o68so3793192pfj.2
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 03:53:19 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed,  3 May 2017 18:52:22 +0800
Message-Id: <20170503105224.19049-6-xiaoguangrong@tencent.com>
In-Reply-To: <20170503105224.19049-1-xiaoguangrong@tencent.com>
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 5/7] KVM: MMU: allow dirty log without write
 protect
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

A new flag, KVM_DIRTY_LOG_WITHOUT_WRITE_PROTECT, is introduced which
indicates the userspace just wants to get the snapshot of dirty bitmap

During live migration, after all snapshot of dirty bitmap is fetched
from KVM, the guest memory can be write protected by calling
KVM_WRITE_PROTECT_ALL_MEM

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 arch/x86/kvm/x86.c       |  1 +
 include/uapi/linux/kvm.h |  6 +++++-
 virt/kvm/kvm_main.c      | 15 ++++++++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dcbeaf4..524c96b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2670,6 +2670,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
  	case KVM_CAP_SPLIT_IRQCHIP:
 	case KVM_CAP_IMMEDIATE_EXIT:
 	case KVM_CAP_X86_WRITE_PROTECT_ALL_MEM:
+	case KVM_CAP_X86_DIRTY_LOG_WITHOUT_WRITE_PROTECT:
 		r = 1;
 		break;
 	case KVM_CAP_ADJUST_CLOCK:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 7d4a395..e0f348c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -443,9 +443,12 @@ struct kvm_interrupt {
 };
 
 /* for KVM_GET_DIRTY_LOG */
+
+#define KVM_DIRTY_LOG_WITHOUT_WRITE_PROTECT	0x1
+
 struct kvm_dirty_log {
 	__u32 slot;
-	__u32 padding1;
+	__u32 flags;
 	union {
 		void __user *dirty_bitmap; /* one bit per page */
 		__u64 padding2;
@@ -896,6 +899,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_X86_GUEST_MWAIT 143
 #define KVM_CAP_ARM_USER_IRQ 144
 #define KVM_CAP_X86_WRITE_PROTECT_ALL_MEM 145
+#define KVM_CAP_X86_DIRTY_LOG_WITHOUT_WRITE_PROTECT 146
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 035bc51..c82e4d1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1169,6 +1169,12 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 	unsigned long n;
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
+	bool write_protect;
+
+	if (log->flags & ~KVM_DIRTY_LOG_WITHOUT_WRITE_PROTECT)
+		return -EINVAL;
+
+	write_protect = !(log->flags & KVM_DIRTY_LOG_WITHOUT_WRITE_PROTECT);
 
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
@@ -1196,11 +1202,14 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 		if (!dirty_bitmap[i])
 			continue;
 
-		*is_dirty = true;
-
 		mask = xchg(&dirty_bitmap[i], 0);
 		dirty_bitmap_buffer[i] = mask;
 
+		if (!write_protect)
+			continue;
+
+		*is_dirty = true;
+
 		if (mask) {
 			offset = i * BITS_PER_LONG;
 			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
@@ -3155,7 +3164,7 @@ static long kvm_vm_compat_ioctl(struct file *filp,
 				   sizeof(compat_log)))
 			return -EFAULT;
 		log.slot	 = compat_log.slot;
-		log.padding1	 = compat_log.padding1;
+		log.flags	 = compat_log.padding1;
 		log.padding2	 = compat_log.padding2;
 		log.dirty_bitmap = compat_ptr(compat_log.dirty_bitmap);
 
-- 
2.9.3
