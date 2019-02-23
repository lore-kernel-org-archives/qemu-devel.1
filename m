Received: from eggs.gnu.org ([209.51.188.92]:45460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxgkC-0000PX-NW
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxgkA-0007QA-Vs
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:08 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:46941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxgkA-0007Np-KP
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:06 -0500
Received: by mail-pf1-x42d.google.com with SMTP id g6so2742522pfh.13
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 15:30:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 23 Feb 2019 15:29:54 -0800
Message-Id: <20190223232954.7185-8-richard.henderson@linaro.org>
In-Reply-To: <20190223232954.7185-1-richard.henderson@linaro.org>
References: <20190223232954.7185-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RFC 7/7] target/riscv: Use pattern groups for RVC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, f4bug@amsat.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvc.inc.c | 60 +++++++++----------------
 target/riscv/insn16.decode              | 23 +++++++---
 target/riscv/insn32.decode              | 18 ++++----
 3 files changed, 48 insertions(+), 53 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index 631e72c8b5..a81da2f107 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -48,24 +48,6 @@ static bool trans_c_li(DisasContext *ctx, arg_c_li *a)
     return trans_addi(ctx, &arg);
 }
 
-static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a)
-{
-    if (a->rd == 2) {
-        /* C.ADDI16SP */
-        arg_addi arg = { .rd = 2, .rs1 = 2, .imm = a->imm_addi16sp };
-        return trans_addi(ctx, &arg);
-    } else if (a->imm_lui != 0) {
-        /* C.LUI */
-        if (a->rd == 0) {
-            /* Hint: insn is valid but does not affect state */
-            return true;
-        }
-        arg_lui arg = { .rd = a->rd, .imm = a->imm_lui };
-        return trans_lui(ctx, &arg);
-    }
-    return false;
-}
-
 static bool trans_c_srli(DisasContext *ctx, arg_c_srli *a)
 {
     int shamt = a->shamt;
@@ -114,36 +96,38 @@ static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a)
     return trans_slli(ctx, &arg);
 }
 
