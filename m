Received: from eggs.gnu.org ([2001:4830:134:3::10]:41131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlU2-0002Vp-Se
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlU0-0004js-BH
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:38 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:36898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDlTy-0004TG-5Y
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:36 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Sat, 20 Oct 2018 09:14:45 +0200
Message-Id: <20181020071451.27808-24-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 23/29] target/riscv: Move gen_arith_imm()
 decoding into trans_* functions
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

gen_arith_imm() does a lot of decoding manually, which was hard to read in
case of the shift instructions and is not necessary anymore with decodetree.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
v1 -> v2:
    - trans_arith_imm -> gen_arith_imm
    - Add missing TARGET_RISC64 checks
    - Reimplement shift translators that were omited in [0004/0028]

 target/riscv/insn32.decode              |   3 +-
 target/riscv/insn_trans/trans_rvi.inc.c | 111 ++++++++++++++++++++----
 target/riscv/translate.c                |  99 ++++-----------------
 3 files changed, 113 insertions(+), 100 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index ffb4f00274..7c045d354c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -39,13 +39,14 @@
 
 # Argument sets:
 &branch    imm rs2 rs1
+&arith_imm imm rs1 rd
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
 
 # Formats 32:
 
 @r       .......   ..... ..... ... ..... .......                   %rs2 %rs1 %rd
-@i       ............    ..... ... ..... .......         imm=%imm_i     %rs1 %rd
+@i       ............    ..... ... ..... ....... &arith_imm imm=%imm_i  %rs1 %rd
 @b       .......   ..... ..... ... ..... ....... &branch imm=%imm_b %rs2 %rs1
 @s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
 @u       ....................      ..... .......         imm=%imm_u          %rd
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 48cc50d35f..c82606f058 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -227,52 +227,89 @@ static bool trans_sd(DisasContext *ctx, arg_sd *a, uint32_t insn)
 
 static bool trans_addi(DisasContext *ctx, arg_addi *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_ADDI, a->rd, a->rs1, a->imm);
-    return true;
+    return gen_arith_imm(ctx, a, &tcg_gen_add_tl);
 }
 
 static bool trans_slti(DisasContext *ctx, arg_slti *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_SLTI, a->rd, a->rs1, a->imm);
+    TCGv source1;
+    source1 = tcg_temp_new();
+    gen_get_gpr(source1, a->rs1);
+
+    tcg_gen_setcondi_tl(TCG_COND_LT, source1, source1, a->imm);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
     return true;
 }
 
 static bool trans_sltiu(DisasContext *ctx, arg_sltiu *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_SLTIU, a->rd, a->rs1, a->imm);
+    TCGv source1;
+    source1 = tcg_temp_new();
+    gen_get_gpr(source1, a->rs1);
+
+    tcg_gen_setcondi_tl(TCG_COND_LTU, source1, source1, a->imm);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
     return true;
 }
 
 static bool trans_xori(DisasContext *ctx, arg_xori *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_XORI, a->rd, a->rs1, a->imm);
-    return true;
+    return gen_arith_imm(ctx, a, &tcg_gen_xor_tl);
 }
+
 static bool trans_ori(DisasContext *ctx, arg_ori *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_ORI, a->rd, a->rs1, a->imm);
-    return true;
+    return gen_arith_imm(ctx, a, &tcg_gen_or_tl);
 }
+
 static bool trans_andi(DisasContext *ctx, arg_andi *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_ANDI, a->rd, a->rs1, a->imm);
-    return true;
+    return gen_arith_imm(ctx, a, &tcg_gen_and_tl);
 }
+
 static bool trans_slli(DisasContext *ctx, arg_slli *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_SLLI, a->rd, a->rs1, a->shamt);
+    if (a->rd != 0) {
+        TCGv t = tcg_temp_new();
+        gen_get_gpr(t, a->rs1);
+
+        if (a->shamt >= TARGET_LONG_BITS) {
+            gen_exception_illegal(ctx);
+            return true;
+        }
+        tcg_gen_shli_tl(t, t, a->shamt);
+
+        gen_set_gpr(a->rd, t);
+        tcg_temp_free(t);
+    } /* NOP otherwise */
     return true;
 }
 
 static bool trans_srli(DisasContext *ctx, arg_srli *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_SHIFT_RIGHT_I, a->rd, a->rs1, a->shamt);
+    if (a->rd != 0) {
+        TCGv t = tcg_temp_new();
+        gen_get_gpr(t, a->rs1);
+        tcg_gen_extract_tl(t, t, a->shamt, 64 - a->shamt);
+        gen_set_gpr(a->rd, t);
+        tcg_temp_free(t);
+    } /* NOP otherwise */
     return true;
 }
 
 static bool trans_srai(DisasContext *ctx, arg_srai *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_SHIFT_RIGHT_I, a->rd, a->rs1, a->shamt | 0x400);
+    if (a->rd != 0) {
+        TCGv t = tcg_temp_new();
+        gen_get_gpr(t, a->rs1);
+        tcg_gen_sextract_tl(t, t, a->shamt, 64 - a->shamt);
+        gen_set_gpr(a->rd, t);
+        tcg_temp_free(t);
+    } /* NOP otherwise */
     return true;
 }
 
@@ -338,27 +375,63 @@ static bool trans_and(DisasContext *ctx, arg_and *a, uint32_t insn)
 
 static bool trans_addiw(DisasContext *ctx, arg_addiw *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_ADDIW, a->rd, a->rs1, a->imm);
