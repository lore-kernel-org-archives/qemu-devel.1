Received: from eggs.gnu.org ([2001:4830:134:3::10]:55508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ0-0007wb-H9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYz-0006mX-4B
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:30 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVYy-0006mR-Ur
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:29 -0500
Received: by mail-qk0-x243.google.com with SMTP id a20so939966qkc.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:28 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:48 -0800
Message-Id: <20170112025606.27332-13-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 12/30] target-sparc: implement UA2005 GL register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <5e6434c91c40b0acc4a8da12da2edc7a43b1dd7f.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/cpu.c          | 13 ++++++++++---
 target/sparc/cpu.h          |  2 ++
 target/sparc/helper.h       |  1 +
 target/sparc/int64_helper.c |  6 ++++++
 target/sparc/translate.c    |  3 +--
 target/sparc/win_helper.c   | 40 ++++++++++++++++++++++++++++++++++++++--
 6 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 4e07b92..8f228e8 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -58,9 +58,13 @@ static void sparc_cpu_reset(CPUState *s)
     env->psrps = 1;
 #endif
 #ifdef TARGET_SPARC64
-    env->pstate = PS_PRIV|PS_RED|PS_PEF|PS_AG;
+    env->pstate = PS_PRIV | PS_RED | PS_PEF;
+    if (!cpu_has_hypervisor(env)) {
+        env->pstate |= PS_AG;
+    }
     env->hpstate = cpu_has_hypervisor(env) ? HS_PRIV : 0;
     env->tl = env->maxtl;
+    env->gl = 2;
     cpu_tsptr(env)->tt = TT_POWER_ON_RESET;
     env->lsu = 0;
 #else
@@ -745,14 +749,17 @@ void sparc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     cpu_print_cc(f, cpu_fprintf, cpu_get_ccr(env) << PSR_CARRY_SHIFT);
     cpu_fprintf(f, " xcc: ");
     cpu_print_cc(f, cpu_fprintf, cpu_get_ccr(env) << (PSR_CARRY_SHIFT - 4));
-    cpu_fprintf(f, ") asi: %02x tl: %d pil: %x\n", env->asi, env->tl,
-                env->psrpil);
+    cpu_fprintf(f, ") asi: %02x tl: %d pil: %x gl: %d\n", env->asi, env->tl,
+                env->psrpil, env->gl);
+    cpu_fprintf(f, "tbr: " TARGET_FMT_lx " hpstate: " TARGET_FMT_lx " htba: "
+                TARGET_FMT_lx "\n", env->tbr, env->hpstate, env->htba);
     cpu_fprintf(f, "cansave: %d canrestore: %d otherwin: %d wstate: %d "
                 "cleanwin: %d cwp: %d\n",
                 env->cansave, env->canrestore, env->otherwin, env->wstate,
                 env->cleanwin, env->nwindows - 1 - env->cwp);
     cpu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: "
                 TARGET_FMT_lx "\n", env->fsr, env->y, env->fprs);
+
 #else
     cpu_fprintf(f, "psr: %08x (icc: ", cpu_get_psr(env));
     cpu_print_cc(f, cpu_fprintf, cpu_get_psr(env));
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index f26fdcf..6c1607e 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -512,6 +512,7 @@ struct CPUSPARCState {
     uint64_t bgregs[8]; /* backup for normal global registers */
     uint64_t igregs[8]; /* interrupt general registers */
     uint64_t mgregs[8]; /* mmu general registers */
+    uint64_t glregs[8 * MAXTL_MAX];
     uint64_t fprs;
     uint64_t tick_cmpr, stick_cmpr;
     CPUTimer *tick, *stick;
@@ -612,6 +613,7 @@ void cpu_put_ccr(CPUSPARCState *env1, target_ulong val);
 target_ulong cpu_get_cwp64(CPUSPARCState *env1);
 void cpu_put_cwp64(CPUSPARCState *env1, int cwp);
 void cpu_change_pstate(CPUSPARCState *env1, uint32_t new_pstate);
+void cpu_gl_switch_gregs(CPUSPARCState *env, uint32_t new_gl);
 #endif
 int cpu_cwp_inc(CPUSPARCState *env1, int cwp);
 int cpu_cwp_dec(CPUSPARCState *env1, int cwp);
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 0cf1bfb..fe44e16 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -5,6 +5,7 @@ DEF_HELPER_1(rdpsr, tl, env)
 DEF_HELPER_1(power_down, void, env)
 #else
 DEF_HELPER_FLAGS_2(wrpil, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_2(wrgl, void, env, tl)
 DEF_HELPER_2(wrpstate, void, env, tl)
 DEF_HELPER_1(done, void, env)
 DEF_HELPER_1(retry, void, env)
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 8300eb4..605747c 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -146,6 +146,12 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         }
     }
 
