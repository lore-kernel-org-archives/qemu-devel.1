Received: from eggs.gnu.org ([209.51.188.92]:55911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkF-00053A-Nh
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkE-0004W1-N4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:07 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkE-0004VE-HH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:06 -0500
Received: by mail-pf1-x443.google.com with SMTP id u6so7187532pfh.11
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:49 +1100
Message-Id: <20190118213122.22865-16-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 16/49] linux-user: Split out exit
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
 linux-user/syscall-defs.h     |  1 +
 linux-user/syscall-proc.inc.c | 61 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 38 +---------------------
 3 files changed, 63 insertions(+), 37 deletions(-)
 create mode 100644 linux-user/syscall-proc.inc.c

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 88f433e998..88aa1a6bfd 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -17,6 +17,7 @@
  */
 
 SYSCALL_DEF(close, ARG_DEC);
+SYSCALL_DEF(exit, ARG_DEC);
 #ifdef TARGET_NR_ipc
 SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
new file mode 100644
index 0000000000..96ad363c1a
--- /dev/null
+++ b/linux-user/syscall-proc.inc.c
@@ -0,0 +1,61 @@
+/*
+ *  Linux process related syscalls
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
+
+SYSCALL_IMPL(exit)
+{
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    int status = arg1;
+
+    /*
+     * In old applications this may be used to implement _exit(2).
+     * However in threaded applictions it is used for thread termination,
+     * and _exit_group is used for application termination.
+     * Do thread termination if we have more then one thread.
+     */
+    if (block_signals()) {
+        return -TARGET_ERESTARTSYS;
+    }
+
+    cpu_list_lock();
+
+    if (CPU_NEXT(first_cpu)) {
+        TaskState *ts;
+
+        /* Remove the CPU from the list.  */
+        QTAILQ_REMOVE_RCU(&cpus, cpu, node);
+
+        cpu_list_unlock();
+
+        ts = cpu->opaque;
+        if (ts->child_tidptr) {
+            put_user_u32(0, ts->child_tidptr);
+            sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
+                      NULL, NULL, 0);
+        }
+        thread_cpu = NULL;
+        object_unref(OBJECT(cpu));
+        g_free(ts);
+        rcu_unregister_thread();
+        pthread_exit(NULL);
+    }
+
+    cpu_list_unlock();
+    preexit_cleanup(cpu_env, status);
+    _exit(status);
+}
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 142654a0a0..02010f9ae0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5626,43 +5626,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_exit:
-        /* In old applications this may be used to implement _exit(2).
-           However in threaded applictions it is used for thread termination,
-           and _exit_group is used for application termination.
-           Do thread termination if we have more then one thread.  */
-
-        if (block_signals()) {
-            return -TARGET_ERESTARTSYS;
-        }
-
-        cpu_list_lock();
-
-        if (CPU_NEXT(first_cpu)) {
-            TaskState *ts;
-
-            /* Remove the CPU from the list.  */
-            QTAILQ_REMOVE_RCU(&cpus, cpu, node);
-
-            cpu_list_unlock();
-
-            ts = cpu->opaque;
-            if (ts->child_tidptr) {
-                put_user_u32(0, ts->child_tidptr);
-                sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
-                          NULL, NULL, 0);
-            }
-            thread_cpu = NULL;
-            object_unref(OBJECT(cpu));
-            g_free(ts);
-            rcu_unregister_thread();
-            pthread_exit(NULL);
-        }
-
-        cpu_list_unlock();
-        preexit_cleanup(cpu_env, arg1);
-        _exit(arg1);
-        return 0; /* avoid warning */
     case TARGET_NR_brk:
         return do_brk(arg1);
 #ifdef TARGET_NR_fork
@@ -9884,6 +9847,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #include "syscall-file.inc.c"
 #include "syscall-ipc.inc.c"
 #include "syscall-mem.inc.c"
+#include "syscall-proc.inc.c"
 
 #undef SYSCALL_IMPL
 #undef SYSCALL_ARGS
-- 
2.17.2
