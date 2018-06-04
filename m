Received: from eggs.gnu.org ([2001:4830:134:3::10]:39116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHu-0002Dp-F1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHr-00062V-C6
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:50 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56591)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHr-00060t-0Y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:47 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:20:10 +0200
Message-Id: <20180604152015.13359-13-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 12/17] linux-user: move sparc signal definitions
 to sparc/target_signal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Remove sparc64/target_signal.h, use sparc/target_signal.h instead.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180529194207.31503-11-laurent@vivier.eu>
---
 linux-user/sparc/target_signal.h   | 48 +++++++++++++++++++++++++++++++++++
 linux-user/sparc64/signal.c        |  1 -
 linux-user/sparc64/target_signal.h | 24 +-----------------
 linux-user/syscall_defs.h          | 52 +-------------------------------------
 4 files changed, 50 insertions(+), 75 deletions(-)

diff --git a/linux-user/sparc/target_signal.h b/linux-user/sparc/target_signal.h
index bfa19bbb67..5cc40327d2 100644
--- a/linux-user/sparc/target_signal.h
+++ b/linux-user/sparc/target_signal.h
@@ -1,6 +1,44 @@
 #ifndef SPARC_TARGET_SIGNAL_H
 #define SPARC_TARGET_SIGNAL_H
 
