Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1dDmin-0000Qi-HG
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1dDmik-0006IU-H1
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:58:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1dDmik-0006I5-6P
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:58:06 -0400
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Thu, 25 May 2017 14:56:43 +0800
Message-ID: <1495695403-8252-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] KVM: x86: Fix nmi injection failure when
 vcpu got blocked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkrcmar@redhat.com, herongguang.he@huawei.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, oscar.zhangbo@huawei.com, kvm@vger.kernel.org, ZhuangYanying <ann.zhuangyanying@huawei.com>

From: ZhuangYanying <ann.zhuangyanying@huawei.com>

When spin_lock_irqsave() deadlock occurs inside the guest, vcpu threads,
other than the lock-holding one, would enter into S state because of
pvspinlock. Then inject NMI via libvirt API "inject-nmi", the NMI could
not be injected into vm.

The reason is:
1 It sets nmi_queued to 1 when calling ioctl KVM_NMI in qemu, and sets
cpu->kvm_vcpu_dirty to true in do_inject_external_nmi() meanwhile.
2 It sets nmi_queued to 0 in process_nmi(), before entering guest, because
cpu->kvm_vcpu_dirty is true.

It's not enough just to check nmi_queued to decide whether to stay in
vcpu_block() or not. NMI should be injected immediately at any situation.
Add checking KVM_REQ_NMI request plus with nmi_queued in
vm_vcpu_has_events().

Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
---
 arch/x86/kvm/x86.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02363e3..2d15708 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8394,7 +8394,9 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.pv.pv_unhalted)
 		return true;
 
-	if (atomic_read(&vcpu->arch.nmi_queued))
+	if ((kvm_test_request(KVM_REQ_NMI, vcpu) ||
+	    atomic_read(&vcpu->arch.nmi_queued)) &&
+	    kvm_x86_ops->nmi_allowed(vcpu))
 		return true;
 
 	if (kvm_test_request(KVM_REQ_SMI, vcpu))
-- 
1.8.3.1
