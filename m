Received: from eggs.gnu.org ([2001:4830:134:3::10]:58024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fnjVZ-0001bY-UT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fnjVY-0001yq-7H
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:53:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:34246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fnjVX-0001xT-Om
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:53:36 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu,  9 Aug 2018 19:53:27 +0800
Message-Id: <1533815609-37245-2-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1533815609-37245-1-git-send-email-robert.hu@linux.intel.com>
References: <1533815609-37245-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 1/3] x86: Data structure changes to support
 MSR based features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com
Cc: robert.hu@intel.com, jingqi.liu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

Define FeatureWordType.
Expand FeatureWordInfo to support both CPUID type feature word as well as
MSR type's.
Change feature_word_info[] accordingly.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 133 ++++++++++++++++++++++++++++++++++++++----------------
 target/i386/cpu.h |   5 ++
 2 files changed, 99 insertions(+), 39 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ba7abe5..77e1859 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -770,17 +770,36 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           /* missing:
           CPUID_XSAVE_XSAVEC, CPUID_XSAVE_XSAVES */
 
+typedef enum FeatureWordType {
+   CPUID_FEATURE_WORD,
+   MSR_FEATURE_WORD,
+} FeatureWordType;
+
 typedef struct FeatureWordInfo {
-    /* feature flags names are taken from "Intel Processor Identification and
+    FeatureWordType type;
+   /* feature flags names are taken from "Intel Processor Identification and
      * the CPUID Instruction" and AMD's "CPUID Specification".
      * In cases of disagreement between feature naming conventions,
      * aliases may be added.
      */
     const char *feat_names[32];
-    uint32_t cpuid_eax;   /* Input EAX for CPUID */
-    bool cpuid_needs_ecx; /* CPUID instruction uses ECX as input */
-    uint32_t cpuid_ecx;   /* Input ECX value for CPUID */
-    int cpuid_reg;        /* output register (R_* constant) */
+    union {
+        /* If type==CPUID_FEATURE_WORD */
+        struct {
+            uint32_t eax;   /* Input EAX for CPUID */
+            bool needs_ecx; /* CPUID instruction uses ECX as input */
+            uint32_t ecx;   /* Input ECX value for CPUID */
+            int reg;        /* output register (R_* constant) */
+        } cpuid;
+        /* If type==MSR_FEATURE_WORD */
+        struct {
+            uint32_t index;
+            struct {   /*CPUID that enumerate this MSR*/
+                FeatureWord cpuid_class;
+                uint32_t    cpuid_flag;
+            } cpuid_dep;
+        } msr;
+    };
     uint32_t tcg_features; /* Feature flags supported by TCG */
     uint32_t unmigratable_flags; /* Feature flags known to be unmigratable */
     uint32_t migratable_flags; /* Feature flags known to be migratable */
@@ -790,6 +809,7 @@ typedef struct FeatureWordInfo {
 
 static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_EDX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "fpu", "vme", "de", "pse",
             "tsc", "msr", "pae", "mce",
@@ -800,10 +820,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fxsr", "sse", "sse2", "ss",
             "ht" /* Intel htt */, "tm", "ia64", "pbe",
         },
-        .cpuid_eax = 1, .cpuid_reg = R_EDX,
+        .cpuid = {.eax = 1, .reg = R_EDX, },
         .tcg_features = TCG_FEATURES,
     },
     [FEAT_1_ECX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "pni" /* Intel,AMD sse3 */, "pclmulqdq", "dtes64", "monitor",
             "ds-cpl", "vmx", "smx", "est",
@@ -814,7 +835,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "tsc-deadline", "aes", "xsave", NULL /* osxsave */,
             "avx", "f16c", "rdrand", "hypervisor",
         },
-        .cpuid_eax = 1, .cpuid_reg = R_ECX,
+        .cpuid = { .eax = 1, .reg = R_ECX, },
         .tcg_features = TCG_EXT_FEATURES,
     },
     /* Feature names that are already defined on feature_name[] but
@@ -823,6 +844,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
      * to features[FEAT_8000_0001_EDX] if and only if CPU vendor is AMD.
      */
     [FEAT_8000_0001_EDX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL /* fpu */, NULL /* vme */, NULL /* de */, NULL /* pse */,
             NULL /* tsc */, NULL /* msr */, NULL /* pae */, NULL /* mce */,
@@ -833,10 +855,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL /* fxsr */, "fxsr-opt", "pdpe1gb", "rdtscp",
             NULL, "lm", "3dnowext", "3dnow",
         },
