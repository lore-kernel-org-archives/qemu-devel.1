Received: from eggs.gnu.org ([2001:4830:134:3::10]:60336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dV5zs-0003P9-3B
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dV5zo-0006Uo-1x
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:59:20 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:50455)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dV5zn-0006UL-Ex
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:59:15 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 12 Jul 2017 17:12:07 +0800
Message-Id: <1499850727-50728-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] target-i386:kvm_get/put_vcpu_events don't
 handle sipi_vector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, pbonzini@redhat.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

qemu call kvm_get_vcpu_events, and kernel return sipi_vector always 0,
never valid when reporting to user space. But qemu call kvm_put_vcpu_events
will make sipi_vector in kernel be 0. This will accidently modify sipi_vector
when sipi_vector in kernel is not 0.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 target/i386/kvm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f84a49d..bbbd696 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2417,7 +2417,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.nmi.masked = !!(env->hflags2 & HF2_NMI_MASK);
     events.nmi.pad = 0;
 
-    events.sipi_vector = env->sipi_vector;
     events.flags = 0;
 
     if (has_msr_smbase) {
@@ -2506,8 +2505,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
         }
     }
 
-    env->sipi_vector = events.sipi_vector;
-
     return 0;
 }
 
-- 
1.8.3.1
