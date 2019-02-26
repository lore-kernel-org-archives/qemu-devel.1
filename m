Received: from eggs.gnu.org ([209.51.188.92]:60770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyjcI-0006ck-Vc
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyjcH-0000w2-VJ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:46:18 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 26 Feb 2019 21:44:37 +0100
Message-Id: <20190226204439.2296-17-eric.auger@redhat.com>
In-Reply-To: <20190226204439.2296-1-eric.auger@redhat.com>
References: <20190226204439.2296-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 16/18] hw/arm/virt: Add nvdimm hot-plug
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

From: Kwangwoo Lee <kwangwoo.lee@sk.com>

Pre-plug and plug handlers are prepared for NVDIMM support.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>

---

v7 -> v8:
- s/VIRT_ACPI_IO_BASE/VIRT_NVDIMM_ACPI_IO_BASE
- use const AcpiGenericAddress arm_virt_nvdimm_acpi_dsmio
---
 default-configs/arm-softmmu.mak |  2 ++
 hw/arm/virt-acpi-build.c        |  6 ++++++
 hw/arm/virt.c                   | 27 +++++++++++++++++++++++++--
 include/hw/arm/virt.h           |  2 ++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 4009a56c67..42027bcee5 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -166,3 +166,5 @@ CONFIG_HIGHBANK=3Dy
 CONFIG_MUSICPAL=3Dy
 CONFIG_MEM_DEVICE=3Dy
 CONFIG_DIMM=3Dy
+CONFIG_NVDIMM=3Dy
+CONFIG_ACPI_NVDIMM=3Dy
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8151fda239..d8f7b484ee 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -786,6 +786,7 @@ static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
+    MachineState *ms =3D MACHINE(vms);
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob =3D tables->table_data;
@@ -826,6 +827,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuil=
dTables *tables)
         }
     }
=20
+    if (ms->acpi_nvdimm_state.is_enabled) {
+        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
+                          &ms->acpi_nvdimm_state, ms->ram_slots);
+    }
+
     if (its_class_name() && !vmc->no_its) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6e2cbba22e..af2ccaf152 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -134,6 +134,7 @@ static const MemMapEntry base_memmap[] =3D {
     [VIRT_GPIO] =3D               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =3D        { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =3D               { 0x09050000, 0x00020000 },
+    [VIRT_NVDIMM_ACPI_IO] =3D     { 0x09070000, 0x00010000 },
     [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that s=
ize */
     [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
@@ -1651,6 +1652,19 @@ static void machvirt_init(MachineState *machine)
=20
     create_platform_bus(vms, pic);
=20
+    if (machine->acpi_nvdimm_state.is_enabled) {
+        const struct AcpiGenericAddress arm_virt_nvdimm_acpi_dsmio =3D {
+            .space_id =3D AML_AS_SYSTEM_MEMORY,
+            .address =3D vms->memmap[VIRT_NVDIMM_ACPI_IO].base +
+                       NVDIMM_ACPI_IO_BASE,
+            .bit_width =3D NVDIMM_ACPI_IO_LEN << 3
+        };
+
+        nvdimm_init_acpi_state(&machine->acpi_nvdimm_state, sysmem,
+                               arm_virt_nvdimm_acpi_dsmio,
+                               vms->fw_cfg, OBJECT(vms));
+    }
+
     vms->bootinfo.ram_size =3D machine->ram_size;
     vms->bootinfo.kernel_filename =3D machine->kernel_filename;
     vms->bootinfo.kernel_cmdline =3D machine->kernel_cmdline;
@@ -1835,11 +1849,20 @@ static void virt_memory_pre_plug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
 static void virt_memory_plug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
-    VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
+    MachineState *ms =3D MACHINE(hotplug_dev);
+    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     Error *local_err =3D NULL;
=20
-    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
+    pc_dimm_plug(PC_DIMM(dev), ms, &local_err);
+    if (local_err) {
+        goto out;
+    }
=20
+    if (is_nvdimm) {
+        nvdimm_plug(&ms->acpi_nvdimm_state);
+    }
+
+out:
     error_propagate(errp, local_err);
 }
=20
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 326a26b6d6..c8a4039f3f 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -37,6 +37,7 @@
 #include "hw/arm/arm.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/mem/nvdimm.h"
=20
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -77,6 +78,7 @@ enum {
     VIRT_GPIO,
     VIRT_SECURE_UART,
     VIRT_SECURE_MEM,
+    VIRT_NVDIMM_ACPI_IO,
     VIRT_LOWMEMMAP_LAST,
 };
=20
--=20
2.20.1
