Received: from eggs.gnu.org ([2001:4830:134:3::10]:58549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgYF-0003im-FQ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgYC-0001xc-7K
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:19 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgYB-0001tS-P5
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:16 -0500
Received: by mail-wr0-x242.google.com with SMTP id n7so25153336wrn.5
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:48:15 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:35 +0000
Message-Id: <20180227143852.11175-15-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 14/31] arm/translate-a64: add FP16
 FMULX/MLS/FMLA to simd_indexed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

The helpers use the new re-factored muladd support in SoftFloat for
the float16 work.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - re-jigged switch statement to fall-through for unalloc
  - added is_fp16 bool for fpst
  - fixed up some long lines
v4
  - don't double-check for feature bit
---
 target/arm/translate-a64.c | 82 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e96e6cdd15..6a264bc134 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11198,6 +11198,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     int rd = extract32(insn, 0, 5);
     bool is_long = false;
     bool is_fp = false;
+    bool is_fp16 = false;
     int index;
     TCGv_ptr fpst;
 
@@ -11244,7 +11245,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         /* fall through */
     case 0x9: /* FMUL, FMULX */
-        if (!extract32(size, 1, 1)) {
+        if (size == 1) {
             unallocated_encoding(s);
             return;
         }
@@ -11256,18 +11257,34 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     if (is_fp) {
-        /* low bit of size indicates single/double */
-        size = extract32(size, 0, 1) ? 3 : 2;
-        if (size == 2) {
+        /* convert insn encoded size to TCGMemOp size */
+        switch (size) {
+        case 2: /* single precision */
+            size = MO_32;
             index = h << 1 | l;
-        } else {
+            rm |= (m << 4);
+            break;
+        case 3: /* double precision */
+            size = MO_64;
             if (l || !is_q) {
                 unallocated_encoding(s);
                 return;
             }
             index = h;
+            rm |= (m << 4);
+            break;
+        case 0: /* half precision */
+            size = MO_16;
+            index = h << 2 | l << 1 | m;
+            is_fp16 = true;
+            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+                break;
+            }
+            /* fallthru */
+        default: /* unallocated */
+            unallocated_encoding(s);
+            return;
         }
-        rm |= (m << 4);
     } else {
         switch (size) {
         case 1:
@@ -11288,7 +11305,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     if (is_fp) {
-        fpst = get_fpstatus_ptr(false);
+        fpst = get_fpstatus_ptr(is_fp16);
     } else {
         fpst = NULL;
     }
@@ -11390,18 +11407,51 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 break;
             }
             case 0x5: /* FMLS */
-                /* As usual for ARM, separate negation for fused multiply-add */
-                gen_helper_vfp_negs(tcg_op, tcg_op);
-                /* fall through */
             case 0x1: /* FMLA */
-                read_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-                gen_helper_vfp_muladds(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
+                read_vec_element_i32(s, tcg_res, rd, pass,
+                                     is_scalar ? size : MO_32);
+                switch (size) {
+                case 1:
+                    if (opcode == 0x5) {
+                        /* As usual for ARM, separate negation for fused
+                         * multiply-add */
+                        tcg_gen_xori_i32(tcg_op, tcg_op, 0x80008000);
+                    }
+                    gen_helper_advsimd_muladdh(tcg_res, tcg_op, tcg_idx,
+                                               tcg_res, fpst);
+                    break;
+                case 2:
+                    if (opcode == 0x5) {
+                        /* As usual for ARM, separate negation for
+                         * fused multiply-add */
+                        tcg_gen_xori_i32(tcg_op, tcg_op, 0x80000000);
+                    }
+                    gen_helper_vfp_muladds(tcg_res, tcg_op, tcg_idx,
+                                           tcg_res, fpst);
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
                 break;
             case 0x9: /* FMUL, FMULX */
-                if (u) {
-                    gen_helper_vfp_mulxs(tcg_res, tcg_op, tcg_idx, fpst);
-                } else {
-                    gen_helper_vfp_muls(tcg_res, tcg_op, tcg_idx, fpst);
+                switch (size) {
+                case 1:
+                    if (u) {
+                        gen_helper_advsimd_mulxh(tcg_res, tcg_op, tcg_idx,
+                                                 fpst);
+                    } else {
+                        g_assert_not_reached();
+                    }
+                    break;
+                case 2:
+                    if (u) {
+                        gen_helper_vfp_mulxs(tcg_res, tcg_op, tcg_idx, fpst);
+                    } else {
+                        gen_helper_vfp_muls(tcg_res, tcg_op, tcg_idx, fpst);
+                    }
+                    break;
+                default:
+                    g_assert_not_reached();
                 }
                 break;
             case 0xc: /* SQDMULH */
-- 
2.15.1
