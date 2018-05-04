Received: from eggs.gnu.org ([2001:4830:134:3::10]:38319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETST-0008RT-LK
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSR-0004if-Lr
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:41 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:40427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fETSR-0004hk-Ce
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:39 -0400
Received: by mail-pf0-x243.google.com with SMTP id f189so16571837pfa.7
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 22:40:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  3 May 2018 22:40:21 -0700
Message-Id: <20180504054030.24527-5-richard.henderson@linaro.org>
In-Reply-To: <20180504054030.24527-1-richard.henderson@linaro.org>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/13] target/openrisc: Convert memory insns
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
 target/openrisc/translate.c  | 275 +++++++++++++++++++++----------------------
 target/openrisc/insns.decode |  24 ++++
 2 files changed, 160 insertions(+), 139 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 95e4f17b8a..794002aaaa 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -457,51 +457,6 @@ static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_cy(dc);
 }
 
-static void gen_lwa(DisasContext *dc, TCGv rd, TCGv ra, int32_t ofs)
-{
-    TCGv ea = tcg_temp_new();
-
-    tcg_gen_addi_tl(ea, ra, ofs);
-    tcg_gen_qemu_ld_tl(rd, ea, dc->mem_idx, MO_TEUL);
-    tcg_gen_mov_tl(cpu_lock_addr, ea);
-    tcg_gen_mov_tl(cpu_lock_value, rd);
-    tcg_temp_free(ea);
-}
-
-static void gen_swa(DisasContext *dc, int b, TCGv ra, int32_t ofs)
-{
-    TCGv ea, val;
-    TCGLabel *lab_fail, *lab_done;
-
-    ea = tcg_temp_new();
-    tcg_gen_addi_tl(ea, ra, ofs);
-
-    /* For TB_FLAGS_R0_0, the branch below invalidates the temporary assigned
-       to cpu_R[0].  Since l.swa is quite often immediately followed by a
-       branch, don't bother reallocating; finish the TB using the "real" R0.
-       This also takes care of RB input across the branch.  */
-    cpu_R[0] = cpu_R0;
-
-    lab_fail = gen_new_label();
-    lab_done = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
-    tcg_temp_free(ea);
-
-    val = tcg_temp_new();
-    tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
-                              cpu_R[b], dc->mem_idx, MO_TEUL);
-    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
-    tcg_temp_free(val);
-
-    tcg_gen_br(lab_done);
-
-    gen_set_label(lab_fail);
-    tcg_gen_movi_tl(cpu_sr_f, 0);
-
-    gen_set_label(lab_done);
-    tcg_gen_movi_tl(cpu_lock_addr, -1);
-}
-
 static void dec_calc(DisasContext *dc, uint32_t insn)
 {
     uint32_t op0, op1, op2;
@@ -739,13 +694,147 @@ static bool trans_l_jalr(DisasContext *dc, arg_l_jalr *a, uint32_t insn)
     return true;
 }
 
