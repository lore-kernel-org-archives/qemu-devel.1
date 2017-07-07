Received: from eggs.gnu.org ([2001:4830:134:3::10]:54661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRhV-0006sz-Ax
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRhT-0005ce-2n
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:45:33 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri,  7 Jul 2017 13:44:15 +0200
Message-Id: <149942785473.8972.785747351232335205.stgit@frigg.lan>
In-Reply-To: <149942760788.8972.474351671751194003.stgit@frigg.lan>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 01/27] Pass generic CPUState to
 gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

Needed to implement a target-agnostic gen_intermediate_code() in the
future.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 accel/tcg/translate-all.c     |    2 +-
 include/exec/exec-all.h       |    2 +-
 target/alpha/translate.c      |    5 ++---
 target/arm/translate-a64.c    |    6 +++---
 target/arm/translate.c        |    6 +++---
 target/arm/translate.h        |    4 ++--
 target/cris/translate.c       |    7 +++----
 target/hppa/translate.c       |    5 ++---
 target/i386/translate.c       |    5 ++---
 target/lm32/translate.c       |    4 ++--
 target/m68k/translate.c       |    5 ++---
 target/microblaze/translate.c |    4 ++--
 target/mips/translate.c       |    5 ++---
 target/moxie/translate.c      |    4 ++--
 target/nios2/translate.c      |    5 ++---
 target/openrisc/translate.c   |    4 ++--
 target/ppc/translate.c        |    5 ++---
 target/s390x/translate.c      |    5 ++---
 target/sh4/translate.c        |    5 ++---
 target/sparc/translate.c      |    5 ++---
 target/tilegx/translate.c     |    5 ++---
 target/tricore/translate.c    |    5 ++---
 target/unicore32/translate.c  |    5 ++---
 target/xtensa/translate.c     |    5 ++---
 24 files changed, 49 insertions(+), 64 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f6ad46b613..2dc93f420a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1299,7 +1299,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_func_start(&tcg_ctx);
=20
     tcg_ctx.cpu =3D ENV_GET_CPU(env);
-    gen_intermediate_code(env, tb);
+    gen_intermediate_code(cpu, tb);
     tcg_ctx.cpu =3D NULL;
=20
     trace_translate_block(tb, tb->pc, tb->tc_ptr);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 724ec73dce..0826894ec5 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -43,7 +43,7 @@ typedef ram_addr_t tb_page_addr_t;
=20
 #include "qemu/log.h"
=20
-void gen_intermediate_code(CPUArchState *env, struct TranslationBlock *t=
b);
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb);
 void restore_state_to_opc(CPUArchState *env, struct TranslationBlock *tb=
,
                           target_ulong *data);
=20
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 232af9e177..7b39101053 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2911,10 +2911,9 @@ static ExitStatus translate_one(DisasContext *ctx,=
 uint32_t insn)
     return ret;
 }
=20
-void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *=
tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    AlphaCPU *cpu =3D alpha_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUAlphaState *env =3D cs->env_ptr;
     DisasContext ctx, *ctxp =3D &ctx;
     target_ulong pc_start;
     target_ulong pc_mask;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e55547d95d..f9bd1a9679 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11190,10 +11190,10 @@ static void disas_a64_insn(CPUARMState *env, Di=
sasContext *s)
     free_tmp_a64(s);
 }
=20
-void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
+void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
 {
-    CPUState *cs =3D CPU(cpu);
-    CPUARMState *env =3D &cpu->env;
+    CPUARMState *env =3D cs->env_ptr;
+    ARMCPU *cpu =3D arm_env_get_cpu(env);
     DisasContext dc1, *dc =3D &dc1;
     target_ulong pc_start;
     target_ulong next_page_start;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0862f9e4aa..e80cc357c1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11787,10 +11787,10 @@ static bool insn_crosses_page(CPUARMState *env,=
 DisasContext *s)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
+    CPUARMState *env =3D cs->env_ptr;
     ARMCPU *cpu =3D arm_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
     DisasContext dc1, *dc =3D &dc1;
     target_ulong pc_start;
     target_ulong next_page_start;
@@ -11804,7 +11804,7 @@ void gen_intermediate_code(CPUARMState *env, Tran=
slationBlock *tb)
      * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
      */
     if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(cpu, tb);
+        gen_intermediate_code_a64(cs, tb);
         return;
     }
