Received: from eggs.gnu.org ([209.51.188.92]:42478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gkU0i-0005XK-Cg
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gkU0c-0008Ll-To
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:16:36 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 18 Jan 2019 14:14:55 +0100
Message-Id: <20190118131456.32451-35-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 34/35] target/riscv: Splice remaining
 compressed insn pairs for riscv32 vs riscv64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com, kbastian@mail.uni-paderborn.de
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, richard.henderson@linaro.org, qemu-devel@nongnu.org

it splices flwsp_ldsp, fswsp_sdsp, and jal_addiw and makes each of them
reuse the code generator used for the non compressed insns.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/riscv/insn16-32.decode           |  7 +++++
 target/riscv/insn16-64.decode           |  5 ++++
 target/riscv/insn16.decode              | 12 ++------
 target/riscv/insn32.decode              |  3 +-
 target/riscv/insn_trans/trans_rvc.inc.c | 40 -------------------------
 5 files changed, 16 insertions(+), 51 deletions(-)

diff --git a/target/riscv/insn16-32.decode b/target/riscv/insn16-32.decode
index e21a701056..978b8d5834 100644
--- a/target/riscv/insn16-32.decode
+++ b/target/riscv/insn16-32.decode
@@ -22,3 +22,10 @@
 # *** RV32C Standard Extension (Quadrant 0) ***
 flw     011 ... ... .. ... 00   @cl_w
 fsw     111 ... ... .. ... 00   @cs_w
+
+# *** RV32C Standard Extension (Quadrant 1) ***
+jal     001 ......   ..... 01   &j imm=%imm_cj rd=1
+
+# *** RV32C Standard Extension (Quadrant 2) ***
+flw     011 . .....  ..... 10   &i imm=%uimm_6bit_lw %rd rs1=2
+fsw     111 ......   ..... 10   &s imm=%uimm_6bit_sw rs2=2 rs1=%rs2_5
diff --git a/target/riscv/insn16-64.decode b/target/riscv/insn16-64.decode
index de97a45acf..d43055837a 100644
--- a/target/riscv/insn16-64.decode
+++ b/target/riscv/insn16-64.decode
@@ -24,5 +24,10 @@ ld      011  ... ... .. ... 00 @cl_d
 sd      111  ... ... .. ... 00 @cs_d
 
 # *** RV64C Standard Extension (Quadrant 1) ***
+addiw             001 .  .....  ..... 01 @ci
 subw              100 1 11 ... 00 ... 01 @cs_2
 addw              100 1 11 ... 01 ... 01 @cs_2
+
+# *** RV64C Standard Extension (Quadrant 2) ***
+ld      011 .  .....  ..... 10 &i imm=%uimm_6bit_ld %rd rs1=2
+sd      111 ......    ..... 10 &s imm=%uimm_6bit_sd rs2=%rs2_5 rs1=2
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index b075336062..98dd672c7f 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -45,6 +45,7 @@
 &r         rd rs1 rs2   !extern
 &i         imm rs1 rd   !extern
 &s         imm rs1 rs2  !extern
+&j         imm rd       !extern
 
 # Argument sets:
 &ci        imm        rd
@@ -59,12 +60,10 @@
 &c_sd      uimm  rs2
 
 &c_addi16sp_lui  imm_lui imm_addi16sp rd
-&c_flwsp_ldsp    uimm_flwsp uimm_ldsp rd
-&c_fswsp_sdsp    uimm_fswsp uimm_sdsp rs2
 
 # Formats 16:
 @cr        ....  ..... .....  .. &cr                      rs2=%rs2_5  %rd
-@ci        ... . ..... .....  .. &ci     imm=%imm_ci                  %rd
+@ci        ... . ..... .....  .. &i  imm=%imm_ci %rd rs1=%rd
 @ciw       ...   ........ ... .. &ciw    nzuimm=%nzuimm_ciw           rd=%rs2_3
 @cl_d      ... ... ... .. ... .. &i  imm=%uimm_cl_d  rs1=%rs1_3  rd=%rs2_3
 @cl_w      ... ... ... .. ... .. &i  imm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3
@@ -80,10 +79,6 @@
 @c_sw      ... . .....  ..... .. &c_sd     uimm=%uimm_6bit_sw  rs2=%rs2_5
 
 @c_addi16sp_lui ... .  ..... ..... .. &c_addi16sp_lui %imm_lui %imm_addi16sp %rd
