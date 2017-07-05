Received: from eggs.gnu.org ([2001:4830:134:3::10]:46763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeX0-0004tn-5l
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWy-0007nl-R2
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:26 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWy-0007nM-HR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:24 -0400
Received: by mail-wm0-x243.google.com with SMTP id y5so30408955wmh.3
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:24 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	y35sm22202793wrc.51.2017.07.05.00.15.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jul 2017 00:15:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:31 +0200
Message-Id: <1499238885-26161-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/42] cpu: move interrupt handling out of
 translate-common.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

translate-common.c will not be available anymore with --disable-tcg,
so we cannot leave cpu_interrupt_handler there.

Move the TCG-specific handler to accel/tcg/tcg-all.c, and adopt
KVM's handler as the default one, since it works just as well for
Xen and qtest.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c          | 11 ---------
 accel/tcg/Makefile.objs      |  2 +-
 accel/tcg/tcg-all.c          | 32 ++++++++++++++++++++++++++
 accel/tcg/translate-common.c | 53 --------------------------------------------
 qom/cpu.c                    | 13 +++++++++++
 5 files changed, 46 insertions(+), 65 deletions(-)
 delete mode 100644 accel/tcg/translate-common.c

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cd71e28..2eef7da 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -981,15 +981,6 @@ static MemoryListener kvm_io_listener = {
     .priority = 10,
 };
 
-static void kvm_handle_interrupt(CPUState *cpu, int mask)
-{
-    cpu->interrupt_request |= mask;
-
-    if (!qemu_cpu_is_self(cpu)) {
-        qemu_cpu_kick(cpu);
-    }
-}
-
 int kvm_set_irq(KVMState *s, int irq, int level)
 {
     struct kvm_irq_level event;
@@ -1774,8 +1765,6 @@ static int kvm_init(MachineState *ms)
 
     s->many_ioeventfds = kvm_check_many_ioeventfds();
 
-    cpu_interrupt_handler = kvm_handle_interrupt;
-
     return 0;
 
 err:
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
index e6b8c4c..0000000
--- a/accel/tcg/translate-common.c
+++ /dev/null
@@ -1,53 +0,0 @@
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
index 7b20f84..8757f03 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -32,6 +32,8 @@
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
 
+CPUInterruptHandler cpu_interrupt_handler;
+
 bool cpu_exists(int64_t id)
 {
     CPUState *cpu;
@@ -417,6 +419,17 @@ static vaddr cpu_adjust_watchpoint_address(CPUState *cpu, vaddr addr, int len)
     return addr;
 }
 
+static void generic_handle_interrupt(CPUState *cpu, int mask)
+{
+    cpu->interrupt_request |= mask;
+
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    }
+}
+
+CPUInterruptHandler cpu_interrupt_handler = generic_handle_interrupt;
+
 static void cpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-- 
1.8.3.1
