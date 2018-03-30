Received: from eggs.gnu.org ([2001:4830:134:3::10]:43160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f1xQ1-0002i5-8k
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f1xPw-0006wG-Sg
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:02:25 -0400
Received: from mail-he1eur01on0711.outbound.protection.outlook.com
	([2a01:111:f400:fe1e::711]:39856
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1f1xPw-0006si-Kg
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:02:20 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 30 Mar 2018 20:02:08 +0300
Message-Id: <20180330170209.20627-2-rkagan@virtuozzo.com>
In-Reply-To: <20180330170209.20627-1-rkagan@virtuozzo.com>
References: <20180330170209.20627-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.12 v3 1/2] i386/hyperv: add
 hv-frequencies cpu property
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

However, the availability of Hyper-V frequency MSRs
(HV_X64_MSR_TSC_FREQUENCY and HV_X64_MSR_APIC_FREQUENCY) depends solely
on the support for them in the underlying KVM.

Introduce "hv-frequencies" cpu property (off by default) which gives
QEMU full control over whether these MSRs are announced.

While at this, drop the redundant check of the cpu tsc frequency, and
decouple this feature from hv-time.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
v2 -> v3:
 - no changes

v1 -> v2:
 - indicate what flag requested the feature that can't be enabled in the
   error message

 target/i386/cpu.h |  1 +
 target/i386/cpu.c |  1 +
 target/i386/kvm.c | 13 +++++++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 78db1b833a..1b219fafc4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1296,6 +1296,7 @@ struct X86CPU {
     bool hyperv_runtime;
     bool hyperv_synic;
     bool hyperv_stimer;
+    bool hyperv_frequencies;
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 555ae79d29..1a6b082b6f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4761,6 +4761,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("hv-runtime", X86CPU, hyperv_runtime, false),
     DEFINE_PROP_BOOL("hv-synic", X86CPU, hyperv_synic, false),
     DEFINE_PROP_BOOL("hv-stimer", X86CPU, hyperv_stimer, false),
+    DEFINE_PROP_BOOL("hv-frequencies", X86CPU, hyperv_frequencies, false),
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d23fff12f5..b35623ae24 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -648,11 +648,16 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
-
-        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
-            env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
-            env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
+    }
+    if (cpu->hyperv_frequencies) {
+        if (!has_msr_hv_frequencies) {
+            fprintf(stderr, "Hyper-V frequency MSRs "
+                    "(requested by 'hv-frequencies' cpu flag) "
+                    "are not supported by kernel\n");
+            return -ENOSYS;
         }
+        env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
+        env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
     }
     if (cpu->hyperv_crash && has_msr_hv_crash) {
         env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
-- 
2.14.3
