Received: from eggs.gnu.org ([2001:4830:134:3::10]:43157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f1xQ1-0002i4-83
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f1xPx-0006xl-ME
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:02:25 -0400
Received: from mail-he1eur01on0711.outbound.protection.outlook.com
	([2a01:111:f400:fe1e::711]:39856
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1f1xPx-0006si-55
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:02:21 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 30 Mar 2018 20:02:09 +0300
Message-Id: <20180330170209.20627-3-rkagan@virtuozzo.com>
In-Reply-To: <20180330170209.20627-1-rkagan@virtuozzo.com>
References: <20180330170209.20627-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.12 v3 2/2] i386/hyperv: error out if
 features requested but unsupported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

In order to guarantee compatibility on migration, QEMU should have
complete control over the features it announces to the guest via CPUID.

However, for a number of Hyper-V-related cpu properties, if the
corresponding feature is not supported by the underlying KVM, the
propery is silently ignored and the feature is not announced to the
guest.

Refuse to start with an error instead.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v2 -> v3:
 - include the fix for 'hv-time' missed previously

v1 -> v2:
 - indicate what flag requested the feature that can't be enabled in the
   error message
 - fix a typo in the error message for VP_RUNTIME

 target/i386/kvm.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b35623ae24..6c49954e68 100644
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
2.14.3
