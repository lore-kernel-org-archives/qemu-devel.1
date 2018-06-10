Received: from eggs.gnu.org ([2001:4830:134:3::10]:40405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdb-0002Hu-3U
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdX-0003Qr-Us
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:27 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdX-0003Qc-N2
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:23 -0400
Received: by mail-pl0-x241.google.com with SMTP id az12-v6so10379703plb.8
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:58 -1000
Message-Id: <20180610030220.3777-27-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 026/108] linux-user: Split out ioctl
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

At the same time, merge do_ioctl into the new function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 184 ++++++++++++++++++++++---------------------
 1 file changed, 94 insertions(+), 90 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 81e142f091..ebe57d86aa 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5754,94 +5754,6 @@ static IOCTLEntry ioctl_entries[] = {
     { 0, 0, },
 };
 
-/* ??? Implement proper locking for ioctls.  */
-/* do_ioctl() Must return target values and target errnos. */
-static abi_long do_ioctl(int fd, int cmd, abi_long arg)
-{
-    const IOCTLEntry *ie;
-    const argtype *arg_type;
-    abi_long ret;
-    uint8_t buf_temp[MAX_STRUCT_SIZE];
-    int target_size;
-    void *argptr;
-
-    ie = ioctl_entries;
-    for(;;) {
-        if (ie->target_cmd == 0) {
-            gemu_log("Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
-            return -TARGET_ENOSYS;
-        }
-        if (ie->target_cmd == cmd)
-            break;
-        ie++;
-    }
-    arg_type = ie->arg_type;
-    if (ie->do_ioctl) {
-        return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
-    } else if (!ie->host_cmd) {
-        /* Some architectures define BSD ioctls in their headers
-           that are not implemented in Linux.  */
-        return -TARGET_ENOSYS;
-    }
-
-    switch(arg_type[0]) {
-    case TYPE_NULL:
-        /* no argument */
-        ret = get_errno(safe_ioctl(fd, ie->host_cmd));
-        break;
-    case TYPE_PTRVOID:
-    case TYPE_INT:
-        ret = get_errno(safe_ioctl(fd, ie->host_cmd, arg));
-        break;
-    case TYPE_PTR:
-        arg_type++;
-        target_size = thunk_type_size(arg_type, 0);
-        switch(ie->access) {
-        case IOC_R:
-            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
-            if (!is_error(ret)) {
-                argptr = lock_user(VERIFY_WRITE, arg, target_size, 0);
-                if (!argptr)
-                    return -TARGET_EFAULT;
-                thunk_convert(argptr, buf_temp, arg_type, THUNK_TARGET);
-                unlock_user(argptr, arg, target_size);
-            }
-            break;
-        case IOC_W:
-            argptr = lock_user(VERIFY_READ, arg, target_size, 1);
-            if (!argptr)
-                return -TARGET_EFAULT;
-            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
-            unlock_user(argptr, arg, 0);
-            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
-            break;
-        default:
-        case IOC_RW:
-            argptr = lock_user(VERIFY_READ, arg, target_size, 1);
-            if (!argptr)
-                return -TARGET_EFAULT;
-            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
-            unlock_user(argptr, arg, 0);
-            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
-            if (!is_error(ret)) {
-                argptr = lock_user(VERIFY_WRITE, arg, target_size, 0);
-                if (!argptr)
-                    return -TARGET_EFAULT;
-                thunk_convert(argptr, buf_temp, arg_type, THUNK_TARGET);
-                unlock_user(argptr, arg, target_size);
-            }
-            break;
-        }
-        break;
-    default:
-        gemu_log("Unsupported ioctl type: cmd=0x%04lx type=%d\n",
-                 (long)cmd, arg_type[0]);
-        ret = -TARGET_ENOSYS;
-        break;
-    }
-    return ret;
-}
-
 static const bitmask_transtbl iflag_tbl[] = {
         { TARGET_IGNBRK, TARGET_IGNBRK, IGNBRK, IGNBRK },
         { TARGET_BRKINT, TARGET_BRKINT, BRKINT, BRKINT },
@@ -8179,6 +8091,99 @@ IMPL(getxpid)
 }
 #endif
 
+/* ??? Implement proper locking for ioctls.  */
+IMPL(ioctl)
+{
+    abi_long fd = arg1;
+    abi_long cmd = arg2;
+    abi_long arg = arg3;
+    const IOCTLEntry *ie;
+    const argtype *arg_type;
+    abi_long ret;
+    uint8_t buf_temp[MAX_STRUCT_SIZE];
+    int target_size;
+    void *argptr;
+
+    for (ie = ioctl_entries; ; ie++) {
+        if (ie->target_cmd == 0) {
+            gemu_log("Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
+            return -TARGET_ENOSYS;
+        }
+        if (ie->target_cmd == cmd) {
+            break;
+        }
+    }
+    arg_type = ie->arg_type;
+    if (ie->do_ioctl) {
+        return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
+    } else if (!ie->host_cmd) {
+        /* Some architectures define BSD ioctls in their headers
+           that are not implemented in Linux.  */
+        return -TARGET_ENOSYS;
+    }
+
+    switch (arg_type[0]) {
+    case TYPE_NULL:
+        /* no argument */
+        ret = get_errno(safe_ioctl(fd, ie->host_cmd));
+        break;
+    case TYPE_PTRVOID:
+    case TYPE_INT:
+        ret = get_errno(safe_ioctl(fd, ie->host_cmd, arg));
+        break;
+    case TYPE_PTR:
+        arg_type++;
+        target_size = thunk_type_size(arg_type, 0);
+        switch (ie->access) {
+        case IOC_R:
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            if (!is_error(ret)) {
+                argptr = lock_user(VERIFY_WRITE, arg, target_size, 0);
+                if (!argptr) {
+                    return -TARGET_EFAULT;
+                }
+                thunk_convert(argptr, buf_temp, arg_type, THUNK_TARGET);
+                unlock_user(argptr, arg, target_size);
+            }
+            break;
+        case IOC_W:
+            argptr = lock_user(VERIFY_READ, arg, target_size, 1);
+            if (!argptr) {
+                return -TARGET_EFAULT;
+            }
+            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+            unlock_user(argptr, arg, 0);
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            break;
+        default:
+        case IOC_RW:
+            argptr = lock_user(VERIFY_READ, arg, target_size, 1);
+            if (!argptr) {
+                return -TARGET_EFAULT;
+            }
+            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+            unlock_user(argptr, arg, 0);
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            if (!is_error(ret)) {
+                argptr = lock_user(VERIFY_WRITE, arg, target_size, 0);
+                if (!argptr) {
+                    return -TARGET_EFAULT;
+                }
+                thunk_convert(argptr, buf_temp, arg_type, THUNK_TARGET);
+                unlock_user(argptr, arg, target_size);
+            }
+            break;
+        }
+        break;
+    default:
+        gemu_log("Unsupported ioctl type: cmd=0x%04lx type=%d\n",
+                 (long)cmd, arg_type[0]);
+        ret = -TARGET_ENOSYS;
+        break;
+    }
+    return ret;
+}
+
 IMPL(kill)
 {
     return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
@@ -8784,8 +8789,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_ioctl:
-        return do_ioctl(arg1, arg2, arg3);
 #ifdef TARGET_NR_fcntl
     case TARGET_NR_fcntl:
         return do_fcntl(arg1, arg2, arg3);
@@ -12641,6 +12644,7 @@ static impl_fn *syscall_table(unsigned num)
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
         SYSCALL(getxpid);
 #endif
+        SYSCALL(ioctl);
         SYSCALL(kill);
 #ifdef TARGET_NR_link
         SYSCALL(link);
-- 
2.17.1
