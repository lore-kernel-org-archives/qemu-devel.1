Received: from eggs.gnu.org ([2001:4830:134:3::10]:37198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3a-0000TX-IZ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3T-00015Q-DL
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:26 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3T-00013s-5S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:19 -0500
Received: by mail-pg0-x241.google.com with SMTP id k134so9402740pga.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:43 -0800
Message-Id: <20171218171758.16964-12-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 11/26] target/arm: Use vector infrastructure
 for aa64 zip/uzp/trn/xtn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 103 +++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 68 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 55a4902fc2..8769b4505a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5576,11 +5576,7 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 12, 2);
     bool part = extract32(insn, 14, 1);
     bool is_q = extract32(insn, 30, 1);
-    int esize = 8 << size;
-    int i, ofs;
-    int datasize = is_q ? 128 : 64;
-    int elements = datasize / esize;
-    TCGv_i64 tcg_res, tcg_resl, tcg_resh;
+    GVecGen3Fn *gvec_fn;
 
     if (opcode == 0 || (size == 3 && !is_q)) {
         unallocated_encoding(s);
@@ -5591,60 +5587,24 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
         return;
     }
 
-    tcg_resl = tcg_const_i64(0);
-    tcg_resh = tcg_const_i64(0);
-    tcg_res = tcg_temp_new_i64();
-
-    for (i = 0; i < elements; i++) {
-        switch (opcode) {
-        case 1: /* UZP1/2 */
-        {
-            int midpoint = elements / 2;
-            if (i < midpoint) {
-                read_vec_element(s, tcg_res, rn, 2 * i + part, size);
-            } else {
-                read_vec_element(s, tcg_res, rm,
-                                 2 * (i - midpoint) + part, size);
-            }
-            break;
-        }
-        case 2: /* TRN1/2 */
-            if (i & 1) {
-                read_vec_element(s, tcg_res, rm, (i & ~1) + part, size);
-            } else {
-                read_vec_element(s, tcg_res, rn, (i & ~1) + part, size);
-            }
-            break;
-        case 3: /* ZIP1/2 */
-        {
-            int base = part * elements / 2;
-            if (i & 1) {
-                read_vec_element(s, tcg_res, rm, base + (i >> 1), size);
-            } else {
-                read_vec_element(s, tcg_res, rn, base + (i >> 1), size);
-            }
-            break;
-        }
-        default:
-            g_assert_not_reached();
-        }
-
-        ofs = i * esize;
-        if (ofs < 64) {
-            tcg_gen_shli_i64(tcg_res, tcg_res, ofs);
-            tcg_gen_or_i64(tcg_resl, tcg_resl, tcg_res);
-        } else {
-            tcg_gen_shli_i64(tcg_res, tcg_res, ofs - 64);
-            tcg_gen_or_i64(tcg_resh, tcg_resh, tcg_res);
-        }
+    switch (opcode) {
+    case 1: /* UZP1/2 */
+        gvec_fn = part ? tcg_gen_gvec_uzpo : tcg_gen_gvec_uzpe;
+        break;
+    case 2: /* TRN1/2 */
+        gvec_fn = part ? tcg_gen_gvec_trno : tcg_gen_gvec_trne;
+        break;
+    case 3: /* ZIP1/2 */
+        gvec_fn = part ? tcg_gen_gvec_ziph : tcg_gen_gvec_zipl;
+        break;
+    default:
+        g_assert_not_reached();
     }
 
-    tcg_temp_free_i64(tcg_res);
-
-    write_vec_element(s, tcg_resl, rd, 0, MO_64);
-    tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
-    tcg_temp_free_i64(tcg_resh);
+    gvec_fn(size, vec_full_reg_offset(s, rd),
+            vec_full_reg_offset(s, rn),
+            vec_full_reg_offset(s, rm),
+            is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
 static void do_minmaxop(DisasContext *s, TCGv_i32 tcg_elt1, TCGv_i32 tcg_elt2,
@@ -7922,6 +7882,22 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
     int destelt = is_q ? 2 : 0;
     int passes = scalar ? 1 : 2;
 
+    if (opcode == 0x12 && !u) { /* XTN, XTN2 */
+        tcg_debug_assert(!scalar);
+        if (is_q) { /* XTN2 */
+            tcg_gen_gvec_uzpe(size, vec_reg_offset(s, rd, 1, MO_64),
+                              vec_reg_offset(s, rn, 0, MO_64),
+                              vec_reg_offset(s, rn, 1, MO_64),
+                              8, vec_full_reg_size(s) - 8);
+        } else {
+            tcg_gen_gvec_uzpe(size, vec_reg_offset(s, rd, 0, MO_64),
+                              vec_reg_offset(s, rn, 0, MO_64),
+                              vec_reg_offset(s, rn, 1, MO_64),
+                              8, vec_full_reg_size(s));
+        }
+        return;
+    }
+
     if (scalar) {
         tcg_res[1] = tcg_const_i32(0);
     }
@@ -7939,23 +7915,14 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         tcg_res[pass] = tcg_temp_new_i32();
 
         switch (opcode) {
-        case 0x12: /* XTN, SQXTUN */
+        case 0x12: /* , SQXTUN */
         {
-            static NeonGenNarrowFn * const xtnfns[3] = {
-                gen_helper_neon_narrow_u8,
-                gen_helper_neon_narrow_u16,
-                tcg_gen_extrl_i64_i32,
-            };
             static NeonGenNarrowEnvFn * const sqxtunfns[3] = {
                 gen_helper_neon_unarrow_sat8,
                 gen_helper_neon_unarrow_sat16,
                 gen_helper_neon_unarrow_sat32,
             };
-            if (u) {
-                genenvfn = sqxtunfns[size];
-            } else {
-                genfn = xtnfns[size];
-            }
+            genenvfn = sqxtunfns[size];
             break;
         }
         case 0x14: /* SQXTN, UQXTN */
-- 
2.14.3
