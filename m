Received: from eggs.gnu.org ([2001:4830:134:3::10]:41100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9e-00062o-Na
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9d-0008Gs-1W
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:42 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:40255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz9c-0008G0-QT
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:40 -0500
Received: by mail-pl0-x244.google.com with SMTP id 62so3764432pld.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:24:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:24:22 -0800
Message-Id: <20171218172425.18200-9-richard.henderson@linaro.org>
In-Reply-To: <20171218172425.18200-1-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/11] target/arm: Decode aa64 armv8.3 fcadd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h         |  7 ++++
 target/arm/advsimd_helper.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c  | 36 +++++++++++++++++-
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 06ca458614..0f0fc942b0 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -567,6 +567,13 @@ DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
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
diff --git a/target/arm/advsimd_helper.c b/target/arm/advsimd_helper.c
index d5185165a5..afc2bb1142 100644
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
@@ -181,3 +193,84 @@ void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
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
index 85fc7af491..89a0616894 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10696,7 +10696,8 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     int size = extract32(insn, 22, 2);
     bool u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
-    int feature;
+    int feature, data;
+    TCGv_ptr fpst;
 
     if (!u) {
         unallocated_encoding(s);
@@ -10712,6 +10713,14 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = ARM_FEATURE_V8_1_SIMD;
         break;
+    case 0xc: /* FCADD, #90 */
+    case 0xe: /* FCADD, #270 */
+        if (size == 0 || (size == 3 && !is_q)) {
+            unallocated_encoding(s);
+            return;
+        }
+        feature = ARM_FEATURE_V8_FCMA;
+        break;
     default:
         unallocated_encoding(s);
         return;
@@ -10758,6 +10767,31 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
                            0, fn_gvec_ptr);
         break;
 
+    case 0xc: /* FCADD, #90 */
+    case 0xe: /* FCADD, #270 */
+        switch (size) {
+        case 1:
+            fn_gvec_ptr = gen_helper_gvec_fcaddh;
+            break;
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
+        fpst = get_fpstatus_ptr(size == 1);
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
2.14.3
