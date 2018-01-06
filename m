Received: from eggs.gnu.org ([2001:4830:134:3::10]:48451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXew9-0007ie-4A
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXew7-0005ax-8f
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:21 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXew7-0005ZS-0Q
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:19 -0500
Received: by mail-pg0-x244.google.com with SMTP id j4so2719228pgp.1
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:14:18 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.14.16 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:14:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:41 -0800
Message-Id: <20180106031346.6650-19-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 18/23] target/arm: Use vector infrastructure
 for aa64 constant shifts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 386 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 329 insertions(+), 57 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8769b4505a..d8bb3bbb25 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6432,17 +6432,6 @@ static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
     }
 }
 
-/* Common SHL/SLI - Shift left with an optional insert */
-static void handle_shli_with_ins(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
-                                 bool insert, int shift)
-{
-    if (insert) { /* SLI */
-        tcg_gen_deposit_i64(tcg_res, tcg_res, tcg_src, shift, 64 - shift);
-    } else { /* SHL */
-        tcg_gen_shli_i64(tcg_res, tcg_src, shift);
-    }
-}
-
 /* SRI: shift right with insert */
 static void handle_shri_with_ins(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
                                  int size, int shift)
@@ -6546,7 +6535,11 @@ static void handle_scalar_simd_shli(DisasContext *s, bool insert,
     tcg_rn = read_fp_dreg(s, rn);
     tcg_rd = insert ? read_fp_dreg(s, rd) : tcg_temp_new_i64();
 
-    handle_shli_with_ins(tcg_rd, tcg_rn, insert, shift);
+    if (insert) {
+        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, shift, 64 - shift);
+    } else {
+        tcg_gen_shli_i64(tcg_rd, tcg_rn, shift);
+    }
 
     write_fp_dreg(s, rd, tcg_rd);
 
