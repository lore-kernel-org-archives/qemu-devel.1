Received: from eggs.gnu.org ([2001:4830:134:3::10]:37462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4X7-0004pp-Kn
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4X2-0004rM-KJ
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:12:45 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 13:12:32 +0300
Message-Id: <149838555190.6497.14794381660566656791.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 22/26] target: [tcg,
 arm] Port to breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/arm/translate-a64.c |   59 ++++++++++++++++++++++++++------------=
-
 target/arm/translate.c     |   66 +++++++++++++++++++++++++++++---------=
------
 2 files changed, 82 insertions(+), 43 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bfc2cdabb5..4321767355 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11267,6 +11267,29 @@ static void aarch64_trblock_insn_start(DisasCont=
extBase *db, CPUState *cpu)
     tcg_gen_insn_start(dc->pc, 0, 0);
 }
=20
+static BreakpointCheckType aarch64_trblock_breakpoint_check(
+    DisasContextBase *db, CPUState *cpu, const CPUBreakpoint *bp)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+
+    if (bp->flags & BP_CPU) {
+        gen_a64_set_pc_im(dc->pc);
+        gen_helper_check_breakpoints(cpu_env);
+        /* End the TB early; it likely won't be executed */
+        db->is_jmp =3D DJ_UPDATE;
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
 void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
                                TranslationBlock *tb)
 {
@@ -11275,6 +11298,7 @@ void gen_intermediate_code_a64(DisasContextBase *=
db, ARMCPU *cpu,
     DisasContext *dc =3D container_of(db, DisasContext, base);
     target_ulong next_page_start;
     int max_insns;
+    CPUBreakpoint *bp;
=20
     db->tb =3D tb;
     db->pc_first =3D tb->pc;
@@ -11301,29 +11325,24 @@ void gen_intermediate_code_a64(DisasContextBase=
 *db, ARMCPU *cpu,
         db->num_insns++;
         aarch64_trblock_insn_start(db, cs);
=20
-        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->pc) {
-                    if (bp->flags & BP_CPU) {
-                        gen_a64_set_pc_im(dc->pc);
-                        gen_helper_check_breakpoints(cpu_env);
-                        /* End the TB early; it likely won't be executed=
 */
-                        db->is_jmp =3D DJ_UPDATE;
-                    } else {
-                        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
-                        /* The address covered by the breakpoint must be
-                           included in [tb->pc, tb->pc + tb->size) in or=
der
-                           to for it to be properly cleared -- thus we
-                           increment the PC here so that the logic setti=
ng
-                           tb->size below does the right thing.  */
-                        dc->pc +=3D 4;
-                        goto done_generating;
-                    }
+        bp =3D NULL;
+        do {
+            bp =3D cpu_breakpoint_get(cs, db->pc_next, bp);
+            if (unlikely(bp)) {
+                BreakpointCheckType bp_check =3D
+                    aarch64_trblock_breakpoint_check(db, cs, bp);
+                if (bp_check =3D=3D BC_HIT_INSN) {
+                    /* Hit, keep translating */
+                    /*
+                     * TODO: if we're never going to have more than one =
BP in a
+                     *       single address, we can simply use a bool he=
re.
+                     */
                     break;
+                } else {
+                    goto done_generating;
                 }
             }
-        }
+        } while (bp !=3D NULL);
=20
         if (db->num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO))=
 {
             gen_io_start(cpu_env);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 18b0e8fbb6..a7fcaf2a21 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11954,6 +11954,33 @@ static void arm_trblock_insn_start(DisasContextB=
ase *db, CPUState *cpu)
 #endif
 }
=20
+static BreakpointCheckType arm_trblock_breakpoint_check(DisasContextBase=
 *db,
+                                                        CPUState *cpu,
+                                                        const CPUBreakpo=
int *bp)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+
+    if (bp->flags & BP_CPU) {
+        gen_set_condexec(dc);
+        gen_set_pc_im(dc, dc->pc);
+        gen_helper_check_breakpoints(cpu_env);
+        /* End the TB early; it's likely not going to be executed */
+        db->is_jmp =3D DJ_UPDATE;
+        return BC_HIT_INSN;
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
+        return BC_HIT_TB;
+    }
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
@@ -11964,6 +11991,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
     target_ulong next_page_start;
     int max_insns;
     bool end_of_page;
+    CPUBreakpoint *bp;
=20
     /* generate intermediate code */
=20
@@ -12003,32 +12031,24 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
         db->num_insns++;
         arm_trblock_insn_start(db, cpu);
=20
-        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->pc) {
-                    if (bp->flags & BP_CPU) {
-                        gen_set_condexec(dc);
-                        gen_set_pc_im(dc, dc->pc);
-                        gen_helper_check_breakpoints(cpu_env);
-                        /* End the TB early; it's likely not going to be=
 executed */
-                        db->is_jmp =3D DJ_UPDATE;
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
-                    }
+        bp =3D NULL;
+        do {
+            bp =3D cpu_breakpoint_get(cpu, db->pc_next, bp);
+            if (unlikely(bp)) {
+                BreakpointCheckType bp_check =3D arm_trblock_breakpoint_=
check(
+                    db, cpu, bp);
+                if (bp_check =3D=3D BC_HIT_INSN) {
+                    /* Hit, keep translating */
+                    /*
+                     * TODO: if we're never going to have more than one =
BP in a
+                     *       single address, we can simply use a bool he=
re.
+                     */
                     break;
+                } else {
+                    goto done_generating;
                 }
             }
-        }
+        } while (bp !=3D NULL);
=20
         if (db->num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO))=
 {
             gen_io_start(cpu_env);
