Received: from eggs.gnu.org ([2001:4830:134:3::10]:59830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ3GW-0003rk-UD
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ3GP-0000E5-VR
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:38:44 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dJ3GP-0000Dr-8t
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:38:37 -0400
Received: by mail-wm0-x243.google.com with SMTP id 70so8836961wme.1
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 12:38:37 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu,  8 Jun 2017 22:38:19 +0300
Message-Id: <20170608193822.24418-1-rolnik@amazon.com>
Subject: [Qemu-devel] [PATCH RFC v19 10/13] target-avr: Put env pointer in
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anichang@protonmail.ch, Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>

From: Michael Rolnik <mrolnik@gmail.com>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/avr/translate-inst.c | 298 ++++++++++++++++++++++----------------------
 target/avr/translate-inst.h | 194 ++++++++++++++--------------
 target/avr/translate.c      |  16 +--
 target/avr/translate.h      |  11 +-
 4 files changed, 257 insertions(+), 262 deletions(-)

diff --git a/target/avr/translate-inst.c b/target/avr/translate-inst.c
index 6ed98bb1ac..377263a0d3 100644
--- a/target/avr/translate-inst.c
+++ b/target/avr/translate-inst.c
@@ -109,9 +109,9 @@ static void gen_ZNSf(TCGv R)
     tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
 }
 
-static void gen_push_ret(CPUAVRState *env, int ret)
+static void gen_push_ret(DisasContext *ctx, int ret)
 {
-    if (avr_feature(env, AVR_FEATURE_1_BYTE_PC)) {
+    if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
 
         TCGv t0 = tcg_const_i32((ret & 0x0000ff));
 
@@ -119,7 +119,7 @@ static void gen_push_ret(CPUAVRState *env, int ret)
         tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
 
         tcg_temp_free_i32(t0);
-    } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
+    } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
 
         TCGv t0 = tcg_const_i32((ret & 0x00ffff));
 
@@ -129,7 +129,7 @@ static void gen_push_ret(CPUAVRState *env, int ret)
 
         tcg_temp_free_i32(t0);
 
-    } else if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
+    } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
 
         TCGv lo = tcg_const_i32((ret & 0x0000ff));
         TCGv hi = tcg_const_i32((ret & 0xffff00) >> 8);
@@ -144,20 +144,20 @@ static void gen_push_ret(CPUAVRState *env, int ret)
     }
 }
 
-static void gen_pop_ret(CPUAVRState *env, TCGv ret)
+static void gen_pop_ret(DisasContext *ctx, TCGv ret)
 {
-    if (avr_feature(env, AVR_FEATURE_1_BYTE_PC)) {
+    if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
 
         tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
         tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_UB);
 
-    } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
+    } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
 
         tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
         tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_BEUW);
         tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
 
-    } else if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
+    } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
 
         TCGv lo = tcg_temp_new_i32();
         TCGv hi = tcg_temp_new_i32();
@@ -249,7 +249,7 @@ static TCGv gen_get_zaddr(void)
  *  Adds two registers and the contents of the C Flag and places the result in
  *  the destination register Rd.
  */
-int avr_translate_ADC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ADC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[ADC_Rd(opcode)];
     TCGv Rr = cpu_r[ADC_Rr(opcode)];
@@ -276,7 +276,7 @@ int avr_translate_ADC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Adds two registers without the C Flag and places the result in the
  *  destination register Rd.
  */
