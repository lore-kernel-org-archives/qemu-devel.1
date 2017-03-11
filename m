Received: from eggs.gnu.org ([2001:4830:134:3::10]:33688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cmlA7-000053-Jj
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cmlA4-0003tq-HE
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:50:39 -0500
Received: from mout.gmx.net ([212.227.17.22]:55929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1cmlA4-0003sY-8A
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:50:36 -0500
Date: Sat, 11 Mar 2017 18:50:19 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20170311175019.GA7195@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] linux-user: Fix TARGET_MAP* and TARGET_F_??LCK
 for hppa arch
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

TARGET_MAP_TYPE needs to be 0x03 instead of 0x0f on the hppa
architecture, otherwise it conflicts with MAP_FIXED which is 0x04.

Add missing TARGET_MAP_STACK and TARGET_MAP_HUGETLB values.

Fix TARGET_F_RDLCK, TARGET_F_WRLCK and TARGET_F_UNLCK.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 2620b56..f356189 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1329,7 +1329,11 @@ struct target_winsize {
 /* Common */
 #define TARGET_MAP_SHARED	0x01		/* Share changes */
 #define TARGET_MAP_PRIVATE	0x02		/* Changes are private */
+#if defined(TARGET_HPPA)
+#define TARGET_MAP_TYPE		0x03		/* Mask for type of mapping */
+#else
 #define TARGET_MAP_TYPE		0x0f		/* Mask for type of mapping */
+#endif
 
 /* Target specific */
 #if defined(TARGET_MIPS)
@@ -1372,6 +1376,8 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x04000		/* no check for reservations */
 #define TARGET_MAP_POPULATE	0x10000		/* pop (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define TARGET_MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
+#define TARGET_MAP_HUGETLB	0x80000		/* create a huge page mapping */
 #else
 #define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
 #define TARGET_MAP_ANONYMOUS	0x20		/* don't use a file */
@@ -2350,6 +2356,9 @@ struct target_statfs64 {
 #define TARGET_F_SETOWN        24       /*  for sockets. */
 #define TARGET_F_GETOWN        23       /*  for sockets. */
 #elif defined(TARGET_HPPA)
+#define TARGET_F_RDLCK         1
+#define TARGET_F_WRLCK         2
+#define TARGET_F_UNLCK         3
 #define TARGET_F_GETLK         5
 #define TARGET_F_SETLK         6
 #define TARGET_F_SETLKW        7
