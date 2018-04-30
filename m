Received: from eggs.gnu.org ([2001:4830:134:3::10]:59417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDFhE-0002ot-Lc
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDFhA-0001P0-NW
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:46:52 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:41052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDFhA-0001LP-CG
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:46:48 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Mon, 30 Apr 2018 22:46:40 +0200
Message-Id: <20180430204640.1713-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PATCH] target/tricore: Fix QEMU crashing when using
 -singlestep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

when -singlestep is enabled we will actually return a tb->size of 0,
even though we emit one instruction. This is because we do the update to ctx.pc
after exiting the translation loop on the singlestep path. Therefore we
substract pc_start from ctx.pc, aka pc_start.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index aef0d9cf06..be2579d189 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8843,12 +8843,12 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         ctx.opcode = cpu_ldl_code(env, ctx.pc);
         decode_opc(env, &ctx, 0);

+        ctx.pc = ctx.next_pc;
         if (num_insns >= max_insns || tcg_op_buf_full()) {
             gen_save_pc(ctx.next_pc);
             tcg_gen_exit_tb(0);
             break;
         }
-        ctx.pc = ctx.next_pc;
     }

     gen_tb_end(tb, num_insns);
--
2.11.0