@@ -8283,16 +8276,195 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
+static void gen_ssra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_sar8i_i64(a, a, shift);
+    tcg_gen_vec_add8_i64(d, d, a);
+}
+
+static void gen_ssra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_sar16i_i64(a, a, shift);
+    tcg_gen_vec_add16_i64(d, d, a);
+}
+
+static void gen_ssra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_sari_i32(a, a, shift);
+    tcg_gen_add_i32(d, d, a);
+}
+
+static void gen_ssra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_sari_i64(a, a, shift);
+    tcg_gen_add_i64(d, d, a);
+}
+
+static void gen_ssra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    tcg_gen_sari_vec(vece, a, a, sh);
+    tcg_gen_add_vec(vece, d, d, a);
+}
+
+static void gen_usra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_shr8i_i64(a, a, shift);
+    tcg_gen_vec_add8_i64(d, d, a);
+}
+
+static void gen_usra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_shr16i_i64(a, a, shift);
+    tcg_gen_vec_add16_i64(d, d, a);
+}
+
+static void gen_usra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_shri_i32(a, a, shift);
+    tcg_gen_add_i32(d, d, a);
+}
+
+static void gen_usra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_shri_i64(a, a, shift);
+    tcg_gen_add_i64(d, d, a);
+}
+
+static void gen_usra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    tcg_gen_shri_vec(vece, a, a, sh);
+    tcg_gen_add_vec(vece, d, d, a);
+}
+
+static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = (0xff >> shift) * (-1ull / 0xff);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_shr16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = (0xffff >> shift) * (-1ull / 0xffff);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_shr32_ins_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_shri_i32(a, a, shift);
+    tcg_gen_deposit_i32(d, d, a, 0, 32 - shift);
+}
+
+static void gen_shr64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_shri_i64(a, a, shift);
+    tcg_gen_deposit_i64(d, d, a, 0, 64 - shift);
+}
+
+static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    uint64_t mask = (2ull << ((8 << vece) - 1)) - 1;
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_dupi_vec(vece, m, mask ^ (mask >> sh));
+    tcg_gen_shri_vec(vece, t, a, sh);
+    tcg_gen_and_vec(vece, d, d, m);
+    tcg_gen_or_vec(vece, d, d, t);
+
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(m);
+}
+
 /* SSHR[RA]/USHR[RA] - Vector shift right (optional rounding/accumulate) */
 static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
                                  int immh, int immb, int opcode, int rn, int rd)
 {
+    static const GVecGen2i ssra_op[4] = {
+        { .fni8 = gen_ssra8_i64,
+          .fniv = gen_ssra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_8 },
+        { .fni8 = gen_ssra16_i64,
+          .fniv = gen_ssra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_16 },
+        { .fni4 = gen_ssra32_i32,
+          .fniv = gen_ssra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_32 },
+        { .fni8 = gen_ssra64_i64,
+          .fniv = gen_ssra_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_64 },
+    };
+    static const GVecGen2i usra_op[4] = {
+        { .fni8 = gen_usra8_i64,
+          .fniv = gen_usra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_8, },
+        { .fni8 = gen_usra16_i64,
+          .fniv = gen_usra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_16, },
+        { .fni4 = gen_usra32_i32,
+          .fniv = gen_usra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_32, },
+        { .fni8 = gen_usra64_i64,
+          .fniv = gen_usra_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_64, },
+    };
+    static const GVecGen2i sri_op[4] = {
+        { .fni8 = gen_shr8_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_8 },
+        { .fni8 = gen_shr16_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_16 },
+        { .fni4 = gen_shr32_ins_i32,
+          .fniv = gen_shr_ins_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_32 },
+        { .fni8 = gen_shr64_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_64 },
+    };
+
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = 2 * (8 << size) - immhb;
     bool accumulate = false;
-    bool round = false;
-    bool insert = false;
     int dsize = is_q ? 128 : 64;
     int esize = 8 << size;
     int elements = dsize/esize;
@@ -8300,6 +8472,8 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
     TCGv_i64 tcg_rn = new_tmp_a64(s);
     TCGv_i64 tcg_rd = new_tmp_a64(s);
     TCGv_i64 tcg_round;
+    uint64_t round_const;
+    const GVecGen2i *gvec_op;
     int i;
 
     if (extract32(immh, 3, 1) && !is_q) {
@@ -8318,64 +8492,141 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
 
     switch (opcode) {
     case 0x02: /* SSRA / USRA (accumulate) */
-        accumulate = true;
-        break;
+        if (is_u) {
+            /* Shift count same as element size produces zero to add.  */
+            if (shift == 8 << size) {
+                goto done;
+            }
+            gvec_op = &usra_op[size];
+        } else {
+            /* Shift count same as element size produces all sign to add.  */
+            if (shift == 8 << size) {
+                shift -= 1;
+            }
+            gvec_op = &ssra_op[size];
+        }
+        goto do_gvec;
+    case 0x08: /* SRI */
+        /* Shift count same as element size is valid but does nothing.  */
+        if (shift == 8 << size) {
+            goto done;
+        }
+        gvec_op = &sri_op[size];
+    do_gvec:
+        tcg_gen_gvec_2i(vec_full_reg_offset(s, rd),
+                        vec_full_reg_offset(s, rn), is_q ? 16 : 8,
+                        vec_full_reg_size(s), shift, gvec_op);
+        return;
+
+    case 0x00: /* SSHR / USHR */
+        if (is_u) {
+            if (shift == 8 << size) {
+                /* Shift count the same size as element size produces zero.  */
+                tcg_gen_gvec_dup8i(vec_full_reg_offset(s, rd),
+                                   is_q ? 16 : 8, vec_full_reg_size(s), 0);
+            } else {
+                tcg_gen_gvec_shri(size, vec_full_reg_offset(s, rd),
+                                  vec_full_reg_offset(s, rn), is_q ? 16 : 8,
+                                  vec_full_reg_size(s), shift);
+            }
+        } else {
+            /* Shift count the same size as element size produces all sign.  */
+            if (shift == 8 << size) {
+                shift -= 1;
+            }
+            tcg_gen_gvec_sari(size, vec_full_reg_offset(s, rd),
+                              vec_full_reg_offset(s, rn), is_q ? 16 : 8,
+                              vec_full_reg_size(s), shift);
+        }
+        return;
+
     case 0x04: /* SRSHR / URSHR (rounding) */
-        round = true;
         break;
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        accumulate = round = true;
-        break;
-    case 0x08: /* SRI */
-        insert = true;
+        accumulate = true;
         break;
+    default:
+        g_assert_not_reached();
     }
 
-    if (round) {
-        uint64_t round_const = 1ULL << (shift - 1);
-        tcg_round = tcg_const_i64(round_const);
-    } else {
-        tcg_round = NULL;
-    }
+    round_const = 1ULL << (shift - 1);
+    tcg_round = tcg_const_i64(round_const);
 
     for (i = 0; i < elements; i++) {
         read_vec_element(s, tcg_rn, rn, i, memop);
-        if (accumulate || insert) {
+        if (accumulate) {
             read_vec_element(s, tcg_rd, rd, i, memop);
         }
 
-        if (insert) {
-            handle_shri_with_ins(tcg_rd, tcg_rn, size, shift);
-        } else {
-            handle_shri_with_rndacc(tcg_rd, tcg_rn, tcg_round,
-                                    accumulate, is_u, size, shift);
-        }
+        handle_shri_with_rndacc(tcg_rd, tcg_rn, tcg_round,
+                                accumulate, is_u, size, shift);
 
         write_vec_element(s, tcg_rd, rd, i, size);
     }
+    tcg_temp_free_i64(tcg_round);
 
+ done:
     if (!is_q) {
         clear_vec_high(s, rd);
     }
+}
 
-    if (round) {
-        tcg_temp_free_i64(tcg_round);
-    }
+static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = ((0xff << shift) & 0xff) * (-1ull / 0xff);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shli_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_shl16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = ((0xffff << shift) & 0xffff) * (-1ull / 0xffff);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shli_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_shl32_ins_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_deposit_i32(d, d, a, shift, 32 - shift);
+}
+
+static void gen_shl64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_deposit_i64(d, d, a, shift, 64 - shift);
+}
+
+static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    uint64_t mask = (1ull << sh) - 1;
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_dupi_vec(vece, m, mask);
+    tcg_gen_shli_vec(vece, t, a, sh);
+    tcg_gen_and_vec(vece, d, d, m);
+    tcg_gen_or_vec(vece, d, d, t);
+
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(m);
 }
 
 /* SHL/SLI - Vector shift left */
 static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
