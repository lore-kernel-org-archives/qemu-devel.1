Received: from eggs.gnu.org ([209.51.188.92]:55848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbk3-0004qb-Ix
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbk2-0004EU-JZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:55 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbk2-0004Dq-DI
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:54 -0500
Received: by mail-pl1-x641.google.com with SMTP id e5so6883429plb.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:31:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:44 +1100
Message-Id: <20190118213122.22865-11-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 11/49] linux-user: Split out pread64,
 pwrite64
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
 linux-user/syscall-defs.h     |  6 ++++
 linux-user/syscall-file.inc.c | 62 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 36 --------------------
 linux-user/strace.list        |  6 ----
 4 files changed, 68 insertions(+), 42 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 130ba7e344..027793d5d0 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -21,6 +21,12 @@ SYSCALL_DEF(close, ARG_DEC);
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+SYSCALL_DEF_FULL(pread64, .impl = impl_pread64,
+                 .args = args_pread64_pwrite64,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
+SYSCALL_DEF_FULL(pwrite64, .impl = impl_pwrite64,
+                 .args = args_pread64_pwrite64,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
 SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlink
 SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 9bd21ac5cd..e79cfabf56 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -317,6 +317,68 @@ SYSCALL_IMPL(openat)
     return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
 
+/*
+ * Both pread64 and pwrite64 merge args into a 64-bit offset,
+ * but the input registers and ordering are target specific.
+ */
+#if TARGET_ABI_BITS == 32
+SYSCALL_ARGS(pread64_pwrite64)
+{
+    /* We have already assigned out[0-2].  */
+    int off = regpairs_aligned(cpu_env, TARGET_NR_pread64);
+    out[3] = target_offset64(in[3 + off], in[4 + off]);
+    return def;
+}
+#else
+#define args_pread64_pwrite64 NULL
+#endif
+
+SYSCALL_IMPL(pread64)
+{
+    int fd = arg1;
+    abi_ulong target_buf = arg2;
+    abi_ulong len = arg3;
+    uint64_t off = arg4;
+    void *p;
+    abi_long ret;
+
+    if (target_buf == 0 && len == 0) {
+        /* Special-case NULL buffer and zero length, which should succeed */
+        p = NULL;
+    } else {
+        p = lock_user(VERIFY_WRITE, target_buf, len, 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(pread64(fd, p, len, off));
+    unlock_user(p, target_buf, ret);
+    return ret;
+}
+
+SYSCALL_IMPL(pwrite64)
+{
+    int fd = arg1;
+    abi_ulong target_buf = arg2;
+    abi_ulong len = arg3;
+    uint64_t off = arg4;
+    void *p;
+    abi_long ret;
+
+    if (target_buf == 0 && len == 0) {
+        /* Special-case NULL buffer and zero length, which should succeed */
+        p = 0;
+    } else {
+        p = lock_user(VERIFY_READ, target_buf, len, 1);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(pwrite64(fd, p, len, off));
+    unlock_user(p, target_buf, 0);
+    return ret;
+}
+
 SYSCALL_IMPL(read)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index df47ee106e..80806c0150 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9312,42 +9312,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
 #error unreachable
 #endif
-#endif
-#ifdef TARGET_NR_pread64
-    case TARGET_NR_pread64:
-        if (regpairs_aligned(cpu_env, num)) {
-            arg4 = arg5;
-            arg5 = arg6;
-        }
-        if (arg2 == 0 && arg3 == 0) {
-            /* Special-case NULL buffer and zero length, which should succeed */
-            p = 0;
-        } else {
-            p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!p) {
-                return -TARGET_EFAULT;
-            }
-        }
-        ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
-        unlock_user(p, arg2, ret);
-        return ret;
-    case TARGET_NR_pwrite64:
-        if (regpairs_aligned(cpu_env, num)) {
-            arg4 = arg5;
-            arg5 = arg6;
-        }
-        if (arg2 == 0 && arg3 == 0) {
-            /* Special-case NULL buffer and zero length, which should succeed */
-            p = 0;
-        } else {
-            p = lock_user(VERIFY_READ, arg2, arg3, 1);
-            if (!p) {
-                return -TARGET_EFAULT;
-            }
-        }
-        ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
-        unlock_user(p, arg2, 0);
-        return ret;
 #endif
     case TARGET_NR_getcwd:
         if (!(p = lock_user(VERIFY_WRITE, arg1, arg2, 0)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index e02a854cea..c7e573669d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1025,9 +1025,6 @@
 #ifdef TARGET_NR_prctl
 { TARGET_NR_prctl, "prctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pread64
-{ TARGET_NR_pread64, "pread64" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_preadv
 { TARGET_NR_preadv, "preadv" , NULL, NULL, NULL },
 #endif
@@ -1055,9 +1052,6 @@
 #ifdef TARGET_NR_putpmsg
 { TARGET_NR_putpmsg, "putpmsg" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pwrite64
-{ TARGET_NR_pwrite64, "pwrite64" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_pwritev
 { TARGET_NR_pwritev, "pwritev" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
