Received: from eggs.gnu.org ([2001:4830:134:3::10]:52630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1eUCKG-000436-U6
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 09:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1eUCKA-0002tr-S0
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 09:04:55 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:21475 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.dakinevich@virtuozzo.com>)
	id 1eUCKA-0002oX-C3
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 09:04:50 -0500
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Wed, 27 Dec 2017 17:04:26 +0300
Message-Id: <1514383466-7257-1-git-send-email-jan.dakinevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] i386/cpu/kvm: look at PMU's CPUID before
 setting MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@virtuozzo.com>, Roman Kagan <rkagan@virtuozzo.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org

Certain PMU-related MSRs are not supported for CPUs with PMU
architecture below version 2. KVM rejects any access to them (see
intel_is_valid_msr_idx routine in KVM), and QEMU fails on the following
assertion:

  kvm_put_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.

QEMU also could fail if KVM exposes less fixed counters then 3. It could
happen if host system run inside another hypervisor, which is tweaking
PMU-related CPUID. To prevent possible fail, number of fixed counters now is
obtained in the same way as number of GP counters.

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 target/i386/kvm.c | 80 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 351b64f..a6790db 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -92,8 +92,9 @@ static bool has_msr_hv_stimer;
 static bool has_msr_hv_frequencies;
 static bool has_msr_xss;
 
-static bool has_msr_architectural_pmu;
-static uint32_t num_architectural_pmu_counters;
+static uint32_t has_architectural_pmu_version;
+static uint32_t num_architectural_pmu_gp_counters;
+static uint32_t num_architectural_pmu_fixed_counters;
 
 static int has_xsave;
 static int has_xcrs;
@@ -872,19 +873,28 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     if (limit >= 0x0a) {
-        uint32_t ver;
+        uint32_t eax, edx;
 
-        cpu_x86_cpuid(env, 0x0a, 0, &ver, &unused, &unused, &unused);
-        if ((ver & 0xff) > 0) {
-            has_msr_architectural_pmu = true;
-            num_architectural_pmu_counters = (ver & 0xff00) >> 8;
+        cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
+
+        has_architectural_pmu_version = eax & 0xff;
+        if (has_architectural_pmu_version > 0) {
+            num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
 
             /* Shouldn't be more than 32, since that's the number of bits
              * available in EBX to tell us _which_ counters are available.
              * Play it safe.
              */
-            if (num_architectural_pmu_counters > MAX_GP_COUNTERS) {
-                num_architectural_pmu_counters = MAX_GP_COUNTERS;
+            if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
+                num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
+            }
+
+            if (has_architectural_pmu_version > 1) {
+                num_architectural_pmu_fixed_counters = edx & 0x1f;
+
+                if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
+                    num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
+                }
             }
         }
     }
@@ -1652,32 +1662,36 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
             kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, env->steal_time_msr);
         }
-        if (has_msr_architectural_pmu) {
-            /* Stop the counter.  */
-            kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
-            kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
+        if (has_architectural_pmu_version > 0) {
+            if (has_architectural_pmu_version > 1) {
+                /* Stop the counter.  */
+                kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
+            }
 
             /* Set the counter values.  */
-            for (i = 0; i < MAX_FIXED_COUNTERS; i++) {
+            for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
                                   env->msr_fixed_counters[i]);
             }
-            for (i = 0; i < num_architectural_pmu_counters; i++) {
+            for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
                 kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i,
                                   env->msr_gp_counters[i]);
                 kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i,
                                   env->msr_gp_evtsel[i]);
             }
-            kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS,
-                              env->msr_global_status);
-            kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
-                              env->msr_global_ovf_ctrl);
-
-            /* Now start the PMU.  */
-            kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL,
-                              env->msr_fixed_ctr_ctrl);
-            kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL,
-                              env->msr_global_ctrl);
+            if (has_architectural_pmu_version > 1) {
+                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS,
+                                  env->msr_global_status);
+                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
+                                  env->msr_global_ovf_ctrl);
+
+                /* Now start the PMU.  */
+                kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL,
+                                  env->msr_fixed_ctr_ctrl);
+                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL,
+                                  env->msr_global_ctrl);
+            }
         }
         /*
          * Hyper-V partition-wide MSRs: to avoid clearing them on cpu hot-add,
@@ -2032,15 +2046,17 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
         kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, 0);
     }
-    if (has_msr_architectural_pmu) {
-        kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
-        kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
-        kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS, 0);
-        kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL, 0);
-        for (i = 0; i < MAX_FIXED_COUNTERS; i++) {
+    if (has_architectural_pmu_version > 0) {
+        if (has_architectural_pmu_version > 1) {
+            kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+            kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
+            kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS, 0);
+            kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL, 0);
+        }
+        for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
         }
-        for (i = 0; i < num_architectural_pmu_counters; i++) {
+        for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
             kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i, 0);
             kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i, 0);
         }
-- 
2.1.4
