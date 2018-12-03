Received: from eggs.gnu.org ([2001:4830:134:3::10]:51846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gTm1h-00046d-Dx
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gTm1g-0002eY-EK
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:04:33 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Tue, 4 Dec 2018 03:26:46 +0800
Message-Id: <1543865209-50994-6-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V11 5/8] hw/arm/virt: add pvpanic device in
 virt acpi table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

Add pvpanic device in virt acpi table, so when kernel command line
uses acpi=force, kernel can get info from acpi table.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/arm/virt-acpi-build.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5785fb6..4215ca6 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -84,6 +84,20 @@ static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
     aml_append(scope, dev);
 }
 
+static void acpi_dsdt_add_pvpanic(Aml *scope, const MemMapEntry *pvpanic_memmap)
+{
+    Aml *dev = aml_device("PEVT");
+    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0001")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    Aml *crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(pvpanic_memmap->base,
+               pvpanic_memmap->size, AML_READ_WRITE));
+
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+
 static void acpi_dsdt_add_fw_cfg(Aml *scope, const MemMapEntry *fw_cfg_memmap)
 {
     Aml *dev = aml_device("FWCF");
@@ -771,6 +785,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
     acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
+    acpi_dsdt_add_pvpanic(scope, &memmap[VIRT_PVPANIC]);
     acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
     acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
                     (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
-- 
1.8.3.1
