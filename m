Received: from eggs.gnu.org ([2001:4830:134:3::10]:35255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1g6wpn-0002kT-I6
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1g6wpm-00061i-Kx
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:57:55 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Mon,  1 Oct 2018 13:57:04 +0200
Message-Id: <20181001115704.701-16-luc.michel@greensocs.com>
In-Reply-To: <20181001115704.701-1-luc.michel@greensocs.com>
References: <20181001115704.701-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/15] arm/xlnx-zynqmp: put APUs and RPUs in
 separate GDB groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.burton@greensocs.com

Create two separate QOM containers for APUs and RPUs to indicate to the
GDB stub that those CPUs should be put in different processes.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 hw/arm/xlnx-zynqmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index c195040350..5e92adbc71 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -22,10 +22,11 @@
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/intc/arm_gic_common.h"
 #include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
+#include "exec/gdbstub.h"
=20
 #define GIC_NUM_SPI_INTR 160
=20
 #define ARM_PHYS_TIMER_PPI  30
 #define ARM_VIRT_TIMER_PPI  27
@@ -175,17 +176,18 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState =
*s, const char *boot_cpu,
                                    Error **errp)
 {
     Error *err =3D NULL;
     int i;
     int num_rpus =3D MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQM=
P_NUM_RPU_CPUS);
+    Object *rpu_group =3D gdb_cpu_group_container_get(OBJECT(s));
=20
     for (i =3D 0; i < num_rpus; i++) {
         char *name;
=20
         object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
                           "cortex-r5f-" TYPE_ARM_CPU);
-        object_property_add_child(OBJECT(s), "rpu-cpu[*]",
+        object_property_add_child(rpu_group, "rpu-cpu[*]",
                                   OBJECT(&s->rpu_cpu[i]), &error_abort);
=20
         name =3D object_get_canonical_path_component(OBJECT(&s->rpu_cpu[=
i]));
         if (strcmp(name, boot_cpu)) {
             /* Secondary CPUs start in PSCI powered-down state */
@@ -210,13 +212,14 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState =
*s, const char *boot_cpu,
 static void xlnx_zynqmp_init(Object *obj)
 {
     XlnxZynqMPState *s =3D XLNX_ZYNQMP(obj);
     int i;
     int num_apus =3D MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    Object *apu_group =3D gdb_cpu_group_container_get(obj);
=20
     for (i =3D 0; i < num_apus; i++) {
-        object_initialize_child(obj, "apu-cpu[*]", &s->apu_cpu[i],
+        object_initialize_child(apu_group, "apu-cpu[*]", &s->apu_cpu[i],
                                 sizeof(s->apu_cpu[i]),
                                 "cortex-a53-" TYPE_ARM_CPU, &error_abort=
, NULL);
     }
=20
     sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
--=20
2.19.0
