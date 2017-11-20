Received: from eggs.gnu.org ([2001:4830:134:3::10]:58093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVn-0004Tc-1s
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVk-0007dx-Bu
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:51 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVk-0007ca-4L
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:48 -0500
Received: by mail-lf0-x244.google.com with SMTP id k66so11726548lfg.3
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:21:48 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:29 +0200
Message-Id: <7f047de18cf6cd51915d4fdbe1a7e66c38b45e98.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 01/15] linux-user: Restrict usage of sa_restorer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Reading and writing to an sa_restorer member that isn't supposed to
exist corrupts user memory.  Introduce TARGET_ARCH_HAS_SA_RESTORER,
similar to the kernel's __ARCH_HAS_SA_RESTORER.

Reported-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/signal.c       |  4 ++--
 linux-user/syscall_defs.h | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 7a238aaea1..cf35473671 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -777,7 +777,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     if (oact) {
         __put_user(k->_sa_handler, &oact->_sa_handler);
         __put_user(k->sa_flags, &oact->sa_flags);
-#if !defined(TARGET_MIPS)
+#ifdef TARGET_ARCH_HAS_SA_RESTORER
         __put_user(k->sa_restorer, &oact->sa_restorer);
 #endif
         /* Not swapped.  */
@@ -787,7 +787,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
         /* FIXME: This is not threadsafe.  */
         __get_user(k->_sa_handler, &act->_sa_handler);
         __get_user(k->sa_flags, &act->sa_flags);
-#if !defined(TARGET_MIPS)
+#ifdef TARGET_ARCH_HAS_SA_RESTORER
         __get_user(k->sa_restorer, &act->sa_restorer);
 #endif
         /* To be swapped in target_to_host_sigset.  */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 450960bb54..e366183419 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -445,6 +445,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_SA_RESTART      2u
 #define TARGET_SA_NODEFER      0x20u
 #define TARGET_SA_RESETHAND    4u
+#define TARGET_ARCH_HAS_SA_RESTORER 1
 #elif defined(TARGET_MIPS)
 #define TARGET_SA_NOCLDSTOP	0x00000001
 #define TARGET_SA_NOCLDWAIT	0x00010000
@@ -483,6 +484,10 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_SA_RESTORER	0x04000000
 #endif
 
+#ifdef TARGET_SA_RESTORER
+#define TARGET_ARCH_HAS_SA_RESTORER 1
+#endif
+
 #if defined(TARGET_ALPHA)
 
 #define TARGET_SIGHUP            1
@@ -718,19 +723,27 @@ struct target_sigaction {
 	abi_ulong	_sa_handler;
 #endif
 	target_sigset_t	sa_mask;
+#ifdef TARGET_ARCH_HAS_SA_RESTORER
+        /* ??? This is always present, but ignored unless O32.  */
+        abi_ulong sa_restorer;
+#endif
 };
 #else
 struct target_old_sigaction {
         abi_ulong _sa_handler;
         abi_ulong sa_mask;
         abi_ulong sa_flags;
+#ifdef TARGET_ARCH_HAS_SA_RESTORER
         abi_ulong sa_restorer;
+#endif
 };
 
 struct target_sigaction {
         abi_ulong _sa_handler;
         abi_ulong sa_flags;
+#ifdef TARGET_ARCH_HAS_SA_RESTORER
         abi_ulong sa_restorer;
+#endif
         target_sigset_t sa_mask;
 };
 #endif
-- 
2.14.2
