Received: from eggs.gnu.org ([2001:4830:134:3::10]:55268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tj-0005Ik-4M
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tf-0007DT-8V
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:39 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:33743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6Te-0007Ct-W1
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:35 -0400
Received: by mail-pl0-x244.google.com with SMTP id b90-v6so5180483plb.0
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:11 -0700
Message-Id: <20180818190118.12911-10-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 09/16] linux-user: Setup split syscall
 infrastructure
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

Defines a unified structure for implementation and strace.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.h | 114 +++++++++++++
 linux-user/strace.c  | 386 +++++++++++++++++++++++++++++++------------
 linux-user/syscall.c |  59 ++++++-
 3 files changed, 446 insertions(+), 113 deletions(-)
 create mode 100644 linux-user/syscall.h

diff --git a/linux-user/syscall.h b/linux-user/syscall.h
new file mode 100644
index 0000000000..f84b40d742
--- /dev/null
+++ b/linux-user/syscall.h
@@ -0,0 +1,114 @@
+/*
+ *  Linux syscalls internals
+ *  Copyright (c) 2018 Linaro, Limited.
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
+typedef struct SyscallDef SyscallDef;
+
+/*
+ * This hook extracts max 6 arguments from max 8 input registers.
+ * In the process, register pairs that store 64-bit arguments are merged.
+ * Finally, syscalls are demultipliexed; e.g. the hook for socketcall will
+ * return the SyscallDef for bind, listen, etc.  In the process the hook
+ * may need to read from guest memory, or otherwise validate operands.
+ * On failure, set errno (to a host value) and return NULL;
+ * the (target adjusted) errno will be returned to the guest.
+ */
+typedef const SyscallDef *SyscallArgsFn(const SyscallDef *, int64_t out[6],
+                                        abi_long in[8]);
+
+/* This hook implements the syscall.  */
+typedef abi_long SyscallImplFn(CPUArchState *, int64_t, int64_t, int64_t,
+                               int64_t, int64_t, int64_t);
+
+/* This hook prints the arguments to the syscall for strace.  */
+typedef void SyscallPrintFn(const SyscallDef *, int64_t arg[6]);
+
+/* This hook print the return value from the syscall for strace.  */
+typedef void SyscallPrintRetFn(const SyscallDef *, abi_long);
+
+/*
+ * These flags describe the arguments for the generic fallback to
+ * SyscallPrintFn.  ARG_NONE indicates that the argument is not present.
+ */
+typedef enum {
+    ARG_NONE = 0,
+
+    /* These print as numbers of abi_long.  */
+    ARG_DEC,
+    ARG_HEX,
+    ARG_OCT,
+
+    /* These print as sets of flags.  */
+    ARG_ATDIRFD,
+    ARG_MODEFLAG,
+    ARG_OPENFLAG,
+
+    /* These are interpreted as pointers.  */
+    ARG_PTR,
+    ARG_STR,
+    ARG_BUF,
+
+    /* For a 32-bit host, force printing as a 64-bit operand.  */
+#if TARGET_ABI_BITS == 32
+    ARG_DEC64,
+#else
+    ARG_DEC64 = ARG_DEC,
+#endif
+} SyscallArgType;
+
+struct SyscallDef {
+    const char *name;
+    SyscallArgsFn *args;
+    SyscallImplFn *impl;
+    SyscallPrintFn *print;
+    SyscallPrintRetFn *print_ret;
+    SyscallArgType arg_type[6];
+};
+
+void print_syscall_def(const SyscallDef *def, int64_t args[6]);
+void print_syscall_def_ret(const SyscallDef *def, abi_long ret);
+void print_syscall_ptr_ret(const SyscallDef *def, abi_long ret);
+
+/* Emit the signature for a SyscallArgsFn.  */
+#define SYSCALL_ARGS(NAME) \
+    static const SyscallDef *args_##NAME(const SyscallDef *def, \
+                                         int64_t out[6], abi_long in[8])
+
+/* Emit the signature for a SyscallImplFn.  */
+#define SYSCALL_IMPL(NAME) \
+    static abi_long impl_##NAME(CPUArchState *cpu_env, int64_t arg1, \
+                                int64_t arg2, int64_t arg3, int64_t arg4, \
+                                int64_t arg5, int64_t arg6)
+
+/*
+ * Emit the definition for a "simple" syscall.  Such does not use
+ * SyscallArgsFn and only uses arg_type for strace.
+ */
+#define SYSCALL_DEF(NAME, ...) \
+    static const SyscallDef def_##NAME = { \
+        .name = #NAME, .impl = impl_##NAME, .arg_type = { __VA_ARGS__ } \
+    }
+
+/*
+ * Emit the definition for a syscall that also has an args hook,
+ * and uses arg_type for strace.
+ */
+#define SYSCALL_DEF_ARGS(NAME, ...) \
+    static const SyscallDef def_##NAME = { \
+        .name = #NAME, .args = args_##NAME, .impl = impl_##NAME, \
+        .arg_type = { __VA_ARGS__ } \
+    }
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 33f4a506a2..792644cc0d 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -10,6 +10,7 @@
 #include <linux/if_packet.h>
 #include <sched.h>
 #include "qemu.h"
