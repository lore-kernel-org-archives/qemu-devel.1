Received: from eggs.gnu.org ([2001:4830:134:3::10]:37148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evTcV-0008Ge-6M
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evTcU-00010H-1B
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:00:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evTcT-0000zu-Os
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:00:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 17:00:21 -0300
Message-Id: <20180312200022.9760-3-ehabkost@redhat.com>
In-Reply-To: <20180312200022.9760-1-ehabkost@redhat.com>
References: <20180312200022.9760-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] i386: Add Intel Processor Trace feature
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>

From: Chao Peng <chao.p.peng@linux.intel.com>

Expose Intel Processor Trace feature to guest.

To make Intel PT live migration safe and get same CPUID information
with same CPU model on diffrent host. CPUID[14] is constant in this
patch. Intel PT use EPT is first supported in IceLake, the CPUID[14]
get on this machine as default value. Intel PT would be disabled
if any machine don't support this minial feature list.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Message-Id: <1520182116-16485-1-git-send-email-luwei.kang@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h |  1 +
 target/i386/cpu.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 target/i386/kvm.c | 23 ++++++++++++++++
 3 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8d977ec567..ec2a771299 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -641,6 +641,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EBX_PCOMMIT  (1U << 22) /* Persistent Commit */
 #define CPUID_7_0_EBX_CLFLUSHOPT (1U << 23) /* Flush a Cache Line Optimized */
 #define CPUID_7_0_EBX_CLWB     (1U << 24) /* Cache Line Write Back */
+#define CPUID_7_0_EBX_INTEL_PT (1U << 25) /* Intel Processor Trace */
 #define CPUID_7_0_EBX_AVX512PF (1U << 26) /* AVX-512 Prefetch */
 #define CPUID_7_0_EBX_AVX512ER (1U << 27) /* AVX-512 Exponential and Reciprocal */
 #define CPUID_7_0_EBX_AVX512CD (1U << 28) /* AVX-512 Conflict Detection */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5ea1931b7e..ec1efd3a3c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -173,7 +173,32 @@
 #define L2_ITLB_4K_ASSOC       4
 #define L2_ITLB_4K_ENTRIES   512
 
-
+/* CPUID Leaf 0x14 constants: */
+#define INTEL_PT_MAX_SUBLEAF     0x1
+/*
+ * bit[00]: IA32_RTIT_CTL.CR3 filter can be set to 1 and IA32_RTIT_CR3_MATCH
+ *          MSR can be accessed;
+ * bit[01]: Support Configurable PSB and Cycle-Accurate Mode;
+ * bit[02]: Support IP Filtering, TraceStop filtering, and preservation
+ *          of Intel PT MSRs across warm reset;
+ * bit[03]: Support MTC timing packet and suppression of COFI-based packets;
+ */
+#define INTEL_PT_MINIMAL_EBX     0xf
+/*
+ * bit[00]: Tracing can be enabled with IA32_RTIT_CTL.ToPA = 1 and
+ *          IA32_RTIT_OUTPUT_BASE and IA32_RTIT_OUTPUT_MASK_PTRS MSRs can be
+ *          accessed;
+ * bit[01]: ToPA tables can hold any number of output entries, up to the
+ *          maximum allowed by the MaskOrTableOffset field of
+ *          IA32_RTIT_OUTPUT_MASK_PTRS;
+ * bit[02]: Support Single-Range Output scheme;
+ */
+#define INTEL_PT_MINIMAL_ECX     0x7
+#define INTEL_PT_ADDR_RANGES_NUM 0x2 /* Number of configurable address ranges */
+#define INTEL_PT_ADDR_RANGES_NUM_MASK 0x3
+#define INTEL_PT_MTC_BITMAP      (0x0249 << 16) /* Support ART(0,3,6,9) */
+#define INTEL_PT_CYCLE_BITMAP    0x1fff         /* Support 0,2^(0~11) */
+#define INTEL_PT_PSB_BITMAP      (0x003f << 16) /* Support 2K,4K,8K,16K,32K,64K */
 
 static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
                                      uint32_t vendor2, uint32_t vendor3)
@@ -442,7 +467,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, "mpx", NULL,
             "avx512f", "avx512dq", "rdseed", "adx",
             "smap", "avx512ifma", "pcommit", "clflushopt",
-            "clwb", NULL, "avx512pf", "avx512er",
+            "clwb", "intel-pt", "avx512pf", "avx512er",
             "avx512cd", "sha-ni", "avx512bw", "avx512vl",
         },
         .cpuid_eax = 7,
@@ -3467,6 +3492,27 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x14: {
+        /* Intel Processor Trace Enumeration */
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
+            !kvm_enabled()) {
+            break;
+        }
+
+        if (count == 0) {
+            *eax = INTEL_PT_MAX_SUBLEAF;
+            *ebx = INTEL_PT_MINIMAL_EBX;
+            *ecx = INTEL_PT_MINIMAL_ECX;
+        } else if (count == 1) {
+            *eax = INTEL_PT_MTC_BITMAP | INTEL_PT_ADDR_RANGES_NUM;
+            *ebx = INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP;
+        }
+        break;
+    }
     case 0x40000000:
         /*
          * CPUID code in kvm_arch_init_vcpu() ignores stuff
@@ -4097,6 +4143,34 @@ static int x86_cpu_filter_features(X86CPU *cpu)
         }
     }
 
+    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
+        kvm_enabled()) {
+        KVMState *s = CPU(cpu)->kvm_state;
+        uint32_t eax_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EAX);
+        uint32_t ebx_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EBX);
+        uint32_t ecx_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_ECX);
+        uint32_t eax_1 = kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EAX);
+        uint32_t ebx_1 = kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EBX);
+
+        if (!eax_0 ||
+           ((ebx_0 & INTEL_PT_MINIMAL_EBX) != INTEL_PT_MINIMAL_EBX) ||
+           ((ecx_0 & INTEL_PT_MINIMAL_ECX) != INTEL_PT_MINIMAL_ECX) ||
+           ((eax_1 & INTEL_PT_MTC_BITMAP) != INTEL_PT_MTC_BITMAP) ||
+           ((eax_1 & INTEL_PT_ADDR_RANGES_NUM_MASK) <
+                                           INTEL_PT_ADDR_RANGES_NUM) ||
+           ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) !=
+                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP))) {
+            /*
+             * Processor Trace capabilities aren't configurable, so if the
+             * host can't emulate the capabilities we report on
+             * cpu_x86_cpuid(), intel-pt can't be enabled on the current host.
+             */
+            env->features[FEAT_7_0_EBX] &= ~CPUID_7_0_EBX_INTEL_PT;
+            cpu->filtered_features[FEAT_7_0_EBX] |= CPUID_7_0_EBX_INTEL_PT;
+            rv = 1;
+        }
+    }
+
     return rv;
 }
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 44ee524188..f5d3d73ed6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -869,6 +869,29 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
+        case 0x14: {
+            uint32_t times;
+
+            c->function = i;
+            c->index = 0;
+            c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            times = c->eax;
+
+            for (j = 1; j <= times; ++j) {
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    fprintf(stderr, "cpuid_data is full, no space for "
+                                "cpuid(eax:0x14,ecx:0x%x)\n", j);
+                    abort();
+                }
+                c = &cpuid_data.entries[cpuid_i++];
+                c->function = i;
+                c->index = j;
+                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            }
+            break;
+        }
         default:
             c->function = i;
             c->flags = 0;
-- 
2.14.3
