Received: from eggs.gnu.org ([2001:4830:134:3::10]:55653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBM-0003Fw-7B
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBJ-0003pd-1y
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:16 -0500
Received: from mail-by2nam01on0066.outbound.protection.outlook.com
	([104.47.34.66]:37502
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1elGBI-0003m5-QB
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:12 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 12 Feb 2018 09:36:52 -0600
Message-Id: <20180212153715.87555-6-brijesh.singh@amd.com>
In-Reply-To: <20180212153715.87555-1-brijesh.singh@amd.com>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 05/28] target/i386: add memory encryption
 feature cpuid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>

AMD EPYC processors support memory encryption feature. The feature
is reported through CPUID 8000_001F[EAX].

Fn8000_001F [EAX]:
 Bit 0   Secure Memory Encryption (SME) supported
 Bit 1   Secure Encrypted Virtualization (SEV) supported
 Bit 2   Page flush MSR supported
 Bit 3   Ecrypted State (SEV-ES) support

when memory encryption feature is reported, CPUID 8000_001F[EBX] should
provide additional information regarding the feature (such as which page
table bit is used to mark pages as encrypted etc). The information in EBX
and ECX may vary from one family to another hence we use the host cpuid
to populate the EBX information.

The details for memory encryption CPUID is available in AMD APM
(https://support.amd.com/TechDocs/24594.pdf) Section E.4.17

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/cpu.c | 36 ++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |  3 +++
 2 files changed, 39 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5e431e769da..475d98a44880 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -235,6 +235,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_EXT4_FEATURES 0
 #define TCG_SVM_FEATURES 0
 #define TCG_KVM_FEATURES 0
+#define TCG_MEM_ENCRYPT_FEATURES 0
 #define TCG_7_0_EBX_FEATURES (CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_SMAP | \
           CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
           CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
@@ -546,6 +547,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .cpuid_reg = R_EDX,
         .tcg_features = ~0U,
     },
+    [FEAT_MEM_ENCRYPT] = {
+        .feat_names = {
+            NULL, "sev", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid_eax = 0x8000001F, .cpuid_reg = R_EAX,
+        .tcg_features = TCG_MEM_ENCRYPT_FEATURES,
+    }
 };
 
 typedef struct X86RegisterInfo32 {
@@ -1966,6 +1981,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: SEV_ES */
+        .features[FEAT_MEM_ENCRYPT] =
+            CPUID_8000_001F_EAX_SEV,
         .xlevel = 0x8000000A,
         .model_id = "AMD EPYC Processor",
     },
@@ -3590,6 +3608,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x8000001F:
+        if (env->features[FEAT_MEM_ENCRYPT] & CPUID_8000_001F_EAX_SEV) {
+            *eax = env->features[FEAT_MEM_ENCRYPT];
+            host_cpuid(0x8000001F, 0, NULL, ebx, NULL, NULL);
+            *ecx = 0;
+            *edx = 0;
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
@@ -4037,10 +4068,15 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
         x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
+        x86_cpu_adjust_feat_level(cpu, FEAT_MEM_ENCRYPT);
         /* SVM requires CPUID[0x8000000A] */
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
         }
+        /* SEV requires CPUID[0x8000001F] */
+        if ((env->features[FEAT_MEM_ENCRYPT] & CPUID_8000_001F_EAX_SEV)) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
+        }
     }
 
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f91e37d25dea..448b30f893fa 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -483,6 +483,7 @@ typedef enum FeatureWord {
     FEAT_6_EAX,         /* CPUID[6].EAX */
     FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
+    FEAT_MEM_ENCRYPT,   /* CPUID[8000_001F].EAX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -679,6 +680,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_6_EAX_ARAT       (1U << 2)
 
+#define CPUID_8000_001F_EAX_SEV             (1U << 1) /* SEV */
+
 /* CPUID[0x80000007].EDX flags: */
 #define CPUID_APM_INVTSC       (1U << 8)
 
-- 
2.14.3
