Received: from eggs.gnu.org ([209.51.188.92]:57782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gszFS-00056v-GH
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 19:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gszFK-0002Yi-61
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 19:14:58 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:43152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gszFD-0002SS-KB
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 19:14:45 -0500
Received: by mail-lf1-x143.google.com with SMTP id j1so6369636lfb.10
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 16:14:40 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 10 Feb 2019 16:14:24 -0800
Message-Id: <20190211001424.18776-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: don't specify windowed
 registers manually
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Use libisa to extract whether opcode uses windowed registers and
construct mask based on that. This only leaves special case for the
'entry' opcode, as it needs to probe a register dynamically.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |   2 +-
 target/xtensa/helper.c    |   1 +
 target/xtensa/translate.c | 493 +---------------------------------------------
 3 files changed, 12 insertions(+), 484 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index b665bfc0068a..f1861244720e 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -380,7 +380,6 @@ typedef struct XtensaOpcodeOps {
     XtensaOpcodeUintTest test_overflow;
     const uint32_t *par;
     uint32_t op_flags;
-    uint32_t windowed_register_op;
     uint32_t coprocessor;
 } XtensaOpcodeOps;
 
@@ -438,6 +437,7 @@ struct XtensaConfig {
     xtensa_isa isa;
     XtensaOpcodeOps **opcode_ops;
     const XtensaOpcodeTranslators **opcode_translators;
+    xtensa_regfile a_regfile;
 
     uint32_t clock_freq_khz;
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index bcf2f20d4858..6cf1dbb8a69b 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -88,6 +88,7 @@ static void init_libisa(XtensaConfig *config)
 #endif
         config->opcode_ops[i] = ops;
     }
+    config->a_regfile = xtensa_regfile_lookup(config->isa, "AR");
 }
 
 void xtensa_finalize_config(XtensaConfig *config)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index d1e9f59b31bd..6e4f0ad44c80 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -916,6 +916,16 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         opnds = xtensa_opcode_num_operands(isa, opc);
 
         for (opnd = vopnd = 0; opnd < opnds; ++opnd) {
+            if (xtensa_operand_is_register(isa, opc, opnd) &&
+                xtensa_operand_regfile(isa, opc, opnd) ==
+                dc->config->a_regfile) {
+                uint32_t v;
+
+                xtensa_operand_get_field(isa, opc, opnd, fmt, slot,
+                                         dc->slotbuf, &v);
+                xtensa_operand_decode(isa, opc, opnd, &v);
+                windowed_register |= 1u << v;
+            }
             if (xtensa_operand_is_visible(isa, opc, opnd)) {
                 uint32_t v;
 
@@ -952,16 +962,6 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         if (ops->test_overflow) {
             windowed_register |= ops->test_overflow(dc, arg, ops->par);
         }
-        if (ops->windowed_register_op) {
-            uint32_t reg_opnd = ops->windowed_register_op;
-
-            while (reg_opnd) {
-                unsigned i = ctz32(reg_opnd);
-
-                windowed_register |= 1 << arg[i];
-                reg_opnd ^= 1 << i;
-            }
-        }
         coprocessor |= ops->coprocessor;
     }
 
@@ -1474,12 +1474,6 @@ static void translate_call0(DisasContext *dc, const uint32_t arg[],
     gen_jumpi(dc, arg[0], 0);
 }
 
-static uint32_t test_overflow_callw(DisasContext *dc, const uint32_t arg[],
-                                    const uint32_t par[])
-{
-    return 1 << (par[0] * 4);
-}
-
 static void translate_callw(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
@@ -2435,42 +2429,33 @@ static const XtensaOpcodeOps core_ops[] = {
     {
         .name = "abs",
         .translate = translate_abs,
-        .windowed_register_op = 0x3,
     }, {
         .name = "add",
         .translate = translate_add,
-        .windowed_register_op = 0x7,
     }, {
         .name = "add.n",
         .translate = translate_add,
-        .windowed_register_op = 0x7,
     }, {
         .name = "addi",
         .translate = translate_addi,
-        .windowed_register_op = 0x3,
     }, {
         .name = "addi.n",
         .translate = translate_addi,
-        .windowed_register_op = 0x3,
     }, {
         .name = "addmi",
         .translate = translate_addi,
-        .windowed_register_op = 0x3,
     }, {
         .name = "addx2",
         .translate = translate_addx,
         .par = (const uint32_t[]){1},
-        .windowed_register_op = 0x7,
     }, {
         .name = "addx4",
         .translate = translate_addx,
         .par = (const uint32_t[]){2},
-        .windowed_register_op = 0x7,
     }, {
         .name = "addx8",
         .translate = translate_addx,
         .par = (const uint32_t[]){3},
-        .windowed_register_op = 0x7,
     }, {
         .name = "all4",
         .translate = translate_all,
@@ -2482,7 +2467,6 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "and",
         .translate = translate_and,
-        .windowed_register_op = 0x7,
     }, {
         .name = "andb",
         .translate = translate_boolean,
@@ -2503,52 +2487,42 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "ball",
         .translate = translate_ball,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x3,
     }, {
         .name = "bany",
         .translate = translate_bany,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x3,
     }, {
         .name = "bbc",
         .translate = translate_bb,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x3,
     }, {
         .name = "bbci",
         .translate = translate_bbi,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x1,
     }, {
         .name = "bbs",
         .translate = translate_bb,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x3,
     }, {
         .name = "bbsi",
         .translate = translate_bbi,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x1,
     }, {
         .name = "beq",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x3,
     }, {
         .name = "beqi",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x1,
     }, {
         .name = "beqz",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x1,
     }, {
         .name = "beqz.n",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x1,
     }, {
         .name = "bf",
         .translate = translate_bp,
@@ -2557,82 +2531,66 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "bge",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_GE},
-        .windowed_register_op = 0x3,
     }, {
         .name = "bgei",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_GE},
-        .windowed_register_op = 0x1,
     }, {
         .name = "bgeu",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_GEU},
-        .windowed_register_op = 0x3,
     }, {
         .name = "bgeui",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_GEU},
