Received: from eggs.gnu.org ([2001:4830:134:3::10]:40108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Ht-00020V-Gi
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hq-0000Sa-AA
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:45 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:60436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1Hp-0000Ey-Sd
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:42 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:42 +0200
Message-Id: <20181012173047.25420-24-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 23/28] target/riscv: make ADD/SUB/OR/XOR/AND
 insn use arg lists
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

manual decoding in gen_arith() is not necessary with decodetree.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode              |  3 ++-
 target/riscv/insn_trans/trans_rvi.inc.c | 21 ++++++----------
 target/riscv/translate.c                | 33 ++++++++++++++-----------
 3 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 806315b830..549cacfdd5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -40,6 +40,7 @@
 # Argument sets:
 &branch    imm rs2 rs1
 &arith_imm imm rs1 rd
+&arith     rd rs1 rs2
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
 
@@ -48,7 +49,7 @@
 @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
 @sfence_vm  ....... ..... .....   ... ..... ....... %rs1
 
-@r       .......   ..... ..... ... ..... .......                   %rs2 %rs1 %rd
+@r       .......   ..... ..... ... ..... ....... &arith            %rs2 %rs1 %rd
 @i       ............    ..... ... ..... ....... &arith_imm imm=%imm_i  %rs1 %rd
 @b       .......   ..... ..... ... ..... ....... &branch imm=%imm_b %rs2 %rs1
 @s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 76d4baab69..cb0c6263bd 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -323,14 +323,12 @@ static bool trans_srai(DisasContext *ctx, arg_srai *a, uint32_t insn)
 
 static bool trans_add(DisasContext *ctx, arg_add *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_ADD, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_add_tl);
 }
 
 static bool trans_sub(DisasContext *ctx, arg_sub *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_SUB, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_sub_tl);
 }
 
 static bool trans_sll(DisasContext *ctx, arg_sll *a, uint32_t insn)
@@ -353,8 +351,7 @@ static bool trans_sltu(DisasContext *ctx, arg_sltu *a, uint32_t insn)
 
 static bool trans_xor(DisasContext *ctx, arg_xor *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_XOR, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_xor_tl);
 }
 
 static bool trans_srl(DisasContext *ctx, arg_srl *a, uint32_t insn)
@@ -371,14 +368,12 @@ static bool trans_sra(DisasContext *ctx, arg_sra *a, uint32_t insn)
 
 static bool trans_or(DisasContext *ctx, arg_or *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_OR, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_or_tl);
 }
 
 static bool trans_and(DisasContext *ctx, arg_and *a, uint32_t insn)
 {
-    gen_arith(ctx, OPC_RISC_AND, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_and_tl);
 }
 
 static bool trans_addiw(DisasContext *ctx, arg_addiw *a, uint32_t insn)
@@ -436,8 +431,7 @@ static bool trans_addw(DisasContext *ctx, arg_addw *a, uint32_t insn)
     gen_exception_illegal(ctx);
     return true;
 #endif
-    gen_arith(ctx, OPC_RISC_ADDW, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_add_tl);
 }
 
 static bool trans_subw(DisasContext *ctx, arg_subw *a, uint32_t insn)
@@ -446,8 +440,7 @@ static bool trans_subw(DisasContext *ctx, arg_subw *a, uint32_t insn)
     gen_exception_illegal(ctx);
     return true;
 #endif
-    gen_arith(ctx, OPC_RISC_SUBW, a->rd, a->rs1, a->rs2);
-    return true;
+    return trans_arith(ctx, a, &tcg_gen_sub_tl);
 }
 
 static bool trans_sllw(DisasContext *ctx, arg_sllw *a, uint32_t insn)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ed1d93af47..92aa4641b0 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -175,12 +175,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
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
@@ -197,9 +191,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
     case OPC_RISC_SLTU:
         tcg_gen_setcond_tl(TCG_COND_LTU, source1, source1, source2);
         break;
-    case OPC_RISC_XOR:
-        tcg_gen_xor_tl(source1, source1, source2);
-        break;
 #if defined(TARGET_RISCV64)
     case OPC_RISC_SRLW:
         /* clear upper 32 */
@@ -225,12 +216,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
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
         tcg_gen_mul_tl(source1, source1, source2);
         break;
@@ -473,6 +458,24 @@ static bool trans_arith_imm(DisasContext *ctx, arg_arith_imm *a,
     return true;
 }
 
+static bool trans_arith(DisasContext *ctx, arg_arith *a,
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
2.19.1
