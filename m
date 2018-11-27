Received: from eggs.gnu.org ([2001:4830:134:3::10]:35109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReTm-0003i1-Vx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReTk-00018a-GR
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:36:46 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gReTk-000166-AB
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:36:44 -0500
Received: by mail-wm1-x343.google.com with SMTP id j207so14987481wmj.1
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:36:44 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id
	n62sm2821869wmd.25.2018.11.27.06.36.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Nov 2018 06:36:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Nov 2018 15:36:23 +0100
Message-Id: <1543329397-48407-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
References: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
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
index 3d6739a..2724800 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -855,6 +855,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 }
 
 static Error *invtsc_mig_blocker;
+static Error *vmx_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
 
@@ -1247,6 +1248,17 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
