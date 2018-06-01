Received: from eggs.gnu.org ([2001:4830:134:3::10]:57539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWv-0005dJ-IO
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWu-0000ZA-Ku
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:21 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWu-0000Ya-DS
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:20 -0400
Received: by mail-pf0-x243.google.com with SMTP id x9-v6so12086226pfm.2
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:35 -0700
Message-Id: <20180601073050.8054-19-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/33] linux-user: Split out chdir, mknod,
 mknodat, time, chmod
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
 linux-user/syscall.c | 132 ++++++++++++++++++++++++++++---------------
 1 file changed, 87 insertions(+), 45 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bbe9d6d9fb..88e0da31ba 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7899,6 +7899,34 @@ IMPL(brk)
     return do_brk(arg1);
 }
 
+IMPL(chdir)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(chdir(p));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_chmod
+IMPL(chmod)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(chmod(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 IMPL(close)
 {
     if (is_hostfd(arg1)) {
@@ -8115,6 +8143,40 @@ IMPL(linkat)
 }
 #endif
 
+#ifdef TARGET_NR_mknod
+IMPL(mknod)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mknod(p, arg2, arg3));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_mknodat
+IMPL(mknodat)
+{
+    char *p;
+    abi_long ret;
+
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    p = lock_user_string(arg2);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mknodat(arg1, p, arg3, arg4));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+#endif
+
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 IMPL(name_to_handle_at)
 {
@@ -8276,6 +8338,18 @@ IMPL(read)
     return ret;
 }
 
+#ifdef TARGET_NR_time
+IMPL(time)
+{
+    time_t host_time;
+    abi_long ret = get_errno(time(&host_time));
+    if (!is_error(ret) && arg1 && put_user_sal(host_time, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_unlink
 IMPL(unlink)
 {
@@ -8386,51 +8460,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-    case TARGET_NR_chdir:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chdir(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#ifdef TARGET_NR_time
-    case TARGET_NR_time:
-        {
-            time_t host_time;
-            ret = get_errno(time(&host_time));
-            if (!is_error(ret)
-                && arg1
-                && put_user_sal(host_time, arg1))
-                return -TARGET_EFAULT;
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_mknod
-    case TARGET_NR_mknod:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mknod(p, arg2, arg3));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_mknodat)
-    case TARGET_NR_mknodat:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mknodat(arg1, p, arg3, arg4));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_chmod
-    case TARGET_NR_chmod:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chmod(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_break
     case TARGET_NR_break:
         return do_unimplemented(num);
@@ -12968,6 +12997,10 @@ IMPL(everything_else)
 static impl_fn * const syscall_table[] = {
     [TARGET_NR_brk] = impl_brk,
     [TARGET_NR_close] = impl_close,
+    [TARGET_NR_chdir] = impl_chdir,
+#ifdef TARGET_NR_chmod
+    [TARGET_NR_chmod] = impl_chmod,
+#endif
 #ifdef TARGET_NR_creat
     [TARGET_NR_creat] = impl_creat,
 #endif
@@ -12982,6 +13015,12 @@ static impl_fn * const syscall_table[] = {
 #if defined(TARGET_NR_linkat)
     [TARGET_NR_linkat] = impl_linkat,
 #endif
+#ifdef TARGET_NR_mknod
+    [TARGET_NR_mknod] = impl_mknod,
+#endif
+#ifdef TARGET_NR_mknodat
+    [TARGET_NR_mknodat] = impl_mknodat,
+#endif
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     [TARGET_NR_name_to_handle_at] = impl_name_to_handle_at,
 #endif
@@ -12993,6 +13032,9 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_open_by_handle_at] = impl_open_by_handle_at,
 #endif
     [TARGET_NR_read] = impl_read,
+#ifdef TARGET_NR_time
+    [TARGET_NR_time] = impl_time,
+#endif
 #ifdef TARGET_NR_unlink
     [TARGET_NR_unlink] = impl_unlink,
 #endif
-- 
2.17.0
