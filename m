Received: from eggs.gnu.org ([2001:4830:134:3::10]:39109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHu-0002DZ-AY
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHq-00061I-Go
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:50 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHp-0005zT-W7
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:46 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:20:01 +0200
Message-Id: <20180604152015.13359-4-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 03/17] linux-user: move generic fcntl
 definitions to generic/fcntl.h
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

add a per target target_fcntl.h and include the generic one from them

No code change.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180529194207.31503-2-laurent@vivier.eu>
---
 linux-user/aarch64/target_fcntl.h    |  11 +++
 linux-user/alpha/target_fcntl.h      |  11 +++
 linux-user/arm/target_fcntl.h        |  11 +++
 linux-user/cris/target_fcntl.h       |  11 +++
 linux-user/generic/fcntl.h           | 151 +++++++++++++++++++++++++++++++++++
 linux-user/hppa/target_fcntl.h       |  11 +++
 linux-user/i386/target_fcntl.h       |  11 +++
 linux-user/m68k/target_fcntl.h       |  11 +++
 linux-user/microblaze/target_fcntl.h |  11 +++
 linux-user/mips/target_fcntl.h       |  11 +++
 linux-user/mips64/target_fcntl.h     |   1 +
 linux-user/nios2/target_fcntl.h      |  11 +++
 linux-user/openrisc/target_fcntl.h   |  11 +++
 linux-user/ppc/target_fcntl.h        |  11 +++
 linux-user/riscv/target_fcntl.h      |  11 +++
 linux-user/s390x/target_fcntl.h      |  11 +++
 linux-user/sh4/target_fcntl.h        |  11 +++
 linux-user/sparc/target_fcntl.h      |  11 +++
 linux-user/sparc64/target_fcntl.h    |   1 +
 linux-user/syscall_defs.h            | 129 +-----------------------------
 linux-user/tilegx/target_fcntl.h     |  11 +++
 linux-user/x86_64/target_fcntl.h     |  11 +++
 linux-user/xtensa/target_fcntl.h     |  11 +++
 23 files changed, 363 insertions(+), 128 deletions(-)
 create mode 100644 linux-user/aarch64/target_fcntl.h
 create mode 100644 linux-user/alpha/target_fcntl.h
 create mode 100644 linux-user/arm/target_fcntl.h
 create mode 100644 linux-user/cris/target_fcntl.h
 create mode 100644 linux-user/generic/fcntl.h
 create mode 100644 linux-user/hppa/target_fcntl.h
 create mode 100644 linux-user/i386/target_fcntl.h
 create mode 100644 linux-user/m68k/target_fcntl.h
 create mode 100644 linux-user/microblaze/target_fcntl.h
 create mode 100644 linux-user/mips/target_fcntl.h
 create mode 100644 linux-user/mips64/target_fcntl.h
 create mode 100644 linux-user/nios2/target_fcntl.h
 create mode 100644 linux-user/openrisc/target_fcntl.h
 create mode 100644 linux-user/ppc/target_fcntl.h
 create mode 100644 linux-user/riscv/target_fcntl.h
 create mode 100644 linux-user/s390x/target_fcntl.h
 create mode 100644 linux-user/sh4/target_fcntl.h
 create mode 100644 linux-user/sparc/target_fcntl.h
 create mode 100644 linux-user/sparc64/target_fcntl.h
 create mode 100644 linux-user/tilegx/target_fcntl.h
 create mode 100644 linux-user/x86_64/target_fcntl.h
 create mode 100644 linux-user/xtensa/target_fcntl.h

diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
new file mode 100644
index 0000000000..59be406280
--- /dev/null
+++ b/linux-user/aarch64/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef AARCH64_TARGET_FCNTL_H
+#define AARCH64_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/alpha/target_fcntl.h b/linux-user/alpha/target_fcntl.h
new file mode 100644
index 0000000000..bb603ff28c
--- /dev/null
+++ b/linux-user/alpha/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef ALPHA_TARGET_FCNTL_H
+#define ALPHA_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/arm/target_fcntl.h b/linux-user/arm/target_fcntl.h
new file mode 100644
index 0000000000..ca819df519
--- /dev/null
+++ b/linux-user/arm/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef ARM_TARGET_FCNTL_H
+#define ARM_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/cris/target_fcntl.h b/linux-user/cris/target_fcntl.h
new file mode 100644
index 0000000000..df0aceea34
--- /dev/null
+++ b/linux-user/cris/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef CRIS_TARGET_FCNTL_H
+#define CRIS_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
new file mode 100644
index 0000000000..a775a491e9
--- /dev/null
+++ b/linux-user/generic/fcntl.h
@@ -0,0 +1,151 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef GENERIC_FCNTL_H
+#define GENERIC_FCNTL_H
+
+/* <asm-generic/fcntl.h> values follow.  */
+#define TARGET_O_ACCMODE          0003
+#define TARGET_O_RDONLY             00
+#define TARGET_O_WRONLY             01
+#define TARGET_O_RDWR               02
+#ifndef TARGET_O_CREAT
+#define TARGET_O_CREAT            0100 /* not fcntl */
+#endif
+#ifndef TARGET_O_EXCL
+#define TARGET_O_EXCL             0200 /* not fcntl */
+#endif
+#ifndef TARGET_O_NOCTTY
+#define TARGET_O_NOCTTY           0400 /* not fcntl */
+#endif
+#ifndef TARGET_O_TRUNC
+#define TARGET_O_TRUNC           01000 /* not fcntl */
+#endif
+#ifndef TARGET_O_APPEND
+#define TARGET_O_APPEND          02000
+#endif
+#ifndef TARGET_O_NONBLOCK
+#define TARGET_O_NONBLOCK        04000
+#endif
+#ifndef TARGET_O_DSYNC
+#define TARGET_O_DSYNC          010000
+#endif
+#ifndef TARGET_FASYNC
+#define TARGET_FASYNC           020000 /* fcntl, for BSD compatibility */
+#endif
+#ifndef TARGET_O_DIRECT
+#define TARGET_O_DIRECT         040000 /* direct disk access hint */
+#endif
+#ifndef TARGET_O_LARGEFILE
+#define TARGET_O_LARGEFILE     0100000
+#endif
+#ifndef TARGET_O_DIRECTORY
+#define TARGET_O_DIRECTORY     0200000 /* must be a directory */
+#endif
+#ifndef TARGET_O_NOFOLLOW
+#define TARGET_O_NOFOLLOW      0400000 /* don't follow links */
+#endif
+#ifndef TARGET_O_NOATIME
+#define TARGET_O_NOATIME      01000000
+#endif
+#ifndef TARGET_O_CLOEXEC
+#define TARGET_O_CLOEXEC      02000000
+#endif
+#ifndef TARGET___O_SYNC
+#define TARGET___O_SYNC       04000000
+#endif
+#ifndef TARGET_O_PATH
+#define TARGET_O_PATH        010000000
+#endif
+#ifndef TARGET___O_TMPFILE
+#define TARGET___O_TMPFILE   020000000
+#endif
+#ifndef TARGET_O_TMPFILE
+#define TARGET_O_TMPFILE     (TARGET___O_TMPFILE | TARGET_O_DIRECTORY)
+#endif
+#ifndef TARGET_O_NDELAY
+#define TARGET_O_NDELAY  TARGET_O_NONBLOCK
+#endif
+#ifndef TARGET_O_SYNC
+#define TARGET_O_SYNC    (TARGET___O_SYNC | TARGET_O_DSYNC)
+#endif
+
+#define TARGET_F_DUPFD         0       /* dup */
+#define TARGET_F_GETFD         1       /* get close_on_exec */
+#define TARGET_F_SETFD         2       /* set/clear close_on_exec */
+#define TARGET_F_GETFL         3       /* get file->f_flags */
+#define TARGET_F_SETFL         4       /* set file->f_flags */
+#ifndef TARGET_F_GETLK
+#define TARGET_F_GETLK         5
+#define TARGET_F_SETLK         6
+#define TARGET_F_SETLKW        7
+#endif
+#ifndef TARGET_F_SETOWN
+#define TARGET_F_SETOWN        8       /*  for sockets. */
+#define TARGET_F_GETOWN        9       /*  for sockets. */
+#endif
+#ifndef TARGET_F_SETSIG
+#define TARGET_F_SETSIG        10      /*  for sockets. */
+#define TARGET_F_GETSIG        11      /*  for sockets. */
+#endif
+
+#ifndef TARGET_F_GETLK64
+#define TARGET_F_GETLK64       12      /*  using 'struct flock64' */
+#define TARGET_F_SETLK64       13
+#define TARGET_F_SETLKW64      14
+#endif
+
+#ifndef TARGET_F_SETOWN_EX
+#define TARGET_F_SETOWN_EX     15
+#define TARGET_F_GETOWN_EX     16
+#endif
+
+struct target_f_owner_ex {
+        int type;       /* Owner type of ID.  */
+        int pid;        /* ID of owner.  */
+};
+
+#ifndef TARGET_F_RDLCK
+#define TARGET_F_RDLCK         0
+#define TARGET_F_WRLCK         1
+#define TARGET_F_UNLCK         2
+#endif
+
+#ifndef TARGET_F_EXLCK
+#define TARGET_F_EXLCK         4
+#define TARGET_F_SHLCK         8
+#endif
+
+#ifndef TARGET_ARCH_FLOCK_PAD
+#define TARGET_ARCH_FLOCK_PAD
+#endif
+
+struct target_flock {
+    short l_type;
+    short l_whence;
+    abi_long l_start;
+    abi_long l_len;
+#if defined(TARGET_MIPS)
+    abi_long l_sysid;
+#endif
+    int l_pid;
+    TARGET_ARCH_FLOCK_PAD
+};
+
+#ifndef TARGET_ARCH_FLOCK64_PAD
+#define TARGET_ARCH_FLOCK64_PAD
+#endif
+
+struct target_flock64 {
+    abi_short l_type;
+    abi_short l_whence;
+    abi_llong l_start;
+    abi_llong l_len;
+    abi_int   l_pid;
+    TARGET_ARCH_FLOCK64_PAD
+};
+#endif
diff --git a/linux-user/hppa/target_fcntl.h b/linux-user/hppa/target_fcntl.h
new file mode 100644
index 0000000000..aa282a5ce8
--- /dev/null
+++ b/linux-user/hppa/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef HPPA_TARGET_FCNTL_H
+#define HPPA_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/i386/target_fcntl.h b/linux-user/i386/target_fcntl.h
new file mode 100644
index 0000000000..4819743dae
--- /dev/null
+++ b/linux-user/i386/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef I386_TARGET_FCNTL_H
+#define I386_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/m68k/target_fcntl.h b/linux-user/m68k/target_fcntl.h
new file mode 100644
index 0000000000..4328c60d22
--- /dev/null
+++ b/linux-user/m68k/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef M68K_TARGET_FCNTL_H
+#define M68K_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/microblaze/target_fcntl.h b/linux-user/microblaze/target_fcntl.h
new file mode 100644
index 0000000000..45402275ff
--- /dev/null
+++ b/linux-user/microblaze/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef MICROBLAZE_TARGET_FCNTL_H
+#define MICROBLAZE_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/mips/target_fcntl.h b/linux-user/mips/target_fcntl.h
new file mode 100644
index 0000000000..5404245068
--- /dev/null
+++ b/linux-user/mips/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef MIPS_TARGET_FCNTL_H
+#define MIPS_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/mips64/target_fcntl.h b/linux-user/mips64/target_fcntl.h
new file mode 100644
index 0000000000..a511bc0e6c
--- /dev/null
+++ b/linux-user/mips64/target_fcntl.h
@@ -0,0 +1 @@
+#include "../mips/target_fcntl.h"
diff --git a/linux-user/nios2/target_fcntl.h b/linux-user/nios2/target_fcntl.h
new file mode 100644
index 0000000000..714583215d
--- /dev/null
+++ b/linux-user/nios2/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef NIOS2_TARGET_FCNTL_H
+#define NIOS2_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/openrisc/target_fcntl.h b/linux-user/openrisc/target_fcntl.h
new file mode 100644
index 0000000000..ea31bf8b70
--- /dev/null
+++ b/linux-user/openrisc/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef OPENRISC_TARGET_FCNTL_H
+#define OPENRISC_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/ppc/target_fcntl.h b/linux-user/ppc/target_fcntl.h
new file mode 100644
index 0000000000..627d547289
--- /dev/null
+++ b/linux-user/ppc/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_TARGET_FCNTL_H
+#define PPC_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/riscv/target_fcntl.h b/linux-user/riscv/target_fcntl.h
new file mode 100644
index 0000000000..9c3d0fbe2b
--- /dev/null
+++ b/linux-user/riscv/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef RISCV_TARGET_FCNTL_H
+#define RISCV_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/s390x/target_fcntl.h b/linux-user/s390x/target_fcntl.h
new file mode 100644
index 0000000000..36dc50fba0
--- /dev/null
+++ b/linux-user/s390x/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef S390X_TARGET_FCNTL_H
+#define S390X_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/sh4/target_fcntl.h b/linux-user/sh4/target_fcntl.h
new file mode 100644
index 0000000000..2622d95539
--- /dev/null
+++ b/linux-user/sh4/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef SH4_TARGET_FCNTL_H
+#define SH4_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/sparc/target_fcntl.h b/linux-user/sparc/target_fcntl.h
new file mode 100644
index 0000000000..35a753153b
--- /dev/null
+++ b/linux-user/sparc/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef SPARC_TARGET_FCNTL_H
+#define SPARC_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/sparc64/target_fcntl.h b/linux-user/sparc64/target_fcntl.h
new file mode 100644
index 0000000000..053c774257
--- /dev/null
+++ b/linux-user/sparc64/target_fcntl.h
@@ -0,0 +1 @@
+#include "../sparc/target_fcntl.h"
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e4cd87cc00..9969f21ba1 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2407,13 +2407,6 @@ struct target_statfs64 {
 };
 #endif
 