+    if (env->def->features & CPU_FEATURE_GL) {
+        tsptr->tstate |= (env->gl & 7ULL) << 40;
+        cpu_gl_switch_gregs(env, env->gl + 1);
+        env->gl++;
+    }
+
     switch (intno) {
     case TT_IVEC:
         if (!cpu_has_hypervisor(env)) {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 82f9965..68677d3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4558,8 +4558,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 break;
                             case 16: // UA2005 gl
                                 CHECK_IU_FEATURE(dc, GL);
-                                tcg_gen_st32_tl(cpu_tmp0, cpu_env,
-                                                offsetof(CPUSPARCState, gl));
+                                gen_helper_wrgl(cpu_env, cpu_tmp0);
                                 break;
                             case 26: // UA2005 strand status
                                 CHECK_IU_FEATURE(dc, HYPV);
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 45ee4e6..71b3dd3 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -290,6 +290,10 @@ void helper_wrcwp(CPUSPARCState *env, target_ulong new_cwp)
 
 static inline uint64_t *get_gregset(CPUSPARCState *env, uint32_t pstate)
 {
+    if (env->def->features & CPU_FEATURE_GL) {
+        return env->glregs + (env->gl & 7) * 8;
+    }
+
     switch (pstate) {
     default:
         trace_win_helper_gregset_error(pstate);
@@ -305,14 +309,40 @@ static inline uint64_t *get_gregset(CPUSPARCState *env, uint32_t pstate)
     }
 }
 
+static inline uint64_t *get_gl_gregset(CPUSPARCState *env, uint32_t gl)
+{
+    return env->glregs + (gl & 7) * 8;
+}
+
+/* Switch global register bank */
+void cpu_gl_switch_gregs(CPUSPARCState *env, uint32_t new_gl)
+{
+    uint64_t *src, *dst;
+    src = get_gl_gregset(env, new_gl);
+    dst = get_gl_gregset(env, env->gl);
+
+    if (src != dst) {
+        memcpy32(dst, env->gregs);
+        memcpy32(env->gregs, src);
+    }
+}
+
+void helper_wrgl(CPUSPARCState *env, target_ulong new_gl)
+{
+    cpu_gl_switch_gregs(env, new_gl & 7);
+    env->gl = new_gl & 7;
+}
+
 void cpu_change_pstate(CPUSPARCState *env, uint32_t new_pstate)
 {
     uint32_t pstate_regs, new_pstate_regs;
     uint64_t *src, *dst;
 
     if (env->def->features & CPU_FEATURE_GL) {
-        /* PS_AG is not implemented in this case */
-        new_pstate &= ~PS_AG;
+        /* PS_AG, IG and MG are not implemented in this case */
+        new_pstate &= ~(PS_AG | PS_IG | PS_MG);
+        env->pstate = new_pstate;
+        return;
     }
 
     pstate_regs = env->pstate & 0xc01;
@@ -367,7 +397,10 @@ void helper_done(CPUSPARCState *env)
     cpu_change_pstate(env, (tsptr->tstate >> 8) & 0xf3f);
     cpu_put_cwp64(env, tsptr->tstate & 0xff);
     if (cpu_has_hypervisor(env)) {
+        uint32_t new_gl = (tsptr->tstate >> 40) & 7;
         env->hpstate = env->htstate[env->tl];
+        cpu_gl_switch_gregs(env, new_gl);
+        env->gl = new_gl;
     }
     env->tl--;
 
@@ -391,7 +424,10 @@ void helper_retry(CPUSPARCState *env)
     cpu_change_pstate(env, (tsptr->tstate >> 8) & 0xf3f);
     cpu_put_cwp64(env, tsptr->tstate & 0xff);
     if (cpu_has_hypervisor(env)) {
+        uint32_t new_gl = (tsptr->tstate >> 40) & 7;
         env->hpstate = env->htstate[env->tl];
+        cpu_gl_switch_gregs(env, new_gl);
+        env->gl = new_gl;
     }
     env->tl--;
 
-- 
2.9.3
