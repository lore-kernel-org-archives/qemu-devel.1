Received: from eggs.gnu.org ([209.51.188.92]:56476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblI-0005s2-IW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblH-0005gd-Gs
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:12 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkblH-0005fI-Af
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:11 -0500
Received: by mail-pf1-x441.google.com with SMTP id r136so7202294pfc.6
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:33:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:17 +1100
Message-Id: <20190118213122.22865-44-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 44/49] linux-user: Split out pipe, pipe2
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

Note that pipe2 is universally available for guests.
Implement host support with syscall when !CONFIG_PIPE2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     | 10 ++++++
 linux-user/syscall-file.inc.c | 51 +++++++++++++++++++++++++++
 linux-user/syscall.c          | 65 +++++++----------------------------
 linux-user/strace.list        |  6 ----
 4 files changed, 74 insertions(+), 58 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 062adddd75..bd3301a72f 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -132,6 +132,16 @@ SYSCALL_DEF(open_by_handle_at, ARG_DEC, ARG_PTR, ARG_OPENFLAG);
 #ifdef TARGET_NR_pause
 SYSCALL_DEF(pause);
 #endif
+#ifdef TARGET_NR_pipe
+# if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || \
+     defined(TARGET_SH4) || defined(TARGET_SPARC)
+/* ??? We have no way for strace to display the second returned fd.  */
+SYSCALL_DEF(pipe);
+# else
+SYSCALL_DEF(pipe, ARG_PTR);
+# endif
+#endif
+SYSCALL_DEF(pipe2, ARG_PTR, ARG_OPENFLAG);
 SYSCALL_DEF_FULL(pread64, .impl = impl_pread64,
                  .args = args_pread64_pwrite64,
                  .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 5e8298fdb3..90aacfacaf 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -720,6 +720,57 @@ SYSCALL_IMPL(open_by_handle_at)
     return ret;
 }
 
+static abi_long do_pipe(CPUArchState *cpu_env, abi_ulong target_fds,
+                        int target_flags, bool is_pipe2)
+{
+    int host_flags = target_to_host_bitmask(target_flags, fcntl_flags_tbl);
+    int host_fds[2];
+    abi_long ret;
+
+    ret = pipe2(host_fds, host_flags);
+    if (is_error(ret)) {
+        return get_errno(ret);
+    }
+
+    /*
+     * Several targets have special calling conventions for the original
+     * pipe syscall, but didn't replicate this into the pipe2 syscall.
+     */
+    if (!is_pipe2) {
+#if defined(TARGET_ALPHA)
+        cpu_env->ir[IR_A4] = host_fds[1];
+        return host_fds[0];
+#elif defined(TARGET_MIPS)
+        cpu_env->active_tc.gpr[3] = host_fds[1];
+        return host_fds[0];
+#elif defined(TARGET_SH4)
+        cpu_env->gregs[1] = host_fds[1];
+        return host_fds[0];
+#elif defined(TARGET_SPARC)
+        cpu_env->regwptr[1] = host_fds[1];
+        return host_fds[0];
+#endif
+    }
+
+    if (put_user_s32(host_fds[0], target_fds)
+        || put_user_s32(host_fds[1], target_fds + 4)) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+
+#ifdef TARGET_NR_pipe
+SYSCALL_IMPL(pipe)
+{
+    return do_pipe(cpu_env, arg1, 0, false);
+}
+#endif
+
+SYSCALL_IMPL(pipe2)
+{
+    return do_pipe(cpu_env, arg1, arg2, true);
+}
+
 /*
  * Both pread64 and pwrite64 merge args into a 64-bit offset,
  * but the input registers and ordering are target specific.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 29a9d5fce4..3a322a61ca 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -207,6 +207,9 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #ifndef __NR_dup3
 #define __NR_dup3  -1
 #endif
+#ifndef __NR_pipe2
+#define __NR_pipe2  -1
+#endif
 #ifndef __NR_syncfs
 #define __NR_syncfs  -1
 #endif
@@ -283,6 +286,16 @@ _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
 #ifndef CONFIG_SYNCFS
 _syscall1(int, syncfs, int, fd)
 #endif
+#ifndef CONFIG_PIPE2
+static int pipe2(int *fds, int flags)
+{
+    if (flags) {
+        return syscall(__NR_pipe2, fds, flags);
+    } else {
+        return pipe(fds);
+    }
+}
+#endif
 
 static bitmask_transtbl fcntl_flags_tbl[] = {
   { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
@@ -1134,49 +1147,6 @@ static abi_long do_old_select(abi_ulong arg1)
 #endif
 #endif
 
-static abi_long do_pipe2(int host_pipe[], int flags)
-{
-#ifdef CONFIG_PIPE2
-    return pipe2(host_pipe, flags);
-#else
-    return -ENOSYS;
-#endif
-}
-
-static abi_long do_pipe(void *cpu_env, abi_ulong pipedes,
-                        int flags, int is_pipe2)
-{
-    int host_pipe[2];
-    abi_long ret;
-    ret = flags ? do_pipe2(host_pipe, flags) : pipe(host_pipe);
-
-    if (is_error(ret))
-        return get_errno(ret);
-
-    /* Several targets have special calling conventions for the original
-       pipe syscall, but didn't replicate this into the pipe2 syscall.  */
-    if (!is_pipe2) {
-#if defined(TARGET_ALPHA)
-        ((CPUAlphaState *)cpu_env)->ir[IR_A4] = host_pipe[1];
-        return host_pipe[0];
-#elif defined(TARGET_MIPS)
-        ((CPUMIPSState*)cpu_env)->active_tc.gpr[3] = host_pipe[1];
-        return host_pipe[0];
-#elif defined(TARGET_SH4)
-        ((CPUSH4State*)cpu_env)->gregs[1] = host_pipe[1];
-        return host_pipe[0];
-#elif defined(TARGET_SPARC)
-        ((CPUSPARCState*)cpu_env)->regwptr[1] = host_pipe[1];
-        return host_pipe[0];
-#endif
-    }
-
-    if (put_user_s32(host_pipe[0], pipedes)
-        || put_user_s32(host_pipe[1], pipedes + sizeof(host_pipe[0])))
-        return -TARGET_EFAULT;
-    return get_errno(ret);
-}
-
 static inline abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn,
                                               abi_ulong target_addr,
                                               socklen_t len)
@@ -5323,15 +5293,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_pipe
-    case TARGET_NR_pipe:
-        return do_pipe(cpu_env, arg1, 0, 0);
-#endif
-#ifdef TARGET_NR_pipe2
-    case TARGET_NR_pipe2:
-        return do_pipe(cpu_env, arg1,
-                       target_to_host_bitmask(arg2, fcntl_flags_tbl), 1);
-#endif
     case TARGET_NR_times:
         {
             struct target_tms *tmsp;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 151b0eb42d..ac25e13bfa 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -860,9 +860,6 @@
 #ifdef TARGET_NR_personality
 { TARGET_NR_personality, "personality" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pipe
-{ TARGET_NR_pipe, "pipe" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_pivot_root
 { TARGET_NR_pivot_root, "pivot_root" , NULL, NULL, NULL },
 #endif
@@ -1377,9 +1374,6 @@
 #ifdef TARGET_NR_sync_file_range2
 { TARGET_NR_sync_file_range2, "sync_file_range2", NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pipe2
-{ TARGET_NR_pipe2, "pipe2", NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_atomic_cmpxchg_32
 { TARGET_NR_atomic_cmpxchg_32, "atomic_cmpxchg_32", NULL, NULL, NULL },
 #endif
-- 
2.17.2
