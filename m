Received: from eggs.gnu.org ([2001:4830:134:3::10]:58863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xc8-0003g1-FT
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xc4-0001li-Vg
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:17:04 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 26 Mar 2018 21:16:00 +0200
Message-Id: <20180326191603.10217-17-laurent@vivier.eu>
In-Reply-To: <20180326191603.10217-1-laurent@vivier.eu>
References: <20180326191603.10217-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 16/19] linux-user: move tilegx cpu
 loop to tilegx directory
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
tilegx/cpu_loop.c.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c            | 267 -------------------------------------------
 linux-user/tilegx/cpu_loop.c | 260 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 260 insertions(+), 267 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 9693383009..3b3613cb89 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,262 +149,6 @@ void fork_end(int child)
     }
 }
 
-#ifdef TARGET_TILEGX
-
-static void gen_sigill_reg(CPUTLGState *env)
-{
-    target_siginfo_t info;
-
-    info.si_signo = TARGET_SIGILL;
-    info.si_errno = 0;
-    info.si_code = TARGET_ILL_PRVREG;
-    info._sifields._sigfault._addr = env->pc;
-    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-}
-
-static void do_signal(CPUTLGState *env, int signo, int sigcode)
-{
-    target_siginfo_t info;
-
-    info.si_signo = signo;
-    info.si_errno = 0;
-    info._sifields._sigfault._addr = env->pc;
-
-    if (signo == TARGET_SIGSEGV) {
-        /* The passed in sigcode is a dummy; check for a page mapping
-           and pass either MAPERR or ACCERR.  */
-        target_ulong addr = env->excaddr;
-        info._sifields._sigfault._addr = addr;
-        if (page_check_range(addr, 1, PAGE_VALID) < 0) {
-            sigcode = TARGET_SEGV_MAPERR;
-        } else {
-            sigcode = TARGET_SEGV_ACCERR;
-        }
-    }
-    info.si_code = sigcode;
-
-    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-}
-
-static void gen_sigsegv_maperr(CPUTLGState *env, target_ulong addr)
-{
-    env->excaddr = addr;
-    do_signal(env, TARGET_SIGSEGV, 0);
-}
-
-static void set_regval(CPUTLGState *env, uint8_t reg, uint64_t val)
-{
-    if (unlikely(reg >= TILEGX_R_COUNT)) {
-        switch (reg) {
-        case TILEGX_R_SN:
-        case TILEGX_R_ZERO:
-            return;
-        case TILEGX_R_IDN0:
-        case TILEGX_R_IDN1:
-        case TILEGX_R_UDN0:
-        case TILEGX_R_UDN1:
-        case TILEGX_R_UDN2:
-        case TILEGX_R_UDN3:
-            gen_sigill_reg(env);
-            return;
-        default:
-            g_assert_not_reached();
-        }
-    }
-    env->regs[reg] = val;
-}
-
-/*
- * Compare the 8-byte contents of the CmpValue SPR with the 8-byte value in
- * memory at the address held in the first source register. If the values are
- * not equal, then no memory operation is performed. If the values are equal,
- * the 8-byte quantity from the second source register is written into memory
- * at the address held in the first source register. In either case, the result
- * of the instruction is the value read from memory. The compare and write to
- * memory are atomic and thus can be used for synchronization purposes. This
- * instruction only operates for addresses aligned to a 8-byte boundary.
- * Unaligned memory access causes an Unaligned Data Reference interrupt.
- *
- * Functional Description (64-bit)
- *       uint64_t memVal = memoryReadDoubleWord (rf[SrcA]);
- *       rf[Dest] = memVal;
- *       if (memVal == SPR[CmpValueSPR])
- *           memoryWriteDoubleWord (rf[SrcA], rf[SrcB]);
- *
- * Functional Description (32-bit)
- *       uint64_t memVal = signExtend32 (memoryReadWord (rf[SrcA]));
- *       rf[Dest] = memVal;
- *       if (memVal == signExtend32 (SPR[CmpValueSPR]))
- *           memoryWriteWord (rf[SrcA], rf[SrcB]);
- *
- *
- * This function also processes exch and exch4 which need not process SPR.
- */
-static void do_exch(CPUTLGState *env, bool quad, bool cmp)
-{
-    target_ulong addr;
-    target_long val, sprval;
-
-    start_exclusive();
-
-    addr = env->atomic_srca;
-    if (quad ? get_user_s64(val, addr) : get_user_s32(val, addr)) {
-        goto sigsegv_maperr;
-    }
-
-    if (cmp) {
-        if (quad) {
-            sprval = env->spregs[TILEGX_SPR_CMPEXCH];
-        } else {
-            sprval = sextract64(env->spregs[TILEGX_SPR_CMPEXCH], 0, 32);
-        }
-    }
-
-    if (!cmp || val == sprval) {
-        target_long valb = env->atomic_srcb;
-        if (quad ? put_user_u64(valb, addr) : put_user_u32(valb, addr)) {
-            goto sigsegv_maperr;
-        }
-    }
-
-    set_regval(env, env->atomic_dstr, val);
-    end_exclusive();
-    return;
-
- sigsegv_maperr:
-    end_exclusive();
-    gen_sigsegv_maperr(env, addr);
-}
-
-static void do_fetch(CPUTLGState *env, int trapnr, bool quad)
-{
-    int8_t write = 1;
-    target_ulong addr;
-    target_long val, valb;
-
-    start_exclusive();
-
-    addr = env->atomic_srca;
-    valb = env->atomic_srcb;
-    if (quad ? get_user_s64(val, addr) : get_user_s32(val, addr)) {
-        goto sigsegv_maperr;
-    }
-
-    switch (trapnr) {
-    case TILEGX_EXCP_OPCODE_FETCHADD:
-    case TILEGX_EXCP_OPCODE_FETCHADD4:
-        valb += val;
-        break;
-    case TILEGX_EXCP_OPCODE_FETCHADDGEZ:
-        valb += val;
-        if (valb < 0) {
-            write = 0;
-        }
-        break;
-    case TILEGX_EXCP_OPCODE_FETCHADDGEZ4:
-        valb += val;
-        if ((int32_t)valb < 0) {
-            write = 0;
-        }
-        break;
-    case TILEGX_EXCP_OPCODE_FETCHAND:
-    case TILEGX_EXCP_OPCODE_FETCHAND4:
-        valb &= val;
-        break;
-    case TILEGX_EXCP_OPCODE_FETCHOR:
-    case TILEGX_EXCP_OPCODE_FETCHOR4:
-        valb |= val;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (write) {
-        if (quad ? put_user_u64(valb, addr) : put_user_u32(valb, addr)) {
-            goto sigsegv_maperr;
-        }
-    }
-
-    set_regval(env, env->atomic_dstr, val);
-    end_exclusive();
-    return;
-
- sigsegv_maperr:
-    end_exclusive();
-    gen_sigsegv_maperr(env, addr);
-}
-
-void cpu_loop(CPUTLGState *env)
-{
-    CPUState *cs = CPU(tilegx_env_get_cpu(env));
-    int trapnr;
-
-    while (1) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
-        switch (trapnr) {
-        case TILEGX_EXCP_SYSCALL:
-        {
-            abi_ulong ret = do_syscall(env, env->regs[TILEGX_R_NR],
-                                       env->regs[0], env->regs[1],
-                                       env->regs[2], env->regs[3],
-                                       env->regs[4], env->regs[5],
-                                       env->regs[6], env->regs[7]);
-            if (ret == -TARGET_ERESTARTSYS) {
-                env->pc -= 8;
-            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                env->regs[TILEGX_R_RE] = ret;
-                env->regs[TILEGX_R_ERR] = TILEGX_IS_ERRNO(ret) ? -ret : 0;
-            }
-            break;
-        }
-        case TILEGX_EXCP_OPCODE_EXCH:
-            do_exch(env, true, false);
-            break;
-        case TILEGX_EXCP_OPCODE_EXCH4:
-            do_exch(env, false, false);
-            break;
-        case TILEGX_EXCP_OPCODE_CMPEXCH:
-            do_exch(env, true, true);
-            break;
-        case TILEGX_EXCP_OPCODE_CMPEXCH4:
-            do_exch(env, false, true);
-            break;
-        case TILEGX_EXCP_OPCODE_FETCHADD:
-        case TILEGX_EXCP_OPCODE_FETCHADDGEZ:
-        case TILEGX_EXCP_OPCODE_FETCHAND:
-        case TILEGX_EXCP_OPCODE_FETCHOR:
-            do_fetch(env, trapnr, true);
-            break;
-        case TILEGX_EXCP_OPCODE_FETCHADD4:
-        case TILEGX_EXCP_OPCODE_FETCHADDGEZ4:
-        case TILEGX_EXCP_OPCODE_FETCHAND4:
-        case TILEGX_EXCP_OPCODE_FETCHOR4:
-            do_fetch(env, trapnr, false);
-            break;
-        case TILEGX_EXCP_SIGNAL:
-            do_signal(env, env->signo, env->sigcode);
-            break;
-        case TILEGX_EXCP_REG_IDN_ACCESS:
-        case TILEGX_EXCP_REG_UDN_ACCESS:
-            gen_sigill_reg(env);
-            break;
-        case EXCP_ATOMIC:
-            cpu_exec_step_atomic(cs);
-            break;
-        default:
-            fprintf(stderr, "trapnr is %d[0x%x].\n", trapnr, trapnr);
-            g_assert_not_reached();
-        }
-        process_pending_signals(env);
-    }
-}
-
-#endif
-
 #ifdef TARGET_RISCV
 
 void cpu_loop(CPURISCVState *env)
