Received: from eggs.gnu.org ([2001:4830:134:3::10]:34453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQDHq-0007Cc-Og
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQDHm-0002K2-RZ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:45:42 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 16:45:27 +0300
Message-Id: <149865752773.17063.5160701222440538985.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 22/29] target/arm: [tcg,
 a64] Port to breakpoint_check
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
---
 target/arm/translate-a64.c |   58 +++++++++++++++++++++++++++++++++-----=
------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5784620642..9c870f6d07 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11255,6 +11255,29 @@ static void aarch64_trblock_insn_start(DisasCont=
extBase *dcbase, CPUState *cpu)
     tcg_gen_insn_start(dc->pc, 0, 0);
 }
=20
+static BreakpointCheckType aarch64_trblock_breakpoint_check(
+    DisasContextBase *dcbase, CPUState *cpu, const CPUBreakpoint *bp)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+
+    if (bp->flags & BP_CPU) {
+        gen_a64_set_pc_im(dc->pc);
+        gen_helper_check_breakpoints(cpu_env);
+        /* End the TB early; it likely won't be executed */
+        dc->base.is_jmp =3D DISAS_UPDATE;
+        return BC_HIT_INSN;
+    } else {
+        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        /* The address covered by the breakpoint must be
+           included in [tb->pc, tb->pc + tb->size) in order
+           to for it to be properly cleared -- thus we
+           increment the PC here so that the logic setting
+           tb->size below does the right thing.  */
+        dc->pc +=3D 4;
+        return BC_HIT_TB;
+    }
+}
+
 void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
                                TranslationBlock *tb)
 {
@@ -11291,26 +11314,31 @@ void gen_intermediate_code_a64(DisasContextBase=
 *dcbase, CPUState *cs,
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
             QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->pc) {
-                    if (bp->flags & BP_CPU) {
-                        gen_a64_set_pc_im(dc->pc);
-                        gen_helper_check_breakpoints(cpu_env);
-                        /* End the TB early; it likely won't be executed=
 */
-                        dc->base.is_jmp =3D DISAS_UPDATE;
-                    } else {
-                        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
-                        /* The address covered by the breakpoint must be
-                           included in [dc->base.tb->pc, dc->base.tb->pc=
 + dc->base.tb->size) in order
-                           to for it to be properly cleared -- thus we
-                           increment the PC here so that the logic setti=
ng
-                           dc->base.tb->size below does the right thing.=
  */
-                        dc->pc +=3D 4;
+                if (bp->pc =3D=3D dc->base.pc_next) {
+                    BreakpointCheckType bp_check =3D
+                        aarch64_trblock_breakpoint_check(&dc->base, cs, =
bp);
+                    switch (bp_check) {
+                    case BC_MISS:
+                        /* Target ignored this breakpoint, go to next */
+                        break;
+                    case BC_HIT_INSN:
+                        /* Hit, keep translating */
+                        /*
+                         * TODO: if we're never going to have more than =
one
+                         *       BP in a single address, we can simply u=
se a
+                         *       bool here.
+                         */
+                        goto done_breakpoints;
+                    case BC_HIT_TB:
+                        /* Hit, end TB */
                         goto done_generating;
+                    default:
+                        g_assert_not_reached();
                     }
-                    break;
                 }
             }
         }
+    done_breakpoints:
=20
         if (dc->base.num_insns =3D=3D max_insns && (dc->base.tb->cflags =
& CF_LAST_IO)) {
             gen_io_start();