-                                int immh, int immb, int opcode, int rn, int rd)
+                                 int immh, int immb, int opcode, int rn, int rd)
 {
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = immhb - (8 << size);
-    int dsize = is_q ? 128 : 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    TCGv_i64 tcg_rn = new_tmp_a64(s);
-    TCGv_i64 tcg_rd = new_tmp_a64(s);
-    int i;
 
     if (extract32(immh, 3, 1) && !is_q) {
         unallocated_encoding(s);
@@ -8391,19 +8642,40 @@ static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
         return;
     }
 
-    for (i = 0; i < elements; i++) {
-        read_vec_element(s, tcg_rn, rn, i, size);
-        if (insert) {
-            read_vec_element(s, tcg_rd, rd, i, size);
-        }
-
-        handle_shli_with_ins(tcg_rd, tcg_rn, insert, shift);
-
-        write_vec_element(s, tcg_rd, rd, i, size);
-    }
-
-    if (!is_q) {
-        clear_vec_high(s, rd);
+    if (insert) {
+        static const GVecGen2i shi_op[4] = {
+            { .fni8 = gen_shl8_ins_i64,
+              .fniv = gen_shl_ins_vec,
+              .opc = INDEX_op_shli_vec,
+              .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+              .load_dest = true,
+              .vece = MO_8 },
+            { .fni8 = gen_shl16_ins_i64,
+              .fniv = gen_shl_ins_vec,
+              .opc = INDEX_op_shli_vec,
+              .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+              .load_dest = true,
+              .vece = MO_16 },
+            { .fni4 = gen_shl32_ins_i32,
+              .fniv = gen_shl_ins_vec,
+              .opc = INDEX_op_shli_vec,
+              .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+              .load_dest = true,
+              .vece = MO_32 },
+            { .fni8 = gen_shl64_ins_i64,
+              .fniv = gen_shl_ins_vec,
+              .opc = INDEX_op_shli_vec,
+              .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+              .load_dest = true,
+              .vece = MO_64 },
+        };
+        tcg_gen_gvec_2i(vec_full_reg_offset(s, rd),
+                        vec_full_reg_offset(s, rn), is_q ? 16 : 8,
+                        vec_full_reg_size(s), shift, &shi_op[size]);
+    } else {
+        tcg_gen_gvec_shli(size, vec_full_reg_offset(s, rd),
+                          vec_full_reg_offset(s, rn), is_q ? 16 : 8,
+                          vec_full_reg_size(s), shift);
     }
 }
 
-- 
2.14.3