-        .windowed_register_op = 0x1,
     }, {
         .name = "bgez",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_GE},
-        .windowed_register_op = 0x1,
     }, {
         .name = "blt",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_LT},
-        .windowed_register_op = 0x3,
     }, {
         .name = "blti",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_LT},
-        .windowed_register_op = 0x1,
     }, {
         .name = "bltu",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_LTU},
-        .windowed_register_op = 0x3,
     }, {
         .name = "bltui",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_LTU},
-        .windowed_register_op = 0x1,
     }, {
         .name = "bltz",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_LT},
-        .windowed_register_op = 0x1,
     }, {
         .name = "bnall",
         .translate = translate_ball,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x3,
     }, {
         .name = "bne",
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x3,
     }, {
         .name = "bnei",
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x1,
     }, {
         .name = "bnez",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x1,
     }, {
         .name = "bnez.n",
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x1,
     }, {
         .name = "bnone",
         .translate = translate_bany,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x3,
     }, {
         .name = "break",
         .translate = translate_nop,
@@ -2653,114 +2611,88 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "call12",
         .translate = translate_callw,
-        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){3},
     }, {
         .name = "call4",
         .translate = translate_callw,
-        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){1},
     }, {
         .name = "call8",
         .translate = translate_callw,
-        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){2},
     }, {
         .name = "callx0",
         .translate = translate_callx0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "callx12",
         .translate = translate_callxw,
-        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){3},
-        .windowed_register_op = 0x1,
     }, {
         .name = "callx4",
         .translate = translate_callxw,
-        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){1},
-        .windowed_register_op = 0x1,
     }, {
         .name = "callx8",
         .translate = translate_callxw,
-        .test_overflow = test_overflow_callw,
         .par = (const uint32_t[]){2},
-        .windowed_register_op = 0x1,
     }, {
         .name = "clamps",
         .translate = translate_clamps,
-        .windowed_register_op = 0x3,
     }, {
         .name = "clrb_expstate",
         .translate = translate_clrb_expstate,
     }, {
         .name = "const16",
         .translate = translate_const16,
-        .windowed_register_op = 0x1,
     }, {
         .name = "depbits",
         .translate = translate_depbits,
-        .windowed_register_op = 0x3,
     }, {
         .name = "dhi",
         .translate = translate_dcache,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "dhu",
         .translate = translate_dcache,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "dhwb",
         .translate = translate_dcache,
-        .windowed_register_op = 0x1,
     }, {
         .name = "dhwbi",
         .translate = translate_dcache,
-        .windowed_register_op = 0x1,
     }, {
         .name = "dii",
         .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "diu",
         .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "diwb",
         .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "diwbi",
         .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "dpfl",
         .translate = translate_dcache,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "dpfr",
         .translate = translate_nop,
-        .windowed_register_op = 0x1,
     }, {
         .name = "dpfro",
         .translate = translate_nop,
-        .windowed_register_op = 0x1,
     }, {
         .name = "dpfw",
         .translate = translate_nop,
-        .windowed_register_op = 0x1,
     }, {
         .name = "dpfwo",
         .translate = translate_nop,
-        .windowed_register_op = 0x1,
     }, {
         .name = "dsync",
         .translate = translate_nop,
@@ -2779,7 +2711,6 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "extui",
         .translate = translate_extui,
-        .windowed_register_op = 0x3,
     }, {
         .name = "extw",
         .translate = translate_memw,
@@ -2794,32 +2725,26 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_itlb,
         .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "ihi",
         .translate = translate_icache,
-        .windowed_register_op = 0x1,
     }, {
         .name = "ihu",
         .translate = translate_icache,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "iii",
         .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "iitlb",
         .translate = translate_itlb,
         .par = (const uint32_t[]){false},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "iiu",
         .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "ill",
         .op_flags = XTENSA_OP_ILL,
@@ -2829,12 +2754,10 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "ipf",
         .translate = translate_nop,
-        .windowed_register_op = 0x1,
     }, {
         .name = "ipfl",
         .translate = translate_icache,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "isync",
         .translate = translate_nop,
@@ -2844,56 +2767,45 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "jx",
         .translate = translate_jx,
-        .windowed_register_op = 0x1,
     }, {
         .name = "l16si",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TESW, false, false},
