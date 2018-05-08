Received: from eggs.gnu.org ([2001:4830:134:3::10]:41606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtG-0003H5-6A
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtD-0001aE-JM
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:22 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAtD-0001ZG-9Z
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:19 -0400
Received: by mail-wm0-x241.google.com with SMTP id y189-v6so5982855wmc.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:41 +0200
Message-Id: <1525817687-34620-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/30] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

KVM recently gained support for Hyper-V Reenlightenment MSRs which are
required to make KVM-on-Hyper-V enable TSC page clocksource to its guests
when INVTSC is not passed to it (and it is not passed by default in Qemu
as it effectively blocks migration).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20180411115036.31832-2-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c          |  4 +++-
 target/i386/cpu.h          |  4 ++++
 target/i386/hyperv-proto.h |  9 ++++++++-
 target/i386/kvm.c          | 39 ++++++++++++++++++++++++++++++++++++++-
 target/i386/machine.c      | 24 ++++++++++++++++++++++++
 5 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a20fe26..b0a1c62 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -416,7 +416,8 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL /* hv_vpindex_access */, NULL /* hv_msr_reset_access */,
             NULL /* hv_msr_stats_access */, NULL /* hv_reftsc_access */,
             NULL /* hv_msr_idle_access */, NULL /* hv_msr_frequency_access */,
-            NULL, NULL, NULL, NULL,
+            NULL /* hv_msr_debug_access */, NULL /* hv_msr_reenlightenment_access */,
+            NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -4770,6 +4771,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("hv-synic", X86CPU, hyperv_synic, false),
     DEFINE_PROP_BOOL("hv-stimer", X86CPU, hyperv_stimer, false),
     DEFINE_PROP_BOOL("hv-frequencies", X86CPU, hyperv_frequencies, false),
+    DEFINE_PROP_BOOL("hv-reenlightenment", X86CPU, hyperv_reenlightenment, false),
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1b219fa..b58b779 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1174,6 +1174,9 @@ typedef struct CPUX86State {
     uint64_t msr_hv_synic_sint[HV_SINT_COUNT];
     uint64_t msr_hv_stimer_config[HV_STIMER_COUNT];
     uint64_t msr_hv_stimer_count[HV_STIMER_COUNT];
+    uint64_t msr_hv_reenlightenment_control;
+    uint64_t msr_hv_tsc_emulation_control;
+    uint64_t msr_hv_tsc_emulation_status;
 
     uint64_t msr_rtit_ctrl;
     uint64_t msr_rtit_status;
@@ -1297,6 +1300,7 @@ struct X86CPU {
     bool hyperv_synic;
     bool hyperv_stimer;
     bool hyperv_frequencies;
+    bool hyperv_reenlightenment;
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index cb4d7f2..93352eb 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -35,7 +35,7 @@
 #define HV_RESET_AVAILABLE           (1u << 7)
 #define HV_REFERENCE_TSC_AVAILABLE   (1u << 9)
 #define HV_ACCESS_FREQUENCY_MSRS     (1u << 11)
-
+#define HV_ACCESS_REENLIGHTENMENTS_CONTROL  (1u << 13)
 
 /*
  * HV_CPUID_FEATURES.EDX bits
@@ -130,6 +130,13 @@
 #define HV_CRASH_CTL_NOTIFY                     (1ull << 63)
 
 /*
+ * Reenlightenment notification MSRs
+ */
+#define HV_X64_MSR_REENLIGHTENMENT_CONTROL      0x40000106
+#define HV_X64_MSR_TSC_EMULATION_CONTROL        0x40000107
+#define HV_X64_MSR_TSC_EMULATION_STATUS         0x40000108
+
+/*
  * Hypercall status code
  */
 #define HV_STATUS_SUCCESS                     0
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6c49954..d6666a4 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -90,6 +90,7 @@ static bool has_msr_hv_runtime;
 static bool has_msr_hv_synic;
 static bool has_msr_hv_stimer;
 static bool has_msr_hv_frequencies;
+static bool has_msr_hv_reenlightenment;
 static bool has_msr_xss;
 static bool has_msr_spec_ctrl;
 static bool has_msr_smi_count;
@@ -583,7 +584,8 @@ static bool hyperv_enabled(X86CPU *cpu)
             cpu->hyperv_vpindex ||
             cpu->hyperv_runtime ||
             cpu->hyperv_synic ||
-            cpu->hyperv_stimer);
+            cpu->hyperv_stimer ||
+            cpu->hyperv_reenlightenment);
 }
 
 static int kvm_arch_set_tsc_khz(CPUState *cs)