-int avr_translate_ADD(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ADD(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[ADD_Rd(opcode)];
     TCGv Rr = cpu_r[ADD_Rr(opcode)];
@@ -305,9 +305,9 @@ int avr_translate_ADD(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  instruction is not available in all devices. Refer to the device specific
  *  instruction set summary.
  */
-int avr_translate_ADIW(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ADIW(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_ADIW_SBIW) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_ADIW_SBIW) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -355,7 +355,7 @@ int avr_translate_ADIW(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Performs the logical AND between the contents of register Rd and register
  *  Rr and places the result in the destination register Rd.
  */
-int avr_translate_AND(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_AND(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[AND_Rd(opcode)];
     TCGv Rr = cpu_r[AND_Rr(opcode)];
@@ -384,7 +384,7 @@ int avr_translate_AND(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Performs the logical AND between the contents of register Rd and a constant
  *  and places the result in the destination register Rd.
  */
-int avr_translate_ANDI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ANDI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + ANDI_Rd(opcode)];
     int Imm = (ANDI_Imm(opcode));
@@ -404,7 +404,7 @@ int avr_translate_ANDI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  signed value by two without changing its sign. The Carry Flag can be used to
  *  round the result.
  */
-int avr_translate_ASR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ASR(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[ASR_Rd(opcode)];
     TCGv t1 = tcg_temp_new_i32();
@@ -435,7 +435,7 @@ int avr_translate_ASR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 /*
  *  Clears a single Flag in SREG.
  */
-int avr_translate_BCLR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_BCLR(DisasContext *ctx, uint32_t opcode)
 {
     switch (BCLR_Bit(opcode)) {
     case 0x00:
@@ -470,7 +470,7 @@ int avr_translate_BCLR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 /*
  *  Copies the T Flag in the SREG (Status Register) to bit b in register Rd.
  */
-int avr_translate_BLD(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_BLD(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[BLD_Rd(opcode)];
     TCGv t1 = tcg_temp_new_i32();
@@ -491,7 +491,7 @@ int avr_translate_BLD(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  parameter k is the offset from PC and is represented in two's complement
  *  form.
  */
-int avr_translate_BRBC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_BRBC(DisasContext *ctx, uint32_t opcode)
 {
     TCGLabel *taken = gen_new_label();
     int Imm = sextract32(BRBC_Imm(opcode), 0, 7);
@@ -523,9 +523,9 @@ int avr_translate_BRBC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
         break;
     }
 
-    gen_goto_tb(env, ctx, 1, ctx->inst[0].npc);
+    gen_goto_tb(ctx, 1, ctx->inst[0].npc);
     gen_set_label(taken);
-    gen_goto_tb(env, ctx, 0, ctx->inst[0].npc + Imm);
+    gen_goto_tb(ctx, 0, ctx->inst[0].npc + Imm);
 
     return BS_BRANCH;
 }
@@ -536,7 +536,7 @@ int avr_translate_BRBC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  PC in either direction (PC - 63 < = destination <= PC + 64). The parameter k
  *  is the offset from PC and is represented in two's complement form.
  */
-int avr_translate_BRBS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_BRBS(DisasContext *ctx, uint32_t opcode)
 {
     TCGLabel *taken = gen_new_label();
     int Imm = sextract32(BRBS_Imm(opcode), 0, 7);
@@ -568,9 +568,9 @@ int avr_translate_BRBS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
         break;
     }
 
-    gen_goto_tb(env, ctx, 1, ctx->inst[0].npc);
+    gen_goto_tb(ctx, 1, ctx->inst[0].npc);
     gen_set_label(taken);
-    gen_goto_tb(env, ctx, 0, ctx->inst[0].npc + Imm);
+    gen_goto_tb(ctx, 0, ctx->inst[0].npc + Imm);
 
     return BS_BRANCH;
 }
@@ -578,7 +578,7 @@ int avr_translate_BRBS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 /*
  *  Sets a single Flag or bit in SREG.
  */
-int avr_translate_BSET(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_BSET(DisasContext *ctx, uint32_t opcode)
 {
     switch (BSET_Bit(opcode)) {
     case 0x00:
@@ -620,9 +620,9 @@ int avr_translate_BSET(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  is not available in all devices. Refer to the device specific instruction
  *  set summary.
  */
-int avr_translate_BREAK(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_BREAK(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_BREAK) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_BREAK) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -635,7 +635,7 @@ int avr_translate_BREAK(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 /*
  *  Stores bit b from Rd to the T Flag in SREG (Status Register).
  */
-int avr_translate_BST(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_BST(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[BST_Rd(opcode)];
 
@@ -652,9 +652,9 @@ int avr_translate_BST(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  CALL.  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_CALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_CALL(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_JMP_CALL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_JMP_CALL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -663,9 +663,8 @@ int avr_translate_CALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     int Imm = CALL_Imm(opcode);
     int ret = ctx->inst[0].npc;
 
-    gen_push_ret(env, ret);
-
-    gen_goto_tb(env, ctx, 0, Imm);
+    gen_push_ret(ctx, ret);
+    gen_goto_tb(ctx, 0, Imm);
 
     return BS_BRANCH;
 }
@@ -674,7 +673,7 @@ int avr_translate_CALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Clears a specified bit in an I/O Register. This instruction operates on
  *  the lower 32 I/O Registers -- addresses 0-31.
  */
-int avr_translate_CBI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_CBI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv data = tcg_temp_new_i32();
     TCGv port = tcg_const_i32(CBI_Imm(opcode));
@@ -694,7 +693,7 @@ int avr_translate_CBI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  between the contents of register Rd and the complement of the constant mask
  *  K. The result will be placed in register Rd.
  */
-int avr_translate_COM(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_COM(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[COM_Rd(opcode)];
     TCGv R = tcg_temp_new_i32();
@@ -715,7 +714,7 @@ int avr_translate_COM(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  None of the registers are changed. All conditional branches can be used
  *  after this instruction.
  */
-int avr_translate_CP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_CP(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[CP_Rd(opcode)];
     TCGv Rr = cpu_r[CP_Rr(opcode)];
@@ -739,7 +738,7 @@ int avr_translate_CP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  also takes into account the previous carry. None of the registers are
  *  changed. All conditional branches can be used after this instruction.
  */
-int avr_translate_CPC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_CPC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[CPC_Rd(opcode)];
     TCGv Rr = cpu_r[CPC_Rr(opcode)];
@@ -769,7 +768,7 @@ int avr_translate_CPC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  The register is not changed. All conditional branches can be used after this
  *  instruction.
  */
-int avr_translate_CPI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_CPI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + CPI_Rd(opcode)];
     int Imm = CPI_Imm(opcode);
@@ -794,7 +793,7 @@ int avr_translate_CPI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction performs a compare between two registers Rd and Rr, and
  *  skips the next instruction if Rd = Rr.
  */
-int avr_translate_CPSE(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_CPSE(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[CPSE_Rd(opcode)];
     TCGv Rr = cpu_r[CPSE_Rr(opcode)];
@@ -818,7 +817,7 @@ int avr_translate_CPSE(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  BREQ and BRNE branches can be expected to perform consistently.  When
  *  operating on two's complement values, all signed branches are available.
  */
-int avr_translate_DEC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_DEC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[DEC_Rd(opcode)];
 
@@ -852,10 +851,10 @@ int avr_translate_DEC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  affect the result in the final ciphertext or plaintext, but reduces
  *  execution time.
  */
-int avr_translate_DES(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_DES(DisasContext *ctx, uint32_t opcode)
 {
     /* TODO: */
-    if (avr_feature(env, AVR_FEATURE_DES) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_DES) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -872,9 +871,9 @@ int avr_translate_DES(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  during EICALL.  This instruction is not available in all devices. Refer to
  *  the device specific instruction set summary.
  */
-int avr_translate_EICALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_EICALL(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_EIJMP_EICALL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_EIJMP_EICALL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -882,7 +881,7 @@ int avr_translate_EICALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 
     int ret = ctx->inst[0].npc;
 
-    gen_push_ret(env, ret);
+    gen_push_ret(ctx, ret);
 
     gen_jmp_ez();
 
@@ -896,9 +895,9 @@ int avr_translate_EICALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  memory space. See also IJMP.  This instruction is not available in all
  *  devices. Refer to the device specific instruction set summary.
  */
-int avr_translate_EIJMP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_EIJMP(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_EIJMP_EICALL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_EIJMP_EICALL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -925,9 +924,9 @@ int avr_translate_EIJMP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  instruction is not available in all devices. Refer to the device specific
  *  instruction set summary.
  */
-int avr_translate_ELPM1(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ELPM1(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_ELPM) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_ELPM) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -943,9 +942,9 @@ int avr_translate_ELPM1(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_ELPM2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ELPM2(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_ELPM) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_ELPM) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -961,9 +960,9 @@ int avr_translate_ELPM2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_ELPMX(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ELPMX(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_ELPMX) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_ELPMX) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -987,7 +986,7 @@ int avr_translate_ELPMX(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Performs the logical EOR between the contents of register Rd and
  *  register Rr and places the result in the destination register Rd.
  */
-int avr_translate_EOR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_EOR(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[EOR_Rd(opcode)];
     TCGv Rr = cpu_r[EOR_Rr(opcode)];
@@ -1004,9 +1003,9 @@ int avr_translate_EOR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction performs 8-bit x 8-bit -> 16-bit unsigned
  *  multiplication and shifts the result one bit left.
  */
-int avr_translate_FMUL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_FMUL(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_MUL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1037,9 +1036,9 @@ int avr_translate_FMUL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction performs 8-bit x 8-bit -> 16-bit signed multiplication
  *  and shifts the result one bit left.
  */
-int avr_translate_FMULS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_FMULS(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_MUL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1076,9 +1075,9 @@ int avr_translate_FMULS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction performs 8-bit x 8-bit -> 16-bit signed multiplication
  *  and shifts the result one bit left.
  */
-int avr_translate_FMULSU(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_FMULSU(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_MUL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1115,9 +1114,9 @@ int avr_translate_FMULSU(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  CALL.  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_ICALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ICALL(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_IJMP_ICALL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_IJMP_ICALL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1125,7 +1124,7 @@ int avr_translate_ICALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 
     int ret = ctx->inst[0].npc;
 
-    gen_push_ret(env, ret);
+    gen_push_ret(ctx, ret);
     gen_jmp_z();
 
     return BS_BRANCH;
@@ -1138,9 +1137,9 @@ int avr_translate_ICALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_IJMP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_IJMP(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_IJMP_ICALL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_IJMP_ICALL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1155,7 +1154,7 @@ int avr_translate_IJMP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Loads data from the I/O Space (Ports, Timers, Configuration Registers,
  *  etc.) into register Rd in the Register File.
  */
-int avr_translate_IN(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_IN(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[IN_Rd(opcode)];
     int Imm = IN_Imm(opcode);
@@ -1176,7 +1175,7 @@ int avr_translate_IN(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  BREQ and BRNE branches can be expected to perform consistently. When
  *  operating on two's complement values, all signed branches are available.
  */
-int avr_translate_INC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_INC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[INC_Rd(opcode)];
 
@@ -1194,15 +1193,15 @@ int avr_translate_INC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  RJMP.  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.0
  */
-int avr_translate_JMP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_JMP(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_JMP_CALL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_JMP_CALL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
     }
 
-    gen_goto_tb(env, ctx, 0, JMP_Imm(opcode));
+    gen_goto_tb(ctx, 0, JMP_Imm(opcode));
     return BS_BRANCH;
 }
 
@@ -1234,9 +1233,9 @@ static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)
     }
 }
 
-int avr_translate_LAC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LAC(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_RMW) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_RMW) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1271,9 +1270,9 @@ int avr_translate_LAC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  The Z-pointer Register is left unchanged by the operation. This instruction
  *  is especially suited for setting status bits stored in SRAM.
  */
-int avr_translate_LAS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LAS(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_RMW) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_RMW) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1307,9 +1306,9 @@ int avr_translate_LAS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  The Z-pointer Register is left unchanged by the operation. This instruction
  *  is especially suited for changing status bits stored in SRAM.
  */
-int avr_translate_LAT(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LAT(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_RMW) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_RMW) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1358,7 +1357,7 @@ int avr_translate_LAT(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  operation as LPM since the program memory is mapped to the data memory
  *  space.
  */
-int avr_translate_LDX1(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDX1(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDX1_Rd(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -1370,7 +1369,7 @@ int avr_translate_LDX1(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDX2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDX2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDX2_Rd(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -1385,7 +1384,7 @@ int avr_translate_LDX2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDX3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDX3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDX3_Rd(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -1424,7 +1423,7 @@ int avr_translate_LDX3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  be used to achieve the same operation as LPM since the program memory is
  *  mapped to the data memory space.
  */
-int avr_translate_LDY2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDY2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDY2_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -1439,7 +1438,7 @@ int avr_translate_LDY2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDY3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDY3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDY3_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -1453,7 +1452,7 @@ int avr_translate_LDY3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDDY(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDDY(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDDY_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -1495,7 +1494,7 @@ int avr_translate_LDDY(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  space.  For using the Z-pointer for table lookup in Program memory see the
  *  LPM and ELPM instructions.
  */
-int avr_translate_LDZ2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDZ2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDZ2_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -1510,7 +1509,7 @@ int avr_translate_LDZ2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDZ3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDZ3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDZ3_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -1525,7 +1524,7 @@ int avr_translate_LDZ3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDDZ(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDDZ(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDDZ_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -1542,7 +1541,7 @@ int avr_translate_LDDZ(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 /*
     Loads an 8 bit constant directly to register 16 to 31.
  */
-int avr_translate_LDI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + LDI_Rd(opcode)];
     int imm = LDI_Imm(opcode);
@@ -1564,7 +1563,7 @@ int avr_translate_LDI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_LDS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LDS(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDS_Rd(opcode)];
     TCGv addr = tcg_temp_new_i32();
@@ -1596,9 +1595,9 @@ int avr_translate_LDS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  available in all devices. Refer to the device specific instruction set
  *  summary
  */
-int avr_translate_LPM1(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LPM1(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_LPM) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_LPM) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1619,9 +1618,9 @@ int avr_translate_LPM1(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LPM2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LPM2(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_LPM) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_LPM) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1642,9 +1641,9 @@ int avr_translate_LPM2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LPMX(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LPMX(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_LPMX) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_LPMX) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1677,7 +1676,7 @@ int avr_translate_LPMX(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  loaded into the C Flag of the SREG. This operation effectively divides an
  *  unsigned value by two. The C Flag can be used to round the result.
  */
-int avr_translate_LSR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_LSR(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LSR_Rd(opcode)];
 
@@ -1695,7 +1694,7 @@ int avr_translate_LSR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  register Rr is left unchanged, while the destination register Rd is loaded
  *  with a copy of Rr.
  */
-int avr_translate_MOV(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_MOV(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[MOV_Rd(opcode)];
     TCGv Rr = cpu_r[MOV_Rr(opcode)];
@@ -1712,9 +1711,9 @@ int avr_translate_MOV(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  instruction is not available in all devices. Refer to the device specific
  *  instruction set summary.
  */
-int avr_translate_MOVW(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_MOVW(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_MOVW) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_MOVW) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1734,9 +1733,9 @@ int avr_translate_MOVW(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 /*
  *  This instruction performs 8-bit x 8-bit -> 16-bit unsigned multiplication.
  */
-int avr_translate_MUL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_MUL(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_MUL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1766,9 +1765,9 @@ int avr_translate_MUL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 /*
  *  This instruction performs 8-bit x 8-bit -> 16-bit signed multiplication.
  */
-int avr_translate_MULS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_MULS(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_MUL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1806,9 +1805,9 @@ int avr_translate_MULS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction performs 8-bit x 8-bit -> 16-bit multiplication of a
  *  signed and an unsigned number.
  */
-int avr_translate_MULSU(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_MULSU(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_MUL) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -1843,7 +1842,7 @@ int avr_translate_MULSU(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Replaces the contents of register Rd with its two's complement; the
  *  value $80 is left unchanged.
  */
-int avr_translate_NEG(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_NEG(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[SUB_Rd(opcode)];
     TCGv t0 = tcg_const_i32(0);
@@ -1869,7 +1868,7 @@ int avr_translate_NEG(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 /*
  *  This instruction performs a single cycle No Operation.
  */
-int avr_translate_NOP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_NOP(DisasContext *ctx, uint32_t opcode)
 {
 
     /* NOP */
@@ -1881,7 +1880,7 @@ int avr_translate_NOP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Performs the logical OR between the contents of register Rd and register
  *  Rr and places the result in the destination register Rd.
  */
-int avr_translate_OR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_OR(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[OR_Rd(opcode)];
     TCGv Rr = cpu_r[OR_Rr(opcode)];
@@ -1901,7 +1900,7 @@ int avr_translate_OR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Performs the logical OR between the contents of register Rd and a
  *  constant and places the result in the destination register Rd.
  */
-int avr_translate_ORI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ORI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + ORI_Rd(opcode)];
     int Imm = (ORI_Imm(opcode));
@@ -1918,7 +1917,7 @@ int avr_translate_ORI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Stores data from register Rr in the Register File to I/O Space (Ports,
  *  Timers, Configuration Registers, etc.).
  */
-int avr_translate_OUT(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_OUT(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[OUT_Rd(opcode)];
     int Imm = OUT_Imm(opcode);
@@ -1937,7 +1936,7 @@ int avr_translate_OUT(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  available in all devices. Refer to the device specific instruction set
  *  summary.
  */
-int avr_translate_POP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_POP(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[POP_Rd(opcode)];
 
@@ -1953,7 +1952,7 @@ int avr_translate_POP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  not available in all devices. Refer to the device specific instruction set
  *  summary.
  */
-int avr_translate_PUSH(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_PUSH(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[PUSH_Rd(opcode)];
 
@@ -1971,14 +1970,13 @@ int avr_translate_PUSH(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  address location. The Stack Pointer uses a post-decrement scheme during
  *  RCALL.
  */
-int avr_translate_RCALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_RCALL(DisasContext *ctx, uint32_t opcode)
 {
     int ret = ctx->inst[0].npc;
     int dst = ctx->inst[0].npc + sextract32(RCALL_Imm(opcode), 0, 12);
 
-    gen_push_ret(env, ret);
-
-    gen_goto_tb(env, ctx, 0, dst);
+    gen_push_ret(ctx, ret);
+    gen_goto_tb(ctx, 0, dst);
 
     return BS_BRANCH;
 }
@@ -1987,9 +1985,9 @@ int avr_translate_RCALL(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Returns from subroutine. The return address is loaded from the STACK.
  *  The Stack Pointer uses a preincrement scheme during RET.
  */
-int avr_translate_RET(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_RET(DisasContext *ctx, uint32_t opcode)
 {
-    gen_pop_ret(env, cpu_pc);
+    gen_pop_ret(ctx, cpu_pc);
 
     tcg_gen_exit_tb(0);
 
@@ -2004,9 +2002,9 @@ int avr_translate_RET(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  the application program. The Stack Pointer uses a pre-increment scheme
  *  during RETI.
  */
-int avr_translate_RETI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_RETI(DisasContext *ctx, uint32_t opcode)
 {
-    gen_pop_ret(env, cpu_pc);
+    gen_pop_ret(ctx, cpu_pc);
 
     tcg_gen_movi_tl(cpu_If, 1);
 
@@ -2021,11 +2019,11 @@ int avr_translate_RETI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  instruction can address the entire memory from every address location. See
  *  also JMP.
  */
-int avr_translate_RJMP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_RJMP(DisasContext *ctx, uint32_t opcode)
 {
     int dst = ctx->inst[0].npc + sextract32(RJMP_Imm(opcode), 0, 12);
 
-    gen_goto_tb(env, ctx, 0, dst);
+    gen_goto_tb(ctx, 0, dst);
 
     return BS_BRANCH;
 }
@@ -2037,7 +2035,7 @@ int avr_translate_RJMP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  LSR it effectively divides multi-byte unsigned values by two. The Carry Flag
  *  can be used to round the result.
  */
-int avr_translate_ROR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_ROR(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[ROR_Rd(opcode)];
     TCGv t0 = tcg_temp_new_i32();
@@ -2059,7 +2057,7 @@ int avr_translate_ROR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Subtracts two registers and subtracts with the C Flag and places the
  *  result in the destination register Rd.
  */
-int avr_translate_SBC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SBC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[SBC_Rd(opcode)];
     TCGv Rr = cpu_r[SBC_Rr(opcode)];
@@ -2085,7 +2083,7 @@ int avr_translate_SBC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 /*
  *  SBCI -- Subtract Immediate with Carry
  */
-int avr_translate_SBCI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SBCI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + SBCI_Rd(opcode)];
     TCGv Rr = tcg_const_i32(SBCI_Imm(opcode));
@@ -2113,7 +2111,7 @@ int avr_translate_SBCI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Sets a specified bit in an I/O Register. This instruction operates on
  *  the lower 32 I/O Registers -- addresses 0-31.
  */
-int avr_translate_SBI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SBI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv data = tcg_temp_new_i32();
     TCGv port = tcg_const_i32(SBI_Imm(opcode));
@@ -2133,7 +2131,7 @@ int avr_translate_SBI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  next instruction if the bit is cleared. This instruction operates on the
  *  lower 32 I/O Registers -- addresses 0-31.
  */
-int avr_translate_SBIC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SBIC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv data = tcg_temp_new_i32();
     TCGv port = tcg_const_i32(SBIC_Imm(opcode));
@@ -2160,7 +2158,7 @@ int avr_translate_SBIC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  next instruction if the bit is set. This instruction operates on the lower
  *  32 I/O Registers -- addresses 0-31.
  */
-int avr_translate_SBIS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SBIS(DisasContext *ctx, uint32_t opcode)
 {
     TCGv data = tcg_temp_new_i32();
     TCGv port = tcg_const_i32(SBIS_Imm(opcode));
@@ -2189,9 +2187,9 @@ int avr_translate_SBIS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_SBIW(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SBIW(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_ADIW_SBIW) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_ADIW_SBIW) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -2239,7 +2237,7 @@ int avr_translate_SBIW(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction tests a single bit in a register and skips the next
  *  instruction if the bit is cleared.
  */
-int avr_translate_SBRC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SBRC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rr = cpu_r[SBRC_Rr(opcode)];
     TCGv t0 = tcg_temp_new_i32();
@@ -2262,7 +2260,7 @@ int avr_translate_SBRC(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction tests a single bit in a register and skips the next
  *  instruction if the bit is set.
  */
-int avr_translate_SBRS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SBRS(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rr = cpu_r[SBRS_Rr(opcode)];
     TCGv t0 = tcg_temp_new_i32();
@@ -2285,7 +2283,7 @@ int avr_translate_SBRS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction sets the circuit in sleep mode defined by the MCU
  *  Control Register.
  */
-int avr_translate_SLEEP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SLEEP(DisasContext *ctx, uint32_t opcode)
 {
     gen_helper_sleep(cpu_env);
 
@@ -2309,9 +2307,9 @@ int avr_translate_SLEEP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  determines the instruction high byte, and R0 determines the instruction low
  *  byte.
  */
-int avr_translate_SPM(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SPM(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_SPM) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_SPM) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -2321,9 +2319,9 @@ int avr_translate_SPM(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_SPMX(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SPMX(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_SPMX) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_SPMX) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
@@ -2333,7 +2331,7 @@ int avr_translate_SPMX(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STX1(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_STX1(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STX1_Rr(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -2345,7 +2343,7 @@ int avr_translate_STX1(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STX2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_STX2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STX2_Rr(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -2359,7 +2357,7 @@ int avr_translate_STX2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STX3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_STX3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STX3_Rr(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -2373,7 +2371,7 @@ int avr_translate_STX3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STY2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_STY2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STY2_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -2387,7 +2385,7 @@ int avr_translate_STY2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STY3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_STY3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STY3_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -2401,7 +2399,7 @@ int avr_translate_STY3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STDY(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_STDY(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STDY_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -2415,7 +2413,7 @@ int avr_translate_STDY(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STZ2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_STZ2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STZ2_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -2430,7 +2428,7 @@ int avr_translate_STZ2(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STZ3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_STZ3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STZ3_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -2445,7 +2443,7 @@ int avr_translate_STZ3(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STDZ(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_STDZ(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STDZ_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -2471,7 +2469,7 @@ int avr_translate_STDZ(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_STS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_STS(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STS_Rd(opcode)];
     TCGv addr = tcg_temp_new_i32();
@@ -2492,7 +2490,7 @@ int avr_translate_STS(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  Subtracts two registers and places the result in the destination
  *  register Rd.
  */
-int avr_translate_SUB(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SUB(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[SUB_Rd(opcode)];
     TCGv Rr = cpu_r[SUB_Rr(opcode)];
@@ -2519,7 +2517,7 @@ int avr_translate_SUB(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  destination register Rd. This instruction is working on Register R16 to R31
  *  and is very well suited for operations on the X, Y, and Z-pointers.
  */
-int avr_translate_SUBI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SUBI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + SUBI_Rd(opcode)];
     TCGv Rr = tcg_const_i32(SUBI_Imm(opcode));
@@ -2546,7 +2544,7 @@ int avr_translate_SUBI(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
 /*
  *  Swaps high and low nibbles in a register.
  */
-int avr_translate_SWAP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_SWAP(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[SWAP_Rd(opcode)];
     TCGv t0 = tcg_temp_new_i32();
@@ -2569,7 +2567,7 @@ int avr_translate_SWAP(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  executed within a limited time given by the WD prescaler. See the Watchdog
  *  Timer hardware specification.
  */
-int avr_translate_WDR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_WDR(DisasContext *ctx, uint32_t opcode)
 {
     gen_helper_wdr(cpu_env);
 
@@ -2585,9 +2583,9 @@ int avr_translate_WDR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
  *  is left unchanged by the operation. This instruction is especially suited
  *  for writing/reading status bits stored in SRAM.
  */
-int avr_translate_XCH(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
+int avr_translate_XCH(DisasContext *ctx, uint32_t opcode)
 {
-    if (avr_feature(env, AVR_FEATURE_RMW) == false) {
+    if (avr_feature(ctx->env, AVR_FEATURE_RMW) == false) {
         gen_helper_unsupported(cpu_env);
 
         return BS_EXCP;
diff --git a/target/avr/translate-inst.h b/target/avr/translate-inst.h
index af2e076807..edb87439d6 100644
--- a/target/avr/translate-inst.h
+++ b/target/avr/translate-inst.h
@@ -23,9 +23,9 @@
 
 typedef struct DisasContext DisasContext;
 
-int avr_translate_NOP(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_NOP(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_MOVW(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_MOVW(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t MOVW_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 4);
@@ -36,7 +36,7 @@ static inline uint32_t MOVW_Rd(uint32_t opcode)
     return extract32(opcode, 4, 4);
 }
 
-int avr_translate_MULS(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_MULS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t MULS_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 4);
@@ -47,7 +47,7 @@ static inline uint32_t MULS_Rd(uint32_t opcode)
     return extract32(opcode, 4, 4);
 }
 
-int avr_translate_MULSU(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_MULSU(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t MULSU_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -58,7 +58,7 @@ static inline uint32_t MULSU_Rd(uint32_t opcode)
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_FMUL(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_FMUL(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t FMUL_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -69,7 +69,7 @@ static inline uint32_t FMUL_Rd(uint32_t opcode)
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_FMULS(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_FMULS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t FMULS_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -80,7 +80,7 @@ static inline uint32_t FMULS_Rd(uint32_t opcode)
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_FMULSU(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_FMULSU(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t FMULSU_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -91,7 +91,7 @@ static inline uint32_t FMULSU_Rd(uint32_t opcode)
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_CPC(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_CPC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CPC_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -103,7 +103,7 @@ static inline uint32_t CPC_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_SBC(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SBC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBC_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -115,7 +115,7 @@ static inline uint32_t SBC_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_ADD(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ADD(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ADD_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -127,7 +127,7 @@ static inline uint32_t ADD_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_AND(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_AND(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t AND_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -139,7 +139,7 @@ static inline uint32_t AND_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_EOR(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_EOR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t EOR_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -151,7 +151,7 @@ static inline uint32_t EOR_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_OR(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_OR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t OR_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -163,7 +163,7 @@ static inline uint32_t OR_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_MOV(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_MOV(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t MOV_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -175,7 +175,7 @@ static inline uint32_t MOV_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_CPSE(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_CPSE(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CPSE_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -187,7 +187,7 @@ static inline uint32_t CPSE_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_CP(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_CP(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CP_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -199,7 +199,7 @@ static inline uint32_t CP_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_SUB(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SUB(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SUB_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -211,7 +211,7 @@ static inline uint32_t SUB_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_ADC(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ADC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ADC_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -223,7 +223,7 @@ static inline uint32_t ADC_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_CPI(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_CPI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CPI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -235,7 +235,7 @@ static inline uint32_t CPI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_SBCI(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SBCI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBCI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -247,7 +247,7 @@ static inline uint32_t SBCI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_ORI(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ORI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ORI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -259,7 +259,7 @@ static inline uint32_t ORI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_SUBI(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SUBI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SUBI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -271,7 +271,7 @@ static inline uint32_t SUBI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_ANDI(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ANDI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ANDI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -283,7 +283,7 @@ static inline uint32_t ANDI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_LDDZ(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDDZ(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDDZ_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -296,7 +296,7 @@ static inline uint32_t LDDZ_Imm(uint32_t opcode)
             (extract32(opcode, 0, 3));
 }
 
-int avr_translate_LDDY(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDDY(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDDY_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -309,7 +309,7 @@ static inline uint32_t LDDY_Imm(uint32_t opcode)
             (extract32(opcode, 0, 3));
 }
 
-int avr_translate_STDZ(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_STDZ(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STDZ_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -322,7 +322,7 @@ static inline uint32_t STDZ_Imm(uint32_t opcode)
             (extract32(opcode, 0, 3));
 }
 
-int avr_translate_STDY(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_STDY(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STDY_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -335,7 +335,7 @@ static inline uint32_t STDY_Imm(uint32_t opcode)
             (extract32(opcode, 0, 3));
 }
 
-int avr_translate_LDS(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDS_Imm(uint32_t opcode)
 {
     return extract32(opcode, 0, 16);
@@ -346,79 +346,79 @@ static inline uint32_t LDS_Rd(uint32_t opcode)
     return extract32(opcode, 20, 5);
 }
 
-int avr_translate_LDZ2(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDZ2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDZ2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDZ3(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDZ3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDZ3_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LPM2(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LPM2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LPM2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LPMX(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LPMX(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LPMX_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_ELPM2(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ELPM2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ELPM2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_ELPMX(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ELPMX(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ELPMX_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDY2(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDY2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDY2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDY3(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDY3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDY3_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDX1(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDX1(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDX1_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDX2(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDX2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDX2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDX3(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDX3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDX3_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_POP(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_POP(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t POP_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STS(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_STS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STS_Imm(uint32_t opcode)
 {
     return extract32(opcode, 0, 16);
@@ -429,185 +429,185 @@ static inline uint32_t STS_Rd(uint32_t opcode)
     return extract32(opcode, 20, 5);
 }
 
-int avr_translate_STZ2(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_STZ2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STZ2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STZ3(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_STZ3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STZ3_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_XCH(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_XCH(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t XCH_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LAS(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LAS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LAS_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LAC(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LAC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LAC_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LAT(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LAT(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LAT_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STY2(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_STY2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STY2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STY3(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_STY3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STY3_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STX1(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_STX1(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STX1_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STX2(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_STX2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STX2_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STX3(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_STX3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STX3_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_PUSH(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_PUSH(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t PUSH_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_COM(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_COM(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t COM_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_NEG(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_NEG(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t NEG_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_SWAP(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SWAP(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SWAP_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_INC(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_INC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t INC_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_ASR(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ASR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ASR_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LSR(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LSR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LSR_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_ROR(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ROR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ROR_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_BSET(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_BSET(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BSET_Bit(uint32_t opcode)
 {
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_IJMP(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_IJMP(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_EIJMP(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_EIJMP(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_BCLR(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_BCLR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BCLR_Bit(uint32_t opcode)
 {
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_RET(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_RET(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_RETI(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_RETI(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_ICALL(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ICALL(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_EICALL(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_EICALL(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_SLEEP(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SLEEP(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_BREAK(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_BREAK(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_WDR(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_WDR(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_LPM1(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LPM1(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_ELPM1(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ELPM1(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_SPM(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SPM(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_SPMX(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SPMX(DisasContext *ctx, uint32_t opcode);
 
-int avr_translate_DEC(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_DEC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t DEC_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_DES(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_DES(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t DES_Imm(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
 }
 
-int avr_translate_JMP(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_JMP(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t JMP_Imm(uint32_t opcode)
 {
     return (extract32(opcode, 20, 5) << 17) |
             (extract32(opcode, 0, 17));
 }
 
-int avr_translate_CALL(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_CALL(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CALL_Imm(uint32_t opcode)
 {
     return (extract32(opcode, 20, 5) << 17) |
             (extract32(opcode, 0, 17));
 }
 
-int avr_translate_ADIW(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_ADIW(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ADIW_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 2);
@@ -619,7 +619,7 @@ static inline uint32_t ADIW_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_SBIW(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SBIW(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBIW_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 2);
@@ -631,7 +631,7 @@ static inline uint32_t SBIW_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_CBI(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_CBI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CBI_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -642,7 +642,7 @@ static inline uint32_t CBI_Imm(uint32_t opcode)
     return extract32(opcode, 3, 5);
 }
 
-int avr_translate_SBIC(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SBIC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBIC_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -653,7 +653,7 @@ static inline uint32_t SBIC_Imm(uint32_t opcode)
     return extract32(opcode, 3, 5);
 }
 
-int avr_translate_SBI(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SBI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBI_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -664,7 +664,7 @@ static inline uint32_t SBI_Imm(uint32_t opcode)
     return extract32(opcode, 3, 5);
 }
 
-int avr_translate_SBIS(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SBIS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBIS_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -675,7 +675,7 @@ static inline uint32_t SBIS_Imm(uint32_t opcode)
     return extract32(opcode, 3, 5);
 }
 
-int avr_translate_MUL(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_MUL(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t MUL_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -687,7 +687,7 @@ static inline uint32_t MUL_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_IN(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_IN(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t IN_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -699,7 +699,7 @@ static inline uint32_t IN_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_OUT(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_OUT(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t OUT_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -711,13 +711,13 @@ static inline uint32_t OUT_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_RJMP(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_RJMP(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t RJMP_Imm(uint32_t opcode)
 {
     return extract32(opcode, 0, 12);
 }
 
-int avr_translate_LDI(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_LDI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -729,13 +729,13 @@ static inline uint32_t LDI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_RCALL(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_RCALL(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t RCALL_Imm(uint32_t opcode)
 {
     return extract32(opcode, 0, 12);
 }
 
-int avr_translate_BRBS(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_BRBS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BRBS_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -746,7 +746,7 @@ static inline uint32_t BRBS_Imm(uint32_t opcode)
     return extract32(opcode, 3, 7);
 }
 
-int avr_translate_BRBC(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_BRBC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BRBC_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -757,7 +757,7 @@ static inline uint32_t BRBC_Imm(uint32_t opcode)
     return extract32(opcode, 3, 7);
 }
 
-int avr_translate_BLD(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_BLD(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BLD_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -768,7 +768,7 @@ static inline uint32_t BLD_Rd(uint32_t opcode)
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_BST(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_BST(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BST_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -779,7 +779,7 @@ static inline uint32_t BST_Rd(uint32_t opcode)
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_SBRC(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SBRC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBRC_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -790,7 +790,7 @@ static inline uint32_t SBRC_Rr(uint32_t opcode)
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_SBRS(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);
+int avr_translate_SBRS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBRS_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
diff --git a/target/avr/translate.c b/target/avr/translate.c
index d6f1f71ebc..d9e491fc3b 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -82,11 +82,10 @@ void avr_translate_init(void)
     done_init = 1;
 }
 
-static void decode_opc(AVRCPU *cpu, DisasContext *ctx, InstInfo *inst)
+static void decode_opc(DisasContext *ctx, InstInfo *inst)
 {
-    CPUAVRState *env = &cpu->env;
-
-    inst->opcode = cpu_ldl_code(env, inst->cpc * 2);/* pc points to words */
+    /* PC points to words.  */
+    inst->opcode = cpu_ldl_code(ctx->env, inst->cpc * 2);
     inst->length = 16;
     inst->translate = NULL;
 
@@ -118,6 +117,7 @@ void gen_intermediate_code(CPUAVRState *env, struct TranslationBlock *tb)
 
     pc_start = tb->pc / 2;
     ctx.tb = tb;
+    ctx.env = env;
     ctx.memidx = 0;
     ctx.bstate = BS_NONE;
     ctx.singlestep = cs->singlestep_enabled;
@@ -143,7 +143,7 @@ void gen_intermediate_code(CPUAVRState *env, struct TranslationBlock *tb)
 
     /* decode first instruction */
     ctx.inst[0].cpc = pc_start;
-    decode_opc(cpu, &ctx, &ctx.inst[0]);
+    decode_opc(&ctx, &ctx.inst[0]);
     do {
         /* set curr/next PCs */
         cpc = ctx.inst[0].cpc;
@@ -151,7 +151,7 @@ void gen_intermediate_code(CPUAVRState *env, struct TranslationBlock *tb)
 
         /* decode next instruction */
         ctx.inst[1].cpc = ctx.inst[0].npc;
-        decode_opc(cpu, &ctx, &ctx.inst[1]);
+        decode_opc(&ctx, &ctx.inst[1]);
 
         /* translate current instruction */
         tcg_gen_insn_start(cpc);
@@ -172,7 +172,7 @@ void gen_intermediate_code(CPUAVRState *env, struct TranslationBlock *tb)
         }
 
         if (ctx.inst[0].translate) {
-            ctx.bstate = ctx.inst[0].translate(env, &ctx, ctx.inst[0].opcode);
+            ctx.bstate = ctx.inst[0].translate(&ctx, ctx.inst[0].opcode);
         }
 
         if (num_insns >= max_insns) {
@@ -202,7 +202,7 @@ void gen_intermediate_code(CPUAVRState *env, struct TranslationBlock *tb)
         switch (ctx.bstate) {
         case BS_STOP:
         case BS_NONE:
-            gen_goto_tb(env, &ctx, 0, npc);
+            gen_goto_tb(&ctx, 0, npc);
             break;
         case BS_BRANCH:
         case BS_EXCP:
diff --git a/target/avr/translate.h b/target/avr/translate.h
index 711886ed63..fabbe69ee9 100644
--- a/target/avr/translate.h
+++ b/target/avr/translate.h
@@ -69,8 +69,7 @@ uint32_t get_opcode(uint8_t const *code, unsigned bitBase, unsigned bitSize);
 typedef struct DisasContext DisasContext;
 typedef struct InstInfo InstInfo;
 
-typedef int (*translate_function_t)(CPUAVRState *env, DisasContext *ctx,
-                                        uint32_t opcode);
+typedef int (*translate_function_t)(DisasContext *ctx, uint32_t opcode);
 struct InstInfo {
     target_long cpc;
     target_long npc;
@@ -82,6 +81,7 @@ struct InstInfo {
 /* This is the state at translation time. */
 struct DisasContext {
     struct TranslationBlock *tb;
+    CPUAVRState *env;
 
     InstInfo inst[2];/* two consecutive instructions */
 
@@ -94,12 +94,9 @@ struct DisasContext {
 void avr_decode(uint32_t pc, uint32_t *length, uint32_t opcode,
                         translate_function_t *translate);
 
-static inline void gen_goto_tb(CPUAVRState *env, DisasContext *ctx,
-                        int n, target_ulong dest)
+static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 {
-    TranslationBlock *tb;
-
-    tb = ctx->tb;
+    TranslationBlock *tb = ctx->tb;
 
     if (ctx->singlestep == 0) {
         tcg_gen_goto_tb(n);
-- 
2.11.0 (Apple Git-81)
