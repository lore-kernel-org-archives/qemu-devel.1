Received: from eggs.gnu.org ([2001:4830:134:3::10]:39444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4ml-0002qH-Ht
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4mi-00042O-BW
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:28:55 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 13:28:39 +0300
Message-Id: <149838651980.6497.760840816251179741.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 26/26] target: [tcg,
 arm] Port to generic translation framework
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

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/arm/translate-a64.c |  110 ++++++--------------------------------=
-----
 target/arm/translate.c     |  112 +++++++-------------------------------=
------
 target/arm/translate.h     |    6 +-
 3 files changed, 36 insertions(+), 192 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 97e8bda230..59c5d58dd1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11387,6 +11387,9 @@ static void aarch64_trblock_tb_stop(DisasContextB=
ase *db, CPUState *cpu)
             break;
         }
     }
+
+    /* Functions above can change dc->pc, so re-align db->pc_next */
+    db->pc_next =3D dc->pc;
 }
=20
 static int aarch64_trblock_disas_flags(const DisasContextBase *db)
@@ -11396,102 +11399,17 @@ static int aarch64_trblock_disas_flags(const D=
isasContextBase *db)
     return 4 | (bswap_code(dc->sctlr_b) ? 2 : 0);
 }
=20
-void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
+static TranslatorOps aarch64_translator_ops =3D {
+    .init_disas_context =3D aarch64_trblock_init_disas_context,
+    .insn_start =3D aarch64_trblock_insn_start,
+    .breakpoint_check =3D aarch64_trblock_breakpoint_check,
+    .disas_insn =3D aarch64_trblock_disas_insn,
+    .tb_stop =3D aarch64_trblock_tb_stop,
+    .disas_flags =3D aarch64_trblock_disas_flags,
+};
+
+void gen_intermediate_code_a64(DisasContextBase *db, CPUState *cpu,
                                TranslationBlock *tb)
 {
-    CPUState *cs =3D CPU(cpu);
-    DisasContext *dc =3D container_of(db, DisasContext, base);
-    int max_insns;
-    CPUBreakpoint *bp;
-
-    db->tb =3D tb;
-    db->pc_first =3D tb->pc;
-    db->pc_next =3D db->pc_first;
-    db->is_jmp =3D DISAS_NEXT;
-    db->num_insns =3D 0;
-    db->singlestep_enabled =3D cs->singlestep_enabled;
-    aarch64_trblock_init_disas_context(db, cs);
-
-    max_insns =3D tb->cflags & CF_COUNT_MASK;
-    if (max_insns =3D=3D 0) {
-        max_insns =3D CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns =3D TCG_MAX_INSNS;
-    }
-
-    gen_tb_start(tb, cpu_env);
-
-    tcg_clear_temp_count();
-
-    do {
-        db->num_insns++;
-        aarch64_trblock_insn_start(db, cs);
-
-        bp =3D NULL;
-        do {
-            bp =3D cpu_breakpoint_get(cs, db->pc_next, bp);
-            if (unlikely(bp)) {
-                BreakpointCheckType bp_check =3D
-                    aarch64_trblock_breakpoint_check(db, cs, bp);
-                if (bp_check =3D=3D BC_HIT_INSN) {
-                    /* Hit, keep translating */
-                    /*
-                     * TODO: if we're never going to have more than one =
BP in a
-                     *       single address, we can simply use a bool he=
re.
-                     */
-                    break;
-                } else {
-                    goto done_generating;
-                }
-            }
-        } while (bp !=3D NULL);
-
-        if (db->num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO))=
 {
-            gen_io_start(cpu_env);
-        }
-
-        db->pc_next =3D aarch64_trblock_disas_insn(db, cs);
-
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
-                    dc->pc);
-        }
-
-        if (!db->is_jmp && (tcg_op_buf_full() || cs->singlestep_enabled =
||
-                            singlestep || db->num_insns >=3D max_insns))=
 {
-            db->is_jmp =3D DJ_TOO_MANY;
-        }
-
-        /* Translation stops when a conditional branch is encountered.
-         * Otherwise the subsequent code could get translated several ti=
mes.
-         * Also stop translation when a page boundary is reached.  This
-         * ensures prefetch aborts occur at the right place.
-         */
-    } while (!db->is_jmp);
-
-    aarch64_trblock_tb_stop(db, cs);
-
-    if (tb->cflags & CF_LAST_IO) {
-        gen_io_end(cpu_env);
-    }
-
-done_generating:
-    gen_tb_end(tb, db->num_insns);
-
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(db->pc_first)) {
-        int disas_flags =3D aarch64_trblock_disas_flags(db);
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(db->pc_first));
-        log_target_disas(cs, db->pc_first, dc->pc - db->pc_first,
-                         disas_flags);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
-    tb->size =3D dc->pc - db->pc_first;
-    tb->icount =3D db->num_insns;
+    translate_block(&aarch64_translator_ops, db, cpu, &cpu_env, tb);
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d87328602a..d9a7d870cb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12177,6 +12177,9 @@ static void arm_trblock_tb_stop(DisasContextBase =
*db, CPUState *cpu)
             gen_goto_tb(dc, 1, dc->pc);
         }
     }
