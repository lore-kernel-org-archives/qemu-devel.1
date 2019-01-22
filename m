Received: from eggs.gnu.org ([209.51.188.92]:59106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glsVU-0006AI-Dm
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glsOV-0005z4-Be
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:30:56 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue, 22 Jan 2019 10:29:04 +0100
Message-Id: <20190122092909.5341-31-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
References: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 30/35] target/riscv: Remove decode_RV32_64G()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

decodetree handles all instructions now so the fallback is not necessary
anymore.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/translate.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0e37beb68e..b0251b3518 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -600,26 +600,6 @@ bool decode_insn16(DisasContext *ctx, uint16_t insn);
 #include "decode_insn16.inc.c"
 #include "insn_trans/trans_rvc.inc.c"
 
-static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
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
-    case OPC_RISC_SYSTEM:
-        break;
-    default:
-        gen_exception_illegal(ctx);
-        break;
-    }
-}
-
 static void decode_opc(DisasContext *ctx)
 {
     /* check for compressed insn */
@@ -636,8 +616,7 @@ static void decode_opc(DisasContext *ctx)
     } else {
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
         if (!decode_insn32(ctx, ctx->opcode)) {
-            /* fallback to old decoder */
-            decode_RV32_64G(ctx->env, ctx);
+            gen_exception_illegal(ctx);
         }
     }
 }
-- 
2.20.1
