Received: from eggs.gnu.org ([2001:4830:134:3::10]:40995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9Z-0005vm-Ex
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9Y-0008Ak-Aq
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:37 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz9X-00089X-Vl
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:36 -0500
Received: by mail-pl0-x244.google.com with SMTP id d21so5200475pll.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:24:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:24:19 -0800
Message-Id: <20171218172425.18200-6-richard.henderson@linaro.org>
In-Reply-To: <20171218172425.18200-1-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 05/11] target/arm: Decode aa32 armv8.1 three
 same
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 85 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c690658493..a9587ae242 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -25,6 +25,7 @@
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
+#include "tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
 #include "arm_ldst.h"
@@ -5364,9 +5365,9 @@ static void gen_neon_narrow_op(int op, int u, int size,
 #define NEON_3R_VPMAX 20
 #define NEON_3R_VPMIN 21
 #define NEON_3R_VQDMULH_VQRDMULH 22
-#define NEON_3R_VPADD 23
+#define NEON_3R_VPADD_VQRDMLAH 23
 #define NEON_3R_SHA 24 /* SHA1C,SHA1P,SHA1M,SHA1SU0,SHA256H{2},SHA256SU1 */
-#define NEON_3R_VFM 25 /* VFMA, VFMS : float fused multiply-add */
+#define NEON_3R_VFM_VQRDMLSH 25 /* VFMA, VFMS : float fused multiply-add */
 #define NEON_3R_FLOAT_ARITH 26 /* float VADD, VSUB, VPADD, VABD */
 #define NEON_3R_FLOAT_MULTIPLY 27 /* float VMLA, VMLS, VMUL */
 #define NEON_3R_FLOAT_CMP 28 /* float VCEQ, VCGE, VCGT */
@@ -5398,9 +5399,9 @@ static const uint8_t neon_3r_sizes[] = {
     [NEON_3R_VPMAX] = 0x7,
     [NEON_3R_VPMIN] = 0x7,
     [NEON_3R_VQDMULH_VQRDMULH] = 0x6,
-    [NEON_3R_VPADD] = 0x7,
+    [NEON_3R_VPADD_VQRDMLAH] = 0x7,
     [NEON_3R_SHA] = 0xf, /* size field encodes op type */
-    [NEON_3R_VFM] = 0x5, /* size bit 1 encodes op */
+    [NEON_3R_VFM_VQRDMLSH] = 0x7, /* For VFM, size bit 1 encodes op */
     [NEON_3R_FLOAT_ARITH] = 0x5, /* size bit 1 encodes op */
     [NEON_3R_FLOAT_MULTIPLY] = 0x5, /* size bit 1 encodes op */
     [NEON_3R_FLOAT_CMP] = 0x5, /* size bit 1 encodes op */
@@ -5579,6 +5580,22 @@ static const uint8_t neon_2rm_sizes[] = {
     [NEON_2RM_VCVT_UF] = 0x4,
 };
 
+
+/* Expand v8.1 simd helper.  */
+static int do_v81_helper(DisasContext *s, gen_helper_gvec_3_ptr *fn,
+                         int q, int rd, int rn, int rm)
+{
+    if (arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
+        int opr_sz = (1 + q) * 8;
+        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
+                           vfp_reg_offset(1, rn),
+                           vfp_reg_offset(1, rm), cpu_env,
+                           opr_sz, opr_sz, 0, fn);
+        return 0;
+    }
+    return 1;
+}
+
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
    We process data in a mixture of 32-bit and 64-bit chunks.
@@ -5630,12 +5647,12 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         if (q && ((rd | rn | rm) & 1)) {
             return 1;
         }
-        /*
-         * The SHA-1/SHA-256 3-register instructions require special treatment
-         * here, as their size field is overloaded as an op type selector, and
-         * they all consume their input in a single pass.
-         */
-        if (op == NEON_3R_SHA) {
+        switch (op) {
+        case NEON_3R_SHA:
+            /* The SHA-1/SHA-256 3-register instructions require special
+             * treatment here, as their size field is overloaded as an
+             * op type selector, and they all consume their input in a
+             * single pass.  */
             if (!q) {
                 return 1;
             }
@@ -5672,6 +5689,40 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tcg_temp_free_i32(tmp2);
             tcg_temp_free_i32(tmp3);
             return 0;
+
+        case NEON_3R_VPADD_VQRDMLAH:
+            if (!u) {
+                break;  /* VPADD */
+            }
+            /* VQRDMLAH */
+            switch (size) {
+            case 1:
+                return do_v81_helper(s, gen_helper_gvec_qrdmlah_s16,
+                                     q, rd, rn, rm);
+            case 2:
+                return do_v81_helper(s, gen_helper_gvec_qrdmlah_s32,
+                                     q, rd, rn, rm);
+            }
+            return 1;
+
+        case NEON_3R_VFM_VQRDMLSH:
+            if (!u) {
+                /* VFM, VFMS */
+                if ((5 & (1 << size)) == 0) {
+                    return 1;
+                }
+                break;
+            }
+            /* VQRDMLSH */
+            switch (size) {
+            case 1:
+                return do_v81_helper(s, gen_helper_gvec_qrdmlsh_s16,
+                                     q, rd, rn, rm);
+            case 2:
+                return do_v81_helper(s, gen_helper_gvec_qrdmlsh_s32,
+                                     q, rd, rn, rm);
+            }
+            return 1;
         }
         if (size == 3 && op != NEON_3R_LOGIC) {
             /* 64-bit element instructions. */
@@ -5757,11 +5808,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 rm = rtmp;
             }
             break;
-        case NEON_3R_VPADD:
-            if (u) {
-                return 1;
-            }
-            /* Fall through */
+        case NEON_3R_VPADD_VQRDMLAH:
         case NEON_3R_VPMAX:
         case NEON_3R_VPMIN:
             pairwise = 1;
@@ -5795,8 +5842,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 return 1;
             }
             break;
-        case NEON_3R_VFM:
-            if (!arm_dc_feature(s, ARM_FEATURE_VFP4) || u) {
+        case NEON_3R_VFM_VQRDMLSH:
+            if (!arm_dc_feature(s, ARM_FEATURE_VFP4)) {
                 return 1;
             }
             break;
@@ -5993,7 +6040,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
             }
             break;
-        case NEON_3R_VPADD:
+        case NEON_3R_VPADD_VQRDMLAH:
             switch (size) {
             case 0: gen_helper_neon_padd_u8(tmp, tmp, tmp2); break;
             case 1: gen_helper_neon_padd_u16(tmp, tmp, tmp2); break;
@@ -6092,7 +6139,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
               }
             }
             break;
-        case NEON_3R_VFM:
+        case NEON_3R_VFM_VQRDMLSH:
         {
             /* VFMA, VFMS: fused multiply-add */
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.14.3