-
-#define TARGET_F_DUPFD         0       /* dup */
-#define TARGET_F_GETFD         1       /* get close_on_exec */
-#define TARGET_F_SETFD         2       /* set/clear close_on_exec */
-#define TARGET_F_GETFL         3       /* get file->f_flags */
-#define TARGET_F_SETFL         4       /* set file->f_flags */
-
 #if defined(TARGET_ALPHA)
 #define TARGET_F_GETLK         7
 #define TARGET_F_SETLK         8
@@ -2450,34 +2443,11 @@ struct target_statfs64 {
 #define TARGET_F_GETLK         7
 #define TARGET_F_SETLK         8
 #define TARGET_F_SETLKW        9
-#else
-#define TARGET_F_GETLK         5
-#define TARGET_F_SETLK         6
-#define TARGET_F_SETLKW        7
-#define TARGET_F_SETOWN        8       /*  for sockets. */
-#define TARGET_F_GETOWN        9       /*  for sockets. */
 #endif
-#define TARGET_F_SETOWN_EX     15
-#define TARGET_F_GETOWN_EX     16
-
-#ifndef TARGET_F_RDLCK
-#define TARGET_F_RDLCK         0
-#define TARGET_F_WRLCK         1
-#define TARGET_F_UNLCK         2
-#endif
-
-#ifndef TARGET_F_EXLCK
-#define TARGET_F_EXLCK         4
-#define TARGET_F_SHLCK         8
-#endif
-
 
 #if defined(TARGET_HPPA)
 #define TARGET_F_SETSIG        13      /*  for sockets. */
 #define TARGET_F_GETSIG        14      /*  for sockets. */
-#else
-#define TARGET_F_SETSIG        10      /*  for sockets. */
-#define TARGET_F_GETSIG        11      /*  for sockets. */
 #endif
 
 #if defined(TARGET_MIPS)
@@ -2488,10 +2458,6 @@ struct target_statfs64 {
 #define TARGET_F_GETLK64       8       /*  using 'struct flock64' */
 #define TARGET_F_SETLK64       9
 #define TARGET_F_SETLKW64      10
-#else
-#define TARGET_F_GETLK64       12      /*  using 'struct flock64' */
-#define TARGET_F_SETLK64       13
-#define TARGET_F_SETLKW64      14
 #endif
 
 #define TARGET_F_LINUX_SPECIFIC_BASE 1024
@@ -2577,108 +2543,15 @@ struct target_statfs64 {
 #define TARGET___O_TMPFILE   0x2000000
 #endif
 
-/* <asm-generic/fcntl.h> values follow.  */
-#define TARGET_O_ACCMODE          0003
-#define TARGET_O_RDONLY             00
-#define TARGET_O_WRONLY             01
-#define TARGET_O_RDWR               02
-#ifndef TARGET_O_CREAT
-#define TARGET_O_CREAT            0100 /* not fcntl */
-#endif
-#ifndef TARGET_O_EXCL
-#define TARGET_O_EXCL             0200 /* not fcntl */
-#endif
-#ifndef TARGET_O_NOCTTY
-#define TARGET_O_NOCTTY           0400 /* not fcntl */
-#endif
-#ifndef TARGET_O_TRUNC
-#define TARGET_O_TRUNC           01000 /* not fcntl */
-#endif
-#ifndef TARGET_O_APPEND
-#define TARGET_O_APPEND          02000
-#endif
-#ifndef TARGET_O_NONBLOCK
-#define TARGET_O_NONBLOCK        04000
-#endif
-#ifndef TARGET_O_DSYNC
-#define TARGET_O_DSYNC          010000
-#endif
-#ifndef TARGET_FASYNC
-#define TARGET_FASYNC           020000 /* fcntl, for BSD compatibility */
-#endif
-#ifndef TARGET_O_DIRECT
-#define TARGET_O_DIRECT         040000 /* direct disk access hint */
-#endif
-#ifndef TARGET_O_LARGEFILE
-#define TARGET_O_LARGEFILE     0100000
-#endif
-#ifndef TARGET_O_DIRECTORY
-#define TARGET_O_DIRECTORY     0200000 /* must be a directory */
-#endif
-#ifndef TARGET_O_NOFOLLOW
-#define TARGET_O_NOFOLLOW      0400000 /* don't follow links */
-#endif
-#ifndef TARGET_O_NOATIME
-#define TARGET_O_NOATIME      01000000
-#endif
-#ifndef TARGET_O_CLOEXEC
-#define TARGET_O_CLOEXEC      02000000
-#endif
-#ifndef TARGET___O_SYNC
-#define TARGET___O_SYNC       04000000
-#endif
-#ifndef TARGET_O_PATH
-#define TARGET_O_PATH        010000000
-#endif
-#ifndef TARGET___O_TMPFILE
-#define TARGET___O_TMPFILE   020000000
-#endif
-#ifndef TARGET_O_TMPFILE
-#define TARGET_O_TMPFILE     (TARGET___O_TMPFILE | TARGET_O_DIRECTORY)
-#endif
-#ifndef TARGET_O_NDELAY
-#define TARGET_O_NDELAY  TARGET_O_NONBLOCK
-#endif
-#ifndef TARGET_O_SYNC
-#define TARGET_O_SYNC    (TARGET___O_SYNC | TARGET_O_DSYNC)
-#endif
-
 #if defined(TARGET_SPARC)
 #define TARGET_ARCH_FLOCK_PAD abi_short __unused;
 #define TARGET_ARCH_FLOCK64_PAD abi_short __unused;
 #elif defined(TARGET_MIPS)
 #define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
 #define TARGET_ARCH_FLOCK64_PAD
-#else
-#define TARGET_ARCH_FLOCK_PAD
-#define TARGET_ARCH_FLOCK64_PAD
-#endif
-
-struct target_flock {
-    short l_type;
-    short l_whence;
-    abi_long l_start;
-    abi_long l_len;
-#if defined(TARGET_MIPS)
-    abi_long l_sysid;
 #endif
-    int l_pid;
-    TARGET_ARCH_FLOCK_PAD
-};
 
-struct target_flock64 {
-    abi_short l_type;
-    abi_short l_whence;
-    abi_llong l_start;
-    abi_llong l_len;
-    abi_int   l_pid;
-    TARGET_ARCH_FLOCK64_PAD
-};
-
-struct target_f_owner_ex {
-        int type;	/* Owner type of ID.  */
-        int pid;	/* ID of owner.  */
-};
+#include "target_fcntl.h"
 
 /* soundcard defines */
 /* XXX: convert them all to arch independent entries */
diff --git a/linux-user/tilegx/target_fcntl.h b/linux-user/tilegx/target_fcntl.h
new file mode 100644
index 0000000000..5ed7438459
--- /dev/null
+++ b/linux-user/tilegx/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef TILEGX_TARGET_FCNTL_H
+#define TILEGX_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/x86_64/target_fcntl.h b/linux-user/x86_64/target_fcntl.h
new file mode 100644
index 0000000000..3c7238e56b
--- /dev/null
+++ b/linux-user/x86_64/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef X86_64_TARGET_FCNTL_H
+#define X86_64_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
diff --git a/linux-user/xtensa/target_fcntl.h b/linux-user/xtensa/target_fcntl.h
new file mode 100644
index 0000000000..dc1ca7eaa5
--- /dev/null
+++ b/linux-user/xtensa/target_fcntl.h
@@ -0,0 +1,11 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef XTENSA_TARGET_FCNTL_H
+#define XTENSA_TARGET_FCNTL_H
+#include "../generic/fcntl.h"
+#endif
-- 
2.14.3
