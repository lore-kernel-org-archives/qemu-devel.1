Received: from eggs.gnu.org ([2001:4830:134:3::10]:40553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO6EB-0003Em-NC
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO6E7-0001zL-Q0
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:49:11 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:53772 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO6E7-0001zB-DZ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:49:07 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 22 Jun 2017 20:48:58 +0300
Message-Id: <149815373864.1830.11327265472101278016.stgit@frigg.lan>
In-Reply-To: <149815338558.1830.8107719559183631163.stgit@frigg.lan>
References: <149815338558.1830.8107719559183631163.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 11/26] target: [tcg,
 i386] Refactor disas_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/i386/translate.c |   72 +++++++++++++++++++++++++++++++----------=
------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 04d65b8416..34e7cf6788 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4436,16 +4436,17 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
=20
 /* convert one instruction. s->base.is_jmp is set if the translation mus=
t
    be stopped. Return the next pc value */
-static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
-                               target_ulong pc_start)
+static target_ulong disas_insn(DisasContextBase *db, CPUState *cpu)
 {
-    DisasContextBase *db =3D &s->base;
+    DisasContext *s =3D container_of(db, DisasContext, base);
+    CPUX86State *env =3D cpu->env_ptr;
     int b, prefixes;
     int shift;
     TCGMemOp ot, aflag, dflag;
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
     int rex_w, rex_r;
+    target_ulong pc_start =3D db->pc_next;
=20
     s->pc_start =3D s->pc =3D pc_start;
     prefixes =3D 0;
@@ -8494,10 +8495,50 @@ static BreakpointCheckType i386_trblock_breakpoin=
t_check(
     }
 }
=20
+static target_ulong i386_trblock_disas_insn(DisasContextBase *db, CPUSta=
te *cpu)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+    target_ulong pc_next =3D disas_insn(db, cpu);
+
+    if (db->is_jmp) {
+        return pc_next;
+    }
+
+    if (dc->tf || (db->tb->flags & HF_INHIBIT_IRQ_MASK)) {
+        /* if single step mode, we generate only one instruction and
+           generate an exception */
+        /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
+           the flag and abort the translation to give the irqs a
+           change to be happen */
+        gen_jmp_im(pc_next - dc->cs_base);
+        gen_eob(dc);
+        db->is_jmp =3D DJ_TOO_MANY;
+    } else if ((db->tb->cflags & CF_USE_ICOUNT)
+               && ((db->pc_next & TARGET_PAGE_MASK)
+                   !=3D ((db->pc_next + TARGET_MAX_INSN_SIZE - 1)
+                       & TARGET_PAGE_MASK)
+                   || (db->pc_next & ~TARGET_PAGE_MASK) =3D=3D 0)) {
+        /* Do not cross the boundary of the pages in icount mode,
+           it can cause an exception. Do it only when boundary is
+           crossed by the first instruction in the block.
+           If current instruction already crossed the bound - it's ok,
+           because an exception hasn't stopped this code.
+         */
+        gen_jmp_im(pc_next - dc->cs_base);
+        gen_eob(dc);
+        db->is_jmp =3D DJ_TOO_MANY;
+    } else if ((pc_next - db->pc_first) >=3D (TARGET_PAGE_SIZE - 32)) {
+        gen_jmp_im(pc_next - dc->cs_base);
+        gen_eob(dc);
+        db->is_jmp =3D DJ_TOO_MANY;
+    }
+
+    return pc_next;
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    CPUX86State *env =3D cpu->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
     DisasContextBase *db =3D &dc1.base;
     CPUBreakpoint *bp;
@@ -8547,39 +8588,20 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
             gen_io_start(cpu_env);
         }
=20
-        db->pc_next =3D disas_insn(env, dc, db->pc_next);
+        db->pc_next =3D i386_trblock_disas_insn(db, cpu);
         /* stop translation if indicated */
         if (db->is_jmp) {
             break;
         }
         /* if single step mode, we generate only one instruction and
            generate an exception */
-        /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
-           the flag and abort the translation to give the irqs a
-           change to be happen */
-        if (dc->tf || db->singlestep_enabled ||
-            (db->tb->flags & HF_INHIBIT_IRQ_MASK)) {
-            gen_jmp_im(db->pc_next - dc->cs_base);
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
-            && ((db->pc_next & TARGET_PAGE_MASK)
-                !=3D ((db->pc_next + TARGET_MAX_INSN_SIZE - 1) & TARGET_=
PAGE_MASK)
-                || (db->pc_next & ~TARGET_PAGE_MASK) =3D=3D 0)) {
+        if (db->singlestep_enabled) {
             gen_jmp_im(db->pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
         /* if too long translation, stop generation too */
         if (tcg_op_buf_full() ||
-            (db->pc_next - db->pc_first) >=3D (TARGET_PAGE_SIZE - 32) ||
             num_insns >=3D max_insns) {
             gen_jmp_im(db->pc_next - dc->cs_base);
             gen_eob(dc);
