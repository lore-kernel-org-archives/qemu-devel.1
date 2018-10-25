Received: from eggs.gnu.org ([2001:4830:134:3::10]:40350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKh-0006hs-91
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKd-0000NB-68
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40625)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKb-00008k-U3
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:45 -0400
Message-Id: <20181025172057.20414-37-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 36/48] target/xtensa: prepare for 2-pass
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
 target/xtensa/translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 14ab1c5ceb..83711f2a18 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -879,7 +879,8 @@ static inline unsigned xtensa_op0_insn_len(DisasContext *dc, uint8_t op0)
     return xtensa_isa_length_from_chars(dc->config->isa, &op0);
 }
 
-static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
+static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc,
+                              struct qemu_plugin_insn *plugin_insn)
 {
     xtensa_isa isa = dc->config->isa;
     unsigned char b[MAX_INSN_LENGTH] = {cpu_ldub_code(env, dc->pc)};
@@ -916,6 +917,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     for (i = 1; i < len; ++i) {
         b[i] = cpu_ldub_code(env, dc->pc + i);
     }
+    qemu_plugin_insn_append(plugin_insn, b, len);
     xtensa_insnbuf_from_chars(isa, dc->insnbuf, b, len);
     fmt = xtensa_format_decode(isa, dc->insnbuf);
     if (fmt == XTENSA_UNDEFINED) {
@@ -1183,7 +1185,7 @@ static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
         gen_ibreak_check(env, dc);
     }
 
-    disas_xtensa_insn(env, dc);
+    disas_xtensa_insn(env, dc, plugin_insn);
 
     if (dc->icount) {
         tcg_gen_mov_i32(cpu_SR[ICOUNT], dc->next_icount);
@@ -1241,6 +1243,8 @@ static const TranslatorOps xtensa_translator_ops = {
     .translate_insn     = xtensa_tr_translate_insn,
     .tb_stop            = xtensa_tr_tb_stop,
     .disas_log          = xtensa_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
-- 
2.17.1
