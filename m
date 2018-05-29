Received: from eggs.gnu.org ([2001:4830:134:3::10]:37987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVp-0004Ff-5t
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVm-0000U6-Mt
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:29 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fNkVm-0000TA-DS
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:26 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 29 May 2018 21:41:59 +0200
Message-Id: <20180529194207.31503-8-laurent@vivier.eu>
In-Reply-To: <20180529194207.31503-1-laurent@vivier.eu>
References: <20180529194207.31503-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 07/15] linux-user: move sparc/sparc64 fcntl
 definitions to sparc/target_fcntl.h
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
 linux-user/sparc/target_fcntl.h | 34 ++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h       | 39 ---------------------------------------
 2 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/linux-user/sparc/target_fcntl.h b/linux-user/sparc/target_fcntl.h
index 35a753153b..c2532989e5 100644
--- a/linux-user/sparc/target_fcntl.h
+++ b/linux-user/sparc/target_fcntl.h
@@ -7,5 +7,39 @@
 
 #ifndef SPARC_TARGET_FCNTL_H
 #define SPARC_TARGET_FCNTL_H
+
+#define TARGET_O_APPEND         0x0008
+#define TARGET_FASYNC           0x0040  /* fcntl, for BSD compatibility */
+#define TARGET_O_CREAT          0x0200  /* not fcntl */
+#define TARGET_O_TRUNC          0x0400  /* not fcntl */
+#define TARGET_O_EXCL           0x0800  /* not fcntl */
+#define TARGET_O_DSYNC          0x2000
+#define TARGET_O_NONBLOCK       0x4000
+# ifdef TARGET_SPARC64
+#  define TARGET_O_NDELAY       0x0004
+# else
+#  define TARGET_O_NDELAY       (0x0004 | TARGET_O_NONBLOCK)
+# endif
+#define TARGET_O_NOCTTY         0x8000  /* not fcntl */
+#define TARGET_O_LARGEFILE     0x40000
+#define TARGET_O_DIRECT       0x100000  /* direct disk access hint */
+#define TARGET_O_NOATIME      0x200000
+#define TARGET_O_CLOEXEC      0x400000
+#define TARGET___O_SYNC       0x800000
+#define TARGET_O_PATH        0x1000000
+#define TARGET___O_TMPFILE   0x2000000
+
+#define TARGET_F_RDLCK         1
+#define TARGET_F_WRLCK         2
+#define TARGET_F_UNLCK         3
+#define TARGET_F_GETOWN        5       /*  for sockets. */
+#define TARGET_F_SETOWN        6       /*  for sockets. */
+#define TARGET_F_GETLK         7
+#define TARGET_F_SETLK         8
+#define TARGET_F_SETLKW        9
+
+#define TARGET_ARCH_FLOCK_PAD abi_short __unused;
+#define TARGET_ARCH_FLOCK64_PAD abi_short __unused;
+
 #include "../generic/fcntl.h"
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a434edadf8..fbf1bf995a 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2407,17 +2407,6 @@ struct target_statfs64 {
 };
 #endif
 
-#if defined(TARGET_SPARC)
-#define TARGET_F_RDLCK         1
-#define TARGET_F_WRLCK         2
-#define TARGET_F_UNLCK         3
-#define TARGET_F_GETOWN        5       /*  for sockets. */
-#define TARGET_F_SETOWN        6       /*  for sockets. */
-#define TARGET_F_GETLK         7
-#define TARGET_F_SETLK         8
-#define TARGET_F_SETLKW        9
-#endif
-
 #define TARGET_F_LINUX_SPECIFIC_BASE 1024
 #define TARGET_F_SETLEASE (TARGET_F_LINUX_SPECIFIC_BASE + 0)
 #define TARGET_F_GETLEASE (TARGET_F_LINUX_SPECIFIC_BASE + 1)
@@ -2426,34 +2415,6 @@ struct target_statfs64 {
 #define TARGET_F_GETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 8)
 #define TARGET_F_NOTIFY  (TARGET_F_LINUX_SPECIFIC_BASE+2)
 
-#if defined (TARGET_SPARC)
-#define TARGET_O_APPEND         0x0008
-#define TARGET_FASYNC           0x0040  /* fcntl, for BSD compatibility */
-#define TARGET_O_CREAT          0x0200  /* not fcntl */
-#define TARGET_O_TRUNC          0x0400  /* not fcntl */
-#define TARGET_O_EXCL           0x0800  /* not fcntl */
-#define TARGET_O_DSYNC          0x2000
-#define TARGET_O_NONBLOCK       0x4000
-# ifdef TARGET_SPARC64
-#  define TARGET_O_NDELAY       0x0004
-# else
-#  define TARGET_O_NDELAY       (0x0004 | TARGET_O_NONBLOCK)
-# endif
-#define TARGET_O_NOCTTY         0x8000  /* not fcntl */
-#define TARGET_O_LARGEFILE     0x40000
-#define TARGET_O_DIRECT       0x100000  /* direct disk access hint */
-#define TARGET_O_NOATIME      0x200000
-#define TARGET_O_CLOEXEC      0x400000
-#define TARGET___O_SYNC       0x800000
-#define TARGET_O_PATH        0x1000000
-#define TARGET___O_TMPFILE   0x2000000
-#endif
-
-#if defined(TARGET_SPARC)
-#define TARGET_ARCH_FLOCK_PAD abi_short __unused;
-#define TARGET_ARCH_FLOCK64_PAD abi_short __unused;
-#endif
-
 #include "target_fcntl.h"
 
 /* soundcard defines */
-- 
2.14.3