+#define TARGET_SIGHUP            1
+#define TARGET_SIGINT            2
+#define TARGET_SIGQUIT           3
+#define TARGET_SIGILL            4
+#define TARGET_SIGTRAP           5
+#define TARGET_SIGABRT           6
+#define TARGET_SIGIOT            6
+#define TARGET_SIGSTKFLT         7 /* actually EMT */
+#define TARGET_SIGFPE            8
+#define TARGET_SIGKILL           9
+#define TARGET_SIGBUS           10
+#define TARGET_SIGSEGV          11
+#define TARGET_SIGSYS           12
+#define TARGET_SIGPIPE          13
+#define TARGET_SIGALRM          14
+#define TARGET_SIGTERM          15
+#define TARGET_SIGURG           16
+#define TARGET_SIGSTOP          17
+#define TARGET_SIGTSTP          18
+#define TARGET_SIGCONT          19
+#define TARGET_SIGCHLD          20
+#define TARGET_SIGTTIN          21
+#define TARGET_SIGTTOU          22
+#define TARGET_SIGIO            23
+#define TARGET_SIGXCPU          24
+#define TARGET_SIGXFSZ          25
+#define TARGET_SIGVTALRM        26
+#define TARGET_SIGPROF          27
+#define TARGET_SIGWINCH         28
+#define TARGET_SIGPWR           29
+#define TARGET_SIGUSR1          30
+#define TARGET_SIGUSR2          31
+#define TARGET_SIGRTMIN         32
+
+#define TARGET_SIG_BLOCK          0x01 /* for blocking signals */
+#define TARGET_SIG_UNBLOCK        0x02 /* for unblocking signals */
+#define TARGET_SIG_SETMASK        0x04 /* for setting the signal mask */
+
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
@@ -16,6 +54,16 @@ typedef struct target_sigaltstack {
 #define TARGET_SS_ONSTACK	1
 #define TARGET_SS_DISABLE	2
 
+#define TARGET_SA_NOCLDSTOP    8u
+#define TARGET_SA_NOCLDWAIT    0x100u
+#define TARGET_SA_SIGINFO      0x200u
+#define TARGET_SA_ONSTACK      1u
+#define TARGET_SA_RESTART      2u
+#define TARGET_SA_NODEFER      0x20u
+#define TARGET_SA_RESETHAND    4u
+#define TARGET_ARCH_HAS_SA_RESTORER 1
+#define TARGET_ARCH_HAS_KA_RESTORER 1
+
 #define TARGET_MINSIGSTKSZ	4096
 #define TARGET_SIGSTKSZ		16384
 
diff --git a/linux-user/sparc64/signal.c b/linux-user/sparc64/signal.c
index c263eb0f08..170ebac232 100644
--- a/linux-user/sparc64/signal.c
+++ b/linux-user/sparc64/signal.c
@@ -16,5 +16,4 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
-#define SPARC_TARGET_SIGNAL_H /* to only include sparc64/target_signal.h */
 #include "../sparc/signal.c"
diff --git a/linux-user/sparc64/target_signal.h b/linux-user/sparc64/target_signal.h
index 1d804bfe86..6a7d57d024 100644
--- a/linux-user/sparc64/target_signal.h
+++ b/linux-user/sparc64/target_signal.h
@@ -1,23 +1 @@
-#ifndef SPARC64_TARGET_SIGNAL_H
-#define SPARC64_TARGET_SIGNAL_H
-
-/* this struct defines a stack used during syscall handling */
-
-typedef struct target_sigaltstack {
-	abi_ulong ss_sp;
-	abi_long ss_flags;
-	abi_ulong ss_size;
-} target_stack_t;
-
-
-/*
- * sigaltstack controls
- */
-#define TARGET_SS_ONSTACK	1
-#define TARGET_SS_DISABLE	2
-
-#define TARGET_MINSIGSTKSZ	4096
-#define TARGET_SIGSTKSZ		16384
-
-#define TARGET_ARCH_HAS_SETUP_FRAME
-#endif /* SPARC64_TARGET_SIGNAL_H */
+#include "../sparc/target_signal.h"
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 44dc7831d6..0034156c6b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -426,17 +426,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     || defined(TARGET_TILEGX) || defined(TARGET_HPPA) || defined(TARGET_NIOS2) \
     || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
 
-#if defined(TARGET_SPARC)
-#define TARGET_SA_NOCLDSTOP    8u
-#define TARGET_SA_NOCLDWAIT    0x100u
-#define TARGET_SA_SIGINFO      0x200u
-#define TARGET_SA_ONSTACK      1u
-#define TARGET_SA_RESTART      2u
-#define TARGET_SA_NODEFER      0x20u
-#define TARGET_SA_RESETHAND    4u
-#define TARGET_ARCH_HAS_SA_RESTORER 1
-#define TARGET_ARCH_HAS_KA_RESTORER 1
-#elif defined(TARGET_MIPS)
+#if defined(TARGET_MIPS)
 #define TARGET_SA_NOCLDSTOP	0x00000001
 #define TARGET_SA_NOCLDWAIT	0x00010000
 #define TARGET_SA_SIGINFO	0x00000008
@@ -518,46 +508,6 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_SIG_UNBLOCK       2
 #define TARGET_SIG_SETMASK       3
 
-#elif defined(TARGET_SPARC)
-
-#define TARGET_SIGHUP		 1
-#define TARGET_SIGINT		 2
-#define TARGET_SIGQUIT		 3
-#define TARGET_SIGILL		 4
-#define TARGET_SIGTRAP		 5
-#define TARGET_SIGABRT		 6
-#define TARGET_SIGIOT		 6
-#define TARGET_SIGSTKFLT	 7 /* actually EMT */
-#define TARGET_SIGFPE		 8
-#define TARGET_SIGKILL		 9
-#define TARGET_SIGBUS		10
-#define TARGET_SIGSEGV		11
-#define TARGET_SIGSYS		12
-#define TARGET_SIGPIPE		13
-#define TARGET_SIGALRM		14
-#define TARGET_SIGTERM		15
-#define TARGET_SIGURG		16
-#define TARGET_SIGSTOP		17
-#define TARGET_SIGTSTP		18
-#define TARGET_SIGCONT		19
-#define TARGET_SIGCHLD		20
-#define TARGET_SIGTTIN		21
-#define TARGET_SIGTTOU		22
-#define TARGET_SIGIO		23
-#define TARGET_SIGXCPU		24
-#define TARGET_SIGXFSZ		25
-#define TARGET_SIGVTALRM	26
-#define TARGET_SIGPROF		27
-#define TARGET_SIGWINCH	        28
-#define TARGET_SIGPWR		29
-#define TARGET_SIGUSR1		30
-#define TARGET_SIGUSR2		31
-#define TARGET_SIGRTMIN         32
-
-#define TARGET_SIG_BLOCK          0x01 /* for blocking signals */
-#define TARGET_SIG_UNBLOCK        0x02 /* for unblocking signals */
-#define TARGET_SIG_SETMASK        0x04 /* for setting the signal mask */
-
 #elif defined(TARGET_MIPS)
 
 #define TARGET_SIGHUP		 1	/* Hangup (POSIX).  */
-- 
2.14.3
