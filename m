Received: from eggs.gnu.org ([2001:4830:134:3::10]:59010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1ddYnl-0000iO-6s
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1ddYni-0008Jr-1l
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:21:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1ddYnh-0008Ip-Rg
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:21:45 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri,  4 Aug 2017 11:14:03 +0200
Message-Id: <20170804091403.13478-4-lprosek@redhat.com>
In-Reply-To: <20170804091403.13478-1-lprosek@redhat.com>
References: <20170804091403.13478-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] i386/kvm: advertise Hyper-V frequency MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rkrcmar@redhat.com

As of kernel commit eb82feea59d6 ("KVM: hyperv: support HV_X64_MSR_TSC_FREQUENCY
and HV_X64_MSR_APIC_FREQUENCY"), KVM supports two new MSRs which are required
for nested Hyper-V to read timestamps with RDTSC + TSC page.

This commit makes QEMU advertise the MSRs with CPUID.40000003H:EAX[11] and
CPUID.40000003H:EDX[8] as specified in the Hyper-V TLFS and experimentally
verified on a Hyper-V host. The feature is enabled with the existing hv-time CPU
flag, and only if the TSC frequency is stable across migration and known.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 target/i386/kvm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 77b6373..7e484a7 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -89,6 +89,7 @@ static bool has_msr_hv_vpindex;
 static bool has_msr_hv_runtime;
 static bool has_msr_hv_synic;
 static bool has_msr_hv_stimer;
+static bool has_msr_hv_frequencies;
 static bool has_msr_xss;
 
 static bool has_msr_architectural_pmu;
@@ -631,7 +632,17 @@ static int hyperv_handle_properties(CPUState *cs)
     if (cpu->hyperv_time) {
         env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_HYPERCALL_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_TIME_REF_COUNT_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |= 0x200;
+        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_REFERENCE_TSC_AVAILABLE;
+        if (has_msr_hv_frequencies
+            /* TSC clock must be stable and known for this feature. */
+            && ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC)
+                || env->user_tsc_khz != 0)
+            && env->tsc_khz != 0) {
+
+            env->features[FEAT_HYPERV_EAX] |= HV_X64_ACCESS_FREQUENCY_MSRS;
+            env->features[FEAT_HYPERV_EDX] |=
+                HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
+        }
     }
     if (cpu->hyperv_crash && has_msr_hv_crash) {
         env->features[FEAT_HYPERV_EDX] |= HV_X64_GUEST_CRASH_MSR_AVAILABLE;
@@ -1127,6 +1138,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case HV_X64_MSR_STIMER0_CONFIG:
                     has_msr_hv_stimer = true;
                     break;
+                case HV_X64_MSR_TSC_FREQUENCY:
+                    has_msr_hv_frequencies = true;
+                    break;
                 }
 
             }
-- 
2.9.3
