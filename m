Received: from eggs.gnu.org ([209.51.188.92]:55835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbk0-0004nP-Vb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbk0-0004Aa-2w
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:52 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:47054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbjz-00049F-Su
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:52 -0500
Received: by mail-pl1-x644.google.com with SMTP id t13so6870017ply.13
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:31:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:43 +1100
Message-Id: <20190118213122.22865-10-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 10/49] linux-user: Split out readv, writev
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  2 ++
 linux-user/syscall-file.inc.c | 34 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 22 ----------------------
 linux-user/strace.list        |  6 ------
 4 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index b031de1375..130ba7e344 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -28,4 +28,6 @@ SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlinkat
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
+SYSCALL_DEF(readv, ARG_DEC, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
+SYSCALL_DEF(writev, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 9c8025b252..9bd21ac5cd 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -343,6 +343,23 @@ SYSCALL_IMPL(read)
     return ret;
 }
 
+SYSCALL_IMPL(readv)
+{
+    int fd = arg1;
+    abi_ulong target_vec = arg2;
+    int count = arg3;
+    struct iovec *vec = lock_iovec(VERIFY_WRITE, target_vec, count, 0);
+    abi_long ret;
+
+    if (vec != NULL) {
+        ret = get_errno(safe_readv(fd, vec, count));
+        unlock_iovec(vec, target_vec, count, 1);
+    } else {
+        ret = -host_to_target_errno(errno);
+    }
+    return ret;
+}
+
 static abi_long do_readlinkat(int dirfd, abi_ulong target_path,
                               abi_ulong target_buf, abi_ulong bufsiz)
 {
@@ -419,3 +436,20 @@ SYSCALL_IMPL(write)
     unlock_user(p, target_p, 0);
     return ret;
 }
+
+SYSCALL_IMPL(writev)
+{
+    int fd = arg1;
+    abi_ulong target_vec = arg2;
+    int count = arg3;
+    struct iovec *vec = lock_iovec(VERIFY_READ, target_vec, count, 1);
+    abi_long ret;
+
+    if (vec != NULL) {
+        ret = get_errno(safe_writev(fd, vec, count));
+        unlock_iovec(vec, target_vec, count, 0);
+    } else {
+        ret = -host_to_target_errno(errno);
+    }
+    return ret;
+}
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c236a80437..df47ee106e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8949,28 +8949,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* NOTE: the flock constant seems to be the same for every
            Linux platform */
         return get_errno(safe_flock(arg1, arg2));
-    case TARGET_NR_readv:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
-            if (vec != NULL) {
-                ret = get_errno(safe_readv(arg1, vec, arg3));
-                unlock_iovec(vec, arg2, arg3, 1);
-            } else {
-                ret = -host_to_target_errno(errno);
-            }
-        }
-        return ret;
-    case TARGET_NR_writev:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
-            if (vec != NULL) {
-                ret = get_errno(safe_writev(arg1, vec, arg3));
-                unlock_iovec(vec, arg2, arg3, 0);
-            } else {
-                ret = -host_to_target_errno(errno);
-            }
-        }
-        return ret;
 #if defined(TARGET_NR_preadv)
     case TARGET_NR_preadv:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index f3a1b0fe31..e02a854cea 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1073,9 +1073,6 @@
 #ifdef TARGET_NR_readdir
 { TARGET_NR_readdir, "readdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_readv
-{ TARGET_NR_readv, "readv" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_reboot
 { TARGET_NR_reboot, "reboot" , NULL, NULL, NULL },
 #endif
@@ -1608,9 +1605,6 @@
 #ifdef TARGET_NR_waitpid
 { TARGET_NR_waitpid, "waitpid" , "%s(%d,%p,%#x)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_writev
-{ TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_utimensat
 { TARGET_NR_utimensat, "utimensat", NULL, print_utimensat, NULL },
 #endif
-- 
2.17.2