=20
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 15d383d9af..e5da614db5 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -146,7 +146,7 @@ static void disas_set_insn_syndrome(DisasContext *s, =
uint32_t syn)
=20
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
-void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb);
+void gen_intermediate_code_a64(CPUState *cpu, TranslationBlock *tb);
 void gen_a64_set_pc_im(uint64_t val);
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
@@ -155,7 +155,7 @@ static inline void a64_translate_init(void)
 {
 }
=20
-static inline void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlo=
ck *tb)
+static inline void gen_intermediate_code_a64(CPUState *cpu, TranslationB=
lock *tb)
 {
 }
=20
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0ee05ca02d..12b96eb68f 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3080,10 +3080,9 @@ static unsigned int crisv32_decoder(CPUCRISState *=
env, DisasContext *dc)
  */
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *t=
b)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    CRISCPU *cpu =3D cris_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUCRISState *env =3D cs->env_ptr;
     uint32_t pc_start;
     unsigned int insn_len;
     struct DisasContext ctx;
@@ -3105,7 +3104,7 @@ void gen_intermediate_code(CPUCRISState *env, struc=
t TranslationBlock *tb)
      * delayslot, like in real hw.
      */
     pc_start =3D tb->pc & ~1;
-    dc->cpu =3D cpu;
+    dc->cpu =3D cris_env_get_cpu(env);
     dc->tb =3D tb;
=20
     dc->is_jmp =3D DISAS_NEXT;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e10abc5e04..900870cd5a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3740,10 +3740,9 @@ static ExitStatus translate_one(DisasContext *ctx,=
 uint32_t insn)
     return gen_illegal(ctx);
 }
=20
-void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *t=
b)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    HPPACPU *cpu =3D hppa_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUHPPAState *env =3D cs->env_ptr;
     DisasContext ctx;
     ExitStatus ret;
     int num_insns, max_insns, i;
diff --git a/target/i386/translate.c b/target/i386/translate.c
index ed3b896db4..cab9e32f91 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8378,10 +8378,9 @@ void tcg_x86_init(void)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    X86CPU *cpu =3D x86_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUX86State *env =3D cs->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
     target_ulong pc_ptr;
     uint32_t flags;
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 692882f447..f68f372f15 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1044,10 +1044,10 @@ static inline void decode(DisasContext *dc, uint3=
2_t ir)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPULM32State *env, struct TranslationBlock *t=
b)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
+    CPULM32State *env =3D cs->env_ptr;
     LM32CPU *cpu =3D lm32_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
     struct DisasContext ctx, *dc =3D &ctx;
     uint32_t pc_start;
     uint32_t next_page_start;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 7aa0fdc238..af19872e0b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5369,10 +5369,9 @@ static void disas_m68k_insn(CPUM68KState * env, Di=
sasContext *s)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    M68kCPU *cpu =3D m68k_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUM68KState *env =3D cs->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
     target_ulong pc_start;
     int pc_offset;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
index 0bb609513c..a180bc78ae 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1594,10 +1594,10 @@ static inline void decode(DisasContext *dc, uint3=
2_t ir)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUMBState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
+    CPUMBState *env =3D cs->env_ptr;
     MicroBlazeCPU *cpu =3D mb_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
     uint32_t pc_start;
     struct DisasContext ctx;
     struct DisasContext *dc =3D &ctx;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 559f8fed89..97314e470a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -19878,10 +19878,9 @@ static void decode_opc(CPUMIPSState *env, DisasC=
ontext *ctx)
     }
 }
=20
-void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *t=
b)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    MIPSCPU *cpu =3D mips_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUMIPSState *env =3D cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
     target_ulong next_page_start;
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 0660b44c08..3cfd232558 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -822,10 +822,10 @@ static int decode_opc(MoxieCPU *cpu, DisasContext *=
ctx)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUMoxieState *env, struct TranslationBlock *=
tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
+    CPUMoxieState *env =3D cs->env_ptr;
     MoxieCPU *cpu =3D moxie_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
     DisasContext ctx;
     target_ulong pc_start;
     int num_insns, max_insns;
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 2f3c2e5dfb..8b97d6585f 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -799,10 +799,9 @@ static void gen_exception(DisasContext *dc, uint32_t=
 excp)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    Nios2CPU *cpu =3D nios2_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUNios2State *env =3D cs->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
     int num_insns;
     int max_insns;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index e49518e893..a01413113b 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1518,10 +1518,10 @@ static void disas_openrisc_insn(DisasContext *dc,=
 OpenRISCCPU *cpu)
     }
 }