-        .windowed_register_op = 0x3,
     }, {
         .name = "l16ui",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUW, false, false},
-        .windowed_register_op = 0x3,
     }, {
         .name = "l32ai",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, true, false},
-        .windowed_register_op = 0x3,
     }, {
         .name = "l32e",
         .translate = translate_l32e,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x3,
     }, {
         .name = "l32i",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, false},
-        .windowed_register_op = 0x3,
     }, {
         .name = "l32i.n",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, false},
-        .windowed_register_op = 0x3,
     }, {
         .name = "l32r",
         .translate = translate_l32r,
-        .windowed_register_op = 0x1,
     }, {
         .name = "l8ui",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_UB, false, false},
-        .windowed_register_op = 0x3,
     }, {
         .name = "lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_NONE, 0, 0, -4},
-        .windowed_register_op = 0x2,
     }, {
         .name = "ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_NONE, 0, 0, 4},
-        .windowed_register_op = 0x2,
     }, {
         .name = "ldpte",
         .op_flags = XTENSA_OP_ILL,
@@ -2901,147 +2813,117 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "loop",
         .translate = translate_loop,
         .par = (const uint32_t[]){TCG_COND_NEVER},
-        .windowed_register_op = 0x1,
     }, {
         .name = "loopgtz",
         .translate = translate_loop,
         .par = (const uint32_t[]){TCG_COND_GT},
-        .windowed_register_op = 0x1,
     }, {
         .name = "loopnez",
         .translate = translate_loop,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x1,
     }, {
         .name = "max",
         .translate = translate_smax,
-        .windowed_register_op = 0x7,
     }, {
         .name = "maxu",
         .translate = translate_umax,
-        .windowed_register_op = 0x7,
     }, {
         .name = "memw",
         .translate = translate_memw,
     }, {
         .name = "min",
         .translate = translate_smin,
-        .windowed_register_op = 0x7,
     }, {
         .name = "minu",
         .translate = translate_umin,
-        .windowed_register_op = 0x7,
     }, {
         .name = "mov",
         .translate = translate_mov,
-        .windowed_register_op = 0x3,
     }, {
         .name = "mov.n",
         .translate = translate_mov,
-        .windowed_register_op = 0x3,
     }, {
         .name = "moveqz",
         .translate = translate_movcond,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x7,
     }, {
         .name = "movf",
         .translate = translate_movp,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x3,
     }, {
         .name = "movgez",
         .translate = translate_movcond,
         .par = (const uint32_t[]){TCG_COND_GE},
-        .windowed_register_op = 0x7,
     }, {
         .name = "movi",
         .translate = translate_movi,
-        .windowed_register_op = 0x1,
     }, {
         .name = "movi.n",
         .translate = translate_movi,
-        .windowed_register_op = 0x1,
     }, {
         .name = "movltz",
         .translate = translate_movcond,
         .par = (const uint32_t[]){TCG_COND_LT},
-        .windowed_register_op = 0x7,
     }, {
         .name = "movnez",
         .translate = translate_movcond,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x7,
     }, {
         .name = "movsp",
         .translate = translate_movsp,
-        .windowed_register_op = 0x3,
         .op_flags = XTENSA_OP_ALLOCA,
     }, {
         .name = "movt",
         .translate = translate_movp,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x3,
     }, {
         .name = "mul.aa.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_HH, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "mul.aa.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_HL, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "mul.aa.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_LH, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "mul.aa.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_LL, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "mul.ad.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_HH, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "mul.ad.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_HL, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "mul.ad.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_LH, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "mul.ad.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_LL, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "mul.da.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_HH, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mul.da.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_HL, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mul.da.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_LH, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mul.da.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_LL, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mul.dd.hh",
         .translate = translate_mac16,
@@ -3062,112 +2944,90 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mul16s",
         .translate = translate_mul16,
         .par = (const uint32_t[]){true},
-        .windowed_register_op = 0x7,
     }, {
         .name = "mul16u",
         .translate = translate_mul16,
         .par = (const uint32_t[]){false},
-        .windowed_register_op = 0x7,
     }, {
         .name = "mula.aa.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_HH, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "mula.aa.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_HL, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "mula.aa.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_LH, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "mula.aa.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_LL, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "mula.ad.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_HH, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "mula.ad.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_HL, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "mula.ad.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_LH, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "mula.ad.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_LL, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "mula.da.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.da.hh.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, -4},
-        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.hh.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, 4},
-        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.da.hl.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, -4},
-        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.hl.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, 4},
-        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.da.lh.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, -4},
-        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.lh.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, 4},
-        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.da.ll.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, -4},
-        .windowed_register_op = 0xa,
     }, {
         .name = "mula.da.ll.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, 4},
-        .windowed_register_op = 0xa,
     }, {
         .name = "mula.dd.hh",
         .translate = translate_mac16,
@@ -3176,12 +3036,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mula.dd.hh.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HH, -4},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.hh.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HH, 4},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.hl",
         .translate = translate_mac16,
