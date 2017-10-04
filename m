Received: from eggs.gnu.org ([2001:4830:134:3::10]:38300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzoe0-0008Gv-31
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodz-0002mh-2Q
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:44 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:43758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dzody-0002mB-Ts
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:42 -0400
Received: by mail-qt0-x234.google.com with SMTP id a43so15131701qta.0
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:43:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  4 Oct 2017 14:43:22 -0400
Message-Id: <20171004184325.24157-10-richard.henderson@linaro.org>
In-Reply-To: <20171004184325.24157-1-richard.henderson@linaro.org>
References: <20171004184325.24157-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v1 09/12] target/arm: Decode aa64 armv8.3 fcadd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h         |  5 ++++
 target/arm/advsimd_helper.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c  | 33 ++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 67583b3c2e..350e2fa0e1 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -551,6 +551,11 @@ DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #endif
diff --git a/target/arm/advsimd_helper.c b/target/arm/advsimd_helper.c
index b0f4b02a12..fe2e0cbcef 100644
--- a/target/arm/advsimd_helper.c
+++ b/target/arm/advsimd_helper.c
@@ -24,6 +24,18 @@
 #include "tcg/tcg-gvec-desc.h"
 
 
+/* Note that vector data is stored in host-endian 64-bit chunks,
+   so addressing units smaller than that needs a host-endian fixup.  */
+#ifdef HOST_WORDS_BIGENDIAN
+#define H1(x)  ((x) ^ 7)
+#define H2(x)  ((x) ^ 3)
+#define H4(x)  ((x) ^ 1)
+#else
+#define H1(x)  (x)
+#define H2(x)  (x)
+#define H4(x)  (x)
+#endif
+
 #define SET_QC() env->vfp.xregs[ARM_VFP_FPSCR] |= CPSR_Q
 
 static void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
@@ -177,3 +189,57 @@ void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fcadds)(void *vd, void *vn, void *vm,
+                         void *vfpst, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    float32 *d = vd;
+    float32 *n = vn;
+    float32 *m = vm;
+    float_status *fpst = vfpst;
+    uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t neg_imag = neg_real ^ 1;
+    uintptr_t i;
+
+    neg_real <<= 31;
+    neg_imag <<= 31;
+
+    for (i = 0; i < opr_sz / 4; i += 2) {
+        float32 e0 = n[H4(i)];
+        float32 e1 = m[H4(i + 1)] ^ neg_imag;
+        float32 e2 = n[H4(i + 1)];
+        float32 e3 = m[H4(i)] ^ neg_real;
+
+        d[H4(i)] = float32_add(e0, e1, fpst);
+        d[H4(i + 1)] = float32_add(e2, e3, fpst);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
+                         void *vfpst, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    float64 *d = vd;
+    float64 *n = vn;
+    float64 *m = vm;
+    float_status *fpst = vfpst;
+    uint64_t neg_real = extract64(desc, SIMD_DATA_SHIFT, 1);
+    uint64_t neg_imag = neg_real ^ 1;
+    uintptr_t i;
+
+    neg_real <<= 63;
+    neg_imag <<= 63;
+
+    for (i = 0; i < opr_sz / 8; i += 2) {
+        float64 e0 = n[i];
+        float64 e1 = m[i + 1] ^ neg_imag;
+        float64 e2 = n[i + 1];
+        float64 e3 = m[i] ^ neg_real;
+
+        d[i] = float64_add(e0, e1, fpst);
+        d[i + 1] = float64_add(e2, e3, fpst);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b02aad8cd7..f13a945c43 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9890,7 +9890,8 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     int size = extract32(insn, 22, 2);
     bool u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
-    int feature;
+    int feature, data;
+    TCGv_ptr fpst;
 
     if (!u) {
         unallocated_encoding(s);
@@ -9906,6 +9907,14 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = ARM_FEATURE_V8_1_SIMD;
         break;
+    case 0xc: /* FCADD, #90 */
+    case 0xe: /* FCADD, #270 */
+        if (size != 2 && (size != 3 || !is_q)) { /* FIXME: fp16 support */
+            unallocated_encoding(s);
+            return;
+        }
+        feature = ARM_FEATURE_V8_FCMA;
+        break;
     default:
         unallocated_encoding(s);
         return;
@@ -9952,6 +9961,28 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
                            0, fn_gvec_ptr);
         break;
 
+    case 0xc: /* FCADD, #90 */
+    case 0xe: /* FCADD, #270 */
+        switch (size) {
+        case 2:
+            fn_gvec_ptr = gen_helper_gvec_fcadds;
+            break;
+        case 3:
+            fn_gvec_ptr = gen_helper_gvec_fcaddd;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        data = extract32(opcode, 1, 1);
+        fpst = get_fpstatus_ptr();
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                           vec_full_reg_offset(s, rn),
+                           vec_full_reg_offset(s, rm), fpst,
+                           is_q ? 16 : 8, vec_full_reg_size(s),
+                           data, fn_gvec_ptr);
+        tcg_temp_free_ptr(fpst);
+        break;
+
     default:
         g_assert_not_reached();
     }
-- 
2.13.6
