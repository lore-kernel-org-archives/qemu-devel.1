Received: from eggs.gnu.org ([2001:4830:134:3::10]:59863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ3Gd-0003xw-LH
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ3GX-0000GG-6K
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:38:51 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dJ3GW-0000Fz-LX
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:38:45 -0400
Received: by mail-wm0-x244.google.com with SMTP id 70so8837395wme.1
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 12:38:44 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu,  8 Jun 2017 22:38:20 +0300
Message-Id: <20170608193822.24418-2-rolnik@amazon.com>
In-Reply-To: <20170608193822.24418-1-rolnik@amazon.com>
References: <20170608193822.24418-1-rolnik@amazon.com>
Subject: [Qemu-devel] [PATCH RFC v19 11/13] target-avr: Put all translation
 code into one compilation unit
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
 target/avr/Makefile.objs    |   2 -
 target/avr/decode.c         |   6 +-
 target/avr/translate-inst.c | 198 ++++++++++++++++++++++----------------------
 target/avr/translate-inst.h | 113 -------------------------
 target/avr/translate.c      | 101 +++++++++++++++++-----
 target/avr/translate.h      | 112 -------------------------
 6 files changed, 180 insertions(+), 352 deletions(-)
 delete mode 100644 target/avr/translate.h

diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
index 9848b1cb4c..48233ef544 100644
--- a/target/avr/Makefile.objs
+++ b/target/avr/Makefile.objs
@@ -20,6 +20,4 @@
 
 obj-y += translate.o cpu.o helper.o
 obj-y += gdbstub.o
-obj-y += translate-inst.o
-obj-y += decode.o
 obj-$(CONFIG_SOFTMMU) += machine.o
diff --git a/target/avr/decode.c b/target/avr/decode.c
index 2d2e54e448..576dd833a6 100644
--- a/target/avr/decode.c
+++ b/target/avr/decode.c
@@ -18,10 +18,8 @@
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
-#include <stdint.h>
-#include "translate.h"
-
-void avr_decode(uint32_t pc, uint32_t *l, uint32_t c, translate_function_t *t)
+static void avr_decode(uint32_t pc, uint32_t *l, uint32_t c,
+                       translate_function_t *t)
 {
     uint32_t opc = extract32(c, 0, 16);
     switch (opc & 0x0000d000) {
diff --git a/target/avr/translate-inst.c b/target/avr/translate-inst.c
index 377263a0d3..827ec7bb9e 100644
--- a/target/avr/translate-inst.c
+++ b/target/avr/translate-inst.c
@@ -18,10 +18,6 @@
  *  <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
-#include "translate.h"
-#include "translate-inst.h"
-#include "qemu/bitops.h"
-
 static void gen_add_CHf(TCGv R, TCGv Rd, TCGv Rr)
 {
     TCGv t1 = tcg_temp_new_i32();
@@ -249,7 +245,7 @@ static TCGv gen_get_zaddr(void)
  *  Adds two registers and the contents of the C Flag and places the result in
  *  the destination register Rd.
  */
-int avr_translate_ADC(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ADC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[ADC_Rd(opcode)];
     TCGv Rr = cpu_r[ADC_Rr(opcode)];
@@ -276,7 +272,7 @@ int avr_translate_ADC(DisasContext *ctx, uint32_t opcode)
  *  Adds two registers without the C Flag and places the result in the
  *  destination register Rd.
  */
-int avr_translate_ADD(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ADD(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[ADD_Rd(opcode)];
     TCGv Rr = cpu_r[ADD_Rr(opcode)];
@@ -305,7 +301,7 @@ int avr_translate_ADD(DisasContext *ctx, uint32_t opcode)
  *  instruction is not available in all devices. Refer to the device specific
  *  instruction set summary.
  */
-int avr_translate_ADIW(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ADIW(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_ADIW_SBIW) == false) {
         gen_helper_unsupported(cpu_env);
@@ -355,7 +351,7 @@ int avr_translate_ADIW(DisasContext *ctx, uint32_t opcode)
  *  Performs the logical AND between the contents of register Rd and register
  *  Rr and places the result in the destination register Rd.
  */
-int avr_translate_AND(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_AND(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[AND_Rd(opcode)];
     TCGv Rr = cpu_r[AND_Rr(opcode)];
@@ -384,7 +380,7 @@ int avr_translate_AND(DisasContext *ctx, uint32_t opcode)
  *  Performs the logical AND between the contents of register Rd and a constant
  *  and places the result in the destination register Rd.
  */
-int avr_translate_ANDI(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ANDI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + ANDI_Rd(opcode)];
     int Imm = (ANDI_Imm(opcode));
@@ -404,7 +400,7 @@ int avr_translate_ANDI(DisasContext *ctx, uint32_t opcode)
  *  signed value by two without changing its sign. The Carry Flag can be used to
  *  round the result.
  */
-int avr_translate_ASR(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ASR(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[ASR_Rd(opcode)];
     TCGv t1 = tcg_temp_new_i32();
@@ -435,7 +431,7 @@ int avr_translate_ASR(DisasContext *ctx, uint32_t opcode)
 /*
  *  Clears a single Flag in SREG.
  */
-int avr_translate_BCLR(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_BCLR(DisasContext *ctx, uint32_t opcode)
 {
     switch (BCLR_Bit(opcode)) {
     case 0x00:
@@ -470,7 +466,7 @@ int avr_translate_BCLR(DisasContext *ctx, uint32_t opcode)
 /*
  *  Copies the T Flag in the SREG (Status Register) to bit b in register Rd.
  */
-int avr_translate_BLD(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_BLD(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[BLD_Rd(opcode)];
     TCGv t1 = tcg_temp_new_i32();
@@ -491,7 +487,7 @@ int avr_translate_BLD(DisasContext *ctx, uint32_t opcode)
  *  parameter k is the offset from PC and is represented in two's complement
  *  form.
  */
-int avr_translate_BRBC(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_BRBC(DisasContext *ctx, uint32_t opcode)
 {
     TCGLabel *taken = gen_new_label();
     int Imm = sextract32(BRBC_Imm(opcode), 0, 7);
@@ -536,7 +532,7 @@ int avr_translate_BRBC(DisasContext *ctx, uint32_t opcode)
  *  PC in either direction (PC - 63 < = destination <= PC + 64). The parameter k
  *  is the offset from PC and is represented in two's complement form.
  */
-int avr_translate_BRBS(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_BRBS(DisasContext *ctx, uint32_t opcode)
 {
     TCGLabel *taken = gen_new_label();
     int Imm = sextract32(BRBS_Imm(opcode), 0, 7);
@@ -578,7 +574,7 @@ int avr_translate_BRBS(DisasContext *ctx, uint32_t opcode)
 /*
  *  Sets a single Flag or bit in SREG.
  */
-int avr_translate_BSET(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_BSET(DisasContext *ctx, uint32_t opcode)
 {
     switch (BSET_Bit(opcode)) {
     case 0x00:
@@ -620,7 +616,7 @@ int avr_translate_BSET(DisasContext *ctx, uint32_t opcode)
  *  is not available in all devices. Refer to the device specific instruction
  *  set summary.
  */
-int avr_translate_BREAK(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_BREAK(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_BREAK) == false) {
         gen_helper_unsupported(cpu_env);
@@ -635,7 +631,7 @@ int avr_translate_BREAK(DisasContext *ctx, uint32_t opcode)
 /*
  *  Stores bit b from Rd to the T Flag in SREG (Status Register).
  */
-int avr_translate_BST(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_BST(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[BST_Rd(opcode)];
 
@@ -652,7 +648,7 @@ int avr_translate_BST(DisasContext *ctx, uint32_t opcode)
  *  CALL.  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_CALL(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_CALL(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_JMP_CALL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -673,7 +669,7 @@ int avr_translate_CALL(DisasContext *ctx, uint32_t opcode)
  *  Clears a specified bit in an I/O Register. This instruction operates on
  *  the lower 32 I/O Registers -- addresses 0-31.
  */
-int avr_translate_CBI(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_CBI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv data = tcg_temp_new_i32();
     TCGv port = tcg_const_i32(CBI_Imm(opcode));
@@ -693,7 +689,7 @@ int avr_translate_CBI(DisasContext *ctx, uint32_t opcode)
  *  between the contents of register Rd and the complement of the constant mask
  *  K. The result will be placed in register Rd.
  */
-int avr_translate_COM(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_COM(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[COM_Rd(opcode)];
     TCGv R = tcg_temp_new_i32();
@@ -714,7 +710,7 @@ int avr_translate_COM(DisasContext *ctx, uint32_t opcode)
  *  None of the registers are changed. All conditional branches can be used
  *  after this instruction.
  */
-int avr_translate_CP(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_CP(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[CP_Rd(opcode)];
     TCGv Rr = cpu_r[CP_Rr(opcode)];
@@ -738,7 +734,7 @@ int avr_translate_CP(DisasContext *ctx, uint32_t opcode)
  *  also takes into account the previous carry. None of the registers are
  *  changed. All conditional branches can be used after this instruction.
  */
-int avr_translate_CPC(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_CPC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[CPC_Rd(opcode)];
     TCGv Rr = cpu_r[CPC_Rr(opcode)];
@@ -768,7 +764,7 @@ int avr_translate_CPC(DisasContext *ctx, uint32_t opcode)
  *  The register is not changed. All conditional branches can be used after this
  *  instruction.
  */
-int avr_translate_CPI(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_CPI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + CPI_Rd(opcode)];
     int Imm = CPI_Imm(opcode);
@@ -793,7 +789,7 @@ int avr_translate_CPI(DisasContext *ctx, uint32_t opcode)
  *  This instruction performs a compare between two registers Rd and Rr, and
  *  skips the next instruction if Rd = Rr.
  */
-int avr_translate_CPSE(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_CPSE(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[CPSE_Rd(opcode)];
     TCGv Rr = cpu_r[CPSE_Rr(opcode)];
@@ -817,7 +813,7 @@ int avr_translate_CPSE(DisasContext *ctx, uint32_t opcode)
  *  BREQ and BRNE branches can be expected to perform consistently.  When
  *  operating on two's complement values, all signed branches are available.
  */
-int avr_translate_DEC(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_DEC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[DEC_Rd(opcode)];
 
@@ -851,7 +847,7 @@ int avr_translate_DEC(DisasContext *ctx, uint32_t opcode)
  *  affect the result in the final ciphertext or plaintext, but reduces
  *  execution time.
  */
-int avr_translate_DES(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_DES(DisasContext *ctx, uint32_t opcode)
 {
     /* TODO: */
     if (avr_feature(ctx->env, AVR_FEATURE_DES) == false) {
@@ -871,7 +867,7 @@ int avr_translate_DES(DisasContext *ctx, uint32_t opcode)
  *  during EICALL.  This instruction is not available in all devices. Refer to
  *  the device specific instruction set summary.
  */
-int avr_translate_EICALL(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_EICALL(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_EIJMP_EICALL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -895,7 +891,7 @@ int avr_translate_EICALL(DisasContext *ctx, uint32_t opcode)
  *  memory space. See also IJMP.  This instruction is not available in all
  *  devices. Refer to the device specific instruction set summary.
  */
-int avr_translate_EIJMP(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_EIJMP(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_EIJMP_EICALL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -924,7 +920,7 @@ int avr_translate_EIJMP(DisasContext *ctx, uint32_t opcode)
  *  instruction is not available in all devices. Refer to the device specific
  *  instruction set summary.
  */
-int avr_translate_ELPM1(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ELPM1(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_ELPM) == false) {
         gen_helper_unsupported(cpu_env);
@@ -942,7 +938,7 @@ int avr_translate_ELPM1(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_ELPM2(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ELPM2(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_ELPM) == false) {
         gen_helper_unsupported(cpu_env);
@@ -960,7 +956,7 @@ int avr_translate_ELPM2(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_ELPMX(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ELPMX(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_ELPMX) == false) {
         gen_helper_unsupported(cpu_env);
@@ -986,7 +982,7 @@ int avr_translate_ELPMX(DisasContext *ctx, uint32_t opcode)
  *  Performs the logical EOR between the contents of register Rd and
  *  register Rr and places the result in the destination register Rd.
  */
-int avr_translate_EOR(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_EOR(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[EOR_Rd(opcode)];
     TCGv Rr = cpu_r[EOR_Rr(opcode)];
@@ -1003,7 +999,7 @@ int avr_translate_EOR(DisasContext *ctx, uint32_t opcode)
  *  This instruction performs 8-bit x 8-bit -> 16-bit unsigned
  *  multiplication and shifts the result one bit left.
  */
-int avr_translate_FMUL(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_FMUL(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1036,7 +1032,7 @@ int avr_translate_FMUL(DisasContext *ctx, uint32_t opcode)
  *  This instruction performs 8-bit x 8-bit -> 16-bit signed multiplication
  *  and shifts the result one bit left.
  */
-int avr_translate_FMULS(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_FMULS(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1075,7 +1071,7 @@ int avr_translate_FMULS(DisasContext *ctx, uint32_t opcode)
  *  This instruction performs 8-bit x 8-bit -> 16-bit signed multiplication
  *  and shifts the result one bit left.
  */
-int avr_translate_FMULSU(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_FMULSU(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1114,7 +1110,7 @@ int avr_translate_FMULSU(DisasContext *ctx, uint32_t opcode)
  *  CALL.  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_ICALL(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ICALL(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_IJMP_ICALL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1137,7 +1133,7 @@ int avr_translate_ICALL(DisasContext *ctx, uint32_t opcode)
  *  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_IJMP(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_IJMP(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_IJMP_ICALL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1154,7 +1150,7 @@ int avr_translate_IJMP(DisasContext *ctx, uint32_t opcode)
  *  Loads data from the I/O Space (Ports, Timers, Configuration Registers,
  *  etc.) into register Rd in the Register File.
  */
-int avr_translate_IN(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_IN(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[IN_Rd(opcode)];
     int Imm = IN_Imm(opcode);
@@ -1175,7 +1171,7 @@ int avr_translate_IN(DisasContext *ctx, uint32_t opcode)
  *  BREQ and BRNE branches can be expected to perform consistently. When
  *  operating on two's complement values, all signed branches are available.
  */
-int avr_translate_INC(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_INC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[INC_Rd(opcode)];
 
@@ -1193,7 +1189,7 @@ int avr_translate_INC(DisasContext *ctx, uint32_t opcode)
  *  RJMP.  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.0
  */
-int avr_translate_JMP(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_JMP(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_JMP_CALL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1233,7 +1229,7 @@ static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)
     }
 }
 
-int avr_translate_LAC(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LAC(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_RMW) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1270,7 +1266,7 @@ int avr_translate_LAC(DisasContext *ctx, uint32_t opcode)
  *  The Z-pointer Register is left unchanged by the operation. This instruction
  *  is especially suited for setting status bits stored in SRAM.
  */
-int avr_translate_LAS(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LAS(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_RMW) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1306,7 +1302,7 @@ int avr_translate_LAS(DisasContext *ctx, uint32_t opcode)
  *  The Z-pointer Register is left unchanged by the operation. This instruction
  *  is especially suited for changing status bits stored in SRAM.
  */
-int avr_translate_LAT(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LAT(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_RMW) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1357,7 +1353,7 @@ int avr_translate_LAT(DisasContext *ctx, uint32_t opcode)
  *  operation as LPM since the program memory is mapped to the data memory
  *  space.
  */
-int avr_translate_LDX1(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDX1(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDX1_Rd(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -1369,7 +1365,7 @@ int avr_translate_LDX1(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDX2(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDX2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDX2_Rd(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -1384,7 +1380,7 @@ int avr_translate_LDX2(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDX3(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDX3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDX3_Rd(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -1423,7 +1419,7 @@ int avr_translate_LDX3(DisasContext *ctx, uint32_t opcode)
  *  be used to achieve the same operation as LPM since the program memory is
  *  mapped to the data memory space.
  */
-int avr_translate_LDY2(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDY2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDY2_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -1438,7 +1434,7 @@ int avr_translate_LDY2(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDY3(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDY3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDY3_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -1452,7 +1448,7 @@ int avr_translate_LDY3(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDDY(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDDY(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDDY_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -1494,7 +1490,7 @@ int avr_translate_LDDY(DisasContext *ctx, uint32_t opcode)
  *  space.  For using the Z-pointer for table lookup in Program memory see the
  *  LPM and ELPM instructions.
  */
-int avr_translate_LDZ2(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDZ2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDZ2_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -1509,7 +1505,7 @@ int avr_translate_LDZ2(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDZ3(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDZ3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDZ3_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -1524,7 +1520,7 @@ int avr_translate_LDZ3(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LDDZ(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDDZ(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDDZ_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -1541,7 +1537,7 @@ int avr_translate_LDDZ(DisasContext *ctx, uint32_t opcode)
 /*
     Loads an 8 bit constant directly to register 16 to 31.
  */
-int avr_translate_LDI(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + LDI_Rd(opcode)];
     int imm = LDI_Imm(opcode);
@@ -1563,7 +1559,7 @@ int avr_translate_LDI(DisasContext *ctx, uint32_t opcode)
  *  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_LDS(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LDS(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LDS_Rd(opcode)];
     TCGv addr = tcg_temp_new_i32();
@@ -1595,7 +1591,7 @@ int avr_translate_LDS(DisasContext *ctx, uint32_t opcode)
  *  available in all devices. Refer to the device specific instruction set
  *  summary
  */
-int avr_translate_LPM1(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LPM1(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_LPM) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1618,7 +1614,7 @@ int avr_translate_LPM1(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LPM2(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LPM2(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_LPM) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1641,7 +1637,7 @@ int avr_translate_LPM2(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_LPMX(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LPMX(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_LPMX) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1676,7 +1672,7 @@ int avr_translate_LPMX(DisasContext *ctx, uint32_t opcode)
  *  loaded into the C Flag of the SREG. This operation effectively divides an
  *  unsigned value by two. The C Flag can be used to round the result.
  */
-int avr_translate_LSR(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_LSR(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[LSR_Rd(opcode)];
 
@@ -1694,7 +1690,7 @@ int avr_translate_LSR(DisasContext *ctx, uint32_t opcode)
  *  register Rr is left unchanged, while the destination register Rd is loaded
  *  with a copy of Rr.
  */
-int avr_translate_MOV(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_MOV(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[MOV_Rd(opcode)];
     TCGv Rr = cpu_r[MOV_Rr(opcode)];
@@ -1711,7 +1707,7 @@ int avr_translate_MOV(DisasContext *ctx, uint32_t opcode)
  *  instruction is not available in all devices. Refer to the device specific
  *  instruction set summary.
  */
-int avr_translate_MOVW(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_MOVW(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_MOVW) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1733,7 +1729,7 @@ int avr_translate_MOVW(DisasContext *ctx, uint32_t opcode)
 /*
  *  This instruction performs 8-bit x 8-bit -> 16-bit unsigned multiplication.
  */
-int avr_translate_MUL(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_MUL(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1765,7 +1761,7 @@ int avr_translate_MUL(DisasContext *ctx, uint32_t opcode)
 /*
  *  This instruction performs 8-bit x 8-bit -> 16-bit signed multiplication.
  */
-int avr_translate_MULS(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_MULS(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1805,7 +1801,7 @@ int avr_translate_MULS(DisasContext *ctx, uint32_t opcode)
  *  This instruction performs 8-bit x 8-bit -> 16-bit multiplication of a
  *  signed and an unsigned number.
  */
-int avr_translate_MULSU(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_MULSU(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_MUL) == false) {
         gen_helper_unsupported(cpu_env);
@@ -1842,7 +1838,7 @@ int avr_translate_MULSU(DisasContext *ctx, uint32_t opcode)
  *  Replaces the contents of register Rd with its two's complement; the
  *  value $80 is left unchanged.
  */
-int avr_translate_NEG(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_NEG(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[SUB_Rd(opcode)];
     TCGv t0 = tcg_const_i32(0);
@@ -1868,7 +1864,7 @@ int avr_translate_NEG(DisasContext *ctx, uint32_t opcode)
 /*
  *  This instruction performs a single cycle No Operation.
  */
-int avr_translate_NOP(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_NOP(DisasContext *ctx, uint32_t opcode)
 {
 
     /* NOP */
@@ -1880,7 +1876,7 @@ int avr_translate_NOP(DisasContext *ctx, uint32_t opcode)
  *  Performs the logical OR between the contents of register Rd and register
  *  Rr and places the result in the destination register Rd.
  */
-int avr_translate_OR(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_OR(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[OR_Rd(opcode)];
     TCGv Rr = cpu_r[OR_Rr(opcode)];
@@ -1900,7 +1896,7 @@ int avr_translate_OR(DisasContext *ctx, uint32_t opcode)
  *  Performs the logical OR between the contents of register Rd and a
  *  constant and places the result in the destination register Rd.
  */
-int avr_translate_ORI(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ORI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + ORI_Rd(opcode)];
     int Imm = (ORI_Imm(opcode));
@@ -1917,7 +1913,7 @@ int avr_translate_ORI(DisasContext *ctx, uint32_t opcode)
  *  Stores data from register Rr in the Register File to I/O Space (Ports,
  *  Timers, Configuration Registers, etc.).
  */
-int avr_translate_OUT(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_OUT(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[OUT_Rd(opcode)];
     int Imm = OUT_Imm(opcode);
@@ -1936,7 +1932,7 @@ int avr_translate_OUT(DisasContext *ctx, uint32_t opcode)
  *  available in all devices. Refer to the device specific instruction set
  *  summary.
  */
-int avr_translate_POP(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_POP(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[POP_Rd(opcode)];
 
@@ -1952,7 +1948,7 @@ int avr_translate_POP(DisasContext *ctx, uint32_t opcode)
  *  not available in all devices. Refer to the device specific instruction set
  *  summary.
  */
-int avr_translate_PUSH(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_PUSH(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[PUSH_Rd(opcode)];
 
@@ -1970,7 +1966,7 @@ int avr_translate_PUSH(DisasContext *ctx, uint32_t opcode)
  *  address location. The Stack Pointer uses a post-decrement scheme during
  *  RCALL.
  */
-int avr_translate_RCALL(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_RCALL(DisasContext *ctx, uint32_t opcode)
 {
     int ret = ctx->inst[0].npc;
     int dst = ctx->inst[0].npc + sextract32(RCALL_Imm(opcode), 0, 12);
@@ -1985,7 +1981,7 @@ int avr_translate_RCALL(DisasContext *ctx, uint32_t opcode)
  *  Returns from subroutine. The return address is loaded from the STACK.
  *  The Stack Pointer uses a preincrement scheme during RET.
  */
-int avr_translate_RET(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_RET(DisasContext *ctx, uint32_t opcode)
 {
     gen_pop_ret(ctx, cpu_pc);
 
@@ -2002,7 +1998,7 @@ int avr_translate_RET(DisasContext *ctx, uint32_t opcode)
  *  the application program. The Stack Pointer uses a pre-increment scheme
  *  during RETI.
  */
-int avr_translate_RETI(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_RETI(DisasContext *ctx, uint32_t opcode)
 {
     gen_pop_ret(ctx, cpu_pc);
 
@@ -2019,7 +2015,7 @@ int avr_translate_RETI(DisasContext *ctx, uint32_t opcode)
  *  instruction can address the entire memory from every address location. See
  *  also JMP.
  */
-int avr_translate_RJMP(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_RJMP(DisasContext *ctx, uint32_t opcode)
 {
     int dst = ctx->inst[0].npc + sextract32(RJMP_Imm(opcode), 0, 12);
 
@@ -2035,7 +2031,7 @@ int avr_translate_RJMP(DisasContext *ctx, uint32_t opcode)
  *  LSR it effectively divides multi-byte unsigned values by two. The Carry Flag
  *  can be used to round the result.
  */
-int avr_translate_ROR(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_ROR(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[ROR_Rd(opcode)];
     TCGv t0 = tcg_temp_new_i32();
@@ -2057,7 +2053,7 @@ int avr_translate_ROR(DisasContext *ctx, uint32_t opcode)
  *  Subtracts two registers and subtracts with the C Flag and places the
  *  result in the destination register Rd.
  */
-int avr_translate_SBC(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SBC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[SBC_Rd(opcode)];
     TCGv Rr = cpu_r[SBC_Rr(opcode)];
@@ -2083,7 +2079,7 @@ int avr_translate_SBC(DisasContext *ctx, uint32_t opcode)
 /*
  *  SBCI -- Subtract Immediate with Carry
  */
-int avr_translate_SBCI(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SBCI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + SBCI_Rd(opcode)];
     TCGv Rr = tcg_const_i32(SBCI_Imm(opcode));
@@ -2111,7 +2107,7 @@ int avr_translate_SBCI(DisasContext *ctx, uint32_t opcode)
  *  Sets a specified bit in an I/O Register. This instruction operates on
  *  the lower 32 I/O Registers -- addresses 0-31.
  */
-int avr_translate_SBI(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SBI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv data = tcg_temp_new_i32();
     TCGv port = tcg_const_i32(SBI_Imm(opcode));
@@ -2131,7 +2127,7 @@ int avr_translate_SBI(DisasContext *ctx, uint32_t opcode)
  *  next instruction if the bit is cleared. This instruction operates on the
  *  lower 32 I/O Registers -- addresses 0-31.
  */
-int avr_translate_SBIC(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SBIC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv data = tcg_temp_new_i32();
     TCGv port = tcg_const_i32(SBIC_Imm(opcode));
@@ -2158,7 +2154,7 @@ int avr_translate_SBIC(DisasContext *ctx, uint32_t opcode)
  *  next instruction if the bit is set. This instruction operates on the lower
  *  32 I/O Registers -- addresses 0-31.
  */
-int avr_translate_SBIS(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SBIS(DisasContext *ctx, uint32_t opcode)
 {
     TCGv data = tcg_temp_new_i32();
     TCGv port = tcg_const_i32(SBIS_Imm(opcode));
@@ -2187,7 +2183,7 @@ int avr_translate_SBIS(DisasContext *ctx, uint32_t opcode)
  *  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_SBIW(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SBIW(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_ADIW_SBIW) == false) {
         gen_helper_unsupported(cpu_env);
@@ -2237,7 +2233,7 @@ int avr_translate_SBIW(DisasContext *ctx, uint32_t opcode)
  *  This instruction tests a single bit in a register and skips the next
  *  instruction if the bit is cleared.
  */
-int avr_translate_SBRC(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SBRC(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rr = cpu_r[SBRC_Rr(opcode)];
     TCGv t0 = tcg_temp_new_i32();
@@ -2260,7 +2256,7 @@ int avr_translate_SBRC(DisasContext *ctx, uint32_t opcode)
  *  This instruction tests a single bit in a register and skips the next
  *  instruction if the bit is set.
  */
-int avr_translate_SBRS(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SBRS(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rr = cpu_r[SBRS_Rr(opcode)];
     TCGv t0 = tcg_temp_new_i32();
@@ -2283,7 +2279,7 @@ int avr_translate_SBRS(DisasContext *ctx, uint32_t opcode)
  *  This instruction sets the circuit in sleep mode defined by the MCU
  *  Control Register.
  */
-int avr_translate_SLEEP(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SLEEP(DisasContext *ctx, uint32_t opcode)
 {
     gen_helper_sleep(cpu_env);
 
@@ -2307,7 +2303,7 @@ int avr_translate_SLEEP(DisasContext *ctx, uint32_t opcode)
  *  determines the instruction high byte, and R0 determines the instruction low
  *  byte.
  */
-int avr_translate_SPM(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SPM(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_SPM) == false) {
         gen_helper_unsupported(cpu_env);
@@ -2319,7 +2315,7 @@ int avr_translate_SPM(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_SPMX(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SPMX(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_SPMX) == false) {
         gen_helper_unsupported(cpu_env);
@@ -2331,7 +2327,7 @@ int avr_translate_SPMX(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STX1(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_STX1(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STX1_Rr(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -2343,7 +2339,7 @@ int avr_translate_STX1(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STX2(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_STX2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STX2_Rr(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -2357,7 +2353,7 @@ int avr_translate_STX2(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STX3(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_STX3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STX3_Rr(opcode)];
     TCGv addr = gen_get_xaddr();
@@ -2371,7 +2367,7 @@ int avr_translate_STX3(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STY2(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_STY2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STY2_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -2385,7 +2381,7 @@ int avr_translate_STY2(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STY3(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_STY3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STY3_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -2399,7 +2395,7 @@ int avr_translate_STY3(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STDY(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_STDY(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STDY_Rd(opcode)];
     TCGv addr = gen_get_yaddr();
@@ -2413,7 +2409,7 @@ int avr_translate_STDY(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STZ2(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_STZ2(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STZ2_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -2428,7 +2424,7 @@ int avr_translate_STZ2(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STZ3(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_STZ3(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STZ3_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -2443,7 +2439,7 @@ int avr_translate_STZ3(DisasContext *ctx, uint32_t opcode)
     return BS_NONE;
 }
 
-int avr_translate_STDZ(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_STDZ(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STDZ_Rd(opcode)];
     TCGv addr = gen_get_zaddr();
@@ -2469,7 +2465,7 @@ int avr_translate_STDZ(DisasContext *ctx, uint32_t opcode)
  *  This instruction is not available in all devices. Refer to the device
  *  specific instruction set summary.
  */
-int avr_translate_STS(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_STS(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[STS_Rd(opcode)];
     TCGv addr = tcg_temp_new_i32();
@@ -2490,7 +2486,7 @@ int avr_translate_STS(DisasContext *ctx, uint32_t opcode)
  *  Subtracts two registers and places the result in the destination
  *  register Rd.
  */
-int avr_translate_SUB(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SUB(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[SUB_Rd(opcode)];
     TCGv Rr = cpu_r[SUB_Rr(opcode)];
@@ -2517,7 +2513,7 @@ int avr_translate_SUB(DisasContext *ctx, uint32_t opcode)
  *  destination register Rd. This instruction is working on Register R16 to R31
  *  and is very well suited for operations on the X, Y, and Z-pointers.
  */
-int avr_translate_SUBI(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SUBI(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[16 + SUBI_Rd(opcode)];
     TCGv Rr = tcg_const_i32(SUBI_Imm(opcode));
@@ -2544,7 +2540,7 @@ int avr_translate_SUBI(DisasContext *ctx, uint32_t opcode)
 /*
  *  Swaps high and low nibbles in a register.
  */
-int avr_translate_SWAP(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_SWAP(DisasContext *ctx, uint32_t opcode)
 {
     TCGv Rd = cpu_r[SWAP_Rd(opcode)];
     TCGv t0 = tcg_temp_new_i32();
@@ -2567,7 +2563,7 @@ int avr_translate_SWAP(DisasContext *ctx, uint32_t opcode)
  *  executed within a limited time given by the WD prescaler. See the Watchdog
  *  Timer hardware specification.
  */
-int avr_translate_WDR(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_WDR(DisasContext *ctx, uint32_t opcode)
 {
     gen_helper_wdr(cpu_env);
 
@@ -2583,7 +2579,7 @@ int avr_translate_WDR(DisasContext *ctx, uint32_t opcode)
  *  is left unchanged by the operation. This instruction is especially suited
  *  for writing/reading status bits stored in SRAM.
  */
-int avr_translate_XCH(DisasContext *ctx, uint32_t opcode)
+static int avr_translate_XCH(DisasContext *ctx, uint32_t opcode)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_RMW) == false) {
         gen_helper_unsupported(cpu_env);
diff --git a/target/avr/translate-inst.h b/target/avr/translate-inst.h
index edb87439d6..7371c6fcca 100644
--- a/target/avr/translate-inst.h
+++ b/target/avr/translate-inst.h
@@ -21,11 +21,6 @@
 #ifndef AVR_TRANSLATE_INST_H_
 #define AVR_TRANSLATE_INST_H_
 
-typedef struct DisasContext DisasContext;
-
-int avr_translate_NOP(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_MOVW(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t MOVW_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 4);
@@ -36,7 +31,6 @@ static inline uint32_t MOVW_Rd(uint32_t opcode)
     return extract32(opcode, 4, 4);
 }
 
-int avr_translate_MULS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t MULS_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 4);
@@ -47,7 +41,6 @@ static inline uint32_t MULS_Rd(uint32_t opcode)
     return extract32(opcode, 4, 4);
 }
 
-int avr_translate_MULSU(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t MULSU_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -58,7 +51,6 @@ static inline uint32_t MULSU_Rd(uint32_t opcode)
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_FMUL(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t FMUL_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -69,7 +61,6 @@ static inline uint32_t FMUL_Rd(uint32_t opcode)
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_FMULS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t FMULS_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -80,7 +71,6 @@ static inline uint32_t FMULS_Rd(uint32_t opcode)
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_FMULSU(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t FMULSU_Rr(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -91,7 +81,6 @@ static inline uint32_t FMULSU_Rd(uint32_t opcode)
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_CPC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CPC_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -103,7 +92,6 @@ static inline uint32_t CPC_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_SBC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBC_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -115,7 +103,6 @@ static inline uint32_t SBC_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_ADD(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ADD_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -127,7 +114,6 @@ static inline uint32_t ADD_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_AND(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t AND_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -139,7 +125,6 @@ static inline uint32_t AND_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_EOR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t EOR_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -151,7 +136,6 @@ static inline uint32_t EOR_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_OR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t OR_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -163,7 +147,6 @@ static inline uint32_t OR_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_MOV(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t MOV_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -175,7 +158,6 @@ static inline uint32_t MOV_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_CPSE(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CPSE_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -187,7 +169,6 @@ static inline uint32_t CPSE_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_CP(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CP_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -199,7 +180,6 @@ static inline uint32_t CP_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_SUB(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SUB_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -211,7 +191,6 @@ static inline uint32_t SUB_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_ADC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ADC_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -223,7 +202,6 @@ static inline uint32_t ADC_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_CPI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CPI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -235,7 +213,6 @@ static inline uint32_t CPI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_SBCI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBCI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -247,7 +224,6 @@ static inline uint32_t SBCI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_ORI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ORI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -259,7 +235,6 @@ static inline uint32_t ORI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_SUBI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SUBI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -271,7 +246,6 @@ static inline uint32_t SUBI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_ANDI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ANDI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -283,7 +257,6 @@ static inline uint32_t ANDI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_LDDZ(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDDZ_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -296,7 +269,6 @@ static inline uint32_t LDDZ_Imm(uint32_t opcode)
             (extract32(opcode, 0, 3));
 }
 
-int avr_translate_LDDY(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDDY_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -309,7 +281,6 @@ static inline uint32_t LDDY_Imm(uint32_t opcode)
             (extract32(opcode, 0, 3));
 }
 
-int avr_translate_STDZ(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STDZ_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -322,7 +293,6 @@ static inline uint32_t STDZ_Imm(uint32_t opcode)
             (extract32(opcode, 0, 3));
 }
 
-int avr_translate_STDY(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STDY_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -335,7 +305,6 @@ static inline uint32_t STDY_Imm(uint32_t opcode)
             (extract32(opcode, 0, 3));
 }
 
-int avr_translate_LDS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDS_Imm(uint32_t opcode)
 {
     return extract32(opcode, 0, 16);
@@ -346,79 +315,66 @@ static inline uint32_t LDS_Rd(uint32_t opcode)
     return extract32(opcode, 20, 5);
 }
 
-int avr_translate_LDZ2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDZ2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDZ3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDZ3_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LPM2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LPM2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LPMX(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LPMX_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_ELPM2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ELPM2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_ELPMX(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ELPMX_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDY2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDY2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDY3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDY3_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDX1(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDX1_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDX2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDX2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LDX3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDX3_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_POP(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t POP_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STS_Imm(uint32_t opcode)
 {
     return extract32(opcode, 0, 16);
@@ -429,185 +385,133 @@ static inline uint32_t STS_Rd(uint32_t opcode)
     return extract32(opcode, 20, 5);
 }
 
-int avr_translate_STZ2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STZ2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STZ3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STZ3_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_XCH(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t XCH_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LAS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LAS_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LAC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LAC_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LAT(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LAT_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STY2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STY2_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STY3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STY3_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STX1(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STX1_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STX2(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STX2_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_STX3(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t STX3_Rr(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_PUSH(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t PUSH_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_COM(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t COM_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_NEG(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t NEG_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_SWAP(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SWAP_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_INC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t INC_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_ASR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ASR_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_LSR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LSR_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_ROR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ROR_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_BSET(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BSET_Bit(uint32_t opcode)
 {
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_IJMP(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_EIJMP(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_BCLR(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BCLR_Bit(uint32_t opcode)
 {
     return extract32(opcode, 4, 3);
 }
 
-int avr_translate_RET(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_RETI(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_ICALL(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_EICALL(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_SLEEP(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_BREAK(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_WDR(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_LPM1(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_ELPM1(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_SPM(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_SPMX(DisasContext *ctx, uint32_t opcode);
-
-int avr_translate_DEC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t DEC_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_DES(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t DES_Imm(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
 }
 
-int avr_translate_JMP(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t JMP_Imm(uint32_t opcode)
 {
     return (extract32(opcode, 20, 5) << 17) |
             (extract32(opcode, 0, 17));
 }
 
-int avr_translate_CALL(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CALL_Imm(uint32_t opcode)
 {
     return (extract32(opcode, 20, 5) << 17) |
             (extract32(opcode, 0, 17));
 }
 
-int avr_translate_ADIW(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t ADIW_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 2);
@@ -619,7 +523,6 @@ static inline uint32_t ADIW_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_SBIW(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBIW_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 2);
@@ -631,7 +534,6 @@ static inline uint32_t SBIW_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_CBI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t CBI_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -642,7 +544,6 @@ static inline uint32_t CBI_Imm(uint32_t opcode)
     return extract32(opcode, 3, 5);
 }
 
-int avr_translate_SBIC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBIC_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -653,7 +554,6 @@ static inline uint32_t SBIC_Imm(uint32_t opcode)
     return extract32(opcode, 3, 5);
 }
 
-int avr_translate_SBI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBI_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -664,7 +564,6 @@ static inline uint32_t SBI_Imm(uint32_t opcode)
     return extract32(opcode, 3, 5);
 }
 
-int avr_translate_SBIS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBIS_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -675,7 +574,6 @@ static inline uint32_t SBIS_Imm(uint32_t opcode)
     return extract32(opcode, 3, 5);
 }
 
-int avr_translate_MUL(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t MUL_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -687,7 +585,6 @@ static inline uint32_t MUL_Rr(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_IN(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t IN_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -699,7 +596,6 @@ static inline uint32_t IN_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_OUT(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t OUT_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 5);
@@ -711,13 +607,11 @@ static inline uint32_t OUT_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_RJMP(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t RJMP_Imm(uint32_t opcode)
 {
     return extract32(opcode, 0, 12);
 }
 
-int avr_translate_LDI(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t LDI_Rd(uint32_t opcode)
 {
     return extract32(opcode, 4, 4);
@@ -729,13 +623,11 @@ static inline uint32_t LDI_Imm(uint32_t opcode)
             (extract32(opcode, 0, 4));
 }
 
-int avr_translate_RCALL(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t RCALL_Imm(uint32_t opcode)
 {
     return extract32(opcode, 0, 12);
 }
 
-int avr_translate_BRBS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BRBS_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -746,7 +638,6 @@ static inline uint32_t BRBS_Imm(uint32_t opcode)
     return extract32(opcode, 3, 7);
 }
 
-int avr_translate_BRBC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BRBC_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -757,7 +648,6 @@ static inline uint32_t BRBC_Imm(uint32_t opcode)
     return extract32(opcode, 3, 7);
 }
 
-int avr_translate_BLD(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BLD_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -768,7 +658,6 @@ static inline uint32_t BLD_Rd(uint32_t opcode)
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_BST(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t BST_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -779,7 +668,6 @@ static inline uint32_t BST_Rd(uint32_t opcode)
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_SBRC(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBRC_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
@@ -790,7 +678,6 @@ static inline uint32_t SBRC_Rr(uint32_t opcode)
     return extract32(opcode, 4, 5);
 }
 
-int avr_translate_SBRS(DisasContext *ctx, uint32_t opcode);
 static inline uint32_t SBRS_Bit(uint32_t opcode)
 {
     return extract32(opcode, 0, 3);
diff --git a/target/avr/translate.c b/target/avr/translate.c
index d9e491fc3b..184e66c04e 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -18,32 +18,93 @@
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
-#include "translate.h"
 
-TCGv_env cpu_env;
+#include "qemu/osdep.h"
+#include "tcg/tcg.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "disas/disas.h"
+#include "tcg-op.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/log.h"
+
+static TCGv_env cpu_env;
+
+static TCGv cpu_pc;
+
+static TCGv cpu_Cf;
+static TCGv cpu_Zf;
+static TCGv cpu_Nf;
+static TCGv cpu_Vf;
+static TCGv cpu_Sf;
+static TCGv cpu_Hf;
+static TCGv cpu_Tf;
+static TCGv cpu_If;
+
+static TCGv cpu_rampD;
+static TCGv cpu_rampX;
+static TCGv cpu_rampY;
+static TCGv cpu_rampZ;
+
+static TCGv cpu_r[32];
+static TCGv cpu_eind;
+static TCGv cpu_sp;
 
-TCGv cpu_pc;
-
-TCGv cpu_Cf;
-TCGv cpu_Zf;
-TCGv cpu_Nf;
-TCGv cpu_Vf;
-TCGv cpu_Sf;
-TCGv cpu_Hf;
-TCGv cpu_Tf;
-TCGv cpu_If;
+#define REG(x) (cpu_r[x])
 
-TCGv cpu_rampD;
-TCGv cpu_rampX;
-TCGv cpu_rampY;
-TCGv cpu_rampZ;
+enum {
+    BS_NONE = 0, /* Nothing special (none of the below) */
+    BS_STOP = 1, /* We want to stop translation for any reason */
+    BS_BRANCH = 2, /* A branch condition is reached */
+    BS_EXCP = 3, /* An exception condition is reached */
+};
+
+typedef struct DisasContext DisasContext;
+typedef struct InstInfo InstInfo;
+
+typedef int (*translate_function_t)(DisasContext *ctx, uint32_t opcode);
+struct InstInfo {
+    target_long cpc;
+    target_long npc;
+    uint32_t opcode;
+    translate_function_t translate;
+    unsigned length;
+};
+
+/* This is the state at translation time. */
+struct DisasContext {
+    struct TranslationBlock *tb;
+    CPUAVRState *env;
+
+    InstInfo inst[2];/* two consecutive instructions */
+
+    /* Routine used to access memory */
+    int memidx;
+    int bstate;
+    int singlestep;
+};
+
+static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
+{
+    TranslationBlock *tb = ctx->tb;
 
-TCGv cpu_r[32];
-TCGv cpu_eind;
-TCGv cpu_sp;
+    if (ctx->singlestep == 0) {
+        tcg_gen_goto_tb(n);
+        tcg_gen_movi_i32(cpu_pc, dest);
+        tcg_gen_exit_tb((uintptr_t)tb + n);
+    } else {
+        tcg_gen_movi_i32(cpu_pc, dest);
+        gen_helper_debug(cpu_env);
+        tcg_gen_exit_tb(0);
+    }
+}
 
 #include "exec/gen-icount.h"
-#define REG(x) (cpu_r[x])
+#include "translate-inst.h"
+#include "translate-inst.c"
+#include "decode.c"
 
 void avr_translate_init(void)
 {
diff --git a/target/avr/translate.h b/target/avr/translate.h
deleted file mode 100644
index fabbe69ee9..0000000000
--- a/target/avr/translate.h
+++ /dev/null
@@ -1,112 +0,0 @@
-/*
- * QEMU AVR CPU
- *
- * Copyright (c) 2016 Michael Rolnik
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see
- * <http://www.gnu.org/licenses/lgpl-2.1.html>
- */
-
-#ifndef AVR_TRANSLATE_H_
-#define AVR_TRANSLATE_H_
-
-#include "qemu/osdep.h"
-
-#include "tcg/tcg.h"
-#include "cpu.h"
-#include "exec/exec-all.h"
-#include "disas/disas.h"
-#include "tcg-op.h"
-#include "exec/cpu_ldst.h"
-
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
-#include "exec/log.h"
-#include "translate-inst.h"
-
-extern TCGv_env cpu_env;
-
-extern TCGv cpu_pc;
-
-extern TCGv cpu_Cf;
-extern TCGv cpu_Zf;
-extern TCGv cpu_Nf;
-extern TCGv cpu_Vf;
-extern TCGv cpu_Sf;
-extern TCGv cpu_Hf;
-extern TCGv cpu_Tf;
-extern TCGv cpu_If;
-
-extern TCGv cpu_rampD;
-extern TCGv cpu_rampX;
-extern TCGv cpu_rampY;
-extern TCGv cpu_rampZ;
-
-extern TCGv cpu_r[32];
-extern TCGv cpu_eind;
-extern TCGv cpu_sp;
-
-enum {
-    BS_NONE = 0, /* Nothing special (none of the below) */
-    BS_STOP = 1, /* We want to stop translation for any reason */
-    BS_BRANCH = 2, /* A branch condition is reached */
-    BS_EXCP = 3, /* An exception condition is reached */
-};
-
-uint32_t get_opcode(uint8_t const *code, unsigned bitBase, unsigned bitSize);
-
-typedef struct DisasContext DisasContext;
-typedef struct InstInfo InstInfo;
-
-typedef int (*translate_function_t)(DisasContext *ctx, uint32_t opcode);
-struct InstInfo {
-    target_long cpc;
-    target_long npc;
-    uint32_t opcode;
-    translate_function_t translate;
-    unsigned length;
-};
-
-/* This is the state at translation time. */
-struct DisasContext {
-    struct TranslationBlock *tb;
-    CPUAVRState *env;
-
-    InstInfo inst[2];/* two consecutive instructions */
-
-    /* Routine used to access memory */
-    int memidx;
-    int bstate;
-    int singlestep;
-};
-
-void avr_decode(uint32_t pc, uint32_t *length, uint32_t opcode,
-                        translate_function_t *translate);
-
-static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
-{
-    TranslationBlock *tb = ctx->tb;
-
-    if (ctx->singlestep == 0) {
-        tcg_gen_goto_tb(n);
-        tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)tb + n);
-    } else {
-        tcg_gen_movi_i32(cpu_pc, dest);
-        gen_helper_debug(cpu_env);
-        tcg_gen_exit_tb(0);
-    }
-}
-
-#endif
-- 
2.11.0 (Apple Git-81)