+static bool trans_l_lwa(DisasContext *dc, arg_load *a, uint32_t insn)
+{
+    TCGv ea;
+
+    LOG_DIS("l.lwa r%d, r%d, %d\n", a->d, a->a, a->i);
+
+    check_r0_write(a->d);
+    ea = tcg_temp_new();
+    tcg_gen_addi_tl(ea, cpu_R[a->a], a->i);
+    tcg_gen_qemu_ld_tl(cpu_R[a->d], ea, dc->mem_idx, MO_TEUL);
+    tcg_gen_mov_tl(cpu_lock_addr, ea);
+    tcg_gen_mov_tl(cpu_lock_value, cpu_R[a->d]);
+    tcg_temp_free(ea);
+    return true;
+}
+
+static void do_load(DisasContext *dc, arg_load *a, TCGMemOp mop)
+{
+    TCGv ea;
+
+    check_r0_write(a->d);
+    ea = tcg_temp_new();
+    tcg_gen_addi_tl(ea, cpu_R[a->a], a->i);
+    tcg_gen_qemu_ld_tl(cpu_R[a->d], ea, dc->mem_idx, mop);
+    tcg_temp_free(ea);
+}
+
+static bool trans_l_lwz(DisasContext *dc, arg_load *a, uint32_t insn)
+{
+    LOG_DIS("l.lwz r%d, r%d, %d\n", a->d, a->a, a->i);
+    do_load(dc, a, MO_TEUL);
+    return true;
+}
+
+static bool trans_l_lws(DisasContext *dc, arg_load *a, uint32_t insn)
+{
+    LOG_DIS("l.lws r%d, r%d, %d\n", a->d, a->a, a->i);
+    do_load(dc, a, MO_TESL);
+    return true;
+}
+
+static bool trans_l_lbz(DisasContext *dc, arg_load *a, uint32_t insn)
+{
+    LOG_DIS("l.lbz r%d, r%d, %d\n", a->d, a->a, a->i);
+    do_load(dc, a, MO_UB);
+    return true;
+}
+
+static bool trans_l_lbs(DisasContext *dc, arg_load *a, uint32_t insn)
+{
+    LOG_DIS("l.lbs r%d, r%d, %d\n", a->d, a->a, a->i);
+    do_load(dc, a, MO_SB);
+    return true;
+}
+
+static bool trans_l_lhz(DisasContext *dc, arg_load *a, uint32_t insn)
+{
+    LOG_DIS("l.lhz r%d, r%d, %d\n", a->d, a->a, a->i);
+    do_load(dc, a, MO_TEUW);
+    return true;
+}
+
+static bool trans_l_lhs(DisasContext *dc, arg_load *a, uint32_t insn)
+{
+    LOG_DIS("l.lhs r%d, r%d, %d\n", a->d, a->a, a->i);
+    do_load(dc, a, MO_TESW);
+    return true;
+}
+
+static bool trans_l_swa(DisasContext *dc, arg_store *a, uint32_t insn)
+{
+    TCGv ea, val;
+    TCGLabel *lab_fail, *lab_done;
+
+    LOG_DIS("l.swa r%d, r%d, %d\n", a->a, a->b, a->i);
+
+    ea = tcg_temp_new();
+    tcg_gen_addi_tl(ea, cpu_R[a->a], a->i);
+
+    /* For TB_FLAGS_R0_0, the branch below invalidates the temporary assigned
+       to cpu_R[0].  Since l.swa is quite often immediately followed by a
+       branch, don't bother reallocating; finish the TB using the "real" R0.
+       This also takes care of RB input across the branch.  */
+    cpu_R[0] = cpu_R0;
+
+    lab_fail = gen_new_label();
+    lab_done = gen_new_label();
+    tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
+    tcg_temp_free(ea);
+
+    val = tcg_temp_new();
+    tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
+                              cpu_R[a->b], dc->mem_idx, MO_TEUL);
+    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
+    tcg_temp_free(val);
+
+    tcg_gen_br(lab_done);
+
+    gen_set_label(lab_fail);
+    tcg_gen_movi_tl(cpu_sr_f, 0);
+
+    gen_set_label(lab_done);
+    tcg_gen_movi_tl(cpu_lock_addr, -1);
+    return true;
+}
+
+static void do_store(DisasContext *dc, arg_store *a, TCGMemOp mop)
+{
+    TCGv t0 = tcg_temp_new();
+    tcg_gen_addi_tl(t0, cpu_R[a->a], a->i);
+    tcg_gen_qemu_st_tl(cpu_R[a->b], t0, dc->mem_idx, mop);
+    tcg_temp_free(t0);
+}
+
+static bool trans_l_sw(DisasContext *dc, arg_store *a, uint32_t insn)
+{
+    LOG_DIS("l.sw r%d, r%d, %d\n", a->a, a->b, a->i);
+    do_store(dc, a, MO_TEUL);
+    return true;
+}
+
+static bool trans_l_sb(DisasContext *dc, arg_store *a, uint32_t insn)
+{
+    LOG_DIS("l.sb r%d, r%d, %d\n", a->a, a->b, a->i);
+    do_store(dc, a, MO_UB);
+    return true;
+}
+
+static bool trans_l_sh(DisasContext *dc, arg_store *a, uint32_t insn)
+{
+    LOG_DIS("l.sh r%d, r%d, %d\n", a->a, a->b, a->i);
+    do_store(dc, a, MO_TEUW);
+    return true;
+}
+
 static void dec_misc(DisasContext *dc, uint32_t insn)
 {
     uint32_t op0, op1;
     uint32_t ra, rb, rd;
     uint32_t L6, K5, K16, K5_11;
-    int32_t I16, I5_11;
-    TCGMemOp mop;
+    int32_t I16;
     TCGv t0;
 
     op0 = extract32(insn, 26, 6);
@@ -758,7 +847,6 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
     K16 = extract32(insn, 0, 16);
     I16 = (int16_t)K16;
     K5_11 = (extract32(insn, 21, 5) << 11) | extract32(insn, 0, 11);
-    I5_11 = (int16_t)K5_11;
 
     switch (op0) {
     case 0x05:
@@ -796,12 +884,6 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         }
         break;
 
-    case 0x1b: /* l.lwa */
-        LOG_DIS("l.lwa r%d, r%d, %d\n", rd, ra, I16);
-        check_r0_write(rd);
-        gen_lwa(dc, cpu_R[rd], cpu_R[ra], I16);
-        break;
-
     case 0x1c:    /* l.cust1 */
         LOG_DIS("l.cust1\n");
         break;
@@ -834,53 +916,6 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         LOG_DIS("l.cust8\n");
         break;
 
-/* not used yet, open it when we need or64.  */
-/*#ifdef TARGET_OPENRISC64
-    case 0x20:     l.ld
-        LOG_DIS("l.ld r%d, r%d, %d\n", rd, ra, I16);
-        check_ob64s(dc);
-        mop = MO_TEQ;
-        goto do_load;
-#endif*/
-
-    case 0x21:    /* l.lwz */
-        LOG_DIS("l.lwz r%d, r%d, %d\n", rd, ra, I16);
-        mop = MO_TEUL;
-        goto do_load;
-
-    case 0x22:    /* l.lws */
-        LOG_DIS("l.lws r%d, r%d, %d\n", rd, ra, I16);
-        mop = MO_TESL;
-        goto do_load;
-
-    case 0x23:    /* l.lbz */
-        LOG_DIS("l.lbz r%d, r%d, %d\n", rd, ra, I16);
-        mop = MO_UB;
-        goto do_load;
-
-    case 0x24:    /* l.lbs */
-        LOG_DIS("l.lbs r%d, r%d, %d\n", rd, ra, I16);
-        mop = MO_SB;
-        goto do_load;
-
-    case 0x25:    /* l.lhz */
-        LOG_DIS("l.lhz r%d, r%d, %d\n", rd, ra, I16);
-        mop = MO_TEUW;
-        goto do_load;
-
-    case 0x26:    /* l.lhs */
-        LOG_DIS("l.lhs r%d, r%d, %d\n", rd, ra, I16);
-        mop = MO_TESW;
-        goto do_load;
-
-    do_load:
-        check_r0_write(rd);
-        t0 = tcg_temp_new();
-        tcg_gen_addi_tl(t0, cpu_R[ra], I16);
-        tcg_gen_qemu_ld_tl(cpu_R[rd], t0, dc->mem_idx, mop);
-        tcg_temp_free(t0);
-        break;
-
     case 0x27:    /* l.addi */
         LOG_DIS("l.addi r%d, r%d, %d\n", rd, ra, I16);
         check_r0_write(rd);
@@ -958,44 +993,6 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         }
         break;
 
