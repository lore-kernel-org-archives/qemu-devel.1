Received: from eggs.gnu.org ([2001:4830:134:3::10]:58523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbq-0003M5-Gj
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbm-0001aB-8y
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:46 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 26 Mar 2018 21:15:45 +0200
Message-Id: <20180326191603.10217-2-laurent@vivier.eu>
In-Reply-To: <20180326191603.10217-1-laurent@vivier.eu>
References: <20180326191603.10217-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 01/19] linux-user: create a dummy per
 arch cpu_loop.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

Create a cpu_loop-common.h for future use by
these new files and use it in the existing
main.c

Introduce target_cpu_copy_regs():
declare the function in cpu_loop-common.h
and an empty function for each target,
to move all the cpu_loop prologues to this function.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/Makefile.objs         |  3 ++-
 linux-user/aarch64/cpu_loop.c    | 26 ++++++++++++++++++++++++++
 linux-user/alpha/cpu_loop.c      | 26 ++++++++++++++++++++++++++
 linux-user/arm/cpu_loop.c        | 26 ++++++++++++++++++++++++++
 linux-user/cpu_loop-common.h     | 37 +++++++++++++++++++++++++++++++++++++
 linux-user/cris/cpu_loop.c       | 26 ++++++++++++++++++++++++++
 linux-user/hppa/cpu_loop.c       | 26 ++++++++++++++++++++++++++
 linux-user/i386/cpu_loop.c       | 26 ++++++++++++++++++++++++++
 linux-user/m68k/cpu_loop.c       | 26 ++++++++++++++++++++++++++
 linux-user/main.c                | 17 +++--------------
 linux-user/microblaze/cpu_loop.c | 26 ++++++++++++++++++++++++++
 linux-user/mips/cpu_loop.c       | 26 ++++++++++++++++++++++++++
 linux-user/mips64/cpu_loop.c     | 26 ++++++++++++++++++++++++++
 linux-user/nios2/cpu_loop.c      | 26 ++++++++++++++++++++++++++
 linux-user/openrisc/cpu_loop.c   | 26 ++++++++++++++++++++++++++
 linux-user/ppc/cpu_loop.c        | 26 ++++++++++++++++++++++++++
 linux-user/riscv/cpu_loop.c      | 26 ++++++++++++++++++++++++++
 linux-user/s390x/cpu_loop.c      | 26 ++++++++++++++++++++++++++
 linux-user/sh4/cpu_loop.c        | 26 ++++++++++++++++++++++++++
 linux-user/sparc/cpu_loop.c      | 26 ++++++++++++++++++++++++++
 linux-user/sparc64/cpu_loop.c    | 26 ++++++++++++++++++++++++++
 linux-user/tilegx/cpu_loop.c     | 26 ++++++++++++++++++++++++++
 linux-user/x86_64/cpu_loop.c     | 26 ++++++++++++++++++++++++++
 linux-user/xtensa/cpu_loop.c     | 26 ++++++++++++++++++++++++++
 24 files changed, 588 insertions(+), 15 deletions(-)
 create mode 100644 linux-user/aarch64/cpu_loop.c
 create mode 100644 linux-user/alpha/cpu_loop.c
 create mode 100644 linux-user/arm/cpu_loop.c
 create mode 100644 linux-user/cpu_loop-common.h
 create mode 100644 linux-user/cris/cpu_loop.c
 create mode 100644 linux-user/hppa/cpu_loop.c
 create mode 100644 linux-user/i386/cpu_loop.c
 create mode 100644 linux-user/m68k/cpu_loop.c
 create mode 100644 linux-user/microblaze/cpu_loop.c
 create mode 100644 linux-user/mips/cpu_loop.c
 create mode 100644 linux-user/mips64/cpu_loop.c
 create mode 100644 linux-user/nios2/cpu_loop.c
 create mode 100644 linux-user/openrisc/cpu_loop.c
 create mode 100644 linux-user/ppc/cpu_loop.c
 create mode 100644 linux-user/riscv/cpu_loop.c
 create mode 100644 linux-user/s390x/cpu_loop.c
 create mode 100644 linux-user/sh4/cpu_loop.c
 create mode 100644 linux-user/sparc/cpu_loop.c
 create mode 100644 linux-user/sparc64/cpu_loop.c
 create mode 100644 linux-user/tilegx/cpu_loop.c
 create mode 100644 linux-user/x86_64/cpu_loop.c
 create mode 100644 linux-user/xtensa/cpu_loop.c

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 811a7f5ce5..59a5c17354 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,6 +1,7 @@
 obj-y = main.o syscall.o strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
