Received: from eggs.gnu.org ([2001:4830:134:3::10]:38024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgiZ-0002Ax-7t
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgiX-0007kX-BZ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:27 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:32906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbgiX-0007kL-3R
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:25 -0500
Received: by mail-pf0-x244.google.com with SMTP id e4so12916722pfg.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 20:52:24 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:39 -0800
Message-Id: <20170209045154.16868-8-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 07/22] target/openrisc: Rationalize immediate
 extraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

The architecture manual is consistent in using "I" for signed
fields and "K" for unsigned fields.  Mirror that.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/translate.c | 98 ++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 58 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ac0c409..d999d2f 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -129,23 +129,6 @@ static inline void wb_SR_F(void)
     gen_set_label(label);
 }
 
-static inline int zero_extend(unsigned int val, int width)
-{
-    return val & ((1 << width) - 1);
-}
-
-static inline int sign_extend(unsigned int val, int width)
-{
-    int sval;
-
-    /* LSL */
-    val <<= TARGET_LONG_BITS - width;
-    sval = val;
-    /* ASR.  */
-    sval >>= TARGET_LONG_BITS - width;
-    return sval;
-}
-
 static inline void gen_sync_flags(DisasContext *dc)
 {
     /* Sync the tb dependent flag between translate and runtime.  */
@@ -221,11 +204,9 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
     }
 }
 
