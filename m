Received: from eggs.gnu.org ([2001:4830:134:3::10]:40307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKg-0006hj-1r
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKa-0000Jw-0P
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKY-00008m-0j
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:58 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:44 -0400
Message-Id: <20181025172057.20414-36-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 35/48] target/sparc: prepare for 2-pass
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
 target/sparc/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2fa8b68e0a..74889de426 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5902,6 +5902,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
     unsigned int insn;
 
     insn = cpu_ldl_code(env, dc->pc);
+    qemu_plugin_insn_append(plugin_insn, &insn, sizeof(insn));
     dc->base.pc_next += 4;
     disas_sparc_insn(dc, insn);
 
@@ -5961,6 +5962,8 @@ static const TranslatorOps sparc_tr_ops = {
     .translate_insn     = sparc_tr_translate_insn,
     .tb_stop            = sparc_tr_tb_stop,
     .disas_log          = sparc_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
-- 
2.17.1
