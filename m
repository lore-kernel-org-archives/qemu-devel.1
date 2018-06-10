Received: from eggs.gnu.org ([2001:4830:134:3::10]:40799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeT-0003Av-DW
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeQ-0003kI-4u
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:21 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:41585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeP-0003jz-Sw
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:18 -0400
Received: by mail-pl0-x243.google.com with SMTP id az12-v6so10380339plb.8
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:23 -1000
Message-Id: <20180610030220.3777-52-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 051/108] linux-user: Split out fstat, lstat,
 stat
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
 linux-user/syscall.c | 129 +++++++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 47 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c8fc7fc908..4f6c01092b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7052,6 +7052,31 @@ static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
     return 0;
 }
 
+static abi_long host_to_target_stat(abi_ulong target_addr, struct stat *st)
+{
+    struct target_stat *target_st;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_st, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    memset(target_st, 0, sizeof(*target_st));
+    __put_user(st->st_dev, &target_st->st_dev);
+    __put_user(st->st_ino, &target_st->st_ino);
+    __put_user(st->st_mode, &target_st->st_mode);
+    __put_user(st->st_uid, &target_st->st_uid);
+    __put_user(st->st_gid, &target_st->st_gid);
+    __put_user(st->st_nlink, &target_st->st_nlink);
+    __put_user(st->st_rdev, &target_st->st_rdev);
+    __put_user(st->st_size, &target_st->st_size);
+    __put_user(st->st_blksize, &target_st->st_blksize);
+    __put_user(st->st_blocks, &target_st->st_blocks);
+    __put_user(st->st_atime, &target_st->target_st_atime);
+    __put_user(st->st_mtime, &target_st->target_st_mtime);
+    __put_user(st->st_ctime, &target_st->target_st_ctime);
+    unlock_user_struct(target_st, target_addr, 1);
+    return 0;
+}
+
 static inline abi_long host_to_target_stat64(void *cpu_env,
                                              abi_ulong target_addr,
                                              struct stat *host_st)
@@ -8100,6 +8125,18 @@ IMPL(fork)
 }
 #endif
 
+IMPL(fstat)
+{
+    struct stat st;
+    abi_long ret;
+
+    ret = get_errno(fstat(arg1, &st));
+    if (!is_error(ret) && host_to_target_stat(arg2, &st)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
 IMPL(fstatfs)
 {
     struct statfs stfs;
@@ -8435,6 +8472,25 @@ IMPL(lseek)
     return get_errno(lseek(arg1, arg2, arg3));
 }
 
+#ifdef TARGET_NR_lstat
+IMPL(lstat)
+{
+    char *p = lock_user_string(arg1);
+    struct stat st;
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(lstat(path(p), &st));
+    unlock_user(p, arg1, 0);
+    if (!is_error(ret) && host_to_target_stat(arg2, &st)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_mkdir
 IMPL(mkdir)
 {
@@ -9781,6 +9837,25 @@ IMPL(ssetmask)
 }
 #endif
 
+#ifdef TARGET_NR_stat
+IMPL(stat)
+{
+    char *p = lock_user_string(arg1);
+    struct stat st;
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(stat(path(p), &st));
+    unlock_user(p, arg1, 0);
+    if (!is_error(ret) && host_to_target_stat(arg2, &st)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 IMPL(statfs)
 {
     char *p = lock_user_string(arg1);
@@ -10153,53 +10228,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_stat
-    case TARGET_NR_stat:
-        if (!(p = lock_user_string(arg1))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(stat(path(p), &st));
-        unlock_user(p, arg1, 0);
-        goto do_stat;
-#endif
-#ifdef TARGET_NR_lstat
-    case TARGET_NR_lstat:
-        if (!(p = lock_user_string(arg1))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(lstat(path(p), &st));
-        unlock_user(p, arg1, 0);
-        goto do_stat;
-#endif
-    case TARGET_NR_fstat:
-        {
-            ret = get_errno(fstat(arg1, &st));
-#if defined(TARGET_NR_stat) || defined(TARGET_NR_lstat)
-        do_stat:
-#endif
-            if (!is_error(ret)) {
-                struct target_stat *target_st;
-
-                if (!lock_user_struct(VERIFY_WRITE, target_st, arg2, 0))
-                    return -TARGET_EFAULT;
-                memset(target_st, 0, sizeof(*target_st));
-                __put_user(st.st_dev, &target_st->st_dev);
-                __put_user(st.st_ino, &target_st->st_ino);
-                __put_user(st.st_mode, &target_st->st_mode);
-                __put_user(st.st_uid, &target_st->st_uid);
-                __put_user(st.st_gid, &target_st->st_gid);
-                __put_user(st.st_nlink, &target_st->st_nlink);
-                __put_user(st.st_rdev, &target_st->st_rdev);
-                __put_user(st.st_size, &target_st->st_size);
-                __put_user(st.st_blksize, &target_st->st_blksize);
-                __put_user(st.st_blocks, &target_st->st_blocks);
-                __put_user(st.st_atime, &target_st->target_st_atime);
-                __put_user(st.st_mtime, &target_st->target_st_mtime);
-                __put_user(st.st_ctime, &target_st->target_st_ctime);
-                unlock_user_struct(target_st, arg2, 1);
-            }
-        }
-        return ret;
     case TARGET_NR_vhangup:
         return get_errno(vhangup());
 #ifdef TARGET_NR_syscall
@@ -12873,6 +12901,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_fork
         SYSCALL(fork);
 #endif
+        SYSCALL(fstat);
         SYSCALL(fstatfs);
 #ifdef TARGET_NR_fstatfs64
         SYSCALL(fstatfs64);
@@ -12918,6 +12947,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(listen);
 #endif
         SYSCALL(lseek);
+#ifdef TARGET_NR_lstat
+        SYSCALL(lstat);
+#endif
 #ifdef TARGET_NR_mkdir
         SYSCALL(mkdir);
 #endif
@@ -13062,6 +13094,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #ifdef TARGET_NR_ssetmask
         SYSCALL(ssetmask);
+#endif
+#ifdef TARGET_NR_stat
+        SYSCALL(stat);
 #endif
         SYSCALL(statfs);
 #ifdef TARGET_NR_statfs64
-- 
2.17.1
