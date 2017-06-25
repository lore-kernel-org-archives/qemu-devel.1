Received: from eggs.gnu.org ([2001:4830:134:3::10]:37895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4b2-0006NC-QP
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4ax-0006R4-K9
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:16:48 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 13:16:34 +0300
Message-Id: <149838579383.6497.17576888439862233362.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 23/26] target: [tcg, arm] Port to disas_insn
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
 target/arm/translate-a64.c |   73 ++++++++++++++--------
 target/arm/translate.c     |  144 +++++++++++++++++++++++++-------------=
------
 target/arm/translate.h     |    4 +
 3 files changed, 131 insertions(+), 90 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4321767355..f618a15062 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11256,6 +11256,8 @@ static void aarch64_trblock_init_disas_context(Di=
sasContextBase *db,
     dc->is_ldex =3D false;
     dc->ss_same_el =3D (arm_debug_target_el(env) =3D=3D dc->current_el);
=20
+    dc->next_page_start =3D (db->pc_first & TARGET_PAGE_MASK) + TARGET_P=
AGE_SIZE;
+
     init_tmp_a64_array(dc);
 }
=20
@@ -11290,13 +11292,46 @@ static BreakpointCheckType aarch64_trblock_brea=
kpoint_check(
     }
 }
=20
+static target_ulong aarch64_trblock_disas_insn(DisasContextBase *db,
+                                               CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
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
+        assert(db->num_insns =3D=3D 1);
+        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
+                      default_exception_el(dc));
+        db->is_jmp =3D DJ_EXC;
+    } else {
+        disas_a64_insn(env, dc);
+    }
+
+    if (dc->ss_active) {
+        db->is_jmp =3D DJ_SS;
+    } else if (dc->pc >=3D dc->next_page_start) {
+        db->is_jmp =3D DJ_PAGE_CROSS;
+    }
+
+    return dc->pc;
+}
+
 void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
                                TranslationBlock *tb)
 {
     CPUState *cs =3D CPU(cpu);
-    CPUARMState *env =3D &cpu->env;
     DisasContext *dc =3D container_of(db, DisasContext, base);
-    target_ulong next_page_start;
     int max_insns;
     CPUBreakpoint *bp;
=20
@@ -11308,7 +11343,6 @@ void gen_intermediate_code_a64(DisasContextBase *=
db, ARMCPU *cpu,
     db->singlestep_enabled =3D cs->singlestep_enabled;
     aarch64_trblock_init_disas_context(db, cs);
=20
-    next_page_start =3D (db->pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_=
SIZE;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
         max_insns =3D CF_COUNT_MASK;
@@ -11348,42 +11382,24 @@ void gen_intermediate_code_a64(DisasContextBase=
 *db, ARMCPU *cpu,
             gen_io_start(cpu_env);
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
-            assert(db->num_insns =3D=3D 1);
-            gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
-                          default_exception_el(dc));
-            db->is_jmp =3D DJ_EXC;
-            break;
-        }
-
-        disas_a64_insn(env, dc);
+        db->pc_next =3D aarch64_trblock_disas_insn(db, cs);
=20
         if (tcg_check_temp_count()) {
             fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
                     dc->pc);
         }
=20
+        if (!db->is_jmp && (tcg_op_buf_full() || cs->singlestep_enabled =
||
+                            singlestep || db->num_insns >=3D max_insns))=
 {
+            db->is_jmp =3D DJ_TOO_MANY;
+        }
+
         /* Translation stops when a conditional branch is encountered.
          * Otherwise the subsequent code could get translated several ti=
mes.
          * Also stop translation when a page boundary is reached.  This
          * ensures prefetch aborts occur at the right place.
          */
-    } while (!db->is_jmp && !tcg_op_buf_full() &&
-             !cs->singlestep_enabled &&
-             !singlestep &&
-             !dc->ss_active &&
-             dc->pc < next_page_start &&
-             db->num_insns < max_insns);
+    } while (!db->is_jmp);
=20
     if (tb->cflags & CF_LAST_IO) {
         gen_io_end(cpu_env);
@@ -11410,6 +11426,7 @@ void gen_intermediate_code_a64(DisasContextBase *=
db, ARMCPU *cpu,
         unsigned int is_jmp =3D (unsigned int)db->is_jmp;
         switch (is_jmp) {
         case DJ_NEXT:
+        case DJ_TOO_MANY:
             gen_goto_tb(dc, 1, dc->pc);
             break;
         default:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a7fcaf2a21..f4c57ed078 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11877,6 +11877,8 @@ static void arm_trblock_init_disas_context(DisasC=
ontextBase *db, CPUState *cpu)
     dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(db->tb->flags);
     dc->is_ldex =3D false;
     dc->ss_same_el =3D false; /* Can't be true since EL_d must be AArch6=
4 */
+
+    dc->next_page_start =3D (db->pc_first & TARGET_PAGE_MASK) + TARGET_P=
AGE_SIZE;
 }
=20
 static void arm_trblock_init_globals(DisasContextBase *db, CPUState *cpu=
)
@@ -11981,6 +11983,76 @@ static BreakpointCheckType arm_trblock_breakpoin=
t_check(DisasContextBase *db,
     }
 }
=20
+static target_ulong arm_trblock_disas_insn(DisasContextBase *db, CPUStat=
e *cpu)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+    CPUARMState *env =3D cpu->env_ptr;
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
+        assert(db->num_insns =3D=3D 1);
+        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
+                      default_exception_el(dc));
+        db->is_jmp =3D DJ_SKIP;
+        return dc->pc;
+    }
+
+    if (dc->thumb) {
+        disas_thumb_insn(env, dc);
+        if (dc->condexec_mask) {
+            dc->condexec_cond =3D (dc->condexec_cond & 0xe)
+                | ((dc->condexec_mask >> 4) & 1);
+            dc->condexec_mask =3D (dc->condexec_mask << 1) & 0x1f;
+            if (dc->condexec_mask =3D=3D 0) {
+                dc->condexec_cond =3D 0;
+            }
+        }
+    } else {
+        unsigned int insn =3D arm_ldl_code(env, dc->pc, dc->sctlr_b);
+        dc->pc +=3D 4;
+        disas_arm_insn(dc, insn);
+    }
+
+    if (dc->condjmp && !db->is_jmp) {
+        gen_set_label(dc->condlabel);
+        dc->condjmp =3D 0;
+    }
+
+
+    /* Translation stops when a conditional branch is encountered.
+     * Otherwise the subsequent code could get translated several times.
+     * Also stop translation when a page boundary is reached.  This
+     * ensures prefetch aborts occur at the right place.  */
+
+    if (is_singlestepping(dc)) {
+        db->is_jmp =3D DJ_SS;
+    } else if ((dc->pc >=3D dc->next_page_start) ||
+               ((dc->pc >=3D dc->next_page_start - 3) &&
+                insn_crosses_page(env, dc))) {
+        /* We want to stop the TB if the next insn starts in a new page,
+         * or if it spans between this page and the next. This means tha=
t
+         * if we're looking at the last halfword in the page we need to
+         * see if it's a 16-bit Thumb insn (which will fit in this TB)
+         * or a 32-bit Thumb insn (which won't).
+         * This is to avoid generating a silly TB with a single 16-bit i=
nsn
+         * in it at the end of this page (which would execute correctly
+         * but isn't very efficient).
+         */
+        return DJ_PAGE_CROSS;
+    }
+
+    return dc->pc;
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
@@ -11988,9 +12060,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
     ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
     DisasContext dc1, *dc =3D &dc1;
     DisasContextBase *db =3D &dc->base;
