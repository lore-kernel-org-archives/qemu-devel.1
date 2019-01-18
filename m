Received: from eggs.gnu.org ([209.51.188.92]:56669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblx-0006S1-8g
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblp-0006Tm-G1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:48 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbln-0005vu-PM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:45 -0500
Received: by mail-pl1-x642.google.com with SMTP id y1so6881523plp.9
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:33:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:22 +1100
Message-Id: <20190118213122.22865-49-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 49/49] linux-user: Split out fcntl, fcntl64
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

Preserving strace functionality is tricky with this one.
Rearrange to lookup structures that contain the data for
both execution and strace for each command.

Do not allow lookup of 64-bit fcntl commands from 32-bit fcntl.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h      |   6 +
 linux-user/strace.c            | 100 ----------
 linux-user/syscall-fcntl.inc.c | 322 +++++++++++++++++++++++++++++++++
 linux-user/syscall.c           | 256 +-------------------------
 linux-user/strace.list         |   6 -
 5 files changed, 329 insertions(+), 361 deletions(-)
 create mode 100644 linux-user/syscall-fcntl.inc.c

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index f58b9745a4..5cf39f2bb9 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -46,6 +46,12 @@ SYSCALL_DEF(execveat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
 SYSCALL_DEF(faccessat, ARG_ATDIRFD, ARG_STR, ARG_ACCESSFLAG);
 SYSCALL_DEF(fchmod, ARG_DEC, ARG_MODEFLAG);
 SYSCALL_DEF(fchmodat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG);
+#ifdef TARGET_NR_fcntl
+SYSCALL_DEF_FULL(fcntl, .impl = impl_fcntl, .print = print_fcntl);
+#endif
+#if TARGET_ABI_BITS == 32
+SYSCALL_DEF_FULL(fcntl64, .impl = impl_fcntl64, .print = print_fcntl64);
+#endif
 #ifdef TARGET_NR_futimesat
 SYSCALL_DEF(futimesat, ARG_ATDIRFD, ARG_STR, ARG_PTR);
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index ca8e110675..787bf41307 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1172,106 +1172,6 @@ print_fchownat(const struct syscallname *name,
 }
 #endif
 
-#if defined(TARGET_NR_fcntl) || defined(TARGET_NR_fcntl64)
-static void
-print_fcntl(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_raw_param("%d", arg0, 0);
-    switch(arg1) {
-    case TARGET_F_DUPFD:
-        gemu_log("F_DUPFD,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
-        break;
-    case TARGET_F_GETFD:
-        gemu_log("F_GETFD");
-        break;
-    case TARGET_F_SETFD:
-        gemu_log("F_SETFD,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
-        break;
-    case TARGET_F_GETFL:
-        gemu_log("F_GETFL");
-        break;
-    case TARGET_F_SETFL:
-        gemu_log("F_SETFL,");
-        print_open_flags(arg2, 1);
-        break;
-    case TARGET_F_GETLK:
-        gemu_log("F_GETLK,");
-        print_pointer(arg2, 1);
-        break;
-    case TARGET_F_SETLK:
-        gemu_log("F_SETLK,");
-        print_pointer(arg2, 1);
-        break;
-    case TARGET_F_SETLKW:
-        gemu_log("F_SETLKW,");
-        print_pointer(arg2, 1);
-        break;
-    case TARGET_F_GETOWN:
-        gemu_log("F_GETOWN");
-        break;
-    case TARGET_F_SETOWN:
-        gemu_log("F_SETOWN,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
-        break;
-    case TARGET_F_GETSIG:
-        gemu_log("F_GETSIG");
-        break;
-    case TARGET_F_SETSIG:
-        gemu_log("F_SETSIG,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
-        break;
-#if TARGET_ABI_BITS == 32
-    case TARGET_F_GETLK64:
-        gemu_log("F_GETLK64,");
-        print_pointer(arg2, 1);
-        break;
-    case TARGET_F_SETLK64:
-        gemu_log("F_SETLK64,");
-        print_pointer(arg2, 1);
-        break;
-    case TARGET_F_SETLKW64:
-        gemu_log("F_SETLKW64,");
-        print_pointer(arg2, 1);
-        break;
-#endif
-    case TARGET_F_SETLEASE:
-        gemu_log("F_SETLEASE,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
-        break;
-    case TARGET_F_GETLEASE:
-        gemu_log("F_GETLEASE");
-        break;
-    case TARGET_F_SETPIPE_SZ:
-        gemu_log("F_SETPIPE_SZ,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
-        break;
-    case TARGET_F_GETPIPE_SZ:
-        gemu_log("F_GETPIPE_SZ");
-        break;
-    case TARGET_F_DUPFD_CLOEXEC:
-        gemu_log("F_DUPFD_CLOEXEC,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
-        break;
-    case TARGET_F_NOTIFY:
-        gemu_log("F_NOTIFY,");
-        print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
-        break;
-    default:
-        print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
-        print_pointer(arg2, 1);
-        break;
-    }
-    print_syscall_epilogue(name);
-}
-#define print_fcntl64   print_fcntl
-#endif
-
-
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
diff --git a/linux-user/syscall-fcntl.inc.c b/linux-user/syscall-fcntl.inc.c
new file mode 100644
index 0000000000..768682bd17
--- /dev/null
+++ b/linux-user/syscall-fcntl.inc.c
@@ -0,0 +1,322 @@
+/*
+ *  Linux fcntl syscall implementation
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+typedef struct FcntlEntry FcntlEntry;
+
+typedef abi_long FcntlFn(int fd, int host_cmd, abi_long arg);
+
+struct FcntlEntry {
+    const char *name;
+    FcntlFn *host_fn;
+    int host_cmd;
+    SyscallArgType arg_type;
+};
+
+static abi_long do_fcntl_int(int fd, int host_cmd, abi_long arg)
+{
+    return get_errno(safe_fcntl(fd, host_cmd, arg));
+}
+
+static abi_long do_fcntl_getfl(int fd, int host_cmd, abi_long arg)
+{
+    abi_long ret = get_errno(safe_fcntl(fd, host_cmd));
+    if (!is_error(ret)) {
+        ret = host_to_target_bitmask(ret, fcntl_flags_tbl);
+    }
+    return ret;
+}
+
+static abi_long do_fcntl_setfl(int fd, int host_cmd, abi_long arg)
+{
+    return get_errno(safe_fcntl(fd, host_cmd,
+                                target_to_host_bitmask(arg, fcntl_flags_tbl)));
+}
+
+static abi_long do_fcntl_getlk_1(int fd, int host_cmd, abi_long arg,
+                                 from_flock64_fn *copy_from,
+                                 to_flock64_fn *copy_to)
+{
+    struct flock64 fl64;
+    abi_long ret;
+
+    ret = copy_from(&fl64, arg);
+    if (ret == 0) {
+        ret = get_errno(safe_fcntl(fd, host_cmd, &fl64));
+        if (ret == 0) {
+            ret = copy_to(arg, &fl64);
+        }
+    }
+    return ret;
+}
+
+static abi_long do_fcntl_setlk_1(int fd, int host_cmd, abi_long arg,
+                                 from_flock64_fn *copy_from)
+{
+    struct flock64 fl64;
+    abi_long ret;
+
+    ret = copy_from(&fl64, arg);
+    if (ret == 0) {
+        ret = get_errno(safe_fcntl(fd, host_cmd, &fl64));
+    }
+    return ret;
+}
+
+static abi_long do_fcntl_getlk(int fd, int cmd, abi_long arg)
+{
+    return do_fcntl_getlk_1(fd, cmd, arg,
+                            copy_from_user_flock,
+                            copy_to_user_flock);
+}
+
+static abi_long do_fcntl_setlk(int fd, int cmd, abi_long arg)
+{
+    return do_fcntl_setlk_1(fd, cmd, arg, copy_from_user_flock);
+}
+
+static abi_long do_fcntl_getlk64(int fd, int cmd, abi_long arg)
+{
+    return do_fcntl_getlk_1(fd, cmd, arg,
+                            copy_from_user_flock64,
+                            copy_to_user_flock64);
+}
+
+static abi_long do_fcntl_setlk64(int fd, int cmd, abi_long arg)
+{
+    return do_fcntl_setlk_1(fd, cmd, arg, copy_from_user_flock64);
+}
+
+#if defined(TARGET_ARM) && TARGET_ABI_BITS == 32
+static abi_long do_fcntl_oabi_getlk64(int fd, int cmd, abi_long arg)
+{
+    return do_fcntl_getlk_1(fd, cmd, arg,
+                            copy_from_user_oabi_flock64,
+                            copy_to_user_oabi_flock64);
+}
+
+static abi_long do_fcntl_oabi_setlk64(int fd, int cmd, abi_long arg)
+{
+    return do_fcntl_setlk_1(fd, cmd, arg, copy_from_user_oabi_flock64);
+}
+#endif /* TARGET_ARM */
+
+#ifdef F_GETOWN_EX
+static abi_long do_fcntl_getown_ex(int fd, int cmd, abi_long arg)
+{
+    struct f_owner_ex fox;
+    abi_long ret = get_errno(safe_fcntl(fd, cmd, &fox));
+
+    if (!is_error(ret)) {
+        struct target_f_owner_ex *target_fox;
+        if (!lock_user_struct(VERIFY_WRITE, target_fox, arg, 0)) {
+            return -TARGET_EFAULT;
+        }
+        target_fox->type = tswap32(fox.type);
+        target_fox->pid = tswap32(fox.pid);
+        unlock_user_struct(target_fox, arg, 1);
+    }
+    return ret;
+}
+
+static abi_long do_fcntl_setown_ex(int fd, int cmd, abi_long arg)
+{
+    struct target_f_owner_ex *target_fox;
+    struct f_owner_ex fox;
+
+    if (!lock_user_struct(VERIFY_READ, target_fox, arg, 1)) {
+        return -TARGET_EFAULT;
+    }
+    fox.type = tswap32(target_fox->type);
+    fox.pid = tswap32(target_fox->pid);
+    unlock_user_struct(target_fox, arg, 0);
+    return get_errno(safe_fcntl(fd, cmd, &fox));
+}
+#endif /* F_GETOWN_EX */
+
+static const FcntlEntry *target_fcntl_cmd(int cmd, int is_64)
+{
+#define CMD2(T, H, A, FN)                                            \
+    case TARGET_##T: do {                                            \
+        static const FcntlEntry ent_##T = {                          \
+            .name = #T, .host_cmd = H, .host_fn = FN, .arg_type = A  \
+        };                                                           \
+        return &ent_##T;                                             \
+    } while(0)
+
+#define CMD1(T, A, FN)                                               \
+    case TARGET_##T: do {                                            \
+        static const FcntlEntry ent_##T = {                          \
+            .name = #T, .host_cmd = T, .host_fn = FN, .arg_type = A  \
+        };                                                           \
+        return &ent_##T;                                             \
+    } while(0)
+
+#if TARGET_ABI_BITS == 64
+# ifdef __powerpc64__
+/*
+ * On PPC64, glibc headers has the F_*LK* defined to 12, 13 and 14 and
+ * is not supported by kernel. The glibc fcntl call actually adjusts
+ * them to 5, 6 and 7 before making the syscall(). Since we make the
+ * syscall directly, adjust to what is supported by the kernel.
+ */
+#  define HOST_CMD_ADJ64(C)  (C - (F_GETLK64 - 5))
+# else
+#  define HOST_CMD_ADJ64(C)  C
+# endif
+# define CMD64(T, FN)                                                \
+    case TARGET_##T: do {                                            \
+        static const FcntlEntry ent_##T = {                          \
+            .name = #T, .host_cmd = HOST_CMD_ADJ64(T),               \
+            .host_fn = do_fcntl_##FN, .arg_type = ARG_PTR            \
+        };                                                           \
+        return &ent_##T;                                             \
+    } while(0)
+#elif defined(TARGET_ARM)
+# define CMD64(T, FN)                                                \
+    case TARGET_##T: do {                                            \
+        if (!is_64) {                                                \
+            return NULL;                                             \
+        } else if (is_64 > 0) {                                      \
+            static const FcntlEntry ent_##T = {                      \
+                .name = #T, .host_cmd = T,                           \
+                .host_fn = do_fcntl_##FN, .arg_type = ARG_PTR        \
+            };                                                       \
+            return &ent_##T;                                         \
+        } else {                                                     \
+            static const FcntlEntry ent_oabi_##T = {                 \
+                .name = #T, .host_cmd = T,                           \
+                .host_fn = do_fcntl_oabi_##FN, .arg_type = ARG_PTR   \
+            };                                                       \
+            return &ent_oabi_##T;                                    \
+        }                                                            \
+    } while (0)
+#else
+# define CMD64(T, FN)                                                \
+    case TARGET_##T: do {                                            \
+        static const FcntlEntry ent_##T = {                          \
+            .name = #T, .host_cmd = T,                               \
+            .host_fn = do_fcntl_##FN, .arg_type = ARG_PTR            \
+        };                                                           \
+        return is_64 ? &ent_##T : NULL;                              \
+    } while (0)
+#endif
+
+    switch (cmd) {
+    CMD1(F_DUPFD, ARG_DEC, do_fcntl_int);
+    CMD1(F_GETFD, ARG_NONE, do_fcntl_int);
+    CMD1(F_SETFD, ARG_DEC, do_fcntl_int);
+    CMD1(F_GETFL, ARG_NONE, do_fcntl_getfl);
+    CMD1(F_SETFL, ARG_DEC, do_fcntl_setfl);
+
+    CMD2(F_GETLK, F_GETLK64, ARG_PTR, do_fcntl_getlk);
+    CMD2(F_SETLK, F_SETLK64, ARG_PTR, do_fcntl_setlk);
+    CMD2(F_SETLKW, F_SETLKW64, ARG_PTR, do_fcntl_setlk);
+
+    CMD1(F_GETOWN, ARG_NONE, do_fcntl_int);
+    CMD1(F_SETOWN, ARG_DEC, do_fcntl_int);
+    CMD1(F_GETSIG, ARG_NONE, do_fcntl_int);
+    CMD1(F_SETSIG, ARG_DEC, do_fcntl_int);
+
+    CMD64(F_GETLK64, getlk64);
+    CMD64(F_SETLK64, setlk64);
+    CMD64(F_SETLKW64, setlk64);
+
+    CMD1(F_GETLEASE, ARG_NONE, do_fcntl_int);
+    CMD1(F_SETLEASE, ARG_DEC, do_fcntl_int);
+#ifdef F_DUPFD_CLOEXEC
+    CMD1(F_DUPFD_CLOEXEC, ARG_DEC, do_fcntl_int);
+#endif
+    CMD1(F_NOTIFY, ARG_DEC, do_fcntl_int);
+#ifdef F_GETOWN_EX
+    CMD1(F_GETOWN_EX, ARG_PTR, do_fcntl_getown_ex);
+    CMD1(F_SETOWN_EX, ARG_PTR, do_fcntl_setown_ex);
+#endif
+#ifdef F_SETPIPE_SZ
+    CMD1(F_SETPIPE_SZ, ARG_DEC, do_fcntl_int);
+    CMD1(F_GETPIPE_SZ, ARG_DEC, do_fcntl_int);
+#endif
+    }
+    return NULL;
+
+#undef CMD1
+#undef CMD2
+#undef CMD64
+#undef HOST_CMD_ADJ64
+}
+
+static abi_long do_fcntl(int fd, int target_cmd, abi_ulong arg, int is_64)
+{
+    const FcntlEntry *ent = target_fcntl_cmd(target_cmd, is_64);
+
+    if (ent == NULL) {
+        return -TARGET_EINVAL;
+    }
+    return ent->host_fn(fd, ent->host_cmd, arg);
+}
+
+static void do_print_fcntl(const SyscallDef *def, int fd, int target_cmd,
+                           abi_ulong arg, int is_64)
+{
+    const FcntlEntry *ent = target_fcntl_cmd(target_cmd, is_64);
+
+    switch (ent->arg_type) {
+    case ARG_NONE:
+        gemu_log("%d %s(%d,%s)", getpid(), def->name, fd, ent->name);
+        break;
+    case ARG_DEC:
+        gemu_log("%d %s(%d,%s," TARGET_ABI_FMT_ld ")",
+                 getpid(), def->name, fd, ent->name, arg);
+        break;
+    case ARG_PTR:
+        gemu_log("%d %s(%d,%s,0x" TARGET_ABI_FMT_lx ")",
+                 getpid(), def->name, fd, ent->name, arg);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+#ifdef TARGET_NR_fcntl
+SYSCALL_IMPL(fcntl)
+{
+    return do_fcntl(arg1, arg2, arg3, 0);
+}
+
+static void print_fcntl(const SyscallDef *def, int64_t in[6])
+{
+    return do_print_fcntl(def, in[0], in[1], in[2], 0);
+}
+#endif
+
+#if TARGET_ABI_BITS == 32
+SYSCALL_IMPL(fcntl64)
+{
+    int is_64 = 1;
+#ifdef TARGET_ARM
+    if (!cpu_env->eabi) {
+        is_64 = -1;
+    }
+#endif
+    return do_fcntl(arg1, arg2, arg3, is_64);
+}
+
+static void print_fcntl64(const SyscallDef *def, int64_t in[6])
+{
+    return do_print_fcntl(def, in[0], in[1], in[2], 1);
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 03ecf0a15a..bce26592d2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3469,102 +3469,6 @@ static void *clone_func(void *arg)
     return NULL;
 }
 
-/* warning : doesn't handle linux specific flags... */
-static int target_to_host_fcntl_cmd(int cmd)
-{
-    int ret;
-
-    switch(cmd) {
-    case TARGET_F_DUPFD:
-    case TARGET_F_GETFD:
-    case TARGET_F_SETFD:
-    case TARGET_F_GETFL:
-    case TARGET_F_SETFL:
-        ret = cmd;
-        break;
-    case TARGET_F_GETLK:
-        ret = F_GETLK64;
-        break;
-    case TARGET_F_SETLK:
-        ret = F_SETLK64;
-        break;
-    case TARGET_F_SETLKW:
-        ret = F_SETLKW64;
-        break;
-    case TARGET_F_GETOWN:
-        ret = F_GETOWN;
-        break;
-    case TARGET_F_SETOWN:
-        ret = F_SETOWN;
-        break;
-    case TARGET_F_GETSIG:
-        ret = F_GETSIG;
-        break;
-    case TARGET_F_SETSIG:
-        ret = F_SETSIG;
-        break;
-#if TARGET_ABI_BITS == 32
-    case TARGET_F_GETLK64:
-        ret = F_GETLK64;
-        break;
-    case TARGET_F_SETLK64:
-        ret = F_SETLK64;
-        break;
-    case TARGET_F_SETLKW64:
-        ret = F_SETLKW64;
-        break;
-#endif
-    case TARGET_F_SETLEASE:
-        ret = F_SETLEASE;
-        break;
-    case TARGET_F_GETLEASE:
-        ret = F_GETLEASE;
-        break;
-#ifdef F_DUPFD_CLOEXEC
-    case TARGET_F_DUPFD_CLOEXEC:
-        ret = F_DUPFD_CLOEXEC;
-        break;
-#endif
-    case TARGET_F_NOTIFY:
-        ret = F_NOTIFY;
-        break;
-#ifdef F_GETOWN_EX
-    case TARGET_F_GETOWN_EX:
-        ret = F_GETOWN_EX;
-        break;
-#endif
-#ifdef F_SETOWN_EX
-    case TARGET_F_SETOWN_EX:
-        ret = F_SETOWN_EX;
-        break;
-#endif
-#ifdef F_SETPIPE_SZ
-    case TARGET_F_SETPIPE_SZ:
-        ret = F_SETPIPE_SZ;
-        break;
-    case TARGET_F_GETPIPE_SZ:
-        ret = F_GETPIPE_SZ;
-        break;
-#endif
-    default:
-        ret = -TARGET_EINVAL;
-        break;
-    }
-
-#if defined(__powerpc64__)
-    /* On PPC64, glibc headers has the F_*LK* defined to 12, 13 and 14 and
-     * is not supported by kernel. The glibc fcntl call actually adjusts
-     * them to 5, 6 and 7 before making the syscall(). Since we make the
-     * syscall directly, adjust to what is supported by the kernel.
-     */
-    if (ret >= F_GETLK64 && ret <= F_SETLKW64) {
-        ret -= F_GETLK64 - 5;
-    }
-#endif
-
-    return ret;
-}
-
 #define FLOCK_TRANSTBL \
     switch (type) { \
     TRANSTBL_CONVERT(F_RDLCK); \
@@ -3730,114 +3634,6 @@ static inline abi_long copy_to_user_flock64(abi_ulong target_flock_addr,
     return 0;
 }
 
-static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
-{
-    struct flock64 fl64;
-#ifdef F_GETOWN_EX
-    struct f_owner_ex fox;
-    struct target_f_owner_ex *target_fox;
-#endif
-    abi_long ret;
-    int host_cmd = target_to_host_fcntl_cmd(cmd);
-
-    if (host_cmd == -TARGET_EINVAL)
-	    return host_cmd;
-
-    switch(cmd) {
-    case TARGET_F_GETLK:
-        ret = copy_from_user_flock(&fl64, arg);
-        if (ret) {
-            return ret;
-        }
-        ret = get_errno(safe_fcntl(fd, host_cmd, &fl64));
-        if (ret == 0) {
-            ret = copy_to_user_flock(arg, &fl64);
-        }
-        break;
-
-    case TARGET_F_SETLK:
-    case TARGET_F_SETLKW:
-        ret = copy_from_user_flock(&fl64, arg);
-        if (ret) {
-            return ret;
-        }
-        ret = get_errno(safe_fcntl(fd, host_cmd, &fl64));
-        break;
-
-    case TARGET_F_GETLK64:
-        ret = copy_from_user_flock64(&fl64, arg);
-        if (ret) {
-            return ret;
-        }
-        ret = get_errno(safe_fcntl(fd, host_cmd, &fl64));
-        if (ret == 0) {
-            ret = copy_to_user_flock64(arg, &fl64);
-        }
-        break;
-    case TARGET_F_SETLK64:
-    case TARGET_F_SETLKW64:
-        ret = copy_from_user_flock64(&fl64, arg);
-        if (ret) {
-            return ret;
-        }
-        ret = get_errno(safe_fcntl(fd, host_cmd, &fl64));
-        break;
-
-    case TARGET_F_GETFL:
-        ret = get_errno(safe_fcntl(fd, host_cmd, arg));
-        if (ret >= 0) {
-            ret = host_to_target_bitmask(ret, fcntl_flags_tbl);
-        }
-        break;
-
-    case TARGET_F_SETFL:
-        ret = get_errno(safe_fcntl(fd, host_cmd,
-                                   target_to_host_bitmask(arg,
-                                                          fcntl_flags_tbl)));
-        break;
-
-#ifdef F_GETOWN_EX
-    case TARGET_F_GETOWN_EX:
-        ret = get_errno(safe_fcntl(fd, host_cmd, &fox));
-        if (ret >= 0) {
-            if (!lock_user_struct(VERIFY_WRITE, target_fox, arg, 0))
-                return -TARGET_EFAULT;
-            target_fox->type = tswap32(fox.type);
-            target_fox->pid = tswap32(fox.pid);
-            unlock_user_struct(target_fox, arg, 1);
-        }
-        break;
-#endif
-
-#ifdef F_SETOWN_EX
-    case TARGET_F_SETOWN_EX:
-        if (!lock_user_struct(VERIFY_READ, target_fox, arg, 1))
-            return -TARGET_EFAULT;
-        fox.type = tswap32(target_fox->type);
-        fox.pid = tswap32(target_fox->pid);
-        unlock_user_struct(target_fox, arg, 0);
-        ret = get_errno(safe_fcntl(fd, host_cmd, &fox));
-        break;
-#endif
-
-    case TARGET_F_SETOWN:
-    case TARGET_F_GETOWN:
-    case TARGET_F_SETSIG:
-    case TARGET_F_GETSIG:
-    case TARGET_F_SETLEASE:
-    case TARGET_F_GETLEASE:
-    case TARGET_F_SETPIPE_SZ:
-    case TARGET_F_GETPIPE_SZ:
-        ret = get_errno(safe_fcntl(fd, host_cmd, arg));
-        break;
-
-    default:
-        ret = get_errno(safe_fcntl(fd, cmd, arg));
-        break;
-    }
-    return ret;
-}
-
 #ifdef USE_UID16
 
 static inline int high2lowuid(int uid)
@@ -4401,10 +4197,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_fcntl
-    case TARGET_NR_fcntl:
-        return do_fcntl(arg1, arg2, arg3);
-#endif
     case TARGET_NR_setpgid:
         return get_errno(setpgid(arg1, arg2));
     case TARGET_NR_umask:
@@ -6935,53 +6727,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            This is a hint, so ignoring and returning success is ok.  */
         return 0;
 #endif
-#if TARGET_ABI_BITS == 32
-    case TARGET_NR_fcntl64:
-    {
-	int cmd;
-	struct flock64 fl;
-        from_flock64_fn *copyfrom = copy_from_user_flock64;
-        to_flock64_fn *copyto = copy_to_user_flock64;
-
-#ifdef TARGET_ARM
-        if (!((CPUARMState *)cpu_env)->eabi) {
-            copyfrom = copy_from_user_oabi_flock64;
-            copyto = copy_to_user_oabi_flock64;
-        }
-#endif
-
-	cmd = target_to_host_fcntl_cmd(arg2);
-        if (cmd == -TARGET_EINVAL) {
-            return cmd;
-        }
-
-        switch(arg2) {
-        case TARGET_F_GETLK64:
-            ret = copyfrom(&fl, arg3);
-            if (ret) {
-                break;
-            }
-            ret = get_errno(safe_fcntl(arg1, cmd, &fl));
-            if (ret == 0) {
-                ret = copyto(arg3, &fl);
-            }
-	    break;
-
-        case TARGET_F_SETLK64:
-        case TARGET_F_SETLKW64:
-            ret = copyfrom(&fl, arg3);
-            if (ret) {
-                break;
-            }
-            ret = get_errno(safe_fcntl(arg1, cmd, &fl));
-	    break;
-        default:
-            ret = do_fcntl(arg1, arg2, arg3);
-            break;
-        }
-        return ret;
-    }
-#endif
 #ifdef TARGET_NR_cacheflush
     case TARGET_NR_cacheflush:
         /* self-modifying code is handled automatically, so nothing needed */
@@ -7968,6 +7713,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                 int64_t arg2, int64_t arg3, int64_t arg4, \
                                 int64_t arg5, int64_t arg6)
 
+#include "syscall-fcntl.inc.c"
 #include "syscall-file.inc.c"
 #include "syscall-ioctl.inc.c"
 #include "syscall-ipc.inc.c"
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 15208b5349..8762892db5 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -157,12 +157,6 @@
 #ifdef TARGET_NR_fchownat
 { TARGET_NR_fchownat, "fchownat" , NULL, print_fchownat, NULL },
 #endif
-#ifdef TARGET_NR_fcntl
-{ TARGET_NR_fcntl, "fcntl" , NULL, print_fcntl, NULL },
-#endif
-#ifdef TARGET_NR_fcntl64
-{ TARGET_NR_fcntl64, "fcntl64" , NULL, print_fcntl64, NULL },
-#endif
 #ifdef TARGET_NR_fdatasync
 { TARGET_NR_fdatasync, "fdatasync" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