-static void gen_jump(DisasContext *dc, uint32_t imm, uint32_t reg, uint32_t op0)
+static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
 {
-    target_ulong tmp_pc;
-    /* N26, 26bits imm */
-    tmp_pc = sign_extend((imm<<2), 26) + dc->pc;
+    target_ulong tmp_pc = dc->pc + n26 * 4;
 
     switch (op0) {
     case 0x00:     /* l.j */
@@ -760,8 +741,8 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
 {
     uint32_t op0, op1;
     uint32_t ra, rb, rd;
-    uint32_t L6, K5;
-    uint32_t I16, I5, I11, N26, tmp;
+    uint32_t L6, K5, K16, K5_11;
+    int32_t I16, I5_11, N26;
     TCGMemOp mop;
 
     op0 = extract32(insn, 26, 6);
@@ -771,11 +752,11 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
     rd = extract32(insn, 21, 5);
     L6 = extract32(insn, 5, 6);
     K5 = extract32(insn, 0, 5);
-    I16 = extract32(insn, 0, 16);
-    I5 = extract32(insn, 21, 5);
-    I11 = extract32(insn, 0, 11);
-    N26 = extract32(insn, 0, 26);
-    tmp = (I5<<11) + I11;
+    K16 = extract32(insn, 0, 16);
+    I16 = (int16_t)K16;
+    N26 = sextract32(insn, 0, 26);
+    K5_11 = (extract32(insn, 21, 5) << 11) | extract32(insn, 0, 11);
+    I5_11 = (int16_t)K5_11;
 
     switch (op0) {
     case 0x00:    /* l.j */
@@ -821,12 +802,12 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         break;
 
     case 0x13:    /* l.maci */
-        LOG_DIS("l.maci %d, r%d, %d\n", I5, ra, I11);
+        LOG_DIS("l.maci r%d, %d\n", ra, I16);
         {
             TCGv_i64 t1 = tcg_temp_new_i64();
             TCGv_i64 t2 = tcg_temp_new_i64();
             TCGv_i32 dst = tcg_temp_new_i32();
-            TCGv ttmp = tcg_const_tl(tmp);
+            TCGv ttmp = tcg_const_tl(I16);
             tcg_gen_mul_tl(dst, cpu_R[ra], ttmp);
             tcg_gen_ext_i32_i64(t1, dst);
             tcg_gen_concat_i32_i64(t2, maclo, machi);
@@ -936,7 +917,7 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
     do_load:
         {
             TCGv t0 = tcg_temp_new();
-            tcg_gen_addi_tl(t0, cpu_R[ra], sign_extend(I16, 16));
+            tcg_gen_addi_tl(t0, cpu_R[ra], I16);
             tcg_gen_qemu_ld_tl(cpu_R[rd], t0, dc->mem_idx, mop);
             tcg_temp_free(t0);
         }
@@ -954,7 +935,7 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
                 TCGv_i32 res = tcg_temp_local_new_i32();
                 TCGv_i32 sr_ove = tcg_temp_local_new_i32();
                 tcg_gen_extu_i32_i64(ta, cpu_R[ra]);
-                tcg_gen_addi_i64(td, ta, sign_extend(I16, 16));
+                tcg_gen_addi_i64(td, ta, I16);
                 tcg_gen_extrl_i64_i32(res, td);
                 tcg_gen_shri_i64(td, td, 32);
                 tcg_gen_andi_i64(td, td, 0x3);
@@ -989,7 +970,7 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
             tcg_gen_andi_i32(sr_cy, cpu_sr, SR_CY);
             tcg_gen_shri_i32(sr_cy, sr_cy, 10);
             tcg_gen_extu_i32_i64(tcy, sr_cy);
-            tcg_gen_addi_i64(td, ta, sign_extend(I16, 16));
+            tcg_gen_addi_i64(td, ta, I16);
             tcg_gen_add_i64(td, td, tcy);
             tcg_gen_extrl_i64_i32(res, td);
             tcg_gen_shri_i64(td, td, 32);
@@ -1013,18 +994,18 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         break;
 
     case 0x29:    /* l.andi */
-        LOG_DIS("l.andi r%d, r%d, %d\n", rd, ra, I16);
-        tcg_gen_andi_tl(cpu_R[rd], cpu_R[ra], zero_extend(I16, 16));
+        LOG_DIS("l.andi r%d, r%d, %d\n", rd, ra, K16);
+        tcg_gen_andi_tl(cpu_R[rd], cpu_R[ra], K16);
         break;
 
     case 0x2a:    /* l.ori */
-        LOG_DIS("l.ori r%d, r%d, %d\n", rd, ra, I16);
-        tcg_gen_ori_tl(cpu_R[rd], cpu_R[ra], zero_extend(I16, 16));
+        LOG_DIS("l.ori r%d, r%d, %d\n", rd, ra, K16);
+        tcg_gen_ori_tl(cpu_R[rd], cpu_R[ra], K16);
         break;
 
     case 0x2b:    /* l.xori */
         LOG_DIS("l.xori r%d, r%d, %d\n", rd, ra, I16);
-        tcg_gen_xori_tl(cpu_R[rd], cpu_R[ra], sign_extend(I16, 16));
+        tcg_gen_xori_tl(cpu_R[rd], cpu_R[ra], I16);
         break;
 
     case 0x2c:    /* l.muli */
@@ -1039,12 +1020,12 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         break;
 
     case 0x2d:    /* l.mfspr */
-        LOG_DIS("l.mfspr r%d, r%d, %d\n", rd, ra, I16);
+        LOG_DIS("l.mfspr r%d, r%d, %d\n", rd, ra, K16);
         {
 #if defined(CONFIG_USER_ONLY)
             return;
 #else
-            TCGv_i32 ti = tcg_const_i32(I16);
+            TCGv_i32 ti = tcg_const_i32(K16);
             if (dc->mem_idx == MMU_USER_IDX) {
                 gen_illegal_exception(dc);
                 return;
@@ -1056,12 +1037,12 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         break;
 
     case 0x30:    /* l.mtspr */
-        LOG_DIS("l.mtspr %d, r%d, r%d, %d\n", I5, ra, rb, I11);
+        LOG_DIS("l.mtspr r%d, r%d, %d\n", ra, rb, K5_11);
         {
 #if defined(CONFIG_USER_ONLY)
             return;
 #else
-            TCGv_i32 im = tcg_const_i32(tmp);
+            TCGv_i32 im = tcg_const_i32(K5_11);
             if (dc->mem_idx == MMU_USER_IDX) {
                 gen_illegal_exception(dc);
                 return;
@@ -1073,38 +1054,38 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         break;
 
     case 0x33: /* l.swa */
-        LOG_DIS("l.swa %d, r%d, r%d, %d\n", I5, ra, rb, I11);
-        gen_swa(dc, cpu_R[rb], cpu_R[ra], sign_extend(tmp, 16));
+        LOG_DIS("l.swa r%d, r%d, %d\n", ra, rb, I5_11);
+        gen_swa(dc, cpu_R[rb], cpu_R[ra], I5_11);
         break;
 
 /* not used yet, open it when we need or64.  */
 /*#ifdef TARGET_OPENRISC64
     case 0x34:     l.sd
-        LOG_DIS("l.sd %d, r%d, r%d, %d\n", I5, ra, rb, I11);
+        LOG_DIS("l.sd r%d, r%d, %d\n", ra, rb, I5_11);
         check_ob64s(dc);
         mop = MO_TEQ;
         goto do_store;
 #endif*/
 
     case 0x35:    /* l.sw */
-        LOG_DIS("l.sw %d, r%d, r%d, %d\n", I5, ra, rb, I11);
+        LOG_DIS("l.sw r%d, r%d, %d\n", ra, rb, I5_11);
         mop = MO_TEUL;
         goto do_store;
 
     case 0x36:    /* l.sb */
-        LOG_DIS("l.sb %d, r%d, r%d, %d\n", I5, ra, rb, I11);
+        LOG_DIS("l.sb r%d, r%d, %d\n", ra, rb, I5_11);
         mop = MO_UB;
         goto do_store;
 
     case 0x37:    /* l.sh */
-        LOG_DIS("l.sh %d, r%d, r%d, %d\n", I5, ra, rb, I11);
+        LOG_DIS("l.sh r%d, r%d, %d\n", ra, rb, I5_11);
         mop = MO_TEUW;
         goto do_store;
 
     do_store:
         {
             TCGv t0 = tcg_temp_new();
-            tcg_gen_addi_tl(t0, cpu_R[ra], sign_extend(tmp, 16));
+            tcg_gen_addi_tl(t0, cpu_R[ra], I5_11);
             tcg_gen_qemu_st_tl(cpu_R[rb], t0, dc->mem_idx, mop);
             tcg_temp_free(t0);
         }
@@ -1172,30 +1153,32 @@ static void dec_mac(DisasContext *dc, uint32_t insn)
 static void dec_logic(DisasContext *dc, uint32_t insn)
 {
     uint32_t op0;
-    uint32_t rd, ra, L6;
+    uint32_t rd, ra, L6, S6;
     op0 = extract32(insn, 6, 2);
     rd = extract32(insn, 21, 5);
     ra = extract32(insn, 16, 5);
     L6 = extract32(insn, 0, 6);
+    S6 = L6 & (TARGET_LONG_BITS - 1);
 
     switch (op0) {
     case 0x00:    /* l.slli */
         LOG_DIS("l.slli r%d, r%d, %d\n", rd, ra, L6);
-        tcg_gen_shli_tl(cpu_R[rd], cpu_R[ra], (L6 & 0x1f));
+        tcg_gen_shli_tl(cpu_R[rd], cpu_R[ra], S6);
         break;
 
     case 0x01:    /* l.srli */
         LOG_DIS("l.srli r%d, r%d, %d\n", rd, ra, L6);
-        tcg_gen_shri_tl(cpu_R[rd], cpu_R[ra], (L6 & 0x1f));
+        tcg_gen_shri_tl(cpu_R[rd], cpu_R[ra], S6);
         break;
 
     case 0x02:    /* l.srai */
         LOG_DIS("l.srai r%d, r%d, %d\n", rd, ra, L6);
-        tcg_gen_sari_tl(cpu_R[rd], cpu_R[ra], (L6 & 0x1f)); break;
+        tcg_gen_sari_tl(cpu_R[rd], cpu_R[ra], S6);
+        break;
 
     case 0x03:    /* l.rori */
         LOG_DIS("l.rori r%d, r%d, %d\n", rd, ra, L6);
-        tcg_gen_rotri_tl(cpu_R[rd], cpu_R[ra], (L6 & 0x1f));
+        tcg_gen_rotri_tl(cpu_R[rd], cpu_R[ra], S6);
         break;
 
     default:
@@ -1306,15 +1289,14 @@ static void dec_comp(DisasContext *dc, uint32_t insn)
 
 static void dec_compi(DisasContext *dc, uint32_t insn)
 {
-    uint32_t op0;
-    uint32_t ra, I16;
+    uint32_t op0, ra;
+    int32_t I16;
 
     op0 = extract32(insn, 21, 5);
     ra = extract32(insn, 16, 5);
-    I16 = extract32(insn, 0, 16);
+    I16 = sextract32(insn, 0, 16);
 
     tcg_gen_movi_i32(env_btaken, 0x0);
-    I16 = sign_extend(I16, 16);
 
     switch (op0) {
     case 0x0:    /* l.sfeqi */
-- 
2.9.3
