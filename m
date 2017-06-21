Received: from eggs.gnu.org ([2001:4830:134:3::10]:55728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckK-0002Q9-LP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckJ-00052W-Ag
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:6553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckI-0004zB-UY
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:23 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:19:49 +0800
Message-Id: <1498040401-16361-4-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 03/15] tcg: tcg_handle_interrupt() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

Move tcg_handle_interrupt() from translate-common.c to
translate-all.c.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 accel/tcg/Makefile.objs      |  2 +-
 accel/tcg/translate-all.c    | 30 ++++++++++++++++++++++++
 accel/tcg/translate-common.c | 56 --------------------------------------------
 cpus.c                       |  1 +
 4 files changed, 32 insertions(+), 57 deletions(-)
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
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7b25a16..bb303e0 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -798,6 +798,33 @@ static void tb_htable_init(void)
     qht_init(&tcg_ctx.tb_ctx.htable, CODE_GEN_HTABLE_SIZE, mode);
 }
 
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
 /* Must be called before using the QEMU cpus. 'tb_size' is the size
    (in bytes) allocated to the translation buffer. Zero means default
    size. */
@@ -807,6 +834,9 @@ void tcg_exec_init(unsigned long tb_size)
     page_init();
     tb_htable_init();
     code_gen_alloc(tb_size);
+#ifndef CONFIG_USER_ONLY
+    cpu_interrupt_handler = tcg_handle_interrupt;
+#endif
 #if defined(CONFIG_SOFTMMU)
     /* There's no guest base to take into account, so go ahead and
        initialize the prologue now.  */
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
diff --git a/cpus.c b/cpus.c
index a86ea10..6ff3e37 100644
--- a/cpus.c
+++ b/cpus.c
@@ -76,6 +76,7 @@ int64_t max_advance;
 /* vcpu throttling controls */
 static QEMUTimer *throttle_timer;
 static unsigned int throttle_percentage;
+CPUInterruptHandler cpu_interrupt_handler;
 
 #define CPU_THROTTLE_PCT_MIN 1
 #define CPU_THROTTLE_PCT_MAX 99
-- 
1.9.1
