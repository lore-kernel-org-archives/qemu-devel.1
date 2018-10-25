Received: from eggs.gnu.org ([2001:4830:134:3::10]:40316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKi-0006ho-Vn
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKX-0000IN-Ie
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKU-00007U-7C
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:36 -0400
Message-Id: <20181025172057.20414-28-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 27/48] target/sh4: prepare for 2-pass translation
 (WIP)
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

XXX: cleanly get the gUSA instructions

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sh4/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ea88d46c04..a3b0fb46a2 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2333,6 +2333,7 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
 #endif
 
     ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+    qemu_plugin_insn_append(plugin_insn, &ctx->opcode, sizeof(ctx->opcode));
     decode_opc(ctx);
     ctx->base.pc_next += 2;
 }
@@ -2381,6 +2382,8 @@ static const TranslatorOps sh4_tr_ops = {
     .translate_insn     = sh4_tr_translate_insn,
     .tb_stop            = sh4_tr_tb_stop,
     .disas_log          = sh4_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
-- 
2.17.1
