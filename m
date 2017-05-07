Received: from eggs.gnu.org ([2001:4830:134:3::10]:52714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d7Qmn-0001gd-D4
	for qemu-devel@nongnu.org; Sun, 07 May 2017 14:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d7Qmm-0000AF-57
	for qemu-devel@nongnu.org; Sun, 07 May 2017 14:20:01 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun,  7 May 2017 20:19:38 +0200
Message-Id: <20170507181940.25882-2-krzk@kernel.org>
In-Reply-To: <20170507181940.25882-1-krzk@kernel.org>
References: <20170507181940.25882-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/3] hw/arm/exynos: Move DRAM initialization
 next boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Krzysztof Kozlowski <krzk@kernel.org>

Before QOM-ifying the Exynos4 SoC model, move the DRAM initialization
from exynos4210.c to exynos4_boards.c because DRAM is board specific,
not SoC.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/arm/exynos4210.c         | 20 +-----------------
 hw/arm/exynos4_boards.c     | 50 ++++++++++++++++++++++++++++++++++++++-=
------
 include/hw/arm/exynos4210.h |  5 +----
 3 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 960f27e45a36..0da877f8db0a 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -160,13 +160,11 @@ static uint64_t exynos4210_calc_affinity(int cpu)
     return mp_affinity;
 }
=20
-Exynos4210State *exynos4210_init(MemoryRegion *system_mem,
-        unsigned long ram_size)
+Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
 {
     int i, n;
     Exynos4210State *s =3D g_new(Exynos4210State, 1);
     qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
-    unsigned long mem_size;
     DeviceState *dev;
     SysBusDevice *busdev;
     ObjectClass *cpu_oc;
@@ -299,22 +297,6 @@ Exynos4210State *exynos4210_init(MemoryRegion *syste=
m_mem,
     memory_region_add_subregion(system_mem, EXYNOS4210_IRAM_BASE_ADDR,
                                 &s->iram_mem);
=20
-    /* DRAM */
-    mem_size =3D ram_size;
-    if (mem_size > EXYNOS4210_DRAM_MAX_SIZE) {
-        memory_region_init_ram(&s->dram1_mem, NULL, "exynos4210.dram1",
-                mem_size - EXYNOS4210_DRAM_MAX_SIZE, &error_fatal);
-        vmstate_register_ram_global(&s->dram1_mem);
-        memory_region_add_subregion(system_mem, EXYNOS4210_DRAM1_BASE_AD=
DR,
-                &s->dram1_mem);
-        mem_size =3D EXYNOS4210_DRAM_MAX_SIZE;
-    }
-    memory_region_init_ram(&s->dram0_mem, NULL, "exynos4210.dram0", mem_=
size,
-                           &error_fatal);
-    vmstate_register_ram_global(&s->dram0_mem);
-    memory_region_add_subregion(system_mem, EXYNOS4210_DRAM0_BASE_ADDR,
-            &s->dram0_mem);
-
    /* PMU.
     * The only reason of existence at the moment is that secondary CPU b=
oot
     * loader uses PMU INFORM5 register as a holding pen.
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 4853c318023c..6240b26839cd 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -22,6 +22,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -56,6 +57,12 @@ typedef enum Exynos4BoardType {
     EXYNOS4_NUM_OF_BOARDS
 } Exynos4BoardType;
=20
+typedef struct Exynos4BoardState {
+    Exynos4210State *soc;
+    MemoryRegion dram0_mem;
+    MemoryRegion dram1_mem;
+} Exynos4BoardState;
+
 static int exynos4_board_id[EXYNOS4_NUM_OF_BOARDS] =3D {
     [EXYNOS4_BOARD_NURI]     =3D 0xD33,
     [EXYNOS4_BOARD_SMDKC210] =3D 0xB16,
@@ -96,9 +103,34 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
     }
 }
=20
-static Exynos4210State *exynos4_boards_init_common(MachineState *machine=
,
-                                                   Exynos4BoardType boar=
d_type)
+static void exynos4_boards_init_ram(Exynos4BoardState *s,
+                                    MemoryRegion *system_mem,
+                                    unsigned long ram_size)
+{
+    unsigned long mem_size =3D ram_size;
+
+    if (mem_size > EXYNOS4210_DRAM_MAX_SIZE) {
+        memory_region_init_ram(&s->dram1_mem, NULL, "exynos4210.dram1",
+                               mem_size - EXYNOS4210_DRAM_MAX_SIZE,
+                               &error_fatal);
+        vmstate_register_ram_global(&s->dram1_mem);
+        memory_region_add_subregion(system_mem, EXYNOS4210_DRAM1_BASE_AD=
DR,
+                                    &s->dram1_mem);
+        mem_size =3D EXYNOS4210_DRAM_MAX_SIZE;
+    }
+
+    memory_region_init_ram(&s->dram0_mem, NULL, "exynos4210.dram0", mem_=
size,
+                           &error_fatal);
+    vmstate_register_ram_global(&s->dram0_mem);
+    memory_region_add_subregion(system_mem, EXYNOS4210_DRAM0_BASE_ADDR,
+                                &s->dram0_mem);
+}
+
+static Exynos4BoardState *
+exynos4_boards_init_common(MachineState *machine,
+                           Exynos4BoardType board_type)
 {
+    Exynos4BoardState *s =3D g_new(Exynos4BoardState, 1);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
=20
     if (smp_cpus !=3D EXYNOS4210_NCPUS && !qtest_enabled()) {
@@ -127,8 +159,12 @@ static Exynos4210State *exynos4_boards_init_common(M=
achineState *machine,
             machine->kernel_cmdline,
             machine->initrd_filename);
=20
-    return exynos4210_init(get_system_memory(),
-            exynos4_board_ram_size[board_type]);
+    exynos4_boards_init_ram(s, get_system_memory(),
+                            exynos4_board_ram_size[board_type]);
+
+    s->soc =3D exynos4210_init(get_system_memory());
+
+    return s;
 }
=20
 static void nuri_init(MachineState *machine)
@@ -140,11 +176,11 @@ static void nuri_init(MachineState *machine)
=20
 static void smdkc210_init(MachineState *machine)
 {
-    Exynos4210State *s =3D exynos4_boards_init_common(machine,
-                                                    EXYNOS4_BOARD_SMDKC2=
10);
+    Exynos4BoardState *s =3D exynos4_boards_init_common(machine,
+                                                      EXYNOS4_BOARD_SMDK=
C210);
=20
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
-            qemu_irq_invert(s->irq_table[exynos4210_get_irq(37, 1)]));
+            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(37, 1)]=
));
     arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
 }
=20
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index d9e08014d6ff..098a69ec73d3 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -93,8 +93,6 @@ typedef struct Exynos4210State {
     MemoryRegion iram_mem;
     MemoryRegion irom_mem;
     MemoryRegion irom_alias_mem;
-    MemoryRegion dram0_mem;
-    MemoryRegion dram1_mem;
     MemoryRegion boot_secondary;
     MemoryRegion bootreg_mem;
     I2CBus *i2c_if[EXYNOS4210_I2C_NUMBER];
@@ -103,8 +101,7 @@ typedef struct Exynos4210State {
 void exynos4210_write_secondary(ARMCPU *cpu,
         const struct arm_boot_info *info);
=20
-Exynos4210State *exynos4210_init(MemoryRegion *system_mem,
-        unsigned long ram_size);
+Exynos4210State *exynos4210_init(MemoryRegion *system_mem);
=20
 /* Initialize exynos4210 IRQ subsystem stub */
 qemu_irq *exynos4210_init_irq(Exynos4210Irq *env);
--=20
2.9.3