@@ -3190,12 +3048,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mula.dd.hl.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HL, -4},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.hl.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HL, 4},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.lh",
         .translate = translate_mac16,
@@ -3204,12 +3060,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mula.dd.lh.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LH, -4},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.lh.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LH, 4},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.ll",
         .translate = translate_mac16,
@@ -3218,76 +3072,61 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mula.dd.ll.lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LL, -4},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mula.dd.ll.ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LL, 4},
-        .windowed_register_op = 0x2,
     }, {
         .name = "mull",
         .translate = translate_mull,
-        .windowed_register_op = 0x7,
     }, {
         .name = "muls.aa.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_HH, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "muls.aa.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_HL, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "muls.aa.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_LH, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "muls.aa.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_LL, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "muls.ad.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_HH, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "muls.ad.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_HL, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "muls.ad.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_LH, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "muls.ad.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_LL, 0},
-        .windowed_register_op = 0x1,
     }, {
         .name = "muls.da.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_HH, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "muls.da.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_HL, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "muls.da.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_LH, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "muls.da.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_LL, 0},
-        .windowed_register_op = 0x2,
     }, {
         .name = "muls.dd.hh",
         .translate = translate_mac16,
@@ -3308,16 +3147,13 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "mulsh",
         .translate = translate_mulh,
         .par = (const uint32_t[]){true},
-        .windowed_register_op = 0x7,
     }, {
         .name = "muluh",
         .translate = translate_mulh,
         .par = (const uint32_t[]){false},
-        .windowed_register_op = 0x7,
     }, {
         .name = "neg",
         .translate = translate_neg,
-        .windowed_register_op = 0x3,
     }, {
         .name = "nop",
         .translate = translate_nop,
@@ -3327,15 +3163,12 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "nsa",
         .translate = translate_nsa,
-        .windowed_register_op = 0x3,
     }, {
         .name = "nsau",
         .translate = translate_nsau,
-        .windowed_register_op = 0x3,
     }, {
         .name = "or",
         .translate = translate_or,
-        .windowed_register_op = 0x7,
     }, {
         .name = "orb",
         .translate = translate_boolean,
@@ -3349,56 +3182,46 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_ptlb,
         .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x3,
     }, {
         .name = "pitlb",
         .translate = translate_ptlb,
         .par = (const uint32_t[]){false},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x3,
     }, {
         .name = "quos",
         .translate = translate_quos,
         .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_DIVIDE_BY_ZERO,
-        .windowed_register_op = 0x7,
     }, {
         .name = "quou",
         .translate = translate_quou,
         .op_flags = XTENSA_OP_DIVIDE_BY_ZERO,
-        .windowed_register_op = 0x7,
     }, {
         .name = "rdtlb0",
         .translate = translate_rtlb,
         .par = (const uint32_t[]){true, 0},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x3,
     }, {
         .name = "rdtlb1",
         .translate = translate_rtlb,
         .par = (const uint32_t[]){true, 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x3,
     }, {
         .name = "read_impwire",
         .translate = translate_read_impwire,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rems",
         .translate = translate_quos,
         .par = (const uint32_t[]){false},
         .op_flags = XTENSA_OP_DIVIDE_BY_ZERO,
-        .windowed_register_op = 0x7,
     }, {
         .name = "remu",
         .translate = translate_remu,
         .op_flags = XTENSA_OP_DIVIDE_BY_ZERO,
-        .windowed_register_op = 0x7,
     }, {
         .name = "rer",
         .translate = translate_rer,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x3,
     }, {
         .name = "ret",
         .translate = translate_ret,
@@ -3448,13 +3271,11 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rtlb,
         .par = (const uint32_t[]){false, 0},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x3,
     }, {
         .name = "ritlb1",
         .translate = translate_rtlb,
         .par = (const uint32_t[]){false, 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x3,
     }, {
         .name = "rotw",
         .translate = translate_rotw,
@@ -3466,526 +3287,449 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.176",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){176},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.208",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){208},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.acchi",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ACCHI},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.acclo",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ACCLO},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.atomctl",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ATOMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.br",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){BR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.cacheattr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CACHEATTR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ccompare0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ccompare1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ccompare2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ccount",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.configid0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CONFIGID0},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.configid1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CONFIGID1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.cpenable",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CPENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.dbreaka0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.dbreaka1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.dbreakc0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKC},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.dbreakc1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ddr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.debugcause",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.depc",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DEPC},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.dtlbcfg",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DTLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc4",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc5",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc6",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.epc7",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps4",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps5",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps6",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.eps7",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.exccause",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave4",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave5",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave6",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excsave7",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.excvaddr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ibreaka0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ibreaka1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ibreakenable",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.icount",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ICOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.icountlevel",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.intclear",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTCLEAR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.intenable",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.interrupt",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTSET},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.intset",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTSET},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.itlbcfg",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ITLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.lbeg",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LBEG},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.lcount",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LCOUNT},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.lend",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LEND},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.litbase",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){LITBASE},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.m0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.m1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR + 1},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.m2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR + 2},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.m3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MR + 3},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.memctl",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.misc0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.misc1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.misc2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.misc3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.prid",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PRID},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ps",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PS},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.ptevaddr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PTEVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.rasid",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){RASID},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.sar",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){SAR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.scompare1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){SCOMPARE1},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.vecbase",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){VECBASE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.windowbase",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){WINDOW_BASE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsr.windowstart",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){WINDOW_START},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "rsync",
         .translate = translate_nop,
