Received: from eggs.gnu.org ([2001:4830:134:3::10]:43524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKp-0006r7-7N
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKn-0008TX-4M
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:59 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faIKm-0008T4-Tw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:57 -0400
Received: by mail-wr0-x244.google.com with SMTP id h10-v6so1357047wrq.8
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:14:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:33 +0100
Message-Id: <20180703101444.23778-10-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/20] linux-user: introduce preexit_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

To avoid repeating ourselves move our preexit clean-up code into a
helper function. I figured the continuing effort to split of the
syscalls made it worthwhile creating a new file for it now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 59a5c17354..b5dfb71f25 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,7 +1,7 @@
 obj-y = main.o syscall.o strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
 	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o
+        $(TARGET_ABI_DIR)/cpu_loop.o exit.o
 
 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
diff --git a/linux-user/exit.c b/linux-user/exit.c
new file mode 100644
index 0000000000..aed8713fae
--- /dev/null
+++ b/linux-user/exit.c
@@ -0,0 +1,28 @@
+/*
+ *  exit support for qemu
+ *
+ *  Copyright (c) 2018 Alex Bennée <alex.bennee@linaro.org>
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+
+void preexit_cleanup(CPUArchState *env, int code)
+{
+#ifdef TARGET_GPROF
+        _mcleanup();
+#endif
+        gdb_exit(env, code);
+}
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 793cd4df04..bb85c81aa4 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -623,6 +623,14 @@ static inline int is_error(abi_long ret)
     return (abi_ulong)ret >= (abi_ulong)(-4096);
 }
 
+/**
+ * preexit_cleanup: housekeeping before the guest exits
+ *
+ * env: the CPU state
+ * code: the exit code
+ */
+void preexit_cleanup(CPUArchState *env, int code);
+
 /* Include target-specific struct and function definitions;
  * they may need access to the target-independent structures
  * above, so include them last.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2117fb13b4..7c66442357 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8018,10 +8018,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
 
         cpu_list_unlock();
-#ifdef TARGET_GPROF
-        _mcleanup();
-#endif
-        gdb_exit(cpu_env, arg1);
+        preexit_cleanup(cpu_env, arg1);
         _exit(arg1);
         ret = 0; /* avoid warning */
         break;
@@ -10127,10 +10124,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef __NR_exit_group
         /* new thread calls */
     case TARGET_NR_exit_group:
-#ifdef TARGET_GPROF
-        _mcleanup();
-#endif
-        gdb_exit(cpu_env, arg1);
+        preexit_cleanup(cpu_env, arg1);
         ret = get_errno(exit_group(arg1));
         break;
 #endif
-- 
2.17.1
