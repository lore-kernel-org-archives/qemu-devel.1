Received: from eggs.gnu.org ([2001:4830:134:3::10]:41329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfa-0004Hb-9c
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfY-0004Yq-IL
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:30 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfY-0004Xw-3O
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:28 -0400
Received: by mail-pf0-x243.google.com with SMTP id b74-v6so8494653pfl.5
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:59 -1000
Message-Id: <20180610030220.3777-88-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 087/108] linux-user: Split out xattr syscalls
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

This includes fgetxattr, flistxattr, fremovexattr, fsetxattr,
getxattr, lgetxattr, listxattr, llistxattr, lremovexattr,
lsetxattr, removexattr, setxattr.

All targets define all of these; simplify the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 453 +++++++++++++++++++++++++++----------------
 1 file changed, 291 insertions(+), 162 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0897449273..c37af32bb6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8328,6 +8328,46 @@ IMPL(fdatasync)
     return get_errno(fdatasync(arg1));
 }
 
+#ifdef CONFIG_ATTR
+IMPL(fgetxattr)
+{
+    void *n, *v = 0;
+    abi_long ret;
+
+    if (arg3) {
+        v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (!v) {
+            return -TARGET_EFAULT;
+        }
+    }
+    n = lock_user_string(arg2);
+    if (n) {
+        ret = get_errno(fgetxattr(arg1, n, v, arg4));
+    } else {
+        ret = -TARGET_EFAULT;
+    }
+    unlock_user(n, arg2, 0);
+    unlock_user(v, arg3, arg4);
+    return ret;
+}
+
+IMPL(flistxattr)
+{
+    void *b = 0;
+    abi_long ret;
+
+    if (arg2) {
+        b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+        if (!b) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(flistxattr(arg1, b, arg3));
+    unlock_user(b, arg2, arg3);
+    return ret;
+}
+#endif
+
 IMPL(flock)
 {
     /* The flock constant seems to be the same for every Linux platform. */
@@ -8341,6 +8381,45 @@ IMPL(fork)
 }
 #endif
 
+#ifdef CONFIG_ATTR
+IMPL(fremovexattr)
+{
+    void *n;
+    abi_long ret;
+
+    n = lock_user_string(arg2);
+    if (n) {
+        ret = get_errno(fremovexattr(arg1, n));
+    } else {
+        ret = -TARGET_EFAULT;
+    }
+    unlock_user(n, arg2, 0);
+    return ret;
+}
+
+IMPL(fsetxattr)
+{
+    void *n, *v = 0;
+    abi_long ret;
+
+    if (arg3) {
+        v = lock_user(VERIFY_READ, arg3, arg4, 1);
+        if (!v) {
+            return -TARGET_EFAULT;
+        }
+    }
+    n = lock_user_string(arg2);
+    if (n) {
+        ret = get_errno(fsetxattr(arg1, n, v, arg4, arg5));
+    } else {
+        ret = -TARGET_EFAULT;
+    }
+    unlock_user(n, arg2, 0);
+    unlock_user(v, arg3, 0);
+    return ret;
+}
+#endif
+
 IMPL(fstat)
 {
     struct stat st;
@@ -8981,6 +9060,32 @@ IMPL(getuid32)
 }
 #endif
 
+#ifdef CONFIG_ATTR
+IMPL(getxattr)
+{
+    void *p, *n, *v = 0;
+    abi_long ret;
+
+    if (arg3) {
+        v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (!v) {
+            return -TARGET_EFAULT;
+        }
+    }
+    p = lock_user_string(arg1);
+    n = lock_user_string(arg2);
+    if (p && n) {
+        ret = get_errno(getxattr(p, n, v, arg4));
+    } else {
+        ret = -TARGET_EFAULT;
+    }
+    unlock_user(p, arg1, 0);
+    unlock_user(n, arg2, 0);
+    unlock_user(v, arg3, arg4);
+    return ret;
+}
+#endif
+
 #if defined(TARGET_NR_getxgid) && defined(TARGET_ALPHA)
 IMPL(getxgid)
 {
@@ -9212,6 +9317,32 @@ IMPL(lchown32)
 }
 #endif
 
+#ifdef CONFIG_ATTR
+IMPL(lgetxattr)
+{
+    void *p, *n, *v = 0;
+    abi_long ret;
+
+    if (arg3) {
+        v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (!v) {
+            return -TARGET_EFAULT;
+        }
+    }
+    p = lock_user_string(arg1);
+    n = lock_user_string(arg2);
+    if (p && n) {
+        ret = get_errno(lgetxattr(p, n, v, arg4));
+    } else {
+        ret = -TARGET_EFAULT;
+    }
+    unlock_user(p, arg1, 0);
+    unlock_user(n, arg2, 0);
+    unlock_user(v, arg3, arg4);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_link
 IMPL(link)
 {
@@ -9249,6 +9380,50 @@ IMPL(listen)
 }
 #endif
 
+#ifdef CONFIG_ATTR
+IMPL(listxattr)
+{
+    void *p = lock_user_string(arg1);
+    void *b = 0;
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    if (arg2) {
+        b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+        if (!b) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(listxattr(p, b, arg3));
+    unlock_user(p, arg1, 0);
+    unlock_user(b, arg2, arg3);
+    return ret;
+}
+
+IMPL(llistxattr)
+{
+    void *p = lock_user_string(arg1);
+    void *b = 0;
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    if (arg2) {
+        b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+        if (!b) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(llistxattr(p, b, arg3));
+    unlock_user(p, arg1, 0);
+    unlock_user(b, arg2, arg3);
+    return ret;
+}
+#endif
+
 /* Older kernel ports have _llseek() instead of llseek() */
 #if defined(TARGET_NR__llseek) && !defined(TARGET_NR_llseek)
 #define TARGET_NR_llseek TARGET_NR__llseek
@@ -9270,11 +9445,54 @@ IMPL(llseek)
 }
 #endif
 
+#ifdef CONFIG_ATTR
+IMPL(lremovexattr)
+{
+    char *p = lock_user_string(arg1);
+    char *n = lock_user_string(arg2);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p && n) {
+        ret = get_errno(lremovexattr(p, n));
+    }
+    unlock_user(p, arg1, 0);
+    unlock_user(n, arg2, 0);
+    return ret;
+}
+#endif
+
 IMPL(lseek)
 {
     return get_errno(lseek(arg1, arg2, arg3));
 }
 
+#ifdef CONFIG_ATTR
+IMPL(lsetxattr)
+{
+    char *p, *n;
+    void *v = 0;
+    abi_long ret;
+
+    if (arg3) {
+        v = lock_user(VERIFY_READ, arg3, arg4, 1);
+        if (!v) {
+            return -TARGET_EFAULT;
+        }
+    }
+    p = lock_user_string(arg1);
+    n = lock_user_string(arg2);
+    if (p && n) {
+        ret = get_errno(lsetxattr(p, n, v, arg4, arg5));
+    } else {
+        ret = -TARGET_EFAULT;
+    }
+    unlock_user(p, arg1, 0);
+    unlock_user(n, arg2, 0);
+    unlock_user(v, arg3, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_lstat
 IMPL(lstat)
 {
@@ -10428,6 +10646,22 @@ IMPL(recvmsg)
 }
 #endif
 
+#ifdef CONFIG_ATTR
+IMPL(removexattr)
+{
+    char *p = lock_user_string(arg1);
+    char *n = lock_user_string(arg2);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p && n) {
+        ret = get_errno(removexattr(p, n));
+    }
+    unlock_user(p, arg1, 0);
+    unlock_user(n, arg2, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_rename
 IMPL(rename)
 {
@@ -11277,6 +11511,33 @@ IMPL(setuid32)
 }
 #endif
 
+#ifdef CONFIG_ATTR
+IMPL(setxattr)
+{
+    char *p, *n;
+    void *v = 0;
+    abi_long ret;
+
+    if (arg3) {
+        v = lock_user(VERIFY_READ, arg3, arg4, 1);
+        if (!v) {
+            return -TARGET_EFAULT;
+        }
+    }
+    p = lock_user_string(arg1);
+    n = lock_user_string(arg2);
+    if (p && n) {
+        ret = get_errno(setxattr(p, n, v, arg4, arg5));
+    } else {
+        ret = -TARGET_EFAULT;
+    }
+    unlock_user(p, arg1, 0);
+    unlock_user(n, arg2, 0);
+    unlock_user(v, arg3, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_sigaction
 IMPL(sigaction)
 {
@@ -12203,168 +12464,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef CONFIG_ATTR
-#ifdef TARGET_NR_setxattr
-    case TARGET_NR_listxattr:
-    case TARGET_NR_llistxattr:
-    {
-        void *p, *b = 0;
-        if (arg2) {
-            b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!b) {
-                return -TARGET_EFAULT;
-            }
-        }
-        p = lock_user_string(arg1);
-        if (p) {
-            if (num == TARGET_NR_listxattr) {
-                ret = get_errno(listxattr(p, b, arg3));
-            } else {
-                ret = get_errno(llistxattr(p, b, arg3));
-            }
-        } else {
-            ret = -TARGET_EFAULT;
-        }
-        unlock_user(p, arg1, 0);
-        unlock_user(b, arg2, arg3);
-        return ret;
-    }
-    case TARGET_NR_flistxattr:
-    {
-        void *b = 0;
-        if (arg2) {
-            b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!b) {
-                return -TARGET_EFAULT;
-            }
-        }
-        ret = get_errno(flistxattr(arg1, b, arg3));
-        unlock_user(b, arg2, arg3);
-        return ret;
-    }
-    case TARGET_NR_setxattr:
-    case TARGET_NR_lsetxattr:
-        {
-            void *p, *n, *v = 0;
-            if (arg3) {
-                v = lock_user(VERIFY_READ, arg3, arg4, 1);
-                if (!v) {
-                    return -TARGET_EFAULT;
-                }
-            }
-            p = lock_user_string(arg1);
-            n = lock_user_string(arg2);
-            if (p && n) {
-                if (num == TARGET_NR_setxattr) {
-                    ret = get_errno(setxattr(p, n, v, arg4, arg5));
-                } else {
-                    ret = get_errno(lsetxattr(p, n, v, arg4, arg5));
-                }
-            } else {
-                ret = -TARGET_EFAULT;
-            }
-            unlock_user(p, arg1, 0);
-            unlock_user(n, arg2, 0);
-            unlock_user(v, arg3, 0);
-        }
-        return ret;
-    case TARGET_NR_fsetxattr:
-        {
-            void *n, *v = 0;
-            if (arg3) {
-                v = lock_user(VERIFY_READ, arg3, arg4, 1);
-                if (!v) {
-                    return -TARGET_EFAULT;
-                }
-            }
-            n = lock_user_string(arg2);
-            if (n) {
-                ret = get_errno(fsetxattr(arg1, n, v, arg4, arg5));
-            } else {
-                ret = -TARGET_EFAULT;
-            }
-            unlock_user(n, arg2, 0);
-            unlock_user(v, arg3, 0);
-        }
-        return ret;
-    case TARGET_NR_getxattr:
-    case TARGET_NR_lgetxattr:
-        {
-            void *p, *n, *v = 0;
-            if (arg3) {
-                v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
-                if (!v) {
-                    return -TARGET_EFAULT;
-                }
-            }
-            p = lock_user_string(arg1);
-            n = lock_user_string(arg2);
-            if (p && n) {
-                if (num == TARGET_NR_getxattr) {
-                    ret = get_errno(getxattr(p, n, v, arg4));
-                } else {
-                    ret = get_errno(lgetxattr(p, n, v, arg4));
-                }
-            } else {
-                ret = -TARGET_EFAULT;
-            }
-            unlock_user(p, arg1, 0);
-            unlock_user(n, arg2, 0);
-            unlock_user(v, arg3, arg4);
-        }
-        return ret;
-    case TARGET_NR_fgetxattr:
-        {
-            void *n, *v = 0;
-            if (arg3) {
-                v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
-                if (!v) {
-                    return -TARGET_EFAULT;
-                }
-            }
-            n = lock_user_string(arg2);
-            if (n) {
-                ret = get_errno(fgetxattr(arg1, n, v, arg4));
-            } else {
-                ret = -TARGET_EFAULT;
-            }
-            unlock_user(n, arg2, 0);
-            unlock_user(v, arg3, arg4);
-        }
-        return ret;
-    case TARGET_NR_removexattr:
-    case TARGET_NR_lremovexattr:
-        {
-            void *p, *n;
-            p = lock_user_string(arg1);
-            n = lock_user_string(arg2);
-            if (p && n) {
-                if (num == TARGET_NR_removexattr) {
-                    ret = get_errno(removexattr(p, n));
-                } else {
-                    ret = get_errno(lremovexattr(p, n));
-                }
-            } else {
-                ret = -TARGET_EFAULT;
-            }
-            unlock_user(p, arg1, 0);
-            unlock_user(n, arg2, 0);
-        }
-        return ret;
-    case TARGET_NR_fremovexattr:
-        {
-            void *n;
-            n = lock_user_string(arg2);
-            if (n) {
-                ret = get_errno(fremovexattr(arg1, n));
-            } else {
-                ret = -TARGET_EFAULT;
-            }
-            unlock_user(n, arg2, 0);
-        }
-        return ret;
-#endif
-#endif /* CONFIG_ATTR */
 #ifdef TARGET_NR_set_thread_area
     case TARGET_NR_set_thread_area:
 #if defined(TARGET_MIPS)
@@ -13253,9 +13352,17 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(fcntl64);
 #endif
         SYSCALL(fdatasync);
+#ifdef CONFIG_ATTR
+        SYSCALL(fgetxattr);
+        SYSCALL(flistxattr);
+#endif
         SYSCALL(flock);
 #ifdef TARGET_NR_fork
         SYSCALL(fork);
+#endif
+#ifdef CONFIG_ATTR
+        SYSCALL(fremovexattr);
+        SYSCALL(fsetxattr);
 #endif
         SYSCALL(fstat);
 #ifdef TARGET_NR_fstat64
@@ -13354,6 +13461,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_getuid32
         SYSCALL(getuid32);
 #endif
+#ifdef CONFIG_ATTR
+        SYSCALL(getxattr);
+#endif
 #if defined(TARGET_NR_getxgid) && defined(TARGET_ALPHA)
         SYSCALL(getxgid);
 #endif
@@ -13374,17 +13484,30 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_lchown32
         SYSCALL(lchown32);
 #endif
+#ifdef CONFIG_ATTR
+        SYSCALL(lgetxattr);
+#endif
 #ifdef TARGET_NR_link
         SYSCALL(link);
 #endif
         SYSCALL(linkat);
+#ifdef CONFIG_ATTR
+        SYSCALL(listxattr);
+        SYSCALL(llistxattr);
+#endif
 #ifdef TARGET_NR_listen
         SYSCALL(listen);
 #endif
 #ifdef TARGET_NR_llseek
         SYSCALL(llseek);
+#endif
+#ifdef CONFIG_ATTR
+        SYSCALL(lremovexattr);
 #endif
         SYSCALL(lseek);
+#ifdef CONFIG_ATTR
+        SYSCALL(lsetxattr);
+#endif
 #ifdef TARGET_NR_lstat
         SYSCALL(lstat);
 #endif
@@ -13498,6 +13621,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_recvmsg
         SYSCALL(recvmsg);
 #endif
+#ifdef CONFIG_ATTR
+        SYSCALL(removexattr);
+#endif
 #ifdef TARGET_NR_rename
         SYSCALL(rename);
 #endif
@@ -13629,6 +13755,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_setuid32
         SYSCALL(setuid32);
 #endif
+#ifdef CONFIG_ATTR
+        SYSCALL(setxattr);
+#endif
 #ifdef TARGET_NR_sigaction
         SYSCALL(sigaction);
 #endif
-- 
2.17.1