-        .cpuid_eax = 0x80000001, .cpuid_reg = R_EDX,
+        .cpuid = { .eax = 0x80000001, .reg = R_EDX, },
         .tcg_features = TCG_EXT2_FEATURES,
     },
     [FEAT_8000_0001_ECX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "lahf-lm", "cmp-legacy", "svm", "extapic",
             "cr8legacy", "abm", "sse4a", "misalignsse",
@@ -847,10 +870,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "perfctr-nb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 0x80000001, .cpuid_reg = R_ECX,
+        .cpuid = { .eax = 0x80000001, .reg = R_ECX, },
         .tcg_features = TCG_EXT3_FEATURES,
     },
     [FEAT_C000_0001_EDX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, "xstore", "xstore-en",
             NULL, NULL, "xcrypt", "xcrypt-en",
@@ -861,10 +885,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 0xC0000001, .cpuid_reg = R_EDX,
+        .cpuid = { .eax = 0xC0000001, .reg = R_EDX, },
         .tcg_features = TCG_EXT4_FEATURES,
     },
     [FEAT_KVM] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
@@ -875,10 +900,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "kvmclock-stable-bit", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EAX,
+        .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EAX, },
         .tcg_features = TCG_KVM_FEATURES,
     },
     [FEAT_KVM_HINTS] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "kvm-hint-dedicated", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -889,7 +915,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EDX,
+        .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EDX, },
         .tcg_features = TCG_KVM_FEATURES,
         /*
          * KVM hints aren't auto-enabled by -cpu host, they need to be
@@ -898,6 +924,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .no_autoenable_flags = ~0U,
     },
     [FEAT_HYPERV_EAX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL /* hv_msr_vp_runtime_access */, NULL /* hv_msr_time_refcount_access */,
             NULL /* hv_msr_synic_access */, NULL /* hv_msr_stimer_access */,
@@ -912,9 +939,10 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 0x40000003, .cpuid_reg = R_EAX,
+        .cpuid = { .eax = 0x40000003, .reg = R_EAX, },
     },
     [FEAT_HYPERV_EBX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL /* hv_create_partitions */, NULL /* hv_access_partition_id */,
             NULL /* hv_access_memory_pool */, NULL /* hv_adjust_message_buffers */,
@@ -928,9 +956,10 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 0x40000003, .cpuid_reg = R_EBX,
+        .cpuid = { .eax = 0x40000003, .reg = R_EBX, },
     },
     [FEAT_HYPERV_EDX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL /* hv_mwait */, NULL /* hv_guest_debugging */,
             NULL /* hv_perf_monitor */, NULL /* hv_cpu_dynamic_part */,
@@ -943,9 +972,10 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 0x40000003, .cpuid_reg = R_EDX,
+        .cpuid = { .eax = 0x40000003, .reg = R_EDX, },
     },
     [FEAT_SVM] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "npt", "lbrv", "svm-lock", "nrip-save",
             "tsc-scale", "vmcb-clean",  "flushbyasid", "decodeassists",
@@ -956,10 +986,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 0x8000000A, .cpuid_reg = R_EDX,
+        .cpuid = { .eax = 0x8000000A, .reg = R_EDX, },
         .tcg_features = TCG_SVM_FEATURES,
     },
     [FEAT_7_0_EBX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "fsgsbase", "tsc-adjust", NULL, "bmi1",
             "hle", "avx2", NULL, "smep",
@@ -970,12 +1001,13 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "clwb", "intel-pt", "avx512pf", "avx512er",
             "avx512cd", "sha-ni", "avx512bw", "avx512vl",
         },
