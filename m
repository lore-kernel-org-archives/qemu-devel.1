Received: from eggs.gnu.org ([209.51.188.92]:59932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gorBF-0002vC-Lp
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gorBF-0004x2-0p
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:49:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gorBE-0004wO-P2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:49:32 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed, 30 Jan 2019 14:49:20 +0000
Message-Id: <1548859760-10654-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH] kvm: Potential NULL pointer dereference in
 kvm_arch_init_vcpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, liam.merwick@oracle.com

From: Liam Merwick <Liam.Merwick@oracle.com>

In kvm_arch_init_vcpu() a call to cpuid_find_entry() can return
NULL so the pointer returned should be checked before dereferencing it.

Reported by the Parfait static code analysis tool

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---
 target/i386/kvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9af4542fb8a8..89fac4a5576c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1308,7 +1308,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c->ecx = c->edx = 0;
 
         c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
-        c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
+        if (c) {
+            c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
+	}
     }
 
     cpuid_data.cpuid.nent = cpuid_i;
-- 
1.8.3.1
