Received: from eggs.gnu.org ([2001:4830:134:3::10]:58191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVv-0004cA-BN
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVt-0007rD-QU
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:59 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:45633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVt-0007nZ-Eo
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:57 -0500
Received: by mail-lf0-x242.google.com with SMTP id f131so3687973lff.12
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:21:57 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:35 +0200
Message-Id: <541e1690420d293c1b09eeb128fac74e98cbef7a.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 07/15] linux-user: Handle TARGET_MAP_STACK and
 TARGET_MAP_HUGETLB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>

From: Helge Deller <deller@gmx.de>

Add the missing defines and for TARGET_MAP_STACK and TARGET_MAP_HUGETLB
for alpha, mips, ppc, x86, hppa.  Fix the mmap_flags translation table
to translate MAP_HUGETLB between host and target architecture, and to
drop MAP_STACK.

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20170311183016.GA20514@ls3530.fritz.box>
[rth: Drop MAP_STACK instead of translating it, since it is ignored
in the kernel anyway.  Fix tabs to spaces.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c      | 31 ++++++++++++++++++++-----------
 linux-user/syscall_defs.h | 10 ++++++++++
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d4497dec5d..8047bf3aac 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5872,17 +5872,26 @@ static const StructEntry struct_termios_def = {
 };
 
 static bitmask_transtbl mmap_flags_tbl[] = {
-	{ TARGET_MAP_SHARED, TARGET_MAP_SHARED, MAP_SHARED, MAP_SHARED },
-	{ TARGET_MAP_PRIVATE, TARGET_MAP_PRIVATE, MAP_PRIVATE, MAP_PRIVATE },
-	{ TARGET_MAP_FIXED, TARGET_MAP_FIXED, MAP_FIXED, MAP_FIXED },
-	{ TARGET_MAP_ANONYMOUS, TARGET_MAP_ANONYMOUS, MAP_ANONYMOUS, MAP_ANONYMOUS },
-	{ TARGET_MAP_GROWSDOWN, TARGET_MAP_GROWSDOWN, MAP_GROWSDOWN, MAP_GROWSDOWN },
-	{ TARGET_MAP_DENYWRITE, TARGET_MAP_DENYWRITE, MAP_DENYWRITE, MAP_DENYWRITE },
-	{ TARGET_MAP_EXECUTABLE, TARGET_MAP_EXECUTABLE, MAP_EXECUTABLE, MAP_EXECUTABLE },
-	{ TARGET_MAP_LOCKED, TARGET_MAP_LOCKED, MAP_LOCKED, MAP_LOCKED },
-        { TARGET_MAP_NORESERVE, TARGET_MAP_NORESERVE, MAP_NORESERVE,
-          MAP_NORESERVE },
-	{ 0, 0, 0, 0 }
+    { TARGET_MAP_SHARED, TARGET_MAP_SHARED, MAP_SHARED, MAP_SHARED },
+    { TARGET_MAP_PRIVATE, TARGET_MAP_PRIVATE, MAP_PRIVATE, MAP_PRIVATE },
+    { TARGET_MAP_FIXED, TARGET_MAP_FIXED, MAP_FIXED, MAP_FIXED },
+    { TARGET_MAP_ANONYMOUS, TARGET_MAP_ANONYMOUS,
+      MAP_ANONYMOUS, MAP_ANONYMOUS },
+    { TARGET_MAP_GROWSDOWN, TARGET_MAP_GROWSDOWN,
+      MAP_GROWSDOWN, MAP_GROWSDOWN },
+    { TARGET_MAP_DENYWRITE, TARGET_MAP_DENYWRITE,
+      MAP_DENYWRITE, MAP_DENYWRITE },
+    { TARGET_MAP_EXECUTABLE, TARGET_MAP_EXECUTABLE,
+      MAP_EXECUTABLE, MAP_EXECUTABLE },
+    { TARGET_MAP_LOCKED, TARGET_MAP_LOCKED, MAP_LOCKED, MAP_LOCKED },
+    { TARGET_MAP_NORESERVE, TARGET_MAP_NORESERVE,
+      MAP_NORESERVE, MAP_NORESERVE },
+    { TARGET_MAP_HUGETLB, TARGET_MAP_HUGETLB, MAP_HUGETLB, MAP_HUGETLB },
+    /* MAP_STACK had been ignored by the kernel for quite some time.
+       Recognize it for the target insofar as we do not want to pass
+       it through to the host.  */
+    { TARGET_MAP_STACK, TARGET_MAP_STACK, 0, 0 },
+    { 0, 0, 0, 0 }
 };
 
 #if defined(TARGET_I386)
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index daa2a57398..bec3680b94 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1353,6 +1353,8 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x0400		/* don't check for reservations */
 #define TARGET_MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define TARGET_MAP_STACK        0x40000         /* ignored */
+#define TARGET_MAP_HUGETLB      0x80000         /* create a huge page mapping */
 #elif defined(TARGET_PPC)
 #define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
 #define TARGET_MAP_ANONYMOUS	0x20		/* don't use a file */
@@ -1363,6 +1365,8 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x0040		/* don't check for reservations */
 #define TARGET_MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define TARGET_MAP_STACK        0x20000         /* ignored */
+#define TARGET_MAP_HUGETLB      0x40000         /* create a huge page mapping */
 #elif defined(TARGET_ALPHA)
 #define TARGET_MAP_ANONYMOUS	0x10		/* don't use a file */
 #define TARGET_MAP_FIXED	0x100		/* Interpret addr exactly */
@@ -1373,6 +1377,8 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x10000		/* no check for reservations */
 #define TARGET_MAP_POPULATE	0x20000		/* pop (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x40000		/* do not block on IO */
+#define TARGET_MAP_STACK        0x80000         /* ignored */
+#define TARGET_MAP_HUGETLB      0x100000        /* create a huge page mapping */
 #elif defined(TARGET_HPPA)
 #define TARGET_MAP_ANONYMOUS	0x10		/* don't use a file */
 #define TARGET_MAP_FIXED	0x04		/* Interpret addr exactly */
@@ -1383,6 +1389,8 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x04000		/* no check for reservations */
 #define TARGET_MAP_POPULATE	0x10000		/* pop (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define TARGET_MAP_STACK        0x40000         /* ignored */
+#define TARGET_MAP_HUGETLB      0x80000         /* create a huge page mapping */
 #else
 #define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
 #define TARGET_MAP_ANONYMOUS	0x20		/* don't use a file */
@@ -1393,6 +1401,8 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define TARGET_MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define TARGET_MAP_STACK        0x20000         /* ignored */
+#define TARGET_MAP_HUGETLB      0x40000         /* create a huge page mapping */
 #define TARGET_MAP_UNINITIALIZED 0x4000000	/* for anonymous mmap, memory could be uninitialized */
 #endif
 
-- 
2.14.2
