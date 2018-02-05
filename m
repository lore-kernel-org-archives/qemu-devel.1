Received: from eggs.gnu.org ([2001:4830:134:3::10]:44675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSE-0004P0-Sj
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSD-0004yq-ML
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:26 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSD-0004yE-D9
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:25 -0500
Received: by mail-wm0-x244.google.com with SMTP id b21so28072446wme.4
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:30 +0100
Message-Id: <1517858941-5538-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/47] Drop remaining bits of ia64 host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

We dropped support for ia64 host CPUs in the 2.11 release (removing
the TCG backend for it, and advertising the support as being
completely removed in the changelog).  However there are a few bits
and pieces of code still floating about.  Remove those, too.

We can drop the check in configure for "ia64 or hppa host?"
entirely, because we don't support hppa hosts either any more.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1516897189-11035-1-git-send-email-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/user-exec.c    | 33 ---------------------------------
 configure                |  5 -----
 include/qemu/processor.h |  3 ---
 include/qemu/timer.h     |  9 ---------
 linux-user/syscall.c     |  7 +------
 5 files changed, 1 insertion(+), 56 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index a0a4a19..7789958 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -503,39 +503,6 @@ int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
-#elif defined(__ia64)
-
-#ifndef __ISR_VALID
-  /* This ought to be in <bits/siginfo.h>... */
-# define __ISR_VALID    1
-#endif
-
-int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
-{
-    siginfo_t *info = pinfo;
-    ucontext_t *uc = puc;
-    unsigned long ip;
-    int is_write = 0;
-
-    ip = uc->uc_mcontext.sc_ip;
-    switch (host_signum) {
-    case SIGILL:
-    case SIGFPE:
-    case SIGSEGV:
-    case SIGBUS:
-    case SIGTRAP:
-        if (info->si_code && (info->si_segvflags & __ISR_VALID)) {
-            /* ISR.W (write-access) is bit 33:  */
-            is_write = (info->si_isr >> 33) & 1;
-        }
-        break;
-
-    default:
-        break;
-    }
-    return handle_cpu_signal(ip, info, is_write, (sigset_t *)&uc->uc_sigmask);
-}
-
 #elif defined(__s390__)
 
 int cpu_signal_handler(int host_signum, void *pinfo,
diff --git a/configure b/configure
index 302fdc9..bdbd097 100755
--- a/configure
+++ b/configure
@@ -636,8 +636,6 @@ elif check_define _ARCH_PPC ; then
   fi
 elif check_define __mips__ ; then
   cpu="mips"
-elif check_define __ia64__ ; then
-  cpu="ia64"
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
     cpu="s390x"
@@ -4744,9 +4742,6 @@ if test "$coroutine_pool" = ""; then
 fi
 
 if test "$debug_stack_usage" = "yes"; then
-  if test "$cpu" = "ia64" -o "$cpu" = "hppa"; then
-    error_exit "stack usage debugging is not supported for $cpu"
-  fi
   if test "$coroutine_pool" = "yes"; then
     echo "WARN: disabling coroutine pool for stack usage debugging"
     coroutine_pool=no
diff --git a/include/qemu/processor.h b/include/qemu/processor.h
index 8b25702..8e16c92 100644
--- a/include/qemu/processor.h
+++ b/include/qemu/processor.h
@@ -12,9 +12,6 @@
 #if defined(__i386__) || defined(__x86_64__)
 # define cpu_relax() asm volatile("rep; nop" ::: "memory")
 
-#elif defined(__ia64__)
-# define cpu_relax() asm volatile("hint @pause" ::: "memory")
-
 #elif defined(__aarch64__)
 # define cpu_relax() asm volatile("yield" ::: "memory")
 
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 1b518bc..3b5a54b 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -931,15 +931,6 @@ static inline int64_t cpu_get_host_ticks(void)
     return val;
 }
 
-#elif defined(__ia64)
-
-static inline int64_t cpu_get_host_ticks(void)
-{
-    int64_t val;
-    asm volatile ("mov %0 = ar.itc" : "=r"(val) :: "memory");
-    return val;
-}
-
 #elif defined(__s390__)
 
 static inline int64_t cpu_get_host_ticks(void)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7437894..df1edf0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -36,10 +36,6 @@
 #include <linux/capability.h>
 #include <sched.h>
 #include <sys/timex.h>
-#ifdef __ia64__
-int __clone2(int (*fn)(void *), void *child_stack_base,
-             size_t stack_size, int flags, void *arg, ...);
-#endif
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/uio.h>
@@ -246,8 +242,7 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
 #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
 
-#if defined(__alpha__) || defined (__ia64__) || defined(__x86_64__) || \
-    defined(__s390x__)
+#if defined(__alpha__) || defined(__x86_64__) || defined(__s390x__)
 #define __NR__llseek __NR_lseek
 #endif
 
-- 
1.8.3.1
