Received: from eggs.gnu.org ([2001:4830:134:3::10]:50846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1eyLAG-0007El-5r
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1eyLAE-0007zs-9q
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1eyLAE-0007t1-5R
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:10 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Tue, 20 Mar 2018 18:34:59 +0100
Message-Id: <20180320173500.32065-2-vkuznets@redhat.com>
In-Reply-To: <20180320173500.32065-1-vkuznets@redhat.com>
References: <20180320173500.32065-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>

KVM recently gained support for Hyper-V Reenlightenment MSRs which are
required to make KVM-on-Hyper-V enable TSC page clocksource to its guests
when INVTSC is not passed to it (and it is not passed by default in Qemu
as it effectively blocks migration).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v2:
- add hv-reenlightenment CPU property [Roman Kagan, Paolo Bonzini]
- add a comment to feature_word_info [Roman Kagan]
---
 target/i386/cpu.c          |  4 +++-
 target/i386/cpu.h          |  4 ++++
 target/i386/hyperv-proto.h |  9 ++++++++-
 target/i386/kvm.c          | 39 ++++++++++++++++++++++++++++++++++++++-
 target/i386/machine.c      | 24 ++++++++++++++++++++++++
 5 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6bb4ce8719..02579f8234 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -407,7 +407,8 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL /* hv_vpindex_access */, NULL /* hv_msr_reset_access */,
             NULL /* hv_msr_stats_access */, NULL /* hv_reftsc_access */,
             NULL /* hv_msr_idle_access */, NULL /* hv_msr_frequency_access */,
-            NULL, NULL, NULL, NULL,
+            NULL /* hv_msr_debug_access */, NULL /* hv_msr_reenlightenment_access */,
+            NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -4764,6 +4765,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("hv-runtime", X86CPU, hyperv_runtime, false),
     DEFINE_PROP_BOOL("hv-synic", X86CPU, hyperv_synic, false),
     DEFINE_PROP_BOOL("hv-stimer", X86CPU, hyperv_stimer, false),
+    DEFINE_PROP_BOOL("hv-reenlightenment", X86CPU, hyperv_reenlightenment, false),
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2e2bab5ff3..98eed72937 100644
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
@@ -1296,6 +1299,7 @@ struct X86CPU {
     bool hyperv_runtime;
     bool hyperv_synic;
     bool hyperv_stimer;
+    bool hyperv_reenlightenment;
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index cb4d7f2b7a..93352ebd2a 100644
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
@@ -129,6 +129,13 @@
 #define HV_X64_MSR_CRASH_CTL                    0x40000105
 #define HV_CRASH_CTL_NOTIFY                     (1ull << 63)
 
+/*
+ * Reenlightenment notification MSRs
+ */
+#define HV_X64_MSR_REENLIGHTENMENT_CONTROL      0x40000106
+#define HV_X64_MSR_TSC_EMULATION_CONTROL        0x40000107
+#define HV_X64_MSR_TSC_EMULATION_STATUS         0x40000108
+
 /*
  * Hypercall status code
  */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d23fff12f5..7d9f9ca0b1 100644
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
@@ -654,6 +656,14 @@ static int hyperv_handle_properties(CPUState *cs)
             env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
         }
     }
+    if (cpu->hyperv_reenlightenment) {
+        if (!has_msr_hv_reenlightenment) {
+            fprintf(stderr,
+                    "Hyper-V Reenlightenment is not supported by kernel\n");
+            return -ENOSYS;
+        }
+        env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_REENLIGHTENMENTS_CONTROL;
+    }
     if (cpu->hyperv_crash && has_msr_hv_crash) {
         env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
     }
@@ -1185,6 +1195,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case HV_X64_MSR_TSC_FREQUENCY:
                     has_msr_hv_frequencies = true;
                     break;
+                case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+                    has_msr_hv_reenlightenment = true;
+                    break;
                 case MSR_IA32_SPEC_CTRL:
                     has_msr_spec_ctrl = true;
                     break;
@@ -1747,6 +1760,15 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
             if (cpu->hyperv_time) {
                 kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC,
                                   env->msr_hv_tsc);
+
+                if (has_msr_hv_reenlightenment) {
+                    kvm_msr_entry_add(cpu, HV_X64_MSR_REENLIGHTENMENT_CONTROL,
+                                      env->msr_hv_reenlightenment_control);
+                    kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_CONTROL,
+                                      env->msr_hv_tsc_emulation_control);
+                    kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS,
+                                      env->msr_hv_tsc_emulation_status);
+                }
             }
         }
         if (cpu->hyperv_vapic) {
@@ -2109,6 +2131,12 @@ static int kvm_get_msrs(X86CPU *cpu)
     }
     if (cpu->hyperv_time) {
         kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC, 0);
+
+        if (has_msr_hv_reenlightenment) {
+            kvm_msr_entry_add(cpu, HV_X64_MSR_REENLIGHTENMENT_CONTROL, 0);
+            kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_CONTROL, 0);
+            kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS, 0);
+        }
     }
     if (has_msr_hv_crash) {
         int j;
@@ -2367,6 +2395,15 @@ static int kvm_get_msrs(X86CPU *cpu)
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
index bd2d82e91b..fd99c0bbb4 100644
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
2.14.3
