Received: from eggs.gnu.org ([208.118.235.92]:50413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtmt-0006rI-VA
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtms-0000hI-La
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:51 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtms-0000gi-FV
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:50 -0500
Received: by mail-pl1-x642.google.com with SMTP id t13so6794748ply.13
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:58:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:12 +1100
Message-Id: <20181225205529.10874-26-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 25/42] linux-user: Add safe_syscall for riscv64
 host
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/host/riscv64/hostdep.h          | 23 +++++++
 linux-user/host/riscv64/safe-syscall.inc.S | 77 ++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 linux-user/host/riscv64/safe-syscall.inc.S

diff --git a/linux-user/host/riscv64/hostdep.h b/linux-user/host/riscv64/hostdep.h
index 28467ba00b..865f0fb9ff 100644
--- a/linux-user/host/riscv64/hostdep.h
+++ b/linux-user/host/riscv64/hostdep.h
@@ -8,4 +8,27 @@
 #ifndef RISCV64_HOSTDEP_H
 #define RISCV64_HOSTDEP_H
 
+/* We have a safe-syscall.inc.S */
+#define HAVE_SAFE_SYSCALL
+
+#ifndef __ASSEMBLER__
+
+/* These are defined by the safe-syscall.inc.S file */
+extern char safe_syscall_start[];
+extern char safe_syscall_end[];
+
+/* Adjust the signal context to rewind out of safe-syscall if we're in it */
+static inline void rewind_if_in_safe_syscall(void *puc)
+{
+    ucontext_t *uc = puc;
+    unsigned long *pcreg = &uc->uc_mcontext.__gregs[REG_PC];
+
+    if (*pcreg > (uintptr_t)safe_syscall_start
+        && *pcreg < (uintptr_t)safe_syscall_end) {
+        *pcreg = (uintptr_t)safe_syscall_start;
+    }
+}
+
+#endif /* __ASSEMBLER__ */
+
 #endif
diff --git a/linux-user/host/riscv64/safe-syscall.inc.S b/linux-user/host/riscv64/safe-syscall.inc.S
new file mode 100644
index 0000000000..9ca3fbfd1e
--- /dev/null
+++ b/linux-user/host/riscv64/safe-syscall.inc.S
@@ -0,0 +1,77 @@
+/*
+ * safe-syscall.inc.S : host-specific assembly fragment
+ * to handle signals occurring at the same time as system calls.
+ * This is intended to be included by linux-user/safe-syscall.S
+ *
+ * Written by Richard Henderson <rth@twiddle.net>
+ * Copyright (C) 2018 Linaro, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+	.global safe_syscall_base
+	.global safe_syscall_start
+	.global safe_syscall_end
+	.type	safe_syscall_base, @function
+	.type	safe_syscall_start, @function
+	.type	safe_syscall_end, @function
+
+	/*
+	 * This is the entry point for making a system call. The calling
+	 * convention here is that of a C varargs function with the
+	 * first argument an 'int *' to the signal_pending flag, the
+	 * second one the system call number (as a 'long'), and all further
+	 * arguments being syscall arguments (also 'long').
+	 * We return a long which is the syscall's return value, which
+	 * may be negative-errno on failure. Conversion to the
+	 * -1-and-errno-set convention is done by the calling wrapper.
+	 */
+safe_syscall_base:
+	.cfi_startproc
+	/*
+	 * The syscall calling convention is nearly the same as C:
+	 * we enter with a0 == *signal_pending
+	 *               a1 == syscall number
+	 *               a2 ... a7 == syscall arguments
+	 *               and return the result in a0
+	 * and the syscall instruction needs
+	 *               a7 == syscall number
+	 *               a0 ... a5 == syscall arguments
+	 *               and returns the result in a0
+	 * Shuffle everything around appropriately.
+	 */
+	mv	t0, a0		/* signal_pending pointer */
+	mv	t1, a1		/* syscall number */
+	mv	a0, a2		/* syscall arguments */
+	mv	a1, a3
+	mv	a2, a4
+	mv	a3, a5
+	mv	a4, a6
+	mv	a5, a7
+	mv	a7, t1
+
+	/*
+	 * This next sequence of code works in conjunction with the
+	 * rewind_if_safe_syscall_function(). If a signal is taken
+	 * and the interrupted PC is anywhere between 'safe_syscall_start'
+	 * and 'safe_syscall_end' then we rewind it to 'safe_syscall_start'.
+	 * The code sequence must therefore be able to cope with this, and
+	 * the syscall instruction must be the final one in the sequence.
+	 */
+safe_syscall_start:
+	/* If signal_pending is non-zero, don't do the call */
+	lw	t1, 0(t0)
+	bnez	t1, 0f
+	scall
+safe_syscall_end:
+	/* code path for having successfully executed the syscall */
+	ret
+
+0:
+	/* code path when we didn't execute the syscall */
+	li	a0, -TARGET_ERESTARTSYS
+	ret
+	.cfi_endproc
+
+	.size	safe_syscall_base, .-safe_syscall_base
-- 
2.17.2