-        .cpuid_eax = 7,
-        .cpuid_needs_ecx = true, .cpuid_ecx = 0,
-        .cpuid_reg = R_EBX,
+        .cpuid = { .eax = 7,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EBX, },
         .tcg_features = TCG_7_0_EBX_FEATURES,
     },
     [FEAT_7_0_ECX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
             NULL /* ospke */, NULL, "avx512vbmi2", NULL,
@@ -986,12 +1018,13 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "cldemote", NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 7,
-        .cpuid_needs_ecx = true, .cpuid_ecx = 0,
-        .cpuid_reg = R_ECX,
+        .cpuid = { .eax = 7,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_ECX, },
         .tcg_features = TCG_7_0_ECX_FEATURES,
     },
     [FEAT_7_0_EDX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, "avx512-4vnniw", "avx512-4fmaps",
             NULL, NULL, NULL, NULL,
@@ -1002,13 +1035,14 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, "spec-ctrl", NULL,
             NULL, "arch-capabilities", NULL, "ssbd",
         },
-        .cpuid_eax = 7,
-        .cpuid_needs_ecx = true, .cpuid_ecx = 0,
-        .cpuid_reg = R_EDX,
+        .cpuid = { .eax = 7,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EDX, },
         .tcg_features = TCG_7_0_EDX_FEATURES,
         .unmigratable_flags = CPUID_7_0_EDX_ARCH_CAPABILITIES,
     },
     [FEAT_8000_0007_EDX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -1019,12 +1053,12 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 0x80000007,
-        .cpuid_reg = R_EDX,
+        .cpuid = { .eax = 0x80000007, .reg = R_EDX, },
         .tcg_features = TCG_APM_FEATURES,
         .unmigratable_flags = CPUID_APM_INVTSC,
     },
     [FEAT_8000_0008_EBX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -1035,12 +1069,12 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "amd-ssbd", "virt-ssbd", "amd-no-ssb", NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 0x80000008,
-        .cpuid_reg = R_EBX,
+        .cpuid = { .eax = 0x80000008, .reg = R_EBX, },
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
     [FEAT_XSAVE] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "xsaveopt", "xsavec", "xgetbv1", "xsaves",
             NULL, NULL, NULL, NULL,
@@ -1051,12 +1085,13 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 0xd,
-        .cpuid_needs_ecx = true, .cpuid_ecx = 1,
-        .cpuid_reg = R_EAX,
+        .cpuid = { .eax = 0xd,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_EAX, },
         .tcg_features = TCG_XSAVE_FEATURES,
     },
     [FEAT_6_EAX] = {
+        .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, "arat", NULL,
             NULL, NULL, NULL, NULL,
@@ -1067,13 +1102,14 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid_eax = 6, .cpuid_reg = R_EAX,
+        .cpuid = { .eax = 6, .reg = R_EAX, },
         .tcg_features = TCG_6_EAX_FEATURES,
     },
     [FEAT_XSAVE_COMP_LO] = {
-        .cpuid_eax = 0xD,
-        .cpuid_needs_ecx = true, .cpuid_ecx = 0,
-        .cpuid_reg = R_EAX,
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = { .eax = 0xD,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EAX, },
         .tcg_features = ~0U,
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
@@ -1081,11 +1117,30 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             XSTATE_PKRU_MASK,
     },
     [FEAT_XSAVE_COMP_HI] = {
-        .cpuid_eax = 0xD,
-        .cpuid_needs_ecx = true, .cpuid_ecx = 0,
-        .cpuid_reg = R_EDX,
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = { .eax = 0xD,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EDX, },
         .tcg_features = ~0U,
     },
+    /*Below are MSR exposed features*/
+    [FEATURE_WORDS_ARCH_CAPABILITIES] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            "rdctl-no", "ibrs-all", "rsba", NULL,
+            "ssb-no", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = { .index = MSR_IA32_ARCH_CAPABILITIES,
+                .cpuid_dep = { FEAT_7_0_EDX,
+                    CPUID_7_0_EDX_ARCH_CAPABILITIES }
+                },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cddf9d9..9e8879e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -502,9 +502,14 @@ typedef enum FeatureWord {
     FEAT_6_EAX,         /* CPUID[6].EAX */
     FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
+    FEATURE_WORDS_NUM_CPUID,
+    FEATURE_WORDS_FIRST_MSR = FEATURE_WORDS_NUM_CPUID,
+    FEATURE_WORDS_ARCH_CAPABILITIES = FEATURE_WORDS_FIRST_MSR,
     FEATURE_WORDS,
 } FeatureWord;
 
+#define FEATURE_WORDS_NUM_MSRS (FEATURE_WORDS - FEATURE_WORDS_FIRST_MSR)
+
 typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 /* cpuid_features bits */
-- 
1.8.3.1
