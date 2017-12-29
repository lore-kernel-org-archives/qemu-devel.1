Received: from eggs.gnu.org ([2001:4830:134:3::10]:50496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoCu-0002jY-Tm
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoCs-0004Tn-Qx
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:52 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:40861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoCs-0004TU-J2
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:50 -0500
Received: by mail-pf0-x243.google.com with SMTP id v26so21821939pfl.7
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:31:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:08 -0800
Message-Id: <20171229063145.29167-2-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/38] target/hppa: Skeleton support for
 hppa-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

From: Helge Deller <deller@gmx.de>

With the addition of default-configs/hppa-softmmu.mak, this
will compile.  It is not enabled with this patch, however.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/sysemu/arch_init.h |  1 +
 target/hppa/cpu.h          |  1 +
 arch_init.c                |  2 ++
 hw/hppa/machine.c          | 39 +++++++++++++++++++++++++++++++++
 target/hppa/cpu.c          |  5 +++++
 target/hppa/helper.c       | 10 ---------
 target/hppa/mem_helper.c   | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 target/hppa/op_helper.c    | 13 +++++++++--
 hw/hppa/Makefile.objs      |  1 +
 target/hppa/Makefile.objs  |  2 +-
 10 files changed, 115 insertions(+), 13 deletions(-)
 create mode 100644 hw/hppa/machine.c
 create mode 100644 target/hppa/mem_helper.c
 create mode 100644 hw/hppa/Makefile.objs

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 8751c468ed..f999bfd3be 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,7 @@ enum {
     QEMU_ARCH_MOXIE = (1 << 15),
     QEMU_ARCH_TRICORE = (1 << 16),
     QEMU_ARCH_NIOS2 = (1 << 17),
+    QEMU_ARCH_HPPA = (1 << 18),
 };
 
 extern const uint32_t arch_type;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8d14077763..7fad92144c 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -133,6 +133,7 @@ void cpu_hppa_loaded_fr0(CPUHPPAState *env);
 
 int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *puc);
 int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw, int midx);
+hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
 int hppa_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
diff --git a/arch_init.c b/arch_init.c
index a0b8ed6167..4c36f2b076 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -53,6 +53,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_CRIS
 #elif defined(TARGET_I386)
 #define QEMU_ARCH QEMU_ARCH_I386
+#elif defined(TARGET_HPPA)
+#define QEMU_ARCH QEMU_ARCH_HPPA
 #elif defined(TARGET_M68K)
 #define QEMU_ARCH QEMU_ARCH_M68K
 #elif defined(TARGET_LM32)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
