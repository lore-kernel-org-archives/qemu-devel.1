Received: from eggs.gnu.org ([2001:4830:134:3::10]:38901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVxN4-0005iy-Oi
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVxN3-0000BH-5t
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:58:50 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 12:58:33 +0300
Message-Id: <150002631325.22386.10348327185029496649.stgit@frigg.lan>
In-Reply-To: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 26/26] target/arm: [tcg] Port to generic
 translation framework
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

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/arm/translate-a64.c |  106 +++++++-------------------------------=
-----
 target/arm/translate.c     |  108 ++++++++------------------------------=
------
 target/arm/translate.h     |    8 ---
 3 files changed, 38 insertions(+), 184 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5de7fbde29..963e0c3433 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11250,6 +11250,11 @@ static void aarch64_tr_init_disas_context(DisasC=
ontextBase *dcbase,
     init_tmp_a64_array(dc);
 }
=20
+static void aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu,
+                                int *max_insns)
+{
+}
+
 static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cp=
u)
 {
     DisasContext *dc =3D container_of(dcbase, DisasContext, base);
@@ -11378,6 +11383,9 @@ static void aarch64_tr_tb_stop(DisasContextBase *=
dcbase, CPUState *cpu)
             break;
         }
     }
+
+    /* Functions above can change dc->pc, so re-align db->pc_next */
+    dc->base.pc_next =3D dc->pc;
 }
=20
 static void aarch64_tr_disas_log(const DisasContextBase *dcbase,
@@ -11390,92 +11398,12 @@ static void aarch64_tr_disas_log(const DisasCon=
textBase *dcbase,
                      4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
 }
=20
-void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
-                               TranslationBlock *tb)
-{
-    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
-    int max_insns;
-
-    dc->base.tb =3D tb;
-    dc->base.pc_first =3D dc->base.tb->pc;
-    dc->base.pc_next =3D dc->base.pc_first;
-    dc->base.is_jmp =3D DISAS_NEXT;
-    dc->base.num_insns =3D 0;
-    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
-    aarch64_tr_init_disas_context(&dc->base, cs);
-
-    max_insns =3D dc->base.tb->cflags & CF_COUNT_MASK;
-    if (max_insns =3D=3D 0) {
-        max_insns =3D CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns =3D TCG_MAX_INSNS;
-    }
-
-    gen_tb_start(tb);
-
-    tcg_clear_temp_count();
-
-    do {
-        dc->base.num_insns++;
-        aarch64_tr_insn_start(&dc->base, cs);
-
-        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->base.pc_next) {
-                    if (aarch64_tr_breakpoint_check(&dc->base, cs, bp)) =
{
-                        break;
-                    }
-                }
-            }
-
-            if (dc->base.is_jmp =3D=3D DISAS_NORETURN) {
-                break;
-            }
-        }
-
-        if (dc->base.num_insns =3D=3D max_insns && (dc->base.tb->cflags =
& CF_LAST_IO)) {
-            gen_io_start();
-        }
-
-        dc->base.pc_next =3D aarch64_tr_translate_insn(&dc->base, cs);
-
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
-                    dc->pc);
-        }
-
-        if (!dc->base.is_jmp && (tcg_op_buf_full() || cs->singlestep_ena=
bled ||
-                            singlestep || dc->base.num_insns >=3D max_in=
sns)) {
-            dc->base.is_jmp =3D DISAS_TOO_MANY;
-        }
-
-        /* Translation stops when a conditional branch is encountered.
-         * Otherwise the subsequent code could get translated several ti=
mes.
-         * Also stop translation when a page boundary is reached.  This
-         * ensures prefetch aborts occur at the right place.
-         */
-    } while (!dc->base.is_jmp);
-
-    aarch64_tr_tb_stop(&dc->base, cs);
-
-    if (dc->base.tb->cflags & CF_LAST_IO) {
-        gen_io_end();
-    }
-
-    gen_tb_end(tb, dc->base.num_insns);
-
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(dc->base.pc_first)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        aarch64_tr_disas_log(&dc->base, cs);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
-    dc->base.tb->size =3D dc->pc - dc->base.pc_first;
-    dc->base.tb->icount =3D dc->base.num_insns;
-}
+const TranslatorOps aarch64_translator_ops =3D {
+    .init_disas_context =3D aarch64_tr_init_disas_context,
+    .tb_start           =3D aarch64_tr_tb_start,
+    .insn_start         =3D aarch64_tr_insn_start,
+    .breakpoint_check   =3D aarch64_tr_breakpoint_check,
+    .translate_insn     =3D aarch64_tr_translate_insn,
+    .tb_stop            =3D aarch64_tr_tb_stop,
+    .disas_log          =3D aarch64_tr_disas_log,
+};
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 507f51d001..ea27a7f70b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12133,6 +12133,9 @@ static void arm_tr_tb_stop(DisasContextBase *dcba=
se, CPUState *cpu)
             gen_goto_tb(dc, 1, dc->pc);
         }
     }
