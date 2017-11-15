Received: from eggs.gnu.org ([2001:4830:134:3::10]:34481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEwwa-0006r4-TB
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEwwZ-0006Nh-2Z
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:37:28 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:47811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eEwwY-0006N3-OJ
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:37:26 -0500
Received: by mail-wr0-x243.google.com with SMTP id k61so20333561wrc.4
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 04:37:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 15 Nov 2017 13:35:18 +0100
Message-Id: <20171115123520.7464-2-richard.henderson@linaro.org>
In-Reply-To: <20171115123520.7464-1-richard.henderson@linaro.org>
References: <20171115123520.7464-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-2.11 1/3] tcg: Record code_gen_buffer
 address for user-only memory helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

When we handle a signal from a fault within a user-only memory helper,
we cannot cpu_restore_state with the PC found within the signal frame.
Use a TLS variable, helper_retaddr, to record the unwind start point
to find the faulting guest insn.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h               | 32 +++++++++++++----
 include/exec/cpu_ldst.h                   |  2 ++
 include/exec/cpu_ldst_useronly_template.h | 14 ++++++--
 accel/tcg/cputlb.c                        |  1 +
 accel/tcg/user-exec.c                     | 58 +++++++++++++++++++++++++------
 5 files changed, 87 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index b400b2a3d3..1c7c17526c 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -62,7 +62,9 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
                               ABI_TYPE cmpv, ABI_TYPE newv EXTRA_ARGS)
 {
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    return atomic_cmpxchg__nocheck(haddr, cmpv, newv);
+    DATA_TYPE ret = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
+    ATOMIC_MMU_CLEANUP;
+    return ret;
 }
 
 #if DATA_SIZE >= 16
@@ -70,6 +72,7 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
     __atomic_load(haddr, &val, __ATOMIC_RELAXED);
+    ATOMIC_MMU_CLEANUP;
     return val;
 }
 
@@ -78,13 +81,16 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     __atomic_store(haddr, &val, __ATOMIC_RELAXED);
+    ATOMIC_MMU_CLEANUP;
 }
 #else
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
                            ABI_TYPE val EXTRA_ARGS)
 {
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    return atomic_xchg__nocheck(haddr, val);
+    DATA_TYPE ret = atomic_xchg__nocheck(haddr, val);
+    ATOMIC_MMU_CLEANUP;
+    return ret;
 }
 
 #define GEN_ATOMIC_HELPER(X)                                        \
@@ -92,8 +98,10 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                  ABI_TYPE val EXTRA_ARGS)                           \
 {                                                                   \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
-    return atomic_##X(haddr, val);                                  \
-}                                                                   \
+    DATA_TYPE ret = atomic_##X(haddr, val);                         \
+    ATOMIC_MMU_CLEANUP;                                             \
+    return ret;                                                     \
+}
 
 GEN_ATOMIC_HELPER(fetch_add)
 GEN_ATOMIC_HELPER(fetch_and)
@@ -123,7 +131,9 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
                               ABI_TYPE cmpv, ABI_TYPE newv EXTRA_ARGS)
 {
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    return BSWAP(atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv)));
+    DATA_TYPE ret = atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
+    ATOMIC_MMU_CLEANUP;
+    return BSWAP(ret);
 }
 
 #if DATA_SIZE >= 16
@@ -131,6 +141,7 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
     __atomic_load(haddr, &val, __ATOMIC_RELAXED);
+    ATOMIC_MMU_CLEANUP;
     return BSWAP(val);
 }
 
@@ -140,13 +151,16 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     val = BSWAP(val);
     __atomic_store(haddr, &val, __ATOMIC_RELAXED);
+    ATOMIC_MMU_CLEANUP;
 }
 #else
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
                            ABI_TYPE val EXTRA_ARGS)
 {
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    return BSWAP(atomic_xchg__nocheck(haddr, BSWAP(val)));
+    ABI_TYPE ret = atomic_xchg__nocheck(haddr, BSWAP(val));
+    ATOMIC_MMU_CLEANUP;
+    return BSWAP(ret);
 }
 
 #define GEN_ATOMIC_HELPER(X)                                        \
