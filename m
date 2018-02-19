Received: from eggs.gnu.org ([2001:4830:134:3::10]:53662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1enoxs-0004ty-0V
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1enoxo-0005RW-GV
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:10:55 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:53607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1enoxo-0005Qa-5v
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:10:52 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 19 Feb 2018 18:10:33 +0100
Message-Id: <20180219171037.24539-5-laurent@vivier.eu>
In-Reply-To: <20180219171037.24539-1-laurent@vivier.eu>
References: <20180219171037.24539-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 4/8] linux-user: Remove THREAD macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <peter.maydell@linaro.org>

Back when we used to support compiling either with or without
NPTL threading library support, we used a macro THREAD which would
expand either to nothing (no thread support) or to __thread (threads
supported). For a long time now we have required thread support,
so remove the macro and just use __thread directly as other parts
of QEMU do.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180213132246.26844-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 2 +-
 linux-user/qemu.h | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 7de0e02487..fd7900628b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -3835,7 +3835,7 @@ void cpu_loop(CPUHPPAState *env)
 
 #endif /* TARGET_HPPA */
 
-THREAD CPUState *thread_cpu;
+__thread CPUState *thread_cpu;
 
 bool qemu_cpu_is_self(CPUState *cpu)
 {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4edd7d0c08..bc4bf35036 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -18,8 +18,6 @@
 #include "exec/gdbstub.h"
 #include "qemu/queue.h"
 
-#define THREAD __thread
-
 /* This is the size of the host kernel's sigset_t, needed where we make
  * direct system calls that take a sigset_t pointer and a size.
  */
@@ -201,7 +199,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8);
 void gemu_log(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
-extern THREAD CPUState *thread_cpu;
+extern __thread CPUState *thread_cpu;
 void cpu_loop(CPUArchState *env);
 const char *target_strerror(int err);
 int get_osversion(void);
-- 
2.14.3
