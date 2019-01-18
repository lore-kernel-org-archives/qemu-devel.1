Received: from eggs.gnu.org ([209.51.188.92]:56191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkt-0005YW-9z
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkp-00055c-H0
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:45 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkn-00052s-IU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:42 -0500
Received: by mail-pf1-x444.google.com with SMTP id h3so7218884pfg.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:04 +1100
Message-Id: <20190118213122.22865-31-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 31/49] linux-user: Split out getpid, getppid,
 getxpid
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
 linux-user/syscall-defs.h     |  9 +++++++++
 linux-user/syscall-proc.inc.c | 23 +++++++++++++++++++++++
 linux-user/syscall.c          | 14 --------------
 linux-user/strace.list        |  9 ---------
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 3453e7afdf..d163bbf409 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -36,6 +36,15 @@ SYSCALL_DEF(fchmodat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
+#ifdef TARGET_NR_getpid
+SYSCALL_DEF(getpid);
+#endif
+#ifdef TARGET_NR_getppid
+SYSCALL_DEF(getppid);
+#endif
+#ifdef TARGET_NR_getxpid
+SYSCALL_DEF(getxpid);
+#endif
 #ifdef TARGET_NR_ipc
 SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 699370c290..c09c83775c 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -438,6 +438,29 @@ SYSCALL_IMPL(fork)
 }
 #endif
 
+#ifdef TARGET_NR_getpid
+SYSCALL_IMPL(getpid)
+{
+    return getpid();
+}
+#endif
+
+#ifdef TARGET_NR_getppid
+SYSCALL_IMPL(getppid)
+{
+    return getppid();
+}
+#endif
+
+#ifdef TARGET_NR_getxpid
+SYSCALL_IMPL(getxpid)
+{
+    /* Alpha specific */
+    cpu_env->ir[IR_A4] = getppid();
+    return getpid();
+}
+#endif
+
 /*
  * Map host to target signal numbers for the wait family of syscalls.
  * Assume all other status bits are the same.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 09fcec7812..6ea1a67345 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5327,16 +5327,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
-    /* Alpha specific */
-    case TARGET_NR_getxpid:
-        ((CPUAlphaState *)cpu_env)->ir[IR_A4] = getppid();
-        return get_errno(getpid());
-#endif
-#ifdef TARGET_NR_getpid
-    case TARGET_NR_getpid:
-        return get_errno(getpid());
-#endif
     case TARGET_NR_mount:
         {
             /* need to look at the data field */
@@ -5668,10 +5658,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
-#ifdef TARGET_NR_getppid /* not on alpha */
-    case TARGET_NR_getppid:
-        return get_errno(getppid());
-#endif
 #ifdef TARGET_NR_getpgrp
     case TARGET_NR_getpgrp:
         return get_errno(getpgrp());
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 18c93ccc2d..344a2232d6 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -298,15 +298,9 @@
 #ifdef TARGET_NR_getpgrp
 { TARGET_NR_getpgrp, "getpgrp" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getpid
-{ TARGET_NR_getpid, "getpid" , "%s()", NULL, NULL },
-#endif
 #ifdef TARGET_NR_getpmsg
 { TARGET_NR_getpmsg, "getpmsg" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getppid
-{ TARGET_NR_getppid, "getppid" , "%s()", NULL, NULL },
-#endif
 #ifdef TARGET_NR_getpriority
 { TARGET_NR_getpriority, "getpriority", "%s(%#x,%#x)", NULL, NULL },
 #endif
@@ -365,9 +359,6 @@
 #ifdef TARGET_NR_getxgid
 { TARGET_NR_getxgid, "getxgid" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getxpid
-{ TARGET_NR_getxpid, "getxpid" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_getxuid
 { TARGET_NR_getxuid, "getxuid" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
