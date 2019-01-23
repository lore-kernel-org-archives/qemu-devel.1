Received: from eggs.gnu.org ([209.51.188.92]:34673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZd-0001bq-Ld
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZT-0007JA-UX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:15:55 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:44 +0100
Message-Id: <20190123101458.12478-5-eric.auger@redhat.com>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
References: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 04/18] hw/arm/virt: Split the memory map
 description
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

In the prospect to introduce an extended memory map supporting more
RAM, let's split the memory map array into two parts:

- the former a15memmap contains regions below and including the RAM
- extended_memmap, only initialized with entries located after the RAM.
  the base address of each entry is an offset relative to the top of
  the RAM.

This new split will allow to grow the RAM size without chaanging the
static description of the high regions.

At that point the memory map is not changed.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt-acpi-build.c |  8 ++++----
 hw/arm/virt.c            | 40 +++++++++++++++++++++++++++++-----------
 include/hw/arm/virt.h    | 16 +++++++++++-----
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 04b62c714d..829d2f0035 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -229,8 +229,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
                      size_pio));
=20
     if (use_highmem) {
-        hwaddr base_mmio_high =3D memmap[VIRT_PCIE_MMIO_HIGH].base;
-        hwaddr size_mmio_high =3D memmap[VIRT_PCIE_MMIO_HIGH].size;
+        hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].base;
+        hwaddr size_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].size;
=20
         aml_append(rbuf,
             aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXE=
D,
@@ -663,8 +663,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
             gicr =3D acpi_data_push(table_data, sizeof(*gicr));
             gicr->type =3D ACPI_APIC_GENERIC_REDISTRIBUTOR;
             gicr->length =3D sizeof(*gicr);
-            gicr->base_address =3D cpu_to_le64(memmap[VIRT_GIC_REDIST2].=
base);
-            gicr->range_length =3D cpu_to_le32(memmap[VIRT_GIC_REDIST2].=
size);
+            gicr->base_address =3D cpu_to_le64(memmap[VIRT_HIGH_GIC_REDI=
ST2].base);
+            gicr->range_length =3D cpu_to_le32(memmap[VIRT_HIGH_GIC_REDI=
ST2].size);
         }
=20
         if (its_class_name() && !vmc->no_its) {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99c2b6e60d..ba4088895a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -29,6 +29,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
@@ -149,11 +150,15 @@ static const MemMapEntry a15memmap[] =3D {
     [VIRT_PCIE_PIO] =3D           { 0x3eff0000, 0x00010000 },
     [VIRT_PCIE_ECAM] =3D          { 0x3f000000, 0x01000000 },
     [VIRT_MEM] =3D                { 0x40000000, RAMLIMIT_BYTES },
+};
+
+/* Memory map beyond the RAM */
+static MemMapEntry extended_memmap[] =3D {
     /* Additional 64 MB redist region (can contain up to 512 redistribut=
ors) */
-    [VIRT_GIC_REDIST2] =3D        { 0x4000000000ULL, 0x4000000 },
-    [VIRT_PCIE_ECAM_HIGH] =3D     { 0x4010000000ULL, 0x10000000 },
+    [VIRT_HIGH_GIC_REDIST2] =3D   { 0x0, S_64MiB },
+    [VIRT_HIGH_PCIE_ECAM] =3D     { S_256MiB, S_256MiB },
     /* Second PCIe window, 512GB wide at the 512GB boundary */
-    [VIRT_PCIE_MMIO_HIGH] =3D   { 0x8000000000ULL, 0x8000000000ULL },
+    [VIRT_HIGH_PCIE_MMIO] =3D     { S_512GiB, S_512GiB },
 };
=20
 static const int a15irqmap[] =3D {
@@ -435,8 +440,8 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                          2, vms->memmap[VIRT_GIC_DIST].s=
ize,
                                          2, vms->memmap[VIRT_GIC_REDIST]=
.base,
                                          2, vms->memmap[VIRT_GIC_REDIST]=
.size,
-                                         2, vms->memmap[VIRT_GIC_REDIST2=
].base,
-                                         2, vms->memmap[VIRT_GIC_REDIST2=
].size);
+                                         2, vms->memmap[VIRT_HIGH_GIC_RE=
DIST2].base,
+                                         2, vms->memmap[VIRT_HIGH_GIC_RE=
DIST2].size);
         }
