Received: from eggs.gnu.org ([209.51.188.92]:49744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnZfs-0003W1-FB
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnZVc-0008Gi-0N
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:45:16 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gnZVb-0008GY-Py
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:45:15 -0500
Received: by mail-lj1-x243.google.com with SMTP id k19-v6so11339241lji.11
	for <qemu-devel@nongnu.org>; Sat, 26 Jan 2019 17:45:15 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 26 Jan 2019 17:45:01 -0800
Message-Id: <20190127014501.21840-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: rearrange access to external
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Replace xtensa_get_extint that returns single external IRQ descriptor
with xtensa_get_extints that returns a vector of all external IRQs.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/pic_cpu.c | 24 +++++++++++-------------
 hw/xtensa/xtfpga.c  |  8 +++++---
 target/xtensa/cpu.h |  5 +++--
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index f70684902628..077f4ad53d6d 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -88,11 +88,11 @@ static void xtensa_ccompare_cb(void *opaque)
 
 void xtensa_irq_init(CPUXtensaState *env)
 {
-    env->irq_inputs = (void **)qemu_allocate_irqs(
-            xtensa_set_irq, env, env->config->ninterrupt);
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_TIMER_INTERRUPT)) {
-        unsigned i;
+    unsigned i;
 
+    env->irq_inputs = qemu_allocate_irqs(xtensa_set_irq, env,
+                                         env->config->ninterrupt);
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_TIMER_INTERRUPT)) {
         env->time_base = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         env->ccount_base = env->sregs[CCOUNT];
         for (i = 0; i < env->config->nccompare; ++i) {
@@ -101,16 +101,14 @@ void xtensa_irq_init(CPUXtensaState *env)
                     xtensa_ccompare_cb, env->ccompare + i);
         }
     }
+    for (i = 0; i < env->config->nextint; ++i) {
+        unsigned irq = env->config->extint[i];
+
+        env->ext_irq_inputs[i] = env->irq_inputs[irq];
+    }
 }
 
-void *xtensa_get_extint(CPUXtensaState *env, unsigned extint)
+qemu_irq *xtensa_get_extints(CPUXtensaState *env)
 {
-    if (extint < env->config->nextint) {
-        unsigned irq = env->config->extint[extint];
-        return env->irq_inputs[irq];
-    } else {
-        qemu_log("%s: trying to acquire invalid external interrupt %d\n",
-                __func__, extint);
-        return NULL;
-    }
+    return env->ext_irq_inputs;
 }
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 7379b3fff427..3102f8c04709 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -225,6 +225,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     XtensaCPU *cpu = NULL;
     CPUXtensaState *env = NULL;
     MemoryRegion *system_io;
+    qemu_irq *extints;
     DriveInfo *dinfo;
     pflash_t *flash = NULL;
     QemuOpts *machine_opts = qemu_get_machine_opts();
@@ -253,6 +254,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
          */
         cpu_reset(CPU(cpu));
     }
+    extints = xtensa_get_extints(env);
 
     if (env) {
         XtensaMemory sysram = env->config->sysram;
@@ -284,11 +286,11 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     xtfpga_fpga_init(system_io, 0x0d020000, freq);
     if (nd_table[0].used) {
         xtfpga_net_init(system_io, 0x0d030000, 0x0d030400, 0x0d800000,
-                xtensa_get_extint(env, 1), nd_table);
+                        extints[1], nd_table);
     }
 
-    serial_mm_init(system_io, 0x0d050020, 2, xtensa_get_extint(env, 0),
-            115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+    serial_mm_init(system_io, 0x0d050020, 2, extints[0],
+                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (dinfo) {
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index f579294822c3..176af8a53cf0 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -483,7 +483,8 @@ typedef struct CPUXtensaState {
     AddressSpace *address_space_er;
     MemoryRegion *system_er;
     int pending_irq_level; /* level of last raised IRQ */
-    void **irq_inputs;
+    qemu_irq *irq_inputs;
+    qemu_irq ext_irq_inputs[MAX_NINTERRUPT];
     XtensaCcompareTimer ccompare[MAX_NCCOMPARE];
     uint64_t time_base;
     uint64_t ccount_time;
@@ -569,7 +570,7 @@ void xtensa_register_core(XtensaConfigList *node);
 void xtensa_sim_open_console(Chardev *chr);
 void check_interrupts(CPUXtensaState *s);
 void xtensa_irq_init(CPUXtensaState *env);
-void *xtensa_get_extint(CPUXtensaState *env, unsigned extint);
+qemu_irq *xtensa_get_extints(CPUXtensaState *env);
 int cpu_xtensa_signal_handler(int host_signum, void *pinfo, void *puc);
 void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 void xtensa_sync_window_from_phys(CPUXtensaState *env);
-- 
2.11.0
