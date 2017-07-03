Received: from eggs.gnu.org ([2001:4830:134:3::10]:60242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dS3D0-0000sE-Iu
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dS3Cy-0007ZP-0K
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:24:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:26935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dS3Cx-0007YR-OH
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:24:15 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon,  3 Jul 2017 23:23:38 +0800
Message-Id: <20170703152338.20024-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH] i386/kvm: mask MSR_IA32_BNDCFGS if MPX is not
 enabled in guest cpuid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>

Otherwise, QEMU on a host with MPX support will try to set guest
MSR_IA32_BNDCFGS although guest MPX is not enabled, and result in
abort.

For example,
   qemu-system-x86_64 -enable-kvm -cpu qemu64,-mpx ...
aborts with messages:
   qemu-system-x86_64: error: failed to set MSR 0xd90 to 0x0
   qemu-system-x86_64: /root/qemu.git/target/i386/kvm.c:1832: kvm_put_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 target/i386/kvm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ee36502789..7b3a310a31 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -943,6 +943,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
 
+    if (has_msr_bndcfgs) {
+        c = cpuid_find_entry(&cpuid_data.cpuid, 7, 0);
+        has_msr_bndcfgs = c && (c->ebx & CPUID_7_0_EBX_MPX);
+    }
+
     if (!env->user_tsc_khz) {
         if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
             invtsc_mig_blocker == NULL) {
-- 
2.11.0
