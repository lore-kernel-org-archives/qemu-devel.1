Received: from eggs.gnu.org ([2001:4830:134:3::10]:57675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX8-0005rZ-GY
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeX7-0000mu-8K
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:34 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeX7-0000m9-0h
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:33 -0400
Received: by mail-pg0-x244.google.com with SMTP id a13-v6so10873032pgu.4
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:44 -0700
Message-Id: <20180601073050.8054-28-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 27/33] linux-user: Split out ioctl
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
 linux-user/syscall.c | 190 ++++++++++++++++++++++---------------------
 1 file changed, 97 insertions(+), 93 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bde1f9872f..4be71367fc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5759,97 +5759,6 @@ static IOCTLEntry ioctl_entries[] = {
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
-#if defined(DEBUG)
-    gemu_log("ioctl: cmd=0x%04lx (%s)\n", (long)cmd, ie->name);
-#endif
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
@@ -8231,6 +8140,102 @@ IMPL(getxpid)
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
+#if defined(DEBUG)
+    gemu_log("ioctl: cmd=0x%04lx (%s)\n", (long)cmd, ie->name);
+#endif
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
@@ -8900,8 +8905,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-    case TARGET_NR_ioctl:
-        return do_ioctl(arg1, arg2, arg3);
 #ifdef TARGET_NR_fcntl
     case TARGET_NR_fcntl:
         return do_fcntl(arg1, arg2, arg3);
@@ -12990,6 +12993,7 @@ static impl_fn * const syscall_table[] = {
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
     [TARGET_NR_getxpid] = impl_getxpid,
 #endif
+    [TARGET_NR_ioctl] = impl_ioctl,
     [TARGET_NR_kill] = impl_kill,
 #ifdef TARGET_NR_link
     [TARGET_NR_link] = impl_link,
-- 
2.17.0