-@c_flwsp_ldsp   ... .  ..... ..... .. &c_flwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
-    uimm_ldsp=%uimm_6bit_ld %rd
-@c_fswsp_sdsp   ... .  ..... ..... .. &c_fswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
-    uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5
 
 @c_shift        ... . .. ... ..... .. &c_shift rd=%rs1_3 shamt=%nzuimm_6bit
 @c_shift2       ... . .. ... ..... .. &c_shift rd=%rd    shamt=%nzuimm_6bit
@@ -99,7 +94,6 @@ sw                110  ... ... .. ... 00 @cs_w
 
 # *** RV64C Standard Extension (Quadrant 1) ***
 c_addi            000 .  .....  ..... 01 @ci
-c_jal_addiw       001 .  .....  ..... 01 @ci #Note: parse rd and/or imm manually
 c_li              010 .  .....  ..... 01 @ci
 c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
 c_srli            100 . 00 ...  ..... 01 @c_shift
@@ -117,9 +111,7 @@ c_bnez            111  ... ...  ..... 01 @cb
 c_slli            000 .  .....  ..... 10 @c_shift2
 c_fldsp           001 .  .....  ..... 10 @c_ld
 c_lwsp            010 .  .....  ..... 10 @c_lw
-c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
 c_jr_mv           100 0  .....  ..... 10 @cr
 c_ebreak_jalr_add 100 1  .....  ..... 10 @cr
 c_fsdsp           101   ......  ..... 10 @c_sd
 c_swsp            110 .  .....  ..... 10 @c_sw
-c_fswsp_sdsp      111 .  .....  ..... 10 @c_fswsp_sdsp #C.SDSP:RV64;C.FSWSP:RV32
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b59a00cc42..0e098e05fe 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -38,6 +38,7 @@
 &i    imm rs1 rd
 &r    rd rs1 rs2
 &s    imm rs2 rs1
+&j    imm rd
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
 
@@ -47,7 +48,7 @@
 @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
 @s       .......   ..... ..... ... ..... ....... &s      imm=%imm_s %rs2 %rs1
 @u       ....................      ..... .......         imm=%imm_u          %rd
-@j       ....................      ..... .......         imm=%imm_j          %rd
+@j       ....................      ..... ....... &j      imm=%imm_j          %rd
 
 @sh      ......  ...... .....  ... ..... ....... &shift  shamt=%sh10      %rs1 %rd
 @csr     ............   .....  ... ..... .......               %csr     %rs1 %rd
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index f521daf32e..db9119ec9b 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -38,19 +38,6 @@ static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a)
     return trans_addi(ctx, &arg);
 }
 
-static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
-{
-#ifdef TARGET_RISCV32
-    /* C.JAL */
-    arg_jal arg = { .rd = 1, .imm = a->imm };
-    return trans_jal(ctx, &arg);
-#else
-    /* C.ADDIW */
-    arg_addiw arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
-    return trans_addiw(ctx, &arg);
-#endif
-}
-
 static bool trans_c_li(DisasContext *ctx, arg_c_li *a)
 {
     if (a->rd == 0) {
@@ -163,20 +150,6 @@ static bool trans_c_lwsp(DisasContext *ctx, arg_c_lwsp *a)
     return trans_lw(ctx, &arg);
 }
 
-static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
-{
-#ifdef TARGET_RISCV32
-    /* C.FLWSP */
-    arg_flw arg_flw = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_flwsp };
-    return trans_flw(ctx, &arg_flw);
-#else
-    /* C.LDSP */
-    arg_ld arg_ld = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_ldsp };
-    return trans_ld(ctx, &arg_ld);
-#endif
-    return false;
-}
-
 static bool trans_c_jr_mv(DisasContext *ctx, arg_c_jr_mv *a)
 {
     if (a->rd != 0 && a->rs2 == 0) {
@@ -222,16 +195,3 @@ static bool trans_c_swsp(DisasContext *ctx, arg_c_swsp *a)
     arg_sw arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
     return trans_sw(ctx, &arg);
 }
-
-static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a)
-{
-#ifdef TARGET_RISCV32
-    /* C.FSWSP */
-    arg_fsw a_fsw = { .rs1 = a->rs2, .rs2 = 2, .imm = a->uimm_fswsp };
-    return trans_fsw(ctx, &a_fsw);
-#else
-    /* C.SDSP */
-    arg_sd a_sd = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm_sdsp };
-    return trans_sd(ctx, &a_sd);
-#endif
-}
-- 
2.20.1
