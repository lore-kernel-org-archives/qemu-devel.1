Received: from eggs.gnu.org ([209.51.188.92]:56082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkf-0005Mq-93
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkd-0004td-Tg
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:33 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkd-0004mg-KQ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:31 -0500
Received: by mail-pf1-x441.google.com with SMTP id r136so7201503pfc.6
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:57 +1100
Message-Id: <20190118213122.22865-24-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 24/49] linux-user: Split out execve
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
 linux-user/syscall-defs.h     |   1 +
 linux-user/strace.c           |  32 ----------
 linux-user/syscall-proc.inc.c | 110 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          |  97 ------------------------------
 linux-user/strace.list        |   3 -
 5 files changed, 111 insertions(+), 132 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 78d3f600eb..58fef48666 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -25,6 +25,7 @@ SYSCALL_DEF(close, ARG_DEC);
 SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(exit, ARG_DEC);
+SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index a41b6dcfe7..43865e9df9 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -568,38 +568,6 @@ print_newselect(const struct syscallname *name,
 }
 #endif
 
-static void
-print_execve(const struct syscallname *name,
-             abi_long arg1, abi_long arg2, abi_long arg3,
-             abi_long arg4, abi_long arg5, abi_long arg6)
-{
-    abi_ulong arg_ptr_addr;
-    char *s;
-
-    if (!(s = lock_user_string(arg1)))
-        return;
-    gemu_log("%s(\"%s\",{", name->name, s);
-    unlock_user(s, arg1, 0);
-
-    for (arg_ptr_addr = arg2; ; arg_ptr_addr += sizeof(abi_ulong)) {
-        abi_ulong *arg_ptr, arg_addr;
-
-        arg_ptr = lock_user(VERIFY_READ, arg_ptr_addr, sizeof(abi_ulong), 1);
-        if (!arg_ptr)
-            return;
-    arg_addr = tswapal(*arg_ptr);
-        unlock_user(arg_ptr, arg_ptr_addr, 0);
-        if (!arg_addr)
-            break;
-        if ((s = lock_user_string(arg_addr))) {
-            gemu_log("\"%s\",", s);
-            unlock_user(s, arg_addr, 0);
-        }
-    }
-
-    gemu_log("NULL})");
-}
-
 /*
  * Variants for the return value output function
  */
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index de4efed9f4..552aea60ae 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -269,6 +269,116 @@ SYSCALL_IMPL(clone)
     return do_clone(cpu_env, arg1, arg2, arg3, arg4, arg5);
 }
 
+SYSCALL_IMPL(execve)
+{
+    char **argp, **envp;
+    int argc, envc;
+    abi_ulong gp;
+    abi_ulong guest_path = arg1;
+    abi_ulong guest_argp = arg2;
+    abi_ulong guest_envp = arg3;
+    abi_ulong addr;
+    char **q, *p;
+    int total_size = 0;
+    abi_long ret = -TARGET_EFAULT;
+
+    argc = 0;
+    for (gp = guest_argp; gp; gp += sizeof(abi_ulong)) {
+        if (get_user_ual(addr, gp)) {
+            goto execve_nofree;
+        }
+        if (!addr) {
+            break;
+        }
+        argc++;
+    }
+    envc = 0;
+    for (gp = guest_envp; gp; gp += sizeof(abi_ulong)) {
+        if (get_user_ual(addr, gp)) {
+            goto execve_nofree;
+        }
+        if (!addr) {
+            break;
+        }
+        envc++;
+    }
+
+    argp = g_new0(char *, argc + 1);
+    envp = g_new0(char *, envc + 1);
+
+    for (gp = guest_argp, q = argp; gp; gp += sizeof(abi_ulong), q++) {
+        char *this_q;
+
+        if (get_user_ual(addr, gp)) {
+            goto execve_free;
+        }
+        if (!addr) {
+            break;
+        }
+        this_q = lock_user_string(addr);
+        if (!this_q) {
+            goto execve_free;
+        }
+        *q = this_q;
+        total_size += strlen(this_q) + 1;
+    }
+
+    for (gp = guest_envp, q = envp; gp; gp += sizeof(abi_ulong), q++) {
+        char *this_q;
+
+        if (get_user_ual(addr, gp)) {
+            goto execve_free;
+        }
+        if (!addr) {
+            break;
+        }
+        this_q = lock_user_string(addr);
+        if (!this_q) {
+            goto execve_free;
+        }
+        *q = this_q;
+        total_size += strlen(this_q) + 1;
+    }
+
+    p = lock_user_string(guest_path);
+    if (!p) {
+        goto execve_free;
+    }
+
+    /*
+     * Although execve() is not an interruptible syscall it is
+     * a special case where we must use the safe_syscall wrapper:
+     * if we allow a signal to happen before we make the host
+     * syscall then we will 'lose' it, because at the point of
+     * execve the process leaves QEMU's control. So we use the
+     * safe syscall wrapper to ensure that we either take the
+     * signal as a guest signal, or else it does not happen
+     * before the execve completes and makes it the other
+     * program's problem.
+     */
+    ret = get_errno(safe_execve(p, argp, envp));
+    unlock_user(p, guest_path, 0);
+
+ execve_free:
+    for (gp = guest_argp, q = argp; *q; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp) || !addr) {
+            break;
+        }
+        unlock_user(*q, addr, 0);
+    }
+    for (gp = guest_envp, q = envp; *q; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp) || !addr) {
+            break;
+        }
+        unlock_user(*q, addr, 0);
+    }
+    g_free(argp);
+    g_free(envp);
+
+ execve_nofree:
+    return ret;
+}
+
 SYSCALL_IMPL(exit)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index eda199d46f..9b5b2eb7f1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5330,103 +5330,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
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
diff --git a/linux-user/strace.list b/linux-user/strace.list
index faa0a9012d..8bc3fe6088 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -139,9 +139,6 @@
 #ifdef TARGET_NR_execv
 { TARGET_NR_execv, "execv" , NULL, print_execv, NULL },
 #endif
-#ifdef TARGET_NR_execve
-{ TARGET_NR_execve, "execve" , NULL, print_execve, NULL },
-#endif
 #ifdef TARGET_NR_execveat
 { TARGET_NR_execveat, "execveat" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
