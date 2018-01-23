Received: from eggs.gnu.org ([2001:4830:134:3::10]:41961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1edwCv-0006SF-Tf
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1edwCq-0001G3-Ui
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:53:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1edwCq-0001FW-Nx
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:53:32 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 85966AD14
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 10:53:31 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
References: <mvmk1w9lreq.fsf@suse.de>
Date: Tue, 23 Jan 2018 11:53:31 +0100
In-Reply-To: <mvmk1w9lreq.fsf@suse.de> (Andreas Schwab's message of "Mon, 22
	Jan 2018 18:44:29 +0100")
Message-ID: <mvm607su9qs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] linux-user: implement renameat2
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
 linux-user/syscall.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5e54889522..c258a0a44b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -598,6 +598,24 @@ static int sys_utimensat(int dirfd, const char *pathname,
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
 
@@ -8342,6 +8360,22 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
2.16.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
