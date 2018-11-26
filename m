Received: from eggs.gnu.org ([2001:4830:134:3::10]:45123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkN-000816-81
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkL-0004DM-Az
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:43 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRMkL-0004D6-5T
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id 79so17316773wmo.0
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:40:41 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s139sm2412468wmd.3.2018.11.26.11.40.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 26 Nov 2018 11:40:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Nov 2018 20:40:21 +0100
Message-Id: <1543261235-2834-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
References: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] target/i386: kvm: add VMX migration
 blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Nested VMX does not support live migration yet.  Add a blocker
until that is worked out.

Nested SVM only does not support it, but unfortunately it is
enabled by default for -cpu host so we cannot really disable it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f524e7d..27dcca5 100644
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
1.8.3.1
