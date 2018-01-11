Received: from eggs.gnu.org ([2001:4830:134:3::10]:52098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3z-0007Q8-Cb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3y-0008VP-6D
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd3x-0008Ns-V0
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3v-0005em-PO
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:05 +0000
Message-Id: <1515677902-23436-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/26] Virt: ACPI: fix qemu assert due to
 re-assigned table data address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Zhaoshenglong <zhaoshenglong@huawei.com>

acpi_data_push uses g_array_set_size to resize the memory size. If there
is no enough contiguous memory, the address will be changed. If we use
the old value, it will assert.
qemu-kvm: hw/acpi/bios-linker-loader.c:214: bios_linker_loader_add_checksum:
Assertion `start_offset < file->blob->len' failed.`

This issue only happens in building SRAT table now but here we unify the
pattern for other tables as well to avoid possible issues in the future.

Signed-off-by: Zhaoshenglong <zhaoshenglong@huawei.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3d78ff6..f7fa795 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -453,6 +453,7 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiSerialPortConsoleRedirection *spcr;
     const MemMapEntry *uart_memmap = &vms->memmap[VIRT_UART];
     int irq = vms->irqmap[VIRT_UART] + ARM_SPI_BASE;
+    int spcr_start = table_data->len;
 
     spcr = acpi_data_push(table_data, sizeof(*spcr));
 
@@ -476,8 +477,8 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     spcr->pci_device_id = 0xffff;  /* PCI Device ID: not a PCI device */
     spcr->pci_vendor_id = 0xffff;  /* PCI Vendor ID: not a PCI device */
 
-    build_header(linker, table_data, (void *)spcr, "SPCR", sizeof(*spcr), 2,
-                 NULL, NULL);
+    build_header(linker, table_data, (void *)(table_data->data + spcr_start),
+                 "SPCR", table_data->len - spcr_start, 2, NULL, NULL);
 }
 
 static void
@@ -512,8 +513,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         mem_base += numa_info[i].node_mem;
     }
 
-    build_header(linker, table_data, (void *)srat, "SRAT",
-                 table_data->len - srat_start, 3, NULL, NULL);
+    build_header(linker, table_data, (void *)(table_data->data + srat_start),
+                 "SRAT", table_data->len - srat_start, 3, NULL, NULL);
 }
 
 static void
@@ -522,6 +523,7 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiTableMcfg *mcfg;
     const MemMapEntry *memmap = vms->memmap;
     int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
+    int mcfg_start = table_data->len;
 
     mcfg = acpi_data_push(table_data, len);
     mcfg->allocation[0].address = cpu_to_le64(memmap[VIRT_PCIE_ECAM].base);
@@ -532,7 +534,8 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     mcfg->allocation[0].end_bus_number = (memmap[VIRT_PCIE_ECAM].size
                                           / PCIE_MMCFG_SIZE_MIN) - 1;
 
-    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
+    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
+                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
 }
 
 /* GTDT */
@@ -651,6 +654,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 static void build_fadt(GArray *table_data, BIOSLinker *linker,
                        VirtMachineState *vms, unsigned dsdt_tbl_offset)
 {
+    int fadt_start = table_data->len;
     AcpiFadtDescriptorRev5_1 *fadt = acpi_data_push(table_data, sizeof(*fadt));
     unsigned xdsdt_entry_offset = (char *)&fadt->x_dsdt - table_data->data;
     uint16_t bootflags;
@@ -681,8 +685,8 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
         ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
         ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
 
-    build_header(linker, table_data,
-                 (void *)fadt, "FACP", sizeof(*fadt), 5, NULL, NULL);
+    build_header(linker, table_data, (void *)(table_data->data + fadt_start),
+                 "FACP", table_data->len - fadt_start, 5, NULL, NULL);
 }
 
 /* DSDT */
-- 
2.7.4
