Received: from eggs.gnu.org ([209.51.188.92]:60203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwtl-0002NV-Jp
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwtN-00030a-EE
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:25 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwtM-0001i4-UT
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:56:09 -0500
Received: by mail-pg1-x542.google.com with SMTP id w7so1295035pgp.13
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:55:18 -0800 (PST)
Date: Wed, 13 Feb 2019 07:54:04 -0800
Message-Id: <20190213155414.22285-26-palmer@sifive.com>
In-Reply-To: <20190213155414.22285-1-palmer@sifive.com>
References: <20190213155414.22285-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH v7 25/35] target/riscv: make ADD/SUB/OR/XOR/AND
 insn use arg lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

manual decoding in gen_arith() is not necessary with decodetree. For now
the function is called trans_arith as the original gen_arith still
exists. The former will be renamed to gen_arith as soon as the old
gen_arith can be removed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode              |  3 +-
 target/riscv/insn_trans/trans_rvi.inc.c | 21 +++++--------
 target/riscv/translate.c                | 40 +++++++++++++++----------
 3 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index d6b4197841f5..6f3ab7aa52d3 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -36,11 +36,12 @@
 # Argument sets:
 &b    imm rs2 rs1
 &i    imm rs1 rd
+&r    rd rs1 rs2
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
 
 # Formats 32:
-@r       .......   ..... ..... ... ..... .......                   %rs2 %rs1 %rd
+@r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
 @i       ............    ..... ... ..... ....... &i      imm=%imm_i     %rs1 %rd
 @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
 @s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index ba9cce2a1410..d322ddf7fc21 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -312,14 +312,12 @@ static bool trans_srai(DisasContext *ctx, arg_srai *a)
 
 static bool trans_add(DisasContext *ctx, arg_add *a)
 {
-    gen_arith(ctx, OPC_RISC_ADD, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_add_tl);
 }
 
 static bool trans_sub(DisasContext *ctx, arg_sub *a)
 {
-    gen_arith(ctx, OPC_RISC_SUB, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_sub_tl);
 }
 
 static bool trans_sll(DisasContext *ctx, arg_sll *a)
@@ -342,8 +340,7 @@ static bool trans_sltu(DisasContext *ctx, arg_sltu *a)
 
 static bool trans_xor(DisasContext *ctx, arg_xor *a)
 {
-    gen_arith(ctx, OPC_RISC_XOR, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_xor_tl);
 }
 
 static bool trans_srl(DisasContext *ctx, arg_srl *a)
@@ -360,14 +357,12 @@ static bool trans_sra(DisasContext *ctx, arg_sra *a)
 
 static bool trans_or(DisasContext *ctx, arg_or *a)
 {
-    gen_arith(ctx, OPC_RISC_OR, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_or_tl);
 }
 
 static bool trans_and(DisasContext *ctx, arg_and *a)
 {
-    gen_arith(ctx, OPC_RISC_AND, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_and_tl);
 }
 
 #ifdef TARGET_RISCV64
@@ -414,14 +409,12 @@ static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
 
 static bool trans_addw(DisasContext *ctx, arg_addw *a)
 {
-    gen_arith(ctx, OPC_RISC_ADDW, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_addw);
 }
 
 static bool trans_subw(DisasContext *ctx, arg_subw *a)
 {
-    gen_arith(ctx, OPC_RISC_SUBW, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &gen_subw);
 }
 
 static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cf75d9b1ff49..99ff11778f8a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -199,12 +199,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
     gen_get_gpr(source2, rs2);
 
     switch (opc) {
-    CASE_OP_32_64(OPC_RISC_ADD):
-        tcg_gen_add_tl(source1, source1, source2);
-        break;
-    CASE_OP_32_64(OPC_RISC_SUB):
-        tcg_gen_sub_tl(source1, source1, source2);
-        break;
 #if defined(TARGET_RISCV64)
     case OPC_RISC_SLLW:
         tcg_gen_andi_tl(source2, source2, 0x1F);
@@ -221,9 +215,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
     case OPC_RISC_SLTU:
         tcg_gen_setcond_tl(TCG_COND_LTU, source1, source1, source2);
         break;
-    case OPC_RISC_XOR:
-        tcg_gen_xor_tl(source1, source1, source2);
-        break;
 #if defined(TARGET_RISCV64)
     case OPC_RISC_SRLW:
         /* clear upper 32 */
@@ -249,12 +240,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
         tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
         tcg_gen_sar_tl(source1, source1, source2);
         break;
-    case OPC_RISC_OR:
-        tcg_gen_or_tl(source1, source1, source2);
-        break;
-    case OPC_RISC_AND:
-        tcg_gen_and_tl(source1, source1, source2);
-        break;
     CASE_OP_32_64(OPC_RISC_MUL):
         if (!has_ext(ctx, RVM)) {
             goto do_illegal;
@@ -725,8 +710,33 @@ static void gen_addw(TCGv ret, TCGv arg1, TCGv arg2)
     tcg_gen_add_tl(ret, arg1, arg2);
     tcg_gen_ext32s_tl(ret, ret);
 }
+
+static void gen_subw(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    tcg_gen_sub_tl(ret, arg1, arg2);
+    tcg_gen_ext32s_tl(ret, ret);
+}
+
 #endif
 
+static bool trans_arith(DisasContext *ctx, arg_r *a,
+                        void(*func)(TCGv, TCGv, TCGv))
+{
+    TCGv source1, source2;
+    source1 = tcg_temp_new();
+    source2 = tcg_temp_new();
+
+    gen_get_gpr(source1, a->rs1);
+    gen_get_gpr(source2, a->rs2);
+
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
2.18.1
