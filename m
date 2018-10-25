Received: from eggs.gnu.org ([2001:4830:134:3::10]:40362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKh-0006hw-Fo
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKf-0000O0-GP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKc-000084-5W
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:39 -0400
Message-Id: <20181025172057.20414-31-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 30/48] target/m68k: prepare for 2-pass translation
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
 target/m68k/translate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index dd7d868b25..9b5a4b1eb5 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -116,6 +116,7 @@ typedef struct DisasContext {
     int done_mac;
     int writeback_mask;
     TCGv writeback[8];
+    struct qemu_plugin_insn *plugin_insn;
 #define MAX_TO_RELEASE 8
     int release_count;
     TCGv release[MAX_TO_RELEASE];
@@ -375,6 +376,7 @@ static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
     uint16_t im;
     im = cpu_lduw_code(env, s->pc);
     s->pc += 2;
+    qemu_plugin_insn_append(s->plugin_insn, &im, sizeof(im));
     return im;
 }
 
@@ -6092,7 +6094,10 @@ static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUM68KState *env = cpu->env_ptr;
-    uint16_t insn = read_im16(env, dc);
+    uint16_t insn;
+
+    dc->plugin_insn = plugin_insn;
+    insn = read_im16(env, dc);
 
     opcode_table[insn](env, dc, insn);
     do_writebacks(dc);
@@ -6167,6 +6172,8 @@ static const TranslatorOps m68k_tr_ops = {
     .translate_insn     = m68k_tr_translate_insn,
     .tb_stop            = m68k_tr_tb_stop,
     .disas_log          = m68k_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
-- 
2.17.1