=20
-void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBloc=
k *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
+    CPUOpenRISCState *env =3D cs->env_ptr;
     OpenRISCCPU *cpu =3D openrisc_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
     struct DisasContext ctx, *dc =3D &ctx;
     uint32_t pc_start;
     uint32_t next_page_start;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c0cd64d927..acb6e881ad 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7203,10 +7203,9 @@ void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
 }
=20
 /***********************************************************************=
******/
-void gen_intermediate_code(CPUPPCState *env, struct TranslationBlock *tb=
)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUPPCState *env =3D cs->env_ptr;
     DisasContext ctx, *ctxp =3D &ctx;
     opc_handler_t **table, *handler;
     target_ulong pc_start;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 592d6b0f38..cd8c38d6d5 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5764,10 +5764,9 @@ static ExitStatus translate_one(CPUS390XState *env=
, DisasContext *s)
     return ret;
 }
=20
-void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *=
tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    S390CPU *cpu =3D s390_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUS390XState *env =3D cs->env_ptr;
     DisasContext dc;
     target_ulong pc_start;
     uint64_t next_page_start;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8bc132b27b..1a5ca39cd6 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1815,10 +1815,9 @@ static void decode_opc(DisasContext * ctx)
     }
 }
=20
-void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *t=
b)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    SuperHCPU *cpu =3D sh_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUSH4State *env =3D cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
     int num_insns;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index aa6734d54e..293b9c65ea 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5747,10 +5747,9 @@ static void disas_sparc_insn(DisasContext * dc, un=
signed int insn)
     }
 }
=20
-void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
 {
-    SPARCCPU *cpu =3D sparc_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUSPARCState *env =3D cs->env_ptr;
     target_ulong pc_start, last_pc;
     DisasContext dc1, *dc =3D &dc1;
     int num_insns;
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index ff2ef7b63d..ace2830a84 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2370,12 +2370,11 @@ static void translate_one_bundle(DisasContext *dc=
, uint64_t bundle)
     }
 }
=20
-void gen_intermediate_code(CPUTLGState *env, struct TranslationBlock *tb=
)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    TileGXCPU *cpu =3D tilegx_env_get_cpu(env);
+    CPUTLGState *env =3D cs->env_ptr;
     DisasContext ctx;
     DisasContext *dc =3D &ctx;
-    CPUState *cs =3D CPU(cpu);
     uint64_t pc_start =3D tb->pc;
     uint64_t next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_=
PAGE_SIZE;
     int num_insns =3D 0;
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ddd2dd07dd..4e4198e887 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8782,10 +8782,9 @@ static void decode_opc(CPUTriCoreState *env, Disas=
Context *ctx, int *is_branch)
     }
 }
=20
-void gen_intermediate_code(CPUTriCoreState *env, struct TranslationBlock=
 *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    TriCoreCPU *cpu =3D tricore_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUTriCoreState *env =3D cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
     int num_insns, max_insns;
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 666a2016a8..8f30cff932 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1869,10 +1869,9 @@ static void disas_uc32_insn(CPUUniCore32State *env=
, DisasContext *s)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUUniCore32State *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    UniCore32CPU *cpu =3D uc32_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUUniCore32State *env =3D cs->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
     target_ulong pc_start;
     uint32_t next_page_start;
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 263002486c..f3f0ff589c 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -3117,10 +3117,9 @@ static void gen_ibreak_check(CPUXtensaState *env, =
DisasContext *dc)
     }
 }
=20
-void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    XtensaCPU *cpu =3D xtensa_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUXtensaState *env =3D cs->env_ptr;
     DisasContext dc;
     int insn_count =3D 0;
     int max_insns =3D tb->cflags & CF_COUNT_MASK;
