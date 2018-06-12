Received: from eggs.gnu.org ([2001:4830:134:3::10]:59426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXY4-0005T3-Oj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXY2-0007pq-H4
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:36 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSXY2-0007oq-6s
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:34 -0400
Received: by mail-pg0-x243.google.com with SMTP id r21-v6so10255327pgv.4
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:52:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Jun 2018 14:51:44 -1000
Message-Id: <20180612005145.3375-19-richard.henderson@linaro.org>
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 18/19] linux-user: Split out memory syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org

This includes mmap, mmap2, munmap, mlock, mlockall, munlock,
munlockall, mprotect, mremap, msync.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.h           |   2 +
 linux-user/strace.c            |  55 ++--------
 linux-user/syscall.c           | 118 --------------------
 linux-user/syscall_mem.c       | 190 +++++++++++++++++++++++++++++++++
 linux-user/Makefile.objs       |   3 +-
 linux-user/gen_syscall_list.py |  10 ++
 linux-user/strace.list         |  33 ------
 7 files changed, 212 insertions(+), 199 deletions(-)
 create mode 100644 linux-user/syscall_mem.c

diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 217267409b..0bbbf6f7b0 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -53,6 +53,8 @@ typedef enum {
     /* These print as sets of flags.  */
     ARG_ATDIRFD,
     ARG_ATFLAG,
+    ARG_MMAPFLAG,
+    ARG_MMAPPROT,
     ARG_MODEFLAG,
     ARG_OPENFLAG,
 
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 79d2d91636..6ebd261a84 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -801,7 +801,7 @@ UNUSED static struct flags umount2_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags mmap_prot_flags[] = {
+static struct flags const mmap_prot_flags[] = {
     FLAG_GENERIC(PROT_NONE),
     FLAG_GENERIC(PROT_EXEC),
     FLAG_GENERIC(PROT_READ),
@@ -812,7 +812,7 @@ UNUSED static struct flags mmap_prot_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags mmap_flags[] = {
+static struct flags const mmap_flags[] = {
     FLAG_TARGET(MAP_SHARED),
     FLAG_TARGET(MAP_PRIVATE),
     FLAG_TARGET(MAP_ANONYMOUS),
@@ -2364,51 +2364,6 @@ print_utimensat(const struct syscallname *name,
 }
 #endif
 
-#if defined(TARGET_NR_mmap) || defined(TARGET_NR_mmap2)
-static void
-print_mmap(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_pointer(arg0, 0);
-    print_raw_param("%d", arg1, 0);
-    print_flags(mmap_prot_flags, arg2, 0);
-    print_flags(mmap_flags, arg3, 0);
-    print_raw_param("%d", arg4, 0);
-    print_raw_param("%#x", arg5, 1);
-    print_syscall_epilogue(name);
-}
-#define print_mmap2     print_mmap
-#endif
-
-#ifdef TARGET_NR_mprotect
-static void
-print_mprotect(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_pointer(arg0, 0);
-    print_raw_param("%d", arg1, 0);
-    print_flags(mmap_prot_flags, arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_munmap
-static void
-print_munmap(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_pointer(arg0, 0);
-    print_raw_param("%d", arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_futex
 static void print_futex_op(abi_long tflag, int last)
 {
@@ -2613,6 +2568,12 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_ATFLAG:
             len = add_flags(b, rest, at_file_flags, arg, false);
             break;
+        case ARG_MMAPFLAG:
+            len = add_flags(b, rest, mmap_flags, arg, false);
+            break;
+        case ARG_MMAPPROT:
+            len = add_flags(b, rest, mmap_prot_flags, arg, false);
+            break;
         case ARG_MODEFLAG:
             len = add_flags(b, rest, mode_flags, arg, true);
             break;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 51d27f2a88..67fbf7f674 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4899,29 +4899,6 @@ static const StructEntry struct_termios_def = {
     .align = { __alignof__(struct target_termios), __alignof__(struct host_termios) },
 };
 
-static bitmask_transtbl mmap_flags_tbl[] = {
-    { TARGET_MAP_SHARED, TARGET_MAP_SHARED, MAP_SHARED, MAP_SHARED },
-    { TARGET_MAP_PRIVATE, TARGET_MAP_PRIVATE, MAP_PRIVATE, MAP_PRIVATE },
-    { TARGET_MAP_FIXED, TARGET_MAP_FIXED, MAP_FIXED, MAP_FIXED },
-    { TARGET_MAP_ANONYMOUS, TARGET_MAP_ANONYMOUS,
-      MAP_ANONYMOUS, MAP_ANONYMOUS },
-    { TARGET_MAP_GROWSDOWN, TARGET_MAP_GROWSDOWN,
-      MAP_GROWSDOWN, MAP_GROWSDOWN },
-    { TARGET_MAP_DENYWRITE, TARGET_MAP_DENYWRITE,
-      MAP_DENYWRITE, MAP_DENYWRITE },
-    { TARGET_MAP_EXECUTABLE, TARGET_MAP_EXECUTABLE,
-      MAP_EXECUTABLE, MAP_EXECUTABLE },
-    { TARGET_MAP_LOCKED, TARGET_MAP_LOCKED, MAP_LOCKED, MAP_LOCKED },
-    { TARGET_MAP_NORESERVE, TARGET_MAP_NORESERVE,
-      MAP_NORESERVE, MAP_NORESERVE },
-    { TARGET_MAP_HUGETLB, TARGET_MAP_HUGETLB, MAP_HUGETLB, MAP_HUGETLB },
-    /* MAP_STACK had been ignored by the kernel for quite some time.
-       Recognize it for the target insofar as we do not want to pass
-       it through to the host.  */
-    { TARGET_MAP_STACK, TARGET_MAP_STACK, 0, 0 },
-    { 0, 0, 0, 0 }
-};
-
 #if defined(TARGET_I386)
 
 /* NOTE: there is really one LDT for all the threads */
@@ -6097,21 +6074,6 @@ static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
     return 0;
 }
 
-#if defined(TARGET_NR_mlockall)
-static inline int target_to_host_mlockall_arg(int arg)
-{
-    int result = 0;
-
-    if (arg & TARGET_MLOCKALL_MCL_CURRENT) {
-        result |= MCL_CURRENT;
-    }
-    if (arg & TARGET_MLOCKALL_MCL_FUTURE) {
-        result |= MCL_FUTURE;
-    }
-    return result;
-}
-#endif
-
 static inline abi_long host_to_target_stat64(void *cpu_env,
                                              abi_ulong target_addr,
                                              struct stat *host_st)
@@ -7853,86 +7815,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            ret = get_errno(reboot(arg1, arg2, arg3, NULL));
         }
         return ret;
-#ifdef TARGET_NR_mmap
-    case TARGET_NR_mmap:
-#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
-    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
-    defined(TARGET_M68K) || defined(TARGET_CRIS) || defined(TARGET_MICROBLAZE) \
-    || defined(TARGET_S390X)
-        {
-            abi_ulong *v;
-            abi_ulong v1, v2, v3, v4, v5, v6;
-            if (!(v = lock_user(VERIFY_READ, arg1, 6 * sizeof(abi_ulong), 1)))
-                return -TARGET_EFAULT;
-            v1 = tswapal(v[0]);
-            v2 = tswapal(v[1]);
-            v3 = tswapal(v[2]);
-            v4 = tswapal(v[3]);
-            v5 = tswapal(v[4]);
-            v6 = tswapal(v[5]);
-            unlock_user(v, arg1, 0);
-            ret = get_errno(target_mmap(v1, v2, v3,
-                                        target_to_host_bitmask(v4, mmap_flags_tbl),
-                                        v5, v6));
-        }
-#else
-        ret = get_errno(target_mmap(arg1, arg2, arg3,
-                                    target_to_host_bitmask(arg4, mmap_flags_tbl),
-                                    arg5,
-                                    arg6));
-#endif
-        return ret;
-#endif
-#ifdef TARGET_NR_mmap2
-    case TARGET_NR_mmap2:
-#ifndef MMAP_SHIFT
-#define MMAP_SHIFT 12
-#endif
-        ret = target_mmap(arg1, arg2, arg3,
-                          target_to_host_bitmask(arg4, mmap_flags_tbl),
-                          arg5, arg6 << MMAP_SHIFT);
-        return get_errno(ret);
-#endif
-    case TARGET_NR_munmap:
-        return get_errno(target_munmap(arg1, arg2));
-    case TARGET_NR_mprotect:
-        {
-            TaskState *ts = cpu->opaque;
-            /* Special hack to detect libc making the stack executable.  */
-            if ((arg3 & PROT_GROWSDOWN)
-                && arg1 >= ts->info->stack_limit
-                && arg1 <= ts->info->start_stack) {
-                arg3 &= ~PROT_GROWSDOWN;
-                arg2 = arg2 + arg1 - ts->info->stack_limit;
-                arg1 = ts->info->stack_limit;
-            }
-        }
-        return get_errno(target_mprotect(arg1, arg2, arg3));
-#ifdef TARGET_NR_mremap
-    case TARGET_NR_mremap:
-        return get_errno(target_mremap(arg1, arg2, arg3, arg4, arg5));
-#endif
-        /* ??? msync/mlock/munlock are broken for softmmu.  */
-#ifdef TARGET_NR_msync
-    case TARGET_NR_msync:
-        return get_errno(msync(g2h(arg1), arg2, arg3));
-#endif
-#ifdef TARGET_NR_mlock
-    case TARGET_NR_mlock:
-        return get_errno(mlock(g2h(arg1), arg2));
-#endif
-#ifdef TARGET_NR_munlock
-    case TARGET_NR_munlock:
-        return get_errno(munlock(g2h(arg1), arg2));
-#endif
-#ifdef TARGET_NR_mlockall
-    case TARGET_NR_mlockall:
-        return get_errno(mlockall(target_to_host_mlockall_arg(arg1)));
-#endif
-#ifdef TARGET_NR_munlockall
-    case TARGET_NR_munlockall:
-        return get_errno(munlockall());
-#endif
     case TARGET_NR_truncate:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
diff --git a/linux-user/syscall_mem.c b/linux-user/syscall_mem.c
new file mode 100644
index 0000000000..71a2fb6747
--- /dev/null
+++ b/linux-user/syscall_mem.c
@@ -0,0 +1,190 @@
+/*
+ *  Linux memory-related syscalls
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
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/path.h"
+#include "qemu.h"
+#include "syscall.h"
+#include <elf.h>
+#include <linux/unistd.h>
+
+
+static bitmask_transtbl const mmap_flags_tbl[] = {
+    { TARGET_MAP_SHARED, TARGET_MAP_SHARED, MAP_SHARED, MAP_SHARED },
+    { TARGET_MAP_PRIVATE, TARGET_MAP_PRIVATE, MAP_PRIVATE, MAP_PRIVATE },
+    { TARGET_MAP_FIXED, TARGET_MAP_FIXED, MAP_FIXED, MAP_FIXED },
+    { TARGET_MAP_ANONYMOUS, TARGET_MAP_ANONYMOUS,
+      MAP_ANONYMOUS, MAP_ANONYMOUS },
+    { TARGET_MAP_GROWSDOWN, TARGET_MAP_GROWSDOWN,
+      MAP_GROWSDOWN, MAP_GROWSDOWN },
+    { TARGET_MAP_DENYWRITE, TARGET_MAP_DENYWRITE,
+      MAP_DENYWRITE, MAP_DENYWRITE },
+    { TARGET_MAP_EXECUTABLE, TARGET_MAP_EXECUTABLE,
+      MAP_EXECUTABLE, MAP_EXECUTABLE },
+    { TARGET_MAP_LOCKED, TARGET_MAP_LOCKED, MAP_LOCKED, MAP_LOCKED },
+    { TARGET_MAP_NORESERVE, TARGET_MAP_NORESERVE,
+      MAP_NORESERVE, MAP_NORESERVE },
+    { TARGET_MAP_HUGETLB, TARGET_MAP_HUGETLB, MAP_HUGETLB, MAP_HUGETLB },
+    /* MAP_STACK had been ignored by the kernel for quite some time.
+       Recognize it for the target insofar as we do not want to pass
+       it through to the host.  */
+    { TARGET_MAP_STACK, TARGET_MAP_STACK, 0, 0 },
+    { 0, 0, 0, 0 }
+};
+
+
+SYSCALL_IMPL(mlock)
+{
+    return get_errno(mlock(g2h(arg1), arg2));
+}
+SYSCALL_DEF(mlock, ARG_PTR, ARG_DEC);
+
+SYSCALL_IMPL(mlockall)
+{
+    int host_flag = 0;
+    if (arg1 & TARGET_MLOCKALL_MCL_CURRENT) {
+        host_flag |= MCL_CURRENT;
+    }
+    if (arg1 & TARGET_MLOCKALL_MCL_FUTURE) {
+        host_flag |= MCL_FUTURE;
+    }
+    return get_errno(mlockall(host_flag));
+}
+SYSCALL_DEF(mlockall, ARG_HEX);
+
+#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
+    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
+    defined(TARGET_M68K) || defined(TARGET_CRIS) || \
+    defined(TARGET_MICROBLAZE) || defined(TARGET_S390X)
+SYSCALL_ARGS(mmap)
+{
+    abi_ulong ptr = in[0];
+    abi_long *v = lock_user(VERIFY_READ, ptr, 6 * sizeof(abi_long), 1);
+    if (v == NULL) {
+        errno = EFAULT;
+        return NULL;
+    }
+    out[0] = tswapal(v[0]);
+    out[1] = tswapal(v[1]);
+    out[2] = tswapal(v[2]);
+    out[3] = tswapal(v[3]);
+    out[4] = tswapal(v[4]);
+    out[5] = tswapal(v[5]);
+    unlock_user(v, ptr, 0);
+    return def;
+}
+#else
+# define args_mmap NULL
+#endif
+
+SYSCALL_IMPL(mmap)
+{
+    int host_flags = target_to_host_bitmask(arg4, mmap_flags_tbl);
+    return get_errno(target_mmap(arg1, arg2, arg3, host_flags, arg5, arg6));
+}
+
+const SyscallDef def_mmap = {
+    .name = "mmap",
+    .args = args_mmap,
+    .impl = impl_mmap,
+    .print_ret = print_syscall_ptr_ret,
+    .arg_type = { ARG_PTR, ARG_DEC, ARG_MMAPPROT,
+                  ARG_MMAPFLAG, ARG_DEC, ARG_DEC }
+};
+
+#ifdef TARGET_NR_mmap2
+/* Define mmap2 in terms of mmap.  */
+/* Note that there is a fundamental problem here in that
+ * target_mmap has an offset parameter that is abi_ulong
+ * and not off_t.  This means that we cannot actually pass
+ * through a 64-bit file offset as intended.
+ */
+
+#ifndef MMAP_SHIFT
+# define MMAP_SHIFT 12
+#endif
+
+SYSCALL_ARGS(mmap2)
+{
+    /* We have already assigned out[0-4].  */
+    out[5] = (uint64_t)(abi_ulong)in[5] << MMAP_SHIFT;
+    return def;
+}
+
+const SyscallDef def_mmap2 = {
+    .name = "mmap2",
+    .args = args_mmap2,
+    .impl = impl_mmap,
+    .print_ret = print_syscall_ptr_ret,
+    .arg_type = { ARG_PTR, ARG_DEC, ARG_MMAPPROT,
+                  ARG_MMAPFLAG, ARG_DEC, ARG_DEC64 },
+};
+#endif
+
+SYSCALL_IMPL(mprotect)
+{
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    TaskState *ts = cpu->opaque;
+
+    /* Special hack to detect libc making the stack executable.  */
+    if ((arg3 & PROT_GROWSDOWN)
+        && arg1 >= ts->info->stack_limit
+        && arg1 <= ts->info->start_stack) {
+        arg3 &= ~PROT_GROWSDOWN;
+        arg2 = arg2 + arg1 - ts->info->stack_limit;
+        arg1 = ts->info->stack_limit;
+    }
+    return get_errno(target_mprotect(arg1, arg2, arg3));
+}
+SYSCALL_DEF(mprotect, ARG_PTR, ARG_DEC, ARG_MMAPPROT);
+
+SYSCALL_IMPL(mremap)
+{
+    return get_errno(target_mremap(arg1, arg2, arg3, arg4, arg5));
+}
+
+const SyscallDef def_mremap = {
+    .name = "mremap",
+    .impl = impl_mremap,
+    .print_ret = print_syscall_ptr_ret,
+    .arg_type = { ARG_PTR, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR }
+};
+
+SYSCALL_IMPL(msync)
+{
+    return get_errno(msync(g2h(arg1), arg2, arg3));
+}
+SYSCALL_DEF(msync, ARG_PTR, ARG_DEC, ARG_HEX);
+
+SYSCALL_IMPL(munlock)
+{
+    return get_errno(munlock(g2h(arg1), arg2));
+}
+SYSCALL_DEF(munlock, ARG_PTR, ARG_DEC);
+
+SYSCALL_IMPL(munlockall)
+{
+    return get_errno(munlockall());
+}
+SYSCALL_DEF(munlockall);
+
+SYSCALL_IMPL(munmap)
+{
+    return get_errno(target_munmap(arg1, arg2));
+}
+SYSCALL_DEF(munmap, ARG_PTR, ARG_DEC);
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 18dfda66c9..92ffe66fef 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y = main.o syscall.o syscall_file.o syscall_ipc.o \
+obj-y = main.o syscall.o syscall_file.o syscall_ipc.o syscall_mem.o \
 	strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
 	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
@@ -18,5 +18,6 @@ $(SYSCALL_LIST): $(GEN_SYSCALL_LIST)
 
 linux-user/syscall.o \
 linux-user/syscall_file.o \
+linux-user/syscall_mem.o \
 linux-user/syscall_ipc.o \
 linux-user/strace.o: $(SYSCALL_LIST)
diff --git a/linux-user/gen_syscall_list.py b/linux-user/gen_syscall_list.py
index 68ab279d00..4eb83ae9ce 100644
--- a/linux-user/gen_syscall_list.py
+++ b/linux-user/gen_syscall_list.py
@@ -26,6 +26,14 @@ import sys
 # Avoiding ifdefs for these can diagnose typos in $cpu/syscall_nr.h
 unconditional_syscalls = [
     "close",
+    "mlock",
+    "mlockall",
+    "mprotect",
+    "mremap",
+    "msync",
+    "munlock",
+    "munlockall",
+    "munmap",
     "name_to_handle_at",
     "openat",
     "open_by_handle_at",
@@ -42,6 +50,8 @@ unconditional_syscalls = [
 # These syscalls are only supported by some target or abis.
 conditional_syscalls = [
     "ipc",
+    "mmap",
+    "mmap2",
     "msgctl",
     "msgget",
     "msgrcv",
diff --git a/linux-user/strace.list b/linux-user/strace.list
index b0a9b4ad1a..28d1c616ac 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -554,21 +554,6 @@
 #ifdef TARGET_NR_mknodat
 { TARGET_NR_mknodat, "mknodat" , NULL, print_mknodat, NULL },
 #endif
-#ifdef TARGET_NR_mlock
-{ TARGET_NR_mlock, "mlock" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_mlock2
-{ TARGET_NR_mlock2, "mlock2" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_mlockall
-{ TARGET_NR_mlockall, "mlockall" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_mmap
-{ TARGET_NR_mmap, "mmap" , NULL, print_mmap, print_syscall_ret_addr },
-#endif
-#ifdef TARGET_NR_mmap2
-{ TARGET_NR_mmap2, "mmap2" , NULL, print_mmap2, print_syscall_ret_addr },
-#endif
 #ifdef TARGET_NR_modify_ldt
 { TARGET_NR_modify_ldt, "modify_ldt" , NULL, NULL, NULL },
 #endif
@@ -578,9 +563,6 @@
 #ifdef TARGET_NR_move_pages
 { TARGET_NR_move_pages, "move_pages" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_mprotect
-{ TARGET_NR_mprotect, "mprotect" , NULL, print_mprotect, NULL },
-#endif
 #ifdef TARGET_NR_mpx
 { TARGET_NR_mpx, "mpx" , NULL, NULL, NULL },
 #endif
@@ -602,24 +584,9 @@
 #ifdef TARGET_NR_mq_unlink
 { TARGET_NR_mq_unlink, "mq_unlink" , NULL, print_mq_unlink, NULL },
 #endif
-#ifdef TARGET_NR_mremap
-{ TARGET_NR_mremap, "mremap" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_msync
-{ TARGET_NR_msync, "msync" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_multiplexer
 { TARGET_NR_multiplexer, "multiplexer" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_munlock
-{ TARGET_NR_munlock, "munlock" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_munlockall
-{ TARGET_NR_munlockall, "munlockall" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_munmap
-{ TARGET_NR_munmap, "munmap" , NULL, print_munmap, NULL },
-#endif
 #ifdef TARGET_NR_nanosleep
 { TARGET_NR_nanosleep, "nanosleep" , NULL, NULL, NULL },
 #endif
-- 
2.17.1
