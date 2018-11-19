Received: from eggs.gnu.org ([2001:4830:134:3::10]:33628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gOoCt-0002xb-0u
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gOoCs-0002Ut-E2
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:23:34 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gOoCs-0002TJ-8A
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:23:34 -0500
Received: by mail-wm1-x342.google.com with SMTP id t15-v6so6270183wmt.0
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 10:23:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 19 Nov 2018 19:23:30 +0100
Message-Id: <20181119182330.17147-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] target/i386: kvm: add VMX migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Nested VMX does not support live migration yet.  Add a blocker
until that is worked out.

Nested SVM only does not support it, but unfortunately it is
enabled by default for -cpu host so we cannot really disable it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f524e7d929..27dcca5365 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -854,6 +854,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 }
 
 static Error *invtsc_mig_blocker;
+static Error *vmx_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
 
@@ -1246,6 +1247,17 @@ int kvm_arch_init_vcpu(CPUState *cs)
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
 
+    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
+        error_setg(&vmx_mig_blocker,
+                   "Nested VMX virtualization does not support live migration yet");
+        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            error_free(vmx_mig_blocker);
+            return r;
+        }
+    }
+
     if (env->mcg_cap & MCG_LMCE_P) {
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
-- 
2.19.1