+#include "syscall.h"
 
 int do_strace=0;
 
@@ -796,7 +797,7 @@ UNUSED static struct flags unlinkat_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags mode_flags[] = {
+static struct flags const mode_flags[] = {
     FLAG_GENERIC(S_IFSOCK),
     FLAG_GENERIC(S_IFLNK),
     FLAG_GENERIC(S_IFREG),
@@ -807,14 +808,14 @@ UNUSED static struct flags mode_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags open_access_flags[] = {
+static struct flags const open_access_flags[] = {
     FLAG_TARGET(O_RDONLY),
     FLAG_TARGET(O_WRONLY),
     FLAG_TARGET(O_RDWR),
     FLAG_END,
 };
 
-UNUSED static struct flags open_flags[] = {
+static struct flags const open_flags[] = {
     FLAG_TARGET(O_APPEND),
     FLAG_TARGET(O_CREAT),
     FLAG_TARGET(O_DIRECTORY),
@@ -989,84 +990,86 @@ get_comma(int last)
     return ((last) ? "" : ",");
 }
 
+static int add_flags(char *buf, int size, const struct flags *f,
+                     int flags, bool octal)
+{
+    const char *sep = "";
+    int off = 0;
+
+    if (flags == 0 && f->f_value == 0) {
+        return snprintf(buf, size, "%s", f->f_string);
+    }
+
+    for (; f->f_string != NULL; f++) {
+        if (f->f_value != 0 && (flags & f->f_value) == f->f_value) {
+            off += snprintf(buf + off, size - off, "%s%s", sep, f->f_string);
+            flags &= ~f->f_value;
+            sep = "|";
+        }
+    }
+
+    /* Print rest of the flags as numeric.  */
+    if (flags) {
+        if (octal) {
+            off += snprintf(buf + off, size - off, "%s%#o", sep, flags);
+        } else {
+            off += snprintf(buf + off, size - off, "%s%#x", sep, flags);
+        }
+    }
+    return off;
+}
+
 static void
 print_flags(const struct flags *f, abi_long flags, int last)
 {
-    const char *sep = "";
-    int n;
+    char buf[256];
+    add_flags(buf, sizeof(buf), f, flags, false);
+    gemu_log("%s%s", buf, get_comma(last));
+}
 
-    if ((flags == 0) && (f->f_value == 0)) {
-        gemu_log("%s%s", f->f_string, get_comma(last));
-        return;
-    }
-    for (n = 0; f->f_string != NULL; f++) {
-        if ((f->f_value != 0) && ((flags & f->f_value) == f->f_value)) {
-            gemu_log("%s%s", sep, f->f_string);
-            flags &= ~f->f_value;
-            sep = "|";
-            n++;
-        }
-    }
-
-    if (n > 0) {
-        /* print rest of the flags as numeric */
-        if (flags != 0) {
-            gemu_log("%s%#x%s", sep, (unsigned int)flags, get_comma(last));
-        } else {
-            gemu_log("%s", get_comma(last));
-        }
+static int add_atdirfd(char *buf, int size, int fd)
+{
+    if (fd == AT_FDCWD) {
+        return snprintf(buf, size, "AT_FDCWD");
     } else {
-        /* no string version of flags found, print them in hex then */
-        gemu_log("%#x%s", (unsigned int)flags, get_comma(last));
+        return snprintf(buf, size, "%d", fd);
     }
 }
 
 static void
 print_at_dirfd(abi_long dirfd, int last)
 {
-#ifdef AT_FDCWD
-    if (dirfd == AT_FDCWD) {
-        gemu_log("AT_FDCWD%s", get_comma(last));
-        return;
-    }
-#endif
-    gemu_log("%d%s", (int)dirfd, get_comma(last));
+    char buf[16];
+    add_atdirfd(buf, sizeof(buf), dirfd);
+    gemu_log("%s%s", buf, get_comma(last));
 }
 
 static void
 print_file_mode(abi_long mode, int last)
 {
-    const char *sep = "";
-    const struct flags *m;
+    char buf[256];
+    add_flags(buf, sizeof(buf), mode_flags, mode, true);
+    gemu_log("%s%s", buf, get_comma(last));
+}
 
-    for (m = &mode_flags[0]; m->f_string != NULL; m++) {
-        if ((m->f_value & mode) == m->f_value) {
-            gemu_log("%s%s", m->f_string, sep);
-            sep = "|";
-            mode &= ~m->f_value;
-            break;
-        }
+static int add_open_flags(char *buf, int size, int flags)
+{
+    int off = add_flags(buf, size, open_access_flags,
+                        flags & TARGET_O_ACCMODE, false);
+    flags &= ~TARGET_O_ACCMODE;
+    if (flags == 0 || off + 2 >= size) {
+        return off;
     }
-
-    mode &= ~S_IFMT;
-    /* print rest of the mode as octal */
-    if (mode != 0)
-        gemu_log("%s%#o", sep, (unsigned int)mode);
-
-    gemu_log("%s", get_comma(last));
+    buf[off++] = '|';
+    return off + add_flags(buf + off, size - off, open_flags, flags, true);
 }
 
 static void
 print_open_flags(abi_long flags, int last)
 {
-    print_flags(open_access_flags, flags & TARGET_O_ACCMODE, 1);
-    flags &= ~TARGET_O_ACCMODE;
-    if (flags == 0) {
-        gemu_log("%s", get_comma(last));
-        return;
-    }
-    gemu_log("|");
-    print_flags(open_flags, flags, last);
+    char buf[256];
+    add_open_flags(buf, sizeof(buf), flags);
+    gemu_log("%s%s", buf, get_comma(last));
 }
 
 static void
@@ -1083,48 +1086,86 @@ print_syscall_epilogue(const struct syscallname *sc)
     gemu_log(")");
 }
 
-static void
-print_string(abi_long addr, int last)
+static int add_pointer(char *buf, int size, abi_ulong addr)
 {
-    char *s;
-
-    if ((s = lock_user_string(addr)) != NULL) {
-        gemu_log("\"%s\"%s", s, get_comma(last));
-        unlock_user(s, addr, 0);
+    if (addr) {
+        return snprintf(buf, size, "0x" TARGET_ABI_FMT_lx, addr);
     } else {
-        /* can't get string out of it, so print it as pointer */
-        print_pointer(addr, last);
+        return snprintf(buf, size, "NULL");
     }
 }
 
+static int add_string(char *buf, int size, abi_ulong addr)
+{
+    char *s = lock_user_string(addr);
+    if (s) {
+        /* TODO: Escape special characters within the string.  */
+        /* TODO: Limit the string length for logging.  */
+        int len = snprintf(buf, size, "\"%s\"", s);
+        unlock_user(s, addr, 0);
+        return len;
+    }
+    return add_pointer(buf, size, addr);
+}
+
+static void
+print_string(abi_long addr, int last)
+{
+    char buf[256];
+    add_string(buf, sizeof(buf), addr);
+    gemu_log("%s%s", buf, get_comma(last));
+}
+
 #define MAX_PRINT_BUF 40
+
+static int add_buffer(char *buf, int size, abi_long addr, abi_ulong len)
+{
+    unsigned char *p;
+    int off = 0;
+    abi_ulong i;
+
+    p = lock_user(VERIFY_READ, addr, MIN(len, MAX_PRINT_BUF), 1);
+    if (!p) {
+        return add_pointer(buf, size, addr);
+    }
+
+    buf[0] = '"';
+    off = 1;
+
+    for (i = 0; i < MAX_PRINT_BUF; ++i) {
+        int len;
+
+        if (isprint(p[i])) {
+            buf[off] = p[i];
+            len = 1;
+        } else {
+            len = snprintf(buf + off, size - off, "\\%o", p[i]);
+        }
+        off += len;
+        if (off + 2 >= size) {
+            goto overflow;
+        }
+    }
+    unlock_user(p, addr, 0);
+
+    if (i == len && off + 2 < size) {
+        buf[off] = '"';
+        buf[off + 1] = 0;
+        return off + 1;
+    }
+
+ overflow:
+    off = MIN(off, size - 5);
+    strcpy(buf + off, "...\"");
+    return off + 4;
+}
+
 static void
 print_buf(abi_long addr, abi_long len, int last)
 {
-    uint8_t *s;
-    int i;
-
-    s = lock_user(VERIFY_READ, addr, len, 1);
-    if (s) {
-        gemu_log("\"");
-        for (i = 0; i < MAX_PRINT_BUF && i < len; i++) {
-            if (isprint(s[i])) {
-                gemu_log("%c", s[i]);
-            } else {
-                gemu_log("\\%o", s[i]);
-            }
-        }
-        gemu_log("\"");
-        if (i != len) {
-            gemu_log("...");
-        }
-        if (!last) {
-            gemu_log(",");
-        }
-        unlock_user(s, addr, 0);
-    } else {
-        print_pointer(addr, last);
-    }
+    char buf[256];
+    add_buffer(buf, sizeof(buf), addr, len);
+    gemu_log("%s%s", buf, get_comma(last));
 }
 
 /*
@@ -1143,10 +1184,9 @@ print_raw_param(const char *fmt, abi_long param, int last)
 static void
 print_pointer(abi_long p, int last)
 {
-    if (p == 0)
-        gemu_log("NULL%s", get_comma(last));
-    else
-        gemu_log("0x" TARGET_ABI_FMT_lx "%s", p, get_comma(last));
+    char buf[24];
+    add_pointer(buf, sizeof(buf), p);
+    gemu_log("%s%s", buf, get_comma(last));
 }
 
 /*
@@ -2635,32 +2675,168 @@ print_syscall(int num,
     gemu_log("Unknown syscall %d\n", num);
 }
 
+static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
+{
+    char buf[1024], *b = buf;
+    int i, rest = sizeof(buf);
+
+    /* Render the argument list into BUF.  This allows us to log the
+     * entire syscall in one write statement at the end.
+     * While this is still not quite as good as separate files, a-la
+     * strace -ff, it can minimize confusion with a multithreaded guest.
+     */
+    buf[0] = 0;
+    for (i = 0; i < 6; ++i) {
+        SyscallArgType type = def->arg_type[i];
+        int64_t arg = args[i];
+        int len;
+
+        if (type == ARG_NONE) {
+            break;
+        }
+
+        /* Validate remaining space.  */
+        if (rest < 4) {
+            goto overflow;
+        }
+
+        /* Add separator.  */
+        if (i > 0) {
+            b[0] = ',';
+            b[1] = ' ';
+            b += 2;
+            rest -= 2;
+        }
+
+        switch (type) {
+#if TARGET_ABI_BITS == 32
+        /* ??? We don't have TARGET_ABI_FMT_* macros for exactly
+         * what we want here.  For this case it probably makes
+         * most sense to just special case.
+         */
+        case ARG_DEC:
+            len = snprintf(b, rest, "%d", (int32_t)arg);
+            break;
+        case ARG_HEX:
+            len = snprintf(b, rest, "%#x", (uint32_t)arg);
+            break;
+        case ARG_OCT:
+            len = snprintf(b, rest, "%#o", (uint32_t)arg);
+            break;
+        case ARG_DEC64:
+            len = snprintf(b, rest, "%" PRId64, arg);
+            break;
+#else
+        case ARG_DEC:
+            len = snprintf(b, rest, "%" PRId64, arg);
+            break;
+        case ARG_OCT:
+            len = snprintf(b, rest, "%" PRIo64, arg);
+            break;
+        case ARG_HEX:
+            len = snprintf(b, rest, "%" PRIx64, arg);
+            break;
+#endif
+        case ARG_ATDIRFD:
+            len = add_atdirfd(b, rest, arg);
+            break;
+        case ARG_MODEFLAG:
+            len = add_flags(b, rest, mode_flags, arg, true);
+            break;
+        case ARG_OPENFLAG:
+            len = add_open_flags(b, rest, arg);
+            break;
+        case ARG_PTR:
+            len = add_pointer(b, rest, arg);
+            break;
+        case ARG_STR:
+            len = add_string(b, rest, arg);
+            break;
+        case ARG_BUF:
+            len = add_buffer(b, rest, arg, MAX_PRINT_BUF);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        b += len;
+        rest -= len;
+        if (rest == 0) {
+            goto overflow;
+        }
+    }
+    goto done;
+
+ overflow:
+    strcpy(buf + sizeof(buf) - 4, "...");
+ done:
+    gemu_log("%d %s(%s)", getpid(), def->name, buf);
+}
+
+void print_syscall_def(const SyscallDef *def, int64_t args[6])
+{
+    SyscallPrintFn *print = def->print;
+    if (!print) {
+        print = print_syscall_def1;
+    }
+    print(def, args);
+}
+
+static void print_syscall_def_ret1(const SyscallDef *def, abi_long ret)
+{
+    if (is_error(ret)) {
+        const char *errstr = target_strerror(-ret);
+        if (errstr) {
+            gemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n",
+                     -ret, errstr);
+        } else {
+            gemu_log(" = -1 errno=" TARGET_ABI_FMT_ld "\n", -ret);
+        }
+    } else {
+        gemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
+    }
+}
 
 void
 print_syscall_ret(int num, abi_long ret)
 {
     int i;
-    const char *errstr = NULL;
 
     for(i=0;i<nsyscalls;i++)
         if( scnames[i].nr == num ) {
             if( scnames[i].result != NULL ) {
                 scnames[i].result(&scnames[i],ret);
             } else {
-                if (ret < 0) {
-                    errstr = target_strerror(-ret);
-                }
-                if (errstr) {
-                    gemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n",
-                             -ret, errstr);
-                } else {
-                    gemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
-                }
+                print_syscall_def_ret1(NULL, ret);
             }
             break;
         }
 }
 
+void print_syscall_ptr_ret(const SyscallDef *def, abi_long ret)
+{
+    if (is_error(ret)) {
+        const char *errstr = target_strerror(-ret);
+        if (errstr) {
+            gemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n",
+                     -ret, errstr);
+        } else {
+            gemu_log(" = -1 errno=" TARGET_ABI_FMT_ld "\n", -ret);
+        }
+    } else {
+        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
+    }
+}
+
+void print_syscall_def_ret(const SyscallDef *def, abi_long ret)
+{
+    SyscallPrintRetFn *print = def->print_ret;
+    if (!print) {
+        print = print_syscall_def_ret1;
+    }
+    print(def, ret);
+}
+
 void print_taken_signal(int target_signum, const target_siginfo_t *tinfo)
 {
     /* Print the strace output for a signal being taken:
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4ae608fb19..3b59f7ed65 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -111,6 +111,7 @@
 #include "uname.h"
 
 #include "qemu.h"
+#include "syscall.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -12481,12 +12482,26 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     return ret;
 }
 
+static const SyscallDef *syscall_table(int num)
+{
+#define S(NAME)  case TARGET_NR_##NAME: return &def_##NAME;
+
+    switch (num) {
+    }
+    return NULL;
+
+#undef S
+}
+
 abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
+    const SyscallDef *def, *orig_def;
+    abi_long raw_args[8] = { arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 };
+    int64_t  out_args[6] = { arg1, arg2, arg3, arg4, arg5, arg6 };
     abi_long ret;
 
 #ifdef DEBUG_ERESTARTSYS
@@ -12506,16 +12521,44 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
 
-    if (unlikely(do_strace)) {
-        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
-        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                          arg5, arg6, arg7, arg8);
-        print_syscall_ret(num, ret);
-    } else {
-        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                          arg5, arg6, arg7, arg8);
+    orig_def = def = syscall_table(num);
+    if (def == NULL) {
+        /* Unconverted.  */
+        if (unlikely(do_strace)) {
+            print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+            ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
+                              arg5, arg6, arg7, arg8);
+            print_syscall_ret(num, ret);
+        } else {
+            ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
+                              arg5, arg6, arg7, arg8);
+        }
+        goto fini;
     }
 
+    if (def->args) {
+        def = def->args(def, out_args, raw_args);
+        if (unlikely(def == NULL)) {
+            ret = -host_to_target_errno(errno);
+            if (unlikely(do_strace)) {
+                print_syscall_def(orig_def, out_args);
+                print_syscall_def_ret(orig_def, ret);
+            }
+            goto fini;
+        }
+    }
+
+    if (unlikely(do_strace)) {
+        print_syscall_def(def, out_args);
+        ret = def->impl(cpu_env, out_args[0], out_args[1], out_args[2],
+                        out_args[3], out_args[4], out_args[5]);
+        print_syscall_def_ret(def, ret);
+    } else {
+        ret = def->impl(cpu_env, out_args[0], out_args[1], out_args[2],
+                        out_args[3], out_args[4], out_args[5]);
+    }
+
+ fini:
     trace_guest_user_syscall_ret(cpu, num, ret);
     return ret;
 }
-- 
2.17.1
