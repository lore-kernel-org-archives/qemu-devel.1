Received: from eggs.gnu.org ([2001:4830:134:3::10]:40232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKi-0006h0-SW
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKX-0000Ih-Td
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKU-00008b-AW
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:56 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:42 -0400
Message-Id: <20181025172057.20414-34-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 33/48] target/riscv: prepare for 2-pass
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/riscv/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a33cf6802b..6f5be8e7d7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1851,6 +1851,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
 
     ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
     decode_opc(env, ctx);
+    qemu_plugin_insn_append(plugin_insn, &ctx->opcode, sizeof(ctx->opcode));
     ctx->base.pc_next = ctx->pc_succ_insn;
 
     if (ctx->base.is_jmp == DISAS_NEXT) {
@@ -1892,6 +1893,8 @@ static const TranslatorOps riscv_tr_ops = {
     .translate_insn     = riscv_tr_translate_insn,
     .tb_stop            = riscv_tr_tb_stop,
     .disas_log          = riscv_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
-- 
2.17.1