-	safe-syscall.o $(TARGET_ABI_DIR)/signal.o
+	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
+        $(TARGET_ABI_DIR)/cpu_loop.o
 
 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/aarch64/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/alpha/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/arm/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/cpu_loop-common.h b/linux-user/cpu_loop-common.h
new file mode 100644
index 0000000000..ffe3fe9ad5
--- /dev/null
+++ b/linux-user/cpu_loop-common.h
@@ -0,0 +1,37 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#ifndef CPU_LOOP_COMMON_H
+#define CPU_LOOP_COMMON_H
+
+#include "exec/log.h"
+
+#define EXCP_DUMP(env, fmt, ...)                                        \
+do {                                                                    \
+    CPUState *cs = ENV_GET_CPU(env);                                    \
+    fprintf(stderr, fmt , ## __VA_ARGS__);                              \
+    cpu_dump_state(cs, stderr, fprintf, 0);                             \
+    if (qemu_log_separate()) {                                          \
+        qemu_log(fmt, ## __VA_ARGS__);                                  \
+        log_cpu_state(cs, 0);                                           \
+    }                                                                   \
+} while (0)
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs);
+#endif
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/cris/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/hppa/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/i386/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/m68k/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/main.c b/linux-user/main.c
index ba09b7d0c8..a2ce9df46f 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -33,9 +33,9 @@
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
 #include "elf.h"
-#include "exec/log.h"
 #include "trace/control.h"
 #include "target_elf.h"
+#include "cpu_loop-common.h"
 
 char *exec_path;
 
@@ -50,17 +50,6 @@ unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
 
-#define EXCP_DUMP(env, fmt, ...)                                        \
-do {                                                                    \
-    CPUState *cs = ENV_GET_CPU(env);                                    \
-    fprintf(stderr, fmt , ## __VA_ARGS__);                              \
-    cpu_dump_state(cs, stderr, fprintf, 0);                             \
-    if (qemu_log_separate()) {                                          \
-        qemu_log(fmt, ## __VA_ARGS__);                                  \
-        log_cpu_state(cs, 0);                                           \
-    }                                                                   \
-} while (0)
-
 /*
  * When running 32-on-64 we should make sure we can fit all of the possible
  * guest address space into a contiguous chunk of virtual host memory.
@@ -4733,6 +4722,8 @@ int main(int argc, char **argv, char **envp)
     tcg_prologue_init(tcg_ctx);
     tcg_region_init();
 
+    target_cpu_copy_regs(env, regs);
+
 #if defined(TARGET_I386)
     env->cr[0] = CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK;
     env->hflags |= HF_PE_MASK | HF_CPL_MASK;
@@ -5122,8 +5113,6 @@ int main(int argc, char **argv, char **envp)
         env->sregs[WINDOW_START] = regs->windowstart;
         env->pc = regs->pc;
     }
-#else
-#error unsupported target CPU
 #endif
 
 #if defined(TARGET_ARM) || defined(TARGET_M68K)
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/microblaze/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/mips/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/mips64/cpu_loop.c b/linux-user/mips64/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/mips64/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/nios2/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/openrisc/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/ppc/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/riscv/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/s390x/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/sh4/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/sparc/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/sparc64/cpu_loop.c b/linux-user/sparc64/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/sparc64/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/tilegx/cpu_loop.c b/linux-user/tilegx/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/tilegx/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/x86_64/cpu_loop.c b/linux-user/x86_64/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/x86_64/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
new file mode 100644
index 0000000000..b7700a5561
--- /dev/null
+++ b/linux-user/xtensa/cpu_loop.c
@@ -0,0 +1,26 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+}
-- 
2.14.3