@@ -154,7 +168,9 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                  ABI_TYPE val EXTRA_ARGS)                           \
 {                                                                   \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
-    return BSWAP(atomic_##X(haddr, BSWAP(val)));                    \
+    DATA_TYPE ret = atomic_##X(haddr, BSWAP(val));                  \
+    ATOMIC_MMU_CLEANUP;                                             \
+    return BSWAP(ret);                                              \
 }
 
 GEN_ATOMIC_HELPER(fetch_and)
@@ -180,6 +196,7 @@ ABI_TYPE ATOMIC_NAME(fetch_add)(CPUArchState *env, target_ulong addr,
         sto = BSWAP(ret + val);
         ldn = atomic_cmpxchg__nocheck(haddr, ldo, sto);
         if (ldn == ldo) {
+            ATOMIC_MMU_CLEANUP;
             return ret;
         }
         ldo = ldn;
@@ -198,6 +215,7 @@ ABI_TYPE ATOMIC_NAME(add_fetch)(CPUArchState *env, target_ulong addr,
         sto = BSWAP(ret);
         ldn = atomic_cmpxchg__nocheck(haddr, ldo, sto);
         if (ldn == ldo) {
+            ATOMIC_MMU_CLEANUP;
             return ret;
         }
         ldo = ldn;
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 6eb5fe80dc..191f2e962a 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -76,6 +76,8 @@
 
 #if defined(CONFIG_USER_ONLY)
 
+extern __thread uintptr_t helper_retaddr;
+
 /* In user-only mode we provide only the _code and _data accessors. */
 
 #define MEMSUFFIX _data
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 7b8c7c506e..c168f31bba 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -73,7 +73,11 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
                                                   uintptr_t retaddr)
 {
-    return glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(env, ptr);
+    RES_TYPE ret;
+    helper_retaddr = retaddr;
+    ret = glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(env, ptr);
+    helper_retaddr = 0;
+    return ret;
 }
 
 #if DATA_SIZE <= 2
@@ -93,7 +97,11 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
                                                   uintptr_t retaddr)
 {
-    return glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(env, ptr);
+    int ret;
+    helper_retaddr = retaddr;
+    ret = glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(env, ptr);
+    helper_retaddr = 0;
+    return ret;
 }
 #endif
 
@@ -116,7 +124,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   RES_TYPE v,
                                                   uintptr_t retaddr)
 {
+    helper_retaddr = retaddr;
     glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(env, ptr, v);
+    helper_retaddr = 0;
 }
 #endif
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a23919c3a8..d071ca4d14 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1041,6 +1041,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define ATOMIC_NAME(X) \
     HELPER(glue(glue(glue(atomic_ ## X, SUFFIX), END), _mmu))
 #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, oi, retaddr)
+#define ATOMIC_MMU_CLEANUP do { } while (0)
 
 #define DATA_SIZE 1
 #include "atomic_template.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 492ea0826c..0324ba8ad1 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -39,6 +39,8 @@
 #include <sys/ucontext.h>
 #endif
 
+__thread uintptr_t helper_retaddr;
+
 //#define DEBUG_SIGNAL
 
 /* exit the current TB from a signal handler. The host registers are
@@ -62,6 +64,27 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
     CPUClass *cc;
     int ret;
 
+    /* We must handle PC addresses from two different sources:
+     * a call return address and a signal frame address.
+     *
+     * Within cpu_restore_state_from_tb we assume the former and adjust
+     * the address by -GETPC_ADJ so that the address is within the call
+     * insn so that addr does not accidentally match the beginning of the
+     * next guest insn.
+     *
+     * However, when the PC comes from the signal frame, it points to
+     * the actual faulting host insn and not a call insn.  Subtracting
+     * GETPC_ADJ in that case may accidentally match the previous guest insn.
+     *
+     * So for the later case, adjust forward to compensate for what
+     * will be done later by cpu_restore_state_from_tb.
+     */
+    if (helper_retaddr) {
+        pc = helper_retaddr;
+    } else {
+        pc += GETPC_ADJ;
+    }
+
     /* For synchronous signals we expect to be coming from the vCPU
      * thread (so current_cpu should be valid) and either from running
      * code or during translation which can fault as we cross pages.
@@ -84,21 +107,24 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
         switch (page_unprotect(h2g(address), pc)) {
         case 0:
             /* Fault not caused by a page marked unwritable to protect
-             * cached translations, must be the guest binary's problem
+             * cached translations, must be the guest binary's problem.
              */
             break;
         case 1:
             /* Fault caused by protection of cached translation; TBs
-             * invalidated, so resume execution
+             * invalidated, so resume execution.  Retain helper_retaddr
+             * for a possible second fault.
              */
             return 1;
         case 2:
             /* Fault caused by protection of cached translation, and the
              * currently executing TB was modified and must be exited
-             * immediately.
+             * immediately.  Clear helper_retaddr for next execution.
              */
+            helper_retaddr = 0;
             cpu_exit_tb_from_sighandler(cpu, old_set);
-            g_assert_not_reached();
+            /* NORETURN */
+
         default:
             g_assert_not_reached();
         }
@@ -112,17 +138,25 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
     /* see if it is an MMU fault */
     g_assert(cc->handle_mmu_fault);
     ret = cc->handle_mmu_fault(cpu, address, is_write, MMU_USER_IDX);
+
+    if (ret == 0) {
+        /* The MMU fault was handled without causing real CPU fault.
+         *  Retain helper_retaddr for a possible second fault.
+         */
+        return 1;
+    }
+
+    /* All other paths lead to cpu_exit; clear helper_retaddr
+     * for next execution.
+     */
+    helper_retaddr = 0;
+
     if (ret < 0) {
         return 0; /* not an MMU fault */
     }
-    if (ret == 0) {
-        return 1; /* the MMU fault was handled without causing real CPU fault */
-    }
 
-    /* Now we have a real cpu fault.  Since this is the exact location of
-     * the exception, we must undo the adjustment done by cpu_restore_state
-     * for handling call return addresses.  */
-    cpu_restore_state(cpu, pc + GETPC_ADJ);
+    /* Now we have a real cpu fault.  */
+    cpu_restore_state(cpu, pc);
 
     sigprocmask(SIG_SETMASK, old_set, NULL);
     cpu_loop_exit(cpu);
@@ -585,11 +619,13 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     if (unlikely(addr & (size - 1))) {
         cpu_loop_exit_atomic(ENV_GET_CPU(env), retaddr);
     }
+    helper_retaddr = retaddr;
     return g2h(addr);
 }
 
 /* Macro to call the above, with local variables from the use context.  */
 #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
+#define ATOMIC_MMU_CLEANUP do { helper_retaddr = 0; } while (0)
 
 #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
 #define EXTRA_ARGS
-- 
2.13.6
