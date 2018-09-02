Received: from eggs.gnu.org ([2001:4830:134:3::10]:54047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fwRuz-0001DV-Dh
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fwRsP-0007m0-CH
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:53:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:48449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fwRsG-0007UU-3S
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:53:13 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Sun,  2 Sep 2018 19:46:07 +0800
Message-Id: <1535888767-154680-4-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1535888767-154680-1-git-send-email-robert.hu@linux.intel.com>
References: <1535888767-154680-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v4 3/3] x86: define a new MSR based feature
 word -- FEATURE_WORDS_ARCH_CAPABILITIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com
Cc: qemu-devel@nongnu.org, robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

Note RSBA is specially treated -- no matter host support it or not, qemu
pretends it is supported.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 27 ++++++++++++++++++++++++++-
 target/i386/cpu.h | 12 ++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0160e97..8ec9613 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1129,6 +1129,24 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .reg = R_EDX, },
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
@@ -3680,7 +3698,14 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                 wi->cpuid.reg);
             break;
         case MSR_FEATURE_WORD:
-            r = kvm_arch_get_supported_msr_feature(kvm_state,
+            /* Special case:
+             * No matter host status, IA32_ARCH_CAPABILITIES.RSBA [bit 2]
+             * is always supported in guest.
+             */
+            if (wi->msr.index == MSR_IA32_ARCH_CAPABILITIES) {
+                r = MSR_ARCH_CAP_RSBA;
+            }
+            r |= kvm_arch_get_supported_msr_feature(kvm_state,
                         wi->msr.index);
             break;
         }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b572a8e..9662730 100644
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
@@ -730,6 +735,13 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_TOPOLOGY_LEVEL_SMT      (1U << 8)
 #define CPUID_TOPOLOGY_LEVEL_CORE     (2U << 8)
 
+/* MSR Feature Bits */
+#define MSR_ARCH_CAP_RDCL_NO    (1U << 0)
+#define MSR_ARCH_CAP_IBRS_ALL   (1U << 1)
+#define MSR_ARCH_CAP_RSBA       (1U << 2)
+#define MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY (1U << 3)
+#define MSR_ARCH_CAP_SSB_NO     (1U << 4)
+
 #ifndef HYPERV_SPINLOCK_NEVER_RETRY
 #define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
 #endif
-- 
1.8.3.1
