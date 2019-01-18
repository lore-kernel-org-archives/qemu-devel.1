Received: from eggs.gnu.org ([209.51.188.92]:56469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblI-0005rk-9j
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblG-0005dZ-7I
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:11 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkblG-0005cN-1N
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:10 -0500
Received: by mail-pl1-x644.google.com with SMTP id y1so6881297plp.9
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:33:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:16 +1100
Message-Id: <20190118213122.22865-43-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 43/49] linux-user: Split out dup, dup2, dup3
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

Note that dup3 is universally available for guests.
Implement host support with syscall when !CONFIG_DUP3.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  5 +++++
 linux-user/syscall-file.inc.c | 42 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 33 +++------------------------
 linux-user/strace.list        |  6 -----
 4 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 8b6d8f75ff..062adddd75 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -34,6 +34,11 @@ SYSCALL_DEF(close, ARG_DEC);
 #ifdef TARGET_NR_creat
 SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
 #endif
+SYSCALL_DEF(dup, ARG_DEC);
+#ifdef TARGET_NR_dup2
+SYSCALL_DEF(dup2, ARG_DEC, ARG_DEC);
+#endif
+SYSCALL_DEF(dup3, ARG_DEC, ARG_DEC, ARG_OPENFLAG);
 SYSCALL_DEF(exit, ARG_DEC);
 SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(execveat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 83174c5781..5e8298fdb3 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -94,6 +94,48 @@ SYSCALL_IMPL(creat)
 }
 #endif
 
+SYSCALL_IMPL(dup)
+{
+    abi_long ret = get_errno(dup(arg1));
+    if (ret >= 0) {
+        fd_trans_dup(arg1, ret);
+    }
+    return ret;
+}
+
+#ifdef TARGET_NR_dup2
+SYSCALL_IMPL(dup2)
+{
+    abi_long ret = get_errno(dup2(arg1, arg2));
+    if (ret >= 0) {
+        fd_trans_dup(arg1, arg2);
+    }
+    return ret;
+}
+#endif
+
+SYSCALL_IMPL(dup3)
+{
+    int ofd = arg1;
+    int nfd = arg2;
+    int host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
+    abi_long ret;
+
+#ifdef CONFIG_DUP3
+    ret = dup3(ofd, nfd, host_flags);
+#else
+    if (host_flags == 0) {
+        if (ofd == nfd) {
+            return -TARGET_EINVAL;
+        }
+        ret = dup2(ofd, nfd);
+    } else {
+        ret = syscall(__NR_dup3, ofd, nfd, host_flags);
+    }
+#endif
+    return get_errno(ret);
+}
+
 SYSCALL_IMPL(faccessat)
 {
     return do_faccessat(arg1, arg2, arg3);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7874a48840..29a9d5fce4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -204,6 +204,9 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
  * Performing a bogus sysacll is lazier than boilerplating
  * the replacement functions here in C.
  */
+#ifndef __NR_dup3
+#define __NR_dup3  -1
+#endif
 #ifndef __NR_syncfs
 #define __NR_syncfs  -1
 #endif
@@ -5320,12 +5323,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_dup:
-        ret = get_errno(dup(arg1));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, ret);
-        }
-        return ret;
 #ifdef TARGET_NR_pipe
     case TARGET_NR_pipe:
         return do_pipe(cpu_env, arg1, 0, 0);
@@ -5380,30 +5377,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(chroot(p));
         unlock_user(p, arg1, 0);
         return ret;
-#ifdef TARGET_NR_dup2
-    case TARGET_NR_dup2:
-        ret = get_errno(dup2(arg1, arg2));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, arg2);
-        }
-        return ret;
-#endif
-#if defined(CONFIG_DUP3) && defined(TARGET_NR_dup3)
-    case TARGET_NR_dup3:
-    {
-        int host_flags;
-
-        if ((arg3 & ~TARGET_O_CLOEXEC) != 0) {
-            return -EINVAL;
-        }
-        host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
-        ret = get_errno(dup3(arg1, arg2, host_flags));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, arg2);
-        }
-        return ret;
-    }
-#endif
 #ifdef TARGET_NR_getpgrp
     case TARGET_NR_getpgrp:
         return get_errno(getpgrp());
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 678feeeb7b..151b0eb42d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -91,12 +91,6 @@
 #ifdef TARGET_NR_dipc
 { TARGET_NR_dipc, "dipc" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_dup
-{ TARGET_NR_dup, "dup" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_dup2
-{ TARGET_NR_dup2, "dup2" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_epoll_create
 { TARGET_NR_epoll_create, "epoll_create" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