-    case 0x33: /* l.swa */
-        LOG_DIS("l.swa r%d, r%d, %d\n", ra, rb, I5_11);
-        gen_swa(dc, rb, cpu_R[ra], I5_11);
-        break;
-
-/* not used yet, open it when we need or64.  */
-/*#ifdef TARGET_OPENRISC64
-    case 0x34:     l.sd
-        LOG_DIS("l.sd r%d, r%d, %d\n", ra, rb, I5_11);
-        check_ob64s(dc);
-        mop = MO_TEQ;
-        goto do_store;
-#endif*/
-
-    case 0x35:    /* l.sw */
-        LOG_DIS("l.sw r%d, r%d, %d\n", ra, rb, I5_11);
-        mop = MO_TEUL;
-        goto do_store;
-
-    case 0x36:    /* l.sb */
-        LOG_DIS("l.sb r%d, r%d, %d\n", ra, rb, I5_11);
-        mop = MO_UB;
-        goto do_store;
-
-    case 0x37:    /* l.sh */
-        LOG_DIS("l.sh r%d, r%d, %d\n", ra, rb, I5_11);
-        mop = MO_TEUW;
-        goto do_store;
-
-    do_store:
-        {
-            TCGv t0 = tcg_temp_new();
-            tcg_gen_addi_tl(t0, cpu_R[ra], I5_11);
-            tcg_gen_qemu_st_tl(cpu_R[rb], t0, dc->mem_idx, mop);
-            tcg_temp_free(t0);
-        }
-        break;
-
     default:
         gen_illegal_exception(dc);
         break;
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 8d35011eab..ba5356abe1 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -38,3 +38,27 @@ l_bf            000100 n:s26
 
 l_jr            010001 ---------- b:5 -----------
 l_jalr          010010 ---------- b:5 -----------
+
+####
+# Memory Instructions
+####
+
+&load           d a i
+@load           ...... d:5 a:5 i:s16                    &load
+
+%store_i        21:s5 0:11
+&store          a b i
+@store          ...... ..... a:5 b:5 ...........        &store i=%store_i
+
+l_lwa           011011 ..... ..... ........ ........    @load
+l_lwz           100001 ..... ..... ........ ........    @load
+l_lws           100010 ..... ..... ........ ........    @load
+l_lbz           100011 ..... ..... ........ ........    @load
+l_lbs           100100 ..... ..... ........ ........    @load
+l_lhz           100101 ..... ..... ........ ........    @load
+l_lhs           100110 ..... ..... ........ ........    @load
+
+l_swa           110011 ..... ..... ........ ........    @store
+l_sw            110101 ..... ..... ........ ........    @store
+l_sb            110110 ..... ..... ........ ........    @store
+l_sh            110111 ..... ..... ........ ........    @store
-- 
2.14.3
