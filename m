Received: from eggs.gnu.org ([2001:4830:134:3::10]:52007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eNKAP-0000fr-1S
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eNKAO-0007Ns-9S
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:02:21 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Dec 2017 15:02:08 +0000
Message-Id: <1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] hw/arm/virt-acpi-build: Add second UART to
 ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhao@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>

Add the second UART to the ACPI tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Pure guesswork, as I don't have a UEFI setup to hand and
am not familiar with ACPI table formats either...
---
 hw/arm/virt-acpi-build.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3d78ff6..a38287b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -689,6 +689,7 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     Aml *scope, *dsdt;
     const MemMapEntry *memmap = vms->memmap;
     const int *irqmap = vms->irqmap;
@@ -706,6 +707,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_cpus(scope, vms->smp_cpus);
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
+    if (!vmc->no_second_uart) {
+        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART_2],
+                           (irqmap[VIRT_UART_2] + ARM_SPI_BASE));
+    }
     acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
     acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
     acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
-- 
2.7.4
