Received: from eggs.gnu.org ([2001:4830:134:3::10]:52018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gBun5-0008Ur-SB
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 00:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gBun1-00018k-Sx
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 00:47:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:20045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1gBun0-00015F-Rt
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 00:47:35 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Mon, 15 Oct 2018 12:47:25 +0800
Message-Id: <1539578845-37944-4-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1539578845-37944-1-git-send-email-robert.hu@linux.intel.com>
References: <1539578845-37944-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v5 3/3] x86: define a new MSR based feature
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
 target/i386/cpu.c | 31 ++++++++++++++++++++++++++++++-
 target/i386/cpu.h |  8 ++++++++
 target/i386/kvm.c | 11 +++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d191b9c..51c8fd8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1141,6 +1141,27 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = ~0U,
     },
+    /*Below are MSR exposed features*/
+    [FEAT_ARCH_CAPABILITIES] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
+            "ssb-no", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_ARCH_CAPABILITIES,
+            .cpuid_dep = {
+                FEAT_7_0_EDX,
+                CPUID_7_0_EDX_ARCH_CAPABILITIES
+            }
+        },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -3696,7 +3717,15 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                         wi->cpuid.reg);
             break;
         case MSR_FEATURE_WORD:
-            r = kvm_arch_get_supported_msr_feature(kvm_state, wi->msr.index);
+            /* Special case:
+             * No matter host status, IA32_ARCH_CAPABILITIES.RSBA [bit 2]
+             * is always supported in guest.
+             */
+            if (wi->msr.index == MSR_IA32_ARCH_CAPABILITIES) {
+                r = MSR_ARCH_CAP_RSBA;
+            }
+            r |= kvm_arch_get_supported_msr_feature(kvm_state,
+                        wi->msr.index);
             break;
         }
     } else if (hvf_enabled()) {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 730c06f..52a52ec 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -502,6 +502,7 @@ typedef enum FeatureWord {
     FEAT_6_EAX,         /* CPUID[6].EAX */
     FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
+    FEAT_ARCH_CAPABILITIES,
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -730,6 +731,13 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
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
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index db79dad..2f7b40d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1928,6 +1928,17 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     }
 #endif
 
+    /* If host supports feature MSR, write down. */
+    if (kvm_feature_msrs) {
+        int i;
+        for (i = 0; i < kvm_feature_msrs->nmsrs; i++)
+            if (kvm_feature_msrs->indices[i] == MSR_IA32_ARCH_CAPABILITIES) {
+                kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
+                              env->features[FEAT_ARCH_CAPABILITIES]);
+                break;
+            }
+    }
+
     /*
      * The following MSRs have side effects on the guest or are too heavy
      * for normal writeback. Limit them to reset or full state updates.
-- 
1.8.3.1
