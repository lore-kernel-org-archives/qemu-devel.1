Received: from eggs.gnu.org ([2001:4830:134:3::10]:39803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKV-0002rC-P7
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKS-0006xs-IT
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:44 +1000
Message-Id: <20180703055804.13449-16-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/35] target/ppc: Remove POWERPC_EXCP_STCX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

Always use the gen_conditional_store implementation that uses
atomic_cmpxchg.  Make sure and clear reserve_addr across most
interrupts crossing the cpu_loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 linux-user/ppc/cpu_loop.c | 121 +++++++-------------------------------
 target/ppc/cpu.h          |   5 --
 target/ppc/translate.c    |  14 -----
 3 files changed, 22 insertions(+), 118 deletions(-)

diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 2fb516cb00..133a87f349 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -65,99 +65,23 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val)
     return -1;
 }
 
-static int do_store_exclusive(CPUPPCState *env)
-{
-    target_ulong addr;
-    target_ulong page_addr;
-    target_ulong val, val2 __attribute__((unused)) = 0;
-    int flags;
-    int segv = 0;
-
-    addr = env->reserve_ea;
-    page_addr = addr & TARGET_PAGE_MASK;
-    start_exclusive();
-    mmap_lock();
-    flags = page_get_flags(page_addr);
-    if ((flags & PAGE_READ) == 0) {
-        segv = 1;
-    } else {
-        int reg = env->reserve_info & 0x1f;
-        int size = env->reserve_info >> 5;
-        int stored = 0;
-
-        if (addr == env->reserve_addr) {
-            switch (size) {
-            case 1: segv = get_user_u8(val, addr); break;
-            case 2: segv = get_user_u16(val, addr); break;
-            case 4: segv = get_user_u32(val, addr); break;
-#if defined(TARGET_PPC64)
-            case 8: segv = get_user_u64(val, addr); break;
-            case 16: {
-                segv = get_user_u64(val, addr);
-                if (!segv) {
-                    segv = get_user_u64(val2, addr + 8);
-                }
-                break;
-            }
-#endif
-            default: abort();
-            }
-            if (!segv && val == env->reserve_val) {
-                val = env->gpr[reg];
-                switch (size) {
-                case 1: segv = put_user_u8(val, addr); break;
-                case 2: segv = put_user_u16(val, addr); break;
-                case 4: segv = put_user_u32(val, addr); break;
-#if defined(TARGET_PPC64)
-                case 8: segv = put_user_u64(val, addr); break;
-                case 16: {
-                    if (val2 == env->reserve_val2) {
-                        if (msr_le) {
-                            val2 = val;
-                            val = env->gpr[reg+1];
-                        } else {
-                            val2 = env->gpr[reg+1];
-                        }
-                        segv = put_user_u64(val, addr);
-                        if (!segv) {
-                            segv = put_user_u64(val2, addr + 8);
-                        }
-                    }
-                    break;
-                }
-#endif
-                default: abort();
-                }
-                if (!segv) {
-                    stored = 1;
-                }
-            }
-        }
-        env->crf[0] = (stored << 1) | xer_so;
-        env->reserve_addr = (target_ulong)-1;
-    }
-    if (!segv) {
-        env->nip += 4;
-    }
-    mmap_unlock();
-    end_exclusive();
-    return segv;
-}
-
 void cpu_loop(CPUPPCState *env)
 {
     CPUState *cs = CPU(ppc_env_get_cpu(env));
     target_siginfo_t info;
-    int trapnr;
+    int trapnr, sig;
     target_ulong ret;
 
     for(;;) {
+        bool arch_interrupt;
+
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
         process_queued_cpu_work(cs);
 
-        switch(trapnr) {
+        arch_interrupt = true;
+        switch (trapnr) {
         case POWERPC_EXCP_NONE:
             /* Just go on */
             break;
@@ -524,26 +448,15 @@ void cpu_loop(CPUPPCState *env)
             }
             env->gpr[3] = ret;
             break;
-        case POWERPC_EXCP_STCX:
-            if (do_store_exclusive(env)) {
-                info.si_signo = TARGET_SIGSEGV;
+        case EXCP_DEBUG:
+            sig = gdb_handlesig(cs, TARGET_SIGTRAP);
+            if (sig) {
+                info.si_signo = sig;
                 info.si_errno = 0;
-                info.si_code = TARGET_SEGV_MAPERR;
-                info._sifields._sigfault._addr = env->nip;
+                info.si_code = TARGET_TRAP_BRKPT;
                 queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
-        case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig) {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
+            } else {
+                arch_interrupt = false;
             }
             break;
         case EXCP_INTERRUPT:
@@ -551,12 +464,22 @@ void cpu_loop(CPUPPCState *env)
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
+            arch_interrupt = false;
             break;
         default:
             cpu_abort(cs, "Unknown exception 0x%x. Aborting\n", trapnr);
             break;
         }
         process_pending_signals(env);
+
+        /* Most of the traps imply a transition through kernel mode,
+         * which implies an REI instruction has been executed.  Which
+         * means that RX and LOCK_ADDR should be cleared.  But there
+         * are a few exceptions for traps internal to QEMU.
+         */
+        if (arch_interrupt) {
+            env->reserve_addr = -1;
+        }
     }
 }
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 973cf44cda..4edcf62cf7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -196,7 +196,6 @@ enum {
     /* QEMU exceptions: special cases we want to stop translation            */
     POWERPC_EXCP_SYNC         = 0x202, /* context synchronizing instruction  */
     POWERPC_EXCP_SYSCALL_USER = 0x203, /* System call in user mode only      */
-    POWERPC_EXCP_STCX         = 0x204 /* Conditional stores in user mode     */
 };
 
 /* Exceptions error codes                                                    */
@@ -994,10 +993,6 @@ struct CPUPPCState {
     /* Reservation value */
     target_ulong reserve_val;
     target_ulong reserve_val2;
-    /* Reservation store address */
-    target_ulong reserve_ea;
-    /* Reserved store source register and size */
-    target_ulong reserve_info;
 
     /* Those ones are used in supervisor mode only */
     /* machine state register */
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c7b9d226eb..03e8c5df03 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3201,19 +3201,6 @@ ST_ATOMIC(stwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32)
 ST_ATOMIC(stdat, DEF_MEMOP(MO_Q), i64, mov_i64)
 #endif
 
-#if defined(CONFIG_USER_ONLY)
-static void gen_conditional_store(DisasContext *ctx, TCGv EA,
-                                  int reg, int memop)
-{
-    TCGv t0 = tcg_temp_new();
-
-    tcg_gen_st_tl(EA, cpu_env, offsetof(CPUPPCState, reserve_ea));
-    tcg_gen_movi_tl(t0, (MEMOP_GET_SIZE(memop) << 5) | reg);
-    tcg_gen_st_tl(t0, cpu_env, offsetof(CPUPPCState, reserve_info));
-    tcg_temp_free(t0);
-    gen_exception_err(ctx, POWERPC_EXCP_STCX, 0);
-}
-#else
 static void gen_conditional_store(DisasContext *ctx, TCGv EA,
                                   int reg, int memop)
 {
@@ -3244,7 +3231,6 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
     gen_set_label(l2);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
-#endif
 
 #define STCX(name, memop)                                   \
 static void gen_##name(DisasContext *ctx)                   \
-- 
2.17.1