+
+    /* Functions above can change dc->pc, so re-align db->pc_next */
+    dc->base.pc_next =3D dc->pc;
 }
=20
 static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *c=
pu)
@@ -12144,100 +12147,29 @@ static void arm_tr_disas_log(const DisasContex=
tBase *dcbase, CPUState *cpu)
                      dc->thumb | (dc->sctlr_b << 1));
 }
=20
+static const TranslatorOps arm_translator_ops =3D {
+    .init_disas_context =3D arm_tr_init_disas_context,
+    .tb_start           =3D arm_tr_tb_start,
+    .insn_start         =3D arm_tr_insn_start,
+    .breakpoint_check   =3D arm_tr_breakpoint_check,
+    .translate_insn     =3D arm_tr_translate_insn,
+    .tb_stop            =3D arm_tr_tb_stop,
+    .disas_log          =3D arm_tr_disas_log,
+};
+
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    DisasContext dc1, *dc =3D &dc1;
-    int max_insns;
+    DisasContext dc;
+    const TranslatorOps *ops =3D &arm_translator_ops;
=20
-    /* generate intermediate code */
-
-    /* The A64 decoder has its own top level loop, because it doesn't ne=
ed
-     * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
-     */
+#ifdef TARGET_AARCH64
     if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(&dc->base, cs, tb);
-        return;
-    }
-
-    dc->base.tb =3D tb;
-    dc->base.pc_first =3D dc->base.tb->pc;
-    dc->base.pc_next =3D dc->base.pc_first;
-    dc->base.is_jmp =3D DISAS_NEXT;
-    dc->base.num_insns =3D 0;
-    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
-    arm_tr_init_disas_context(&dc->base, cs);
-
-
-    max_insns =3D tb->cflags & CF_COUNT_MASK;
-    if (max_insns =3D=3D 0) {
-        max_insns =3D CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns =3D TCG_MAX_INSNS;
-    }
-
-    gen_tb_start(tb);
-
-    tcg_clear_temp_count();
-    arm_tr_tb_start(&dc->base, cs, &max_insns);
-
-    do {
-        dc->base.num_insns++;
-        arm_tr_insn_start(&dc->base, cs);
-
-        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->base.pc_next) {
-                    if (arm_tr_breakpoint_check(&dc->base, cs, bp)) {
-                        break;
-                    }
-                }
-            }
-
-            if (dc->base.is_jmp =3D=3D DISAS_NORETURN) {
-                break;
-            }
-        }
-
-        if (dc->base.num_insns =3D=3D max_insns && (tb->cflags & CF_LAST=
_IO)) {
-            gen_io_start();
-        }
-
-        dc->base.pc_next =3D arm_tr_translate_insn(&dc->base, cs);
-
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
-                    dc->pc);
-        }
-
-        if (!dc->base.is_jmp && (tcg_op_buf_full() || singlestep ||
-                            dc->base.num_insns >=3D max_insns)) {
-            dc->base.is_jmp =3D DISAS_TOO_MANY;
-        }
-    } while (!dc->base.is_jmp);
-
-    arm_tr_tb_stop(&dc->base, cs);
-
-    if (dc->base.tb->cflags & CF_LAST_IO) {
-        gen_io_end();
-    }
-
-    gen_tb_end(tb, dc->base.num_insns);
-
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(dc->base.pc_first)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        arm_tr_disas_log(&dc->base, cs);
-        qemu_log("\n");
-        qemu_log_unlock();
+        ops =3D &aarch64_translator_ops;
     }
 #endif
-    tb->size =3D dc->pc - dc->base.pc_first;
-    tb->icount =3D dc->base.num_insns;
+
+    translator_loop(ops, &dc.base, cpu, tb);
 }
=20
 static const char *cpu_mode_names[16] =3D {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 720cb102e3..0337cec52b 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -152,21 +152,15 @@ static void disas_set_insn_syndrome(DisasContext *s=
, uint32_t syn)
=20
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
-void gen_intermediate_code_a64(DisasContextBase *db, CPUState *cpu,
-                               TranslationBlock *tb);
 void gen_a64_set_pc_im(uint64_t val);
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
+extern const TranslatorOps aarch64_translator_ops;
 #else
 static inline void a64_translate_init(void)
 {
 }
=20
-static inline void gen_intermediate_code_a64(DisasContextBase *db, CPUSt=
ate *cpu,
-                                             TranslationBlock *tb)
-{
-}
-
 static inline void gen_a64_set_pc_im(uint64_t val)
 {
 }
