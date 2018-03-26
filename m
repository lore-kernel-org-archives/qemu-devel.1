Received: from eggs.gnu.org ([2001:4830:134:3::10]:58550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbr-0003NB-Qe
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbp-0001d2-4K
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:47 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 26 Mar 2018 21:15:49 +0200
Message-Id: <20180326191603.10217-6-laurent@vivier.eu>
In-Reply-To: <20180326191603.10217-1-laurent@vivier.eu>
References: <20180326191603.10217-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 05/19] linux-user: move sparc/sparc64
 cpu loop to sparc directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

No code change, only move code from main.c to
sparc/cpu_loop.c.

Include sparc/cpu_loop.c in sparc64/cpu_loop.c
to avoid to duplicate code.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c             | 288 +-----------------------------------------
 linux-user/sparc/cpu_loop.c   | 280 ++++++++++++++++++++++++++++++++++++++++
 linux-user/sparc64/cpu_loop.c |   8 +-
 3 files changed, 282 insertions(+), 294 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index f8ea0c8b96..349dcd6a20 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,281 +149,6 @@ void fork_end(int child)
     }
 }
 
-#ifdef TARGET_SPARC
-#define SPARC64_STACK_BIAS 2047
-
-//#define DEBUG_WIN
-
-/* WARNING: dealing with register windows _is_ complicated. More info
-   can be found at http://www.sics.se/~psm/sparcstack.html */
-static inline int get_reg_index(CPUSPARCState *env, int cwp, int index)
-{
-    index = (index + cwp * 16) % (16 * env->nwindows);
-    /* wrap handling : if cwp is on the last window, then we use the
-       registers 'after' the end */
-    if (index < 8 && env->cwp == env->nwindows - 1)
-        index += 16 * env->nwindows;
-    return index;
-}
-
-/* save the register window 'cwp1' */
-static inline void save_window_offset(CPUSPARCState *env, int cwp1)
-{
-    unsigned int i;
-    abi_ulong sp_ptr;
-
-    sp_ptr = env->regbase[get_reg_index(env, cwp1, 6)];
-#ifdef TARGET_SPARC64
-    if (sp_ptr & 3)
-        sp_ptr += SPARC64_STACK_BIAS;
-#endif
-#if defined(DEBUG_WIN)
-    printf("win_overflow: sp_ptr=0x" TARGET_ABI_FMT_lx " save_cwp=%d\n",
-           sp_ptr, cwp1);
-#endif
-    for(i = 0; i < 16; i++) {
-        /* FIXME - what to do if put_user() fails? */
-        put_user_ual(env->regbase[get_reg_index(env, cwp1, 8 + i)], sp_ptr);
-        sp_ptr += sizeof(abi_ulong);
-    }
-}
-
-static void save_window(CPUSPARCState *env)
-{
-#ifndef TARGET_SPARC64
-    unsigned int new_wim;
-    new_wim = ((env->wim >> 1) | (env->wim << (env->nwindows - 1))) &
-        ((1LL << env->nwindows) - 1);
-    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
-    env->wim = new_wim;
-#else
-    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
-    env->cansave++;
-    env->canrestore--;
-#endif
-}
-
-static void restore_window(CPUSPARCState *env)
-{
-#ifndef TARGET_SPARC64
-    unsigned int new_wim;
-#endif
-    unsigned int i, cwp1;
-    abi_ulong sp_ptr;
-
-#ifndef TARGET_SPARC64
-    new_wim = ((env->wim << 1) | (env->wim >> (env->nwindows - 1))) &
-        ((1LL << env->nwindows) - 1);
-#endif
-
-    /* restore the invalid window */
-    cwp1 = cpu_cwp_inc(env, env->cwp + 1);
-    sp_ptr = env->regbase[get_reg_index(env, cwp1, 6)];
-#ifdef TARGET_SPARC64
-    if (sp_ptr & 3)
-        sp_ptr += SPARC64_STACK_BIAS;
-#endif
-#if defined(DEBUG_WIN)
-    printf("win_underflow: sp_ptr=0x" TARGET_ABI_FMT_lx " load_cwp=%d\n",
-           sp_ptr, cwp1);
-#endif
-    for(i = 0; i < 16; i++) {
-        /* FIXME - what to do if get_user() fails? */
-        get_user_ual(env->regbase[get_reg_index(env, cwp1, 8 + i)], sp_ptr);
-        sp_ptr += sizeof(abi_ulong);
-    }
-#ifdef TARGET_SPARC64
-    env->canrestore++;
-    if (env->cleanwin < env->nwindows - 1)
-        env->cleanwin++;
-    env->cansave--;
-#else
-    env->wim = new_wim;
-#endif
-}
-
-static void flush_windows(CPUSPARCState *env)
-{
-    int offset, cwp1;
-
-    offset = 1;
-    for(;;) {
-        /* if restore would invoke restore_window(), then we can stop */
-        cwp1 = cpu_cwp_inc(env, env->cwp + offset);
-#ifndef TARGET_SPARC64
-        if (env->wim & (1 << cwp1))
-            break;
-#else
-        if (env->canrestore == 0)
-            break;
-        env->cansave++;
-        env->canrestore--;
-#endif
-        save_window_offset(env, cwp1);
-        offset++;
-    }
-    cwp1 = cpu_cwp_inc(env, env->cwp + 1);
-#ifndef TARGET_SPARC64
-    /* set wim so that restore will reload the registers */
-    env->wim = 1 << cwp1;
-#endif
-#if defined(DEBUG_WIN)
-    printf("flush_windows: nb=%d\n", offset - 1);
-#endif
-}
-
-void cpu_loop (CPUSPARCState *env)
-{
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
-    int trapnr;
-    abi_long ret;
-    target_siginfo_t info;
-
-    while (1) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
-        /* Compute PSR before exposing state.  */
-        if (env->cc_op != CC_OP_FLAGS) {
-            cpu_get_psr(env);
-        }
-
-        switch (trapnr) {
-#ifndef TARGET_SPARC64
-        case 0x88:
-        case 0x90:
-#else
-        case 0x110:
-        case 0x16d:
-#endif
-            ret = do_syscall (env, env->gregs[1],
-                              env->regwptr[0], env->regwptr[1],
-                              env->regwptr[2], env->regwptr[3],
-                              env->regwptr[4], env->regwptr[5],
-                              0, 0);
-            if (ret == -TARGET_ERESTARTSYS || ret == -TARGET_QEMU_ESIGRETURN) {
-                break;
-            }
-            if ((abi_ulong)ret >= (abi_ulong)(-515)) {
-#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-                env->xcc |= PSR_CARRY;
-#else
-                env->psr |= PSR_CARRY;
-#endif
-                ret = -ret;
-            } else {
-#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-                env->xcc &= ~PSR_CARRY;
-#else
-                env->psr &= ~PSR_CARRY;
-#endif
-            }
-            env->regwptr[0] = ret;
-            /* next instruction */
-            env->pc = env->npc;
-            env->npc = env->npc + 4;
-            break;
-        case 0x83: /* flush windows */
-#ifdef TARGET_ABI32
-        case 0x103:
-#endif
-            flush_windows(env);
-            /* next instruction */
-            env->pc = env->npc;
-            env->npc = env->npc + 4;
-            break;
-#ifndef TARGET_SPARC64
-        case TT_WIN_OVF: /* window overflow */
-            save_window(env);
-            break;
-        case TT_WIN_UNF: /* window underflow */
-            restore_window(env);
-            break;
-        case TT_TFAULT:
-        case TT_DFAULT:
-            {
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                /* XXX: check env->error_code */
-                info.si_code = TARGET_SEGV_MAPERR;
-                info._sifields._sigfault._addr = env->mmuregs[4];
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
-#else
-        case TT_SPILL: /* window overflow */
-            save_window(env);
-            break;
-        case TT_FILL: /* window underflow */
-            restore_window(env);
-            break;
-        case TT_TFAULT:
-        case TT_DFAULT:
-            {
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                /* XXX: check env->error_code */
-                info.si_code = TARGET_SEGV_MAPERR;
-                if (trapnr == TT_DFAULT)
-                    info._sifields._sigfault._addr = env->dmmu.mmuregs[4];
-                else
-                    info._sifields._sigfault._addr = cpu_tsptr(env)->tpc;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
-#ifndef TARGET_ABI32
-        case 0x16e:
-            flush_windows(env);
-            sparc64_get_context(env);
-            break;
-        case 0x16f:
-            flush_windows(env);
-            sparc64_set_context(env);
-            break;
-#endif
-#endif
-        case EXCP_INTERRUPT:
-            /* just indicate that signals should be handled asap */
-            break;
-        case TT_ILL_INSN:
-            {
-                info.si_signo = TARGET_SIGILL;
-                info.si_errno = 0;
-                info.si_code = TARGET_ILL_ILLOPC;
-                info._sifields._sigfault._addr = env->pc;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
-        case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig)
-                  {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
-            }
-            break;
-        case EXCP_ATOMIC:
-            cpu_exec_step_atomic(cs);
-            break;
-        default:
-            printf ("Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
-            exit(EXIT_FAILURE);
-        }
-        process_pending_signals (env);
-    }
-}
-
-#endif
-
 #ifdef TARGET_PPC
 static inline uint64_t cpu_ppc_get_tb(CPUPPCState *env)
 {
@@ -3999,18 +3724,7 @@ int main(int argc, char **argv, char **envp)
 
     target_cpu_copy_regs(env, regs);
 
-#if defined(TARGET_SPARC)
-    {
-        int i;
-	env->pc = regs->pc;
-	env->npc = regs->npc;
-        env->y = regs->y;
-        for(i = 0; i < 8; i++)
-            env->gregs[i] = regs->u_regs[i];
-        for(i = 0; i < 8; i++)
-            env->regwptr[i] = regs->u_regs[i + 8];
-    }
-#elif defined(TARGET_PPC)
+#if defined(TARGET_PPC)
     {
         int i;
 
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index b7700a5561..7c4796ca23 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -21,6 +21,286 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+#define SPARC64_STACK_BIAS 2047
+
+//#define DEBUG_WIN
+
+/* WARNING: dealing with register windows _is_ complicated. More info
+   can be found at http://www.sics.se/~psm/sparcstack.html */
+static inline int get_reg_index(CPUSPARCState *env, int cwp, int index)
+{
+    index = (index + cwp * 16) % (16 * env->nwindows);
+    /* wrap handling : if cwp is on the last window, then we use the
+       registers 'after' the end */
+    if (index < 8 && env->cwp == env->nwindows - 1)
+        index += 16 * env->nwindows;
+    return index;
+}
+
+/* save the register window 'cwp1' */
+static inline void save_window_offset(CPUSPARCState *env, int cwp1)
+{
+    unsigned int i;
+    abi_ulong sp_ptr;
+
+    sp_ptr = env->regbase[get_reg_index(env, cwp1, 6)];
+#ifdef TARGET_SPARC64
+    if (sp_ptr & 3)
+        sp_ptr += SPARC64_STACK_BIAS;
+#endif
+#if defined(DEBUG_WIN)
+    printf("win_overflow: sp_ptr=0x" TARGET_ABI_FMT_lx " save_cwp=%d\n",
+           sp_ptr, cwp1);
+#endif
+    for(i = 0; i < 16; i++) {
+        /* FIXME - what to do if put_user() fails? */
+        put_user_ual(env->regbase[get_reg_index(env, cwp1, 8 + i)], sp_ptr);
+        sp_ptr += sizeof(abi_ulong);
+    }
+}
+
+static void save_window(CPUSPARCState *env)
+{
+#ifndef TARGET_SPARC64
+    unsigned int new_wim;
+    new_wim = ((env->wim >> 1) | (env->wim << (env->nwindows - 1))) &
+        ((1LL << env->nwindows) - 1);
+    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
+    env->wim = new_wim;
+#else
+    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
+    env->cansave++;
+    env->canrestore--;
+#endif
+}
+
+static void restore_window(CPUSPARCState *env)
+{
+#ifndef TARGET_SPARC64
+    unsigned int new_wim;
+#endif
+    unsigned int i, cwp1;
+    abi_ulong sp_ptr;
+
+#ifndef TARGET_SPARC64
+    new_wim = ((env->wim << 1) | (env->wim >> (env->nwindows - 1))) &
+        ((1LL << env->nwindows) - 1);
+#endif
+
+    /* restore the invalid window */
+    cwp1 = cpu_cwp_inc(env, env->cwp + 1);
+    sp_ptr = env->regbase[get_reg_index(env, cwp1, 6)];
+#ifdef TARGET_SPARC64
+    if (sp_ptr & 3)
+        sp_ptr += SPARC64_STACK_BIAS;
+#endif
+#if defined(DEBUG_WIN)
+    printf("win_underflow: sp_ptr=0x" TARGET_ABI_FMT_lx " load_cwp=%d\n",
+           sp_ptr, cwp1);
+#endif
+    for(i = 0; i < 16; i++) {
+        /* FIXME - what to do if get_user() fails? */
+        get_user_ual(env->regbase[get_reg_index(env, cwp1, 8 + i)], sp_ptr);
+        sp_ptr += sizeof(abi_ulong);
+    }
+#ifdef TARGET_SPARC64
+    env->canrestore++;
+    if (env->cleanwin < env->nwindows - 1)
+        env->cleanwin++;
+    env->cansave--;
+#else
+    env->wim = new_wim;
+#endif
+}
+
+static void flush_windows(CPUSPARCState *env)
+{
+    int offset, cwp1;
+
+    offset = 1;
+    for(;;) {
+        /* if restore would invoke restore_window(), then we can stop */
+        cwp1 = cpu_cwp_inc(env, env->cwp + offset);
+#ifndef TARGET_SPARC64
+        if (env->wim & (1 << cwp1))
+            break;
+#else
+        if (env->canrestore == 0)
+            break;
+        env->cansave++;
+        env->canrestore--;
+#endif
+        save_window_offset(env, cwp1);
+        offset++;
+    }
+    cwp1 = cpu_cwp_inc(env, env->cwp + 1);
+#ifndef TARGET_SPARC64
+    /* set wim so that restore will reload the registers */
+    env->wim = 1 << cwp1;
+#endif
+#if defined(DEBUG_WIN)
+    printf("flush_windows: nb=%d\n", offset - 1);
+#endif
+}
+
+void cpu_loop (CPUSPARCState *env)
+{
+    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    int trapnr;
+    abi_long ret;
+    target_siginfo_t info;
+
+    while (1) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        /* Compute PSR before exposing state.  */
+        if (env->cc_op != CC_OP_FLAGS) {
+            cpu_get_psr(env);
+        }
+
+        switch (trapnr) {
+#ifndef TARGET_SPARC64
+        case 0x88:
+        case 0x90:
+#else
+        case 0x110:
+        case 0x16d:
+#endif
+            ret = do_syscall (env, env->gregs[1],
+                              env->regwptr[0], env->regwptr[1],
+                              env->regwptr[2], env->regwptr[3],
+                              env->regwptr[4], env->regwptr[5],
+                              0, 0);
+            if (ret == -TARGET_ERESTARTSYS || ret == -TARGET_QEMU_ESIGRETURN) {
+                break;
+            }
+            if ((abi_ulong)ret >= (abi_ulong)(-515)) {
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+                env->xcc |= PSR_CARRY;
+#else
+                env->psr |= PSR_CARRY;
+#endif
+                ret = -ret;
+            } else {
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+                env->xcc &= ~PSR_CARRY;
+#else
+                env->psr &= ~PSR_CARRY;
+#endif
+            }
+            env->regwptr[0] = ret;
+            /* next instruction */
+            env->pc = env->npc;
+            env->npc = env->npc + 4;
+            break;
+        case 0x83: /* flush windows */
+#ifdef TARGET_ABI32
+        case 0x103:
+#endif
+            flush_windows(env);
+            /* next instruction */
+            env->pc = env->npc;
+            env->npc = env->npc + 4;
+            break;
+#ifndef TARGET_SPARC64
+        case TT_WIN_OVF: /* window overflow */
+            save_window(env);
+            break;
+        case TT_WIN_UNF: /* window underflow */
+            restore_window(env);
+            break;
+        case TT_TFAULT:
+        case TT_DFAULT:
+            {
+                info.si_signo = TARGET_SIGSEGV;
+                info.si_errno = 0;
+                /* XXX: check env->error_code */
+                info.si_code = TARGET_SEGV_MAPERR;
+                info._sifields._sigfault._addr = env->mmuregs[4];
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
+            break;
+#else
+        case TT_SPILL: /* window overflow */
+            save_window(env);
+            break;
+        case TT_FILL: /* window underflow */
+            restore_window(env);
+            break;
+        case TT_TFAULT:
+        case TT_DFAULT:
+            {
+                info.si_signo = TARGET_SIGSEGV;
+                info.si_errno = 0;
+                /* XXX: check env->error_code */
+                info.si_code = TARGET_SEGV_MAPERR;
+                if (trapnr == TT_DFAULT)
+                    info._sifields._sigfault._addr = env->dmmu.mmuregs[4];
+                else
+                    info._sifields._sigfault._addr = cpu_tsptr(env)->tpc;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
+            break;
+#ifndef TARGET_ABI32
+        case 0x16e:
+            flush_windows(env);
+            sparc64_get_context(env);
+            break;
+        case 0x16f:
+            flush_windows(env);
+            sparc64_set_context(env);
+            break;
+#endif
+#endif
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case TT_ILL_INSN:
+            {
+                info.si_signo = TARGET_SIGILL;
+                info.si_errno = 0;
+                info.si_code = TARGET_ILL_ILLOPC;
+                info._sifields._sigfault._addr = env->pc;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
+            break;
+        case EXCP_DEBUG:
+            {
+                int sig;
+
+                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
+                if (sig)
+                  {
+                    info.si_signo = sig;
+                    info.si_errno = 0;
+                    info.si_code = TARGET_TRAP_BRKPT;
+                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                  }
+            }
+            break;
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            break;
+        default:
+            printf ("Unhandled trap: 0x%x\n", trapnr);
+            cpu_dump_state(cs, stderr, fprintf, 0);
+            exit(EXIT_FAILURE);
+        }
+        process_pending_signals (env);
+    }
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    int i;
+    env->pc = regs->pc;
+    env->npc = regs->npc;
+    env->y = regs->y;
+    for(i = 0; i < 8; i++)
+        env->gregs[i] = regs->u_regs[i];
+    for(i = 0; i < 8; i++)
+        env->regwptr[i] = regs->u_regs[i + 8];
 }
diff --git a/linux-user/sparc64/cpu_loop.c b/linux-user/sparc64/cpu_loop.c
index b7700a5561..4fd44e1b1e 100644
--- a/linux-user/sparc64/cpu_loop.c
+++ b/linux-user/sparc64/cpu_loop.c
@@ -17,10 +17,4 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "qemu/osdep.h"
-#include "qemu.h"
-#include "cpu_loop-common.h"
-
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
-{
-}
+#include "../sparc/cpu_loop.c"
-- 
2.14.3