-    target_ulong next_page_start;
     int max_insns;
-    bool end_of_page;
     CPUBreakpoint *bp;
=20
     /* generate intermediate code */
@@ -12013,7 +12083,6 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
=20
=20
     arm_trblock_init_globals(db, cpu);
-    next_page_start =3D (db->pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_=
SIZE;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
         max_insns =3D CF_COUNT_MASK;
@@ -12054,72 +12123,20 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
             gen_io_start(cpu_env);
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
-            assert(db->num_insns =3D=3D 1);
-            gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
-                          default_exception_el(dc));
-            goto done_generating;
-        }
-
-        if (dc->thumb) {
-            disas_thumb_insn(env, dc);
-            if (dc->condexec_mask) {
-                dc->condexec_cond =3D (dc->condexec_cond & 0xe)
-                                   | ((dc->condexec_mask >> 4) & 1);
-                dc->condexec_mask =3D (dc->condexec_mask << 1) & 0x1f;
-                if (dc->condexec_mask =3D=3D 0) {
-                    dc->condexec_cond =3D 0;
-                }
-            }
-        } else {
-            unsigned int insn =3D arm_ldl_code(env, dc->pc, dc->sctlr_b)=
;
-            dc->pc +=3D 4;
-            disas_arm_insn(dc, insn);
-        }
-
-        if (dc->condjmp && !db->is_jmp) {
-            gen_set_label(dc->condlabel);
-            dc->condjmp =3D 0;
-        }
+        db->pc_next =3D arm_trblock_disas_insn(db, cpu);
=20
         if (tcg_check_temp_count()) {
             fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
                     dc->pc);
         }
