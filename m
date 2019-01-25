Received: from eggs.gnu.org ([209.51.188.92]:59539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn9cA-0004vt-Sp
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn9cA-0006Ex-0m
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gn9c7-0006B6-NH
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:17 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 25 Jan 2019 20:06:05 -0200
Message-Id: <20190125220606.4864-2-ehabkost@redhat.com>
In-Reply-To: <20190125220606.4864-1-ehabkost@redhat.com>
References: <20190125220606.4864-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] i386: kvm: Disable arch_capabilities if
 MSR can't be set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Tao Xu <tao5.xu@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jim Mattson <jmattson@google.com>, KarimAllah Ahmed <karahmed@amazon.de>, David Woodhouse <dwmw@amazon.co.uk>, Darren Kenny <darren.kenny@oracle.com>

KVM has two bugs in the handling of MSR_IA32_ARCH_CAPABILITIES:

1) Linux commit commit 1eaafe91a0df ("kvm: x86: IA32_ARCH_CAPABILITIES
   is always supported") makes GET_SUPPORTED_CPUID return
   arch_capabilities even if running on SVM.  This makes "-cpu
   host,migratable=off" incorrectly expose arch_capabilities on CPUID on
   AMD hosts (where the MSR is not emulated by KVM).

2) KVM_GET_MSR_INDEX_LIST does not return MSR_IA32_ARCH_CAPABILITIES if
   the MSR is not supported by the host CPU.  This makes QEMU not
   initialize the MSR properly at kvm_put_msrs() on those hosts.

Work around both bugs on the QEMU side, by checking if the MSR
was returned by KVM_GET_MSR_INDEX_LIST before returning the
feature flag on kvm_arch_get_supported_cpuid().

This has the unfortunate side effect of making arch_capabilities
unavailable on hosts without hardware support for the MSR until bug #2
is fixed on KVM, but I can't see another way to work around bug #1
without that side effect.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Darren Kenny <darren.kenny@oracle.com>
---
 target/i386/kvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9af4542fb8..4fa3e3806a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -389,6 +389,15 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         if (host_tsx_blacklisted()) {
             ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
         }
+    } else if (function == 7 && index == 0 && reg == R_EDX) {
+        /*
+         * Linux incorrectly v4.17-v4.20 return ARCH_CAPABILITIES on SVM.
+         * We can detect the bug by checking if MSR_IA32_ARCH_CAPABILITIES is
+         * returned by KVM_GET_MSR_INDEX_LIST.
+         */
+        if (!has_msr_arch_capabs) {
+            ret &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
+        }
     } else if (function == 0x80000001 && reg == R_ECX) {
         /*
          * It's safe to enable TOPOEXT even if it's not returned by
-- 
2.18.0.rc1.1.g3f1ff2140
