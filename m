Received: from eggs.gnu.org ([209.51.188.92]:59386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glsVU-0006Mz-EG
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glsOR-0005wL-QY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:30:53 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue, 22 Jan 2019 10:29:01 +0100
Message-Id: <20190122092909.5341-28-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
References: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 27/35] target/riscv: Remove manual decoding
 of RV32/64M insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn_trans/trans_rvm.inc.c |  55 +++--
 target/riscv/translate.c                | 283 +++++++++++-------------
 2 files changed, 164 insertions(+), 174 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvm.inc.c b/target/riscv/insn_trans/trans_rvm.inc.c
index ec3197ede8..949f59ddb2 100644
--- a/target/riscv/insn_trans/trans_rvm.inc.c
+++ b/target/riscv/insn_trans/trans_rvm.inc.c
@@ -21,80 +21,87 @@
 
 static bool trans_mul(DisasContext *ctx, arg_mul *a)
 {
-    gen_arith(ctx, OPC_RISC_MUL, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_mul_tl);
 }
 
 static bool trans_mulh(DisasContext *ctx, arg_mulh *a)
 {
-    gen_arith(ctx, OPC_RISC_MULH, a->rd, a->rs1, a->rs2);
+    TCGv source1 = tcg_temp_new();
+    TCGv source2 = tcg_temp_new();
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+
+    tcg_gen_muls2_tl(source2, source1, source1, source2);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
     return true;
 }
 
 static bool trans_mulhsu(DisasContext *ctx, arg_mulhsu *a)
 {
-    gen_arith(ctx, OPC_RISC_MULHSU, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_mulhsu);
 }
 
 static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a)
 {
-    gen_arith(ctx, OPC_RISC_MULHU, a->rd, a->rs1, a->rs2);
+    TCGv source1 = tcg_temp_new();
+    TCGv source2 = tcg_temp_new();
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+
+    tcg_gen_mulu2_tl(source2, source1, source1, source2);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
     return true;
 }
 
 static bool trans_div(DisasContext *ctx, arg_div *a)
 {
-    gen_arith(ctx, OPC_RISC_DIV, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_div);
 }
 
 static bool trans_divu(DisasContext *ctx, arg_divu *a)
 {
-    gen_arith(ctx, OPC_RISC_DIVU, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_divu);
 }
 
 static bool trans_rem(DisasContext *ctx, arg_rem *a)
 {
-    gen_arith(ctx, OPC_RISC_REM, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_rem);
 }
 
 static bool trans_remu(DisasContext *ctx, arg_remu *a)
 {
-    gen_arith(ctx, OPC_RISC_REMU, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_remu);
 }
 
 #ifdef TARGET_RISCV64
 static bool trans_mulw(DisasContext *ctx, arg_mulw *a)
 {
-    gen_arith(ctx, OPC_RISC_MULW, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_mulw);
 }
 
 static bool trans_divw(DisasContext *ctx, arg_divw *a)
 {
-    gen_arith(ctx, OPC_RISC_DIVW, a->rd, a->rs1, a->rs2);
-    return true;
+    return gen_arith_div_w(ctx, a, &gen_div);
 }
 
 static bool trans_divuw(DisasContext *ctx, arg_divuw *a)
 {
-    gen_arith(ctx, OPC_RISC_DIVUW, a->rd, a->rs1, a->rs2);
-    return true;
+    return gen_arith_div_w(ctx, a, &gen_divu);
 }
 
 static bool trans_remw(DisasContext *ctx, arg_remw *a)
 {
-    gen_arith(ctx, OPC_RISC_REMW, a->rd, a->rs1, a->rs2);
-    return true;
+    return gen_arith_div_w(ctx, a, &gen_rem);
 }
 
 static bool trans_remuw(DisasContext *ctx, arg_remuw *a)
 {
-    gen_arith(ctx, OPC_RISC_REMUW, a->rd, a->rs1, a->rs2);
-    return true;
+    return gen_arith_div_w(ctx, a, &gen_remu);
 }
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 442c7d26a3..6a722a0045 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -182,156 +182,112 @@ static void gen_mulhsu(TCGv ret, TCGv arg1, TCGv arg2)
     tcg_temp_free(rh);
 }
 
