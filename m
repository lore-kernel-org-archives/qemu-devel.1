Received: from eggs.gnu.org ([2001:4830:134:3::10]:40620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqe2-0002hX-Qx
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqe0-0003c3-GK
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:54 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqe0-0003bo-69
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:52 -0400
Received: by mail-pl0-x243.google.com with SMTP id c23-v6so10384472plz.12
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:11 -1000
Message-Id: <20180610030220.3777-40-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 039/108] linux-user: Split out mprotect,
 mremap, msync, munmap
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

All targets define all of these; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 61 ++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a3374955da..7504ad74b5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8471,6 +8471,37 @@ IMPL(mount)
     return ret;
 }
 
+IMPL(mprotect)
+{
+    /* Special hack to detect libc making the stack executable.  */
+    if (arg3 & PROT_GROWSDOWN) {
+        CPUState *cpu = ENV_GET_CPU(cpu_env);
+        TaskState *ts = cpu->opaque;
+
+        if (arg1 >= ts->info->stack_limit && arg1 <= ts->info->start_stack) {
+            arg3 &= ~PROT_GROWSDOWN;
+            arg2 = arg2 + arg1 - ts->info->stack_limit;
+            arg1 = ts->info->stack_limit;
+        }
+    }
+    return get_errno(target_mprotect(arg1, arg2, arg3));
+}
+
+IMPL(mremap)
+{
+    return get_errno(target_mremap(arg1, arg2, arg3, arg4, arg5));
+}
+
+IMPL(msync)
+{
+    return get_errno(msync(g2h(arg1), arg2, arg3));
+}
+
+IMPL(munmap)
+{
+    return get_errno(target_munmap(arg1, arg2));
+}
+
 #ifdef CONFIG_OPEN_BY_HANDLE
 IMPL(name_to_handle_at)
 {
@@ -9696,37 +9727,13 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8)
 {
-    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    CPUState *cpu __attribute__((unused)) = ENV_GET_CPU(cpu_env);
     abi_long ret;
     struct stat st;
     struct statfs stfs;
     void *p;
 
     switch(num) {
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
 #ifdef TARGET_NR_mlock
     case TARGET_NR_mlock:
         return get_errno(mlock(g2h(arg1), arg2));
@@ -12762,6 +12769,10 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(mmap2);
 #endif
         SYSCALL(mount);
+        SYSCALL(mprotect);
+        SYSCALL(mremap);
+        SYSCALL(msync);
+        SYSCALL(munmap);
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(name_to_handle_at);
 #endif
-- 
2.17.1
