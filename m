Received: from eggs.gnu.org ([2001:4830:134:3::10]:34047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dyq57-0004pe-90
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 22:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dyq53-00022g-BS
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 22:03:41 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dyq53-00022K-4H
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 22:03:37 -0400
Received: by mail-pg0-x241.google.com with SMTP id d8so4394738pgt.3
	for <qemu-devel@nongnu.org>; Sun, 01 Oct 2017 19:03:36 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Sun,  1 Oct 2017 19:01:32 -0700
Message-Id: <20171002020132.28762-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: avoid EFAULT when NULL is passed
 as buffer for [p]write[64]
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhuoweizhang@yahoo.com, laurent@vivier.eu, peter.maydell@linaro.com, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
List-ID: <qemu-devel.nongnu.org>

as documented in write(2)[1], if count is zero and fd refers to a regular
file the syscall might return 0 (if error detection is not performed).

the current version of the code will force and EFAULT if the buffer was
pointing to NULL and therefore will result in the following call failing:

  write(fd, NULL, 0)

instead of failing early, pass the call to the host instead so that any
further checks could be done there and the documented shortcut could be
used.

[1] http://man7.org/linux/man-pages/man2/write.2.html#RETURN_VALUE

Reported-by: Zhuowei Zhang <zhuoweizhang@yahoo.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/syscall.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..c0171e4d8c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7783,8 +7783,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
     case TARGET_NR_write:
-        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
+        p = lock_user(VERIFY_READ, arg2, arg3, 1);
+        if ((p == NULL) && (arg2 != 0)) {
             goto efault;
+        }
         if (fd_trans_target_to_host_data(arg1)) {
             void *copy = g_malloc(arg3);
             memcpy(copy, p, arg3);
@@ -10505,12 +10507,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg2, ret);
         break;
     case TARGET_NR_pwrite64:
+        p = lock_user(VERIFY_READ, arg2, arg3, 1);
+        if ((p == NULL) && (arg2 != 0)) {
+            goto efault;
+        }
         if (regpairs_aligned(cpu_env)) {
             arg4 = arg5;
             arg5 = arg6;
         }
-        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            goto efault;
         ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, 0);
         break;
-- 
2.14.2
