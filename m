Received: from eggs.gnu.org ([209.51.188.92]:55719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbju-0004hk-V4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbjt-0003xf-J0
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:46 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbjs-0003mi-Ip
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:45 -0500
Received: by mail-pf1-x441.google.com with SMTP id c123so7220157pfb.0
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:31:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:37 +1100
Message-Id: <20190118213122.22865-4-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 04/49] linux-user: Share more code for open
 and openat
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

The do_openat helper can have all of the code that is not directly
related to the argument ordering of these two syscalls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-file.inc.c | 69 ++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index ca777da753..ffa70bbea8 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -221,8 +221,8 @@ static int open_net_route(void *cpu_env, int fd)
 }
 #endif
 
-static int do_openat(void *cpu_env, int dirfd, const char *pathname,
-                     int flags, mode_t mode)
+static abi_long do_openat(void *cpu_env, int dirfd, abi_ulong target_path,
+                          int target_flags, mode_t mode)
 {
     struct fake_open {
         const char *filename;
@@ -241,9 +241,20 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname,
         { NULL, NULL, NULL }
     };
 
+    char *pathname = lock_user_string(target_path);
+    int flags = target_to_host_bitmask(target_flags, fcntl_flags_tbl);
+    abi_long ret;
+
+    if (!pathname) {
+        return -TARGET_EFAULT;
+    }
+
     if (is_proc_myself(pathname, "exe")) {
-        int execfd = qemu_getauxval(AT_EXECFD);
-        return execfd ? execfd : safe_openat(dirfd, exec_path, flags, mode);
+        ret = qemu_getauxval(AT_EXECFD);
+        if (ret == 0) {
+            ret = get_errno(safe_openat(dirfd, exec_path, flags, mode));
+        }
+        goto done;
     }
 
     for (fake_open = fakes; fake_open->filename; fake_open++) {
@@ -255,7 +266,7 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname,
     if (fake_open->filename) {
         const char *tmpdir;
         char filename[PATH_MAX];
-        int fd, r;
+        int fd;
 
         /* create temporary file to map stat to */
         tmpdir = getenv("TMPDIR");
@@ -265,55 +276,37 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname,
         snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXXX", tmpdir);
         fd = mkstemp(filename);
         if (fd < 0) {
-            return fd;
+            ret = -TARGET_ENOENT;
+            goto done;
         }
         unlink(filename);
 
-        r = fake_open->fill(cpu_env, fd);
-        if (r) {
-            int e = errno;
+        ret = fake_open->fill(cpu_env, fd);
+        if (ret) {
+            ret = get_errno(ret);
             close(fd);
-            errno = e;
-            return r;
+            goto done;
         }
         lseek(fd, 0, SEEK_SET);
-
-        return fd;
+        ret = fd;
+        goto done;
     }
 
-    return safe_openat(dirfd, path(pathname), flags, mode);
+    ret = get_errno(safe_openat(dirfd, path(pathname), flags, mode));
+ done:
+    fd_trans_unregister(ret);
+    unlock_user(pathname, target_path, 0);
+    return ret;
 }
 
 #ifdef TARGET_NR_open
 SYSCALL_IMPL(open)
 {
-    char *p = lock_user_string(arg1);
-    abi_long ret;
-
-    if (!p) {
-        return -TARGET_EFAULT;
-    }
-    ret = get_errno(do_openat(cpu_env, AT_FDCWD, p,
-                              target_to_host_bitmask(arg2, fcntl_flags_tbl),
-                              arg3));
-    fd_trans_unregister(ret);
-    unlock_user(p, arg1, 0);
-    return ret;
+    return do_openat(cpu_env, AT_FDCWD, arg1, arg2, arg3);
 }
 #endif
 
 SYSCALL_IMPL(openat)
 {
-    char *p = lock_user_string(arg2);
-    abi_long ret;
-
-    if (!p) {
-        return -TARGET_EFAULT;
-    }
-    ret = get_errno(do_openat(cpu_env, arg1, p,
-                              target_to_host_bitmask(arg3, fcntl_flags_tbl),
-                              arg4));
-    fd_trans_unregister(ret);
-    unlock_user(p, arg2, 0);
-    return ret;
+    return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
-- 
2.17.2