@@ -3993,80 +3737,65 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "rur.expstate",
         .translate = translate_rur,
         .par = (const uint32_t[]){EXPSTATE},
-        .windowed_register_op = 0x1,
     }, {
         .name = "rur.fcr",
         .translate = translate_rur,
         .par = (const uint32_t[]){FCR},
-        .windowed_register_op = 0x1,
         .coprocessor = 0x1,
     }, {
         .name = "rur.fsr",
         .translate = translate_rur,
         .par = (const uint32_t[]){FSR},
-        .windowed_register_op = 0x1,
         .coprocessor = 0x1,
     }, {
         .name = "rur.threadptr",
         .translate = translate_rur,
         .par = (const uint32_t[]){THREADPTR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "s16i",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUW, false, true},
-        .windowed_register_op = 0x3,
     }, {
         .name = "s32c1i",
         .translate = translate_s32c1i,
-        .windowed_register_op = 0x3,
     }, {
         .name = "s32e",
         .translate = translate_s32e,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x3,
     }, {
         .name = "s32i",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, true},
-        .windowed_register_op = 0x3,
     }, {
         .name = "s32i.n",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, true},
-        .windowed_register_op = 0x3,
     }, {
         .name = "s32nb",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, true},
-        .windowed_register_op = 0x3,
     }, {
         .name = "s32ri",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, true, true},
