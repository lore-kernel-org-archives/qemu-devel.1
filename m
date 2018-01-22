Received: from eggs.gnu.org ([2001:4830:134:3::10]:49861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1edg96-0007NQ-7H
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1edg91-0008Gf-BZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:44:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1edg91-0008GK-52
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:44:31 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 10B9AAC95
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 17:44:30 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 22 Jan 2018 18:44:29 +0100
Message-ID: <mvmk1w9lreq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] linux-user: implement renameat2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is needed for new architectures like RISC-V which do not provide any
other rename-like syscall.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5e54889522..12ca06c65a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -598,6 +598,23 @@ static int sys_utimensat(int dirfd, const char *pathname,
 #endif
 #endif /* TARGET_NR_utimensat */
 
+#ifdef TARGET_NR_renameat2
+#if defined(__NR_renameat2)
+#define __NR_sys_renameat2 __NR_renameat2
+_syscall5(int, sys_renameat2, int, oldfd, const char *, old, int, newfd,
+          const char *, new, unsigned int, flags)
+#else
+static int sys_renameat2(int oldfd, const char *old,
+                         int newfd, const chat *new, int flags)
+{
+    if (flags == 0)
+        return renameat(oldfd, old, newfd, new);
+    errno = ENOSYS;
+    return -1;
+}
+#endif
+#endif /* TARGET_NR_renameat2 */
+
 #ifdef CONFIG_INOTIFY
 #include <sys/inotify.h>
 
@@ -8342,6 +8359,22 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
 #endif
+#if defined(TARGET_NR_renameat2)
+    case TARGET_NR_renameat2:
+        {
+            void *p2;
+            p  = lock_user_string(arg2);
+            p2 = lock_user_string(arg4);
+            if (!p || !p2)
+                ret = -TARGET_EFAULT;
+            else
+                ret = get_errno(sys_renameat2(arg1, p, arg3, p2,
+                                              target_to_host_bitmask(arg5, fcntl_flags_tbl)));
+            unlock_user(p2, arg4, 0);
+            unlock_user(p, arg2, 0);
+        }
+        break;
+#endif
 #ifdef TARGET_NR_mkdir
     case TARGET_NR_mkdir:
         if (!(p = lock_user_string(arg1)))
-- 
2.16.0

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
