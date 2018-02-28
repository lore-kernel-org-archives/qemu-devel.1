Received: from eggs.gnu.org ([2001:4830:134:3::10]:35722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7S6-0003SG-6k
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7S4-0006Qj-Tj
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:46 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:39549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er7S4-0006Pw-MM
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:44 -0500
Received: by mail-pl0-x242.google.com with SMTP id s13-v6so2119297plq.6
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:31:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 11:31:20 -0800
Message-Id: <20180228193125.20577-12-richard.henderson@linaro.org>
In-Reply-To: <20180228193125.20577-1-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/16] target/arm: Decode aa64 armv8.3 fcadd
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  7 ++++
 target/arm/translate-a64.c | 48 ++++++++++++++++++++++-
 target/arm/vec_helper.c    | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 7f0d3b2d84..1e2d7025de 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -578,6 +578,13 @@ DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #endif
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e4d2d548ba..efed4fd9d2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -713,6 +713,21 @@ static void gen_gvec_op3_env(DisasContext *s, bool is_q, int rd,
                        is_q ? 16 : 8, vec_full_reg_size(s), 0, fn);
 }
 
+/* Expand a 3-operand + fpstatus pointer + simd data value operation using
+ * an out-of-line helper.
+ */
+static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
+                              int rm, bool is_fp16, int data,
+                              gen_helper_gvec_3_ptr *fn)
+{
+    TCGv_ptr fpst = get_fpstatus_ptr(is_fp16);
+    tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm), fpst,
+                       is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
+    tcg_temp_free_ptr(fpst);
+}
+
 /* Set ZF and NF based on a 64 bit result. This is alas fiddlier
  * than the 32 bit equivalent.
  */
@@ -10816,7 +10831,7 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     int size = extract32(insn, 22, 2);
     bool u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
-    int feature;
+    int feature, rot;
 
     switch (u * 16 + opcode) {
     case 0x10: /* SQRDMLAH (vector) */
@@ -10827,6 +10842,16 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = ARM_FEATURE_V8_RDM;
         break;
+    case 0xc: /* FCADD, #90 */
+    case 0xe: /* FCADD, #270 */
+        if (size == 0
+            || (size == 1 && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))
+            || (size == 3 && !is_q)) {
+            unallocated_encoding(s);
+            return;
+        }
+        feature = ARM_FEATURE_V8_FCMA;
+        break;
     default:
         unallocated_encoding(s);
         return;
@@ -10866,6 +10891,27 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         return;
 
+    case 0xc: /* FCADD, #90 */
+    case 0xe: /* FCADD, #270 */
+        rot = extract32(opcode, 1, 1);
+        switch (size) {
+        case 1:
+            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, size == 1, rot,
+                              gen_helper_gvec_fcaddh);
+            break;
+        case 2:
+            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, size == 1, rot,
+                              gen_helper_gvec_fcadds);
+            break;
+        case 3:
+            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, size == 1, rot,
+                              gen_helper_gvec_fcaddd);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return;
+
     default:
         g_assert_not_reached();
     }
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 3072df4d77..a868ca6aac 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -22,8 +22,21 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
+#include "fpu/softfloat.h"
 
 
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
@@ -181,3 +194,87 @@ void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
+                         void *vfpst, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    float16 *d = vd;
+    float16 *n = vn;
+    float16 *m = vm;
+    float_status *fpst = vfpst;
+    uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t neg_imag = neg_real ^ 1;
+    uintptr_t i;
+
+    /* Shift boolean to the sign bit so we can xor to negate.  */
+    neg_real <<= 15;
+    neg_imag <<= 15;
+
+    for (i = 0; i < opr_sz / 2; i += 2) {
+        float16 e0 = n[H2(i)];
+        float16 e1 = m[H2(i + 1)] ^ neg_imag;
+        float16 e2 = n[H2(i + 1)];
+        float16 e3 = m[H2(i)] ^ neg_real;
+
+        d[H2(i)] = float16_add(e0, e1, fpst);
+        d[H2(i + 1)] = float16_add(e2, e3, fpst);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
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
+    /* Shift boolean to the sign bit so we can xor to negate.  */
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
+    /* Shift boolean to the sign bit so we can xor to negate.  */
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
-- 
2.14.3
