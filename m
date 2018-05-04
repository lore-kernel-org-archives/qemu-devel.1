Received: from eggs.gnu.org ([2001:4830:134:3::10]:38331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSU-0008SJ-KO
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETST-0004kp-3w
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:42 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:42286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fETSS-0004jj-SH
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:41 -0400
Received: by mail-pg0-x243.google.com with SMTP id p9-v6so11817998pgc.9
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 22:40:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  3 May 2018 22:40:22 -0700
Message-Id: <20180504054030.24527-6-richard.henderson@linaro.org>
In-Reply-To: <20180504054030.24527-1-richard.henderson@linaro.org>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/13] target/openrisc: Convert remainder of
 dec_misc insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c  | 279 +++++++++++++++++++------------------------
 target/openrisc/insns.decode |  35 +++++-
 2 files changed, 151 insertions(+), 163 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 794002aaaa..0100fbc460 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -829,174 +829,118 @@ static bool trans_l_sh(DisasContext *dc, arg_store *a, uint32_t insn)
     return true;
 }
 
-static void dec_misc(DisasContext *dc, uint32_t insn)
+static bool trans_l_nop(DisasContext *dc, arg_l_nop *a, uint32_t insn)
+{
+    LOG_DIS("l.nop %d\n", a->k);
+    return true;
+}
+
+static bool trans_l_addi(DisasContext *dc, arg_rri *a, uint32_t insn)
 {
-    uint32_t op0, op1;
-    uint32_t ra, rb, rd;
-    uint32_t L6, K5, K16, K5_11;
-    int32_t I16;
     TCGv t0;
 
-    op0 = extract32(insn, 26, 6);
-    op1 = extract32(insn, 24, 2);
-    ra = extract32(insn, 16, 5);
-    rb = extract32(insn, 11, 5);
-    rd = extract32(insn, 21, 5);
-    L6 = extract32(insn, 5, 6);
-    K5 = extract32(insn, 0, 5);
-    K16 = extract32(insn, 0, 16);
-    I16 = (int16_t)K16;
-    K5_11 = (extract32(insn, 21, 5) << 11) | extract32(insn, 0, 11);
+    LOG_DIS("l.addi r%d, r%d, %d\n", a->d, a->a, a->i);
+    check_r0_write(a->d);
+    t0 = tcg_const_tl(a->i);
+    gen_add(dc, cpu_R[a->d], cpu_R[a->a], t0);
+    tcg_temp_free(t0);
+    return true;
+}
 
