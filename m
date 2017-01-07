Received: from eggs.gnu.org ([2001:4830:134:3::10]:36925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kirkseraph@gmail.com>) id 1cPqDq-0007gI-Hg
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 07:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kirkseraph@gmail.com>) id 1cPqDm-00056g-Jo
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 07:35:46 -0500
From: Seraphime Kirkovski <kirkseraph@gmail.com>
Date: Sat,  7 Jan 2017 13:35:31 +0100
Message-Id: <20170107123531.5994-1-kirkseraph@gmail.com>
Subject: [Qemu-devel] [PATCH] target-arm/abi32: check for segfault in
 do_kernel_trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, riku.voipio@iki.fi, Seraphime Kirkovski <kirkseraph@gmail.com>

Currently, the cmpxchg implementation tests whether the destination address
is readable:
  - if it is, we read the value and continue with the comparison
  - if isn't, i.e. access to addr would segfault, we assume that src != dest
    rather than queuing a SIGSEGV.

The same problem exists in the case where src == dest: the code doesn't
check whether put_user_u32 succeeds.

This fixes both problems by sending a SIGSEGV when the destination address
is inaccessible.

Signed-off-by: Seraphime Kirkovski <kirkseraph@gmail.com>
---

> As the patchew robot notes, our coding style wants braces on all
> if() statements, even one-line ones. Other than that,
>
>  Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

This fixes the missing brackets.

 linux-user/main.c | 74 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index c1d5eb4d6f..1a32f2da7d 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -441,7 +441,7 @@ static void arm_kernel_cmpxchg64_helper(CPUARMState *env)
     uint32_t addr, cpsr;
     target_siginfo_t info;
 
-    /* Based on the 32 bit code in do_kernel_trap */
+    /* Based on the 32 bit code in arm_kernel_cmpxchg_helper */
 
     /* XXX: This only works between threads, not between processes.
        It's probably possible to implement this with native host
@@ -496,41 +496,65 @@ segv:
     queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
 }
 
+/*
+ * 32bit cmpxchg kernel user helper.
+ * See the note above arm_kernel_cmpxchg64_helper.
+ */
+static void arm_kernel_cmpxchg_helper(CPUARMState *env)
+{
+    uint32_t addr;
+    uint32_t cpsr;
+    uint32_t val;
+    target_siginfo_t info;
+
+    /* XXX: This only works between threads, not between processes.
+       It's probably possible to implement this with native host
+       operations. However things like ldrex/strex are much harder so
+       there's not much point trying.  */
+    start_exclusive();
+    cpsr = cpsr_read(env);
+    addr = env->regs[2];
+    if (get_user_u32(val, addr)) {
+        goto segv;
+    }
+    if (val == env->regs[0]) {
+        val = env->regs[1];
+        if (put_user_u32(val, addr)) {
+            goto segv;
+        }
+        env->regs[0] = 0;
+        cpsr |= CPSR_C;
+    } else {
+        env->regs[0] = -1;
+        cpsr &= ~CPSR_C;
+    }
+    cpsr_write(env, cpsr, CPSR_C, CPSRWriteByInstr);
+    end_exclusive();
+    return;
+
+segv:
+    end_exclusive();
+    env->exception.vaddress = addr;
+    info.si_signo = TARGET_SIGSEGV;
+    info.si_errno = 0;
+    /* XXX: check env->error_code */
+    info.si_code = TARGET_SEGV_MAPERR;
+    info._sifields._sigfault._addr = env->exception.vaddress;
+    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+}
+
 /* Handle a jump to the kernel code page.  */
 static int
 do_kernel_trap(CPUARMState *env)
 {
     uint32_t addr;
-    uint32_t cpsr;
-    uint32_t val;
 
     switch (env->regs[15]) {
     case 0xffff0fa0: /* __kernel_memory_barrier */
         /* ??? No-op. Will need to do better for SMP.  */
         break;
     case 0xffff0fc0: /* __kernel_cmpxchg */
-         /* XXX: This only works between threads, not between processes.
-            It's probably possible to implement this with native host
-            operations. However things like ldrex/strex are much harder so
-            there's not much point trying.  */
-        start_exclusive();
-        cpsr = cpsr_read(env);
-        addr = env->regs[2];
-        /* FIXME: This should SEGV if the access fails.  */
-        if (get_user_u32(val, addr))
-            val = ~env->regs[0];
-        if (val == env->regs[0]) {
-            val = env->regs[1];
-            /* FIXME: Check for segfaults.  */
-            put_user_u32(val, addr);
-            env->regs[0] = 0;
-            cpsr |= CPSR_C;
-        } else {
-            env->regs[0] = -1;
-            cpsr &= ~CPSR_C;
-        }
-        cpsr_write(env, cpsr, CPSR_C, CPSRWriteByInstr);
-        end_exclusive();
+        arm_kernel_cmpxchg_helper(env);
         break;
     case 0xffff0fe0: /* __kernel_get_tls */
         env->regs[0] = cpu_get_tls(env);
-- 
2.11.0
