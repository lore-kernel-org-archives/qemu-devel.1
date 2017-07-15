Received: from eggs.gnu.org ([2001:4830:134:3::10]:38167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbb-0003oF-Bg
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJba-0003Ji-Bi
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:19 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJba-0003JB-3D
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:18 -0400
Received: by mail-pg0-x241.google.com with SMTP id d193so13340199pgc.2
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:22 -1000
Message-Id: <20170715094243.28371-14-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 13/34] target/i386: [tcg] Port to
 translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Message-Id: <150002195074.22386.16195894320027075398.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 66 +++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a009710..d350699 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4416,15 +4416,16 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
 
 /* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
-static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
-                               target_ulong pc_start)
+static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 {
+    CPUX86State *env = cpu->env_ptr;
     int b, prefixes;
     int shift;
     TCGMemOp ot, aflag, dflag;
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
     int rex_w, rex_r;
+    target_ulong pc_start = s->base.pc_next;
 
     s->pc_start = s->pc = pc_start;
     prefixes = 0;
@@ -8475,10 +8476,46 @@ static bool i386_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     }
 }
 
+static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    target_ulong pc_next = disas_insn(dc, cpu);
+
+    if (dc->tf || (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
+        /* if single step mode, we generate only one instruction and
+           generate an exception */
+        /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
+           the flag and abort the translation to give the irqs a
+           chance to happen */
+        gen_jmp_im(pc_next - dc->cs_base);
+        gen_eob(dc);
+        dc->base.is_jmp = DISAS_TOO_MANY;
+    } else if ((dc->base.tb->cflags & CF_USE_ICOUNT)
+               && ((dc->base.pc_next & TARGET_PAGE_MASK)
+                   != ((dc->base.pc_next + TARGET_MAX_INSN_SIZE - 1)
+                       & TARGET_PAGE_MASK)
+                   || (dc->base.pc_next & ~TARGET_PAGE_MASK) == 0)) {
+        /* Do not cross the boundary of the pages in icount mode,
+           it can cause an exception. Do it only when boundary is
+           crossed by the first instruction in the block.
+           If current instruction already crossed the bound - it's ok,
+           because an exception hasn't stopped this code.
+         */
+        gen_jmp_im(pc_next - dc->cs_base);
+        gen_eob(dc);
+        dc->base.is_jmp = DISAS_TOO_MANY;
+    } else if ((pc_next - dc->base.pc_first) >= (TARGET_PAGE_SIZE - 32)) {
+        gen_jmp_im(pc_next - dc->cs_base);
+        gen_eob(dc);
+        dc->base.is_jmp = DISAS_TOO_MANY;
+    }
+
+    dc->base.pc_next = pc_next;
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    CPUX86State *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
     int num_insns;
     int max_insns;
@@ -8524,39 +8561,20 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             gen_io_start();
         }
 
-        dc->base.pc_next = disas_insn(env, dc, dc->base.pc_next);
+        i386_tr_translate_insn(&dc->base, cs);
         /* stop translation if indicated */
         if (dc->base.is_jmp) {
             break;
         }
         /* if single step mode, we generate only one instruction and
            generate an exception */
-        /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
-           the flag and abort the translation to give the irqs a
-           change to be happen */
-        if (dc->tf || dc->base.singlestep_enabled ||
-            (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
-            gen_jmp_im(dc->base.pc_next - dc->cs_base);
-            gen_eob(dc);
-            break;
-        }
-        /* Do not cross the boundary of the pages in icount mode,
-           it can cause an exception. Do it only when boundary is
-           crossed by the first instruction in the block.
-           If current instruction already crossed the bound - it's ok,
-           because an exception hasn't stopped this code.
-         */
-        if ((tb->cflags & CF_USE_ICOUNT)
-            && ((dc->base.pc_next & TARGET_PAGE_MASK)
-                != ((dc->base.pc_next + TARGET_MAX_INSN_SIZE - 1) & TARGET_PAGE_MASK)
-                || (dc->base.pc_next & ~TARGET_PAGE_MASK) == 0)) {
+        if (dc->base.singlestep_enabled) {
             gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
         /* if too long translation, stop generation too */
         if (tcg_op_buf_full() ||
-            (dc->base.pc_next - dc->base.pc_first) >= (TARGET_PAGE_SIZE - 32) ||
             num_insns >= max_insns) {
             gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
-- 
2.9.4
