Received: from eggs.gnu.org ([2001:4830:134:3::10]:38020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVq-0004Gb-7x
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVo-0000VQ-FA
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:30 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fNkVo-0000Ue-2r
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:28 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 29 May 2018 21:42:01 +0200
Message-Id: <20180529194207.31503-10-laurent@vivier.eu>
In-Reply-To: <20180529194207.31503-1-laurent@vivier.eu>
References: <20180529194207.31503-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 09/15] linux-user: move generic signal
 definitions to generic/signal.h
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
 linux-user/aarch64/target_signal.h    |  2 ++
 linux-user/arm/target_signal.h        |  2 ++
 linux-user/cris/target_signal.h       |  2 ++
 linux-user/generic/signal.h           | 57 +++++++++++++++++++++++++++++++++++
 linux-user/i386/target_signal.h       |  2 ++
 linux-user/m68k/target_signal.h       |  2 ++
 linux-user/microblaze/target_signal.h |  2 ++
 linux-user/nios2/target_signal.h      |  2 ++
 linux-user/openrisc/target_signal.h   |  2 ++
 linux-user/ppc/target_signal.h        |  2 ++
 linux-user/riscv/target_signal.h      |  2 ++
 linux-user/s390x/target_signal.h      |  2 ++
 linux-user/sh4/target_signal.h        |  2 ++
 linux-user/syscall_defs.h             | 50 ------------------------------
 linux-user/tilegx/target_signal.h     |  2 ++
 linux-user/x86_64/target_signal.h     |  2 ++
 linux-user/xtensa/target_signal.h     |  2 ++
 17 files changed, 87 insertions(+), 50 deletions(-)
 create mode 100644 linux-user/generic/signal.h

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 18599b1447..ddd73169f0 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -19,5 +19,7 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ 2048
 #define TARGET_SIGSTKSZ 8192
 
+#include "../generic/signal.h"
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* AARCH64_TARGET_SIGNAL_H */
diff --git a/linux-user/arm/target_signal.h b/linux-user/arm/target_signal.h
index f80eb0a215..ea123c40f3 100644
--- a/linux-user/arm/target_signal.h
+++ b/linux-user/arm/target_signal.h
@@ -19,5 +19,7 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ		8192
 
+#include "../generic/signal.h"
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* ARM_TARGET_SIGNAL_H */
diff --git a/linux-user/cris/target_signal.h b/linux-user/cris/target_signal.h
index bf404a85fd..1cb5548f85 100644
--- a/linux-user/cris/target_signal.h
+++ b/linux-user/cris/target_signal.h
@@ -19,5 +19,7 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
+#include "../generic/signal.h"
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* CRIS_TARGET_SIGNAL_H */
diff --git a/linux-user/generic/signal.h b/linux-user/generic/signal.h
new file mode 100644
index 0000000000..e1083f8fba
--- /dev/null
+++ b/linux-user/generic/signal.h
@@ -0,0 +1,57 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef GENERIC_SIGNAL_H
+#define GENERIC_SIGNAL_H
+
+#define TARGET_SA_NOCLDSTOP     0x00000001
+#define TARGET_SA_NOCLDWAIT     0x00000002 /* not supported yet */
+#define TARGET_SA_SIGINFO       0x00000004
+#define TARGET_SA_ONSTACK       0x08000000
+#define TARGET_SA_RESTART       0x10000000
+#define TARGET_SA_NODEFER       0x40000000
+#define TARGET_SA_RESETHAND     0x80000000
+#define TARGET_SA_RESTORER      0x04000000
+
+#define TARGET_SIGHUP            1
+#define TARGET_SIGINT            2
+#define TARGET_SIGQUIT           3
+#define TARGET_SIGILL            4
+#define TARGET_SIGTRAP           5
+#define TARGET_SIGABRT           6
+#define TARGET_SIGIOT            6
+#define TARGET_SIGBUS            7
+#define TARGET_SIGFPE            8
+#define TARGET_SIGKILL           9
+#define TARGET_SIGUSR1          10
+#define TARGET_SIGSEGV          11
+#define TARGET_SIGUSR2          12
+#define TARGET_SIGPIPE          13
+#define TARGET_SIGALRM          14
+#define TARGET_SIGTERM          15
+#define TARGET_SIGSTKFLT        16
+#define TARGET_SIGCHLD          17
+#define TARGET_SIGCONT          18
+#define TARGET_SIGSTOP          19
+#define TARGET_SIGTSTP          20
+#define TARGET_SIGTTIN          21
+#define TARGET_SIGTTOU          22
+#define TARGET_SIGURG           23
+#define TARGET_SIGXCPU          24
+#define TARGET_SIGXFSZ          25
+#define TARGET_SIGVTALRM        26
+#define TARGET_SIGPROF          27
+#define TARGET_SIGWINCH         28
+#define TARGET_SIGIO            29
+#define TARGET_SIGPWR           30
+#define TARGET_SIGSYS           31
+#define TARGET_SIGRTMIN         32
+
+#define TARGET_SIG_BLOCK          0    /* for blocking signals */
+#define TARGET_SIG_UNBLOCK        1    /* for unblocking signals */
+#define TARGET_SIG_SETMASK        2    /* for setting the signal mask */
+#endif
diff --git a/linux-user/i386/target_signal.h b/linux-user/i386/target_signal.h
index 8a284f4b57..f55e78fd33 100644
--- a/linux-user/i386/target_signal.h
+++ b/linux-user/i386/target_signal.h
@@ -19,5 +19,7 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ		8192
 
