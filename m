Received: from eggs.gnu.org ([2001:4830:134:3::10]:60600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMgY-00046g-D1
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMgT-0008Nu-Dr
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:03:10 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:35682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHMgT-0008Nl-99
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:03:05 -0400
Received: by mail-pl0-x241.google.com with SMTP id i5-v6so4373864plt.2
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 22:03:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 22:02:50 -0700
Message-Id: <20180512050250.12774-10-richard.henderson@linaro.org>
In-Reply-To: <20180512050250.12774-1-richard.henderson@linaro.org>
References: <20180512050250.12774-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 9/9] target/m68k: Merge disas_m68k_insn into
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
Cc: laurent@vivier.eu

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 069558bc28..21eeebf4df 100644
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
2.17.0
