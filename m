Received: from eggs.gnu.org ([209.51.188.92]:35122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFaW-0002LY-Gr
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFaV-0007rl-4q
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:52 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:56 +0100
Message-Id: <20190123101458.12478-17-eric.auger@redhat.com>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
References: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 16/18] hw/arm/virt: Add nvdimm hot-plug
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
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

From: Kwangwoo Lee <kwangwoo.lee@sk.com>

Pre-plug and plug handlers are prepared for NVDIMM support.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
---
 default-configs/arm-softmmu.mak |  2 ++
 hw/arm/virt-acpi-build.c        |  6 ++++++
 hw/arm/virt.c                   | 22 ++++++++++++++++++++++
 include/hw/arm/virt.h           |  3 +++
 4 files changed, 33 insertions(+)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 3c5928aae0..5deabc188b 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -161,3 +161,5 @@ CONFIG_HIGHBANK=3Dy
 CONFIG_MUSICPAL=3Dy
 CONFIG_MEM_DEVICE=3Dy
 CONFIG_DIMM=3Dy
+CONFIG_NVDIMM=3Dy
+CONFIG_ACPI_NVDIMM=3Dy
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index a2feacf6ce..ab30e28710 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -783,6 +783,7 @@ static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
+    MachineState *ms =3D MACHINE(vms);
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob =3D tables->table_data;
@@ -823,6 +824,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuil=
dTables *tables)
         }
     }
=20
+    if (vms->acpi_nvdimm_state.is_enabled) {
+        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
+                          &vms->acpi_nvdimm_state, ms->ram_slots);
+    }
+
     if (its_class_name() && !vmc->no_its) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c74a622412..f21cf32936 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -132,6 +132,7 @@ static const MemMapEntry a15memmap[] =3D {
     [VIRT_GPIO] =3D               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =3D        { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =3D               { 0x09050000, 0x00020000 },
+    [VIRT_ACPI_IO] =3D            { 0x09070000, 0x00010000 },
     [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that s=
ize */
     [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
@@ -1610,6 +1611,18 @@ static void machvirt_init(MachineState *machine)
=20
     create_platform_bus(vms, pic);
=20
+    if (vms->acpi_nvdimm_state.is_enabled) {
+        AcpiNVDIMMState *acpi_nvdimm_state =3D &vms->acpi_nvdimm_state;
+
+        acpi_nvdimm_state->dsm_io.type =3D NVDIMM_ACPI_IO_MEMORY;
+        acpi_nvdimm_state->dsm_io.base =3D
+                vms->memmap[VIRT_ACPI_IO].base + NVDIMM_ACPI_IO_BASE;
+        acpi_nvdimm_state->dsm_io.len =3D NVDIMM_ACPI_IO_LEN;
+
+        nvdimm_init_acpi_state(acpi_nvdimm_state, sysmem,
+                               vms->fw_cfg, OBJECT(vms));
+    }
+
     vms->bootinfo.ram_size =3D machine->ram_size;
     vms->bootinfo.kernel_filename =3D machine->kernel_filename;
     vms->bootinfo.kernel_cmdline =3D machine->kernel_cmdline;
@@ -1795,10 +1808,19 @@ static void virt_memory_plug(HotplugHandler *hotp=
lug_dev,
                              DeviceState *dev, Error **errp)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
+    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     Error *local_err =3D NULL;
=20
     pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
+    if (local_err) {
+        goto out;
+    }
=20
+    if (is_nvdimm) {
+        nvdimm_plug(&vms->acpi_nvdimm_state);
+    }
+
+out:
     error_propagate(errp, local_err);
 }
=20
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 86d4c93120..6bb7f92f72 100644
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
+    VIRT_ACPI_IO,
     VIRT_LOWMEMMAP_LAST,
 };
=20
@@ -133,6 +135,7 @@ typedef struct {
     int psci_conduit;
     hwaddr high_io_base;
     bool extended_memmap;
+    AcpiNVDIMMState acpi_nvdimm_state;
 } VirtMachineState;
=20
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
--=20
2.20.1