new file mode 100644
index 0000000000..4625e591ea
--- /dev/null
+++ b/hw/hppa/machine.c
@@ -0,0 +1,39 @@
+/*
+ * QEMU HPPA hardware system emulator.
+ * Copyright 2017 Helge Deller <deller@gmx.de>
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "elf.h"
+#include "hw/loader.h"
+#include "hw/boards.h"
+#include "qemu/error-report.h"
+#include "sysemu/sysemu.h"
+#include "hw/timer/mc146818rtc.h"
+#include "hw/ide.h"
+#include "hw/timer/i8254.h"
+#include "hw/char/serial.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+
+
+static void machine_hppa_init(MachineState *machine)
+{
+}
+
+static void machine_hppa_machine_init(MachineClass *mc)
+{
+    mc->desc = "HPPA generic machine";
+    mc->init = machine_hppa_init;
+    mc->block_default_type = IF_SCSI;
+    mc->max_cpus = 1;
+    mc->is_default = 1;
+    mc->default_ram_size = 2048UL*1024*1024; // 2GB
+    mc->default_boot_order = "cd";
+}
+
+DEFINE_MACHINE("hppa", machine_hppa_machine_init)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 9e7b0d4ccb..f6d92de972 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -132,7 +132,12 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
     cc->gdb_read_register = hppa_cpu_gdb_read_register;
     cc->gdb_write_register = hppa_cpu_gdb_write_register;
+#ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
+#else
+    cc->get_phys_page_debug = hppa_cpu_get_phys_page_debug;
+#endif
+
     cc->disas_set_info = hppa_cpu_disas_set_info;
     cc->tcg_initialize = hppa_translate_init;
 
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index ba04a9a52b..d6d6f06cb0 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -65,16 +65,6 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     env->psw_cb = cb;
 }
 
-int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
-                              int rw, int mmu_idx)
-{
-    HPPACPU *cpu = HPPA_CPU(cs);
-
-    cs->exception_index = EXCP_SIGSEGV;
-    cpu->env.ior = address;
-    return 1;
-}
-
 void hppa_cpu_do_interrupt(CPUState *cs)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
new file mode 100644
index 0000000000..e0802bc935
--- /dev/null
+++ b/target/hppa/mem_helper.c
@@ -0,0 +1,54 @@
+/*
+ *  HPPA memory access helper routines
+ *
+ *  Copyright (c) 2017 Helge Deller
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "qom/cpu.h"
+
+#ifdef CONFIG_USER_ONLY
+int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
+                              int rw, int mmu_idx)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+
+    cs->exception_index = EXCP_SIGSEGV;
+    cpu->env.ior = address;
+    return 1;
+}
+#else
+hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    /* Stub */
+    return addr;
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType type,
+              int mmu_idx, uintptr_t retaddr)
+{
+    /* Stub */
+    int prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    hwaddr phys = addr;
+
+    /* Success!  Store the translation into the QEMU TLB.  */
+    tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
+                 prot, mmu_idx, TARGET_PAGE_SIZE);
+}
+#endif /* CONFIG_USER_ONLY */
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 3104404e8d..9c7603588f 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -58,9 +58,9 @@ void HELPER(tcond)(CPUHPPAState *env, target_ulong cond)
 static void atomic_store_3(CPUHPPAState *env, target_ulong addr, uint32_t val,
                            uint32_t mask, uintptr_t ra)
 {
+#ifdef CONFIG_USER_ONLY
     uint32_t old, new, cmp;
 
-#ifdef CONFIG_USER_ONLY
     uint32_t *haddr = g2h(addr - 1);
     old = *haddr;
     while (1) {
@@ -72,7 +72,8 @@ static void atomic_store_3(CPUHPPAState *env, target_ulong addr, uint32_t val,
         old = cmp;
     }
 #else
-#error "Not implemented."
+    /* FIXME -- we can do better.  */
+    cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
 #endif
 }
 
@@ -158,12 +159,20 @@ void HELPER(stby_e_parallel)(CPUHPPAState *env, target_ulong addr,
 
 target_ulong HELPER(probe_r)(target_ulong addr)
 {
+#ifdef CONFIG_USER_ONLY
     return page_check_range(addr, 1, PAGE_READ);
+#else
+    return 1; /* FIXME */
+#endif
 }
 
 target_ulong HELPER(probe_w)(target_ulong addr)
 {
+#ifdef CONFIG_USER_ONLY
     return page_check_range(addr, 1, PAGE_WRITE);
+#else
+    return 1; /* FIXME */
+#endif
 }
 
 void HELPER(loaded_fr0)(CPUHPPAState *env)
diff --git a/hw/hppa/Makefile.objs b/hw/hppa/Makefile.objs
new file mode 100644
index 0000000000..46b2ae18de
--- /dev/null
+++ b/hw/hppa/Makefile.objs
@@ -0,0 +1 @@
+obj-y += machine.o
diff --git a/target/hppa/Makefile.objs b/target/hppa/Makefile.objs
index 263446fa0b..d89285307b 100644
--- a/target/hppa/Makefile.objs
+++ b/target/hppa/Makefile.objs
@@ -1 +1 @@
-obj-y += translate.o helper.o cpu.o op_helper.o gdbstub.o
+obj-y += translate.o helper.o cpu.o op_helper.o gdbstub.o mem_helper.o
-- 
2.14.3