=20
-        /* Translation stops when a conditional branch is encountered.
-         * Otherwise the subsequent code could get translated several ti=
mes.
-         * Also stop translation when a page boundary is reached.  This
-         * ensures prefetch aborts occur at the right place.  */
-
-        /* We want to stop the TB if the next insn starts in a new page,
-         * or if it spans between this page and the next. This means tha=
t
-         * if we're looking at the last halfword in the page we need to
-         * see if it's a 16-bit Thumb insn (which will fit in this TB)
-         * or a 32-bit Thumb insn (which won't).
-         * This is to avoid generating a silly TB with a single 16-bit i=
nsn
-         * in it at the end of this page (which would execute correctly
-         * but isn't very efficient).
-         */
-        end_of_page =3D (dc->pc >=3D next_page_start) ||
-            ((dc->pc >=3D next_page_start - 3) && insn_crosses_page(env,=
 dc));
-
-    } while (!db->is_jmp && !tcg_op_buf_full() &&
-             !is_singlestepping(dc) &&
-             !singlestep &&
-             !end_of_page &&
-             db->num_insns < max_insns);
+        if (!db->is_jmp && (tcg_op_buf_full() || singlestep ||
+                            db->num_insns >=3D max_insns)) {
+            db->is_jmp =3D DJ_TOO_MANY;
+        }
+    } while (!db->is_jmp);
=20
+    if (db->is_jmp !=3D DJ_SKIP) {
     if (tb->cflags & CF_LAST_IO) {
         if (dc->condjmp) {
             /* FIXME:  This can theoretically happen with self-modifying
@@ -12159,6 +12176,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
             gen_exception(EXCP_SMC, syn_aa32_smc(), 3);
             break;
         case DJ_NEXT:
+        case DJ_TOO_MANY:
         case DJ_UPDATE:
             gen_set_pc_im(dc, dc->pc);
             /* fall through */
@@ -12179,6 +12197,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
          */
         switch (is_jmp) {
         case DJ_NEXT:
+        case DJ_TOO_MANY:
             gen_goto_tb(dc, 1, dc->pc);
             break;
         case DJ_UPDATE:
@@ -12232,6 +12251,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
             gen_goto_tb(dc, 1, dc->pc);
         }
     }
+    }
=20
 done_generating:
     gen_tb_end(tb, db->num_insns);
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 190d461134..43e8b555e3 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -6,6 +6,7 @@ typedef struct DisasContext {
     DisasContextBase base;
=20
     target_ulong pc;
+    target_ulong next_page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
@@ -145,6 +146,9 @@ static void disas_set_insn_syndrome(DisasContext *s, =
uint32_t syn)
  * as opposed to attempting to use lookup_and_goto_ptr.
  */
 #define DJ_EXIT (DJ_TARGET + 11)
+#define DJ_SS   (DJ_TARGET + 12)
+#define DJ_PAGE_CROSS (DJ_TARGET + 13)
+#define DJ_SKIP (DJ_TARGET + 14)
=20
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
