Received: from eggs.gnu.org ([2001:4830:134:3::10]:40232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKb-0006h0-HH
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKZ-0000Jn-R0
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKX-00008l-Vu
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:58 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:46 -0400
Message-Id: <20181025172057.20414-38-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 37/48] target/openrisc: prepare for 2-pass
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
 target/openrisc/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 947330e10a..2f084668f9 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1308,6 +1308,8 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     uint32_t insn = cpu_ldl_code(&cpu->env, dc->base.pc_next);
 
+    qemu_plugin_insn_append(plugin_insn, &insn, sizeof(insn));
+
     if (!decode(dc, insn)) {
         gen_illegal_exception(dc);
     }
@@ -1407,6 +1409,8 @@ static const TranslatorOps openrisc_tr_ops = {
     .translate_insn     = openrisc_tr_translate_insn,
     .tb_stop            = openrisc_tr_tb_stop,
     .disas_log          = openrisc_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
-- 
2.17.1
