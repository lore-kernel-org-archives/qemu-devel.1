Received: from eggs.gnu.org ([209.51.188.92]:56089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkf-0005Ni-Sd
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbke-0004v5-IN
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:33 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbke-0004tQ-Bd
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:32 -0500
Received: by mail-pf1-x444.google.com with SMTP id b7so7192468pfi.8
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:00 +1100
Message-Id: <20190118213122.22865-27-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 27/49] linux-user: Split out time
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
 linux-user/syscall-defs.h     |  3 +++
 linux-user/syscall-time.inc.c | 32 ++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 13 +------------
 linux-user/strace.list        |  3 ---
 4 files changed, 36 insertions(+), 15 deletions(-)
 create mode 100644 linux-user/syscall-time.inc.c

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 3fad9d51f0..9950b73e76 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -127,6 +127,9 @@ SYSCALL_DEF(shmdt, ARG_PTR);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_shmget)
 SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
+#ifdef TARGET_NR_time
+SYSCALL_DEF(time, ARG_PTR);
+#endif
 #ifdef TARGET_NR_unlink
 SYSCALL_DEF(unlink, ARG_STR);
 #endif
diff --git a/linux-user/syscall-time.inc.c b/linux-user/syscall-time.inc.c
new file mode 100644
index 0000000000..14fec88e47
--- /dev/null
+++ b/linux-user/syscall-time.inc.c
@@ -0,0 +1,32 @@
+/*
+ *  Linux time related syscalls
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifdef TARGET_NR_time
+SYSCALL_IMPL(time)
+{
+    time_t host_time;
+    abi_long ret = get_errno(time(&host_time));
+
+    if (!is_error(ret)
+        && arg1
+        && put_user_sal(host_time, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1cdc9727a9..cc5360ae43 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5331,18 +5331,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_time
-    case TARGET_NR_time:
-        {
-            time_t host_time;
-            ret = get_errno(time(&host_time));
-            if (!is_error(ret)
-                && arg1
-                && put_user_sal(host_time, arg1))
-                return -TARGET_EFAULT;
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_mknod
     case TARGET_NR_mknod:
         if (!(p = lock_user_string(arg1)))
@@ -9303,6 +9291,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #include "syscall-ipc.inc.c"
 #include "syscall-mem.inc.c"
 #include "syscall-proc.inc.c"
+#include "syscall-time.inc.c"
 
 #undef SYSCALL_IMPL
 #undef SYSCALL_ARGS
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 357984dd6f..3505014501 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1350,9 +1350,6 @@
 #ifdef TARGET_NR_tgkill
 { TARGET_NR_tgkill, "tgkill" , NULL, print_tgkill, NULL },
 #endif
-#ifdef TARGET_NR_time
-{ TARGET_NR_time, "time" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_timer_create
 { TARGET_NR_timer_create, "timer_create" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
