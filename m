Received: from eggs.gnu.org ([2001:4830:134:3::10]:33032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKPKa-00020i-GC
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKPKX-000883-Ar
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:24:32 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKPKW-00086B-M7
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:24:29 -0400
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Mon, 12 Jun 2017 21:23:16 +0800
Message-ID: <1497273796-44720-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC] KVM: X86: save and load
 PVCLOCK_TSC_UNSTABLE_BIT when migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, Jay Zhou <jianjay.zhou@huawei.com>

Guest using kvmclock will be hanged when migrating from unstable
tsc host to stable tsc host occasionally.
Sometimes, the tsc timestamp saved at the source side will be
backward when the guest stopped, and this value is transferred
to the destination side. The guest at the destination side thought
kvmclock is stable, so the protection mechanism against time
going backwards is not used.
When the first time vcpu0 enters the guest at the destination
side to update the wall clock, the result of
pvclock_clocksource_read will be backward occasionally,
which results in the wall clock drift.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/include/uapi/asm/kvm.h | 2 ++
 arch/x86/kvm/x86.c              | 7 ++++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 695605e..6dd21ff 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -783,6 +783,7 @@ struct kvm_arch {
 
 	spinlock_t pvclock_gtod_sync_lock;
 	bool use_master_clock;
+	bool kvmclock_migration_unstable_tsc;
 	u64 master_kernel_ns;
 	u64 master_cycle_now;
 	struct delayed_work kvmclock_update_work;
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index c2824d0..9faed3e 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -360,4 +360,6 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 
+#define MIGRATION_PVCLOCK_TSC_UNSTABLE_BIT (1 << 0)
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 87d3cb9..a0f7011 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1920,7 +1920,8 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	/* If the host uses TSC clocksource, then it is stable */
 	pvclock_flags = 0;
-	if (use_master_clock)
+	if (use_master_clock &&
+		!(v->kvm->arch.kvmclock_migration_unstable_tsc))
 		pvclock_flags |= PVCLOCK_TSC_STABLE_BIT;
 
 	vcpu->hv_clock.flags = pvclock_flags;
@@ -4184,8 +4185,8 @@ long kvm_arch_vm_ioctl(struct file *filp,
 			goto out;
 
 		r = -EINVAL;
-		if (user_ns.flags)
-			goto out;
+		if (user_ns.flags & MIGRATION_PVCLOCK_TSC_UNSTABLE_BIT)
+			kvm->arch.kvmclock_migration_unstable_tsc = true;
 
 		r = 0;
 		now_ns = get_kvmclock_ns(kvm);
-- 
1.8.3.1
