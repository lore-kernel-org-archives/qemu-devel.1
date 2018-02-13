Received: from eggs.gnu.org ([2001:4830:134:3::10]:41859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1elaXz-00089L-JF
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1elaXy-0004PL-M3
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:22:59 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1elaXy-0004Jz-FU
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:22:58 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 13:22:46 +0000
Message-Id: <20180213132246.26844-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Remove THREAD macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Back when we used to support compiling either with or without
NPTL threading library support, we used a macro THREAD which would
expand either to nothing (no thread support) or to __thread (threads
supported). For a long time now we have required thread support,
so remove the macro and just use __thread directly as other parts
of QEMU do.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/qemu.h | 4 +---
 linux-user/main.c | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

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
-- 
2.16.1
