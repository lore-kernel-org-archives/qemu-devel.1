Received: from eggs.gnu.org ([209.51.188.92]:56421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiaoyao.li@linux.intel.com>) id 1h0d5A-0004ru-V9
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 21:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiaoyao.li@linux.intel.com>) id 1h0d59-0001hf-TF
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 21:11:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:8723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiaoyao.li@linux.intel.com>)
	id 1h0d59-0001hK-JU
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 21:11:55 -0500
From: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Date: Mon,  4 Mar 2019 10:00:42 +0800
Message-Id: <20190304020042.211830-1-xiaoyao.li@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] x86: define a new MSR based feature word --
 FEAT_CORE_CAPABILITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Xiaoyao Li <xiaoyao.li@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

MSR IA32_CORE_CAPABILITY is a feature-enumerating MSR, which
enumerates the capabilitiy of enabling detection of split locks (bit 5
of MSR_TEST_CTL).

MSR IA32_CORE_CAPABILITY can be enumerated by CPUID.0X7.0:EDX[30].

Related kernel patches can be found here:
https://lkml.org/lkml/2019/3/1/749
Patches 15-17 of kvm are exposing this feature to guest.

If host has split lock detection feature, we can expose it to guest by
using '-cpu host' with this patch and kernel's patches.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
---
 target/i386/cpu.c | 22 +++++++++++++++++++++-
 target/i386/cpu.h |  3 +++
 target/i386/kvm.c |  9 +++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d3aa6a815b..32df1d358a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1081,7 +1081,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", "stibp",
-            NULL, "arch-capabilities", NULL, "ssbd",
+            NULL, "arch-capabilities", "core-capability", "ssbd",
         },
         .cpuid = {
             .eax = 7,
@@ -1200,6 +1200,26 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             }
         },
     },
+    [FEAT_CORE_CAPABILITY] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, "split-lock-detect", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+    },
+        .msr = {
+            .index = MSR_IA32_CORE_CAPABILITY,
+            .cpuid_dep = {
+                FEAT_7_0_EDX,
+                CPUID_7_0_EDX_CORE_CAPABILITY
+            },
+        },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 95112b9118..6eb89ac735 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -355,6 +355,7 @@ typedef enum X86Seg {
 #define MSR_IA32_SPEC_CTRL              0x48
 #define MSR_VIRT_SSBD                   0xc001011f
 #define MSR_IA32_PRED_CMD               0x49
+#define MSR_IA32_CORE_CAPABILITY        0xcf
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
@@ -505,6 +506,7 @@ typedef enum FeatureWord {
     FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
+    FEAT_CORE_CAPABILITY,
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -696,6 +698,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
+#define CPUID_7_0_EDX_CORE_CAPABILITY (1U << 30)  /*Core Capabilities*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
 #define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index beae1b99da..8aafd1db77 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -96,6 +96,7 @@ static bool has_msr_spec_ctrl;
 static bool has_msr_virt_ssbd;
 static bool has_msr_smi_count;
 static bool has_msr_arch_capabs;
+static bool has_msr_core_capabs;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -1507,6 +1508,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case MSR_IA32_ARCH_CAPABILITIES:
                     has_msr_arch_capabs = true;
                     break;
+                case MSR_IA32_CORE_CAPABILITY:
+                    has_msr_core_capabs = true;
+                    break;
                 }
             }
         }
@@ -2033,6 +2037,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                           env->features[FEAT_ARCH_CAPABILITIES]);
     }
 
+    if (has_msr_core_capabs) {
+        kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
+                          env->features[FEAT_CORE_CAPABILITY]);
+    }
+
     /*
      * The following MSRs have side effects on the guest or are too heavy
      * for normal writeback. Limit them to reset or full state updates.
-- 
2.19.1
