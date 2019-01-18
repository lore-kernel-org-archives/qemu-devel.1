Received: from eggs.gnu.org ([209.51.188.92]:56358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbl8-0005gN-QJ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbl6-0005Q0-Nq
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:02 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbl6-0005NR-Hg
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:00 -0500
Received: by mail-pg1-x543.google.com with SMTP id n2so6650602pgm.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:12 +1100
Message-Id: <20190118213122.22865-39-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 39/49] linux-user: Split out sync, syncfs
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

Note that syncfs is universally available.
If !CONFIG_SYNCFS, provide our own syscall replacement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  2 ++
 linux-user/syscall-file.inc.c | 11 +++++++++++
 linux-user/syscall.c          | 20 ++++++++++++--------
 linux-user/strace.list        |  6 ------
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 860754aaca..497fbdba66 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -171,6 +171,8 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #ifdef TARGET_NR_stime
 SYSCALL_DEF(stime, ARG_PTR);
 #endif
+SYSCALL_DEF(sync);
+SYSCALL_DEF(syncfs, ARG_DEC);
 #ifdef TARGET_NR_time
 SYSCALL_DEF(time, ARG_PTR);
 #endif
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 3111abd861..80dec33971 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -867,6 +867,17 @@ SYSCALL_IMPL(readlinkat)
 }
 #endif
 
+SYSCALL_IMPL(sync)
+{
+    sync();
+    return 0;
+}
+
+SYSCALL_IMPL(syncfs)
+{
+    return get_errno(syncfs(arg1));
+}
+
 static abi_long do_umount2(abi_ulong target_path, int flags)
 {
     char *p = lock_user_string(target_path);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 351b2a6288..6668e4ada8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -199,6 +199,15 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define TARGET_NR_llseek TARGET_NR__llseek
 #endif
 
+/*
+ * These definitions produce an ENOSYS from the host kernel.
+ * Performing a bogus sysacll is lazier than boilerplating
+ * the replacement functions here in C.
+ */
+#ifndef __NR_syncfs
+#define __NR_syncfs  -1
+#endif
+
 #ifdef __NR_gettid
 _syscall0(int, gettid)
 #else
@@ -264,11 +273,13 @@ _syscall3(int, ioprio_set, int, which, int, who, int, ioprio)
 #if defined(TARGET_NR_getrandom) && defined(__NR_getrandom)
 _syscall3(int, getrandom, void *, buf, size_t, buflen, unsigned int, flags)
 #endif
-
 #if defined(TARGET_NR_kcmp) && defined(__NR_kcmp)
 _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
           unsigned long, idx1, unsigned long, idx2)
 #endif
+#ifndef CONFIG_SYNCFS
+_syscall1(int, syncfs, int, fd)
+#endif
 
 static bitmask_transtbl fcntl_flags_tbl[] = {
   { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
@@ -5327,13 +5338,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_sync:
-        sync();
-        return 0;
-#if defined(TARGET_NR_syncfs) && defined(CONFIG_SYNCFS)
-    case TARGET_NR_syncfs:
-        return get_errno(syncfs(arg1));
-#endif
     case TARGET_NR_kill:
         return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
 #ifdef TARGET_NR_rename
diff --git a/linux-user/strace.list b/linux-user/strace.list
index aaea23d433..56f25c15b7 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1260,12 +1260,6 @@
 #ifdef TARGET_NR_symlinkat
 { TARGET_NR_symlinkat, "symlinkat", NULL, print_symlinkat, NULL },
 #endif
-#ifdef TARGET_NR_sync
-{ TARGET_NR_sync, "sync" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_syncfs
-{ TARGET_NR_syncfs, "syncfs" , "%s(%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_syscall
 { TARGET_NR_syscall, "syscall" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
