Received: from eggs.gnu.org ([2001:4830:134:3::10]:55803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkEaL-0000Ro-QA
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkEaH-00021J-Ql
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:16:05 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:42124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkEaH-00020y-M0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:16:01 -0400
Received: by mail-ua0-x243.google.com with SMTP id w7-v6so8734497uan.9
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 13:16:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 30 Jul 2018 16:15:50 -0400
Message-Id: <20180730201553.32423-2-richard.henderson@linaro.org>
In-Reply-To: <20180730201553.32423-1-richard.henderson@linaro.org>
References: <20180730201553.32423-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] linux-user: Disallow setting newsp for fork
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com

Or really, just clone devolving into fork.  This should not ever happen
in practice.  We do want to reserve calling cpu_clone_regs for the case
in which we are actually performing a clone.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dfc851cc35..5bf8d13de7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6502,10 +6502,14 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         pthread_mutex_destroy(&info.mutex);
         pthread_mutex_unlock(&clone_lock);
     } else {
-        /* if no CLONE_VM, we consider it is a fork */
+        /* If no CLONE_VM, we consider it is a fork.  */
         if (flags & CLONE_INVALID_FORK_FLAGS) {
             return -TARGET_EINVAL;
         }
+        /* As a fork, setting a new sp does not make sense.  */
+        if (newsp) {
+            return -TARGET_EINVAL;
+        }
 
         /* We can't support custom termination signals */
         if ((flags & CSIGNAL) != TARGET_SIGCHLD) {
@@ -6520,7 +6524,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ret = fork();
         if (ret == 0) {
             /* Child Process.  */
-            cpu_clone_regs(env, newsp);
             fork_end(1);
             /* There is a race condition here.  The parent process could
                theoretically read the TID in the child process before the child
-- 
2.17.1
