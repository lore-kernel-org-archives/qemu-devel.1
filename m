Received: from eggs.gnu.org ([209.51.188.92]:55990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkb-0005Iy-Bu
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkZ-0004oS-0V
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:29 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkQ-0004ea-L4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:20 -0500
Received: by mail-pl1-x641.google.com with SMTP id a14so6865894plm.12
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:53 +1100
Message-Id: <20190118213122.22865-20-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 20/49] linux-user: Implement rusage argument
 to waitid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

The kernel interface, which we are supposed to be implementing,
takes a fifth argument: an rusage pointer akin to wait4.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  2 +-
 linux-user/syscall-proc.inc.c | 27 +++++++++++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index a84050a318..f099d98fa3 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -119,7 +119,7 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 SYSCALL_DEF_FULL(vfork, .impl = impl_fork);
 #endif
 SYSCALL_DEF(wait4, ARG_DEC, ARG_PTR, ARG_HEX, ARG_PTR);
-SYSCALL_DEF(waitid, ARG_HEX, ARG_DEC, ARG_PTR, ARG_HEX);
+SYSCALL_DEF(waitid, ARG_HEX, ARG_DEC, ARG_PTR, ARG_HEX, ARG_PTR);
 #ifdef TARGET_NR_waitpid
 SYSCALL_DEF(waitpid, ARG_DEC, ARG_PTR, ARG_HEX);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 37f5bbe197..de4efed9f4 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -370,19 +370,30 @@ SYSCALL_IMPL(waitid)
     id_t id = arg2;
     abi_ulong target_info = arg3;
     int options = arg4;
+    abi_ulong target_rusage = arg5;
     siginfo_t info, *info_ptr = target_info ? &info : NULL;
+    struct rusage rusage;
+    struct rusage *rusage_ptr = target_rusage ? &rusage : NULL;
     abi_long ret;
 
     info.si_pid = 0;
-    ret = get_errno(safe_waitid(idtype, id, info_ptr, options, NULL));
-    if (!is_error(ret) && target_info && info.si_pid != 0) {
-        target_siginfo_t *p = lock_user(VERIFY_WRITE, target_info,
-                                        sizeof(target_siginfo_t), 0);
-        if (!p) {
-            return -TARGET_EFAULT;
+    ret = get_errno(safe_waitid(idtype, id, info_ptr, options, rusage_ptr));
+    if (!is_error(ret)) {
+        if (target_info && info.si_pid != 0) {
+            target_siginfo_t *p = lock_user(VERIFY_WRITE, target_info,
+                                            sizeof(target_siginfo_t), 0);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+            host_to_target_siginfo(p, &info);
+            unlock_user(p, target_info, sizeof(target_siginfo_t));
+        }
+        if (target_rusage) {
+            abi_long err = host_to_target_rusage(target_rusage, &rusage);
+            if (err) {
+                ret = err;
+            }
         }
-        host_to_target_siginfo(p, &info);
-        unlock_user(p, target_info, sizeof(target_siginfo_t));
     }
     return ret;
 }
-- 
2.17.2
