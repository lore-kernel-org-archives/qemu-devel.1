Received: from eggs.gnu.org ([2001:4830:134:3::10]:59317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dbmiD-0004F1-Vw
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 07:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dbmiA-00068O-Sh
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 07:48:46 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:51882)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dbmiA-00065h-9B
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 07:48:42 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Mon, 31 Jul 2017 04:01:38 +0800
Message-Id: <1501444898-27668-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] target-i386 : fix a race condition result to
 lost INIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

when SMP VM start, AP may lost INIT because of receiving INIT between
kvm_vcpu_ioctl_x86_get/set_vcpu_events.

   vcpu 0                             vcpu 1
                               kvm_vcpu_ioctl_x86_get_vcpu_events
                                       events->smi.latched_init=0
 send INIT to vcpu1
   set vcpu1's pending_events
                               kvm_vcpu_ioctl_x86_set_vcpu_events
                                    events->smi.latched_init == 0
                                      clear INIT in pending_events
considering migration, just at level >= KVM_PUT_RESET_STATE,
add KVM_VCPUEVENT_VALID_SMM in events.flags.I think it is better to
modify in qemu.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 target/i386/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index a6613e1..be146cb 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2438,7 +2438,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
         /* Stop SMI delivery on old machine types to avoid a reboot
          * on an inward migration of an old VM.
          */
-        if (!cpu->kvm_no_smi_migration) {
+        if (!cpu->kvm_no_smi_migration && (level >= KVM_PUT_RESET_STATE)) {
             events.flags |= KVM_VCPUEVENT_VALID_SMM;
         }
     }
-- 
1.8.3.1
