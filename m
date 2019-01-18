Received: from eggs.gnu.org ([209.51.188.92]:56271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbl1-0005ay-1L
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkz-0005Dp-5f
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:54 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkx-0005AG-A3
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:51 -0500
Received: by mail-pf1-x442.google.com with SMTP id y126so7208025pfb.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:08 +1100
Message-Id: <20190118213122.22865-35-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 35/49] linux-user: Split out alarm, pause
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
 linux-user/syscall-defs.h    |  6 ++++++
 linux-user/syscall-sig.inc.c | 36 ++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c         | 12 +-----------
 linux-user/strace.list       |  6 ------
 4 files changed, 43 insertions(+), 17 deletions(-)
 create mode 100644 linux-user/syscall-sig.inc.c

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 6ca82af397..9d0dd7457b 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -16,6 +16,9 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#ifdef TARGET_NR_alarm
+SYSCALL_DEF(alarm, ARG_DEC);
+#endif
 SYSCALL_DEF_FULL(brk, .impl = impl_brk,
                  .print_ret = print_syscall_ptr_ret,
                  .arg_type = { ARG_PTR });
@@ -106,6 +109,9 @@ SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 SYSCALL_DEF(open_by_handle_at, ARG_DEC, ARG_PTR, ARG_OPENFLAG);
+#ifdef TARGET_NR_pause
+SYSCALL_DEF(pause);
+#endif
 SYSCALL_DEF_FULL(pread64, .impl = impl_pread64,
                  .args = args_pread64_pwrite64,
                  .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
new file mode 100644
index 0000000000..f4e43eb00e
--- /dev/null
+++ b/linux-user/syscall-sig.inc.c
@@ -0,0 +1,36 @@
+/*
+ *  Linux signal related syscalls
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
+#ifdef TARGET_NR_alarm
+SYSCALL_IMPL(alarm)
+{
+    return alarm(arg1);
+}
+#endif
+
+#ifdef TARGET_NR_pause
+SYSCALL_IMPL(pause)
+{
+    if (!block_signals()) {
+        CPUState *cpu = ENV_GET_CPU(cpu_env);
+        TaskState *ts = cpu->opaque;
+        sigsuspend(&ts->signal_mask);
+    }
+    return -TARGET_EINTR;
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c0ce4068b6..f3ea9600c8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5327,17 +5327,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_alarm /* not on alpha */
-    case TARGET_NR_alarm:
-        return alarm(arg1);
-#endif
-#ifdef TARGET_NR_pause /* not on alpha */
-    case TARGET_NR_pause:
-        if (!block_signals()) {
-            sigsuspend(&((TaskState *)cpu->opaque)->signal_mask);
-        }
-        return -TARGET_EINTR;
-#endif
 #ifdef TARGET_NR_utime
     case TARGET_NR_utime:
         {
@@ -9135,6 +9124,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #include "syscall-ipc.inc.c"
 #include "syscall-mem.inc.c"
 #include "syscall-proc.inc.c"
+#include "syscall-sig.inc.c"
 #include "syscall-time.inc.c"
 
 #undef SYSCALL_IMPL
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a5f308c497..b119b7a20c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -25,9 +25,6 @@
 #ifdef TARGET_NR_afs_syscall
 { TARGET_NR_afs_syscall, "afs_syscall" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_alarm
-{ TARGET_NR_alarm, "alarm" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_aplib
 { TARGET_NR_aplib, "aplib" , NULL, NULL, NULL },
 #endif
@@ -872,9 +869,6 @@
 #ifdef TARGET_NR_osf_waitid
 { TARGET_NR_osf_waitid, "osf_waitid" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pause
-{ TARGET_NR_pause, "pause" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_pciconfig_iobase
 { TARGET_NR_pciconfig_iobase, "pciconfig_iobase" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
