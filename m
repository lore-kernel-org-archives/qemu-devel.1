Received: from eggs.gnu.org ([2001:4830:134:3::10]:54843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbY4-0007zb-FS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbY3-0002ir-Sg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:39:08 -0400
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 19 Oct 2018 21:39:06 +0100
Message-Id: <1539981546-10596-9-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v4 8/8] kvm: Potential NULL pointer dereference
 in kvm_arch_init_vcpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com, mreitz@redhat.com

In kvm_arch_init_vcpu() a call to cpuid_find_entry() can return
NULL so the pointer returned should be checked before dereferencing it.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---
 target/i386/kvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dc4047b02fc5..eb19c87a9d25 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1177,7 +1177,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c->ecx = c->edx = 0;
 
         c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
-        c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
+        if (c) {
+            c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
+       }
     }
 
     cpuid_data.cpuid.nent = cpuid_i;
-- 
1.8.3.1
