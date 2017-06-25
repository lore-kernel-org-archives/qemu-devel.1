Received: from eggs.gnu.org ([2001:4830:134:3::10]:36856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4TG-0003Ui-EF
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4TB-0003gB-Dl
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:08:46 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 13:08:30 +0300
Message-Id: <149838531005.6497.12362377034456580175.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 21/26] target: [tcg, arm] Port to insn_start
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
 target/arm/translate-a64.c |   11 +++++++++--
 target/arm/translate.c     |   36 +++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1959f27377..bfc2cdabb5 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11259,6 +11259,14 @@ static void aarch64_trblock_init_disas_context(D=
isasContextBase *db,
     init_tmp_a64_array(dc);
 }
=20
+static void aarch64_trblock_insn_start(DisasContextBase *db, CPUState *c=
pu)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+
+    dc->insn_start_idx =3D tcg_op_buf_count();
+    tcg_gen_insn_start(dc->pc, 0, 0);
+}
+
 void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
                                TranslationBlock *tb)
 {
@@ -11291,8 +11299,7 @@ void gen_intermediate_code_a64(DisasContextBase *=
db, ARMCPU *cpu,
=20
     do {
         db->num_insns++;
-        dc->insn_start_idx =3D tcg_op_buf_count();
-        tcg_gen_insn_start(dc->pc, 0, 0);
+        aarch64_trblock_insn_start(db, cs);
=20
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ae3f772446..18b0e8fbb6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11934,6 +11934,26 @@ static void arm_trblock_tb_start(DisasContextBas=
e *db, CPUState *cpu)
     }
 }
=20
+static void arm_trblock_insn_start(DisasContextBase *db, CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+
+    dc->insn_start_idx =3D tcg_op_buf_count();
+    tcg_gen_insn_start(dc->pc,
+                       (dc->condexec_cond << 4) | (dc->condexec_mask >> =
1),
+                       0);
+
+#ifdef CONFIG_USER_ONLY
+    /* Intercept jump to the magic kernel page.  */
+    if (dc->pc >=3D 0xffff0000) {
+        /* We always get here via a jump, so know we are not in a
+           conditional execution block.  */
+        gen_exception_internal(EXCP_KERNEL_TRAP);
+        dc->is_jmp =3D DJ_EXC;
+    }
+#endif
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
@@ -11981,21 +12001,7 @@ void gen_intermediate_code(CPUState *cpu, Transl=
ationBlock *tb)
=20
     do {
         db->num_insns++;
-        dc->insn_start_idx =3D tcg_op_buf_count();
-        tcg_gen_insn_start(dc->pc,
-                           (dc->condexec_cond << 4) | (dc->condexec_mask=
 >> 1),
-                           0);
-
-#ifdef CONFIG_USER_ONLY
-        /* Intercept jump to the magic kernel page.  */
-        if (dc->pc >=3D 0xffff0000) {
-            /* We always get here via a jump, so know we are not in a
-               conditional execution block.  */
-            gen_exception_internal(EXCP_KERNEL_TRAP);
-            dc->is_jmp =3D DJ_EXC;
-            break;
-        }
-#endif
+        arm_trblock_insn_start(db, cpu);
=20
         if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
             CPUBreakpoint *bp;
