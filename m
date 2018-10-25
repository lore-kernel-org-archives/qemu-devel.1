Received: from eggs.gnu.org ([2001:4830:134:3::10]:40350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKj-0006hs-0S
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKU-0000GD-BL
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44461)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKT-00005s-PJ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:35 -0400
Message-Id: <20181025172057.20414-27-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 26/48] target/ppc: prepare for 2-pass translation
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
 target/ppc/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 34c3ed0a41..88f88adaff 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7565,6 +7565,9 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
               ctx->opcode, opc1(ctx->opcode), opc2(ctx->opcode),
               opc3(ctx->opcode), opc4(ctx->opcode),
               ctx->le_mode ? "little" : "big");
+
+    qemu_plugin_insn_append(plugin_insn, &ctx->opcode, sizeof(ctx->opcode));
+
     ctx->base.pc_next += 4;
     table = env->opcodes;
     handler = table[opc1(ctx->opcode)];
@@ -7664,6 +7667,8 @@ static const TranslatorOps ppc_tr_ops = {
     .translate_insn     = ppc_tr_translate_insn,
     .tb_stop            = ppc_tr_tb_stop,
     .disas_log          = ppc_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
-- 
2.17.1