=20
         if (vms->virt) {
@@ -584,7 +589,7 @@ static void create_gic(VirtMachineState *vms, qemu_ir=
q *pic)
=20
         if (nb_redist_regions =3D=3D 2) {
             uint32_t redist1_capacity =3D
-                        vms->memmap[VIRT_GIC_REDIST2].size / GICV3_REDIS=
T_SIZE;
+                    vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDI=
ST_SIZE;
=20
             qdev_prop_set_uint32(gicdev, "redist-region-count[1]",
                 MIN(smp_cpus - redist0_count, redist1_capacity));
@@ -601,7 +606,8 @@ static void create_gic(VirtMachineState *vms, qemu_ir=
q *pic)
     if (type =3D=3D 3) {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base)=
;
         if (nb_redist_regions =3D=3D 2) {
-            sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_REDIST2].=
base);
+            sysbus_mmio_map(gicbusdev, 2,
+                            vms->memmap[VIRT_HIGH_GIC_REDIST2].base);
         }
     } else {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
@@ -1088,8 +1094,8 @@ static void create_pcie(VirtMachineState *vms, qemu=
_irq *pic)
 {
     hwaddr base_mmio =3D vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio =3D vms->memmap[VIRT_PCIE_MMIO].size;
-    hwaddr base_mmio_high =3D vms->memmap[VIRT_PCIE_MMIO_HIGH].base;
-    hwaddr size_mmio_high =3D vms->memmap[VIRT_PCIE_MMIO_HIGH].size;
+    hwaddr base_mmio_high =3D vms->memmap[VIRT_HIGH_PCIE_MMIO].base;
+    hwaddr size_mmio_high =3D vms->memmap[VIRT_HIGH_PCIE_MMIO].size;
     hwaddr base_pio =3D vms->memmap[VIRT_PCIE_PIO].base;
     hwaddr size_pio =3D vms->memmap[VIRT_PCIE_PIO].size;
     hwaddr base_ecam, size_ecam;
@@ -1418,7 +1424,7 @@ static void machvirt_init(MachineState *machine)
      */
     if (vms->gic_version =3D=3D 3) {
         virt_max_cpus =3D vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDI=
ST_SIZE;
-        virt_max_cpus +=3D vms->memmap[VIRT_GIC_REDIST2].size / GICV3_RE=
DIST_SIZE;
+        virt_max_cpus +=3D vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GIC=
V3_REDIST_SIZE;
     } else {
         virt_max_cpus =3D GIC_NCPU;
     }
@@ -1780,6 +1786,7 @@ static void virt_instance_init(Object *obj)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(obj);
     VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
+    int i;
=20
     /* EL3 is disabled by default on virt: this makes us consistent
      * between KVM and TCG for this board, and it also allows us to
@@ -1842,7 +1849,18 @@ static void virt_instance_init(Object *obj)
                                     "Valid values are none and smmuv3",
                                     NULL);
=20
-    vms->memmap =3D a15memmap;
+    vms->memmap =3D extended_memmap;
+
+    for (i =3D 0; i < ARRAY_SIZE(a15memmap); i++) {
+        vms->memmap[i] =3D a15memmap[i];
+    }
+
+    vms->high_io_base =3D S_256GiB; /* Top of the RAM */
+
+    for (i =3D VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++=
) {
+        vms->memmap[i].base =3D extended_memmap[i].base + vms->high_io_b=
ase;
+        vms->memmap[i].size =3D extended_memmap[i].size;
+    }
     vms->irqmap =3D a15irqmap;
 }
=20
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 4cc57a7ef6..3dc7a6c5d5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -64,7 +64,6 @@ enum {
     VIRT_GIC_VCPU,
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
-    VIRT_GIC_REDIST2,
     VIRT_SMMU,
     VIRT_UART,
     VIRT_MMIO,
@@ -74,12 +73,18 @@ enum {
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
     VIRT_PCIE_ECAM,
-    VIRT_PCIE_ECAM_HIGH,
     VIRT_PLATFORM_BUS,
-    VIRT_PCIE_MMIO_HIGH,
     VIRT_GPIO,
     VIRT_SECURE_UART,
     VIRT_SECURE_MEM,
+    VIRT_LOWMEMMAP_LAST,
+};
+
+/* indices of IO regions located after the RAM */
+enum {
+    VIRT_HIGH_GIC_REDIST2 =3D  VIRT_LOWMEMMAP_LAST,
+    VIRT_HIGH_PCIE_ECAM,
+    VIRT_HIGH_PCIE_MMIO,
 };
=20
 typedef enum VirtIOMMUType {
@@ -116,7 +121,7 @@ typedef struct {
     int32_t gic_version;
     VirtIOMMUType iommu;
     struct arm_boot_info bootinfo;
-    const MemMapEntry *memmap;
+    MemMapEntry *memmap;
     const int *irqmap;
     int smp_cpus;
     void *fdt;
@@ -126,9 +131,10 @@ typedef struct {
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
     int psci_conduit;
+    hwaddr high_io_base;
 } VirtMachineState;
=20
-#define VIRT_ECAM_ID(high) (high ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM)
+#define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
=20
 #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
 #define VIRT_MACHINE(obj) \
--=20
2.20.1
