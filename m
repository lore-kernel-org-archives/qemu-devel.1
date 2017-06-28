Received: from eggs.gnu.org ([2001:4830:134:3::10]:36788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQDPe-0001B5-Tu
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQDPb-0006qn-OQ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:53:46 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 16:53:31 +0300
Message-Id: <149865801156.17063.15618379976159104550.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 24/29] target/arm: [tcg,
 a64] Port to translate_insn
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
 target/arm/translate-a64.c |   74 +++++++++++++++++++++++++++-----------=
------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9c870f6d07..586a01a2de 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11244,6 +11244,9 @@ static void aarch64_trblock_init_disas_context(Di=
sasContextBase *dcbase,
     dc->is_ldex =3D false;
     dc->ss_same_el =3D (arm_debug_target_el(env) =3D=3D dc->current_el);
=20
+    dc->next_page_start =3D
+        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+
     init_tmp_a64_array(dc);
 }
=20
@@ -11278,12 +11281,45 @@ static BreakpointCheckType aarch64_trblock_brea=
kpoint_check(
     }
 }
=20
+static target_ulong aarch64_trblock_translate_insn(DisasContextBase *dcb=
ase,
+                                                   CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+    CPUARMState *env =3D cpu->env_ptr;
+
+
+    if (dc->ss_active && !dc->pstate_ss) {
+        /* Singlestep state is Active-pending.
+         * If we're in this state at the start of a TB then either
+         *  a) we just took an exception to an EL which is being debugge=
d
+         *     and this is the first insn in the exception handler
+         *  b) debug exceptions were masked and we just unmasked them
+         *     without changing EL (eg by clearing PSTATE.D)
+         * In either case we're going to take a swstep exception in the
+         * "did not step an insn" case, and so the syndrome ISV and EX
+         * bits should be zero.
+         */
+        assert(dc->base.num_insns =3D=3D 1);
+        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
+                      default_exception_el(dc));
+        dc->base.is_jmp =3D DISAS_EXC;
+    } else {
+        disas_a64_insn(env, dc);
+    }
+
+    if (dc->ss_active) {
+        dc->base.is_jmp =3D DISAS_SS;
+    } else if (dc->pc >=3D dc->next_page_start) {
+        dc->base.is_jmp =3D DISAS_PAGE_CROSS;
+    }
+
+    return dc->pc;
+}
+
 void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
                                TranslationBlock *tb)
 {
-    CPUARMState *env =3D cs->env_ptr;
     DisasContext *dc =3D container_of(dcbase, DisasContext, base);
-    target_ulong next_page_start;
     int max_insns;
=20
     dc->base.tb =3D tb;
@@ -11294,7 +11330,6 @@ void gen_intermediate_code_a64(DisasContextBase *=
dcbase, CPUState *cs,
     dc->base.singlestep_enabled =3D cs->singlestep_enabled;
     aarch64_trblock_init_disas_context(&dc->base, cs);
=20
-    next_page_start =3D (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_=
PAGE_SIZE;
     max_insns =3D dc->base.tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
         max_insns =3D CF_COUNT_MASK;
@@ -11344,42 +11379,24 @@ void gen_intermediate_code_a64(DisasContextBase=
 *dcbase, CPUState *cs,
             gen_io_start();
         }
=20
-        if (dc->ss_active && !dc->pstate_ss) {
-            /* Singlestep state is Active-pending.
-             * If we're in this state at the start of a TB then either
-             *  a) we just took an exception to an EL which is being deb=
ugged
-             *     and this is the first insn in the exception handler
-             *  b) debug exceptions were masked and we just unmasked the=
m
-             *     without changing EL (eg by clearing PSTATE.D)
-             * In either case we're going to take a swstep exception in =
the
-             * "did not step an insn" case, and so the syndrome ISV and =
EX
-             * bits should be zero.
-             */
-            assert(dc->base.num_insns =3D=3D 1);
-            gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
-                          default_exception_el(dc));
-            dc->base.is_jmp =3D DISAS_EXC;
-            break;
-        }
-
-        disas_a64_insn(env, dc);
+        dc->base.pc_next =3D aarch64_trblock_translate_insn(&dc->base, c=
s);
=20
         if (tcg_check_temp_count()) {
             fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
                     dc->pc);
         }
=20
+        if (!dc->base.is_jmp && (tcg_op_buf_full() || cs->singlestep_ena=
bled ||
+                            singlestep || dc->base.num_insns >=3D max_in=
sns)) {
+            dc->base.is_jmp =3D DISAS_TOO_MANY;
+        }
+
         /* Translation stops when a conditional branch is encountered.
          * Otherwise the subsequent code could get translated several ti=
mes.
          * Also stop translation when a page boundary is reached.  This
          * ensures prefetch aborts occur at the right place.
          */
-    } while (!dc->base.is_jmp && !tcg_op_buf_full() &&
-             !cs->singlestep_enabled &&
-             !singlestep &&
-             !dc->ss_active &&
-             dc->pc < next_page_start &&
-             dc->base.num_insns < max_insns);
+    } while (!dc->base.is_jmp);
=20
     if (dc->base.tb->cflags & CF_LAST_IO) {
         gen_io_end();
@@ -11404,6 +11421,7 @@ void gen_intermediate_code_a64(DisasContextBase *=
dcbase, CPUState *cs,
     } else {
         switch (dc->base.is_jmp) {
         case DISAS_NEXT:
+        case DISAS_TOO_MANY:
             gen_goto_tb(dc, 1, dc->pc);
             break;
         default:
