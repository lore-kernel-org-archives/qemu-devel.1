Received: from eggs.gnu.org ([2001:4830:134:3::10]:60063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1dDPBo-0008I1-Cl
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1dDPBl-0006zx-AW
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:50:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1dDPBk-0006xb-NF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:50:29 -0400
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Wed, 24 May 2017 13:48:42 +0800
Message-ID: <1495604922-4496-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] Fix nmi injection failure when vcpu got blocked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, herongguang.he@huawei.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, oscar.zhangbo@huawei.com, kvm@vger.kernel.org, ZhuangYanying <ann.zhuangyanying@huawei.com>

From: ZhuangYanying <ann.zhuangyanying@huawei.com>

Recently I found NMI could not be injected to vm via libvirt API
Reproduce the problem:
1 use guest of redhat 7.3
2 disable nmi_watchdog and trig spinlock deadlock inside the guest
check the running vcpu thread, make sure not vcpu0
3 inject NMI into the guest via libvirt API "inject-nmi"

Result:
The NMI could not be injected into the guest.

Reason:
1 It sets nmi_queued to 1 when calling ioctl KVM_NMI in qemu, and
sets cpu->kvm_vcpu_dirty to true in do_inject_external_nmi() meanwhile.
2 It sets nmi_queued to 0 in process_nmi(), before entering guest,
because cpu->kvm_vcpu_dirty is true.

Normally, vcpu could call vcpu_enter_guest successfully to inject the NMI.
However, in the problematic scenario, when the guest's threads hold
spin_lock_irqsave for a long time, such as entering a while loop after
spin_lock_irqsave(), other vcpus would enter into S state because of
pvspinlock scheme, then KVM module will loop in vcpu_block rather than
entry the guest.

I think that it's not suitable to decide whether to stay in vcpu_block()
or not just by checking nmi_queued, NMI should be injected immediately
even at this situation.

Solution:
There're 2 ways to solve the problem:
1 call cpu_synchronize_state_not_set_dirty() rather than
cpu_synchronize_state(), while injecting NMI, to avoid changing
nmi_queued to 0. But other workqueues may affect cpu->kvm_vcpu_dirty,
so it's not recommended.
2 add checking nmi_pending plus with nmi_queued in vm_vcpu_has_events()
in KVM module.

qemu_kvm_wait_io_event
  qemu_wait_io_event_common
    flush_queued_work
      do_inject_external_nmi
        cpu_synchronize_state
          kvm_cpu_synchronize_state
            do_kvm_cpu_synchronize_state
              cpu->kvm_vcpu_dirty = true;    /* trigger process_nmi */
        kvm_vcpu_ioctl(cpu, KVM_NMI)
          kvm_vcpu_ioctl_nmi
            kvm_inject_nmi
              atomic_inc(&vcpu->arch.nmi_queued);
                nmi_queued = 1
                /* nmi_queued set to 1, when qemu ioctl KVM_NMI */
              kvm_make_request(KVM_REQ_NMI, vcpu);
kvm_cpu_exec
  kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE);
    kvm_arch_put_registers
      kvm_put_vcpu_events
        kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
          kvm_vcpu_ioctl_x86_set_vcpu_events
            process_nmi(vcpu);
              vcpu->arch.nmi_pending +=
                    atomic_xchg(&vcpu->arch.nmi_queued, 0);
                nmi_queued = 0
                /* nmi_queued set to 0, vcpu thread always block */
                nmi_pending = 1
              kvm_make_request(KVM_REQ_EVENT, vcpu);
  kvm_vcpu_ioctl(cpu, KVM_RUN, 0);
    kvm_arch_vcpu_ioctl_run
      vcpu_run(vcpu);
        kvm_vcpu_running(vcpu)
          /* always false, could not call vcpu_enter_guest */
          vcpu_block
            kvm_arch_vcpu_runnable
              kvm_vcpu_has_events
                if (atomic_read(&vcpu->arch.nmi_queued))
                   /* nmi_queued is 0, vcpu thread always block*/

Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02363e3..96983dc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8394,7 +8394,8 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.pv.pv_unhalted)
 		return true;
 
-	if (atomic_read(&vcpu->arch.nmi_queued))
+	if (vcpu->arch.nmi_pending ||
+	    atomic_read(&vcpu->arch.nmi_queued))
 		return true;
 
 	if (kvm_test_request(KVM_REQ_SMI, vcpu))
-- 
1.8.3.1
