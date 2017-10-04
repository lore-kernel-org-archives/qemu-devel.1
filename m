Received: from eggs.gnu.org ([2001:4830:134:3::10]:38233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodw-0008Ex-2l
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodu-0002he-Tk
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:40 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:53435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dzodu-0002hN-Ov
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:38 -0400
Received: by mail-qt0-x236.google.com with SMTP id 47so21026891qts.10
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:43:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  4 Oct 2017 14:43:19 -0400
Message-Id: <20171004184325.24157-7-richard.henderson@linaro.org>
In-Reply-To: <20171004184325.24157-1-richard.henderson@linaro.org>
References: <20171004184325.24157-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v1 06/12] target/arm: Decode aa32 armv8.1 three
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
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 83 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ab1a12a1b8..0cd58710b3 100644
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
@@ -5334,9 +5335,9 @@ static void gen_neon_narrow_op(int op, int u, int size,
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
@@ -5368,9 +5369,9 @@ static const uint8_t neon_3r_sizes[] = {
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
@@ -5556,6 +5557,7 @@ static const uint8_t neon_2rm_sizes[] = {
 
 static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 {
+    void (*fn_gvec_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
     int op;
     int q;
     int rd, rn, rm;
@@ -5600,12 +5602,12 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
@@ -5642,6 +5644,53 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
+                fn_gvec_ptr = gen_helper_gvec_qrdmlah_s16;
+                break;
+            case 2:
+                fn_gvec_ptr = gen_helper_gvec_qrdmlah_s32;
+                break;
+            default:
+                return 1;
+            }
+        do_vqrdmlx:
+            if (arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
+                int opr_sz = (1 + q) * 8;
+                tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
+                                   vfp_reg_offset(1, rn),
+                                   vfp_reg_offset(1, rm), cpu_env,
+                                   opr_sz, opr_sz, 0, fn_gvec_ptr);
+                return 0;
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
+                fn_gvec_ptr = gen_helper_gvec_qrdmlsh_s16;
+                break;
+            case 2:
+                fn_gvec_ptr = gen_helper_gvec_qrdmlsh_s32;
+                break;
+            default:
+                return 1;
+            }
+            goto do_vqrdmlx;
         }
         if (size == 3 && op != NEON_3R_LOGIC) {
             /* 64-bit element instructions. */
@@ -5727,11 +5776,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
@@ -5765,8 +5810,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
@@ -5963,7 +6008,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
             }
             break;
-        case NEON_3R_VPADD:
+        case NEON_3R_VPADD_VQRDMLAH:
             switch (size) {
             case 0: gen_helper_neon_padd_u8(tmp, tmp, tmp2); break;
             case 1: gen_helper_neon_padd_u16(tmp, tmp, tmp2); break;
@@ -6062,7 +6107,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
               }
             }
             break;
-        case NEON_3R_VFM:
+        case NEON_3R_VFM_VQRDMLSH:
         {
             /* VFMA, VFMS: fused multiply-add */
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.13.6
