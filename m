Received: from eggs.gnu.org ([2001:4830:134:3::10]:35695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTSCS-0006Od-Bt
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTSCN-0004cN-Co
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:17:32 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:38188 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTSCN-0004c7-09
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:17:27 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri,  7 Jul 2017 14:17:11 +0200
Message-Id: <149942983074.8972.4124917122042440113.stgit@frigg.lan>
In-Reply-To: <149942760788.8972.474351671751194003.stgit@frigg.lan>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 09/27] target/i386: [tcg] Port to
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
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c |   72 +++++++++++++++++++++++++++++++----------=
------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index d39e65e5b0..18447b88b2 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4419,15 +4419,17 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
=20
 /* convert one instruction. s->base.is_jmp is set if the translation mus=
t
    be stopped. Return the next pc value */
-static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
-                               target_ulong pc_start)
+static target_ulong disas_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
+    DisasContext *s =3D container_of(dcbase, DisasContext, base);
+    CPUX86State *env =3D cpu->env_ptr;
     int b, prefixes;
     int shift;
     TCGMemOp ot, aflag, dflag;
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
     int rex_w, rex_r;
+    target_ulong pc_start =3D s->base.pc_next;
=20
     s->pc_start =3D s->pc =3D pc_start;
     prefixes =3D 0;
@@ -8474,10 +8476,51 @@ static BreakpointCheckType i386_tr_breakpoint_che=
ck(
     }
 }
=20
+static target_ulong i386_tr_translate_insn(DisasContextBase *dcbase,
+                                           CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+    target_ulong pc_next =3D disas_insn(&dc->base, cpu);
+
+    if (dc->base.is_jmp) {
+        return pc_next;
+    }
+
+    if (dc->tf || (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
+        /* if single step mode, we generate only one instruction and
+           generate an exception */
+        /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
+           the flag and abort the translation to give the irqs a
+           chance to happen */
+        gen_jmp_im(pc_next - dc->cs_base);
+        gen_eob(dc);
+        dc->base.is_jmp =3D DISAS_TOO_MANY;
+    } else if ((dc->base.tb->cflags & CF_USE_ICOUNT)
+               && ((dc->base.pc_next & TARGET_PAGE_MASK)
+                   !=3D ((dc->base.pc_next + TARGET_MAX_INSN_SIZE - 1)
+                       & TARGET_PAGE_MASK)
+                   || (dc->base.pc_next & ~TARGET_PAGE_MASK) =3D=3D 0)) =
{
+        /* Do not cross the boundary of the pages in icount mode,
+           it can cause an exception. Do it only when boundary is
+           crossed by the first instruction in the block.
+           If current instruction already crossed the bound - it's ok,
+           because an exception hasn't stopped this code.
+         */
+        gen_jmp_im(pc_next - dc->cs_base);
+        gen_eob(dc);
+        dc->base.is_jmp =3D DISAS_TOO_MANY;
+    } else if ((pc_next - dc->base.pc_first) >=3D (TARGET_PAGE_SIZE - 32=
)) {
+        gen_jmp_im(pc_next - dc->cs_base);
+        gen_eob(dc);
+        dc->base.is_jmp =3D DISAS_TOO_MANY;
+    }
+
+    return pc_next;
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    CPUX86State *env =3D cs->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
     int num_insns;
     int max_insns;
@@ -8537,39 +8580,20 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
             gen_io_start();
         }
=20
-        dc->base.pc_next =3D disas_insn(env, dc, dc->base.pc_next);
+        dc->base.pc_next =3D i386_tr_translate_insn(&dc->base, cs);
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
-                !=3D ((dc->base.pc_next + TARGET_MAX_INSN_SIZE - 1) & TA=
RGET_PAGE_MASK)
-                || (dc->base.pc_next & ~TARGET_PAGE_MASK) =3D=3D 0)) {
+        if (dc->base.singlestep_enabled) {
             gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
         /* if too long translation, stop generation too */
         if (tcg_op_buf_full() ||
-            (dc->base.pc_next - dc->base.pc_first) >=3D (TARGET_PAGE_SIZ=
E - 32) ||
             num_insns >=3D max_insns) {
             gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
