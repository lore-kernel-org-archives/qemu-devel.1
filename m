Received: from eggs.gnu.org ([209.51.188.92]:37853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gmJHb-0007gh-0o
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gmJHZ-0006i1-Kr
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:13:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:53088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gmJHU-0006aZ-He
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:13:30 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Wed, 23 Jan 2019 05:06:46 +0800
Message-Id: <20190122210648.26320-3-weijiang.yang@intel.com>
In-Reply-To: <20190122210648.26320-1-weijiang.yang@intel.com>
References: <20190122210648.26320-1-weijiang.yang@intel.com>
Subject: [Qemu-devel] [PATCH v2 2/4] Add CET SHSTK and IBT CPUID
 feature-word definitions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, cdupontd@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc: weijiang.yang@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>

XSS[bit 11] and XSS[bit 12] correspond to CET
user mode area and supervisor mode area respectively.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f81d35e1f9..f6c7bdf6fe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1018,7 +1018,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            NULL /* ospke */, NULL, "avx512vbmi2", NULL,
+            NULL /* ospke */, NULL, "avx512vbmi2", "shstk",
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
@@ -1041,7 +1041,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "pconfig", NULL,
-            NULL, NULL, NULL, NULL,
+            "ibt", NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", NULL,
             NULL, "arch-capabilities", NULL, "ssbd",
         },
@@ -1162,6 +1162,25 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             }
         },
     },
+    /* Below are CET supervisor xsave features */
+    [FEAT_XSAVE_SV_LO] = {
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = {
+            .eax = 0xD,
+            .needs_ecx = true,
+            .ecx = 1,
+            .reg = R_ECX,
+        },
+    },
+    [FEAT_XSAVE_SV_HI] = {
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = {
+            .eax = 0xD,
+            .needs_ecx = true,
+            .ecx = 1,
+            .reg = R_EDX
+        },
+    }
 };
 
 typedef struct X86RegisterInfo32 {
@@ -1233,6 +1252,14 @@ static const ExtSaveArea x86_ext_save_areas[] = {
           { .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
             .offset = offsetof(X86XSaveArea, pkru_state),
             .size = sizeof(XSavePKRU) },
+    [XSTATE_CET_U_BIT] = {
+            .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
+            .offset = 0 /*supervisor mode component, offset = 0 */,
+            .size = sizeof(XSaveCETU) },
+    [XSTATE_CET_S_BIT] = {
+            .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
+            .offset = 0 /*supervisor mode component, offset = 0 */,
+            .size = sizeof(XSaveCETS) },
 };
 
 static uint32_t xsave_area_size(uint64_t mask)
@@ -1243,6 +1270,9 @@ static uint32_t xsave_area_size(uint64_t mask)
     for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
         const ExtSaveArea *esa = &x86_ext_save_areas[i];
         if ((mask >> i) & 1) {
+            if (i >= 2 && !esa->offset) {
+                continue;
+            }
             ret = MAX(ret, esa->offset + esa->size);
         }
     }
@@ -4657,6 +4687,9 @@ static void x86_cpu_reset(CPUState *s)
     }
     for (i = 2; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
         const ExtSaveArea *esa = &x86_ext_save_areas[i];
+        if (!esa->offset) {
+            continue;
+        }
         if (env->features[esa->feature] & esa->bits) {
             xcr0 |= 1ull << i;
         }
-- 
2.17.1
