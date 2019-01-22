Received: from eggs.gnu.org ([209.51.188.92]:37840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gmJHa-0007gM-Mc
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gmJHZ-0006iI-Ld
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:13:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:53084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gmJHU-0006ZO-IY
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:13:30 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Wed, 23 Jan 2019 05:06:45 +0800
Message-Id: <20190122210648.26320-2-weijiang.yang@intel.com>
In-Reply-To: <20190122210648.26320-1-weijiang.yang@intel.com>
References: <20190122210648.26320-1-weijiang.yang@intel.com>
Subject: [Qemu-devel] [PATCH v2 1/4] Add CET xsaves/xrstors related macros
 and structures.
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

CET protection in user mode and kernel mode relies on
specific MSRs, these MSRs' contents are automatically
saved/restored by xsaves/xrstors instructions.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.h | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9c52d0cbeb..f3f724d8e6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -469,6 +469,9 @@ typedef enum X86Seg {
 #define XSTATE_ZMM_Hi256_BIT            6
 #define XSTATE_Hi16_ZMM_BIT             7
 #define XSTATE_PKRU_BIT                 9
+#define XSTATE_RESERVED_BIT             10
+#define XSTATE_CET_U_BIT                11
+#define XSTATE_CET_S_BIT                12
 
 #define XSTATE_FP_MASK                  (1ULL << XSTATE_FP_BIT)
 #define XSTATE_SSE_MASK                 (1ULL << XSTATE_SSE_BIT)
@@ -479,6 +482,19 @@ typedef enum X86Seg {
 #define XSTATE_ZMM_Hi256_MASK           (1ULL << XSTATE_ZMM_Hi256_BIT)
 #define XSTATE_Hi16_ZMM_MASK            (1ULL << XSTATE_Hi16_ZMM_BIT)
 #define XSTATE_PKRU_MASK                (1ULL << XSTATE_PKRU_BIT)
+#define XSTATE_RESERVED_MASK            (1ULL << XSTATE_RESERVED_BIT)
+#define XSTATE_CET_U_MASK               (1ULL << XSTATE_CET_U_BIT)
+#define XSTATE_CET_S_MASK               (1ULL << XSTATE_CET_S_BIT)
+
+/* CPUID feature bits available in XCR0 */
+#define CPUID_XSTATE_USER_MASK  (XSTATE_FP_MASK | XSTATE_SSE_MASK \
+                                | XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK \
+                                | XSTATE_BNDCSR_MASK | XSTATE_OPMASK_MASK \
+                                | XSTATE_ZMM_Hi256_MASK \
+                                | XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK)
+
+/* CPUID feature bits available in XSS */
+#define CPUID_XSTATE_KERNEL_MASK    (XSTATE_CET_U_MASK | XSTATE_CET_S_MASK)
 
 /* CPUID feature words */
 typedef enum FeatureWord {
@@ -503,6 +519,8 @@ typedef enum FeatureWord {
     FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
+    FEAT_XSAVE_SV_LO,   /* CPUID[EAX=0xd,ECX=1].ECX */
+    FEAT_XSAVE_SV_HI,   /* CPUID[EAX=0xd,ECX=1].EDX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -687,7 +705,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_LA57     (1U << 16)
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
 #define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
-
+#define CPUID_7_0_ECX_CET_SHSTK     (1U << 7)  /* CET SHSTK feature bit */
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_PCONFIG (1U << 18)       /* Platform Configuration */
@@ -1021,6 +1039,19 @@ typedef struct XSavePKRU {
     uint32_t padding;
 } XSavePKRU;
 
+/* Ext. save area 11: User mode CET state */
+typedef struct XSaveCETU {
+    uint64_t u_cet;
+    uint64_t user_ssp;
+} XSaveCETU;
+
+/* Ext. save area 12: Supervisor mode CET state */
+typedef struct XSaveCETS {
+    uint64_t kernel_ssp;
+    uint64_t pl1_ssp;
+    uint64_t pl2_ssp;
+} XSaveCETS;
+
 typedef struct X86XSaveArea {
     X86LegacyXSaveArea legacy;
     X86XSaveHeader header;
@@ -1039,6 +1070,9 @@ typedef struct X86XSaveArea {
     XSaveHi16_ZMM hi16_zmm_state;
     /* PKRU State: */
     XSavePKRU pkru_state;
+    /* CET State: */
+    XSaveCETU cet_u;
+    XSaveCETS cet_s;
 } X86XSaveArea;
 
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, avx_state) != 0x240);
-- 
2.17.1
