Received: from eggs.gnu.org ([2001:4830:134:3::10]:39669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMJA2-0003iQ-BK
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMJ9z-0000HC-Kc
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:50:18 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:54491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMJ9z-0000Em-0H
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:50:15 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Nov 2018 21:49:28 +0100
Message-Id: <20181112204929.12625-4-laurent@vivier.eu>
In-Reply-To: <20181112204929.12625-1-laurent@vivier.eu>
References: <20181112204929.12625-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/4] linux-user: Clean up nios2 main loop signal
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

The nios2 main loop code's code does some odd
things with gdb_handlesig() that no other target
CPU does: it has some signals that are delivered
to gdb and only to gdb. Stop doing this, and instead
behave like all the other targets:
 * a trap instruction becomes a SIGTRAP
 * an unhandled exception type returned from cpu_exec()
   causes us to abort(), not to try to hand gdb a SIGILL

This fixes in passing Coverity issue CID 1390853,
which was a complaint that the old code failed to
check the return value from gdb_handlesig().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20181019174958.26616-3-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[lv: removed gdbsig unused variable]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/nios2/cpu_loop.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
index dac7a06181..b96b1aa119 100644
--- a/linux-user/nios2/cpu_loop.c
+++ b/linux-user/nios2/cpu_loop.c
@@ -26,13 +26,12 @@ void cpu_loop(CPUNios2State *env)
     CPUState *cs = ENV_GET_CPU(env);
     Nios2CPU *cpu = NIOS2_CPU(cs);
     target_siginfo_t info;
-    int trapnr, gdbsig, ret;
+    int trapnr, ret;
 
     for (;;) {
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        gdbsig = 0;
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
@@ -68,7 +67,10 @@ void cpu_loop(CPUNios2State *env)
                 env->regs[R_EA] = env->regs[R_PC] + 4;
                 env->regs[R_PC] = cpu->exception_addr;
 
-                gdbsig = TARGET_SIGTRAP;
+                info.si_signo = TARGET_SIGTRAP;
+                info.si_errno = 0;
+                info.si_code = TARGET_TRAP_BRKPT;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
                 break;
             }
         case 0xaa:
@@ -106,14 +108,7 @@ kuser_fail:
         default:
             EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x - aborting\n",
                      trapnr);
-            gdbsig = TARGET_SIGILL;
-            break;
-        }
-        if (gdbsig) {
-            gdb_handlesig(cs, gdbsig);
-            if (gdbsig != TARGET_SIGTRAP) {
-                exit(EXIT_FAILURE);
-            }
+            abort();
         }
 
         process_pending_signals(env);
-- 
2.17.2