@@ -669,6 +671,16 @@ static int hyperv_handle_properties(CPUState *cs)
         }
         env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
     }
+    if (cpu->hyperv_reenlightenment) {
+        if (!has_msr_hv_reenlightenment) {
+            fprintf(stderr,
+                    "Hyper-V Reenlightenment MSRs "
+                    "(requested by 'hv-reenlightenment' cpu flag) "
+                    "are not supported by kernel\n");
+            return -ENOSYS;
+        }
+        env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_REENLIGHTENMENTS_CONTROL;
+    }
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
     if (cpu->hyperv_reset) {
         if (!has_msr_hv_reset) {
@@ -1215,6 +1227,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case HV_X64_MSR_TSC_FREQUENCY:
                     has_msr_hv_frequencies = true;
                     break;
+                case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+                    has_msr_hv_reenlightenment = true;
+                    break;
                 case MSR_IA32_SPEC_CTRL:
                     has_msr_spec_ctrl = true;
                     break;
@@ -1778,6 +1793,14 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                 kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC,
                                   env->msr_hv_tsc);
             }
+            if (cpu->hyperv_reenlightenment) {
+                kvm_msr_entry_add(cpu, HV_X64_MSR_REENLIGHTENMENT_CONTROL,
+                                  env->msr_hv_reenlightenment_control);
+                kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_CONTROL,
+                                  env->msr_hv_tsc_emulation_control);
+                kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS,
+                                  env->msr_hv_tsc_emulation_status);
+            }
         }
         if (cpu->hyperv_vapic) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_APIC_ASSIST_PAGE,
@@ -2140,6 +2163,11 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (cpu->hyperv_time) {
         kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC, 0);
     }
+    if (cpu->hyperv_reenlightenment) {
+        kvm_msr_entry_add(cpu, HV_X64_MSR_REENLIGHTENMENT_CONTROL, 0);
+        kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_CONTROL, 0);
+        kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS, 0);
+    }
     if (has_msr_hv_crash) {
         int j;
 
@@ -2397,6 +2425,15 @@ static int kvm_get_msrs(X86CPU *cpu)
             env->msr_hv_stimer_count[(index - HV_X64_MSR_STIMER0_COUNT)/2] =
                                 msrs[i].data;
             break;
+        case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+            env->msr_hv_reenlightenment_control = msrs[i].data;
+            break;
+        case HV_X64_MSR_TSC_EMULATION_CONTROL:
+            env->msr_hv_tsc_emulation_control = msrs[i].data;
+            break;
+        case HV_X64_MSR_TSC_EMULATION_STATUS:
+            env->msr_hv_tsc_emulation_status = msrs[i].data;
+            break;
         case MSR_MTRRdefType:
             env->mtrr_deftype = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index bd2d82e..fd99c0b 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -713,6 +713,29 @@ static const VMStateDescription vmstate_msr_hyperv_stimer = {
     }
 };
 
+static bool hyperv_reenlightenment_enable_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->msr_hv_reenlightenment_control != 0 ||
+        env->msr_hv_tsc_emulation_control != 0 ||
+        env->msr_hv_tsc_emulation_status != 0;
+}
+
+static const VMStateDescription vmstate_msr_hyperv_reenlightenment = {
+    .name = "cpu/msr_hyperv_reenlightenment",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hyperv_reenlightenment_enable_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.msr_hv_reenlightenment_control, X86CPU),
+        VMSTATE_UINT64(env.msr_hv_tsc_emulation_control, X86CPU),
+        VMSTATE_UINT64(env.msr_hv_tsc_emulation_status, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool avx512_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1005,6 +1028,7 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_hyperv_runtime,
         &vmstate_msr_hyperv_synic,
         &vmstate_msr_hyperv_stimer,
+        &vmstate_msr_hyperv_reenlightenment,
         &vmstate_avx512,
         &vmstate_xss,
         &vmstate_tsc_khz,
-- 
1.8.3.1
