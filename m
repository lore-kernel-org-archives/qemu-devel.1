Received: from eggs.gnu.org ([2001:4830:134:3::10]:33132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2C3-0001Jo-CY
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2Bz-0002Wr-C3
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:47 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:39372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ey2Bz-0002WO-3Z
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:43 -0400
Received: by mail-pl0-x244.google.com with SMTP id k22-v6so10205825pls.6
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 14:19:43 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Mon, 19 Mar 2018 14:18:25 -0700
Message-Id: <1521494329-19546-3-git-send-email-mjc@sifive.com>
In-Reply-To: <1521494329-19546-1-git-send-email-mjc@sifive.com>
References: <1521494329-19546-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 02/26] RISC-V: Replace hardcoded constants
 with enum values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

The RISC-V device-tree code has a number of hard-coded
constants and this change moves them into header enums.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/riscv/sifive_clint.c         | 9 +++------
 hw/riscv/sifive_u.c             | 6 ++++--
 hw/riscv/spike.c                | 6 ++++--
 hw/riscv/virt.c                 | 6 ++++--
 include/hw/riscv/sifive_clint.h | 4 ++++
 include/hw/riscv/sifive_u.h     | 4 ++++
 include/hw/riscv/spike.h        | 4 ++++
 include/hw/riscv/virt.h         | 4 ++++
 8 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index 4893453..7cc606e 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -26,13 +26,10 @@
 #include "hw/riscv/sifive_clint.h"
 #include "qemu/timer.h"
 
-/* See: riscv-pk/machine/sbi_entry.S and arch/riscv/kernel/time.c */
-#define TIMER_FREQ (10 * 1000 * 1000)
-
 static uint64_t cpu_riscv_read_rtc(void)
 {
-    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), TIMER_FREQ,
-                    NANOSECONDS_PER_SECOND);
+    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+        SIFIVE_CLINT_TIMEBASE_FREQ, NANOSECONDS_PER_SECOND);
 }
 
 /*
@@ -59,7 +56,7 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
     diff = cpu->env.timecmp - rtc_r;
     /* back to ns (note args switched in muldiv64) */
     next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-        muldiv64(diff, NANOSECONDS_PER_SECOND, TIMER_FREQ);
+        muldiv64(diff, NANOSECONDS_PER_SECOND, SIFIVE_CLINT_TIMEBASE_FREQ);
     timer_mod(cpu->env.timer, next);
 }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1c2deef..f3f7615 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -122,7 +122,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 
     qemu_fdt_add_subnode(fdt, "/cpus");
-    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency", 10000000);
+    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
+        SIFIVE_CLINT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
 
@@ -131,7 +132,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.harts[cpu]);
         qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 1000000000);
+        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
+                              SIFIVE_U_CLOCK_FREQ);
         qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 2d1f114..4c233ec 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -115,7 +115,8 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 
     qemu_fdt_add_subnode(fdt, "/cpus");
-    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency", 10000000);
+    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
+        SIFIVE_CLINT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
 
@@ -124,7 +125,8 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.harts[cpu]);
         qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 1000000000);
+        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
+                              SPIKE_CLOCK_FREQ);
         qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 37968d2..a402856 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -145,7 +145,8 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 
     qemu_fdt_add_subnode(fdt, "/cpus");
-    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency", 10000000);
+    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
+                          SIFIVE_CLINT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
 
@@ -155,7 +156,8 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.harts[cpu]);
         qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 1000000000);
+        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
+                              VIRT_CLOCK_FREQ);
         qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
index aaa2a58..e2865be 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -47,4 +47,8 @@ enum {
     SIFIVE_TIME_BASE    = 0xBFF8
 };
 
+enum {
+    SIFIVE_CLINT_TIMEBASE_FREQ = 10000000
+};
+
 #endif
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 662e8a1..be38aa0 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -50,6 +50,10 @@ enum {
     SIFIVE_U_UART1_IRQ = 4
 };
 
+enum {
+    SIFIVE_U_CLOCK_FREQ = 1000000000
+};
+
 #define SIFIVE_U_PLIC_HART_CONFIG "MS"
 #define SIFIVE_U_PLIC_NUM_SOURCES 127
 #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index cb55a14..d85a64e 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -42,6 +42,10 @@ enum {
     SPIKE_DRAM
 };
 
+enum {
+    SPIKE_CLOCK_FREQ = 1000000000
+};
+
 #if defined(TARGET_RISCV32)
 #define SPIKE_V1_09_1_CPU TYPE_RISCV_CPU_RV32GCSU_V1_09_1
 #define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_RV32GCSU_V1_10_0
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7525647..2fbe808 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,10 @@ enum {
     VIRTIO_NDEV = 10
 };
 
+enum {
+    VIRT_CLOCK_FREQ = 1000000000
+};
+
 #define VIRT_PLIC_HART_CONFIG "MS"
 #define VIRT_PLIC_NUM_SOURCES 127
 #define VIRT_PLIC_NUM_PRIORITIES 7
-- 
2.7.0
