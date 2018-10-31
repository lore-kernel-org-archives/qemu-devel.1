Received: from eggs.gnu.org ([2001:4830:134:3::10]:47319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeeo-0000mQ-Bn
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeek-0006rh-81
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHeej-0006pV-SM
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:45:48 -0300
Message-Id: <20181031004550.15410-6-ehabkost@redhat.com>
In-Reply-To: <20181031004550.15410-1-ehabkost@redhat.com>
References: <20181031004550.15410-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] x86: define a new MSR based feature word --
 FEATURE_WORDS_ARCH_CAPABILITIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>

From: Robert Hoo <robert.hu@linux.intel.com>

Note RSBA is specially treated -- no matter host support it or not, qemu
pretends it is supported.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Message-Id: <1539578845-37944-4-git-send-email-robert.hu@linux.intel.com>
[ehabkost: removed automatic enabling of RSBA]
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h |  8 ++++++++
 target/i386/cpu.c | 24 +++++++++++++++++++++++-
 target/i386/kvm.c | 11 +++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 663f3a5e67..ad0e0b4534 100644
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
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 989a71ac9a..e92117a476 100644
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
@@ -3696,7 +3717,8 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                         wi->cpuid.reg);
             break;
         case MSR_FEATURE_WORD:
-            r = kvm_arch_get_supported_msr_feature(kvm_state, wi->msr.index);
+            r = kvm_arch_get_supported_msr_feature(kvm_state,
+                        wi->msr.index);
             break;
         }
     } else if (hvf_enabled()) {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 161fc38397..796a049a0d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1975,6 +1975,17 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
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
2.18.0.rc1.1.g3f1ff2140
