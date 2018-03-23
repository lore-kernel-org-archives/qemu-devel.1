Received: from eggs.gnu.org ([2001:4830:134:3::10]:43500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ezMH1-0002di-33
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ezMGy-000176-Gv
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:58:23 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 23 Mar 2018 15:58:07 +0300
Message-Id: <20180323125808.4479-2-rkagan@virtuozzo.com>
In-Reply-To: <20180323125808.4479-1-rkagan@virtuozzo.com>
References: <20180323125808.4479-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.12 1/2] i386/hyperv: add hv-frequencies
 cpu property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-stable@nongnu.org

In order to guarantee compatibility on migration, QEMU should have
complete control over the features it announces to the guest via CPUID.

However, the declared availability of Hyper-V frequency MSRs
(HV_X64_MSR_TSC_FREQUENCY and HV_X64_MSR_APIC_FREQUENCY) depends solely
on the support for them in the underlying KVM.

Introduce "hv-frequencies" cpu property (off by default) which gives
QEMU full control over whether these MSRs are announced.

While at this, drop the redundant check of the cpu tsc frequency, and
decouple this feature from hv-time.

Cc: qemu-stable@nongnu.org
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
Note: this patch introduces a new cpu property, which is not what we
normally do in stable branches.  However, this appears to be the minimal
effort/churn approach to reduce the number of published QEMU releases
where the behavior of the feature is unpredictable, with potentially
fatal consequences for the guest.

 target/i386/cpu.h |  1 +
 target/i386/cpu.c |  1 +
 target/i386/kvm.c | 12 ++++++++----
 3 files changed, 10 insertions(+), 4 deletions(-)

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
index d23fff12f5..fb20ff18c2 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -648,11 +648,15 @@ static int hyperv_handle_properties(CPUState *cs)
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
+            fprintf(stderr,
+                    "Hyper-V frequency MSRs are not supported by kernel\n");
+            return -ENOSYS;
         }
+        env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
+        env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
     }
     if (cpu->hyperv_crash && has_msr_hv_crash) {
         env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
-- 
2.14.3
