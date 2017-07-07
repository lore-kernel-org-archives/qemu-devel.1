Received: from eggs.gnu.org ([2001:4830:134:3::10]:44142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTSaK-00072v-Dt
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTSaH-0007HI-9K
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:42:12 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri,  7 Jul 2017 14:41:53 +0200
Message-Id: <149943131289.8972.14899352517803578316.stgit@frigg.lan>
In-Reply-To: <149942760788.8972.474351671751194003.stgit@frigg.lan>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 15/27] target/arm: [tcg,
 a64] Port to init_disas_context
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
 target/arm/translate-a64.c |   36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4270ac3847..5c04ff3d8b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11190,21 +11190,12 @@ static void disas_a64_insn(CPUARMState *env, Di=
sasContext *s)
     free_tmp_a64(s);
 }
=20
-void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
-                               TranslationBlock *tb)
+static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
+                                               CPUState *cpu)
 {
-    CPUARMState *env =3D cs->env_ptr;
-    ARMCPU *cpu =3D arm_env_get_cpu(env);
     DisasContext *dc =3D container_of(dcbase, DisasContext, base);
-    target_ulong next_page_start;
-    int max_insns;
-
-    dc->base.tb =3D tb;
-    dc->base.pc_first =3D dc->base.tb->pc;
-    dc->base.pc_next =3D dc->base.pc_first;
-    dc->base.is_jmp =3D DISAS_NEXT;
-    dc->base.num_insns =3D 0;
-    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
+    CPUARMState *env =3D cpu->env_ptr;
+    ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
=20
     dc->pc =3D dc->base.pc_first;
     dc->condjmp =3D 0;
@@ -11230,7 +11221,7 @@ void gen_intermediate_code_a64(DisasContextBase *=
dcbase, CPUState *cs,
     dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
     dc->vec_len =3D 0;
     dc->vec_stride =3D 0;
-    dc->cp_regs =3D cpu->cp_regs;
+    dc->cp_regs =3D arm_cpu->cp_regs;
     dc->features =3D env->features;
=20
     /* Single step state. The code-generation logic here is:
@@ -11254,6 +11245,23 @@ void gen_intermediate_code_a64(DisasContextBase =
*dcbase, CPUState *cs,
     dc->ss_same_el =3D (arm_debug_target_el(env) =3D=3D dc->current_el);
=20
     init_tmp_a64_array(dc);
+}
+
+void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
+                               TranslationBlock *tb)
+{
+    CPUARMState *env =3D cs->env_ptr;
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+    target_ulong next_page_start;
+    int max_insns;
+
+    dc->base.tb =3D tb;
+    dc->base.pc_first =3D dc->base.tb->pc;
+    dc->base.pc_next =3D dc->base.pc_first;
+    dc->base.is_jmp =3D DISAS_NEXT;
+    dc->base.num_insns =3D 0;
+    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
+    aarch64_tr_init_disas_context(&dc->base, cs);
=20
     next_page_start =3D (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_=
PAGE_SIZE;
     max_insns =3D dc->base.tb->cflags & CF_COUNT_MASK;
