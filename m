Received: from eggs.gnu.org ([2001:4830:134:3::10]:35580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLkv-0006YV-VC
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLku-0001pw-Je
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:33 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLku-0001pT-A2
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:32 -0400
Received: by mail-wm0-x244.google.com with SMTP id p204so25630268wmg.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:12:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:12:00 +0200
Message-Id: <1499166735-39360-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/22] tcg: tcg_handle_interrupt() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

From: Yang Zhong <yang.zhong@intel.com>

Move tcg_handle_interrupt() from translate-common.c to
accel/tcg/tcg-all.c.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/Makefile.objs      |  2 +-
 accel/tcg/tcg-all.c          | 32 +++++++++++++++++++++++++
 accel/tcg/translate-common.c | 56 --------------------------------------------
 qom/cpu.c                    |  2 ++
 4 files changed, 35 insertions(+), 57 deletions(-)
 delete mode 100644 accel/tcg/translate-common.c

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index f173cd5..70cd474 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,3 +1,3 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
-obj-y += cpu-exec.o cpu-exec-common.o translate-all.o translate-common.o
+obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index e327d90..c1ccad3 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -27,13 +27,45 @@
 #include "sysemu/accel.h"
 #include "sysemu/sysemu.h"
 #include "qom/object.h"
+#include "qemu-common.h"
+#include "qom/cpu.h"
+#include "sysemu/cpus.h"
+#include "qemu/main-loop.h"
 
 unsigned long tcg_tb_size;
 static bool tcg_allowed = true;
 
+#ifndef CONFIG_USER_ONLY
+/* mask must never be zero, except for A20 change call */
+static void tcg_handle_interrupt(CPUState *cpu, int mask)
+{
+    int old_mask;
+    g_assert(qemu_mutex_iothread_locked());
+
+    old_mask = cpu->interrupt_request;
+    cpu->interrupt_request |= mask;
+
+    /*
+     * If called from iothread context, wake the target cpu in
+     * case its halted.
+     */
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    } else {
+        cpu->icount_decr.u16.high = -1;
+        if (use_icount &&
+            !cpu->can_do_io
+            && (mask & ~old_mask) != 0) {
+            cpu_abort(cpu, "Raised interrupt while not in I/O function");
+        }
+    }
+}
+#endif
+
 static int tcg_init(MachineState *ms)
 {
     tcg_exec_init(tcg_tb_size * 1024 * 1024);
+    cpu_interrupt_handler = tcg_handle_interrupt;
     return 0;
 }
 
diff --git a/accel/tcg/translate-common.c b/accel/tcg/translate-common.c
deleted file mode 100644
index 40fe5a1..0000000
--- a/accel/tcg/translate-common.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- *  Host code generation common components
- *
- *  Copyright (c) 2015 Peter Crosthwaite <crosthwaite.peter@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "qom/cpu.h"
-#include "sysemu/cpus.h"
-#include "qemu/main-loop.h"
-
-uintptr_t qemu_real_host_page_size;
-intptr_t qemu_real_host_page_mask;
-
-#ifndef CONFIG_USER_ONLY
-/* mask must never be zero, except for A20 change call */
-static void tcg_handle_interrupt(CPUState *cpu, int mask)
-{
-    int old_mask;
-    g_assert(qemu_mutex_iothread_locked());
-
-    old_mask = cpu->interrupt_request;
-    cpu->interrupt_request |= mask;
-
-    /*
-     * If called from iothread context, wake the target cpu in
-     * case its halted.
-     */
-    if (!qemu_cpu_is_self(cpu)) {
-        qemu_cpu_kick(cpu);
-    } else {
-        cpu->icount_decr.u16.high = -1;
-        if (use_icount &&
-            !cpu->can_do_io
-            && (mask & ~old_mask) != 0) {
-            cpu_abort(cpu, "Raised interrupt while not in I/O function");
-        }
-    }
-}
-
-CPUInterruptHandler cpu_interrupt_handler = tcg_handle_interrupt;
-#endif
diff --git a/qom/cpu.c b/qom/cpu.c
index 585419b..1d7aa59 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -31,6 +31,8 @@
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
 
+CPUInterruptHandler cpu_interrupt_handler;
+
 bool cpu_exists(int64_t id)
 {
     CPUState *cpu;
-- 
1.8.3.1
