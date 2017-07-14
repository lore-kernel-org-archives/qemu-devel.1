Received: from eggs.gnu.org ([2001:4830:134:3::10]:59024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwrn-0003sK-5M
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwrh-0008Rm-EQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:26:31 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 12:26:14 +0300
Message-Id: <150002437386.22386.7745855254236101855.stgit@frigg.lan>
In-Reply-To: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 18/26] target/arm: [tcg] Port to
 breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c |   53 +++++++++++++++++++++++++++++++-----------=
------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b9183fc511..55bef09739 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11917,6 +11917,33 @@ static void arm_tr_insn_start(DisasContextBase *=
dcbase, CPUState *cpu)
 #endif
 }
=20
+static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *=
cpu,
+                                    const CPUBreakpoint *bp)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+
+    if (bp->flags & BP_CPU) {
+        gen_set_condexec(dc);
+        gen_set_pc_im(dc, dc->pc);
+        gen_helper_check_breakpoints(cpu_env);
+        /* End the TB early; it's likely not going to be executed */
+        dc->base.is_jmp =3D DISAS_UPDATE;
+    } else {
+        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        /* The address covered by the breakpoint must be
+           included in [tb->pc, tb->pc + tb->size) in order
+           to for it to be properly cleared -- thus we
+           increment the PC here so that the logic setting
+           tb->size below does the right thing.  */
+        /* TODO: Advance PC by correct instruction length to
+         * avoid disassembler error messages */
+        dc->pc +=3D 2;
+        dc->base.is_jmp =3D DISAS_NORETURN;
+    }
+
+    return true;
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -11965,28 +11992,16 @@ void gen_intermediate_code(CPUState *cs, Transl=
ationBlock *tb)
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
             QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->pc) {
-                    if (bp->flags & BP_CPU) {
-                        gen_set_condexec(dc);
-                        gen_set_pc_im(dc, dc->pc);
-                        gen_helper_check_breakpoints(cpu_env);
-                        /* End the TB early; it's likely not going to be=
 executed */
-                        dc->base.is_jmp =3D DISAS_UPDATE;
-                    } else {
-                        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
-                        /* The address covered by the breakpoint must be
-                           included in [tb->pc, tb->pc + tb->size) in or=
der
-                           to for it to be properly cleared -- thus we
-                           increment the PC here so that the logic setti=
ng
-                           tb->size below does the right thing.  */
-                        /* TODO: Advance PC by correct instruction lengt=
h to
-                         * avoid disassembler error messages */
-                        dc->pc +=3D 2;
-                        goto done_generating;
+                if (bp->pc =3D=3D dc->base.pc_next) {
+                    if (arm_tr_breakpoint_check(&dc->base, cs, bp)) {
+                        break;
                     }
-                    break;
                 }
             }
+
+            if (dc->base.is_jmp =3D=3D DISAS_NORETURN) {
+                break;
+            }
         }
=20
         if (dc->base.num_insns =3D=3D max_insns && (tb->cflags & CF_LAST=
_IO)) {
