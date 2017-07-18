Received: from eggs.gnu.org ([2001:4830:134:3::10]:48613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPl-0005jl-Jp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-00040p-I0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:21 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003V1-2l
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:32 +0200
Message-Id: <20170718215050.3812-14-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 13/31] linux-user/sh4: Clean env->flags on
 signal boundaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Richard Henderson <rth@twiddle.net>

If a signal is delivered during the execution of a delay slot,
or a gUSA region, clear those bits from the environment so that
the signal handler does not start in that same state.

Cleaning the bits on signal return is paranoid good sense.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-10-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 linux-user/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index c8b0733a7c..d68bd26013 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3549,6 +3549,7 @@ static void restore_sigcontext(CPUSH4State *regs, struct target_sigcontext *sc)
     __get_user(regs->fpul, &sc->sc_fpul);
 
     regs->tra = -1;         /* disable syscall checks */
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
 }
 
 static void setup_frame(int sig, struct target_sigaction *ka,
@@ -3592,6 +3593,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     regs->gregs[5] = 0;
     regs->gregs[6] = frame_addr += offsetof(typeof(*frame), sc);
     regs->pc = (unsigned long) ka->_sa_handler;
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
 
     unlock_user_struct(frame, frame_addr, 1);
     return;
@@ -3654,6 +3656,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     regs->gregs[5] = frame_addr + offsetof(typeof(*frame), info);
     regs->gregs[6] = frame_addr + offsetof(typeof(*frame), uc);
     regs->pc = (unsigned long) ka->_sa_handler;
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
 
     unlock_user_struct(frame, frame_addr, 1);
     return;
-- 
2.11.0
