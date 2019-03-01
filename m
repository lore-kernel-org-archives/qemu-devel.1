Received: from eggs.gnu.org ([209.51.188.92]:49863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gzq3C-0003Da-QY
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gzq35-0002VZ-Kp
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:50:34 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:41929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gzq2n-00026K-DX
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:50:21 -0500
Received: by mail-pg1-x532.google.com with SMTP id m1so12043732pgq.8
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 13:50:13 -0800 (PST)
Date: Fri,  1 Mar 2019 13:49:20 -0800
Message-Id: <20190301214945.4353-10-palmer@sifive.com>
In-Reply-To: <20190301214945.4353-1-palmer@sifive.com>
References: <20190301214945.4353-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 09/34] target/riscv: Convert RV32A insns to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/insn32.decode              |  17 +++
 target/riscv/insn_trans/trans_rva.inc.c | 160 ++++++++++++++++++++++++
 target/riscv/translate.c                |   1 +
 3 files changed, 178 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rva.inc.c

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e53944bf0e40..00b9e2d9a508 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -34,6 +34,7 @@
 # Argument sets:
 &b    imm rs2 rs1
 &shift     shamt rs1 rd
+&atomic    aq rl rs2 rs1 rd
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... .......                   %rs2 %rs1 %rd
@@ -46,6 +47,9 @@
 @sh      ......  ...... .....  ... ..... ....... &shift  shamt=%sh10      %rs1 %rd
 @csr     ............   .....  ... ..... .......               %csr     %rs1 %rd
 
+@atom_ld ..... aq:1 rl:1 ..... ........ ..... ....... &atomic rs2=0     %rs1 %rd
+@atom_st ..... aq:1 rl:1 ..... ........ ..... ....... &atomic %rs2      %rs1 %rd
+
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
 auipc    ....................       ..... 0010111 @u
@@ -102,3 +106,16 @@ div      0000001 .....  ..... 100 ..... 0110011 @r
 divu     0000001 .....  ..... 101 ..... 0110011 @r
 rem      0000001 .....  ..... 110 ..... 0110011 @r
 remu     0000001 .....  ..... 111 ..... 0110011 @r
+
+# *** RV32A Standard Extension ***
+lr_w       00010 . . 00000 ..... 010 ..... 0101111 @atom_ld
+sc_w       00011 . . ..... ..... 010 ..... 0101111 @atom_st
+amoswap_w  00001 . . ..... ..... 010 ..... 0101111 @atom_st
+amoadd_w   00000 . . ..... ..... 010 ..... 0101111 @atom_st
+amoxor_w   00100 . . ..... ..... 010 ..... 0101111 @atom_st
+amoand_w   01100 . . ..... ..... 010 ..... 0101111 @atom_st
+amoor_w    01000 . . ..... ..... 010 ..... 0101111 @atom_st
+amomin_w   10000 . . ..... ..... 010 ..... 0101111 @atom_st
+amomax_w   10100 . . ..... ..... 010 ..... 0101111 @atom_st
+amominu_w  11000 . . ..... ..... 010 ..... 0101111 @atom_st
+amomaxu_w  11100 . . ..... ..... 010 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
new file mode 100644
index 000000000000..5d3c853ca504
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rva.inc.c
@@ -0,0 +1,160 @@
+/*
+ * RISC-V translation routines for the RV64A Standard Extension.
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
+ *                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+static inline bool gen_lr(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
+{
+    TCGv src1 = tcg_temp_new();
+    /* Put addr in load_res, data in load_val.  */
+    gen_get_gpr(src1, a->rs1);
+    if (a->rl) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
+    tcg_gen_qemu_ld_tl(load_val, src1, ctx->mem_idx, mop);
+    if (a->aq) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    }
+    tcg_gen_mov_tl(load_res, src1);
+    gen_set_gpr(a->rd, load_val);
+
+    tcg_temp_free(src1);
+    return true;
+}
+
+static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
+{
+    TCGv src1 = tcg_temp_new();
+    TCGv src2 = tcg_temp_new();
+    TCGv dat = tcg_temp_new();
+    TCGLabel *l1 = gen_new_label();
+    TCGLabel *l2 = gen_new_label();
+
+    gen_get_gpr(src1, a->rs1);
+    tcg_gen_brcond_tl(TCG_COND_NE, load_res, src1, l1);
+
+    gen_get_gpr(src2, a->rs2);
+    /*
+     * Note that the TCG atomic primitives are SC,
+     * so we can ignore AQ/RL along this path.
+     */
+    tcg_gen_atomic_cmpxchg_tl(src1, load_res, load_val, src2,
+                              ctx->mem_idx, mop);
+    tcg_gen_setcond_tl(TCG_COND_NE, dat, src1, load_val);
+    gen_set_gpr(a->rd, dat);
+    tcg_gen_br(l2);
+
+    gen_set_label(l1);
+    /*
+     * Address comparion failure.  However, we still need to
+     * provide the memory barrier implied by AQ/RL.
+     */
+    tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + a->rl * TCG_BAR_STRL);
+    tcg_gen_movi_tl(dat, 1);
+    gen_set_gpr(a->rd, dat);
+
+    gen_set_label(l2);
+    tcg_temp_free(dat);
+    tcg_temp_free(src1);
+    tcg_temp_free(src2);
+    return true;
+}
+
+static bool gen_amo(DisasContext *ctx, arg_atomic *a,
+                    void(*func)(TCGv, TCGv, TCGv, TCGArg, TCGMemOp),
+                    TCGMemOp mop)
+{
+    TCGv src1 = tcg_temp_new();
+    TCGv src2 = tcg_temp_new();
+
+    gen_get_gpr(src1, a->rs1);
+    gen_get_gpr(src2, a->rs2);
+
+    (*func)(src2, src1, src2, ctx->mem_idx, mop);
+
+    gen_set_gpr(a->rd, src2);
+    tcg_temp_free(src1);
+    tcg_temp_free(src2);
+    return true;
+}
+
+static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_sc(ctx, a, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESL));
+}
+
+static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
+{
+    REQUIRE_EXT(ctx, RVA);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESL));
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 783ccade5180..b0de062a4fd1 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1853,6 +1853,7 @@ bool decode_insn32(DisasContext *ctx, uint32_t insn);
 /* Include insn module translation function */
 #include "insn_trans/trans_rvi.inc.c"
 #include "insn_trans/trans_rvm.inc.c"
+#include "insn_trans/trans_rva.inc.c"
 
 static void decode_RV32_64G(DisasContext *ctx)
 {
-- 
2.18.1