-        .windowed_register_op = 0x3,
     }, {
         .name = "s8i",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_UB, false, true},
-        .windowed_register_op = 0x3,
     }, {
         .name = "salt",
         .translate = translate_salt,
         .par = (const uint32_t[]){TCG_COND_LT},
-        .windowed_register_op = 0x7,
     }, {
         .name = "saltu",
         .translate = translate_salt,
         .par = (const uint32_t[]){TCG_COND_LTU},
-        .windowed_register_op = 0x7,
     }, {
         .name = "setb_expstate",
         .translate = translate_setb_expstate,
     }, {
         .name = "sext",
         .translate = translate_sext,
-        .windowed_register_op = 0x3,
     }, {
         .name = "simcall",
         .translate = translate_simcall,
@@ -4075,69 +3804,54 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "sll",
         .translate = translate_sll,
-        .windowed_register_op = 0x3,
     }, {
         .name = "slli",
         .translate = translate_slli,
-        .windowed_register_op = 0x3,
     }, {
         .name = "sra",
         .translate = translate_sra,
-        .windowed_register_op = 0x3,
     }, {
         .name = "srai",
         .translate = translate_srai,
-        .windowed_register_op = 0x3,
     }, {
         .name = "src",
         .translate = translate_src,
-        .windowed_register_op = 0x7,
     }, {
         .name = "srl",
         .translate = translate_srl,
-        .windowed_register_op = 0x3,
     }, {
         .name = "srli",
         .translate = translate_srli,
-        .windowed_register_op = 0x3,
     }, {
         .name = "ssa8b",
         .translate = translate_ssa8b,
-        .windowed_register_op = 0x1,
     }, {
         .name = "ssa8l",
         .translate = translate_ssa8l,
-        .windowed_register_op = 0x1,
     }, {
         .name = "ssai",
         .translate = translate_ssai,
     }, {
         .name = "ssl",
         .translate = translate_ssl,
-        .windowed_register_op = 0x1,
     }, {
         .name = "ssr",
         .translate = translate_ssr,
-        .windowed_register_op = 0x1,
     }, {
         .name = "sub",
         .translate = translate_sub,
-        .windowed_register_op = 0x7,
     }, {
         .name = "subx2",
         .translate = translate_subx,
         .par = (const uint32_t[]){1},
-        .windowed_register_op = 0x7,
     }, {
         .name = "subx4",
         .translate = translate_subx,
         .par = (const uint32_t[]){2},
-        .windowed_register_op = 0x7,
     }, {
         .name = "subx8",
         .translate = translate_subx,
         .par = (const uint32_t[]){3},
-        .windowed_register_op = 0x7,
     }, {
         .name = "syscall",
         .op_flags = XTENSA_OP_SYSCALL,
@@ -4145,22 +3859,18 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "umul.aa.hh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_HH, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "umul.aa.hl",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_HL, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "umul.aa.lh",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_LH, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "umul.aa.ll",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_LL, 0},
-        .windowed_register_op = 0x3,
     }, {
         .name = "waiti",
         .translate = translate_waiti,
@@ -4170,362 +3880,309 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wtlb,
         .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x3,
     }, {
         .name = "wer",
         .translate = translate_wer,
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x3,
     }, {
         .name = "witlb",
         .translate = translate_wtlb,
         .par = (const uint32_t[]){false},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x3,
     }, {
         .name = "wrmsk_expstate",
         .translate = translate_wrmsk_expstate,
-        .windowed_register_op = 0x3,
     }, {
         .name = "wsr.176",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){176},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.208",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){208},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.acchi",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ACCHI},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.acclo",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ACCLO},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.atomctl",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ATOMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.br",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){BR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.cacheattr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CACHEATTR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccompare0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccompare1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccompare2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccount",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.configid0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CONFIGID0},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.configid1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CONFIGID1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.cpenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CPENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dbreaka0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dbreaka1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dbreakc0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKC},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dbreakc1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ddr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.debugcause",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.depc",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DEPC},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dtlbcfg",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DTLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc4",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc5",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc6",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.epc7",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps4",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps5",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps6",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.eps7",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.exccause",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave4",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave5",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave6",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excsave7",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.excvaddr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ibreaka0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ibreaka1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ibreakenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.icount",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ICOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.icountlevel",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intclear",
         .translate = translate_wsr,
