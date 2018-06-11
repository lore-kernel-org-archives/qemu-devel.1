Received: from eggs.gnu.org ([2001:4830:134:3::10]:56392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOn-0002cj-TD
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOj-0000pI-NB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:09 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSKOj-0000oT-9Z
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:05 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Jun 2018 12:49:35 +0200
Message-Id: <20180611104935.20499-10-laurent@vivier.eu>
In-Reply-To: <20180611104935.20499-1-laurent@vivier.eu>
References: <20180611104935.20499-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 9/9] target/m68k: Merge disas_m68k_insn into
 m68k_tr_translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180512050250.12774-10-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ff3493d8ab..ae3651b867 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6049,16 +6049,6 @@ void register_m68k_insns (CPUM68KState *env)
 #undef INSN
 }
 
-/* ??? Some of this implementation is not exception safe.  We should always
-   write back the result to memory before setting the condition codes.  */
-static void disas_m68k_insn(CPUM68KState * env, DisasContext *s)
-{
-    uint16_t insn = read_im16(env, s);
-    opcode_table[insn](env, s, insn);
-    do_writebacks(s);
-    do_release(s);
-}
-
 static void m68k_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
@@ -6101,8 +6091,13 @@ static bool m68k_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
 static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
+    CPUM68KState *env = cpu->env_ptr;
+    uint16_t insn = read_im16(env, dc);
+
+    opcode_table[insn](env, dc, insn);
+    do_writebacks(dc);
+    do_release(dc);
 
-    disas_m68k_insn(cpu->env_ptr, dc);
     dc->base.pc_next = dc->pc;
 
     if (dc->base.is_jmp == DISAS_NEXT) {
-- 
2.14.4
