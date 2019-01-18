Received: from eggs.gnu.org ([209.51.188.92]:55938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkI-00053K-HE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkH-0004Z3-3D
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:10 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkG-0004XX-Qg
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:09 -0500
Received: by mail-pl1-x644.google.com with SMTP id e11so6872945plt.11
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:50 +1100
Message-Id: <20190118213122.22865-17-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 17/49] linux-user: Split out brk
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
 linux-user/syscall-defs.h    |  3 ++
 linux-user/strace.c          | 35 --------------
 linux-user/syscall-mem.inc.c | 90 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c         | 93 ------------------------------------
 linux-user/strace.list       |  3 --
 5 files changed, 93 insertions(+), 131 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 88aa1a6bfd..c3ed22ff16 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -16,6 +16,9 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+SYSCALL_DEF_FULL(brk, .impl = impl_brk,
+                 .print_ret = print_syscall_ptr_ret,
+                 .arg_type = { ARG_PTR });
 SYSCALL_DEF(close, ARG_DEC);
 SYSCALL_DEF(exit, ARG_DEC);
 #ifdef TARGET_NR_ipc
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5619defec8..ba541432eb 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -604,29 +604,6 @@ print_execve(const struct syscallname *name,
  * Variants for the return value output function
  */
 
-static void
-print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
-{
-    const char *errstr = NULL;
-
-    if (ret < 0) {
-        errstr = target_strerror(-ret);
-    }
-    if (errstr) {
-        gemu_log(" = -1 errno=%d (%s)\n", (int)-ret, errstr);
-    } else {
-        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
-    }
-}
-
-#if 0 /* currently unused */
-static void
-print_syscall_ret_raw(struct syscallname *name, abi_long ret)
-{
-        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
-}
-#endif
-
 #ifdef TARGET_NR__newselect
 static void
 print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
@@ -1168,18 +1145,6 @@ print_access(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_brk
-static void
-print_brk(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_pointer(arg0, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_chdir
 static void
 print_chdir(const struct syscallname *name,
diff --git a/linux-user/syscall-mem.inc.c b/linux-user/syscall-mem.inc.c
index d2ce0cb8cc..17ba8e3d97 100644
--- a/linux-user/syscall-mem.inc.c
+++ b/linux-user/syscall-mem.inc.c
@@ -42,6 +42,96 @@ static bitmask_transtbl const mmap_flags_tbl[] = {
     { 0, 0, 0, 0 }
 };
 
+static abi_ulong target_brk;
+static abi_ulong target_original_brk;
+static abi_ulong brk_page;
+
+void target_set_brk(abi_ulong new_brk)
+{
+    target_original_brk = target_brk = HOST_PAGE_ALIGN(new_brk);
+    brk_page = HOST_PAGE_ALIGN(target_brk);
+}
+
+/* do_brk() must return target values and target errnos. */
+abi_long do_brk(abi_ulong new_brk)
+{
+    abi_long mapped_addr;
+    abi_ulong new_alloc_size;
+
+    if (!new_brk) {
+        return target_brk;
+    }
+    if (new_brk < target_original_brk) {
+        return target_brk;
+    }
+
+    /*
+     * If the new brk is less than the highest page reserved to the
+     * target heap allocation, set it and we're almost done...
+     */
+    if (new_brk <= brk_page) {
+        /*
+         * Heap contents are initialized to zero,
+         * as for anonymous mapped pages.
+         */
+        if (new_brk > target_brk) {
+            memset(g2h(target_brk), 0, new_brk - target_brk);
+        }
+        target_brk = new_brk;
+        return target_brk;
+    }
+
+    /*
+     * We need to allocate more memory after the brk... Note that
+     * we don't use MAP_FIXED because that will map over the top of
+     * any existing mapping (like the one with the host libc or qemu
+     * itself); instead we treat "mapped but at wrong address" as
+     * a failure and unmap again.
+     */
+    new_alloc_size = HOST_PAGE_ALIGN(new_brk - brk_page);
+    mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
+                                        PROT_READ | PROT_WRITE,
+                                        MAP_ANON | MAP_PRIVATE, 0, 0));
+
+    if (mapped_addr == brk_page) {
+        /*
+         * Heap contents are initialized to zero, as for anonymous
+         * mapped pages.  Technically the new pages are already
+         * initialized to zero since they *are* anonymous mapped
+         * pages, however we have to take care with the contents that
+         * come from the remaining part of the previous page: it may
+         * contains garbage data due to a previous heap usage (grown
+         * then shrunken).
+         */
+        memset(g2h(target_brk), 0, brk_page - target_brk);
+
+        target_brk = new_brk;
+        brk_page = HOST_PAGE_ALIGN(target_brk);
+        return target_brk;
+    } else if (mapped_addr != -1) {
+        /*
+         * Mapped but at wrong address, meaning there wasn't actually
+         * enough space for this brk.
+         */
+        target_munmap(mapped_addr, new_alloc_size);
+        mapped_addr = -1;
+    }
+
+#if defined(TARGET_ALPHA)
+    /*
+     * We (partially) emulate OSF/1 on Alpha, which requires we
+     * return a proper errno, not an unchanged brk value.
+     */
+    return -TARGET_ENOMEM;
+#endif
+    /* For everything else, return the previous break. */
+    return target_brk;
+}
+
+SYSCALL_IMPL(brk)
+{
+    return do_brk(arg1);
+}
 
 SYSCALL_IMPL(mlock)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 02010f9ae0..fbca989021 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -830,97 +830,6 @@ static inline int host_to_target_sock_type(int host_type)
     return target_type;
 }
 
-static abi_ulong target_brk;
-static abi_ulong target_original_brk;
-static abi_ulong brk_page;
-
-void target_set_brk(abi_ulong new_brk)
-{
-    target_original_brk = target_brk = HOST_PAGE_ALIGN(new_brk);
-    brk_page = HOST_PAGE_ALIGN(target_brk);
-}
-
-//#define DEBUGF_BRK(message, args...) do { fprintf(stderr, (message), ## args); } while (0)
-#define DEBUGF_BRK(message, args...)
-
-/* do_brk() must return target values and target errnos. */
-abi_long do_brk(abi_ulong new_brk)
-{
-    abi_long mapped_addr;
-    abi_ulong new_alloc_size;
-
-    DEBUGF_BRK("do_brk(" TARGET_ABI_FMT_lx ") -> ", new_brk);
-
-    if (!new_brk) {
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (!new_brk)\n", target_brk);
-        return target_brk;
-    }
-    if (new_brk < target_original_brk) {
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (new_brk < target_original_brk)\n",
-                   target_brk);
-        return target_brk;
-    }
-
-    /* If the new brk is less than the highest page reserved to the
-     * target heap allocation, set it and we're almost done...  */
-    if (new_brk <= brk_page) {
-        /* Heap contents are initialized to zero, as for anonymous
-         * mapped pages.  */
-        if (new_brk > target_brk) {
-            memset(g2h(target_brk), 0, new_brk - target_brk);
-        }
-	target_brk = new_brk;
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (new_brk <= brk_page)\n", target_brk);
-	return target_brk;
-    }
-
-    /* We need to allocate more memory after the brk... Note that
-     * we don't use MAP_FIXED because that will map over the top of
-     * any existing mapping (like the one with the host libc or qemu
-     * itself); instead we treat "mapped but at wrong address" as
-     * a failure and unmap again.
-     */
-    new_alloc_size = HOST_PAGE_ALIGN(new_brk - brk_page);
-    mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
-                                        PROT_READ|PROT_WRITE,
-                                        MAP_ANON|MAP_PRIVATE, 0, 0));
-
-    if (mapped_addr == brk_page) {
-        /* Heap contents are initialized to zero, as for anonymous
-         * mapped pages.  Technically the new pages are already
-         * initialized to zero since they *are* anonymous mapped
-         * pages, however we have to take care with the contents that
-         * come from the remaining part of the previous page: it may
-         * contains garbage data due to a previous heap usage (grown
-         * then shrunken).  */
-        memset(g2h(target_brk), 0, brk_page - target_brk);
-
-        target_brk = new_brk;
-        brk_page = HOST_PAGE_ALIGN(target_brk);
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (mapped_addr == brk_page)\n",
-            target_brk);
-        return target_brk;
-    } else if (mapped_addr != -1) {
-        /* Mapped but at wrong address, meaning there wasn't actually
-         * enough space for this brk.
-         */
-        target_munmap(mapped_addr, new_alloc_size);
-        mapped_addr = -1;
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (mapped_addr != -1)\n", target_brk);
-    }
-    else {
-        DEBUGF_BRK(TARGET_ABI_FMT_lx " (otherwise)\n", target_brk);
-    }
-
-#if defined(TARGET_ALPHA)
-    /* We (partially) emulate OSF/1 on Alpha, which requires we
-       return a proper errno, not an unchanged brk value.  */
-    return -TARGET_ENOMEM;
-#endif
-    /* For everything else, return the previous break. */
-    return target_brk;
-}
-
 static inline abi_long copy_from_user_fdset(fd_set *fds,
                                             abi_ulong target_fds_addr,
                                             int n)
@@ -5626,8 +5535,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_brk:
-        return do_brk(arg1);
 #ifdef TARGET_NR_fork
     case TARGET_NR_fork:
         return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d0160f841f..bdc1401b01 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -49,9 +49,6 @@
 #ifdef TARGET_NR_break
 { TARGET_NR_break, "break" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_brk
-{ TARGET_NR_brk, "brk" , NULL, print_brk, print_syscall_ret_addr },
-#endif
 #ifdef TARGET_NR_cachectl
 { TARGET_NR_cachectl, "cachectl" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
