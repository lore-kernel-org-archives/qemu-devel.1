Received: from eggs.gnu.org ([208.118.235.92]:50655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gc4RH-0005iL-6H
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gc4RF-0005qF-39
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:14744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gc4RD-0005p1-BM
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:12 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Wed, 26 Dec 2018 16:25:18 +0800
Message-Id: <30d79c2d6fa0658cd2818c21da852fd4dfeeae1c.1545806972.git.weijiang.yang@intel.com>
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
Subject: [Qemu-devel] [PATCH 2/4] Add CET SHSTK and IBT CPUID feature-word
 definitions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc: Yang Weijiang <weijiang.yang@intel.com>, Zhang Yi <yi.z.zhang@linux.intel.com>

XSS[bit 11] and XSS[bit 12] correspond to CET
user mode area and supervisor mode area respectively.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f81d35e1f9..3630c688d6 100644
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
+            .offset = offsetof(X86XSaveArea, cet_u),
+            .size = sizeof(XSaveCETU) },
+    [XSTATE_CET_S_BIT] = {
+            .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
+            .offset = offsetof(X86XSaveArea, cet_s),
+            .size = sizeof(XSaveCETS) },
 };
 
 static uint32_t xsave_area_size(uint64_t mask)
-- 
2.17.1