@@ -1580,17 +1324,6 @@ int main(int argc, char **argv, char **envp)
         env->pc = regs->sepc;
         env->gpr[xSP] = regs->sp;
     }
-#elif defined(TARGET_TILEGX)
-    {
-        int i;
-        for (i = 0; i < TILEGX_R_COUNT; i++) {
-            env->regs[i] = regs->regs[i];
-        }
-        for (i = 0; i < TILEGX_SPR_COUNT; i++) {
-            env->spregs[i] = 0;
-        }
-        env->pc = regs->pc;
-    }
 #elif defined(TARGET_HPPA)
     {
         int i;
diff --git a/linux-user/tilegx/cpu_loop.c b/linux-user/tilegx/cpu_loop.c
index b7700a5561..4f39eb9ad3 100644
--- a/linux-user/tilegx/cpu_loop.c
+++ b/linux-user/tilegx/cpu_loop.c
@@ -21,6 +21,266 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+static void gen_sigill_reg(CPUTLGState *env)
+{
+    target_siginfo_t info;
+
+    info.si_signo = TARGET_SIGILL;
+    info.si_errno = 0;
+    info.si_code = TARGET_ILL_PRVREG;
+    info._sifields._sigfault._addr = env->pc;
+    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+}
+
+static void do_signal(CPUTLGState *env, int signo, int sigcode)
+{
+    target_siginfo_t info;
+
+    info.si_signo = signo;
+    info.si_errno = 0;
+    info._sifields._sigfault._addr = env->pc;
+
+    if (signo == TARGET_SIGSEGV) {
+        /* The passed in sigcode is a dummy; check for a page mapping
+           and pass either MAPERR or ACCERR.  */
+        target_ulong addr = env->excaddr;
+        info._sifields._sigfault._addr = addr;
+        if (page_check_range(addr, 1, PAGE_VALID) < 0) {
+            sigcode = TARGET_SEGV_MAPERR;
+        } else {
+            sigcode = TARGET_SEGV_ACCERR;
+        }
+    }
+    info.si_code = sigcode;
+
+    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+}
+
+static void gen_sigsegv_maperr(CPUTLGState *env, target_ulong addr)
+{
+    env->excaddr = addr;
+    do_signal(env, TARGET_SIGSEGV, 0);
+}
+
+static void set_regval(CPUTLGState *env, uint8_t reg, uint64_t val)
+{
+    if (unlikely(reg >= TILEGX_R_COUNT)) {
+        switch (reg) {
+        case TILEGX_R_SN:
+        case TILEGX_R_ZERO:
+            return;
+        case TILEGX_R_IDN0:
+        case TILEGX_R_IDN1:
+        case TILEGX_R_UDN0:
+        case TILEGX_R_UDN1:
+        case TILEGX_R_UDN2:
+        case TILEGX_R_UDN3:
+            gen_sigill_reg(env);
+            return;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    env->regs[reg] = val;
+}
+
+/*
+ * Compare the 8-byte contents of the CmpValue SPR with the 8-byte value in
+ * memory at the address held in the first source register. If the values are
+ * not equal, then no memory operation is performed. If the values are equal,
+ * the 8-byte quantity from the second source register is written into memory
+ * at the address held in the first source register. In either case, the result
+ * of the instruction is the value read from memory. The compare and write to
+ * memory are atomic and thus can be used for synchronization purposes. This
+ * instruction only operates for addresses aligned to a 8-byte boundary.
+ * Unaligned memory access causes an Unaligned Data Reference interrupt.
+ *
+ * Functional Description (64-bit)
+ *       uint64_t memVal = memoryReadDoubleWord (rf[SrcA]);
+ *       rf[Dest] = memVal;
+ *       if (memVal == SPR[CmpValueSPR])
+ *           memoryWriteDoubleWord (rf[SrcA], rf[SrcB]);
+ *
+ * Functional Description (32-bit)
+ *       uint64_t memVal = signExtend32 (memoryReadWord (rf[SrcA]));
+ *       rf[Dest] = memVal;
+ *       if (memVal == signExtend32 (SPR[CmpValueSPR]))
+ *           memoryWriteWord (rf[SrcA], rf[SrcB]);
+ *
+ *
+ * This function also processes exch and exch4 which need not process SPR.
+ */
+static void do_exch(CPUTLGState *env, bool quad, bool cmp)
+{
+    target_ulong addr;
+    target_long val, sprval;
+
+    start_exclusive();
+
+    addr = env->atomic_srca;
+    if (quad ? get_user_s64(val, addr) : get_user_s32(val, addr)) {
+        goto sigsegv_maperr;
+    }
+
+    if (cmp) {
+        if (quad) {
+            sprval = env->spregs[TILEGX_SPR_CMPEXCH];
+        } else {
+            sprval = sextract64(env->spregs[TILEGX_SPR_CMPEXCH], 0, 32);
+        }
+    }
+
+    if (!cmp || val == sprval) {
+        target_long valb = env->atomic_srcb;
+        if (quad ? put_user_u64(valb, addr) : put_user_u32(valb, addr)) {
+            goto sigsegv_maperr;
+        }
+    }
+
+    set_regval(env, env->atomic_dstr, val);
+    end_exclusive();
+    return;
+
+ sigsegv_maperr:
+    end_exclusive();
+    gen_sigsegv_maperr(env, addr);
+}
+
+static void do_fetch(CPUTLGState *env, int trapnr, bool quad)
+{
+    int8_t write = 1;
+    target_ulong addr;
+    target_long val, valb;
+
+    start_exclusive();
+
+    addr = env->atomic_srca;
+    valb = env->atomic_srcb;
+    if (quad ? get_user_s64(val, addr) : get_user_s32(val, addr)) {
+        goto sigsegv_maperr;
+    }
+
+    switch (trapnr) {
+    case TILEGX_EXCP_OPCODE_FETCHADD:
+    case TILEGX_EXCP_OPCODE_FETCHADD4:
+        valb += val;
+        break;
+    case TILEGX_EXCP_OPCODE_FETCHADDGEZ:
+        valb += val;
+        if (valb < 0) {
+            write = 0;
+        }
+        break;
+    case TILEGX_EXCP_OPCODE_FETCHADDGEZ4:
+        valb += val;
+        if ((int32_t)valb < 0) {
+            write = 0;
+        }
+        break;
+    case TILEGX_EXCP_OPCODE_FETCHAND:
+    case TILEGX_EXCP_OPCODE_FETCHAND4:
+        valb &= val;
+        break;
+    case TILEGX_EXCP_OPCODE_FETCHOR:
+    case TILEGX_EXCP_OPCODE_FETCHOR4:
+        valb |= val;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (write) {
+        if (quad ? put_user_u64(valb, addr) : put_user_u32(valb, addr)) {
+            goto sigsegv_maperr;
+        }
+    }
+
+    set_regval(env, env->atomic_dstr, val);
+    end_exclusive();
+    return;
+
+ sigsegv_maperr:
+    end_exclusive();
+    gen_sigsegv_maperr(env, addr);
+}
+
+void cpu_loop(CPUTLGState *env)
+{
+    CPUState *cs = CPU(tilegx_env_get_cpu(env));
+    int trapnr;
+
+    while (1) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        switch (trapnr) {
+        case TILEGX_EXCP_SYSCALL:
+        {
+            abi_ulong ret = do_syscall(env, env->regs[TILEGX_R_NR],
+                                       env->regs[0], env->regs[1],
+                                       env->regs[2], env->regs[3],
+                                       env->regs[4], env->regs[5],
+                                       env->regs[6], env->regs[7]);
+            if (ret == -TARGET_ERESTARTSYS) {
+                env->pc -= 8;
+            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+                env->regs[TILEGX_R_RE] = ret;
+                env->regs[TILEGX_R_ERR] = TILEGX_IS_ERRNO(ret) ? -ret : 0;
+            }
+            break;
+        }
+        case TILEGX_EXCP_OPCODE_EXCH:
+            do_exch(env, true, false);
+            break;
+        case TILEGX_EXCP_OPCODE_EXCH4:
+            do_exch(env, false, false);
+            break;
+        case TILEGX_EXCP_OPCODE_CMPEXCH:
+            do_exch(env, true, true);
+            break;
+        case TILEGX_EXCP_OPCODE_CMPEXCH4:
+            do_exch(env, false, true);
+            break;
+        case TILEGX_EXCP_OPCODE_FETCHADD:
+        case TILEGX_EXCP_OPCODE_FETCHADDGEZ:
+        case TILEGX_EXCP_OPCODE_FETCHAND:
+        case TILEGX_EXCP_OPCODE_FETCHOR:
+            do_fetch(env, trapnr, true);
+            break;
+        case TILEGX_EXCP_OPCODE_FETCHADD4:
+        case TILEGX_EXCP_OPCODE_FETCHADDGEZ4:
+        case TILEGX_EXCP_OPCODE_FETCHAND4:
+        case TILEGX_EXCP_OPCODE_FETCHOR4:
+            do_fetch(env, trapnr, false);
+            break;
+        case TILEGX_EXCP_SIGNAL:
+            do_signal(env, env->signo, env->sigcode);
+            break;
+        case TILEGX_EXCP_REG_IDN_ACCESS:
+        case TILEGX_EXCP_REG_UDN_ACCESS:
+            gen_sigill_reg(env);
+            break;
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            break;
+        default:
+            fprintf(stderr, "trapnr is %d[0x%x].\n", trapnr, trapnr);
+            g_assert_not_reached();
+        }
+        process_pending_signals(env);
+    }
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    int i;
+    for (i = 0; i < TILEGX_R_COUNT; i++) {
+        env->regs[i] = regs->regs[i];
+    }
+    for (i = 0; i < TILEGX_SPR_COUNT; i++) {
+        env->spregs[i] = 0;
+    }
+    env->pc = regs->pc;
 }
-- 
2.14.3
