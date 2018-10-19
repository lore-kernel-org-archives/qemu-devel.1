Received: from eggs.gnu.org ([2001:4830:134:3::10]:40693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDZ2c-0008Sm-4V
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDZ2b-0004QQ-8Y
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:58:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDZ2b-0004K9-15
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:58:29 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 18:49:58 +0100
Message-Id: <20181019174958.26616-3-peter.maydell@linaro.org>
In-Reply-To: <20181019174958.26616-1-peter.maydell@linaro.org>
References: <20181019174958.26616-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] linux-user: Clean up nios2 main loop
 signal handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

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
---
Disclaimer: compile tested, and the change makes conceptual
sense, but I have no nios2 test environment.
---
 linux-user/nios2/cpu_loop.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
index dac7a061813..973dd54d791 100644
--- a/linux-user/nios2/cpu_loop.c
+++ b/linux-user/nios2/cpu_loop.c
@@ -68,7 +68,10 @@ void cpu_loop(CPUNios2State *env)
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
@@ -106,14 +109,7 @@ kuser_fail:
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
2.19.1
