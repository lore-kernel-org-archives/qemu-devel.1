Received: from eggs.gnu.org ([2001:4830:134:3::10]:40105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Ht-00020P-Eh
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hq-0000SV-9G
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:45 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:42838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1Hp-0000G2-O2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:42 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:44 +0200
Message-Id: <20181012173047.25420-26-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 25/28] target/riscv: Remove manual decoding of
 RV32/64M insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Cc: qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn_trans/trans_rvm.inc.c |  55 ++---
 target/riscv/translate.c                | 266 +++++++++++-------------
 2 files changed, 151 insertions(+), 170 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvm.inc.c b/target/riscv/insn_trans/trans_rvm.inc.c
index 2d0fd6a64f..6f7187bb8f 100644
--- a/target/riscv/insn_trans/trans_rvm.inc.c
+++ b/target/riscv/insn_trans/trans_rvm.inc.c
@@ -21,67 +21,74 @@
 
 static bool trans_mul(DisasContext *ctx, arg_mul *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_MUL, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_mul_tl);
 }
 static bool trans_mulh(DisasContext *ctx, arg_mulh *a, uint32_t insn)
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
 static bool trans_mulhsu(DisasContext *ctx, arg_mulhsu *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_MULHSU, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_mulhsu);
 }
 static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a, uint32_t insn)
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
 
 static bool trans_div(DisasContext *ctx, arg_div *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_DIV, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_div);
 }
 static bool trans_divu(DisasContext *ctx, arg_divu *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_DIVU, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_divu);
 }
 static bool trans_rem(DisasContext *ctx, arg_rem *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_REM, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_rem);
 }
 static bool trans_remu(DisasContext *ctx, arg_remu *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_REMU, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_remu);
 }
 static bool trans_mulw(DisasContext *ctx, arg_mulw *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_MULW, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_mul_tl);
 }
 static bool trans_divw(DisasContext *ctx, arg_divw *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_DIVW, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith_w(ctx, a, &gen_div);
 }
 static bool trans_divuw(DisasContext *ctx, arg_divuw *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_DIVUW, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith_w(ctx, a, &gen_divu);
 }
 static bool trans_remw(DisasContext *ctx, arg_remw *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_REMW, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith_w(ctx, a, &gen_rem);
 }
 static bool trans_remuw(DisasContext *ctx, arg_remuw *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_REMUW, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith_w(ctx, a, &gen_remu);
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 047f64c6f2..5e24ec49a0 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -165,156 +165,110 @@ static void gen_mulhsu(TCGv ret, TCGv arg1, TCGv arg2)
     tcg_temp_free(rh);
 }
 
-static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
-        int rs2)
+static void gen_div(TCGv ret, TCGv source1, TCGv source2)
 {
-    TCGv source1, source2, cond1, cond2, zeroreg, resultopt1;
-    source1 = tcg_temp_new();
-    source2 = tcg_temp_new();
-    gen_get_gpr(source1, rs1);
-    gen_get_gpr(source2, rs2);
+    TCGv cond1, cond2, zeroreg, resultopt1;
+    /* Handle by altering args to tcg_gen_div to produce req'd results:
+     * For overflow: want source1 in source1 and 1 in source2
+     * For div by zero: want -1 in source1 and 1 in source2 -> -1 result */
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
 
-    if (opc & 0x8) { /* sign extend for W instructions */
-        tcg_gen_ext32s_tl(source1, source1);
-    }
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
 
-    gen_set_gpr(rd, source1);
-    tcg_temp_free(source1);
-    tcg_temp_free(source2);
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
@@ -434,6 +388,26 @@ static bool trans_arith(DisasContext *ctx, arg_arith *a,
     tcg_temp_free(source2);
     return true;
 }
+static bool trans_arith_w(DisasContext *ctx, arg_arith *a,
+                        void(*func)(TCGv, TCGv, TCGv))
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
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
+    return true;
+}
+
 
 static bool trans_shift(DisasContext *ctx, arg_arith *a,
                         void(*func)(TCGv, TCGv, TCGv))
-- 
2.19.1
