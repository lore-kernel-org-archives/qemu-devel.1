Received: from eggs.gnu.org ([2001:4830:134:3::10]:51885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gTm1i-00048N-Tz
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gTm1h-0002fy-Ln
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:04:34 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Tue, 4 Dec 2018 03:26:48 +0800
Message-Id: <1543865209-50994-8-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V11 7/8] hw/arm/virt: use the configure
 interface
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

Use the configure interface for pvpanic-mmio.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/arm/virt-acpi-build.c | 5 ++++-
 hw/arm/virt.c            | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4215ca6..4990a0d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -785,7 +785,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
     acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
-    acpi_dsdt_add_pvpanic(scope, &memmap[VIRT_PVPANIC]);
+
+    if (vms->pvpanic) {
+        acpi_dsdt_add_pvpanic(scope, &memmap[VIRT_PVPANIC]);
+    }
     acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
     acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
                     (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fdd3f20..a63e9e1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -198,6 +198,9 @@ static void create_pvpanic_device(const VirtMachineState *vms)
     hwaddr base = vms->memmap[VIRT_PVPANIC].base;
     hwaddr size = vms->memmap[VIRT_PVPANIC].size;
 
+    if (!vms->pvpanic) {
+        return;
+    }
     sysbus_create_simple(TYPE_PVPANIC_MMIO, base, NULL);
 
     nodename = g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);
-- 
1.8.3.1
