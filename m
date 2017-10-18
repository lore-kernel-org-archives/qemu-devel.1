Received: from eggs.gnu.org ([2001:4830:134:3::10]:58573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXU-0005C6-HZ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXO-0003ss-Mj
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:35 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:44717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1e4nXO-0003sM-FB
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:30 -0400
Received: by mail-lf0-x22c.google.com with SMTP id 75so5619267lfx.1
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:33:30 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 18 Oct 2017 15:33:15 +0300
Message-Id: <5f9cee46cd4ec4600e1a2fdcca20adcf30348f9e.1508329282.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1508329282.git.riku.voipio@linaro.org>
References: <cover.1508329282.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 01/10] linux-user: fix O_TMPFILE handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@linaro.org>

From: Riku Voipio <riku.voipio@linaro.org>

Since O_TMPFILE might differ between guest and host,
add it to the bitmask_transtbl. While at it, fix the definitions
of O_DIRECTORY etc which should arm32 according to kernel sources.

This fixes open14 and openat03 ltp testcases. Fixes:

https://bugs.launchpad.net/qemu/+bug/1709170
---
 linux-user/strace.c       | 4 ++++
 linux-user/syscall.c      | 3 +++
 linux-user/syscall_defs.h | 8 +++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index d821d165ff..bd897a3f20 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -837,6 +837,10 @@ UNUSED static struct flags open_flags[] = {
 #endif
 #ifdef O_PATH
     FLAG_TARGET(O_PATH),
+#endif
+#ifdef O_TMPFILE
+    FLAG_TARGET(O_TMPFILE),
+    FLAG_TARGET(__O_TMPFILE),
 #endif
     FLAG_END,
 };
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..08fbc4d5f7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -341,6 +341,9 @@ static bitmask_transtbl fcntl_flags_tbl[] = {
 #endif
 #if defined(O_PATH)
   { TARGET_O_PATH,      TARGET_O_PATH,      O_PATH,      O_PATH       },
+#endif
+#if defined(O_TMPFILE)
+  { TARGET_O_TMPFILE,   TARGET_O_TMPFILE,   O_TMPFILE,   O_TMPFILE    },
 #endif
   /* Don't terminate the list prematurely on 64-bit host+guest.  */
 #if TARGET_O_LARGEFILE != 0 || O_LARGEFILE != 0
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 40c5027e93..6e2287e918 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2416,7 +2416,7 @@ struct target_statfs64 {
 #define TARGET_O_CLOEXEC     010000000
 #define TARGET___O_SYNC      000100000
 #define TARGET_O_PATH        020000000
-#elif defined(TARGET_ARM) || defined(TARGET_M68K)
+#elif defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_AARCH64)
 #define TARGET_O_DIRECTORY      040000 /* must be a directory */
 #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
 #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
@@ -2513,6 +2513,12 @@ struct target_statfs64 {
 #ifndef TARGET_O_PATH
 #define TARGET_O_PATH        010000000
 #endif
+#ifndef TARGET___O_TMPFILE
+#define TARGET___O_TMPFILE   020000000
+#endif
+#ifndef TARGET_O_TMPFILE
+#define TARGET_O_TMPFILE     (TARGET___O_TMPFILE | TARGET_O_DIRECTORY)
+#endif
 #ifndef TARGET_O_NDELAY
 #define TARGET_O_NDELAY  TARGET_O_NONBLOCK
 #endif
-- 
2.14.2
