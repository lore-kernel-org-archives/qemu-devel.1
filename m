Received: from eggs.gnu.org ([209.51.188.92]:34223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hD31A-0001AS-Bk
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 04:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hD319-000746-77
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 04:19:08 -0400
From: Heyi Guo <guoheyi@huawei.com>
Date: Sun, 7 Apr 2019 16:14:53 +0800
Message-ID: <1554624893-8363-1-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC] arm/virt: add one more uart for UEFI runtime
 debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wanghaibin.wang@huawei.com, Heyi Guo <guoheyi@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>

This patch is based on the discussion in TianoCore edk2-devel mailing
list:
https://lists.01.org/pipermail/edk2-devel/2019-March/037986.html

The conclusion is that we need an individual UART for UEFI runtime
services to print debug message at runtime, to avoid conflicting with
the system UART. We cannot use the secure UART either, for we may both
have Trusted Firmware and UEFI runtime services running on the VM, and
it is not easy to keep synchronization between the two components.

To keep backward compatibility, UEFI UART is put behind the secure
UART when secure world is enabled.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
---
 hw/arm/virt.c         | 29 +++++++++++++++++++++++------
 include/hw/arm/virt.h |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ce2664a..cbc5a66 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -131,6 +131,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
+    [VIRT_UEFI_UART] =          { 0x09070000, 0x00001000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -166,6 +167,7 @@ static const int a15irqmap[] = {
     [VIRT_PCIE] = 3, /* ... to 6 */
     [VIRT_GPIO] = 7,
     [VIRT_SECURE_UART] = 8,
+    [VIRT_UEFI_UART] = 9,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
@@ -713,13 +715,23 @@ static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
     if (uart == VIRT_UART) {
         qemu_fdt_setprop_string(vms->fdt, "/chosen", "stdout-path", nodename);
     } else {
+        const char *status_string;
+
+        if (uart == VIRT_SECURE_UART) {
+            status_string = "secure-status";
+        } else {
+            status_string = "uefi-status";
+        }
+
         /* Mark as not usable by the normal world */
         qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
-        qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
+        qemu_fdt_setprop_string(vms->fdt, nodename, status_string, "okay");
 
-        qemu_fdt_add_subnode(vms->fdt, "/secure-chosen");
-        qemu_fdt_setprop_string(vms->fdt, "/secure-chosen", "stdout-path",
-                                nodename);
+        if (uart == VIRT_SECURE_UART) {
+            qemu_fdt_add_subnode(vms->fdt, "/secure-chosen");
+            qemu_fdt_setprop_string(vms->fdt, "/secure-chosen", "stdout-path",
+                                    nodename);
+        }
     }
 
     g_free(nodename);
@@ -1423,6 +1435,7 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
     bool aarch64 = true;
+    int uart_index = 0;
 
     /*
      * In accelerated mode, the memory map is computed earlier in kvm_type()
@@ -1616,13 +1629,17 @@ static void machvirt_init(MachineState *machine)
 
     fdt_add_pmu_nodes(vms);
 
-    create_uart(vms, pic, VIRT_UART, sysmem, serial_hd(0));
+    create_uart(vms, pic, VIRT_UART, sysmem, serial_hd(uart_index++));
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
-        create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
+        create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem,
+                    serial_hd(uart_index++));
     }
 
+    /* Create UART for UEFI runtime services debug */
+    create_uart(vms, pic, VIRT_UEFI_UART, sysmem, serial_hd(uart_index));
+
     vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
 
     create_rtc(vms, pic);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 507517c..565769f 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -77,6 +77,7 @@ enum {
     VIRT_GPIO,
     VIRT_SECURE_UART,
     VIRT_SECURE_MEM,
+    VIRT_UEFI_UART,
     VIRT_LOWMEMMAP_LAST,
 };
 
-- 
1.8.3.1
