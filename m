Received: from eggs.gnu.org ([2001:4830:134:3::10]:52759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d7Qmt-0001mC-67
	for qemu-devel@nongnu.org; Sun, 07 May 2017 14:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d7Qms-0000Ev-8Q
	for qemu-devel@nongnu.org; Sun, 07 May 2017 14:20:07 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun,  7 May 2017 20:19:40 +0200
Message-Id: <20170507181940.25882-4-krzk@kernel.org>
In-Reply-To: <20170507181940.25882-1-krzk@kernel.org>
References: <20170507181940.25882-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/3] hw/arm/exynos: QOM-ify the SoC
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

Convert the Exynos4210 SoC code into a QOM model which is a preferred
approach instead of directly initializing SoC-related devices from the
board file.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/arm/exynos4210.c         | 18 +++++++++++++++---
 hw/arm/exynos4_boards.c     |  9 ++++++---
 include/hw/arm/exynos4210.h |  8 ++++++--
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 27a7bf28a5a9..034fc8be9d76 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -160,9 +160,10 @@ static uint64_t exynos4210_calc_affinity(int cpu)
     return mp_affinity;
 }
=20
-Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
+static void exynos4210_init(Object *obj)
 {
-    Exynos4210State *s =3D g_new(Exynos4210State, 1);
+    MemoryRegion *system_mem =3D get_system_memory();
+    Exynos4210State *s =3D EXYNOS4210(obj);
     qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
     SysBusDevice *busdev;
     ObjectClass *cpu_oc;
@@ -402,6 +403,17 @@ Exynos4210State *exynos4210_init(MemoryRegion *syste=
m_mem)
=20
     sysbus_create_simple(TYPE_EXYNOS4210_EHCI, EXYNOS4210_EHCI_BASE_ADDR=
,
             s->irq_table[exynos4210_get_irq(28, 3)]);
+}
+
+static const TypeInfo exynos4210_type_info =3D {
+    .name =3D TYPE_EXYNOS4210,
+    .parent =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(Exynos4210State),
+    .instance_init =3D exynos4210_init,
+};
=20
-    return s;
+static void exynos4210_register_types(void)
+{
+    type_register_static(&exynos4210_type_info);
 }
+type_init(exynos4210_register_types)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 6240b26839cd..5e7c6b562ae2 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -58,7 +58,7 @@ typedef enum Exynos4BoardType {
 } Exynos4BoardType;
=20
 typedef struct Exynos4BoardState {
-    Exynos4210State *soc;
+    Exynos4210State soc;
     MemoryRegion dram0_mem;
     MemoryRegion dram1_mem;
 } Exynos4BoardState;
@@ -162,7 +162,10 @@ exynos4_boards_init_common(MachineState *machine,
     exynos4_boards_init_ram(s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
=20
-    s->soc =3D exynos4210_init(get_system_memory());
+    object_initialize(&s->soc, sizeof(s->soc), TYPE_EXYNOS4210);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+                              &error_abort);
+    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_f=
atal);
=20
     return s;
 }
@@ -180,7 +183,7 @@ static void smdkc210_init(MachineState *machine)
                                                       EXYNOS4_BOARD_SMDK=
C210);
=20
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
-            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(37, 1)]=
));
+            qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)])=
);
     arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
 }
=20
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 098a69ec73d3..116eae62756b 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -29,6 +29,10 @@
 #include "exec/memory.h"
 #include "target/arm/cpu-qom.h"
=20
+#define TYPE_EXYNOS4210 "exynos4210"
+#define EXYNOS4210(obj) \
+    OBJECT_CHECK(Exynos4210State, (obj), TYPE_EXYNOS4210)
+
 #define EXYNOS4210_NCPUS                    2
=20
 #define EXYNOS4210_DRAM0_BASE_ADDR          0x40000000
@@ -85,6 +89,8 @@ typedef struct Exynos4210Irq {
 } Exynos4210Irq;
=20
 typedef struct Exynos4210State {
+    DeviceState parent_obj;
+
     ARMCPU *cpu[EXYNOS4210_NCPUS];
     Exynos4210Irq irqs;
     qemu_irq *irq_table;
@@ -101,8 +107,6 @@ typedef struct Exynos4210State {
 void exynos4210_write_secondary(ARMCPU *cpu,
         const struct arm_boot_info *info);
=20
-Exynos4210State *exynos4210_init(MemoryRegion *system_mem);
-
 /* Initialize exynos4210 IRQ subsystem stub */
 qemu_irq *exynos4210_init_irq(Exynos4210Irq *env);
=20
--=20
2.9.3
