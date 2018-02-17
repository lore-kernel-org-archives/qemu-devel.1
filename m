Received: from eggs.gnu.org ([2001:4830:134:3::10]:41923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99C-0008WE-Ck
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en999-0000lh-MR
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:50 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:41653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en999-0000lK-EH
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:47 -0500
Received: by mail-pg0-x243.google.com with SMTP id t4so4412706pgp.8
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 12:31:47 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	y7sm48203797pfe.26.2018.02.17.12.31.44 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 12:31:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 12:31:19 -0800
Message-Id: <20180217203132.31780-7-richard.henderson@linaro.org>
In-Reply-To: <20180217203132.31780-1-richard.henderson@linaro.org>
References: <20180217203132.31780-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/19] target/hppa: Convert memory management
 insns
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
 target/hppa/translate.c  | 159 +++++++++++++++--------------------------------
 target/hppa/insns.decode |  38 +++++++++++
 2 files changed, 88 insertions(+), 109 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 074234b1e0..ca46e8d50b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -302,6 +302,12 @@ static int expand_sm_imm(int val)
     return val;
 }
 
+/* Inverted space register indicates 0 means sr0 not inferred from base.  */
+static int expand_sr3x(int val)
+{
+    return ~val;
+}
+
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
 
@@ -2007,7 +2013,7 @@ static void do_page_zero(DisasContext *ctx)
 }
 #endif
 
-static void trans_nop(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_nop(DisasContext *ctx, arg_nop *a, uint32_t insn)
 {
     cond_free(&ctx->null_cond);
 }
@@ -2330,30 +2336,23 @@ static void gen_hlt(DisasContext *ctx, int reset)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static void trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
-                               const DisasInsn *di)
+static void trans_nop_addrx(DisasContext *ctx, arg_ldst *a, uint32_t insn)
 {
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned rx = extract32(insn, 16, 5);
-    TCGv_reg dest = dest_gpr(ctx, rb);
-    TCGv_reg src1 = load_gpr(ctx, rb);
-    TCGv_reg src2 = load_gpr(ctx, rx);
-
-    /* The only thing we need to do is the base register modification.  */
-    tcg_gen_add_reg(dest, src1, src2);
-    save_gpr(ctx, rb, dest);
+    if (a->m) {
+        TCGv_reg dest = dest_gpr(ctx, a->b);
+        TCGv_reg src1 = load_gpr(ctx, a->b);
+        TCGv_reg src2 = load_gpr(ctx, a->x);
 
+        /* The only thing we need to do is the base register modification.  */
+        tcg_gen_add_reg(dest, src1, src2);
+        save_gpr(ctx, a->b, dest);
+    }
     cond_free(&ctx->null_cond);
 }
 
