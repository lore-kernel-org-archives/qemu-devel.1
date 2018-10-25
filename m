Received: from eggs.gnu.org ([2001:4830:134:3::10]:40316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKg-0006ho-2n
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKc-0000Mt-KR
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKb-000085-SL
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:38 -0400
Message-Id: <20181025172057.20414-30-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 29/48] target/hppa: prepare for 2-pass translation
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
 target/hppa/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6c2a7fbc46..08ebbeb21c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4757,6 +4757,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
            the page permissions for execute.  */
         uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
 
+        qemu_plugin_insn_append(plugin_insn, &insn, sizeof(insn));
+
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
         if (ctx->iaoq_b == -1) {
@@ -4887,6 +4889,8 @@ static const TranslatorOps hppa_tr_ops = {
     .translate_insn     = hppa_tr_translate_insn,
     .tb_stop            = hppa_tr_tb_stop,
     .disas_log          = hppa_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
-- 
2.17.1
