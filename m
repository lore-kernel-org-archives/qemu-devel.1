Received: from eggs.gnu.org ([209.51.188.92]:38264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOJ-0005Ue-TH
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOH-0004fO-0R
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:35 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:44742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOE-0004Qm-M2
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id p4so320872plq.11
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:39 -0800
Message-Id: <20190211235258.542-10-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 09/28] target/arm: Suppress tag check for
 sp+offset
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

R0078 specifies that base register, or base register plus immediate
offset, is unchecked when the base register is SP.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Include writeback addresses as checked.
---
 target/arm/translate-a64.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1465c52a05..27ceea66d1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -340,11 +340,11 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
  * This is always a fresh temporary, as we need to be able to
  * increment this independently of a dirty write-back address.
  */
-static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
+static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr, bool check)
 {
     TCGv_i64 clean = new_tmp_a64(s);
 
-    if (s->mte_active) {
+    if (check && s->mte_active) {
         if (s->current_el >= 2) {
             /* FIXME: ARMv8.1-VHE S2 translation regime.  */
             gen_helper_mte_check1(clean, cpu_env, addr);
@@ -2385,7 +2385,7 @@ static void gen_compare_and_swap(DisasContext *s, int rs, int rt,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn), rn != 31);
     tcg_gen_atomic_cmpxchg_i64(tcg_rs, clean_addr, tcg_rs, tcg_rt, memidx,
                                size | MO_ALIGN | s->be_data);
 }
@@ -2403,7 +2403,7 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn), rn != 31);
 
     if (size == 2) {
         TCGv_i64 cmp = tcg_temp_new_i64();
@@ -2528,7 +2528,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (is_lasr) {
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
         }
-        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn), rn != 31);
         gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, false);
         return;
 
@@ -2537,7 +2537,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (rn == 31) {
             gen_check_sp_alignment(s);
         }
-        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn), rn != 31);
         s->is_ldex = true;
         gen_load_exclusive(s, rt, rt2, clean_addr, size, false);
         if (is_lasr) {
@@ -2557,7 +2557,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             gen_check_sp_alignment(s);
         }
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn), rn != 31);
         do_gpr_st(s, cpu_reg(s, rt), clean_addr, size, true, rt,
                   disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         return;
@@ -2573,7 +2573,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (rn == 31) {
             gen_check_sp_alignment(s);
         }
-        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn), rn != 31);
         do_gpr_ld(s, cpu_reg(s, rt), clean_addr, size, false, false, true, rt,
                   disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
@@ -2587,7 +2587,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             if (is_lasr) {
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
             }
-            clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+            clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn), rn != 31);
             gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, true);
             return;
         }
@@ -2605,7 +2605,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             if (rn == 31) {
                 gen_check_sp_alignment(s);
             }
-            clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+            clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn), rn != 31);
             s->is_ldex = true;
             gen_load_exclusive(s, rt, rt2, clean_addr, size, true);
             if (is_lasr) {
@@ -2795,7 +2795,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     if (!postindex) {
         tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     }
-    clean_addr = clean_data_tbi(s, dirty_addr);
+    clean_addr = clean_data_tbi(s, dirty_addr, wback || rn != 31);
 
     if (is_vector) {
         if (is_load) {
@@ -2933,7 +2933,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     if (!post_index) {
         tcg_gen_addi_i64(dirty_addr, dirty_addr, imm9);
     }
-    clean_addr = clean_data_tbi(s, dirty_addr);
+    clean_addr = clean_data_tbi(s, dirty_addr, writeback || rn != 31);
 
     if (is_vector) {
         if (is_store) {
@@ -3040,7 +3040,7 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     ext_and_shift_reg(tcg_rm, tcg_rm, opt, shift ? size : 0);
 
     tcg_gen_add_i64(dirty_addr, dirty_addr, tcg_rm);
-    clean_addr = clean_data_tbi(s, dirty_addr);
+    clean_addr = clean_data_tbi(s, dirty_addr, true);
 
     if (is_vector) {
         if (is_store) {
@@ -3125,7 +3125,7 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
     dirty_addr = read_cpu_reg_sp(s, rn, 1);
     offset = imm12 << size;
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
-    clean_addr = clean_data_tbi(s, dirty_addr);
+    clean_addr = clean_data_tbi(s, dirty_addr, rn != 31);
 
     if (is_vector) {
         if (is_store) {
@@ -3209,7 +3209,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn), rn != 31);
     tcg_rs = read_cpu_reg(s, rs, true);
 
     if (o3_opc == 1) { /* LDCLR */
@@ -3271,7 +3271,7 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
 
     /* Note that "clean" and "dirty" here refer to TBI not PAC.  */
-    clean_addr = clean_data_tbi(s, dirty_addr);
+    clean_addr = clean_data_tbi(s, dirty_addr, is_wback || rn != 31);
 
     tcg_rt = cpu_reg(s, rt);
     do_gpr_ld(s, tcg_rt, clean_addr, size, /* is_signed */ false,
@@ -3431,7 +3431,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     elements = (is_q ? 16 : 8) / ebytes;
 
     tcg_rn = cpu_reg_sp(s, rn);
-    clean_addr = clean_data_tbi(s, tcg_rn);
+    clean_addr = clean_data_tbi(s, tcg_rn, is_postidx || rn != 31);
     tcg_ebytes = tcg_const_i64(ebytes);
 
     for (r = 0; r < rpt; r++) {
@@ -3574,7 +3574,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     }
 
     tcg_rn = cpu_reg_sp(s, rn);
-    clean_addr = clean_data_tbi(s, tcg_rn);
+    clean_addr = clean_data_tbi(s, tcg_rn, is_postidx || rn != 31);
     tcg_ebytes = tcg_const_i64(ebytes);
 
     for (xs = 0; xs < selem; xs++) {
-- 
2.17.2
