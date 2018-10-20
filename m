Received: from eggs.gnu.org ([2001:4830:134:3::10]:41039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlU0-0002SS-87
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTv-0004fe-Ej
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:36 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:36904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDlTs-0004Tn-B4
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:30 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Sat, 20 Oct 2018 09:14:47 +0200
Message-Id: <20181020071451.27808-26-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 25/29] target/riscv: Remove shift and slt
 insn manual decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, richard.henderson@linaro.org, qemu-devel@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
    v1 -> v2:
        - trans_shift -> gen_shift

 target/riscv/insn_trans/trans_rvi.inc.c | 79 +++++++++++++++++++++----
 target/riscv/translate.c                | 59 ++++++------------
 2 files changed, 86 insertions(+), 52 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index c4a928705a..5ece5e2f6a 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -325,19 +325,39 @@ static bool trans_sub(DisasContext *ctx, arg_sub *a, uint32_t insn)
 
 static bool trans_sll(DisasContext *ctx, arg_sll *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_SLL, a->rd, a->rs1, a->rs2);
-    return true;
+
+    return gen_shift(ctx, a, &tcg_gen_shl_tl);
 }
 
 static bool trans_slt(DisasContext *ctx, arg_slt *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_SLT, a->rd, a->rs1, a->rs2);
+    TCGv source1 = tcg_temp_new();
+    TCGv source2 = tcg_temp_new();
+
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+
+    tcg_gen_setcond_tl(TCG_COND_LT, source1, source1, source2);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
     return true;
 }
 
 static bool trans_sltu(DisasContext *ctx, arg_sltu *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_SLTU, a->rd, a->rs1, a->rs2);
+    TCGv source1 = tcg_temp_new();
+    TCGv source2 = tcg_temp_new();
+
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+
+    tcg_gen_setcond_tl(TCG_COND_LTU, source1, source1, source2);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
     return true;
 }
 
@@ -346,16 +366,15 @@ static bool trans_xor(DisasContext *ctx, arg_xor *a, uint32_t insn)
     return trans_arith(ctx, a, &tcg_gen_xor_tl);
 }
 
+
 static bool trans_srl(DisasContext *ctx, arg_srl *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_SRL, a->rd, a->rs1, a->rs2);
-    return true;
+    return gen_shift(ctx, a, &tcg_gen_shr_tl);
 }
 
 static bool trans_sra(DisasContext *ctx, arg_sra *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_SRA, a->rd, a->rs1, a->rs2);
-    return true;
+    return gen_shift(ctx, a, &tcg_gen_sar_tl);
 }
 
 static bool trans_or(DisasContext *ctx, arg_or *a, uint32_t insn)
@@ -450,7 +469,18 @@ static bool trans_sllw(DisasContext *ctx, arg_sllw *a, uint32_t insn)
 #if !defined(TARGET_RISCV64)
     return false;
 #endif
-    gen_arith(ctx, OPC_RISC_SLLW, a->rd, a->rs1, a->rs2);
+    TCGv source1 = tcg_temp_new();
+    TCGv source2 = tcg_temp_new();
+
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+
+    tcg_gen_andi_tl(source2, source2, 0x1F);
+    tcg_gen_shl_tl(source1, source1, source2);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
     return true;
 }
 
@@ -459,7 +489,20 @@ static bool trans_srlw(DisasContext *ctx, arg_srlw *a, uint32_t insn)
 #if !defined(TARGET_RISCV64)
     return false;
 #endif
-    gen_arith(ctx, OPC_RISC_SRLW, a->rd, a->rs1, a->rs2);
+    TCGv source1 = tcg_temp_new();
+    TCGv source2 = tcg_temp_new();
+
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+
+    /* clear upper 32 */
+    tcg_gen_ext32u_tl(source1, source1);
+    tcg_gen_andi_tl(source2, source2, 0x1F);
+    tcg_gen_shr_tl(source1, source1, source2);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
     return true;
 }
 
@@ -468,7 +511,21 @@ static bool trans_sraw(DisasContext *ctx, arg_sraw *a, uint32_t insn)
 #if !defined(TARGET_RISCV64)
     return false;
 #endif
-    gen_arith(ctx, OPC_RISC_SRAW, a->rd, a->rs1, a->rs2);
+    TCGv source1 = tcg_temp_new();
+    TCGv source2 = tcg_temp_new();
+
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+
+    /* first, trick to get it to act like working on 32 bits (get rid of
+       upper 32, sign extend to fill space) */
+    tcg_gen_ext32s_tl(source1, source1);
+    tcg_gen_andi_tl(source2, source2, 0x1F);
+    tcg_gen_sar_tl(source1, source1, source2);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
     return true;
 }
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index fc1ed73784..d85c21ee91 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -176,47 +176,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
     gen_get_gpr(source2, rs2);
 
     switch (opc) {
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_SLLW:
-        tcg_gen_andi_tl(source2, source2, 0x1F);
-        tcg_gen_shl_tl(source1, source1, source2);
-        break;
-#endif
-    case OPC_RISC_SLL:
-        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
-        tcg_gen_shl_tl(source1, source1, source2);
-        break;
-    case OPC_RISC_SLT:
-        tcg_gen_setcond_tl(TCG_COND_LT, source1, source1, source2);
-        break;
-    case OPC_RISC_SLTU:
-        tcg_gen_setcond_tl(TCG_COND_LTU, source1, source1, source2);
-        break;
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_SRLW:
-        /* clear upper 32 */
-        tcg_gen_ext32u_tl(source1, source1);
-        tcg_gen_andi_tl(source2, source2, 0x1F);
-        tcg_gen_shr_tl(source1, source1, source2);
-        break;
-#endif
-    case OPC_RISC_SRL:
-        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
-        tcg_gen_shr_tl(source1, source1, source2);
-        break;
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_SRAW:
-        /* first, trick to get it to act like working on 32 bits (get rid of
-        upper 32, sign extend to fill space) */
-        tcg_gen_ext32s_tl(source1, source1);
-        tcg_gen_andi_tl(source2, source2, 0x1F);
-        tcg_gen_sar_tl(source1, source1, source2);
-        break;
-#endif
-    case OPC_RISC_SRA:
-        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
-        tcg_gen_sar_tl(source1, source1, source2);
-        break;
     CASE_OP_32_64(OPC_RISC_MUL):
         tcg_gen_mul_tl(source1, source1, source2);
         break;
@@ -477,6 +436,24 @@ static bool trans_arith(DisasContext *ctx, arg_arith *a,
     return true;
 }
 
+static bool gen_shift(DisasContext *ctx, arg_arith *a,
+                        void(*func)(TCGv, TCGv, TCGv))
+{
+    TCGv source1 = tcg_temp_new();
+    TCGv source2 = tcg_temp_new();
+
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+
+    tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
+    (*func)(source1, source1, source2);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    tcg_temp_free(source2);
+    return true;
+}
+
 /* Include insn module translation function */
 #include "insn_trans/trans_rvi.inc.c"
 #include "insn_trans/trans_rvm.inc.c"
-- 
2.19.1