@@ -4535,7 +4192,6 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intenable",
         .translate = translate_wsr,
@@ -4545,7 +4201,6 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.interrupt",
         .translate = translate_wsr,
@@ -4555,7 +4210,6 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intset",
         .translate = translate_wsr,
@@ -4565,114 +4219,97 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.itlbcfg",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ITLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.lbeg",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LBEG},
         .op_flags = XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.lcount",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LCOUNT},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.lend",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LEND},
         .op_flags = XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.litbase",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LITBASE},
         .op_flags = XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.m0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.m1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR + 1},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.m2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR + 2},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.m3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MR + 3},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.memctl",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.misc0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.misc1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.misc2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.misc3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.mmid",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MMID},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.prid",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PRID},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ps",
         .translate = translate_wsr,
@@ -4682,80 +4319,67 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_M1 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ptevaddr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PTEVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.rasid",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){RASID},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.sar",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){SAR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.scompare1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){SCOMPARE1},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.vecbase",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){VECBASE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.windowbase",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_BASE},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wsr.windowstart",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_START},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "wur.expstate",
         .translate = translate_wur,
         .par = (const uint32_t[]){EXPSTATE},
-        .windowed_register_op = 0x1,
     }, {
         .name = "wur.fcr",
         .translate = translate_wur,
         .par = (const uint32_t[]){FCR},
-        .windowed_register_op = 0x1,
         .coprocessor = 0x1,
     }, {
         .name = "wur.fsr",
         .translate = translate_wur,
         .par = (const uint32_t[]){FSR},
-        .windowed_register_op = 0x1,
         .coprocessor = 0x1,
     }, {
         .name = "wur.threadptr",
         .translate = translate_wur,
         .par = (const uint32_t[]){THREADPTR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xor",
         .translate = translate_xor,
-        .windowed_register_op = 0x7,
     }, {
         .name = "xorb",
         .translate = translate_boolean,
@@ -4766,340 +4390,291 @@ static const XtensaOpcodeOps core_ops[] = {
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){176},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.208",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){208},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.acchi",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ACCHI},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.acclo",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ACCLO},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.atomctl",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ATOMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.br",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){BR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.cacheattr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CACHEATTR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccompare0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccompare1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccompare2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccount",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.configid0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CONFIGID0},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.configid1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CONFIGID1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.cpenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CPENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dbreaka0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dbreaka1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dbreakc0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKC},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dbreakc1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ddr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.debugcause",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.depc",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DEPC},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dtlbcfg",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DTLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc4",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc5",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc6",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.epc7",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps4",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps5",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps6",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.eps7",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.exccause",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCCAUSE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave4",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave5",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave6",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excsave7",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.excvaddr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ibreaka0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKA},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ibreaka1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKA + 1},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ibreakenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKENABLE},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.icount",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ICOUNT},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.icountlevel",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intclear",
         .translate = translate_xsr,
@@ -5109,7 +4684,6 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intenable",
         .translate = translate_xsr,
@@ -5119,7 +4693,6 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.interrupt",
         .translate = translate_xsr,
@@ -5129,7 +4702,6 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intset",
         .translate = translate_xsr,