+#include "../generic/signal.h"
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* I386_TARGET_SIGNAL_H */
diff --git a/linux-user/m68k/target_signal.h b/linux-user/m68k/target_signal.h
index 0cf26b79e5..314e808844 100644
--- a/linux-user/m68k/target_signal.h
+++ b/linux-user/m68k/target_signal.h
@@ -19,5 +19,7 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ	8192
 
+#include "../generic/signal.h"
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* M68K_TARGET_SIGNAL_H */
diff --git a/linux-user/microblaze/target_signal.h b/linux-user/microblaze/target_signal.h
index 86adcc1fc9..35efd5e928 100644
--- a/linux-user/microblaze/target_signal.h
+++ b/linux-user/microblaze/target_signal.h
@@ -19,5 +19,7 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
+#include "../generic/signal.h"
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* MICROBLAZE_TARGET_SIGNAL_H */
diff --git a/linux-user/nios2/target_signal.h b/linux-user/nios2/target_signal.h
index 1f09f1e6bb..7776bcdbfd 100644
--- a/linux-user/nios2/target_signal.h
+++ b/linux-user/nios2/target_signal.h
@@ -16,4 +16,6 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
+#include "../generic/signal.h"
+
 #endif /* TARGET_SIGNAL_H */
diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
index 590383302c..3ccbb974d9 100644
--- a/linux-user/openrisc/target_signal.h
+++ b/linux-user/openrisc/target_signal.h
@@ -16,4 +16,6 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
+#include "../generic/signal.h"
+
 #endif /* OPENRISC_TARGET_SIGNAL_H */
diff --git a/linux-user/ppc/target_signal.h b/linux-user/ppc/target_signal.h
index 6f9e67e321..4453e2e7ef 100644
--- a/linux-user/ppc/target_signal.h
+++ b/linux-user/ppc/target_signal.h
@@ -19,6 +19,8 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
+#include "../generic/signal.h"
+
 #if !defined(TARGET_PPC64)
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif
diff --git a/linux-user/riscv/target_signal.h b/linux-user/riscv/target_signal.h
index c7fa357008..c8b1455800 100644
--- a/linux-user/riscv/target_signal.h
+++ b/linux-user/riscv/target_signal.h
@@ -13,4 +13,6 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ 2048
 #define TARGET_SIGSTKSZ 8192
 
+#include "../generic/signal.h"
+
 #endif /* TARGET_SIGNAL_H */
diff --git a/linux-user/s390x/target_signal.h b/linux-user/s390x/target_signal.h
index 8f41ccf9b2..b58bc7c20f 100644
--- a/linux-user/s390x/target_signal.h
+++ b/linux-user/s390x/target_signal.h
@@ -16,5 +16,7 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ     2048
 #define TARGET_SIGSTKSZ        8192
 