+
+    /* Functions above can change dc->pc, so re-align db->pc_next */
+    db->pc_next =3D dc->pc;
 }
=20
 static int arm_trblock_disas_flags(const DisasContextBase *db)
@@ -12186,15 +12189,24 @@ static int arm_trblock_disas_flags(const DisasC=
ontextBase *db)
     return dc->thumb | (dc->sctlr_b << 1);
 }
=20
+static TranslatorOps arm_translator_ops =3D {
+    .init_disas_context =3D arm_trblock_init_disas_context,
+    .init_globals =3D arm_trblock_init_globals,
+    .tb_start =3D arm_trblock_tb_start,
+    .insn_start =3D arm_trblock_insn_start,
+    .breakpoint_check =3D arm_trblock_breakpoint_check,
+    .disas_insn =3D arm_trblock_disas_insn,
+    .tb_stop =3D arm_trblock_tb_stop,
+    .disas_flags =3D arm_trblock_disas_flags,
+};
+
+#include "qemu/error-report.h"
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    CPUARMState *env =3D cpu->env_ptr;
-    ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
     DisasContext dc1, *dc =3D &dc1;
     DisasContextBase *db =3D &dc->base;
-    int max_insns;
-    CPUBreakpoint *bp;
=20
     /* generate intermediate code */
=20
@@ -12202,97 +12214,11 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
      * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
      */
     if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(db, arm_cpu, tb);
+        gen_intermediate_code_a64(db, cpu, tb);
         return;
+    } else {
+        translate_block(&arm_translator_ops, db, cpu, &cpu_env, tb);
     }
-
-    db->tb =3D tb;
-    db->pc_first =3D tb->pc;
-    db->pc_next =3D db->pc_first;
-    db->is_jmp =3D DISAS_NEXT;
-    db->num_insns =3D 0;
-    db->singlestep_enabled =3D cpu->singlestep_enabled;
-    arm_trblock_init_disas_context(db, cpu);
-
-
-    arm_trblock_init_globals(db, cpu);
-    max_insns =3D tb->cflags & CF_COUNT_MASK;
-    if (max_insns =3D=3D 0) {
-        max_insns =3D CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns =3D TCG_MAX_INSNS;
-    }
-
-    gen_tb_start(tb, cpu_env);
-
-    tcg_clear_temp_count();
-    arm_trblock_tb_start(db, cpu);
-
-    do {
-        db->num_insns++;
-        arm_trblock_insn_start(db, cpu);
-
-        bp =3D NULL;
-        do {
-            bp =3D cpu_breakpoint_get(cpu, db->pc_next, bp);
-            if (unlikely(bp)) {
-                BreakpointCheckType bp_check =3D arm_trblock_breakpoint_=
check(
-                    db, cpu, bp);
-                if (bp_check =3D=3D BC_HIT_INSN) {
-                    /* Hit, keep translating */
-                    /*
-                     * TODO: if we're never going to have more than one =
BP in a
-                     *       single address, we can simply use a bool he=
re.
-                     */
-                    break;
-                } else {
-                    goto done_generating;
-                }
-            }
-        } while (bp !=3D NULL);
-
-        if (db->num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO))=
 {
-            gen_io_start(cpu_env);
-        }
-
-        db->pc_next =3D arm_trblock_disas_insn(db, cpu);
-
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
-                    dc->pc);
-        }
-
-        if (!db->is_jmp && (tcg_op_buf_full() || singlestep ||
-                            db->num_insns >=3D max_insns)) {
-            db->is_jmp =3D DJ_TOO_MANY;
-        }
-    } while (!db->is_jmp);
-
-    arm_trblock_tb_stop(db, cpu);
-
-    if (tb->cflags & CF_LAST_IO) {
-        gen_io_end(cpu_env);
-    }
-
-done_generating:
-    gen_tb_end(tb, db->num_insns);
-
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(db->pc_first)) {
-        int disas_flags =3D arm_trblock_disas_flags(db);
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(db->pc_first));
-        log_target_disas(cpu, db->pc_first, dc->pc - db->pc_first,
-                         disas_flags);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
-    tb->size =3D dc->pc - db->pc_first;
-    tb->icount =3D db->num_insns;
 }
=20
 static const char *cpu_mode_names[16] =3D {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 43e8b555e3..0e60d4d771 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -152,7 +152,7 @@ static void disas_set_insn_syndrome(DisasContext *s, =
uint32_t syn)
=20
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
-void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
+void gen_intermediate_code_a64(DisasContextBase *db, CPUState *cpu,
                                TranslationBlock *tb);
 void gen_a64_set_pc_im(uint64_t val);
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
@@ -162,8 +162,8 @@ static inline void a64_translate_init(void)
 {
 }
=20
-static inline void gen_intermediate_code_a64(DisasContextBase *db, ARMCP=
U *cpu,
-                                             TranslationBlock *tb)
+static inline void gen_intermediate_code_a64(
+    DisasContextBase *db, CPUState *cpu, TranslationBlock *tb)
 {
 }
=20
