Received: from eggs.gnu.org ([2001:4830:134:3::10]:40758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTV-00021P-Dh
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTQ-0004C3-An
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:05 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:50110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDlTQ-0004B0-3H
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:00 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Sat, 20 Oct 2018 09:14:23 +0200
Message-Id: <20181020071451.27808-2-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/29] target/riscv: Move CPURISCVState
 pointer to DisasContext
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

CPURISCVState is rarely used, so there is no need to pass it to every
translate function. This paves the way for decodetree which only passes
DisasContext to translate functions.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/riscv/translate.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 18d7b6d147..e81b9f097e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -52,6 +52,7 @@ typedef struct DisasContext {
        to any system register, which includes CSR_FRM, so we do not have
        to reset this known value.  */
     int frm;
+    CPURISCVState *env;
 } DisasContext;
 
 /* convert riscv funct3 to qemu memop for load/store */
@@ -1789,19 +1790,19 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
     }
 }
 
-static void decode_opc(CPURISCVState *env, DisasContext *ctx)
+static void decode_opc(DisasContext *ctx)
 {
     /* check for compressed insn */
     if (extract32(ctx->opcode, 0, 2) != 3) {
-        if (!riscv_has_ext(env, RVC)) {
+        if (!riscv_has_ext(ctx->env, RVC)) {
             gen_exception_illegal(ctx);
         } else {
             ctx->pc_succ_insn = ctx->base.pc_next + 2;
-            decode_RV32_64C(env, ctx);
+            decode_RV32_64C(ctx->env, ctx);
         }
     } else {
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
-        decode_RV32_64G(env, ctx);
+        decode_RV32_64G(ctx->env, ctx);
     }
 }
 
@@ -1846,10 +1847,10 @@ static bool riscv_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
 static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPURISCVState *env = cpu->env_ptr;
+    ctx->env = cpu->env_ptr;
 
-    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
-    decode_opc(env, ctx);
+    ctx->opcode = cpu_ldl_code(ctx->env, ctx->base.pc_next);
+    decode_opc(ctx);
     ctx->base.pc_next = ctx->pc_succ_insn;
 
     if (ctx->base.is_jmp == DISAS_NEXT) {
-- 
2.19.1
