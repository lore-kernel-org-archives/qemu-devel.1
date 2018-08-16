Received: from eggs.gnu.org ([2001:4830:134:3::10]:56434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJla-00067Q-RP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJlJ-0001IR-SW
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44775 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJl9-0000ne-OI
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:24 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:58:00 +0200
Message-Id: <1534431497-1385-68-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 67/84] linux-user: Update syscall_defs.h
 header for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update constants and structures related to linux user syscall support
in nanoMIPS.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/syscall_defs.h | 57 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 40bb60e..abf94b8 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -374,7 +374,7 @@ struct target_dirent64 {
 #define TARGET_SIG_IGN	((abi_long)1)	/* ignore signal */
 #define TARGET_SIG_ERR	((abi_long)-1)	/* error return from signal */
 
-#ifdef TARGET_MIPS
+#if defined(TARGET_MIPS) && !defined(TARGET_NANOMIPS)
 #define TARGET_NSIG	   128
 #else
 #define TARGET_NSIG	   64
@@ -445,7 +445,7 @@ struct target_sigaction {
     target_sigset_t sa_mask;
     abi_ulong sa_restorer;
 };
-#elif defined(TARGET_MIPS)
+#elif defined(TARGET_MIPS) && !defined(TARGET_NANOMIPS)
 struct target_sigaction {
 	uint32_t	sa_flags;
 #if defined(TARGET_ABI_MIPSN32)
@@ -459,6 +459,14 @@ struct target_sigaction {
         abi_ulong sa_restorer;
 #endif
 };
+#elif defined(TARGET_NANOMIPS)
+struct target_sigaction {
+    abi_ulong _sa_handler;
+    abi_uint sa_flags;
+    target_sigset_t sa_mask;
+    abi_ulong sa_restorer;
+};
+
 #else
 struct target_old_sigaction {
         abi_ulong _sa_handler;
@@ -537,7 +545,7 @@ typedef struct {
 #define QEMU_SI_RT 5
 
 typedef struct target_siginfo {
-#ifdef TARGET_MIPS
+#if defined(TARGET_MIPS) && !defined(TARGET_NANOMIPS)
 	int si_signo;
 	int si_code;
 	int si_errno;
@@ -665,13 +673,16 @@ struct target_rlimit {
 
 #if defined(TARGET_ALPHA)
 #define TARGET_RLIM_INFINITY	0x7fffffffffffffffull
-#elif defined(TARGET_MIPS) || (defined(TARGET_SPARC) && TARGET_ABI_BITS == 32)
+#elif (defined(TARGET_MIPS) && !defined(TARGET_NANOMIPS)) \
+      || (defined(TARGET_SPARC) && TARGET_ABI_BITS == 32)
 #define TARGET_RLIM_INFINITY	0x7fffffffUL
+#elif defined(TARGET_NANOMIPS)
+#define TARGET_RLIM_INFINITY    0x76ffeec4UL
 #else
 #define TARGET_RLIM_INFINITY	((abi_ulong)-1)
 #endif
 
-#if defined(TARGET_MIPS)
+#if defined(TARGET_MIPS) && !defined(TARGET_NANOMIPS)
 #define TARGET_RLIMIT_CPU		0
 #define TARGET_RLIMIT_FSIZE		1
 #define TARGET_RLIMIT_DATA		2
@@ -687,6 +698,22 @@ struct target_rlimit {
 #define TARGET_RLIMIT_MSGQUEUE		12
 #define TARGET_RLIMIT_NICE		13
 #define TARGET_RLIMIT_RTPRIO		14
+#elif defined(TARGET_NANOMIPS)
+#define TARGET_RLIMIT_CPU               0
+#define TARGET_RLIMIT_FSIZE             1
+#define TARGET_RLIMIT_DATA              2
+#define TARGET_RLIMIT_STACK             3
+#define TARGET_RLIMIT_CORE              4
+#define TARGET_RLIMIT_RSS               5
+#define TARGET_RLIMIT_NPROC             6
+#define TARGET_RLIMIT_NOFILE            7
+#define TARGET_RLIMIT_MEMLOCK           8
+#define TARGET_RLIMIT_AS                9
+#define TARGET_RLIMIT_LOCKS             10
+#define TARGET_RLIMIT_SIGPENDING        11
+#define TARGET_RLIMIT_MSGQUEUE          12
+#define TARGET_RLIMIT_NICE              13
+#define TARGET_RLIMIT_RTPRIO            14
 #else
 #define TARGET_RLIMIT_CPU		0
 #define TARGET_RLIMIT_FSIZE		1
@@ -1657,6 +1684,10 @@ struct target_stat64 {
 	int64_t  	st_blocks;
 };
 
+#elif defined(TARGET_ABI_MIPSP32)
+
+/* No struct stat and struct stat64 structures */
+
 #elif defined(TARGET_ALPHA)
 
 struct target_stat {
@@ -2009,6 +2040,22 @@ struct target_statfs {
 	int32_t			f_flags;
 	int32_t			f_spare[5];
 };
+#elif defined(TARGET_ABI_MIPSP32)
+struct target_statfs {
+    abi_long    f_type;
+    abi_long    f_bsize;
+    abi_long    f_blocks;
+    abi_long    f_bfree;
+    abi_long    f_bavail;
+    abi_long    f_files;
+    abi_long    f_ffree;
+
+    /* Linux specials */
+    target_fsid_t f_fsid;
+    abi_long    f_namelen;
+    abi_llong   f_frsize;   /* Fragment size - unsupported */
+    abi_long    f_spare[6];
+};
 #else
 struct target_statfs {
 	abi_long		f_type;
-- 
2.7.4
