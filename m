Received: from eggs.gnu.org ([209.51.188.92]:50534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gzq3b-0003di-Ti
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gzq3Z-0003Pk-MV
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:51:03 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:38162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gzq3L-0002mG-UW
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:50:58 -0500
Received: by mail-pg1-x52d.google.com with SMTP id m2so12050642pgl.5
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 13:50:44 -0800 (PST)
Date: Fri,  1 Mar 2019 13:49:39 -0800
Message-Id: <20190301214945.4353-29-palmer@sifive.com>
In-Reply-To: <20190301214945.4353-1-palmer@sifive.com>
References: <20190301214945.4353-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 28/34] target/riscv: Remove gen_system()
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

with all 16 bit insns moved to decodetree no path is falling back to
gen_system(), so we can remove it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/translate.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index dedf4189d5b7..92be090bc7bb 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -473,33 +473,6 @@ static void gen_set_rm(DisasContext *ctx, int rm)
     tcg_temp_free_i32(t0);
 }
 
-static void gen_system(DisasContext *ctx, uint32_t opc, int rd, int rs1,
-                       int csr)
-{
-    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-
-    switch (opc) {
-    case OPC_RISC_ECALL:
-        switch (csr) {
-        case 0x0: /* ECALL */
-            /* always generates U-level ECALL, fixed in do_interrupt handler */
-            generate_exception(ctx, RISCV_EXCP_U_ECALL);
-            tcg_gen_exit_tb(NULL, 0); /* no chaining */
-            ctx->base.is_jmp = DISAS_NORETURN;
-            break;
-        case 0x1: /* EBREAK */
-            generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
-            tcg_gen_exit_tb(NULL, 0); /* no chaining */
-            ctx->base.is_jmp = DISAS_NORETURN;
-            break;
-        default:
-            gen_exception_illegal(ctx);
-            break;
-        }
-        break;
-    }
-}
-
 static void decode_RV32_64C0(DisasContext *ctx)
 {
     uint8_t funct3 = extract32(ctx->opcode, 13, 3);
@@ -680,7 +653,6 @@ bool decode_insn16(DisasContext *ctx, uint16_t insn);
 
 static void decode_RV32_64G(DisasContext *ctx)
 {
-    int rs1, rd;
     uint32_t op;
 
     /* We do not do misaligned address check here: the address should never be
@@ -689,14 +661,8 @@ static void decode_RV32_64G(DisasContext *ctx)
      * perform the misaligned instruction fetch */
 
     op = MASK_OP_MAJOR(ctx->opcode);
-    rs1 = GET_RS1(ctx->opcode);
-    rd = GET_RD(ctx->opcode);
 
     switch (op) {
-    case OPC_RISC_SYSTEM:
-        gen_system(ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
-                   (ctx->opcode & 0xFFF00000) >> 20);
-        break;
     default:
         gen_exception_illegal(ctx);
         break;
-- 
2.18.1
