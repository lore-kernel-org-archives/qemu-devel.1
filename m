Received: from eggs.gnu.org ([2001:4830:134:3::10]:59909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfK-000466-Ck
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfE-0005My-J7
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:14 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfE-0005M7-D2
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:08 -0400
Received: by mail-wm0-x241.google.com with SMTP id e64so3756809wmi.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:10 +0200
Message-Id: <1505824179-21541-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/50] i386/kvm: advertise Hyper-V frequency MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

As of kernel commit eb82feea59d6 ("KVM: hyperv: support HV_X64_MSR_TSC_FREQUENCY
and HV_X64_MSR_APIC_FREQUENCY"), KVM supports two new MSRs which are required
for nested Hyper-V to read timestamps with RDTSC + TSC page.

This commit makes QEMU advertise the MSRs with CPUID.40000003H:EAX[11] and
CPUID.40000003H:EDX[8] as specified in the Hyper-V TLFS and experimentally
verified on a Hyper-V host. The feature is enabled with the existing hv-time CPU
flag, and only if the TSC frequency is stable across migrations and known.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170807085703.32267-5-lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2dc01c9..739334a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -89,6 +89,7 @@ static bool has_msr_hv_vpindex;
 static bool has_msr_hv_runtime;
 static bool has_msr_hv_synic;
 static bool has_msr_hv_stimer;
+static bool has_msr_hv_frequencies;
 static bool has_msr_xss;
 
 static bool has_msr_architectural_pmu;
@@ -640,7 +641,13 @@ static int hyperv_handle_properties(CPUState *cs)
     if (cpu->hyperv_time) {
         env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_HYPERCALL_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_TIME_REF_COUNT_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |= 0x200;
+        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_REFERENCE_TSC_AVAILABLE;
+
+        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
+            env->features[FEAT_HYPERV_EAX] |= HV_X64_ACCESS_FREQUENCY_MSRS;
+            env->features[FEAT_HYPERV_EDX] |=
+                HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
+        }
     }
     if (cpu->hyperv_crash && has_msr_hv_crash) {
         env->features[FEAT_HYPERV_EDX] |= HV_X64_GUEST_CRASH_MSR_AVAILABLE;
@@ -1134,6 +1141,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case HV_X64_MSR_STIMER0_CONFIG:
                     has_msr_hv_stimer = true;
                     break;
+                case HV_X64_MSR_TSC_FREQUENCY:
+                    has_msr_hv_frequencies = true;
+                    break;
                 }
             }
         }
-- 
1.8.3.1
