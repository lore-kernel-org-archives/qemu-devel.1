Received: from eggs.gnu.org ([2001:4830:134:3::10]:39912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kirkseraph@gmail.com>) id 1cO1yf-0003gh-TZ
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 07:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kirkseraph@gmail.com>) id 1cO1yc-0000LM-Rl
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 07:44:37 -0500
From: Seraphime Kirkovski <kirkseraph@gmail.com>
Date: Mon,  2 Jan 2017 13:44:24 +0100
Message-Id: <20170102124424.1031-1-kirkseraph@gmail.com>
Subject: [Qemu-devel] [RESEND PATCH] target-arm/abi32: check for segfault in
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
Cc: qemu-arm@nongnu.org, riku.voipio@iki.fi, Seraphime Kirkovski <kirkseraph@gmail.com>

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
 linux-user/main.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 75b199f..376b0c3 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -503,6 +503,7 @@ do_kernel_trap(CPUARMState *env)
     uint32_t addr;
     uint32_t cpsr;
     uint32_t val;
+    target_siginfo_t info;
 
     switch (env->regs[15]) {
     case 0xffff0fa0: /* __kernel_memory_barrier */
@@ -516,13 +517,16 @@ do_kernel_trap(CPUARMState *env)
         start_exclusive();
         cpsr = cpsr_read(env);
         addr = env->regs[2];
-        /* FIXME: This should SEGV if the access fails.  */
-        if (get_user_u32(val, addr))
-            val = ~env->regs[0];
+        if (get_user_u32(val, addr)) {
+            env->exception.vaddress = addr;
+            goto segv;
+        }
         if (val == env->regs[0]) {
             val = env->regs[1];
-            /* FIXME: Check for segfaults.  */
-            put_user_u32(val, addr);
+            if (put_user_u32(val, addr)) {
+                env->exception.vaddress = addr;
+                goto segv;
+            }
             env->regs[0] = 0;
             cpsr |= CPSR_C;
         } else {
@@ -551,6 +555,16 @@ do_kernel_trap(CPUARMState *env)
     env->regs[15] = addr;
 
     return 0;
+
+segv:
+    end_exclusive();
+    info.si_signo = TARGET_SIGSEGV;
+    info.si_errno = 0;
+    /* XXX: check env->error_code */
+    info.si_code = TARGET_SEGV_MAPERR;
+    info._sifields._sigfault._addr = env->exception.vaddress;
+    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+    return 0;
 }
 
 void cpu_loop(CPUARMState *env)
-- 
2.10.2
