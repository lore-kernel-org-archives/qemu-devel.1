Received: from eggs.gnu.org ([2001:4830:134:3::10]:38113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVv-0004MG-A0
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVt-0000YU-MR
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:35 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fNkVt-0000Xs-9C
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:33 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 29 May 2018 21:42:03 +0200
Message-Id: <20180529194207.31503-12-laurent@vivier.eu>
In-Reply-To: <20180529194207.31503-1-laurent@vivier.eu>
References: <20180529194207.31503-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 11/15] linux-user: move mips signal definitions
 to mips/target_signal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

No code change.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/target_signal.h   | 50 ++++++++++++++++++++++++++++++++++
 linux-user/mips64/target_signal.h | 49 ++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h         | 56 +--------------------------------------
 3 files changed, 100 insertions(+), 55 deletions(-)

diff --git a/linux-user/mips/target_signal.h b/linux-user/mips/target_signal.h
index 5f68bd7634..66e1ad44a6 100644
--- a/linux-user/mips/target_signal.h
+++ b/linux-user/mips/target_signal.h
@@ -1,6 +1,47 @@
 #ifndef MIPS_TARGET_SIGNAL_H
 #define MIPS_TARGET_SIGNAL_H
 
+#define TARGET_SIGHUP            1      /* Hangup (POSIX).  */
+#define TARGET_SIGINT            2      /* Interrupt (ANSI).  */
+#define TARGET_SIGQUIT           3      /* Quit (POSIX).  */
+#define TARGET_SIGILL            4      /* Illegal instruction (ANSI).  */
+#define TARGET_SIGTRAP           5      /* Trace trap (POSIX).  */
+#define TARGET_SIGIOT            6      /* IOT trap (4.2 BSD).  */
+#define TARGET_SIGABRT           TARGET_SIGIOT  /* Abort (ANSI).  */
+#define TARGET_SIGEMT            7
+#define TARGET_SIGSTKFLT         7 /* XXX: incorrect */
+#define TARGET_SIGFPE            8      /* Floating-point exception (ANSI).  */
+#define TARGET_SIGKILL           9      /* Kill, unblockable (POSIX).  */
+#define TARGET_SIGBUS           10      /* BUS error (4.2 BSD).  */
+#define TARGET_SIGSEGV          11      /* Segmentation violation (ANSI).  */
+#define TARGET_SIGSYS           12
+#define TARGET_SIGPIPE          13      /* Broken pipe (POSIX).  */
+#define TARGET_SIGALRM          14      /* Alarm clock (POSIX).  */
+#define TARGET_SIGTERM          15      /* Termination (ANSI).  */
+#define TARGET_SIGUSR1          16      /* User-defined signal 1 (POSIX).  */
+#define TARGET_SIGUSR2          17      /* User-defined signal 2 (POSIX).  */
+#define TARGET_SIGCHLD          18      /* Child status has changed (POSIX).  */
+#define TARGET_SIGCLD           TARGET_SIGCHLD  /* Same as TARGET_SIGCHLD (System V).  */
+#define TARGET_SIGPWR           19      /* Power failure restart (System V).  */
+#define TARGET_SIGWINCH 20      /* Window size change (4.3 BSD, Sun).  */
+#define TARGET_SIGURG           21      /* Urgent condition on socket (4.2 BSD).  */
+#define TARGET_SIGIO            22      /* I/O now possible (4.2 BSD).  */
+#define TARGET_SIGPOLL          TARGET_SIGIO    /* Pollable event occurred (System V).  */
+#define TARGET_SIGSTOP          23      /* Stop, unblockable (POSIX).  */
+#define TARGET_SIGTSTP          24      /* Keyboard stop (POSIX).  */
+#define TARGET_SIGCONT          25      /* Continue (POSIX).  */
+#define TARGET_SIGTTIN          26      /* Background read from tty (POSIX).  */
+#define TARGET_SIGTTOU          27      /* Background write to tty (POSIX).  */
+#define TARGET_SIGVTALRM        28      /* Virtual alarm clock (4.2 BSD).  */
+#define TARGET_SIGPROF          29      /* Profiling alarm clock (4.2 BSD).  */
+#define TARGET_SIGXCPU          30      /* CPU limit exceeded (4.2 BSD).  */
+#define TARGET_SIGXFSZ          31      /* File size limit exceeded (4.2 BSD).  */
+#define TARGET_SIGRTMIN         32
+
+#define TARGET_SIG_BLOCK        1       /* for blocking signals */
+#define TARGET_SIG_UNBLOCK      2       /* for unblocking signals */
+#define TARGET_SIG_SETMASK      3       /* for setting the signal mask */
+
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -16,6 +57,15 @@ typedef struct target_sigaltstack {
 #define TARGET_SS_ONSTACK     1
 #define TARGET_SS_DISABLE     2
 
+#define TARGET_SA_NOCLDSTOP     0x00000001
+#define TARGET_SA_NOCLDWAIT     0x00010000
+#define TARGET_SA_SIGINFO       0x00000008
+#define TARGET_SA_ONSTACK       0x08000000
+#define TARGET_SA_NODEFER       0x40000000
+#define TARGET_SA_RESTART       0x10000000
+#define TARGET_SA_RESETHAND     0x80000000
+#define TARGET_SA_RESTORER      0x04000000      /* Only for O32 */
+
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
diff --git a/linux-user/mips64/target_signal.h b/linux-user/mips64/target_signal.h
index 7fe6b2f517..753e91fbd6 100644
--- a/linux-user/mips64/target_signal.h
+++ b/linux-user/mips64/target_signal.h
@@ -1,6 +1,47 @@
 #ifndef MIPS64_TARGET_SIGNAL_H
 #define MIPS64_TARGET_SIGNAL_H
 
+#define TARGET_SIGHUP            1      /* Hangup (POSIX).  */
+#define TARGET_SIGINT            2      /* Interrupt (ANSI).  */
+#define TARGET_SIGQUIT           3      /* Quit (POSIX).  */
+#define TARGET_SIGILL            4      /* Illegal instruction (ANSI).  */
+#define TARGET_SIGTRAP           5      /* Trace trap (POSIX).  */
+#define TARGET_SIGIOT            6      /* IOT trap (4.2 BSD).  */
+#define TARGET_SIGABRT           TARGET_SIGIOT  /* Abort (ANSI).  */
+#define TARGET_SIGEMT            7
+#define TARGET_SIGSTKFLT         7 /* XXX: incorrect */
+#define TARGET_SIGFPE            8      /* Floating-point exception (ANSI).  */
+#define TARGET_SIGKILL           9      /* Kill, unblockable (POSIX).  */
+#define TARGET_SIGBUS           10      /* BUS error (4.2 BSD).  */
+#define TARGET_SIGSEGV          11      /* Segmentation violation (ANSI).  */
+#define TARGET_SIGSYS           12
+#define TARGET_SIGPIPE          13      /* Broken pipe (POSIX).  */
+#define TARGET_SIGALRM          14      /* Alarm clock (POSIX).  */
+#define TARGET_SIGTERM          15      /* Termination (ANSI).  */
+#define TARGET_SIGUSR1          16      /* User-defined signal 1 (POSIX).  */
+#define TARGET_SIGUSR2          17      /* User-defined signal 2 (POSIX).  */
+#define TARGET_SIGCHLD          18      /* Child status has changed (POSIX).  */
+#define TARGET_SIGCLD           TARGET_SIGCHLD  /* Same as TARGET_SIGCHLD (System V).  */
+#define TARGET_SIGPWR           19      /* Power failure restart (System V).  */
+#define TARGET_SIGWINCH 20      /* Window size change (4.3 BSD, Sun).  */
+#define TARGET_SIGURG           21      /* Urgent condition on socket (4.2 BSD).  */
+#define TARGET_SIGIO            22      /* I/O now possible (4.2 BSD).  */
+#define TARGET_SIGPOLL          TARGET_SIGIO    /* Pollable event occurred (System V).  */
+#define TARGET_SIGSTOP          23      /* Stop, unblockable (POSIX).  */
+#define TARGET_SIGTSTP          24      /* Keyboard stop (POSIX).  */
+#define TARGET_SIGCONT          25      /* Continue (POSIX).  */
+#define TARGET_SIGTTIN          26      /* Background read from tty (POSIX).  */
+#define TARGET_SIGTTOU          27      /* Background write to tty (POSIX).  */
+#define TARGET_SIGVTALRM        28      /* Virtual alarm clock (4.2 BSD).  */
+#define TARGET_SIGPROF          29      /* Profiling alarm clock (4.2 BSD).  */
+#define TARGET_SIGXCPU          30      /* CPU limit exceeded (4.2 BSD).  */
+#define TARGET_SIGXFSZ          31      /* File size limit exceeded (4.2 BSD).  */
+#define TARGET_SIGRTMIN         32
+
+#define TARGET_SIG_BLOCK        1       /* for blocking signals */
+#define TARGET_SIG_UNBLOCK      2       /* for unblocking signals */
+#define TARGET_SIG_SETMASK      3       /* for setting the signal mask */
+
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -16,6 +57,14 @@ typedef struct target_sigaltstack {
 #define TARGET_SS_ONSTACK     1
 #define TARGET_SS_DISABLE     2
 
+#define TARGET_SA_NOCLDSTOP     0x00000001
+#define TARGET_SA_NOCLDWAIT     0x00010000
+#define TARGET_SA_SIGINFO       0x00000008
+#define TARGET_SA_ONSTACK       0x08000000
+#define TARGET_SA_NODEFER       0x40000000
+#define TARGET_SA_RESTART       0x10000000
+#define TARGET_SA_RESETHAND     0x80000000
+
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0034156c6b..21d3ef5559 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -426,18 +426,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     || defined(TARGET_TILEGX) || defined(TARGET_HPPA) || defined(TARGET_NIOS2) \
     || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
 
-#if defined(TARGET_MIPS)
-#define TARGET_SA_NOCLDSTOP	0x00000001
-#define TARGET_SA_NOCLDWAIT	0x00010000
-#define TARGET_SA_SIGINFO	0x00000008
-#define TARGET_SA_ONSTACK	0x08000000
-#define TARGET_SA_NODEFER	0x40000000
-#define TARGET_SA_RESTART	0x10000000
-#define TARGET_SA_RESETHAND	0x80000000
-#if !defined(TARGET_ABI_MIPSN32) && !defined(TARGET_ABI_MIPSN64)
-#define TARGET_SA_RESTORER	0x04000000	/* Only for O32 */
-#endif
-#elif defined(TARGET_OPENRISC)
+#if defined(TARGET_OPENRISC)
 #define TARGET_SA_NOCLDSTOP    0x00000001
 #define TARGET_SA_NOCLDWAIT    0x00000002
 #define TARGET_SA_SIGINFO      0x00000004
@@ -508,49 +497,6 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_SIG_UNBLOCK       2
 #define TARGET_SIG_SETMASK       3
 
-#elif defined(TARGET_MIPS)
-
-#define TARGET_SIGHUP		 1	/* Hangup (POSIX).  */
-#define TARGET_SIGINT		 2	/* Interrupt (ANSI).  */
-#define TARGET_SIGQUIT		 3	/* Quit (POSIX).  */
-#define TARGET_SIGILL		 4	/* Illegal instruction (ANSI).  */
-#define TARGET_SIGTRAP		 5	/* Trace trap (POSIX).  */
-#define TARGET_SIGIOT		 6	/* IOT trap (4.2 BSD).  */
-#define TARGET_SIGABRT		 TARGET_SIGIOT	/* Abort (ANSI).  */
-#define TARGET_SIGEMT		 7
-#define TARGET_SIGSTKFLT	 7 /* XXX: incorrect */
-#define TARGET_SIGFPE		 8	/* Floating-point exception (ANSI).  */
-#define TARGET_SIGKILL		 9	/* Kill, unblockable (POSIX).  */
-#define TARGET_SIGBUS		10	/* BUS error (4.2 BSD).  */
-#define TARGET_SIGSEGV		11	/* Segmentation violation (ANSI).  */
-#define TARGET_SIGSYS		12
-#define TARGET_SIGPIPE		13	/* Broken pipe (POSIX).  */
-#define TARGET_SIGALRM		14	/* Alarm clock (POSIX).  */
-#define TARGET_SIGTERM		15	/* Termination (ANSI).  */
-#define TARGET_SIGUSR1		16	/* User-defined signal 1 (POSIX).  */
-#define TARGET_SIGUSR2		17	/* User-defined signal 2 (POSIX).  */
-#define TARGET_SIGCHLD		18	/* Child status has changed (POSIX).  */
-#define TARGET_SIGCLD		TARGET_SIGCHLD	/* Same as TARGET_SIGCHLD (System V).  */
-#define TARGET_SIGPWR		19	/* Power failure restart (System V).  */
-#define TARGET_SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
-#define TARGET_SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
-#define TARGET_SIGIO		22	/* I/O now possible (4.2 BSD).  */
-#define TARGET_SIGPOLL		TARGET_SIGIO	/* Pollable event occurred (System V).  */
-#define TARGET_SIGSTOP		23	/* Stop, unblockable (POSIX).  */
-#define TARGET_SIGTSTP		24	/* Keyboard stop (POSIX).  */
-#define TARGET_SIGCONT		25	/* Continue (POSIX).  */
-#define TARGET_SIGTTIN		26	/* Background read from tty (POSIX).  */
-#define TARGET_SIGTTOU		27	/* Background write to tty (POSIX).  */
-#define TARGET_SIGVTALRM	28	/* Virtual alarm clock (4.2 BSD).  */
-#define TARGET_SIGPROF		29	/* Profiling alarm clock (4.2 BSD).  */
-#define TARGET_SIGXCPU		30	/* CPU limit exceeded (4.2 BSD).  */
-#define TARGET_SIGXFSZ		31	/* File size limit exceeded (4.2 BSD).  */
-#define TARGET_SIGRTMIN         32
-
-#define TARGET_SIG_BLOCK	1	/* for blocking signals */
-#define TARGET_SIG_UNBLOCK	2	/* for unblocking signals */
-#define TARGET_SIG_SETMASK	3	/* for setting the signal mask */
-
 #elif defined(TARGET_HPPA)
 
 #define TARGET_SIGHUP           1
-- 
2.14.3