-static bool trans_c_jr_mv(DisasContext *ctx, arg_c_jr_mv *a)
+static bool trans_c_jr(DisasContext *ctx, arg_c_jr *a)
 {
-    if (a->rd != 0 && a->rs2 == 0) {
-        /* C.JR */
+    if (a->rd != 0) {
         arg_jalr arg = { .rd = 0, .rs1 = a->rd, .imm = 0 };
         return trans_jalr(ctx, &arg);
-    } else if (a->rd != 0 && a->rs2 != 0) {
-        /* C.MV */
+    }
+    return false;
+}
+
+static bool trans_c_mv(DisasContext *ctx, arg_c_mv *a)
+{
+    if (a->rd != 0 && a->rs2 != 0) {
         arg_add arg = { .rd = a->rd, .rs1 = 0, .rs2 = a->rs2 };
         return trans_add(ctx, &arg);
     }
     return false;
 }
 
-static bool trans_c_ebreak_jalr_add(DisasContext *ctx, arg_c_ebreak_jalr_add *a)
+static bool trans_c_jalr(DisasContext *ctx, arg_c_jalr *a)
 {
-    if (a->rd == 0 && a->rs2 == 0) {
-        /* C.EBREAK */
-        arg_ebreak arg = { };
-        return trans_ebreak(ctx, &arg);
-    } else if (a->rd != 0) {
-        if (a->rs2 == 0) {
-            /* C.JALR */
-            arg_jalr arg = { .rd = 1, .rs1 = a->rd, .imm = 0 };
-            return trans_jalr(ctx, &arg);
-        } else {
-            /* C.ADD */
-            arg_add arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-            return trans_add(ctx, &arg);
-        }
+    if (a->rd != 0) {
+        arg_jalr arg = { .rd = 1, .rs1 = a->rd, .imm = 0 };
+        return trans_jalr(ctx, &arg);
+    }
+    return false;
+}
+
+static bool trans_c_add(DisasContext *ctx, arg_c_add *a)
+{
+    if (a->rd != 0 && a->rs2 != 0) {
+        arg_add arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
+        return trans_add(ctx, &arg);
     }
     return false;
 }
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index d88a0c78ab..5b93051a19 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -42,11 +42,13 @@
 
 
 # Argument sets imported from insn32.decode:
+&empty                  !extern
 &r         rd rs1 rs2   !extern
 &i         imm rs1 rd   !extern
 &s         imm rs1 rs2  !extern
 &j         imm rd       !extern
 &b         imm rs2 rs1  !extern
+&u         imm rd       !extern
 
 # Argument sets:
 &ci        imm        rd
@@ -55,8 +57,6 @@
 &cr               rd  rs2
 &c_shift   shamt      rd
 
-&c_addi16sp_lui  imm_lui imm_addi16sp rd
-
 # Formats 16:
 @cr        ....  ..... .....  .. &cr                      rs2=%rs2_5  %rd
 @ci        ... . ..... .....  .. &i  imm=%imm_ci %rd rs1=%rd
@@ -74,8 +74,6 @@
 @c_sd      ... . .....  ..... .. &s  imm=%uimm_6bit_sd  rs1=2 rs2=%rs2_5
 @c_sw      ... . .....  ..... .. &s  imm=%uimm_6bit_sw  rs1=2 rs2=%rs2_5
 
-@c_addi16sp_lui ... .  ..... ..... .. &c_addi16sp_lui %imm_lui %imm_addi16sp %rd
-
 @c_shift        ... . .. ... ..... .. &c_shift rd=%rs1_3 shamt=%nzuimm_6bit
 @c_shift2       ... . .. ... ..... .. &c_shift rd=%rd    shamt=%nzuimm_6bit
 
@@ -92,7 +90,11 @@ sw                110  ... ... .. ... 00 @cs_w
 # *** RV64C Standard Extension (Quadrant 1) ***
 c_addi            000 .  .....  ..... 01 @ci
 c_li              010 .  .....  ..... 01 @ci
-c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
+{
+  # addi16sp
+  addi            011 .  00010  ..... 01 &i rd=2 rs1=2 imm=%imm_addi16sp
+  lui             011 .  .....  ..... 01 &u %rd imm=%imm_lui
+}
 c_srli            100 . 00 ...  ..... 01 @c_shift
 c_srai            100 . 01 ...  ..... 01 @c_shift
 andi              100 . 10 ...  ..... 01 @c_andi
@@ -108,7 +110,14 @@ bne               111  ... ...  ..... 01 @cb # c_bnez
 c_slli            000 .  .....  ..... 10 @c_shift2
 fld               001 .  .....  ..... 10 @c_ld # fldsp
 lw                010 .  .....  ..... 10 @c_lw # lwsp
-c_jr_mv           100 0  .....  ..... 10 @cr
-c_ebreak_jalr_add 100 1  .....  ..... 10 @cr
+{
+  c_jr            100 0  .....  00000 10 %rd
+  c_mv            100 0  .....  ..... 10 @cr
+}
+{
+  ebreak          100 1  00000  00000 10
+  c_jalr          100 1  .....  00000 10 %rd
+  c_add           100 1  .....  ..... 10 @cr
+}
 fsd               101   ......  ..... 10 @c_sd # fsdsp
 sw                110 .  .....  ..... 10 @c_sw # swsp
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0e098e05fe..81bcb5dbb4 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -34,20 +34,22 @@
 %imm_u    12:s20                 !function=ex_shift_12
 
 # Argument sets:
-&b    imm rs2 rs1
-&i    imm rs1 rd
-&r    rd rs1 rs2
-&s    imm rs2 rs1
-&j    imm rd
-&shift     shamt rs1 rd
-&atomic    aq rl rs2 rs1 rd
+&empty
+&b        imm rs2 rs1
+&i        imm rs1 rd
+&r        rd rs1 rs2
+&s        imm rs2 rs1
+&j        imm rd
+&u        imm rd
+&shift    shamt rs1 rd
+&atomic   aq rl rs2 rs1 rd
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
 @i       ............    ..... ... ..... ....... &i      imm=%imm_i     %rs1 %rd
 @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
 @s       .......   ..... ..... ... ..... ....... &s      imm=%imm_s %rs2 %rs1
-@u       ....................      ..... .......         imm=%imm_u          %rd
+@u       ....................      ..... ....... &u      imm=%imm_u          %rd
 @j       ....................      ..... ....... &j      imm=%imm_j          %rd
 
 @sh      ......  ...... .....  ... ..... ....... &shift  shamt=%sh10      %rs1 %rd
-- 
2.17.2
