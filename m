Received: from eggs.gnu.org ([2001:4830:134:3::10]:39805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cmlmn-0005Cp-F7
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 13:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cmlmj-0003VS-HN
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 13:30:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:65443)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1cmlmj-0003UB-79
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 13:30:33 -0500
Date: Sat, 11 Mar 2017 19:30:16 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20170311183016.GA20514@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] linux-user: Add TARGET_MAP_STACK and
 TARGET_MAP_HUGETLB for all remaining architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Cc: Richard Henderson <rth@twiddle.net>

Add the missing defines and for TARGET_MAP_STACK and TARGET_MAP_HUGETLB
for alpha, mips, ppc and x86, and fix the mmap_flags translation table
to translate those flags between host and target architecture.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cec8428..03ed370 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5875,6 +5875,8 @@ static bitmask_transtbl mmap_flags_tbl[] = {
 	{ TARGET_MAP_LOCKED, TARGET_MAP_LOCKED, MAP_LOCKED, MAP_LOCKED },
         { TARGET_MAP_NORESERVE, TARGET_MAP_NORESERVE, MAP_NORESERVE,
           MAP_NORESERVE },
+	{ TARGET_MAP_STACK, TARGET_MAP_STACK, MAP_STACK, MAP_STACK },
+	{ TARGET_MAP_HUGETLB, TARGET_MAP_HUGETLB, MAP_HUGETLB, MAP_HUGETLB },
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index f356189..a516d77 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1346,6 +1346,8 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x0400		/* don't check for reservations */
 #define TARGET_MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define TARGET_MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
+#define TARGET_MAP_HUGETLB	0x80000		/* create a huge page mapping */
 #elif defined(TARGET_PPC)
 #define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
 #define TARGET_MAP_ANONYMOUS	0x20		/* don't use a file */
@@ -1356,6 +1358,8 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x0040		/* don't check for reservations */
 #define TARGET_MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define TARGET_MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
+#define TARGET_MAP_HUGETLB	0x40000		/* create a huge page mapping */
 #elif defined(TARGET_ALPHA)
 #define TARGET_MAP_ANONYMOUS	0x10		/* don't use a file */
 #define TARGET_MAP_FIXED	0x100		/* Interpret addr exactly */
@@ -1366,6 +1370,8 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x10000		/* no check for reservations */
 #define TARGET_MAP_POPULATE	0x20000		/* pop (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x40000		/* do not block on IO */
+#define TARGET_MAP_STACK	0x80000		/* give out an address that is best suited for process/thread stacks */
+#define TARGET_MAP_HUGETLB	0x100000	/* create a huge page mapping */
 #elif defined(TARGET_HPPA)
 #define TARGET_MAP_ANONYMOUS	0x10		/* don't use a file */
 #define TARGET_MAP_FIXED	0x04		/* Interpret addr exactly */
@@ -1388,6 +1394,8 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define TARGET_MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define TARGET_MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
+#define TARGET_MAP_HUGETLB	0x40000		/* create a huge page mapping */
 #define TARGET_MAP_UNINITIALIZED 0x4000000	/* for anonymous mmap, memory could be uninitialized */
 #endif
 
