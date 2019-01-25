Received: from eggs.gnu.org ([209.51.188.92]:33846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn6jY-0001gk-LR
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn6jX-0001gV-Pw
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:01:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gn6jX-0001fH-KB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:01:43 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 25 Jan 2019 17:01:34 -0200
Message-Id: <20190125190134.25492-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] i386: Disable MSR_PLATFORM_INFO emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

Linux v4.12 introduced[1] emulation of MSR_PLATFORM_INFO and
MSR_MISC_FEATURES_ENABLES, and enabled the
MSR_PLATFORM_INFO_CPUID_FAULT bit unconditionally.  This made
guests incorrectly believe the VM emulates
MSR_MISC_FEATURES_ENABLES properly (which is not true because
QEMU has no migration code to handle the MSR).

The KVM_CAP_MSR_PLATFORM_INFO capability was added[2] to Linux
v4.19 to address the issue.  Use it to disable emulation of
MSR_PLATFORM_INFO and stop incorrectly exposing cpuid_fault to
guests.

References:
[1] commit db2336a80489 ("KVM: x86: virtualize cpuid faulting")
[2] commit 6fbbde9a1969 ("KVM: x86: Control guest reads of MSR_PLATFORM_INFO")

Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9af4542fb8..9629f25c90 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1647,6 +1647,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    /*
+     * QEMU doesn't initialize MSR_PLATFORM_INFO yet, so disable the MSR
+     * unconditionally until support for the MSR is properly implemented
+     */
+    if (kvm_check_extension(s, KVM_CAP_MSR_PLATFORM_INFO)) {
+        kvm_vm_enable_cap(s, KVM_CAP_MSR_PLATFORM_INFO, 0);
+    }
+
     return 0;
 }
 
-- 
2.18.0.rc1.1.g3f1ff2140
