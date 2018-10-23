Received: from eggs.gnu.org ([2001:4830:134:3::10]:54131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEvQt-0005al-Li
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEvQs-0007dL-EX
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:11 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEvQr-0007ZX-DR
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id w5-v6so1415721wrt.2
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 05:05:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 13:04:51 +0100
Message-Id: <20181023120454.28553-5-richard.henderson@linaro.org>
In-Reply-To: <20181023120454.28553-1-richard.henderson@linaro.org>
References: <20181023120454.28553-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/7] target/riscv: Rename some argument sets in
 insn32.decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, sagark@eecs.berkeley.edu, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

For format x, use &x for the argument set and @x for the extract.
This is less confusing than e.g. "arith" for format R.
---
 target/riscv/insn_trans/trans_rvi.inc.c |  2 +-
 target/riscv/translate.c                | 10 +++++-----
 target/riscv/insn32.decode              | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 2ef355019d..7e676fe2e4 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -72,7 +72,7 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     return true;
 }
 
-static bool gen_branch(DisasContext *ctx, arg_branch *a, TCGCond cond)
+static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
 {
     TCGLabel *l = gen_new_label();
     TCGv source1, source2;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ece163e69f..e7fe8720ac 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -326,7 +326,7 @@ bool decode_insn32(DisasContext *ctx, uint32_t insn);
 /* Include the auto-generated decoder for 32 bit insn */
 #include "decode_insn32.inc.c"
 
-static bool gen_arith_imm(DisasContext *ctx, arg_arith_imm *a,
+static bool gen_arith_imm(DisasContext *ctx, arg_i *a,
                           void(*func)(TCGv, TCGv, TCGv))
 {
     TCGv source1, source2;
@@ -344,7 +344,7 @@ static bool gen_arith_imm(DisasContext *ctx, arg_arith_imm *a,
     return true;
 }
 
-static bool gen_arith(DisasContext *ctx, arg_arith *a,
+static bool gen_arith(DisasContext *ctx, arg_r *a,
                       void(*func)(TCGv, TCGv, TCGv))
 {
     TCGv source1, source2;
@@ -363,7 +363,7 @@ static bool gen_arith(DisasContext *ctx, arg_arith *a,
 }
 
 #ifdef TARGET_RISCV64
-static bool gen_arith_w(DisasContext *ctx, arg_arith *a,
+static bool gen_arith_w(DisasContext *ctx, arg_r *a,
                         void(*func)(TCGv, TCGv, TCGv))
 {
     TCGv source1, source2;
@@ -384,8 +384,8 @@ static bool gen_arith_w(DisasContext *ctx, arg_arith *a,
 }
 #endif
 
-static bool gen_shift(DisasContext *ctx, arg_arith *a,
-                        void(*func)(TCGv, TCGv, TCGv))
+static bool gen_shift(DisasContext *ctx, arg_r *a,
+                      void(*func)(TCGv, TCGv, TCGv))
 {
     TCGv source1 = tcg_temp_new();
     TCGv source2 = tcg_temp_new();
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1541c254df..77e093a060 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -38,17 +38,17 @@
 %imm_u    12:s20                 !function=ex_shift_12
 
 # Argument sets:
-&branch    imm rs2 rs1
-&arith_imm imm rs1 rd
-&arith     rd rs1 rs2
+&b         imm rs2 rs1
+&i         imm rs1 rd
+&r         rd rs1 rs2
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
 
 # Formats 32:
 
-@r       .......   ..... ..... ... ..... ....... &arith            %rs2 %rs1 %rd
-@i       ............    ..... ... ..... ....... &arith_imm imm=%imm_i  %rs1 %rd
-@b       .......   ..... ..... ... ..... ....... &branch imm=%imm_b %rs2 %rs1
+@r       .......   ..... ..... ... ..... ....... &r    %rs2 %rs1 %rd
+@i       ............    ..... ... ..... ....... &i    imm=%imm_i %rs1 %rd
+@b       .......   ..... ..... ... ..... ....... &b    imm=%imm_b %rs2 %rs1
 @s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
 @u       ....................      ..... .......         imm=%imm_u          %rd
 @j       ....................      ..... .......         imm=%imm_j          %rd
-- 
2.17.2
