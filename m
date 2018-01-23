Received: from eggs.gnu.org ([2001:4830:134:3::10]:43513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs5-00078E-RD
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs4-0002U9-Fe
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:21 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56431)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edzs4-0002T6-5w
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:20 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 23 Jan 2018 15:48:07 +0100
Message-Id: <20180123144807.5618-14-laurent@vivier.eu>
In-Reply-To: <20180123144807.5618-1-laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 13/13] linux-user: implement renameat2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>

From: Andreas Schwab <schwab@suse.de>

This is needed for new architectures like RISC-V which do not provide any
other rename-like syscall.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <mvm607su9qs.fsf@suse.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 104408c050..74378947f0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -600,6 +600,24 @@ static int sys_utimensat(int dirfd, const char *pathname,
 #endif
 #endif /* TARGET_NR_utimensat */
 
+#ifdef TARGET_NR_renameat2
+#if defined(__NR_renameat2)
+#define __NR_sys_renameat2 __NR_renameat2
+_syscall5(int, sys_renameat2, int, oldfd, const char *, old, int, newfd,
+          const char *, new, unsigned int, flags)
+#else
+static int sys_renameat2(int oldfd, const char *old,
+                         int newfd, const char *new, int flags)
+{
+    if (flags == 0) {
+        return renameat(oldfd, old, newfd, new);
+    }
+    errno = ENOSYS;
+    return -1;
+}
+#endif
+#endif /* TARGET_NR_renameat2 */
+
 #ifdef CONFIG_INOTIFY
 #include <sys/inotify.h>
 
@@ -8426,6 +8444,22 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
 #endif
+#if defined(TARGET_NR_renameat2)
+    case TARGET_NR_renameat2:
+        {
+            void *p2;
+            p  = lock_user_string(arg2);
+            p2 = lock_user_string(arg4);
+            if (!p || !p2) {
+                ret = -TARGET_EFAULT;
+            } else {
+                ret = get_errno(sys_renameat2(arg1, p, arg3, p2, arg5));
+            }
+            unlock_user(p2, arg4, 0);
+            unlock_user(p, arg2, 0);
+        }
+        break;
+#endif
 #ifdef TARGET_NR_mkdir
     case TARGET_NR_mkdir:
         if (!(p = lock_user_string(arg1)))
-- 
2.14.3
