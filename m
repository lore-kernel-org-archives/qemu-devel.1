Received: from eggs.gnu.org ([2001:4830:134:3::10]:40885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqee-0003JH-QT
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqed-0003od-GC
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:32 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:45642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqed-0003oP-8E
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:31 -0400
Received: by mail-pf0-x241.google.com with SMTP id a22-v6so8480163pfo.12
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:29 -1000
Message-Id: <20180610030220.3777-58-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 057/108] linux-user: Split out modify_ldt,
 setdomainname, uname
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

At the same time, merge do_modify_ldt into the new function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 123 +++++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 57 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 41facf4b44..4967b84f21 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5755,7 +5755,6 @@ static bitmask_transtbl mmap_flags_tbl[] = {
 };
 
 #if defined(TARGET_I386)
-
 /* NOTE: there is really one LDT for all the threads */
 static uint8_t *ldt_table;
 
@@ -5870,29 +5869,6 @@ install:
     return 0;
 }
 
-/* specific and weird i386 syscalls */
-static abi_long do_modify_ldt(CPUX86State *env, int func, abi_ulong ptr,
-                              unsigned long bytecount)
-{
-    abi_long ret;
-
-    switch (func) {
-    case 0:
-        ret = read_ldt(ptr, bytecount);
-        break;
-    case 1:
-        ret = write_ldt(env, ptr, bytecount, 1);
-        break;
-    case 0x11:
-        ret = write_ldt(env, ptr, bytecount, 0);
-        break;
-    default:
-        ret = -TARGET_ENOSYS;
-        break;
-    }
-    return ret;
-}
-
 #if defined(TARGET_I386) && defined(TARGET_ABI32)
 abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr)
 {
@@ -8614,6 +8590,28 @@ IMPL(mmap2)
 }
 #endif
 
+#ifdef TARGET_I386
+/* ??? Other TARGET_NR_modify_ldt should be deleted.  */
+IMPL(modify_ldt)
+{
+    CPUX86State *env = cpu_env;
+    int func = arg1;
+    abi_ulong ptr = arg2;
+    abi_ulong bytecount = arg3;
+
+    switch (func) {
+    case 0:
+        return read_ldt(ptr, bytecount);
+    case 1:
+        return write_ldt(env, ptr, bytecount, 1);
+    case 0x11:
+        return write_ldt(env, ptr, bytecount, 0);
+    default:
+        return -TARGET_ENOSYS;
+    }
+}
+#endif
+
 IMPL(mount)
 {
     char *p1 = NULL, *p2, *p3 = NULL;
@@ -9498,6 +9496,19 @@ IMPL(sendto)
 }
 #endif
 
+IMPL(setdomainname)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setdomainname(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 IMPL(sethostname)
 {
     char *p = lock_user_string(arg1);
@@ -10206,6 +10217,31 @@ IMPL(umount2)
     return ret;
 }
 
+IMPL(uname)
+{
+    struct new_utsname *buf;
+    abi_long ret;
+
+    if (!lock_user_struct(VERIFY_WRITE, buf, arg1, 0)) {
+        return -TARGET_EFAULT;
+    }
+    /* No need to transcode because we use the linux syscall.  */
+    ret = get_errno(sys_uname(buf));
+    if (!is_error(ret)) {
+        /* Overwrite the native machine name with whatever is being
+           emulated. */
+        g_strlcpy(buf->machine, cpu_to_uname_machine(cpu_env),
+                  sizeof(buf->machine));
+        /* Allow the user to override the reported release.  */
+        if (qemu_uname_release && *qemu_uname_release) {
+            g_strlcpy(buf->release, qemu_uname_release,
+                      sizeof(buf->release));
+        }
+    }
+    unlock_user_struct(buf, arg1, 1);
+    return ret;
+}
+
 #ifdef TARGET_NR_unlink
 IMPL(unlink)
 {
@@ -10384,41 +10420,9 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_setdomainname:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(setdomainname(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-    case TARGET_NR_uname:
-        /* no need to transcode because we use the linux syscall */
-        {
-            struct new_utsname * buf;
-
-            if (!lock_user_struct(VERIFY_WRITE, buf, arg1, 0))
-                return -TARGET_EFAULT;
-            ret = get_errno(sys_uname(buf));
-            if (!is_error(ret)) {
-                /* Overwrite the native machine name with whatever is being
-                   emulated. */
-                g_strlcpy(buf->machine, cpu_to_uname_machine(cpu_env),
-                          sizeof(buf->machine));
-                /* Allow the user to override the reported release.  */
-                if (qemu_uname_release && *qemu_uname_release) {
-                    g_strlcpy(buf->release, qemu_uname_release,
-                              sizeof(buf->release));
-                }
-            }
-            unlock_user_struct(buf, arg1, 1);
-        }
-        return ret;
-#ifdef TARGET_I386
-    case TARGET_NR_modify_ldt:
-        return do_modify_ldt(cpu_env, arg1, arg2, arg3);
-#if !defined(TARGET_X86_64)
+#if defined(TARGET_I386) && !defined(TARGET_X86_64)
     case TARGET_NR_vm86:
         return do_vm86(cpu_env, arg1, arg2);
-#endif
 #endif
     case TARGET_NR_adjtimex:
         {
@@ -12986,6 +12990,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #ifdef TARGET_NR_mmap2
         SYSCALL(mmap2);
+#endif
+#ifdef TARGET_I386
+        SYSCALL(modify_ldt);
 #endif
         SYSCALL(mount);
         SYSCALL(mprotect);
@@ -13112,6 +13119,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_sendto
         SYSCALL(sendto);
 #endif
+        SYSCALL(setdomainname);
         SYSCALL(sethostname);
         SYSCALL(setitimer);
         SYSCALL(setpgid);
@@ -13181,6 +13189,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(umount);
 #endif
         SYSCALL(umount2);
+        SYSCALL(uname);
 #ifdef TARGET_NR_unlink
         SYSCALL(unlink);
 #endif
-- 
2.17.1
