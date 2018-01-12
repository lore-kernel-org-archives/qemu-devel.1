Received: from eggs.gnu.org ([2001:4830:134:3::10]:41441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYW-0007Ad-Nr
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYV-0004Nt-EU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:28 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYV-0004Lk-3x
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:27 -0500
Received: by mail-wm0-x242.google.com with SMTP id x4so1968733wmc.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:29 +0100
Message-Id: <1515756676-3860-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/52] i386/cpu/kvm: look at PMU's CPUID before
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
Cc: Jan Dakinevich <jan.dakinevich@virtuozzo.com>

From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>

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
Message-Id: <1514383466-7257-1-git-send-email-jan.dakinevich@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 80 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6f69e2f..d23127c 100644
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
@@ -1650,32 +1660,36 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
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
@@ -2030,15 +2044,17 @@ static int kvm_get_msrs(X86CPU *cpu)
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
1.8.3.1
