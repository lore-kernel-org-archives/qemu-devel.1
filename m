Received: from eggs.gnu.org ([2001:4830:134:3::10]:57442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWm-0005VL-0N
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWk-0000Q9-OT
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:12 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:41500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWk-0000PO-Gw
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:10 -0400
Received: by mail-pl0-x244.google.com with SMTP id az12-v6so14819013plb.8
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:28 -0700
Message-Id: <20180601073050.8054-12-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/33] linux-user: Split out execve
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

At the same time, fix the repeated re-reading of the argv and env
arrays from guest memory.  Instead read into a unified array once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 203 ++++++++++++++++++++++---------------------
 1 file changed, 106 insertions(+), 97 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b0d268dab7..a9b59a8658 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7998,6 +7998,111 @@ IMPL(close)
     return get_errno(close(arg1));
 }
 
+IMPL(execve)
+{
+    abi_ulong *guest_ptrs;
+    char **host_ptrs;
+    int argc, envc, alloc, i;
+    abi_ulong gp;
+    abi_ulong guest_argp = arg2;
+    abi_ulong guest_envp = arg3;
+    char *filename;
+    abi_long ret;
+
+    /* Initial estimate of number of guest pointers required.  */
+    alloc = 32;
+    guest_ptrs = g_new(abi_ulong, alloc);
+
+    /* Iterate through argp and envp, counting entries, and
+     * reading guest addresses from the arrays.
+     */
+    for (gp = guest_argp, argc = 0; gp; gp += sizeof(abi_ulong)) {
+        abi_ulong addr;
+        if (get_user_ual(addr, gp)) {
+            return -TARGET_EFAULT;
+        }
+        if (!addr) {
+            break;
+        }
+        if (argc >= alloc) {
+            alloc *= 2;
+            guest_ptrs = g_renew(abi_ulong, guest_ptrs, alloc);
+        }
+        guest_ptrs[argc++] = addr;
+    }
+    for (gp = guest_envp, envc = 0; gp; gp += sizeof(abi_ulong)) {
+        abi_ulong addr;
+        if (get_user_ual(addr, gp)) {
+            return -TARGET_EFAULT;
+        }
+        if (!addr) {
+            break;
+        }
+        if (argc + envc >= alloc) {
+            alloc *= 2;
+            guest_ptrs = g_renew(abi_ulong, guest_ptrs, alloc);
+        }
+        guest_ptrs[argc + envc++] = addr;
+    }
+
+    /* Exact number of host pointers required.  */
+    host_ptrs = g_new0(char *, argc + envc + 2);
+
+    /* Iterate through the argp and envp that we already read
+     * and convert the guest pointers to host pointers.
+     */
+    ret = -TARGET_EFAULT;
+    for (i = 0; i < argc; ++i) {
+        char *p = lock_user_string(guest_ptrs[i]);
+        if (!p) {
+            goto fini;
+        }
+        host_ptrs[i] = p;
+    }
+    for (i = 0; i < envc; ++i) {
+        char *p = lock_user_string(guest_ptrs[argc + i]);
+        if (!p) {
+            goto fini;
+        }
+        host_ptrs[argc + 1 + i] = p;
+    }
+
+    /* Read the executable filename.  */
+    filename = lock_user_string(arg1);
+    if (!filename) {
+        goto fini;
+    }
+
+    /* Although execve() is not an interruptible syscall it is
+     * a special case where we must use the safe_syscall wrapper:
+     * if we allow a signal to happen before we make the host
+     * syscall then we will 'lose' it, because at the point of
+     * execve the process leaves QEMU's control. So we use the
+     * safe syscall wrapper to ensure that we either take the
+     * signal as a guest signal, or else it does not happen
+     * before the execve completes and makes it the other
+     * program's problem.
+     */
+    ret = get_errno(safe_execve(filename, host_ptrs, host_ptrs + argc + 1));
+    unlock_user(filename, arg1, 0);
+
+ fini:
+    /* Deallocate everything we allocated above.  */
+    for (i = 0; i < argc; ++i) {
+        if (host_ptrs[i]) {
+            unlock_user(host_ptrs[i], guest_ptrs[i], 0);
+        }
+    }
+    for (i = 0; i < envc; ++i) {
+        if (host_ptrs[argc + 1 + i]) {
+            unlock_user(host_ptrs[argc + 1 + i], guest_ptrs[argc + i], 0);
+        }
+    }
+    g_free(host_ptrs);
+    g_free(guest_ptrs);
+    return ret;
+}
+
 IMPL(exit)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