@@ -5139,107 +4711,91 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.itlbcfg",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ITLBCFG},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.lbeg",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LBEG},
         .op_flags = XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.lcount",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LCOUNT},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.lend",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LEND},
         .op_flags = XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.litbase",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LITBASE},
         .op_flags = XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.m0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.m1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR + 1},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.m2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR + 2},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.m3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MR + 3},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.memctl",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.misc0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.misc1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.misc2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 2},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.misc3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 3},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.prid",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PRID},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ps",
         .translate = translate_xsr,
@@ -5249,54 +4805,46 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_M1 |
             XTENSA_OP_CHECK_INTERRUPTS,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ptevaddr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PTEVADDR},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.rasid",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){RASID},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.sar",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){SAR},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.scompare1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){SCOMPARE1},
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.vecbase",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){VECBASE},
         .op_flags = XTENSA_OP_PRIVILEGED,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.windowbase",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_BASE},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     }, {
         .name = "xsr.windowstart",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_START},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
-        .windowed_register_op = 0x1,
     },
 };
 
@@ -5504,43 +5052,36 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "ceil.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_up, false},
-        .windowed_register_op = 0x1,
         .coprocessor = 0x1,
     }, {
         .name = "float.s",
         .translate = translate_float_s,
         .par = (const uint32_t[]){false},
-        .windowed_register_op = 0x2,
         .coprocessor = 0x1,
     }, {
         .name = "floor.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_down, false},
-        .windowed_register_op = 0x1,
         .coprocessor = 0x1,
     }, {
         .name = "lsi",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){false, false},
-        .windowed_register_op = 0x2,
         .coprocessor = 0x1,
     }, {
         .name = "lsiu",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){false, true},
-        .windowed_register_op = 0x2,
         .coprocessor = 0x1,
     }, {
         .name = "lsx",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){false, false},
-        .windowed_register_op = 0x6,
         .coprocessor = 0x1,
     }, {
         .name = "lsxu",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){false, true},
-        .windowed_register_op = 0x6,
         .coprocessor = 0x1,
     }, {
         .name = "madd.s",
@@ -5554,7 +5095,6 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "moveqz.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_EQ},
-        .windowed_register_op = 0x4,
         .coprocessor = 0x1,
     }, {
         .name = "movf.s",
@@ -5565,19 +5105,16 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "movgez.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_GE},
-        .windowed_register_op = 0x4,
         .coprocessor = 0x1,
     }, {
         .name = "movltz.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_LT},
-        .windowed_register_op = 0x4,
         .coprocessor = 0x1,
     }, {
         .name = "movnez.s",
         .translate = translate_movcond_s,
         .par = (const uint32_t[]){TCG_COND_NE},
-        .windowed_register_op = 0x4,
         .coprocessor = 0x1,
     }, {
         .name = "movt.s",
@@ -5614,37 +5151,31 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
     }, {
         .name = "rfr",
         .translate = translate_rfr_s,
-        .windowed_register_op = 0x1,
         .coprocessor = 0x1,
     }, {
         .name = "round.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_nearest_even, false},
-        .windowed_register_op = 0x1,
         .coprocessor = 0x1,
     }, {
         .name = "ssi",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){true, false},
-        .windowed_register_op = 0x2,
         .coprocessor = 0x1,
     }, {
         .name = "ssiu",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){true, true},
-        .windowed_register_op = 0x2,
         .coprocessor = 0x1,
     }, {
         .name = "ssx",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){true, false},
-        .windowed_register_op = 0x6,
         .coprocessor = 0x1,
     }, {
         .name = "ssxu",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){true, true},
-        .windowed_register_op = 0x6,
         .coprocessor = 0x1,
     }, {
         .name = "sub.s",
@@ -5654,7 +5185,6 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "trunc.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_to_zero, false},
-        .windowed_register_op = 0x1,
         .coprocessor = 0x1,
     }, {
         .name = "ueq.s",
@@ -5665,7 +5195,6 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "ufloat.s",
         .translate = translate_float_s,
         .par = (const uint32_t[]){true},
-        .windowed_register_op = 0x2,
         .coprocessor = 0x1,
     }, {
         .name = "ule.s",
@@ -5686,12 +5215,10 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "utrunc.s",
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_to_zero, true},
-        .windowed_register_op = 0x1,
         .coprocessor = 0x1,
     }, {
         .name = "wfr",
         .translate = translate_wfr_s,
-        .windowed_register_op = 0x2,
         .coprocessor = 0x1,
     },
 };
-- 
2.11.0
