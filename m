Received: from eggs.gnu.org ([2001:4830:134:3::10]:45318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdY-0004jF-2P
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ezVdU-0000Xp-Ig
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:58:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Mar 2018 23:57:20 +0100
Message-Id: <20180323225739.17329-2-laurent@vivier.eu>
In-Reply-To: <20180323225739.17329-1-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 v2 01/20] linux-user: create a dummy
 per arch signal.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org

Create a signal-common.h for future use by
these new files and use it in the existing
signal.c

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/Makefile.objs       |  2 +-
 linux-user/aarch64/signal.c    | 18 +++++++++++++++
 linux-user/alpha/signal.c      | 18 +++++++++++++++
 linux-user/arm/signal.c        | 18 +++++++++++++++
 linux-user/cris/signal.c       | 18 +++++++++++++++
 linux-user/hppa/signal.c       | 18 +++++++++++++++
 linux-user/i386/signal.c       | 18 +++++++++++++++
 linux-user/m68k/signal.c       | 18 +++++++++++++++
 linux-user/microblaze/signal.c | 18 +++++++++++++++
 linux-user/mips/signal.c       | 18 +++++++++++++++
 linux-user/mips64/signal.c     | 18 +++++++++++++++
 linux-user/nios2/signal.c      | 18 +++++++++++++++
 linux-user/openrisc/signal.c   | 18 +++++++++++++++
 linux-user/ppc/signal.c        | 18 +++++++++++++++
 linux-user/riscv/signal.c      | 18 +++++++++++++++
 linux-user/s390x/signal.c      | 18 +++++++++++++++
 linux-user/sh4/signal.c        | 18 +++++++++++++++
 linux-user/signal-common.h     | 50 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/signal.c            | 41 ++++++++++------------------------
 linux-user/sparc/signal.c      | 18 +++++++++++++++
 linux-user/sparc64/signal.c    | 18 +++++++++++++++
 linux-user/tilegx/signal.c     | 18 +++++++++++++++
 linux-user/x86_64/signal.c     | 18 +++++++++++++++
 linux-user/xtensa/signal.c     | 18 +++++++++++++++
 24 files changed, 440 insertions(+), 31 deletions(-)
 create mode 100644 linux-user/aarch64/signal.c
 create mode 100644 linux-user/alpha/signal.c
 create mode 100644 linux-user/arm/signal.c
 create mode 100644 linux-user/cris/signal.c
 create mode 100644 linux-user/hppa/signal.c
 create mode 100644 linux-user/i386/signal.c
 create mode 100644 linux-user/m68k/signal.c
 create mode 100644 linux-user/microblaze/signal.c
 create mode 100644 linux-user/mips/signal.c
 create mode 100644 linux-user/mips64/signal.c
 create mode 100644 linux-user/nios2/signal.c
 create mode 100644 linux-user/openrisc/signal.c
 create mode 100644 linux-user/ppc/signal.c
 create mode 100644 linux-user/riscv/signal.c
 create mode 100644 linux-user/s390x/signal.c
 create mode 100644 linux-user/sh4/signal.c
 create mode 100644 linux-user/signal-common.h
 create mode 100644 linux-user/sparc/signal.c
 create mode 100644 linux-user/sparc64/signal.c
 create mode 100644 linux-user/tilegx/signal.c
 create mode 100644 linux-user/x86_64/signal.c
 create mode 100644 linux-user/xtensa/signal.c

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 8c93058100..811a7f5ce5 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,6 +1,6 @@
 obj-y = main.o syscall.o strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
-	safe-syscall.o
+	safe-syscall.o $(TARGET_ABI_DIR)/signal.o
 
 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/aarch64/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/alpha/signal.c b/linux-user/alpha/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/alpha/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/arm/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/cris/signal.c b/linux-user/cris/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/cris/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/hppa/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/i386/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/m68k/signal.c b/linux-user/m68k/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/m68k/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/microblaze/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/mips/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/mips64/signal.c b/linux-user/mips64/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/mips64/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/nios2/signal.c b/linux-user/nios2/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/nios2/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/openrisc/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/ppc/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/riscv/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/s390x/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/sh4/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