+#include "../generic/signal.h"
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* S390X_TARGET_SIGNAL_H */
diff --git a/linux-user/sh4/target_signal.h b/linux-user/sh4/target_signal.h
index 2bdc24c48e..434970a990 100644
--- a/linux-user/sh4/target_signal.h
+++ b/linux-user/sh4/target_signal.h
@@ -19,5 +19,7 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
+#include "../generic/signal.h"
+
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* SH4_TARGET_SIGNAL_H */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 85e0d870d8..44dc7831d6 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -471,15 +471,6 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_SA_NODEFER       0x00000020
 #define TARGET_SA_RESTART       0x00000040
 #define TARGET_SA_NOCLDWAIT     0x00000080
-#else
-#define TARGET_SA_NOCLDSTOP	0x00000001
-#define TARGET_SA_NOCLDWAIT	0x00000002 /* not supported yet */
-#define TARGET_SA_SIGINFO	0x00000004
-#define TARGET_SA_ONSTACK	0x08000000
-#define TARGET_SA_RESTART	0x10000000
-#define TARGET_SA_NODEFER	0x40000000
-#define TARGET_SA_RESETHAND	0x80000000
-#define TARGET_SA_RESTORER	0x04000000
 #endif
 
 #include "target_signal.h"
@@ -650,47 +641,6 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_SIG_UNBLOCK     1
 #define TARGET_SIG_SETMASK     2
 
-#else
-
-/* OpenRISC Using the general signals */
-#define TARGET_SIGHUP		 1
-#define TARGET_SIGINT		 2
-#define TARGET_SIGQUIT		 3
-#define TARGET_SIGILL		 4
-#define TARGET_SIGTRAP		 5
-#define TARGET_SIGABRT		 6
-#define TARGET_SIGIOT		 6
-#define TARGET_SIGBUS		 7
-#define TARGET_SIGFPE		 8
-#define TARGET_SIGKILL		 9
-#define TARGET_SIGUSR1		10
-#define TARGET_SIGSEGV		11
-#define TARGET_SIGUSR2		12
-#define TARGET_SIGPIPE		13
-#define TARGET_SIGALRM		14
-#define TARGET_SIGTERM		15
-#define TARGET_SIGSTKFLT	16
-#define TARGET_SIGCHLD		17
-#define TARGET_SIGCONT		18
-#define TARGET_SIGSTOP		19
-#define TARGET_SIGTSTP		20
-#define TARGET_SIGTTIN		21
-#define TARGET_SIGTTOU		22
-#define TARGET_SIGURG		23
-#define TARGET_SIGXCPU		24
-#define TARGET_SIGXFSZ		25
-#define TARGET_SIGVTALRM	26
-#define TARGET_SIGPROF		27
-#define TARGET_SIGWINCH	        28
-#define TARGET_SIGIO		29
-#define TARGET_SIGPWR		30
-#define TARGET_SIGSYS		31
-#define TARGET_SIGRTMIN         32
-
-#define TARGET_SIG_BLOCK          0    /* for blocking signals */
-#define TARGET_SIG_UNBLOCK        1    /* for unblocking signals */
-#define TARGET_SIG_SETMASK        2    /* for setting the signal mask */
-
 #endif
 
 #if defined(TARGET_ALPHA)
diff --git a/linux-user/tilegx/target_signal.h b/linux-user/tilegx/target_signal.h
index 4cb8c56adf..655be13009 100644
--- a/linux-user/tilegx/target_signal.h
+++ b/linux-user/tilegx/target_signal.h
@@ -18,4 +18,6 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
+#include "../generic/signal.h"
+
 #endif /* TILEGX_TARGET_SIGNAL_H */
diff --git a/linux-user/x86_64/target_signal.h b/linux-user/x86_64/target_signal.h
index be054d1e59..4c4380f7b9 100644
--- a/linux-user/x86_64/target_signal.h
+++ b/linux-user/x86_64/target_signal.h
@@ -19,4 +19,6 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ		8192
 
+#include "../generic/signal.h"
+
 #endif /* X86_64_TARGET_SIGNAL_H */
diff --git a/linux-user/xtensa/target_signal.h b/linux-user/xtensa/target_signal.h
index de03c0a564..c60bf656f6 100644
--- a/linux-user/xtensa/target_signal.h
+++ b/linux-user/xtensa/target_signal.h
@@ -18,4 +18,6 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
+#include "../generic/signal.h"
+
 #endif
-- 
2.14.3
