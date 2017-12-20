Received: from eggs.gnu.org ([2001:4830:134:3::10]:56201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy6-0004NA-Vu
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy5-00076K-W3
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:46 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhy5-00075V-O2
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:45 -0500
Received: by mail-wm0-x242.google.com with SMTP id f206so11067847wmf.5
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:45 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:22 +0100
Message-Id: <1513790098-9815-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/46] hyperv: ensure SINTx msrs are reset
 properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Initially SINTx msrs should be in "masked" state.  To ensure that
happens on *every* reset, move setting their values to
kvm_arch_vcpu_reset.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20171122181418.14180-3-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 89fa65e..5d93391 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -662,8 +662,6 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
     }
     if (cpu->hyperv_synic) {
-        int sint;
-
         if (!has_msr_hv_synic ||
             kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC, 0)) {
             fprintf(stderr, "Hyper-V SynIC is not supported by kernel\n");
@@ -672,9 +670,6 @@ static int hyperv_handle_properties(CPUState *cs)
 
         env->features[FEAT_HYPERV_EAX] |= HV_SYNIC_AVAILABLE;
         env->msr_hv_synic_version = HV_SYNIC_VERSION;
-        for (sint = 0; sint < ARRAY_SIZE(env->msr_hv_synic_sint); sint++) {
-            env->msr_hv_synic_sint[sint] = HV_SINT_MASKED;
-        }
     }
     if (cpu->hyperv_stimer) {
         if (!has_msr_hv_stimer) {
@@ -1053,6 +1048,13 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
     } else {
         env->mp_state = KVM_MP_STATE_RUNNABLE;
     }
+
+    if (cpu->hyperv_synic) {
+        int i;
+        for (i = 0; i < ARRAY_SIZE(env->msr_hv_synic_sint); i++) {
+            env->msr_hv_synic_sint[i] = HV_SINT_MASKED;
+        }
+    }
 }
 
 void kvm_arch_do_init_vcpu(X86CPU *cpu)
-- 
1.8.3.1
