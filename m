Received: from eggs.gnu.org ([2001:4830:134:3::10]:55303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tm-0005Kz-FZ
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tl-0007GB-AE
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:42 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6Tl-0007Fw-1N
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id z25-v6so260757pgu.7
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:14 -0700
Message-Id: <20180818190118.12911-13-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 12/16] linux-user: Split out pread64,
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
 linux-user/syscall.h          | 45 +++++++++++++++++++++
 linux-user/syscall-file.inc.c | 62 ++++++++++++++++++++++++++--
 linux-user/syscall.c          | 76 +++--------------------------------
 linux-user/strace.list        |  6 ---
 4 files changed, 110 insertions(+), 79 deletions(-)

diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index f84b40d742..1d4b7ea915 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -112,3 +112,48 @@ void print_syscall_ptr_ret(const SyscallDef *def, abi_long ret);
         .name = #NAME, .args = args_##NAME, .impl = impl_##NAME, \
         .arg_type = { __VA_ARGS__ } \
     }
+
+/*
+ * Returns true if syscall NUM expects 64bit types aligned even
+ * on pairs of registers.
+ */
+static inline bool regpairs_aligned(void *cpu_env, int num)
+{
+#ifdef TARGET_ARM
+    return ((CPUARMState *)cpu_env)->eabi;
+#elif defined(TARGET_MIPS) && TARGET_ABI_BITS == 32
+    return true;
+#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
+    /* SysV AVI for PPC32 expects 64bit parameters to be passed on
+     * odd/even pairs of registers which translates to the same as
+     * we start with r3 as arg1
+     */
+    return true;
+#elif defined(TARGET_SH4)
+    /* SH4 doesn't align register pairs, except for p{read,write}64 */
+    switch (num) {
+    case TARGET_NR_pread64:
+    case TARGET_NR_pwrite64:
+        return true;
+    default:
+        return false;
+    }
+#elif defined(TARGET_XTENSA)
+    return true;
+#else
+    return false;
+#endif
+}
+
+static inline uint64_t target_offset64(abi_ulong word0, abi_ulong word1)
+{
+#if TARGET_ABI_BITS == 32
+# ifdef TARGET_WORDS_BIGENDIAN
+    return ((uint64_t)word0 << 32) | word1;
+# else
+    return ((uint64_t)word1 << 32) | word0;
+# endif
+#else
+    return word0;
+#endif
+}
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 7eb5b968e2..c75c5dea9e 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -323,6 +323,62 @@ SYSCALL_IMPL(openat)
 }
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 
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
+    void *p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(pread64(arg1, p, arg3, arg4));
+    unlock_user(p, arg2, ret);
+    return ret;
+}
+
+static const SyscallDef def_pread64 = {
+    .name = "pread64",
+    .args = args_pread64_pwrite64,
+    .impl = impl_pread64,
+    .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 }
+};
+
+SYSCALL_IMPL(pwrite64)
+{
+    void *p = lock_user(VERIFY_READ, arg2, arg3, 0);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(pwrite64(arg1, p, arg3, arg4));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
+static const SyscallDef def_pwrite64 = {
+    .name = "pwrite64",
+    .args = args_pread64_pwrite64,
+    .impl = impl_pwrite64,
+    .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 }
+};
+
 /*
  * Both preadv and pwritev merge args 4/5 into a 64-bit offset.
  * Moreover, the parts are *always* in little-endian order.
@@ -330,9 +386,9 @@ SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #if TARGET_ABI_BITS == 32
 SYSCALL_ARGS(preadv_pwritev)
 {
-    /* We have already assigned out[0-3].  */
-    abi_ulong lo = in[4], hi = in[5];
-    out[4] = ((hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
+    /* We have already assigned out[0-2].  */
+    abi_ulong lo = in[3], hi = in[4];
+    out[3] = ((hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
     return def;
 }
 #else
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 16824386fd..eb6c8465b7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -718,38 +718,6 @@ static inline int next_free_host_timer(void)
 }
 #endif
 
-/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
-#ifdef TARGET_ARM
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
-}
-#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
-/* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
- * of registers which translates to the same as ARM/MIPS, because we start with
- * r3 as arg1 */
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#elif defined(TARGET_SH4)
-/* SH4 doesn't align register pairs, except for p{read,write}64 */
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    switch (num) {
-    case TARGET_NR_pread64:
-    case TARGET_NR_pwrite64:
-        return 1;
-
-    default:
-        return 0;
-    }
-}
-#elif defined(TARGET_XTENSA)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#else
-static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
-#endif
-
 #define ERRNO_TABLE_SIZE 1200
 
 /* target_to_host_errno_table[] is initialized from
@@ -7045,22 +7013,6 @@ void syscall_init(void)
     }
 }
 
-#if TARGET_ABI_BITS == 32
-static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
-{
-#ifdef TARGET_WORDS_BIGENDIAN
-    return ((uint64_t)word0 << 32) | word1;
-#else
-    return ((uint64_t)word1 << 32) | word0;
-#endif
-}
-#else /* TARGET_ABI_BITS == 32 */
-static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
-{
-    return word0;
-}
-#endif /* TARGET_ABI_BITS != 32 */
-
 #ifdef TARGET_NR_truncate64
 static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
                                          abi_long arg2,
@@ -10232,28 +10184,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
-        if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-            return -TARGET_EFAULT;
-        ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
-        unlock_user(p, arg2, ret);
-        return ret;
-    case TARGET_NR_pwrite64:
-        if (regpairs_aligned(cpu_env, num)) {
-            arg4 = arg5;
-            arg5 = arg6;
-        }
-        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
-        unlock_user(p, arg2, 0);
-        return ret;
 #endif
     case TARGET_NR_getcwd:
         if (!(p = lock_user(VERIFY_WRITE, arg1, arg2, 0)))
@@ -12067,6 +11997,12 @@ static const SyscallDef *syscall_table(int num)
 #ifdef TARGET_NR_open
     S(open);
 #endif
+#ifdef TARGET_NR_pread64
+    S(pread64);
+#endif
+#ifdef TARGET_NR_pwrite64
+    S(pwrite64);
+#endif
 #ifdef TARGET_NR_readlink
     S(readlink);
 #endif
diff --git a/linux-user/strace.list b/linux-user/strace.list
index f41b604c63..586eb55482 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1025,9 +1025,6 @@
 #ifdef TARGET_NR_prctl
 { TARGET_NR_prctl, "prctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pread64
-{ TARGET_NR_pread64, "pread64" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_prlimit64
 { TARGET_NR_prlimit64, "prlimit64" , NULL, NULL, NULL },
 #endif
@@ -1052,9 +1049,6 @@
 #ifdef TARGET_NR_putpmsg
 { TARGET_NR_putpmsg, "putpmsg" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pwrite64
-{ TARGET_NR_pwrite64, "pwrite64" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_query_module
 { TARGET_NR_query_module, "query_module" , NULL, NULL, NULL },
 #endif
-- 
2.17.1