@@ -8237,103 +8342,6 @@ IMPL(everything_else)
         unlock_user(p, arg2, 0);
         return ret;
 #endif
-    case TARGET_NR_execve:
-        {
-            char **argp, **envp;
-            int argc, envc;
-            abi_ulong gp;
-            abi_ulong guest_argp;
-            abi_ulong guest_envp;
-            abi_ulong addr;
-            char **q;
-            int total_size = 0;
-
-            argc = 0;
-            guest_argp = arg2;
-            for (gp = guest_argp; gp; gp += sizeof(abi_ulong)) {
-                if (get_user_ual(addr, gp))
-                    return -TARGET_EFAULT;
-                if (!addr)
-                    break;
-                argc++;
-            }
-            envc = 0;
-            guest_envp = arg3;
-            for (gp = guest_envp; gp; gp += sizeof(abi_ulong)) {
-                if (get_user_ual(addr, gp))
-                    return -TARGET_EFAULT;
-                if (!addr)
-                    break;
-                envc++;
-            }
-
-            argp = g_new0(char *, argc + 1);
-            envp = g_new0(char *, envc + 1);
-
-            for (gp = guest_argp, q = argp; gp;
-                  gp += sizeof(abi_ulong), q++) {
-                if (get_user_ual(addr, gp))
-                    goto execve_efault;
-                if (!addr)
-                    break;
-                if (!(*q = lock_user_string(addr)))
-                    goto execve_efault;
-                total_size += strlen(*q) + 1;
-            }
-            *q = NULL;
-
-            for (gp = guest_envp, q = envp; gp;
-                  gp += sizeof(abi_ulong), q++) {
-                if (get_user_ual(addr, gp))
-                    goto execve_efault;
-                if (!addr)
-                    break;
-                if (!(*q = lock_user_string(addr)))
-                    goto execve_efault;
-                total_size += strlen(*q) + 1;
-            }
-            *q = NULL;
-
-            if (!(p = lock_user_string(arg1)))
-                goto execve_efault;
-            /* Although execve() is not an interruptible syscall it is
-             * a special case where we must use the safe_syscall wrapper:
-             * if we allow a signal to happen before we make the host
-             * syscall then we will 'lose' it, because at the point of
-             * execve the process leaves QEMU's control. So we use the
-             * safe syscall wrapper to ensure that we either take the
-             * signal as a guest signal, or else it does not happen
-             * before the execve completes and makes it the other
-             * program's problem.
-             */
-            ret = get_errno(safe_execve(p, argp, envp));
-            unlock_user(p, arg1, 0);
-
-            goto execve_end;
-
-        execve_efault:
-            ret = -TARGET_EFAULT;
-
-        execve_end:
-            for (gp = guest_argp, q = argp; *q;
-                  gp += sizeof(abi_ulong), q++) {
-                if (get_user_ual(addr, gp)
-                    || !addr)
-                    break;
-                unlock_user(*q, addr, 0);
-            }
-            for (gp = guest_envp, q = envp; *q;
-                  gp += sizeof(abi_ulong), q++) {
-                if (get_user_ual(addr, gp)
-                    || !addr)
-                    break;
-                unlock_user(*q, addr, 0);
-            }
-
-            g_free(argp);
-            g_free(envp);
-        }
-        return ret;
     case TARGET_NR_chdir:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
@@ -12916,6 +12924,7 @@ IMPL(everything_else)
 static impl_fn * const syscall_table[] = {
     [TARGET_NR_brk] = impl_brk,
     [TARGET_NR_close] = impl_close,
+    [TARGET_NR_execve] = impl_execve,
     [TARGET_NR_exit] = impl_exit,
     [TARGET_NR_read] = impl_read,
     [TARGET_NR_write] = impl_write,
-- 
2.17.0
