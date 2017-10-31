Received: from eggs.gnu.org ([2001:4830:134:3::10]:54087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3d-0002LU-Si
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3c-00058B-U0
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:17 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:45902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e9W3c-000581-NY
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:16 -0400
Received: by mail-wm0-x241.google.com with SMTP id y80so15474218wmd.0
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 05:54:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 31 Oct 2017 13:53:52 +0100
Message-Id: <20171031125358.23377-2-richard.henderson@linaro.org>
In-Reply-To: <20171031125358.23377-1-richard.henderson@linaro.org>
References: <20171031125358.23377-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/7] linux-user: Restrict usage of sa_restorer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Reading and writing to an sa_restorer member that isn't supposed to
exist corrupts user memory.  Introduce TARGET_ARCH_HAS_SA_RESTORER,
similar to the kernel's __ARCH_HAS_SA_RESTORER.

Reported-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/syscall_defs.h | 13 +++++++++++++
 linux-user/signal.c       |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

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
-- 
2.13.6