-    return true;
+#ifdef TARGET_RISCV64
+    bool res = gen_arith_imm(ctx, a, &tcg_gen_add_tl);
+    tcg_gen_ext32s_tl(cpu_gpr[a->rd], cpu_gpr[a->rd]);
+    return res;
+#else
+    return false;
+#endif
 }
 
 static bool trans_slliw(DisasContext *ctx, arg_slliw *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_SLLIW, a->rd, a->rs1, a->shamt);
+#ifdef TARGET_RISCV64
+    TCGv source1;
+    source1 = tcg_temp_new();
+    gen_get_gpr(source1, a->rs1);
+
+    tcg_gen_shli_tl(source1, source1, a->shamt);
+    tcg_gen_ext32s_tl(source1, source1);
+    gen_set_gpr(a->rd, source1);
+
+    tcg_temp_free(source1);
     return true;
+#else
+    return false;
+#endif
 }
 
 static bool trans_srliw(DisasContext *ctx, arg_srliw *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_SHIFT_RIGHT_IW, a->rd, a->rs1, a->shamt);
+#ifdef TARGET_RISCV64
+    TCGv t = tcg_temp_new();
+    gen_get_gpr(t, a->rs1);
+    tcg_gen_extract_tl(t, t, a->shamt, 32 - a->shamt);
+    /* sign-extend for W instructions */
+    tcg_gen_ext32s_tl(t, t);
+    gen_set_gpr(a->rd, t);
+    tcg_temp_free(t);
     return true;
+#else
+    return false;
+#endif
 }
 
 static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a, uint32_t insn)
 {
-    gen_arith_imm(ctx, OPC_RISC_SHIFT_RIGHT_IW , a->rd, a->rs1,
-                  a->shamt | 0x400);
+#ifdef TARGET_RISCV64
+    TCGv t = tcg_temp_new();
+    gen_get_gpr(t, a->rs1);
+    tcg_gen_sextract_tl(t, t, a->shamt, 32 - a->shamt);
+    /* sign-extend for W instructions */
+    tcg_gen_ext32s_tl(t, t);
+    gen_set_gpr(a->rd, t);
+    tcg_temp_free(t);
     return true;
+#else
+    return false;
+#endif
 }
 
 static bool trans_addw(DisasContext *ctx, arg_addw *a, uint32_t insn)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a8dbd00b99..dfd401fe74 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -374,86 +374,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
     tcg_temp_free(source2);
 }
 
-static void gen_arith_imm(DisasContext *ctx, uint32_t opc, int rd,
-        int rs1, target_long imm)
-{
-    TCGv source1 = tcg_temp_new();
-    int shift_len = TARGET_LONG_BITS;
-    int shift_a;
-
-    gen_get_gpr(source1, rs1);
-
-    switch (opc) {
-    case OPC_RISC_ADDI:
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_ADDIW:
-#endif
-        tcg_gen_addi_tl(source1, source1, imm);
-        break;
-    case OPC_RISC_SLTI:
-        tcg_gen_setcondi_tl(TCG_COND_LT, source1, source1, imm);
-        break;
-    case OPC_RISC_SLTIU:
-        tcg_gen_setcondi_tl(TCG_COND_LTU, source1, source1, imm);
-        break;
-    case OPC_RISC_XORI:
-        tcg_gen_xori_tl(source1, source1, imm);
-        break;
-    case OPC_RISC_ORI:
-        tcg_gen_ori_tl(source1, source1, imm);
-        break;
-    case OPC_RISC_ANDI:
-        tcg_gen_andi_tl(source1, source1, imm);
-        break;
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_SLLIW:
-        shift_len = 32;
-        /* FALLTHRU */
-#endif
-    case OPC_RISC_SLLI:
-        if (imm >= shift_len) {
-            goto do_illegal;
-        }
-        tcg_gen_shli_tl(source1, source1, imm);
-        break;
-#if defined(TARGET_RISCV64)
-    case OPC_RISC_SHIFT_RIGHT_IW:
-        shift_len = 32;
-        /* FALLTHRU */
-#endif
-    case OPC_RISC_SHIFT_RIGHT_I:
-        /* differentiate on IMM */
-        shift_a = imm & 0x400;
-        imm &= 0x3ff;
-        if (imm >= shift_len) {
-            goto do_illegal;
-        }
-        if (imm != 0) {
-            if (shift_a) {
-                /* SRAI[W] */
-                tcg_gen_sextract_tl(source1, source1, imm, shift_len - imm);
-            } else {
-                /* SRLI[W] */
-                tcg_gen_extract_tl(source1, source1, imm, shift_len - imm);
-            }
-            /* No further sign-extension needed for W instructions.  */
-            opc &= ~0x8;
-        }
-        break;
-    default:
-    do_illegal:
-        gen_exception_illegal(ctx);
-        return;
-    }
-
-    if (opc & 0x8) { /* sign-extend for W instructions */
-        tcg_gen_ext32s_tl(source1, source1);
-    }
-
-    gen_set_gpr(rd, source1);
-    tcg_temp_free(source1);
-}
-
 static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
                     target_ulong imm)
 {
@@ -535,6 +455,25 @@ static int ex_rvc_register(int reg)
 bool decode_insn32(DisasContext *ctx, uint32_t insn);
 /* Include the auto-generated decoder for 32 bit insn */
 #include "decode_insn32.inc.c"
+
+static bool gen_arith_imm(DisasContext *ctx, arg_arith_imm *a,
+                          void(*func)(TCGv, TCGv, TCGv))
+{
+    TCGv source1, source2;
+    source1 = tcg_temp_new();
+    source2 = tcg_temp_new();
+
+    gen_get_gpr(source1, a->rs1);
+    tcg_gen_movi_tl(source2, a->imm);
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
