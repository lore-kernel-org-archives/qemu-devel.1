Received: from eggs.gnu.org ([2001:4830:134:3::10]:34436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIvC-0001om-I0
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIv9-00007x-Dq
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:23:06 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIv9-00007e-A4
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:23:03 -0400
Received: by mail-qt0-x241.google.com with SMTP id v31so2713950qtb.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:23:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:53 -1000
Message-Id: <20170707022111.21836-10-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 09/27] linux-user/sh4: Clean env->flags on
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
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

If a signal is delivered during the execution of a delay slot,
or a gUSA region, clear those bits from the environment so that
the signal handler does not start in that same state.

Cleaning the bits on signal return is paranoid good sense.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index a537778..8c0b851 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3544,6 +3544,7 @@ static void restore_sigcontext(CPUSH4State *regs, struct target_sigcontext *sc)
     __get_user(regs->fpul, &sc->sc_fpul);
 
     regs->tra = -1;         /* disable syscall checks */
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
 }
 
 static void setup_frame(int sig, struct target_sigaction *ka,
@@ -3587,6 +3588,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     regs->gregs[5] = 0;
     regs->gregs[6] = frame_addr += offsetof(typeof(*frame), sc);
     regs->pc = (unsigned long) ka->_sa_handler;
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
 
     unlock_user_struct(frame, frame_addr, 1);
     return;
@@ -3649,6 +3651,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     regs->gregs[5] = frame_addr + offsetof(typeof(*frame), info);
     regs->gregs[6] = frame_addr + offsetof(typeof(*frame), uc);
     regs->pc = (unsigned long) ka->_sa_handler;
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
 
     unlock_user_struct(frame, frame_addr, 1);
     return;
-- 
2.9.4
