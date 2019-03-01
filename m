Received: from eggs.gnu.org ([209.51.188.92]:50502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gzq3b-0003cw-EG
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gzq3V-0003Ix-PU
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:51:01 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:37651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gzq3L-0002qa-75
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:50:56 -0500
Received: by mail-pl1-x62f.google.com with SMTP id q3so12093462pll.4
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 13:50:46 -0800 (PST)
Date: Fri,  1 Mar 2019 13:49:40 -0800
Message-Id: <20190301214945.4353-30-palmer@sifive.com>
In-Reply-To: <20190301214945.4353-1-palmer@sifive.com>
References: <20190301214945.4353-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 29/34] target/riscv: Remove decode_RV32_64G()
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

decodetree handles all instructions now so the fallback is not necessary
anymore.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/translate.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 92be090bc7bb..049fa65c6611 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -651,24 +651,6 @@ bool decode_insn16(DisasContext *ctx, uint16_t insn);
 #include "decode_insn16.inc.c"
 #include "insn_trans/trans_rvc.inc.c"
 
-static void decode_RV32_64G(DisasContext *ctx)
-{
-    uint32_t op;
-
-    /* We do not do misaligned address check here: the address should never be
-     * misaligned at this point. Instructions that set PC must do the check,
-     * since epc must be the address of the instruction that caused us to
-     * perform the misaligned instruction fetch */
-
-    op = MASK_OP_MAJOR(ctx->opcode);
-
-    switch (op) {
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-}
-
 static void decode_opc(DisasContext *ctx)
 {
     /* check for compressed insn */
@@ -685,8 +667,7 @@ static void decode_opc(DisasContext *ctx)
     } else {
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
         if (!decode_insn32(ctx, ctx->opcode)) {
-            /* fallback to old decoder */
-            decode_RV32_64G(ctx);
+            gen_exception_illegal(ctx);
         }
     }
 }
-- 
2.18.1
