Received: from eggs.gnu.org ([2001:4830:134:3::10]:41954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1eYr1x-0004hi-Ut
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1eYr1u-0004jn-Pf
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:21:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:39308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luwei.kang@intel.com>)
	id 1eYr1u-0004ht-GE
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:21:14 -0500
From: Luwei Kang <luwei.kang@intel.com>
Date: Tue,  9 Jan 2018 04:36:36 +0800
Message-Id: <1515443797-10837-1-git-send-email-luwei.kang@intel.com>
Subject: [Qemu-devel] [PATCH RESEND v1 1/2] i386: Add Intel Processor Trace
 feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, Chao Peng <chao.p.peng@linux.intel.com>, Luwei Kang <luwei.kang@intel.com>

From: Chao Peng <chao.p.peng@linux.intel.com>

Expose Intel Processor Trace feature to guest.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 target/i386/cpu.c | 19 ++++++++++++++++++-
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 23 +++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3818d72..57f8370 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -427,7 +427,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, "mpx", NULL,
             "avx512f", "avx512dq", "rdseed", "adx",
             "smap", "avx512ifma", "pcommit", "clflushopt",
-            "clwb", NULL, "avx512pf", "avx512er",
+            "clwb", "intel-pt", "avx512pf", "avx512er",
             "avx512cd", "sha-ni", "avx512bw", "avx512vl",
         },
         .cpuid_eax = 7,
@@ -3006,6 +3006,23 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x14: {
+        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
+             kvm_enabled()) {
+            KVMState *s = cs->kvm_state;
+
+            *eax = kvm_arch_get_supported_cpuid(s, 0x14, count, R_EAX);
+            *ebx = kvm_arch_get_supported_cpuid(s, 0x14, count, R_EBX);
+            *ecx = kvm_arch_get_supported_cpuid(s, 0x14, count, R_ECX);
+            *edx = kvm_arch_get_supported_cpuid(s, 0x14, count, R_EDX);
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
+        break;
+    }
     case 0x40000000:
         /*
          * CPUID code in kvm_arch_init_vcpu() ignores stuff
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 62c4742..58a4b6c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -642,6 +642,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EBX_PCOMMIT  (1U << 22) /* Persistent Commit */
 #define CPUID_7_0_EBX_CLFLUSHOPT (1U << 23) /* Flush a Cache Line Optimized */
 #define CPUID_7_0_EBX_CLWB     (1U << 24) /* Cache Line Write Back */
+#define CPUID_7_0_EBX_INTEL_PT (1U << 25) /* Intel Processor Trace */
 #define CPUID_7_0_EBX_AVX512PF (1U << 26) /* AVX-512 Prefetch */
 #define CPUID_7_0_EBX_AVX512ER (1U << 27) /* AVX-512 Exponential and Reciprocal */
 #define CPUID_7_0_EBX_AVX512CD (1U << 28) /* AVX-512 Conflict Detection */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6f69e2f..e13ab58 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -863,6 +863,29 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
1.8.3.1