new file mode 100644
index 0000000000..838b6e9198
--- /dev/null
+++ b/linux-user/signal-common.h
@@ -0,0 +1,50 @@
+/*
+ *  Emulation of Linux signals
+ *
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
+#ifndef SIGNAL_COMMON_H
+#define SIGNAL_COMMON_H
+extern struct target_sigaltstack target_sigaltstack_used;
+
+static inline int on_sig_stack(unsigned long sp)
+{
+    return (sp - target_sigaltstack_used.ss_sp
+            < target_sigaltstack_used.ss_size);
+}
+
+static inline int sas_ss_flags(unsigned long sp)
+{
+    return (target_sigaltstack_used.ss_size == 0 ? SS_DISABLE
+            : on_sig_stack(sp) ? SS_ONSTACK : 0);
+}
+
+static inline void target_sigemptyset(target_sigset_t *set)
+{
+    memset(set, 0, sizeof(*set));
+}
+
+void host_to_target_sigset_internal(target_sigset_t *d,
+                                    const sigset_t *s);
+void target_to_host_sigset_internal(sigset_t *d,
+                                    const target_sigset_t *s);
+void tswap_siginfo(target_siginfo_t *tinfo,
+                   const target_siginfo_t *info);
+void set_sigmask(const sigset_t *set);
+void force_sig(int sig);
+void force_sigsegv(int oldsig);
+#endif
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2ea3e0321f..435cadbe96 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -25,8 +25,9 @@
 #include "qemu-common.h"
 #include "target_signal.h"
 #include "trace.h"
+#include "signal-common.h"
 
-static struct target_sigaltstack target_sigaltstack_used = {
+struct target_sigaltstack target_sigaltstack_used = {
     .ss_sp = 0,
     .ss_size = 0,
     .ss_flags = TARGET_SS_DISABLE,
@@ -82,18 +83,6 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
 };
 static uint8_t target_to_host_signal_table[_NSIG];
 
-static inline int on_sig_stack(unsigned long sp)
-{
-    return (sp - target_sigaltstack_used.ss_sp
-            < target_sigaltstack_used.ss_size);
-}
-
-static inline int sas_ss_flags(unsigned long sp)
-{
-    return (target_sigaltstack_used.ss_size == 0 ? SS_DISABLE
-            : on_sig_stack(sp) ? SS_ONSTACK : 0);
-}
-
 int host_to_target_signal(int sig)
 {
     if (sig < 0 || sig >= _NSIG)
@@ -108,11 +97,6 @@ int target_to_host_signal(int sig)
     return target_to_host_signal_table[sig];
 }
 
-static inline void target_sigemptyset(target_sigset_t *set)
-{
-    memset(set, 0, sizeof(*set));
-}
-
 static inline void target_sigaddset(target_sigset_t *set, int signum)
 {
     signum--;
@@ -127,8 +111,8 @@ static inline int target_sigismember(const target_sigset_t *set, int signum)
     return ((set->sig[signum / TARGET_NSIG_BPW] & mask) != 0);
 }
 
-static void host_to_target_sigset_internal(target_sigset_t *d,
-                                           const sigset_t *s)
+void host_to_target_sigset_internal(target_sigset_t *d,
+                                    const sigset_t *s)
 {
     int i;
     target_sigemptyset(d);
@@ -149,8 +133,8 @@ void host_to_target_sigset(target_sigset_t *d, const sigset_t *s)
         d->sig[i] = tswapal(d1.sig[i]);
 }
 
-static void target_to_host_sigset_internal(sigset_t *d,
-                                           const target_sigset_t *s)
+void target_to_host_sigset_internal(sigset_t *d,
+                                    const target_sigset_t *s)
 {
     int i;
     sigemptyset(d);
@@ -257,7 +241,7 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
 /* Just set the guest's signal mask to the specified value; the
  * caller is assumed to have called block_signals() already.
  */
-static void set_sigmask(const sigset_t *set)
+void set_sigmask(const sigset_t *set)
 {
     TaskState *ts = (TaskState *)thread_cpu->opaque;
 
@@ -344,8 +328,8 @@ static inline void host_to_target_siginfo_noswap(target_siginfo_t *tinfo,
     tinfo->si_code = deposit32(si_code, 16, 16, si_type);
 }
 
-static void tswap_siginfo(target_siginfo_t *tinfo,
-                          const target_siginfo_t *info)
+void tswap_siginfo(target_siginfo_t *tinfo,
+                   const target_siginfo_t *info)
 {
     int si_type = extract32(info->si_code, 16, 16);
     int si_code = sextract32(info->si_code, 0, 16);
@@ -515,7 +499,7 @@ void signal_init(void)
  * also forces the signal to "not blocked, not ignored", but for QEMU
  * that work is done in process_pending_signals().
  */
-static void force_sig(int sig)
+void force_sig(int sig)
 {
     CPUState *cpu = thread_cpu;
     CPUArchState *env = cpu->env_ptr;
@@ -534,7 +518,7 @@ static void force_sig(int sig)
  * at the point of failure.
  */
 #if !defined(TARGET_RISCV)
-static void force_sigsegv(int oldsig)
+void force_sigsegv(int oldsig)
 {
     if (oldsig == SIGSEGV) {
         /* Make sure we don't try to deliver the signal again; this will
@@ -7301,9 +7285,6 @@ badframe:
     force_sig(TARGET_SIGSEGV);
     return -TARGET_QEMU_ESIGRETURN;
 }
-
-#else
-#error Target needs to add support for signal handling
 #endif
 
 static void handle_pending_signal(CPUArchState *cpu_env, int sig,
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/sparc/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/sparc64/signal.c b/linux-user/sparc64/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/sparc64/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/tilegx/signal.c b/linux-user/tilegx/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/tilegx/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/x86_64/signal.c b/linux-user/x86_64/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/x86_64/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
new file mode 100644
index 0000000000..02ca338b6c
--- /dev/null
+++ b/linux-user/xtensa/signal.c
@@ -0,0 +1,18 @@
+/*
+ *  Emulation of Linux signals
+ *
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
-- 
2.14.3
