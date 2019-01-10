Received: from eggs.gnu.org ([209.51.188.92]:56172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZI2-0004nh-3S
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHu-0007nY-I2
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:22 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghZHo-0007kU-6W
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:13 -0500
Received: by mail-pl1-x641.google.com with SMTP id 101so5114634pld.6
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 04:18:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Jan 2019 23:17:35 +1100
Message-Id: <20190110121736.23448-11-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-1-richard.henderson@linaro.org>
References: <20190110121736.23448-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/11] linux-user/aarch64: Reset btype for
 signal handlers
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

It does not make sense for a SIGILL handler to enter with the
btype set as for the indirect branch that caused the SIGILL.

Nor does it make sense to return from a handler with BTYPE set.
This could be argued to be the handler's job, setting BTYPE
within ucontext->uc_mcontext.pstate, but handling this here
while the ABI is undiscussed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index f84a9cf28a..1fb229e696 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -218,6 +218,8 @@ static void target_restore_general_frame(CPUARMState *env,
     __get_user(env->pc, &sf->uc.tuc_mcontext.pc);
     __get_user(pstate, &sf->uc.tuc_mcontext.pstate);
     pstate_write(env, pstate);
+    /* Reset btype that might have been there going into the frame.  */
+    env->btype = 0;
 }
 
 static void target_restore_fpsimd_record(CPUARMState *env,
@@ -510,6 +512,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     env->xregs[29] = frame_addr + fr_ofs;
     env->pc = ka->_sa_handler;
     env->xregs[30] = return_addr;
+    /* Reset btype going into the signal handler.  */
+    env->btype = 0;
     if (info) {
         tswap_siginfo(&frame->info, info);
         env->xregs[1] = frame_addr + offsetof(struct target_rt_sigframe, info);
-- 
2.17.2
