Received: from eggs.gnu.org ([2001:4830:134:3::10]:36270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utl-0007pY-48
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utj-0007ag-Sj
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:37 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:43589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utj-0007ZG-KK
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:35 -0400
Received: by mail-wr0-x22f.google.com with SMTP id p53so2401062wrc.10
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:08 +0200
Message-Id: <1523034681-33787-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/20] i386/hyperv: error out if features
 requested but unsupported
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

In order to guarantee compatibility on migration, QEMU should have
complete control over the features it announces to the guest via CPUID.

However, for a number of Hyper-V-related cpu properties, if the
corresponding feature is not supported by the underlying KVM, the
propery is silently ignored and the feature is not announced to the
guest.

Refuse to start with an error instead.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180330170209.20627-3-rkagan@virtuozzo.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b35623a..6c49954 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -632,11 +632,6 @@ static int hyperv_handle_properties(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (cpu->hyperv_time &&
-            kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) <= 0) {
-        cpu->hyperv_time = false;
-    }
-
     if (cpu->hyperv_relaxed_timing) {
         env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
     }
@@ -645,6 +640,12 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_APIC_ACCESS_AVAILABLE;
     }
     if (cpu->hyperv_time) {
+        if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_TIME) <= 0) {
+            fprintf(stderr, "Hyper-V clocksources "
+                    "(requested by 'hv-time' cpu flag) "
+                    "are not supported by kernel\n");
+            return -ENOSYS;
+        }
         env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
@@ -659,17 +660,41 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
         env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
     }
-    if (cpu->hyperv_crash && has_msr_hv_crash) {
+    if (cpu->hyperv_crash) {
+        if (!has_msr_hv_crash) {
+            fprintf(stderr, "Hyper-V crash MSRs "
+                    "(requested by 'hv-crash' cpu flag) "
+                    "are not supported by kernel\n");
+            return -ENOSYS;
+        }
         env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
     }
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
-    if (cpu->hyperv_reset && has_msr_hv_reset) {
+    if (cpu->hyperv_reset) {
+        if (!has_msr_hv_reset) {
+            fprintf(stderr, "Hyper-V reset MSR "
+                    "(requested by 'hv-reset' cpu flag) "
+                    "is not supported by kernel\n");
+            return -ENOSYS;
+        }
         env->features[FEAT_HYPERV_EAX] |= HV_RESET_AVAILABLE;
     }
-    if (cpu->hyperv_vpindex && has_msr_hv_vpindex) {
+    if (cpu->hyperv_vpindex) {
+        if (!has_msr_hv_vpindex) {
+            fprintf(stderr, "Hyper-V VP_INDEX MSR "
+                    "(requested by 'hv-vpindex' cpu flag) "
+                    "is not supported by kernel\n");
+            return -ENOSYS;
+        }
         env->features[FEAT_HYPERV_EAX] |= HV_VP_INDEX_AVAILABLE;
     }
-    if (cpu->hyperv_runtime && has_msr_hv_runtime) {
+    if (cpu->hyperv_runtime) {
+        if (!has_msr_hv_runtime) {
+            fprintf(stderr, "Hyper-V VP_RUNTIME MSR "
+                    "(requested by 'hv-runtime' cpu flag) "
+                    "is not supported by kernel\n");
+            return -ENOSYS;
+        }
         env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
     }
     if (cpu->hyperv_synic) {
-- 
1.8.3.1
