Received: from eggs.gnu.org ([2001:4830:134:3::10]:36961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytB-0006ac-Hh
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTyt7-0002k9-Om
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:33 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTyt7-0002jC-Fe
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:29 -0500
Received: by mail-wm0-x242.google.com with SMTP id r126so7538980wmr.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:29 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:25 +0100
Message-Id: <1484779123-18968-13-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 12/30] target-sparc: implement UA2005 GL register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.c          | 13 ++++++++++---
 target/sparc/cpu.h          |  2 ++
 target/sparc/helper.h       |  1 +
 target/sparc/int64_helper.c |  6 ++++++
 target/sparc/translate.c    |  3 +--
 target/sparc/win_helper.c   | 40 ++++++++++++++++++++++++++++++++++++++--
 6 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index d6583f1..d606eb5 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -57,9 +57,13 @@ static void sparc_cpu_reset(CPUState *s)
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
@@ -744,14 +748,17 @@ void sparc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
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
index f173dd6..857e93b 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -515,6 +515,7 @@ struct CPUSPARCState {
     uint64_t bgregs[8]; /* backup for normal global registers */
     uint64_t igregs[8]; /* interrupt general registers */
     uint64_t mgregs[8]; /* mmu general registers */
+    uint64_t glregs[8 * MAXTL_MAX];
     uint64_t fprs;
     uint64_t tick_cmpr, stick_cmpr;
     CPUTimer *tick, *stick;
@@ -615,6 +616,7 @@ void cpu_put_ccr(CPUSPARCState *env1, target_ulong val);
 target_ulong cpu_get_cwp64(CPUSPARCState *env1);
 void cpu_put_cwp64(CPUSPARCState *env1, int cwp);
 void cpu_change_pstate(CPUSPARCState *env1, uint32_t new_pstate);
+void cpu_gl_switch_gregs(CPUSPARCState *env, uint32_t new_gl);
 #endif
 int cpu_cwp_inc(CPUSPARCState *env1, int cwp);
 int cpu_cwp_dec(CPUSPARCState *env1, int cwp);
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 3ef38b9..b8f1e78 100644
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
index 009ea3a..a40c974 100644
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
2.7.2
