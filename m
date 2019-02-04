Received: from eggs.gnu.org ([209.51.188.92]:51529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeC1-00011d-Gc
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeBy-0006V1-3E
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:45 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqeBx-0006R7-Ms
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:41 -0500
Received: by mail-wm1-x343.google.com with SMTP id z5so5203356wmf.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:21:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 13:21:24 +0000
Message-Id: <20190204132126.3255-3-richard.henderson@linaro.org>
In-Reply-To: <20190204132126.3255-1-richard.henderson@linaro.org>
References: <20190204132126.3255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 2/4] target/arm: Clean TBI for data
 operations in the translator
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

This will allow TBI to be used in user-only mode, as well as
avoid ping-ponging the softmmu TLB when TBI is in use.  It
will also enable other armv8 extensions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 217 ++++++++++++++++++++-----------------
 1 file changed, 116 insertions(+), 101 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0b4a09ca1c..27b90d5778 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -335,6 +335,18 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
     gen_top_byte_ignore(s, cpu_pc, src, s->tbii);
 }
 
+/*
+ * Return a "clean" address for ADDR according to TBID.
+ * This is always a fresh temporary, as we need to be able to
+ * increment this independently of a dirty write-back address.
+ */
+static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
+{
+    TCGv_i64 clean = new_tmp_a64(s);
+    gen_top_byte_ignore(s, clean, addr, s->tbid);
+    return clean;
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -2347,12 +2359,13 @@ static void gen_compare_and_swap(DisasContext *s, int rs, int rt,
     TCGv_i64 tcg_rs = cpu_reg(s, rs);
     TCGv_i64 tcg_rt = cpu_reg(s, rt);
     int memidx = get_mem_index(s);
-    TCGv_i64 addr = cpu_reg_sp(s, rn);
+    TCGv_i64 clean_addr;
 
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    tcg_gen_atomic_cmpxchg_i64(tcg_rs, addr, tcg_rs, tcg_rt, memidx,
+    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+    tcg_gen_atomic_cmpxchg_i64(tcg_rs, clean_addr, tcg_rs, tcg_rt, memidx,
                                size | MO_ALIGN | s->be_data);
 }
 
@@ -2363,12 +2376,13 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
     TCGv_i64 s2 = cpu_reg(s, rs + 1);
     TCGv_i64 t1 = cpu_reg(s, rt);
     TCGv_i64 t2 = cpu_reg(s, rt + 1);
-    TCGv_i64 addr = cpu_reg_sp(s, rn);
+    TCGv_i64 clean_addr;
     int memidx = get_mem_index(s);
 
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
+    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
 
     if (size == 2) {
         TCGv_i64 cmp = tcg_temp_new_i64();
@@ -2382,7 +2396,7 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
             tcg_gen_concat32_i64(cmp, s2, s1);
         }
 
-        tcg_gen_atomic_cmpxchg_i64(cmp, addr, cmp, val, memidx,
+        tcg_gen_atomic_cmpxchg_i64(cmp, clean_addr, cmp, val, memidx,
                                    MO_64 | MO_ALIGN | s->be_data);
         tcg_temp_free_i64(val);
 
@@ -2396,9 +2410,11 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
         if (HAVE_CMPXCHG128) {
             TCGv_i32 tcg_rs = tcg_const_i32(rs);
             if (s->be_data == MO_LE) {
-                gen_helper_casp_le_parallel(cpu_env, tcg_rs, addr, t1, t2);
+                gen_helper_casp_le_parallel(cpu_env, tcg_rs,
+                                            clean_addr, t1, t2);
             } else {
-                gen_helper_casp_be_parallel(cpu_env, tcg_rs, addr, t1, t2);
+                gen_helper_casp_be_parallel(cpu_env, tcg_rs,
+                                            clean_addr, t1, t2);
             }
             tcg_temp_free_i32(tcg_rs);
         } else {
@@ -2414,10 +2430,10 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
         TCGv_i64 zero = tcg_const_i64(0);
 
         /* Load the two words, in memory order.  */
-        tcg_gen_qemu_ld_i64(d1, addr, memidx,
+        tcg_gen_qemu_ld_i64(d1, clean_addr, memidx,
                             MO_64 | MO_ALIGN_16 | s->be_data);
-        tcg_gen_addi_i64(a2, addr, 8);
-        tcg_gen_qemu_ld_i64(d2, addr, memidx, MO_64 | s->be_data);
+        tcg_gen_addi_i64(a2, clean_addr, 8);
+        tcg_gen_qemu_ld_i64(d2, clean_addr, memidx, MO_64 | s->be_data);
 
         /* Compare the two words, also in memory order.  */
         tcg_gen_setcond_i64(TCG_COND_EQ, c1, d1, s1);
@@ -2427,7 +2443,7 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
         /* If compare equal, write back new data, else write back old data.  */
         tcg_gen_movcond_i64(TCG_COND_NE, c1, c2, zero, t1, d1);
         tcg_gen_movcond_i64(TCG_COND_NE, c2, c2, zero, t2, d2);
-        tcg_gen_qemu_st_i64(c1, addr, memidx, MO_64 | s->be_data);
+        tcg_gen_qemu_st_i64(c1, clean_addr, memidx, MO_64 | s->be_data);
         tcg_gen_qemu_st_i64(c2, a2, memidx, MO_64 | s->be_data);
         tcg_temp_free_i64(a2);
         tcg_temp_free_i64(c1);
@@ -2480,7 +2496,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
     int is_lasr = extract32(insn, 15, 1);
     int o2_L_o1_o0 = extract32(insn, 21, 3) * 2 | is_lasr;
     int size = extract32(insn, 30, 2);
-    TCGv_i64 tcg_addr;
+    TCGv_i64 clean_addr;
 
     switch (o2_L_o1_o0) {
     case 0x0: /* STXR */
@@ -2491,8 +2507,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (is_lasr) {
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
         }
-        tcg_addr = read_cpu_reg_sp(s, rn, 1);
-        gen_store_exclusive(s, rs, rt, rt2, tcg_addr, size, false);
+        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, false);
         return;
 
     case 0x4: /* LDXR */
@@ -2500,9 +2516,9 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (rn == 31) {
             gen_check_sp_alignment(s);
         }
-        tcg_addr = read_cpu_reg_sp(s, rn, 1);
+        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
         s->is_ldex = true;
-        gen_load_exclusive(s, rt, rt2, tcg_addr, size, false);
+        gen_load_exclusive(s, rt, rt2, clean_addr, size, false);
         if (is_lasr) {
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
         }
@@ -2520,8 +2536,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             gen_check_sp_alignment(s);
         }
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        tcg_addr = read_cpu_reg_sp(s, rn, 1);
-        do_gpr_st(s, cpu_reg(s, rt), tcg_addr, size, true, rt,
+        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        do_gpr_st(s, cpu_reg(s, rt), clean_addr, size, true, rt,
                   disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         return;
 
@@ -2536,8 +2552,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (rn == 31) {
             gen_check_sp_alignment(s);
         }
-        tcg_addr = read_cpu_reg_sp(s, rn, 1);
-        do_gpr_ld(s, cpu_reg(s, rt), tcg_addr, size, false, false, true, rt,
+        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, size, false, false, true, rt,
                   disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
         return;
@@ -2550,8 +2566,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             if (is_lasr) {
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
             }
-            tcg_addr = read_cpu_reg_sp(s, rn, 1);
-            gen_store_exclusive(s, rs, rt, rt2, tcg_addr, size, true);
+            clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+            gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, true);
             return;
         }
         if (rt2 == 31
@@ -2568,9 +2584,9 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             if (rn == 31) {
                 gen_check_sp_alignment(s);
             }
-            tcg_addr = read_cpu_reg_sp(s, rn, 1);
+            clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
             s->is_ldex = true;
-            gen_load_exclusive(s, rt, rt2, tcg_addr, size, true);
+            gen_load_exclusive(s, rt, rt2, clean_addr, size, true);
             if (is_lasr) {
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
             }
@@ -2619,7 +2635,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
     int opc = extract32(insn, 30, 2);
     bool is_signed = false;
     int size = 2;
-    TCGv_i64 tcg_rt, tcg_addr;
+    TCGv_i64 tcg_rt, clean_addr;
 
     if (is_vector) {
         if (opc == 3) {
@@ -2641,17 +2657,17 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
 
     tcg_rt = cpu_reg(s, rt);
 
-    tcg_addr = tcg_const_i64((s->pc - 4) + imm);
+    clean_addr = tcg_const_i64((s->pc - 4) + imm);
     if (is_vector) {
-        do_fp_ld(s, rt, tcg_addr, size);
+        do_fp_ld(s, rt, clean_addr, size);
     } else {
         /* Only unsigned 32bit loads target 32bit registers.  */
         bool iss_sf = opc != 0;
 
-        do_gpr_ld(s, tcg_rt, tcg_addr, size, is_signed, false,
+        do_gpr_ld(s, tcg_rt, clean_addr, size, is_signed, false,
                   true, rt, iss_sf, false);
     }
-    tcg_temp_free_i64(tcg_addr);
+    tcg_temp_free_i64(clean_addr);
 }
 
 /*
@@ -2697,7 +2713,8 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     bool postindex = false;
     bool wback = false;
 
-    TCGv_i64 tcg_addr; /* calculated address */
+    TCGv_i64 clean_addr, dirty_addr;
+
     int size;
 
     if (opc == 3) {
@@ -2753,23 +2770,23 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
         gen_check_sp_alignment(s);
     }
 
-    tcg_addr = read_cpu_reg_sp(s, rn, 1);
-
+    dirty_addr = read_cpu_reg_sp(s, rn, 1);
     if (!postindex) {
-        tcg_gen_addi_i64(tcg_addr, tcg_addr, offset);
+        tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     }
+    clean_addr = clean_data_tbi(s, dirty_addr);
 
     if (is_vector) {
         if (is_load) {
-            do_fp_ld(s, rt, tcg_addr, size);
+            do_fp_ld(s, rt, clean_addr, size);
         } else {
-            do_fp_st(s, rt, tcg_addr, size);
+            do_fp_st(s, rt, clean_addr, size);
         }
-        tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
+        tcg_gen_addi_i64(clean_addr, clean_addr, 1 << size);
         if (is_load) {
-            do_fp_ld(s, rt2, tcg_addr, size);
+            do_fp_ld(s, rt2, clean_addr, size);
         } else {
-            do_fp_st(s, rt2, tcg_addr, size);
+            do_fp_st(s, rt2, clean_addr, size);
         }
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
@@ -2781,30 +2798,28 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
             /* Do not modify tcg_rt before recognizing any exception
              * from the second load.
              */
-            do_gpr_ld(s, tmp, tcg_addr, size, is_signed, false,
+            do_gpr_ld(s, tmp, clean_addr, size, is_signed, false,
                       false, 0, false, false);
-            tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
-            do_gpr_ld(s, tcg_rt2, tcg_addr, size, is_signed, false,
+            tcg_gen_addi_i64(clean_addr, clean_addr, 1 << size);
+            do_gpr_ld(s, tcg_rt2, clean_addr, size, is_signed, false,
                       false, 0, false, false);
 
             tcg_gen_mov_i64(tcg_rt, tmp);
             tcg_temp_free_i64(tmp);
         } else {
-            do_gpr_st(s, tcg_rt, tcg_addr, size,
+            do_gpr_st(s, tcg_rt, clean_addr, size,
                       false, 0, false, false);
-            tcg_gen_addi_i64(tcg_addr, tcg_addr, 1 << size);
-            do_gpr_st(s, tcg_rt2, tcg_addr, size,
+            tcg_gen_addi_i64(clean_addr, clean_addr, 1 << size);
+            do_gpr_st(s, tcg_rt2, clean_addr, size,
                       false, 0, false, false);
         }
     }
 
     if (wback) {
         if (postindex) {
-            tcg_gen_addi_i64(tcg_addr, tcg_addr, offset - (1 << size));
-        } else {
-            tcg_gen_subi_i64(tcg_addr, tcg_addr, 1 << size);
+            tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
         }
-        tcg_gen_mov_i64(cpu_reg_sp(s, rn), tcg_addr);
+        tcg_gen_mov_i64(cpu_reg_sp(s, rn), dirty_addr);
     }
 }
 
@@ -2841,7 +2856,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     bool post_index;
     bool writeback;
 
-    TCGv_i64 tcg_addr;
+    TCGv_i64 clean_addr, dirty_addr;
 
     if (is_vector) {
         size |= (opc & 2) << 1;
@@ -2892,17 +2907,18 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    tcg_addr = read_cpu_reg_sp(s, rn, 1);
 
+    dirty_addr = read_cpu_reg_sp(s, rn, 1);
     if (!post_index) {
-        tcg_gen_addi_i64(tcg_addr, tcg_addr, imm9);
+        tcg_gen_addi_i64(dirty_addr, dirty_addr, imm9);
     }
+    clean_addr = clean_data_tbi(s, dirty_addr);
 
     if (is_vector) {
         if (is_store) {
-            do_fp_st(s, rt, tcg_addr, size);
+            do_fp_st(s, rt, clean_addr, size);
         } else {
-            do_fp_ld(s, rt, tcg_addr, size);
+            do_fp_ld(s, rt, clean_addr, size);
         }
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
@@ -2910,10 +2926,10 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
         bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
 
         if (is_store) {
-            do_gpr_st_memidx(s, tcg_rt, tcg_addr, size, memidx,
+            do_gpr_st_memidx(s, tcg_rt, clean_addr, size, memidx,
                              iss_valid, rt, iss_sf, false);
         } else {
-            do_gpr_ld_memidx(s, tcg_rt, tcg_addr, size,
+            do_gpr_ld_memidx(s, tcg_rt, clean_addr, size,
                              is_signed, is_extended, memidx,
                              iss_valid, rt, iss_sf, false);
         }
@@ -2922,9 +2938,9 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     if (writeback) {
         TCGv_i64 tcg_rn = cpu_reg_sp(s, rn);
         if (post_index) {
-            tcg_gen_addi_i64(tcg_addr, tcg_addr, imm9);
+            tcg_gen_addi_i64(dirty_addr, dirty_addr, imm9);
         }
-        tcg_gen_mov_i64(tcg_rn, tcg_addr);
+        tcg_gen_mov_i64(tcg_rn, dirty_addr);
     }
 }
 
@@ -2963,8 +2979,7 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     bool is_store = false;
     bool is_extended = false;
 
-    TCGv_i64 tcg_rm;
-    TCGv_i64 tcg_addr;
+    TCGv_i64 tcg_rm, clean_addr, dirty_addr;
 
     if (extract32(opt, 1, 1) == 0) {
         unallocated_encoding(s);
@@ -2998,27 +3013,28 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    tcg_addr = read_cpu_reg_sp(s, rn, 1);
+    dirty_addr = read_cpu_reg_sp(s, rn, 1);
 
     tcg_rm = read_cpu_reg(s, rm, 1);
     ext_and_shift_reg(tcg_rm, tcg_rm, opt, shift ? size : 0);
 
-    tcg_gen_add_i64(tcg_addr, tcg_addr, tcg_rm);
+    tcg_gen_add_i64(dirty_addr, dirty_addr, tcg_rm);
+    clean_addr = clean_data_tbi(s, dirty_addr);
 
     if (is_vector) {
         if (is_store) {
-            do_fp_st(s, rt, tcg_addr, size);
+            do_fp_st(s, rt, clean_addr, size);
         } else {
-            do_fp_ld(s, rt, tcg_addr, size);
+            do_fp_ld(s, rt, clean_addr, size);
         }
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
         bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
         if (is_store) {
-            do_gpr_st(s, tcg_rt, tcg_addr, size,
+            do_gpr_st(s, tcg_rt, clean_addr, size,
                       true, rt, iss_sf, false);
         } else {
-            do_gpr_ld(s, tcg_rt, tcg_addr, size,
+            do_gpr_ld(s, tcg_rt, clean_addr, size,
                       is_signed, is_extended,
                       true, rt, iss_sf, false);
         }
@@ -3052,7 +3068,7 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
     unsigned int imm12 = extract32(insn, 10, 12);
     unsigned int offset;
 
-    TCGv_i64 tcg_addr;
+    TCGv_i64 clean_addr, dirty_addr;
 
     bool is_store;
     bool is_signed = false;
@@ -3085,24 +3101,25 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    tcg_addr = read_cpu_reg_sp(s, rn, 1);
+    dirty_addr = read_cpu_reg_sp(s, rn, 1);
     offset = imm12 << size;
-    tcg_gen_addi_i64(tcg_addr, tcg_addr, offset);
+    tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+    clean_addr = clean_data_tbi(s, dirty_addr);
 
     if (is_vector) {
         if (is_store) {
-            do_fp_st(s, rt, tcg_addr, size);
+            do_fp_st(s, rt, clean_addr, size);
         } else {
-            do_fp_ld(s, rt, tcg_addr, size);
+            do_fp_ld(s, rt, clean_addr, size);
         }
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
         bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
         if (is_store) {
-            do_gpr_st(s, tcg_rt, tcg_addr, size,
+            do_gpr_st(s, tcg_rt, clean_addr, size,
                       true, rt, iss_sf, false);
         } else {
-            do_gpr_ld(s, tcg_rt, tcg_addr, size, is_signed, is_extended,
+            do_gpr_ld(s, tcg_rt, clean_addr, size, is_signed, is_extended,
                       true, rt, iss_sf, false);
         }
     }
@@ -3128,7 +3145,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     int rs = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int o3_opc = extract32(insn, 12, 4);
-    TCGv_i64 tcg_rn, tcg_rs;
+    TCGv_i64 tcg_rs, clean_addr;
     AtomicThreeOpFn *fn;
 
     if (is_vector || !dc_isar_feature(aa64_atomics, s)) {
@@ -3171,7 +3188,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    tcg_rn = cpu_reg_sp(s, rn);
+    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
     tcg_rs = read_cpu_reg(s, rs, true);
 
     if (o3_opc == 1) { /* LDCLR */
@@ -3181,7 +3198,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     /* The tcg atomic primitives are all full barriers.  Therefore we
      * can ignore the Acquire and Release bits of this instruction.
      */
-    fn(cpu_reg(s, rt), tcg_rn, tcg_rs, get_mem_index(s),
+    fn(cpu_reg(s, rt), clean_addr, tcg_rs, get_mem_index(s),
        s->be_data | size | MO_ALIGN);
 }
 
@@ -3207,7 +3224,7 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
     bool is_wback = extract32(insn, 11, 1);
     bool use_key_a = !extract32(insn, 23, 1);
     int offset;
-    TCGv_i64 tcg_addr, tcg_rt;
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt;
 
     if (size != 3 || is_vector || !dc_isar_feature(aa64_pauth, s)) {
         unallocated_encoding(s);
@@ -3217,29 +3234,31 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    tcg_addr = read_cpu_reg_sp(s, rn, 1);
+    dirty_addr = read_cpu_reg_sp(s, rn, 1);
 
     if (s->pauth_active) {
         if (use_key_a) {
-            gen_helper_autda(tcg_addr, cpu_env, tcg_addr, cpu_X[31]);
+            gen_helper_autda(dirty_addr, cpu_env, dirty_addr, cpu_X[31]);
         } else {
-            gen_helper_autdb(tcg_addr, cpu_env, tcg_addr, cpu_X[31]);
+            gen_helper_autdb(dirty_addr, cpu_env, dirty_addr, cpu_X[31]);
         }
     }
 
     /* Form the 10-bit signed, scaled offset.  */
     offset = (extract32(insn, 22, 1) << 9) | extract32(insn, 12, 9);
     offset = sextract32(offset << size, 0, 10 + size);
-    tcg_gen_addi_i64(tcg_addr, tcg_addr, offset);
+    tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+
+    /* Note that "clean" and "dirty" here refer to TBI not PAC.  */
+    clean_addr = clean_data_tbi(s, dirty_addr);
 
     tcg_rt = cpu_reg(s, rt);
-
-    do_gpr_ld(s, tcg_rt, tcg_addr, size, /* is_signed */ false,
+    do_gpr_ld(s, tcg_rt, clean_addr, size, /* is_signed */ false,
               /* extend */ false, /* iss_valid */ !is_wback,
               /* iss_srt */ rt, /* iss_sf */ true, /* iss_ar */ false);
 
     if (is_wback) {
-        tcg_gen_mov_i64(cpu_reg_sp(s, rn), tcg_addr);
+        tcg_gen_mov_i64(cpu_reg_sp(s, rn), dirty_addr);
     }
 }
 
@@ -3308,7 +3327,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     bool is_store = !extract32(insn, 22, 1);
     bool is_postidx = extract32(insn, 23, 1);
     bool is_q = extract32(insn, 30, 1);
-    TCGv_i64 tcg_addr, tcg_rn, tcg_ebytes;
+    TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
     TCGMemOp endian = s->be_data;
 
     int ebytes;   /* bytes per element */
@@ -3391,8 +3410,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     elements = (is_q ? 16 : 8) / ebytes;
 
     tcg_rn = cpu_reg_sp(s, rn);
-    tcg_addr = tcg_temp_new_i64();
-    tcg_gen_mov_i64(tcg_addr, tcg_rn);
+    clean_addr = clean_data_tbi(s, tcg_rn);
     tcg_ebytes = tcg_const_i64(ebytes);
 
     for (r = 0; r < rpt; r++) {
@@ -3402,14 +3420,15 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
             for (xs = 0; xs < selem; xs++) {
                 int tt = (rt + r + xs) % 32;
                 if (is_store) {
-                    do_vec_st(s, tt, e, tcg_addr, size, endian);
+                    do_vec_st(s, tt, e, clean_addr, size, endian);
                 } else {
-                    do_vec_ld(s, tt, e, tcg_addr, size, endian);
+                    do_vec_ld(s, tt, e, clean_addr, size, endian);
                 }
-                tcg_gen_add_i64(tcg_addr, tcg_addr, tcg_ebytes);
+                tcg_gen_add_i64(clean_addr, clean_addr, tcg_ebytes);
             }
         }
     }
+    tcg_temp_free_i64(tcg_ebytes);
 
     if (!is_store) {
         /* For non-quad operations, setting a slice of the low
@@ -3427,13 +3446,11 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
 
     if (is_postidx) {
         if (rm == 31) {
-            tcg_gen_mov_i64(tcg_rn, tcg_addr);
+            tcg_gen_addi_i64(tcg_rn, tcg_rn, rpt * elements * selem * ebytes);
         } else {
             tcg_gen_add_i64(tcg_rn, tcg_rn, cpu_reg(s, rm));
         }
     }
-    tcg_temp_free_i64(tcg_ebytes);
-    tcg_temp_free_i64(tcg_addr);
 }
 
 /* AdvSIMD load/store single structure
@@ -3476,7 +3493,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     bool replicate = false;
     int index = is_q << 3 | S << 2 | size;
     int ebytes, xs;
-    TCGv_i64 tcg_addr, tcg_rn, tcg_ebytes;
+    TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
 
     if (extract32(insn, 31, 1)) {
         unallocated_encoding(s);
@@ -3536,8 +3553,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     }
 
     tcg_rn = cpu_reg_sp(s, rn);
-    tcg_addr = tcg_temp_new_i64();
-    tcg_gen_mov_i64(tcg_addr, tcg_rn);
+    clean_addr = clean_data_tbi(s, tcg_rn);
     tcg_ebytes = tcg_const_i64(ebytes);
 
     for (xs = 0; xs < selem; xs++) {
@@ -3545,7 +3561,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
             /* Load and replicate to all elements */
             TCGv_i64 tcg_tmp = tcg_temp_new_i64();
 
-            tcg_gen_qemu_ld_i64(tcg_tmp, tcg_addr,
+            tcg_gen_qemu_ld_i64(tcg_tmp, clean_addr,
                                 get_mem_index(s), s->be_data + scale);
             tcg_gen_gvec_dup_i64(scale, vec_full_reg_offset(s, rt),
                                  (is_q + 1) * 8, vec_full_reg_size(s),
@@ -3554,24 +3570,23 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
         } else {
             /* Load/store one element per register */
             if (is_load) {
-                do_vec_ld(s, rt, index, tcg_addr, scale, s->be_data);
+                do_vec_ld(s, rt, index, clean_addr, scale, s->be_data);
             } else {
-                do_vec_st(s, rt, index, tcg_addr, scale, s->be_data);
+                do_vec_st(s, rt, index, clean_addr, scale, s->be_data);
             }
         }
-        tcg_gen_add_i64(tcg_addr, tcg_addr, tcg_ebytes);
+        tcg_gen_add_i64(clean_addr, clean_addr, tcg_ebytes);
         rt = (rt + 1) % 32;
     }
+    tcg_temp_free_i64(tcg_ebytes);
 
     if (is_postidx) {
         if (rm == 31) {
-            tcg_gen_mov_i64(tcg_rn, tcg_addr);
+            tcg_gen_addi_i64(tcg_rn, tcg_rn, selem * ebytes);
         } else {
             tcg_gen_add_i64(tcg_rn, tcg_rn, cpu_reg(s, rm));
         }
     }
-    tcg_temp_free_i64(tcg_ebytes);
-    tcg_temp_free_i64(tcg_addr);
 }
 
 /* Loads and stores */
-- 
2.17.2
