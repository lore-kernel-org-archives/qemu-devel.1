Received: from eggs.gnu.org ([2001:4830:134:3::10]:49705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYir-0006Fl-TF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYir-0004et-6C
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:57 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYir-0004ek-1u
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:57 -0400
Received: by mail-qk0-x244.google.com with SMTP id u126so2855396qka.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:03:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:34 -1000
Message-Id: <20170718200255.31647-10-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 09/30] linux-user/sh4: Clean env->flags on
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
Cc: aurelien@aurel32.net

If a signal is delivered during the execution of a delay slot,
or a gUSA region, clear those bits from the environment so that
the signal handler does not start in that same state.

Cleaning the bits on signal return is paranoid good sense.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 27867a4..426e330 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3549,6 +3549,7 @@ static void restore_sigcontext(CPUSH4State *regs, struct target_sigcontext *sc)
     __get_user(regs->fpul, &sc->sc_fpul);
 
     regs->tra = -1;         /* disable syscall checks */
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
 }
 
 static void setup_frame(int sig, struct target_sigaction *ka,
@@ -3593,6 +3594,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     regs->gregs[6] = frame_addr += offsetof(typeof(*frame), sc);
     regs->pc = (unsigned long) ka->_sa_handler;
     regs->lock_addr = -1;
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
 
     unlock_user_struct(frame, frame_addr, 1);
     return;
@@ -3656,6 +3658,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     regs->gregs[6] = frame_addr + offsetof(typeof(*frame), uc);
     regs->pc = (unsigned long) ka->_sa_handler;
     regs->lock_addr = -1;
+    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
 
     unlock_user_struct(frame, frame_addr, 1);
     return;
-- 
2.9.4