-static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
-        int rs2)
-{
-    TCGv source1, source2, cond1, cond2, zeroreg, resultopt1;
-    source1 = tcg_temp_new();
-    source2 = tcg_temp_new();
-    gen_get_gpr(source1, rs1);
-    gen_get_gpr(source2, rs2);
-
-    switch (opc) {
-    CASE_OP_32_64(OPC_RISC_MUL):
-        tcg_gen_mul_tl(source1, source1, source2);
-        break;
-    case OPC_RISC_MULH:
-        tcg_gen_muls2_tl(source2, source1, source1, source2);
-        break;
-    case OPC_RISC_MULHSU:
-        gen_mulhsu(source1, source1, source2);
-        break;
-    case OPC_RISC_MULHU:
-        tcg_gen_mulu2_tl(source2, source1, source1, source2);
-        break;
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_DIVW:
-        tcg_gen_ext32s_tl(source1, source1);
-        tcg_gen_ext32s_tl(source2, source2);
-        /* fall through to DIV */
-#endif
-    case OPC_RISC_DIV:
-        /* Handle by altering args to tcg_gen_div to produce req'd results:
-         * For overflow: want source1 in source1 and 1 in source2
-         * For div by zero: want -1 in source1 and 1 in source2 -> -1 result */
-        cond1 = tcg_temp_new();
-        cond2 = tcg_temp_new();
-        zeroreg = tcg_const_tl(0);
-        resultopt1 = tcg_temp_new();
-
-        tcg_gen_movi_tl(resultopt1, (target_ulong)-1);
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cond2, source2, (target_ulong)(~0L));
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source1,
-                            ((target_ulong)1) << (TARGET_LONG_BITS - 1));
-        tcg_gen_and_tl(cond1, cond1, cond2); /* cond1 = overflow */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cond2, source2, 0); /* cond2 = div 0 */
-        /* if div by zero, set source1 to -1, otherwise don't change */
-        tcg_gen_movcond_tl(TCG_COND_EQ, source1, cond2, zeroreg, source1,
-                resultopt1);
-        /* if overflow or div by zero, set source2 to 1, else don't change */
-        tcg_gen_or_tl(cond1, cond1, cond2);
-        tcg_gen_movi_tl(resultopt1, (target_ulong)1);
-        tcg_gen_movcond_tl(TCG_COND_EQ, source2, cond1, zeroreg, source2,
-                resultopt1);
-        tcg_gen_div_tl(source1, source1, source2);
-
-        tcg_temp_free(cond1);
-        tcg_temp_free(cond2);
-        tcg_temp_free(zeroreg);
-        tcg_temp_free(resultopt1);
-        break;
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_DIVUW:
-        tcg_gen_ext32u_tl(source1, source1);
-        tcg_gen_ext32u_tl(source2, source2);
-        /* fall through to DIVU */
-#endif
-    case OPC_RISC_DIVU:
-        cond1 = tcg_temp_new();
-        zeroreg = tcg_const_tl(0);
-        resultopt1 = tcg_temp_new();
-
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source2, 0);
-        tcg_gen_movi_tl(resultopt1, (target_ulong)-1);
-        tcg_gen_movcond_tl(TCG_COND_EQ, source1, cond1, zeroreg, source1,
-                resultopt1);
-        tcg_gen_movi_tl(resultopt1, (target_ulong)1);
-        tcg_gen_movcond_tl(TCG_COND_EQ, source2, cond1, zeroreg, source2,
-                resultopt1);
-        tcg_gen_divu_tl(source1, source1, source2);
-
-        tcg_temp_free(cond1);
-        tcg_temp_free(zeroreg);
-        tcg_temp_free(resultopt1);
-        break;
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_REMW:
-        tcg_gen_ext32s_tl(source1, source1);
-        tcg_gen_ext32s_tl(source2, source2);
-        /* fall through to REM */
-#endif
-    case OPC_RISC_REM:
-        cond1 = tcg_temp_new();
-        cond2 = tcg_temp_new();
-        zeroreg = tcg_const_tl(0);
-        resultopt1 = tcg_temp_new();
-
-        tcg_gen_movi_tl(resultopt1, 1L);
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cond2, source2, (target_ulong)-1);
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source1,
-                            (target_ulong)1 << (TARGET_LONG_BITS - 1));
-        tcg_gen_and_tl(cond2, cond1, cond2); /* cond1 = overflow */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source2, 0); /* cond2 = div 0 */
-        /* if overflow or div by zero, set source2 to 1, else don't change */
-        tcg_gen_or_tl(cond2, cond1, cond2);
-        tcg_gen_movcond_tl(TCG_COND_EQ, source2, cond2, zeroreg, source2,
-                resultopt1);
-        tcg_gen_rem_tl(resultopt1, source1, source2);
-        /* if div by zero, just return the original dividend */
-        tcg_gen_movcond_tl(TCG_COND_EQ, source1, cond1, zeroreg, resultopt1,
-                source1);
-
-        tcg_temp_free(cond1);
-        tcg_temp_free(cond2);
-        tcg_temp_free(zeroreg);
-        tcg_temp_free(resultopt1);
-        break;
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_REMUW:
-        tcg_gen_ext32u_tl(source1, source1);
-        tcg_gen_ext32u_tl(source2, source2);
-        /* fall through to REMU */
-#endif
-    case OPC_RISC_REMU:
-        cond1 = tcg_temp_new();
-        zeroreg = tcg_const_tl(0);
-        resultopt1 = tcg_temp_new();
-
-        tcg_gen_movi_tl(resultopt1, (target_ulong)1);
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source2, 0);
-        tcg_gen_movcond_tl(TCG_COND_EQ, source2, cond1, zeroreg, source2,
-                resultopt1);
-        tcg_gen_remu_tl(resultopt1, source1, source2);
-        /* if div by zero, just return the original dividend */
-        tcg_gen_movcond_tl(TCG_COND_EQ, source1, cond1, zeroreg, resultopt1,
-                source1);
-
-        tcg_temp_free(cond1);
-        tcg_temp_free(zeroreg);
-        tcg_temp_free(resultopt1);
-        break;
-    default:
-        gen_exception_illegal(ctx);
-        return;
-    }
-
-    if (opc & 0x8) { /* sign extend for W instructions */
-        tcg_gen_ext32s_tl(source1, source1);
-    }
-
-    gen_set_gpr(rd, source1);
-    tcg_temp_free(source1);
-    tcg_temp_free(source2);
+static void gen_div(TCGv ret, TCGv source1, TCGv source2)
+{
+    TCGv cond1, cond2, zeroreg, resultopt1;
+    /*
+     * Handle by altering args to tcg_gen_div to produce req'd results:
+     * For overflow: want source1 in source1 and 1 in source2
+     * For div by zero: want -1 in source1 and 1 in source2 -> -1 result
+     */
+    cond1 = tcg_temp_new();
+    cond2 = tcg_temp_new();
+    zeroreg = tcg_const_tl(0);
+    resultopt1 = tcg_temp_new();
+
+    tcg_gen_movi_tl(resultopt1, (target_ulong)-1);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cond2, source2, (target_ulong)(~0L));
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source1,
+                        ((target_ulong)1) << (TARGET_LONG_BITS - 1));
+    tcg_gen_and_tl(cond1, cond1, cond2); /* cond1 = overflow */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cond2, source2, 0); /* cond2 = div 0 */
+    /* if div by zero, set source1 to -1, otherwise don't change */
+    tcg_gen_movcond_tl(TCG_COND_EQ, source1, cond2, zeroreg, source1,
+            resultopt1);
+    /* if overflow or div by zero, set source2 to 1, else don't change */
+    tcg_gen_or_tl(cond1, cond1, cond2);
+    tcg_gen_movi_tl(resultopt1, (target_ulong)1);
+    tcg_gen_movcond_tl(TCG_COND_EQ, source2, cond1, zeroreg, source2,
+            resultopt1);
+    tcg_gen_div_tl(ret, source1, source2);
+
+    tcg_temp_free(cond1);
+    tcg_temp_free(cond2);
+    tcg_temp_free(zeroreg);
+    tcg_temp_free(resultopt1);
+}
+
+static void gen_divu(TCGv ret, TCGv source1, TCGv source2)
+{
+    TCGv cond1, zeroreg, resultopt1;
+    cond1 = tcg_temp_new();
+
+    zeroreg = tcg_const_tl(0);
+    resultopt1 = tcg_temp_new();
+
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source2, 0);
+    tcg_gen_movi_tl(resultopt1, (target_ulong)-1);
+    tcg_gen_movcond_tl(TCG_COND_EQ, source1, cond1, zeroreg, source1,
+            resultopt1);
+    tcg_gen_movi_tl(resultopt1, (target_ulong)1);
+    tcg_gen_movcond_tl(TCG_COND_EQ, source2, cond1, zeroreg, source2,
+            resultopt1);
+    tcg_gen_divu_tl(ret, source1, source2);
+
+    tcg_temp_free(cond1);
+    tcg_temp_free(zeroreg);
+    tcg_temp_free(resultopt1);
+}
+
+static void gen_rem(TCGv ret, TCGv source1, TCGv source2)
+{
+    TCGv cond1, cond2, zeroreg, resultopt1;
+
+    cond1 = tcg_temp_new();
+    cond2 = tcg_temp_new();
+    zeroreg = tcg_const_tl(0);
+    resultopt1 = tcg_temp_new();
+
+    tcg_gen_movi_tl(resultopt1, 1L);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cond2, source2, (target_ulong)-1);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source1,
+                        (target_ulong)1 << (TARGET_LONG_BITS - 1));
+    tcg_gen_and_tl(cond2, cond1, cond2); /* cond1 = overflow */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source2, 0); /* cond2 = div 0 */
+    /* if overflow or div by zero, set source2 to 1, else don't change */
+    tcg_gen_or_tl(cond2, cond1, cond2);
+    tcg_gen_movcond_tl(TCG_COND_EQ, source2, cond2, zeroreg, source2,
+            resultopt1);
+    tcg_gen_rem_tl(resultopt1, source1, source2);
+    /* if div by zero, just return the original dividend */
+    tcg_gen_movcond_tl(TCG_COND_EQ, ret, cond1, zeroreg, resultopt1,
+            source1);
+
+    tcg_temp_free(cond1);
+    tcg_temp_free(cond2);
+    tcg_temp_free(zeroreg);
+    tcg_temp_free(resultopt1);
+}
+
+static void gen_remu(TCGv ret, TCGv source1, TCGv source2)
+{
+    TCGv cond1, zeroreg, resultopt1;
+    cond1 = tcg_temp_new();
+    zeroreg = tcg_const_tl(0);
+    resultopt1 = tcg_temp_new();
+
+    tcg_gen_movi_tl(resultopt1, (target_ulong)1);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source2, 0);
+    tcg_gen_movcond_tl(TCG_COND_EQ, source2, cond1, zeroreg, source2,
+            resultopt1);
+    tcg_gen_remu_tl(resultopt1, source1, source2);
+    /* if div by zero, just return the original dividend */
+    tcg_gen_movcond_tl(TCG_COND_EQ, ret, cond1, zeroreg, resultopt1,
+            source1);
+
+    tcg_temp_free(cond1);
+    tcg_temp_free(zeroreg);
+    tcg_temp_free(resultopt1);
 }
 
 static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
@@ -592,6 +548,33 @@ static void gen_subw(TCGv ret, TCGv arg1, TCGv arg2)
     tcg_gen_ext32s_tl(ret, ret);
 }
 
+static void gen_mulw(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    tcg_gen_mul_tl(ret, arg1, arg2);
+    tcg_gen_ext32s_tl(ret, ret);
+}
+
+static bool gen_arith_div_w(DisasContext *ctx, arg_r *a,
+                            void(*func)(TCGv, TCGv, TCGv))
+{
+    TCGv source1, source2;
+    source1 = tcg_temp_new();
+    source2 = tcg_temp_new();
+
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+    tcg_gen_ext32s_tl(source1, source1);
+    tcg_gen_ext32s_tl(source2, source2);
+
+    (*func)(source1, source1, source2);
+
+    tcg_gen_ext32s_tl(source1, source1);
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
+    return true;
+}
+
 #endif
 
 static bool trans_arith(DisasContext *ctx, arg_r *a,
-- 
2.20.1
