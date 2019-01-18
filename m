Received: from eggs.gnu.org ([209.51.188.92]:56330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbl6-0005g6-JO
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbl4-0005N7-Qa
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:00 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbl3-0005J5-58
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:58 -0500
Received: by mail-pg1-x542.google.com with SMTP id y4so6630308pgc.12
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:11 +1100
Message-Id: <20190118213122.22865-38-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 38/49] linux-user: Split out nice
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
 linux-user/syscall-defs.h     | 3 +++
 linux-user/syscall-proc.inc.c | 7 +++++++
 linux-user/syscall.c          | 4 ----
 linux-user/strace.list        | 3 ---
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 39e3ae3c21..860754aaca 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -111,6 +111,9 @@ SYSCALL_DEF(munlockall);
 SYSCALL_DEF(munmap, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(name_to_handle_at,
             ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
+#ifdef TARGET_NR_nice
+SYSCALL_DEF(nice, ARG_DEC);
+#endif
 #ifdef TARGET_NR_open
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index c09c83775c..58c0a22300 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -461,6 +461,13 @@ SYSCALL_IMPL(getxpid)
 }
 #endif
 
+#ifdef TARGET_NR_nice
+SYSCALL_IMPL(nice)
+{
+    return get_errno(nice(arg1));
+}
+#endif
+
 /*
  * Map host to target signal numbers for the wait family of syscalls.
  * Assume all other status bits are the same.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9074cf8b8d..351b2a6288 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5327,10 +5327,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_nice /* not on alpha */
-    case TARGET_NR_nice:
-        return get_errno(nice(arg1));
-#endif
     case TARGET_NR_sync:
         sync();
         return 0;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index fc0eb91e29..aaea23d433 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -527,9 +527,6 @@
 #ifdef TARGET_NR_nfsservctl
 { TARGET_NR_nfsservctl, "nfsservctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_nice
-{ TARGET_NR_nice, "nice" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_old_adjtimex
 { TARGET_NR_old_adjtimex, "old_adjtimex" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
