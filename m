Received: from eggs.gnu.org ([2001:4830:134:3::10]:32799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4q0-0006GZ-Oy
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4pz-00066O-7J
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 11:09:57 +0200
Message-Id: <20180430091037.13878-3-laurent@vivier.eu>
In-Reply-To: <20180430091037.13878-1-laurent@vivier.eu>
References: <20180430091037.13878-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 02/42] linux-user: Fix getdents emulation for 64
 bit guest on 32 bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Currently we mishandle emulation of the getdents syscall for the
case of a 64 bit guest on a 32 bit host -- it defaults into
the 'host and guest same size' codepath and generates incorrect
structures in the guest buffer.

We can't easily handle the 64-on-32 case using the host getdents
syscall, because the guest struct dirent is bigger than the
host struct dirent, and we might find the host syscall has handed
us back more records than we can fit in the guest buffer after
conversion. Instead, always emulate 64-on-32 getdents with
the host getdents64. This avoids the buffer-overrun problem
because a dirent64 struct is always the same size on any host
and always larger than any architecture's dirent struct.

Reported-by: Henry Wertz <hwertz10@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180419125740.2695-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 643b8833de..404be44ad5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -259,10 +259,22 @@ static int gettid(void) {
     return -ENOSYS;
 }
 #endif
-#if defined(TARGET_NR_getdents) && defined(__NR_getdents)
+
+/* For the 64-bit guest on 32-bit host case we must emulate
+ * getdents using getdents64, because otherwise the host
+ * might hand us back more dirent records than we can fit
+ * into the guest buffer after structure format conversion.
+ * Otherwise we emulate getdents with getdents if the host has it.
+ */
+#if defined(__NR_getdents) && HOST_LONG_BITS >= TARGET_ABI_BITS
+#define EMULATE_GETDENTS_WITH_GETDENTS
+#endif
+
+#if defined(TARGET_NR_getdents) && defined(EMULATE_GETDENTS_WITH_GETDENTS)
 _syscall3(int, sys_getdents, uint, fd, struct linux_dirent *, dirp, uint, count);
 #endif
-#if !defined(__NR_getdents) || \
+#if (defined(TARGET_NR_getdents) && \
+      !defined(EMULATE_GETDENTS_WITH_GETDENTS)) || \
     (defined(TARGET_NR_getdents64) && defined(__NR_getdents64))
 _syscall3(int, sys_getdents64, uint, fd, struct linux_dirent64 *, dirp, uint, count);
 #endif
@@ -10163,7 +10175,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_getdents
     case TARGET_NR_getdents:
-#ifdef __NR_getdents
+#ifdef EMULATE_GETDENTS_WITH_GETDENTS
 #if TARGET_ABI_BITS == 32 && HOST_LONG_BITS == 64
         {
             struct target_dirent *target_dirp;
-- 
2.14.3
