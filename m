Received: from eggs.gnu.org ([209.51.188.92]:56245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkz-0005at-6v
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkx-0005B6-04
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:53 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkt-00054z-CU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:49 -0500
Received: by mail-pl1-x644.google.com with SMTP id y1so6880894plp.9
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:05 +1100
Message-Id: <20190118213122.22865-32-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 32/49] linux-user: Split out mount
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
 linux-user/syscall-defs.h     |  1 +
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 21 +++----------
 linux-user/syscall-file.inc.c | 48 ++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 55 -----------------------------------
 linux-user/strace.list        |  3 --
 6 files changed, 54 insertions(+), 75 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index d163bbf409..2b331c6a6d 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -78,6 +78,7 @@ SYSCALL_DEF_FULL(mmap2, .impl = impl_mmap,
                  .arg_type = { ARG_PTR, ARG_DEC, ARG_MMAPPROT,
                                ARG_MMAPFLAG, ARG_DEC, ARG_DEC64 });
 #endif
+SYSCALL_DEF(mount, ARG_STR, ARG_STR, ARG_STR, ARG_MOUNTFLAG, ARG_PTR);
 SYSCALL_DEF(mprotect, ARG_PTR, ARG_DEC, ARG_MMAPPROT);
 SYSCALL_DEF_FULL(mremap, .impl = impl_mremap,
                  .print_ret = print_syscall_ptr_ret,
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index c16c0a3f1e..35dd3e5fa3 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -62,6 +62,7 @@ typedef enum {
     ARG_MMAPFLAG,
     ARG_MMAPPROT,
     ARG_MODEFLAG,
+    ARG_MOUNTFLAG,
     ARG_OPENFLAG,
     ARG_UNLINKATFLAG,
     ARG_LSEEKWHENCE,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index c08dbdff0c..eb02430eba 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -708,7 +708,7 @@ static struct flags const open_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags mount_flags[] = {
+static struct flags const mount_flags[] = {
 #ifdef MS_BIND
     FLAG_GENERIC(MS_BIND),
 #endif
@@ -2003,22 +2003,6 @@ print_symlinkat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_mount
-static void
-print_mount(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_string(arg1, 0);
-    print_string(arg2, 0);
-    print_flags(mount_flags, arg3, 0);
-    print_pointer(arg4, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_umount
 static void
 print_umount(const struct syscallname *name,
@@ -2303,6 +2287,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_MODEFLAG:
             len = add_flags(b, rest, mode_flags, arg, true);
             break;
+        case ARG_MOUNTFLAG:
+            len = add_flags(b, rest, mount_flags, arg, true);
+            break;
         case ARG_OPENFLAG:
             len = add_open_flags(b, rest, arg);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index e23d21bdfc..d7eb72cc31 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -174,6 +174,54 @@ SYSCALL_IMPL(mknodat)
     return do_mknodat(arg1, arg2, arg3, arg4);
 }
 
+SYSCALL_IMPL(mount)
+{
+    abi_ulong target_src = arg1;
+    abi_ulong target_tgt = arg2;
+    abi_ulong target_fst = arg3;
+    abi_ulong mountflags = arg4;
+    abi_ulong target_data = arg5;
+    char *p_src = NULL, *p_tgt = NULL, *p_fst = NULL, *p_data = NULL;
+    abi_long ret = -TARGET_EFAULT;
+
+    if (target_src) {
+        p_src = lock_user_string(target_src);
+        if (!p_src) {
+            goto exit0;
+        }
+    }
+
+    p_tgt = lock_user_string(target_tgt);
+    if (!p_tgt) {
+        goto exit1;
+    }
+
+    if (target_fst) {
+        p_fst = lock_user_string(target_fst);
+        if (!p_fst) {
+            goto exit2;
+        }
+    }
+
+    /*
+     * FIXME - arg5 should be locked, but it isn't clear how to
+     * do that since it's not guaranteed to be a NULL-terminated
+     * string.
+     */
+    if (target_data) {
+        p_data = g2h(target_data);
+    }
+    ret = get_errno(mount(p_src, p_tgt, p_fst, mountflags, p_data));
+
+    unlock_user(p_fst, target_fst, 0);
+ exit2:
+    unlock_user(p_tgt, target_tgt, 0);
+ exit1:
+    unlock_user(p_src, target_src, 0);
+ exit0:
+    return ret;
+}
+
 /*
  * Helpers for do_openat, manipulating /proc/self/foo.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6ea1a67345..39e749a985 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5327,61 +5327,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_mount:
-        {
-            /* need to look at the data field */
-            void *p2, *p3;
-
-            if (arg1) {
-                p = lock_user_string(arg1);
-                if (!p) {
-                    return -TARGET_EFAULT;
-                }
-            } else {
-                p = NULL;
-            }
-
-            p2 = lock_user_string(arg2);
-            if (!p2) {
-                if (arg1) {
-                    unlock_user(p, arg1, 0);
-                }
-                return -TARGET_EFAULT;
-            }
-
-            if (arg3) {
-                p3 = lock_user_string(arg3);
-                if (!p3) {
-                    if (arg1) {
-                        unlock_user(p, arg1, 0);
-                    }
-                    unlock_user(p2, arg2, 0);
-                    return -TARGET_EFAULT;
-                }
-            } else {
-                p3 = NULL;
-            }
-
-            /* FIXME - arg5 should be locked, but it isn't clear how to
-             * do that since it's not guaranteed to be a NULL-terminated
-             * string.
-             */
-            if (!arg5) {
-                ret = mount(p, p2, p3, (unsigned long)arg4, NULL);
-            } else {
-                ret = mount(p, p2, p3, (unsigned long)arg4, g2h(arg5));
-            }
-            ret = get_errno(ret);
-
-            if (arg1) {
-                unlock_user(p, arg1, 0);
-            }
-            unlock_user(p2, arg2, 0);
-            if (arg3) {
-                unlock_user(p3, arg3, 0);
-            }
-        }
-        return ret;
 #ifdef TARGET_NR_umount
     case TARGET_NR_umount:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 344a2232d6..5f07e0e23d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -497,9 +497,6 @@
 #ifdef TARGET_NR_modify_ldt
 { TARGET_NR_modify_ldt, "modify_ldt" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_mount
-{ TARGET_NR_mount, "mount" , NULL, print_mount, NULL },
-#endif
 #ifdef TARGET_NR_move_pages
 { TARGET_NR_move_pages, "move_pages" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