-    switch (op0) {
-    case 0x05:
-        switch (op1) {
-        case 0x01:    /* l.nop */
-            LOG_DIS("l.nop %d\n", I16);
-            break;
+static bool trans_l_addic(DisasContext *dc, arg_rri *a, uint32_t insn)
+{
+    TCGv t0;
 
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
+    LOG_DIS("l.addic r%d, r%d, %d\n", a->d, a->a, a->i);
+    check_r0_write(a->d);
+    t0 = tcg_const_tl(a->i);
+    gen_addc(dc, cpu_R[a->d], cpu_R[a->a], t0);
+    tcg_temp_free(t0);
+    return true;
+}
 
-    case 0x13:    /* l.maci */
-        LOG_DIS("l.maci r%d, %d\n", ra, I16);
-        t0 = tcg_const_tl(I16);
-        gen_mac(dc, cpu_R[ra], t0);
-        tcg_temp_free(t0);
-        break;
+static bool trans_l_muli(DisasContext *dc, arg_rri *a, uint32_t insn)
+{
+    TCGv t0;
 
-    case 0x09:    /* l.rfe */
-        LOG_DIS("l.rfe\n");
-        {
-#if defined(CONFIG_USER_ONLY)
-            return;
+    LOG_DIS("l.muli r%d, r%d, %d\n", a->d, a->a, a->i);
+    check_r0_write(a->d);
+    t0 = tcg_const_tl(a->i);
+    gen_mul(dc, cpu_R[a->d], cpu_R[a->a], t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_l_maci(DisasContext *dc, arg_l_maci *a, uint32_t insn)
+{
+    TCGv t0;
+
+    LOG_DIS("l.maci r%d, %d\n", a->a, a->i);
+    t0 = tcg_const_tl(a->i);
+    gen_mac(dc, cpu_R[a->a], t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_l_andi(DisasContext *dc, arg_rrk *a, uint32_t insn)
+{
+    LOG_DIS("l.andi r%d, r%d, %d\n", a->d, a->a, a->k);
+    check_r0_write(a->d);
+    tcg_gen_andi_tl(cpu_R[a->d], cpu_R[a->a], a->k);
+    return true;
+}
+
+static bool trans_l_ori(DisasContext *dc, arg_rrk *a, uint32_t insn)
+{
+    LOG_DIS("l.ori r%d, r%d, %d\n", a->d, a->a, a->k);
+    check_r0_write(a->d);
+    tcg_gen_ori_tl(cpu_R[a->d], cpu_R[a->a], a->k);
+    return true;
+}
+
+static bool trans_l_xori(DisasContext *dc, arg_rri *a, uint32_t insn)
+{
+    LOG_DIS("l.xori r%d, r%d, %d\n", a->d, a->a, a->i);
+    check_r0_write(a->d);
+    tcg_gen_xori_tl(cpu_R[a->d], cpu_R[a->a], a->i);
+    return true;
+}
+
+static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a, uint32_t insn)
+{
+    LOG_DIS("l.mfspr r%d, r%d, %d\n", a->d, a->a, a->k);
+    check_r0_write(a->d);
+
+#ifdef CONFIG_USER_ONLY
+    gen_illegal_exception(dc);
 #else
-            if (dc->mem_idx == MMU_USER_IDX) {
-                gen_illegal_exception(dc);
-                return;
-            }
-            gen_helper_rfe(cpu_env);
-            dc->is_jmp = DISAS_UPDATE;
-#endif
-        }
-        break;
-
-    case 0x1c:    /* l.cust1 */
-        LOG_DIS("l.cust1\n");
-        break;
-
-    case 0x1d:    /* l.cust2 */
-        LOG_DIS("l.cust2\n");
-        break;
-
-    case 0x1e:    /* l.cust3 */
-        LOG_DIS("l.cust3\n");
-        break;
-
-    case 0x1f:    /* l.cust4 */
-        LOG_DIS("l.cust4\n");
-        break;
-
-    case 0x3c:    /* l.cust5 */
-        LOG_DIS("l.cust5 r%d, r%d, r%d, %d, %d\n", rd, ra, rb, L6, K5);
-        break;
-
-    case 0x3d:    /* l.cust6 */
-        LOG_DIS("l.cust6\n");
-        break;
-
-    case 0x3e:    /* l.cust7 */
-        LOG_DIS("l.cust7\n");
-        break;
-
-    case 0x3f:    /* l.cust8 */
-        LOG_DIS("l.cust8\n");
-        break;
-
-    case 0x27:    /* l.addi */
-        LOG_DIS("l.addi r%d, r%d, %d\n", rd, ra, I16);
-        check_r0_write(rd);
-        t0 = tcg_const_tl(I16);
-        gen_add(dc, cpu_R[rd], cpu_R[ra], t0);
-        tcg_temp_free(t0);
-        break;
-
-    case 0x28:    /* l.addic */
-        LOG_DIS("l.addic r%d, r%d, %d\n", rd, ra, I16);
-        check_r0_write(rd);
-        t0 = tcg_const_tl(I16);
-        gen_addc(dc, cpu_R[rd], cpu_R[ra], t0);
-        tcg_temp_free(t0);
-        break;
-
-    case 0x29:    /* l.andi */
-        LOG_DIS("l.andi r%d, r%d, %d\n", rd, ra, K16);
-        check_r0_write(rd);
-        tcg_gen_andi_tl(cpu_R[rd], cpu_R[ra], K16);
-        break;
-
-    case 0x2a:    /* l.ori */
-        LOG_DIS("l.ori r%d, r%d, %d\n", rd, ra, K16);
-        check_r0_write(rd);
-        tcg_gen_ori_tl(cpu_R[rd], cpu_R[ra], K16);
-        break;
-
-    case 0x2b:    /* l.xori */
-        LOG_DIS("l.xori r%d, r%d, %d\n", rd, ra, I16);
-        check_r0_write(rd);
-        tcg_gen_xori_tl(cpu_R[rd], cpu_R[ra], I16);
-        break;
-
-    case 0x2c:    /* l.muli */
-        LOG_DIS("l.muli r%d, r%d, %d\n", rd, ra, I16);
-        check_r0_write(rd);
-        t0 = tcg_const_tl(I16);
-        gen_mul(dc, cpu_R[rd], cpu_R[ra], t0);
-        tcg_temp_free(t0);
-        break;
-
-    case 0x2d:    /* l.mfspr */
-        LOG_DIS("l.mfspr r%d, r%d, %d\n", rd, ra, K16);
-        check_r0_write(rd);
-        {
-#if defined(CONFIG_USER_ONLY)
-            return;
-#else
-            TCGv_i32 ti = tcg_const_i32(K16);
-            if (dc->mem_idx == MMU_USER_IDX) {
-                gen_illegal_exception(dc);
-                return;
-            }
-            gen_helper_mfspr(cpu_R[rd], cpu_env, cpu_R[rd], cpu_R[ra], ti);
-            tcg_temp_free_i32(ti);
-#endif
-        }
-        break;
-
-    case 0x30:    /* l.mtspr */
-        LOG_DIS("l.mtspr r%d, r%d, %d\n", ra, rb, K5_11);
-        {
-#if defined(CONFIG_USER_ONLY)
-            return;
-#else
-            TCGv_i32 im = tcg_const_i32(K5_11);
-            if (dc->mem_idx == MMU_USER_IDX) {
-                gen_illegal_exception(dc);
-                return;
-            }
-            gen_helper_mtspr(cpu_env, cpu_R[ra], cpu_R[rb], im);
-            tcg_temp_free_i32(im);
-#endif
-        }
-        break;
-
-    default:
+    if (dc->mem_idx == MMU_USER_IDX) {
         gen_illegal_exception(dc);
-        break;
+    } else {
+        TCGv_i32 ti = tcg_const_i32(a->k);
+        gen_helper_mfspr(cpu_R[a->d], cpu_env, cpu_R[a->d], cpu_R[a->a], ti);
+        tcg_temp_free_i32(ti);
     }
+#endif
+    return true;
+}
+
+static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
+{
+    LOG_DIS("l.mtspr r%d, r%d, %d\n", a->a, a->b, a->k);
+
+#ifdef CONFIG_USER_ONLY
+    gen_illegal_exception(dc);
+#else
+    if (dc->mem_idx == MMU_USER_IDX) {
+        gen_illegal_exception(dc);
+    } else {
+        TCGv_i32 ti = tcg_const_i32(a->k);
+        gen_helper_mtspr(cpu_env, cpu_R[a->a], cpu_R[a->b], ti);
+        tcg_temp_free_i32(ti);
+    }
+#endif
+    return true;
 }
 
 static void dec_mac(DisasContext *dc, uint32_t insn)
@@ -1272,6 +1216,23 @@ static bool trans_l_csync(DisasContext *dc, arg_l_csync *a, uint32_t insn)
     return true;
 }
 
+static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a, uint32_t insn)
+{
+    LOG_DIS("l.rfe\n");
+
+#ifdef CONFIG_USER_ONLY
+    gen_illegal_exception(dc);
+#else
+    if (dc->mem_idx == MMU_USER_IDX) {
+        gen_illegal_exception(dc);
+    } else {
+        gen_helper_rfe(cpu_env);
+        dc->is_jmp = DISAS_UPDATE;
+    }
+#endif
+    return true;
+}
+
 static void dec_float(DisasContext *dc, uint32_t insn)
 {
     uint32_t op0;
@@ -1534,7 +1495,7 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
         break;
 
     default:
-        dec_misc(dc, insn);
+        gen_illegal_exception(dc);
         break;
     }
 }
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index ba5356abe1..247a2e14f2 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -27,6 +27,8 @@ l_msync         001000 1000000000 00000000 00000000
 l_psync         001000 1010000000 00000000 00000000
 l_csync         001000 1100000000 00000000 00000000
 
+l_rfe		001001 ----- ----- -------- --------
+
 ####
 # Branch Instructions
 ####
@@ -58,7 +60,32 @@ l_lbs           100100 ..... ..... ........ ........    @load
 l_lhz           100101 ..... ..... ........ ........    @load
 l_lhs           100110 ..... ..... ........ ........    @load
 
-l_swa           110011 ..... ..... ........ ........    @store
-l_sw            110101 ..... ..... ........ ........    @store
-l_sb            110110 ..... ..... ........ ........    @store
-l_sh            110111 ..... ..... ........ ........    @store
+l_swa		110011 ..... ..... ..... ...........	@store
+l_sw		110101 ..... ..... ..... ...........	@store
+l_sb		110110 ..... ..... ..... ...........	@store
+l_sh		110111 ..... ..... ..... ...........	@store
+
+####
+# Immediate Operand Instructions
+####
+
+%mtspr_k	21:5 0:11
+
+&rri		d a i
+&rrk		d a k
+@rri		...... d:5 a:5 i:s16			&rri
+@rrk		...... d:5 a:5 k:16			&rrk
+
+l_nop		000101 01--- ----- k:16
+
+l_addi		100111 ..... ..... ........ ........	@rri
+l_addic		101000 ..... ..... ........ ........	@rri
+l_andi		101001 ..... ..... ........ ........	@rrk
+l_ori		101010 ..... ..... ........ ........	@rrk
+l_xori		101011 ..... ..... ........ ........	@rri
+l_muli		101100 ..... ..... ........ ........	@rri
+
+l_mfspr		101101 ..... ..... ........ ........	@rrk
+l_mtspr		110000 ..... a:5 b:5 ...........	k=%mtspr_k
+
+l_maci		010011 ----- a:5 i:s16
-- 
2.14.3
