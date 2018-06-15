Received: from eggs.gnu.org ([2001:4830:134:3::10]:34819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTpio-0004l5-7l
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTpik-0001I3-S0
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:29:02 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 15 Jun 2018 16:28:27 +0200
Message-Id: <1529072910-16156-9-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
References: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/11] hw/arm/virt: Add a new 256MB ECAM
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, ard.biesheuvel@linaro.org, christoffer.dall@arm.com, marc.zyngier@arm.com

This patch defines a new ECAM region located after the 256GB limit.

The virt machine state is augmented with a new highmem_ecam field
which guards the usage of this new ECAM region instead of the legacy
16MB one. With the highmem ECAM region, up to 256 PCIe buses can be
used.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>

---

1.0 (virt3.0) -> 2.0
- introduce VIRT_ECAM_ID and renamed ecam_memmap_id variable into
  ecam_id
- Added Drew's R-b

RFC -> PATCH:
- remove the newline at the end of acpi_dsdt_add_pci
- use vms->highmem_ecam to select the memmap id
---
 hw/arm/virt-acpi-build.c | 21 +++++++++++++--------
 hw/arm/virt.c            | 12 ++++++++----
 include/hw/arm/virt.h    |  4 ++++
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index eefd1d4..6ea47e2 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -150,16 +150,17 @@ static void acpi_dsdt_add_virtio(Aml *scope,
 }
 
 static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
-                              uint32_t irq, bool use_highmem)
+                              uint32_t irq, bool use_highmem, bool highmem_ecam)
 {
+    int ecam_id = VIRT_ECAM_ID(highmem_ecam);
     Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
     int i, bus_no;
     hwaddr base_mmio = memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = memmap[VIRT_PCIE_MMIO].size;
     hwaddr base_pio = memmap[VIRT_PCIE_PIO].base;
     hwaddr size_pio = memmap[VIRT_PCIE_PIO].size;
-    hwaddr base_ecam = memmap[VIRT_PCIE_ECAM].base;
-    hwaddr size_ecam = memmap[VIRT_PCIE_ECAM].size;
+    hwaddr base_ecam = memmap[ecam_id].base;
+    hwaddr size_ecam = memmap[ecam_id].size;
     int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
 
     Aml *dev = aml_device("%s", "PCI0");
@@ -173,7 +174,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
 
     /* Declare the PCI Routing Table. */
-    Aml *rt_pkg = aml_package(nr_pcie_buses * PCI_NUM_PINS);
+    Aml *rt_pkg = aml_varpackage(nr_pcie_buses * PCI_NUM_PINS);
     for (bus_no = 0; bus_no < nr_pcie_buses; bus_no++) {
         for (i = 0; i < PCI_NUM_PINS; i++) {
             int gsi = (i + bus_no) % PCI_NUM_PINS;
@@ -316,7 +317,10 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
     crs = aml_resource_template();
-    aml_append(crs, aml_memory32_fixed(base_ecam, size_ecam, AML_READ_WRITE));
+    aml_append(crs,
+        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base_ecam,
+                         base_ecam + size_ecam - 1, 0x0000, size_ecam));
     aml_append(dev_res0, aml_name_decl("_CRS", crs));
     aml_append(dev, dev_res0);
     aml_append(scope, dev);
@@ -573,16 +577,17 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     AcpiTableMcfg *mcfg;
     const MemMapEntry *memmap = vms->memmap;
+    int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
     int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
     int mcfg_start = table_data->len;
 
     mcfg = acpi_data_push(table_data, len);
-    mcfg->allocation[0].address = cpu_to_le64(memmap[VIRT_PCIE_ECAM].base);
+    mcfg->allocation[0].address = cpu_to_le64(memmap[ecam_id].base);
 
     /* Only a single allocation so no need to play with segments */
     mcfg->allocation[0].pci_segment = cpu_to_le16(0);
     mcfg->allocation[0].start_bus_number = 0;
-    mcfg->allocation[0].end_bus_number = (memmap[VIRT_PCIE_ECAM].size
+    mcfg->allocation[0].end_bus_number = (memmap[ecam_id].size
                                           / PCIE_MMCFG_SIZE_MIN) - 1;
 
     build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
@@ -766,7 +771,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
                     (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
     acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
-                      vms->highmem);
+                      vms->highmem, vms->highmem_ecam);
     acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
                        (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
     acpi_dsdt_add_power_button(scope);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 936cb3a..45d5ed0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -150,6 +150,7 @@ static const MemMapEntry a15memmap[] = {
     [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
     [VIRT_GIC_REDIST2] =        { 0x4000000000ULL, 0x4000000 },
+    [VIRT_PCIE_ECAM_HIGH] =     { 0x4010000000ULL, 0x10000000 },
     /* Second PCIe window, 512GB wide at the 512GB boundary */
     [VIRT_PCIE_MMIO_HIGH] =   { 0x8000000000ULL, 0x8000000000ULL },
 };
@@ -1043,10 +1044,9 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
     hwaddr size_mmio_high = vms->memmap[VIRT_PCIE_MMIO_HIGH].size;
     hwaddr base_pio = vms->memmap[VIRT_PCIE_PIO].base;
     hwaddr size_pio = vms->memmap[VIRT_PCIE_PIO].size;
-    hwaddr base_ecam = vms->memmap[VIRT_PCIE_ECAM].base;
-    hwaddr size_ecam = vms->memmap[VIRT_PCIE_ECAM].size;
+    hwaddr base_ecam, size_ecam;
     hwaddr base = base_mmio;
-    int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
+    int nr_pcie_buses;
     int irq = vms->irqmap[VIRT_PCIE];
     MemoryRegion *mmio_alias;
     MemoryRegion *mmio_reg;
@@ -1054,12 +1054,16 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
     MemoryRegion *ecam_reg;
     DeviceState *dev;
     char *nodename;
-    int i;
+    int i, ecam_id;
     PCIHostState *pci;
 
     dev = qdev_create(NULL, TYPE_GPEX_HOST);
     qdev_init_nofail(dev);
 
+    ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
+    base_ecam = vms->memmap[ecam_id].base;
+    size_ecam = vms->memmap[ecam_id].size;
+    nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
     /* Map only the first size_ecam bytes of ECAM space */
     ecam_alias = g_new0(MemoryRegion, 1);
     ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 308156f..085fdcc 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -72,6 +72,7 @@ enum {
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
     VIRT_PCIE_ECAM,
+    VIRT_PCIE_ECAM_HIGH,
     VIRT_PLATFORM_BUS,
     VIRT_PCIE_MMIO_HIGH,
     VIRT_GPIO,
@@ -106,6 +107,7 @@ typedef struct {
     FWCfgState *fw_cfg;
     bool secure;
     bool highmem;
+    bool highmem_ecam;
     bool its;
     bool virt;
     int32_t gic_version;
@@ -123,6 +125,8 @@ typedef struct {
     int psci_conduit;
 } VirtMachineState;
 
+#define VIRT_ECAM_ID(high) (high ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM)
+
 #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
 #define VIRT_MACHINE(obj) \
     OBJECT_CHECK(VirtMachineState, (obj), TYPE_VIRT_MACHINE)
-- 
2.5.5