-static void trans_probe(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_probe(DisasContext *ctx, arg_probe *a, uint32_t insn)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned sp = extract32(insn, 14, 2);
-    unsigned rr = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned is_write = extract32(insn, 6, 1);
-    unsigned is_imm = extract32(insn, 13, 1);
+    unsigned rt = a->t;
     TCGv_reg dest, ofs;
     TCGv_i32 level, want;
     TCGv_tl addr;
@@ -2361,16 +2360,16 @@ static void trans_probe(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     nullify_over(ctx);
 
     dest = dest_gpr(ctx, rt);
-    form_gva(ctx, &addr, &ofs, rb, 0, 0, 0, sp, 0, false);
+    form_gva(ctx, &addr, &ofs, a->b, 0, 0, 0, a->sp, 0, false);
 
-    if (is_imm) {
-        level = tcg_const_i32(extract32(insn, 16, 2));
+    if (a->imm) {
+        level = tcg_const_i32(a->ri);
     } else {
         level = tcg_temp_new_i32();
-        tcg_gen_trunc_reg_i32(level, load_gpr(ctx, rr));
+        tcg_gen_trunc_reg_i32(level, load_gpr(ctx, a->ri));
         tcg_gen_andi_i32(level, level, 3);
     }
-    want = tcg_const_i32(is_write ? PAGE_WRITE : PAGE_READ);
+    want = tcg_const_i32(a->write ? PAGE_WRITE : PAGE_READ);
 
     gen_helper_probe(dest, cpu_env, addr, level, want);
 
@@ -2381,29 +2380,18 @@ static void trans_probe(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     nullify_end(ctx);
 }
 
-#ifndef CONFIG_USER_ONLY
-static void trans_ixtlbx(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a, uint32_t insn)
 {
-    unsigned sp;
-    unsigned rr = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned is_data = insn & 0x1000;
-    unsigned is_addr = insn & 0x40;
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
     TCGv_tl addr;
     TCGv_reg ofs, reg;
 
-    if (is_data) {
-        sp = extract32(insn, 14, 2);
-    } else {
-        sp = ~assemble_sr3(insn);
-    }
-
-    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
     nullify_over(ctx);
 
-    form_gva(ctx, &addr, &ofs, rb, 0, 0, 0, sp, 0, false);
-    reg = load_gpr(ctx, rr);
-    if (is_addr) {
+    form_gva(ctx, &addr, &ofs, a->b, 0, 0, 0, a->sp, 0, false);
+    reg = load_gpr(ctx, a->r);
+    if (a->addr) {
         gen_helper_itlba(cpu_env, addr, reg);
     } else {
         gen_helper_itlbp(cpu_env, addr, reg);
@@ -2411,80 +2399,67 @@ static void trans_ixtlbx(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 
     /* Exit TB for ITLB change if mmu is enabled.  This *should* not be
        the case, since the OS TLB fill handler runs with mmu disabled.  */
-    if (!is_data && (ctx->tb_flags & PSW_C)) {
+    if (!a->data && (ctx->tb_flags & PSW_C)) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
     }
     nullify_end(ctx);
+#endif
 }
 
-static void trans_pxtlbx(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a, uint32_t insn)
 {
-    unsigned m = extract32(insn, 5, 1);
-    unsigned sp;
-    unsigned rx = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-    unsigned is_data = insn & 0x1000;
-    unsigned is_local = insn & 0x40;
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
     TCGv_tl addr;
     TCGv_reg ofs;
 
-    if (is_data) {
-        sp = extract32(insn, 14, 2);
-    } else {
-        sp = ~assemble_sr3(insn);
-    }
-
-    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
     nullify_over(ctx);
 
-    form_gva(ctx, &addr, &ofs, rb, rx, 0, 0, sp, m, false);
-    if (m) {
-        save_gpr(ctx, rb, ofs);
+    form_gva(ctx, &addr, &ofs, a->b, a->x, 0, 0, a->sp, a->m, false);
+    if (a->m) {
+        save_gpr(ctx, a->b, ofs);
     }
-    if (is_local) {
+    if (a->local) {
         gen_helper_ptlbe(cpu_env);
     } else {
         gen_helper_ptlb(cpu_env, addr);
     }
 
     /* Exit TB for TLB change if mmu is enabled.  */
-    if (!is_data && (ctx->tb_flags & PSW_C)) {
+    if (!a->data && (ctx->tb_flags & PSW_C)) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
     }
     nullify_end(ctx);
+#endif
 }
 
-static void trans_lpa(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_lpa(DisasContext *ctx, arg_ldst *a, uint32_t insn)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned m = extract32(insn, 5, 1);
-    unsigned sp = extract32(insn, 14, 2);
-    unsigned rx = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
     TCGv_tl vaddr;
     TCGv_reg ofs, paddr;
 
-    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
     nullify_over(ctx);
 
-    form_gva(ctx, &vaddr, &ofs, rb, rx, 0, 0, sp, m, false);
+    form_gva(ctx, &vaddr, &ofs, a->b, a->x, 0, 0, a->sp, a->m, false);
 
     paddr = tcg_temp_new();
     gen_helper_lpa(paddr, cpu_env, vaddr);
 
     /* Note that physical address result overrides base modification.  */
-    if (m) {
-        save_gpr(ctx, rb, ofs);
+    if (a->m) {
+        save_gpr(ctx, a->b, ofs);
     }
-    save_gpr(ctx, rt, paddr);
+    save_gpr(ctx, a->t, paddr);
     tcg_temp_free(paddr);
 
     nullify_end(ctx);
+#endif
 }
 
-static void trans_lci(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_lci(DisasContext *ctx, arg_lci *a, uint32_t insn)
 {
-    unsigned rt = extract32(insn, 0, 5);
     TCGv_reg ci;
 
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
@@ -2494,42 +2469,11 @@ static void trans_lci(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
        view of the cache.  Our implementation is to return 0 for all,
        since the entire address space is coherent.  */
     ci = tcg_const_reg(0);
-    save_gpr(ctx, rt, ci);
+    save_gpr(ctx, a->t, ci);
     tcg_temp_free(ci);
 
     cond_free(&ctx->null_cond);
 }
-#endif /* !CONFIG_USER_ONLY */
-
-static const DisasInsn table_mem_mgmt[] = {
-    { 0x04003280u, 0xfc003fffu, trans_nop },          /* fdc, disp */
-    { 0x04001280u, 0xfc003fffu, trans_nop },          /* fdc, index */
-    { 0x040012a0u, 0xfc003fffu, trans_base_idx_mod }, /* fdc, index, base mod */
-    { 0x040012c0u, 0xfc003fffu, trans_nop },          /* fdce */
-    { 0x040012e0u, 0xfc003fffu, trans_base_idx_mod }, /* fdce, base mod */
-    { 0x04000280u, 0xfc001fffu, trans_nop },          /* fic 0a */
-    { 0x040002a0u, 0xfc001fffu, trans_base_idx_mod }, /* fic 0a, base mod */
-    { 0x040013c0u, 0xfc003fffu, trans_nop },          /* fic 4f */
-    { 0x040013e0u, 0xfc003fffu, trans_base_idx_mod }, /* fic 4f, base mod */
-    { 0x040002c0u, 0xfc001fffu, trans_nop },          /* fice */
-    { 0x040002e0u, 0xfc001fffu, trans_base_idx_mod }, /* fice, base mod */
-    { 0x04002700u, 0xfc003fffu, trans_nop },          /* pdc */
-    { 0x04002720u, 0xfc003fffu, trans_base_idx_mod }, /* pdc, base mod */
-    { 0x04001180u, 0xfc003fa0u, trans_probe },        /* probe */
-    { 0x04003180u, 0xfc003fa0u, trans_probe },        /* probei */
-#ifndef CONFIG_USER_ONLY
-    { 0x04000000u, 0xfc001fffu, trans_ixtlbx },       /* iitlbp */
-    { 0x04000040u, 0xfc001fffu, trans_ixtlbx },       /* iitlba */
-    { 0x04001000u, 0xfc001fffu, trans_ixtlbx },       /* idtlbp */
-    { 0x04001040u, 0xfc001fffu, trans_ixtlbx },       /* idtlba */
-    { 0x04000200u, 0xfc001fdfu, trans_pxtlbx },       /* pitlb */
-    { 0x04000240u, 0xfc001fdfu, trans_pxtlbx },       /* pitlbe */
-    { 0x04001200u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlb */
-    { 0x04001240u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlbe */
-    { 0x04001340u, 0xfc003fc0u, trans_lpa },
-    { 0x04001300u, 0xfc003fe0u, trans_lci },
-#endif
-};
 
 static void trans_add(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
@@ -4521,9 +4465,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
 
     opc = extract32(insn, 26, 6);
     switch (opc) {
-    case 0x01:
-        translate_table(ctx, insn, table_mem_mgmt);
-        return;
     case 0x02:
         translate_table(ctx, insn, table_arith_log);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index b2131a269b..5fe7b9a027 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -22,9 +22,17 @@
 ####
 
 %assemble_sr3	13:1 14:2
+%assemble_sr3x	13:1 14:2 !function=expand_sr3x
 
 %sm_imm		16:10 !function=expand_sm_imm
 
+####
+# Argument set definitions
+####
+
+# All insns that need to form a virtual address should use this set.
+&ldst		t b x disp sp m scale size
+
 ####
 # System
 ####
@@ -49,3 +57,33 @@ ssm		000000 ..........  000 01101011 t:5	i=%sm_imm
 
 rfi		000000 ----- ----- --- 01100000 00000
 rfi_r		000000 ----- ----- --- 01100101 00000
+
+####
+# Memory Management
+####
+
+@addrx		...... b:5 x:5 .. ........ m:1 .....	\
+		&ldst disp=0 scale=0 t=0 sp=0 size=0
+
+nop		000001 ----- ----- -- 11001010 0 -----         # fdc, disp
+nop_addrx	000001 ..... ..... -- 01001010 . -----	@addrx # fdc, index
+nop_addrx	000001 ..... ..... -- 01001011 . -----	@addrx # fdce
+nop_addrx	000001 ..... ..... --- 0001010 . -----	@addrx # fic 0x0a
+nop_addrx	000001 ..... ..... -- 01001111 . 00000	@addrx # fic 0x4f
+nop_addrx	000001 ..... ..... --- 0001011 . -----	@addrx # fice
+nop_addrx	000001 ..... ..... -- 01001110 . 00000	@addrx # pdc
+
+probe		000001 b:5 ri:5 sp:2 imm:1 100011 write:1 0 t:5
+
+ixtlbx		000001 b:5 r:5 sp:2 0100000 addr:1 0 00000	data=1
+ixtlbx		000001 b:5 r:5 ... 000000 addr:1 0 00000	\
+		sp=%assemble_sr3x data=0
+
+pxtlbx		000001 b:5 x:5 sp:2 0100100 local:1 m:1 -----	data=1
+pxtlbx		000001 b:5 x:5 ... 000100 local:1 m:1 -----	\
+		sp=%assemble_sr3x data=0
+
+lpa		000001 b:5 x:5 sp:2 01001101 m:1 t:5	\
+		&ldst disp=0 scale=0 size=0
+
+lci		000001 ----- ----- -- 01001100 0 t:5
-- 
2.14.3
