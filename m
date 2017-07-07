Received: from eggs.gnu.org ([2001:4830:134:3::10]:55133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTTAD-0005JZ-JR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTTA8-0005gI-Lb
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:19:17 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri,  7 Jul 2017 15:18:55 +0200
Message-Id: <149943353527.8972.10583420262960708622.stgit@frigg.lan>
In-Reply-To: <149942760788.8972.474351671751194003.stgit@frigg.lan>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 24/27] target/arm: [tcg,
 a64] Port to tb_stop
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
 target/arm/translate-a64.c |  123 +++++++++++++++++++++++---------------=
------
 1 file changed, 65 insertions(+), 58 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c4cb9afb02..cead9d382c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11316,6 +11316,69 @@ static target_ulong aarch64_tr_translate_insn(Di=
sasContextBase *dcbase,
     return dc->pc;
 }
=20
+static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+
+    if (unlikely(dc->base.singlestep_enabled || dc->ss_active)
+        && dc->base.is_jmp !=3D DISAS_EXC) {
+        /* Note that this means single stepping WFI doesn't halt the CPU.
+         * For conditional branch insns this is harmless unreachable cod=
e as
+         * gen_goto_tb() has already handled emitting the debug exceptio=
n
+         * (and thus a tb-jump is not possible when singlestepping).
+         */
+        assert(dc->base.is_jmp !=3D DISAS_TB_JUMP);
+        if (dc->base.is_jmp !=3D DISAS_JUMP) {
+            gen_a64_set_pc_im(dc->pc);
+        }
+        if (dc->base.singlestep_enabled) {
+            gen_exception_internal(EXCP_DEBUG);
+        } else {
+            gen_step_complete_exception(dc);
+        }
+    } else {
+        switch (dc->base.is_jmp) {
+        case DISAS_NEXT:
+        case DISAS_TOO_MANY:
+            gen_goto_tb(dc, 1, dc->pc);
+            break;
+        default:
+        case DISAS_UPDATE:
+            gen_a64_set_pc_im(dc->pc);
+            /* fall through */
+        case DISAS_JUMP:
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            break;
+        case DISAS_EXIT:
+            tcg_gen_exit_tb(0);
+            break;
+        case DISAS_TB_JUMP:
+        case DISAS_EXC:
+        case DISAS_SWI:
+            break;
+        case DISAS_WFE:
+            gen_a64_set_pc_im(dc->pc);
+            gen_helper_wfe(cpu_env);
+            break;
+        case DISAS_YIELD:
+            gen_a64_set_pc_im(dc->pc);
+            gen_helper_yield(cpu_env);
+            break;
+        case DISAS_WFI:
+            /* This is a special case because we don't want to just halt=
 the CPU
+             * if trying to debug across a WFI.
+             */
+            gen_a64_set_pc_im(dc->pc);
+            gen_helper_wfi(cpu_env);
+            /* The helper doesn't necessarily throw an exception, but we
+             * must go back to the main loop to check for interrupts any=
way.
+             */
+            tcg_gen_exit_tb(0);
+            break;
+        }
+    }
+}
+
 void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
                                TranslationBlock *tb)
 {
@@ -11398,68 +11461,12 @@ void gen_intermediate_code_a64(DisasContextBase=
 *dcbase, CPUState *cs,
          */
     } while (!dc->base.is_jmp);
=20
+    aarch64_tr_tb_stop(&dc->base, cs);
+
     if (dc->base.tb->cflags & CF_LAST_IO) {
         gen_io_end();
     }
=20
-    if (unlikely(cs->singlestep_enabled || dc->ss_active)
-        && dc->base.is_jmp !=3D DISAS_EXC) {
-        /* Note that this means single stepping WFI doesn't halt the CPU.
-         * For conditional branch insns this is harmless unreachable cod=
e as
-         * gen_goto_tb() has already handled emitting the debug exceptio=
n
-         * (and thus a tb-jump is not possible when singlestepping).
-         */
-        assert(dc->base.is_jmp !=3D DISAS_TB_JUMP);
-        if (dc->base.is_jmp !=3D DISAS_JUMP) {
-            gen_a64_set_pc_im(dc->pc);
-        }
-        if (cs->singlestep_enabled) {
-            gen_exception_internal(EXCP_DEBUG);
-        } else {
-            gen_step_complete_exception(dc);
-        }
-    } else {
-        switch (dc->base.is_jmp) {
-        case DISAS_NEXT:
-        case DISAS_TOO_MANY:
-            gen_goto_tb(dc, 1, dc->pc);
-            break;
-        default:
-        case DISAS_UPDATE:
-            gen_a64_set_pc_im(dc->pc);
-            /* fall through */
-        case DISAS_JUMP:
-            tcg_gen_lookup_and_goto_ptr(cpu_pc);
-            break;
-        case DISAS_EXIT:
-            tcg_gen_exit_tb(0);
-            break;
-        case DISAS_TB_JUMP:
-        case DISAS_EXC:
-        case DISAS_SWI:
-            break;
-        case DISAS_WFE:
-            gen_a64_set_pc_im(dc->pc);
-            gen_helper_wfe(cpu_env);
-            break;
-        case DISAS_YIELD:
-            gen_a64_set_pc_im(dc->pc);
-            gen_helper_yield(cpu_env);
-            break;
-        case DISAS_WFI:
-            /* This is a special case because we don't want to just halt=
 the CPU
-             * if trying to debug across a WFI.
-             */
-            gen_a64_set_pc_im(dc->pc);
-            gen_helper_wfi(cpu_env);
-            /* The helper doesn't necessarily throw an exception, but we
-             * must go back to the main loop to check for interrupts any=
way.
-             */
-            tcg_gen_exit_tb(0);
-            break;
-        }
-    }
-
 done_generating:
     gen_tb_end(tb, dc->base.num_insns);
=20
