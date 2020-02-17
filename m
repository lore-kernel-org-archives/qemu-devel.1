Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31306C7619D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE57B2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE57B2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b7h-0004fr-39
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b33-0004V9-KZ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b30-0000dz-Q4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45570 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2s-0000Q2-MU; Mon, 17 Feb 2020 02:42:23 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7A5DEB51FF8740FA55DE;
 Mon, 17 Feb 2020 15:42:20 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:10 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 12/16] hw/arm: move shared devices related functions to
 arm.c and export them
Date: Mon, 17 Feb 2020 02:51:24 -0500
Message-ID: <1581925888-103620-13-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: zhang.zhanghailiang@huawei.com, slp@redhat.com,
 Xu Yandong <xuyandong2@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move device related functions to arm.c, include RTC(pl031), UART(pl011),
virtio devices.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/arm.c          | 137 +++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c         | 156 +++---------------------------------------
 include/hw/arm/arm.h  |   8 +++
 include/hw/arm/virt.h |   1 -
 4 files changed, 153 insertions(+), 149 deletions(-)

diff --git a/hw/arm/arm.c b/hw/arm/arm.c
index c51bf513d2..6751c6a624 100644
--- a/hw/arm/arm.c
+++ b/hw/arm/arm.c
@@ -145,6 +145,143 @@ void init_gic_sysbus(ArmMachineState *ams)
     }
 }
 
+void create_uart(const ArmMachineState *ams, int uart,
+                        MemoryRegion *mem, Chardev *chr)
+{
+    char *nodename;
+    hwaddr base = ams->memmap[uart].base;
+    hwaddr size = ams->memmap[uart].size;
+    int irq = ams->irqmap[uart];
+    const char compat[] = "arm,pl011\0arm,primecell";
+    const char clocknames[] = "uartclk\0apb_pclk";
+    DeviceState *dev = qdev_create(NULL, "pl011");
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+
+    qdev_prop_set_chr(dev, "chardev", chr);
+    qdev_init_nofail(dev);
+    memory_region_add_subregion(mem, base,
+                                sysbus_mmio_get_region(s, 0));
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(ams->gic, irq));
+
+    nodename = g_strdup_printf("/pl011@%" PRIx64, base);
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    /* Note that we can't use setprop_string because of the embedded NUL */
+    qemu_fdt_setprop(ams->fdt, nodename, "compatible",
+                         compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
+                                     2, base, 2, size);
+    qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop_cells(ams->fdt, nodename, "clocks",
+                               ams->clock_phandle, ams->clock_phandle);
+    qemu_fdt_setprop(ams->fdt, nodename, "clock-names",
+                         clocknames, sizeof(clocknames));
+
+    if (uart == VIRT_UART) {
+        qemu_fdt_setprop_string(ams->fdt, "/chosen", "stdout-path", nodename);
+    } else {
+        /* Mark as not usable by the normal world */
+        qemu_fdt_setprop_string(ams->fdt, nodename, "status", "disabled");
+        qemu_fdt_setprop_string(ams->fdt, nodename, "secure-status", "okay");
+
+        qemu_fdt_add_subnode(ams->fdt, "/secure-chosen");
+        qemu_fdt_setprop_string(ams->fdt, "/secure-chosen", "stdout-path",
+                                nodename);
+    }
+
+    g_free(nodename);
+}
+
+void create_rtc(const ArmMachineState *ams)
+{
+    char *nodename;
+    hwaddr base = ams->memmap[VIRT_RTC].base;
+    hwaddr size = ams->memmap[VIRT_RTC].size;
+    int irq = ams->irqmap[VIRT_RTC];
+    const char compat[] = "arm,pl031\0arm,primecell";
+
+    sysbus_create_simple("pl031", base, qdev_get_gpio_in(ams->gic, irq));
+
+    nodename = g_strdup_printf("/pl031@%" PRIx64, base);
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    qemu_fdt_setprop(ams->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
+                                 2, base, 2, size);
+    qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "clocks", ams->clock_phandle);
+    qemu_fdt_setprop_string(ams->fdt, nodename, "clock-names", "apb_pclk");
+    g_free(nodename);
+}
+
+void create_virtio_devices(const ArmMachineState *ams)
+{
+    int i;
+    hwaddr size = ams->memmap[VIRT_MMIO].size;
+
+    /* We create the transports in forwards order. Since qbus_realize()
+     * prepends (not appends) new child buses, the incrementing loop below will
+     * create a list of virtio-mmio buses with decreasing base addresses.
+     *
+     * When a -device option is processed from the command line,
+     * qbus_find_recursive() picks the next free virtio-mmio bus in forwards
+     * order. The upshot is that -device options in increasing command line
+     * order are mapped to virtio-mmio buses with decreasing base addresses.
+     *
+     * When this code was originally written, that arrangement ensured that the
+     * guest Linux kernel would give the lowest "name" (/dev/vda, eth0, etc) to
+     * the first -device on the command line. (The end-to-end order is a
+     * function of this loop, qbus_realize(), qbus_find_recursive(), and the
+     * guest kernel's name-to-address assignment strategy.)
+     *
+     * Meanwhile, the kernel's traversal seems to have been reversed; see eg.
+     * the message, if not necessarily the code, of commit 70161ff336.
+     * Therefore the loop now establishes the inverse of the original intent.
+     *
+     * Unfortunately, we can't counteract the kernel change by reversing the
+     * loop; it would break existing command lines.
+     *
+     * In any case, the kernel makes no guarantee about the stability of
+     * enumeration order of virtio devices (as demonstrated by it changing
+     * between kernel versions). For reliable and stable identification
+     * of disks users must use UUIDs or similar mechanisms.
+     */
+    for (i = 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
+        int irq = ams->irqmap[VIRT_MMIO] + i;
+        hwaddr base = ams->memmap[VIRT_MMIO].base + i * size;
+
+        sysbus_create_simple("virtio-mmio", base,
+                             qdev_get_gpio_in(ams->gic, irq));
+    }
+
+    /* We add dtb nodes in reverse order so that they appear in the finished
+     * device tree lowest address first.
+     *
+     * Note that this mapping is independent of the loop above. The previous
+     * loop influences virtio device to virtio transport assignment, whereas
+     * this loop controls how virtio transports are laid out in the dtb.
+     */
+    for (i = NUM_VIRTIO_TRANSPORTS - 1; i >= 0; i--) {
+        char *nodename;
+        int irq = ams->irqmap[VIRT_MMIO] + i;
+        hwaddr base = ams->memmap[VIRT_MMIO].base + i * size;
+
+        nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
+        qemu_fdt_add_subnode(ams->fdt, nodename);
+        qemu_fdt_setprop_string(ams->fdt, nodename,
+                                "compatible", "virtio,mmio");
+        qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
+                                     2, base, 2, size);
+        qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+        qemu_fdt_setprop(ams->fdt, nodename, "dma-coherent", NULL, 0);
+        g_free(nodename);
+    }
+}
+
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     ArmMachineState *ams = ARM_MACHINE(obj);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2c0dfb2695..b3267b873a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -231,14 +231,14 @@ static void create_fdt(VirtMachineState *vms)
      * optional but in practice if you omit them the kernel refuses to
      * probe for the device.
      */
-    vms->clock_phandle = qemu_fdt_alloc_phandle(fdt);
+    ams->clock_phandle = qemu_fdt_alloc_phandle(fdt);
     qemu_fdt_add_subnode(fdt, "/apb-pclk");
     qemu_fdt_setprop_string(fdt, "/apb-pclk", "compatible", "fixed-clock");
     qemu_fdt_setprop_cell(fdt, "/apb-pclk", "#clock-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/apb-pclk", "clock-frequency", 24000000);
     qemu_fdt_setprop_string(fdt, "/apb-pclk", "clock-output-names",
                                 "clk24mhz");
-    qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", vms->clock_phandle);
+    qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", ams->clock_phandle);
 
     if (nb_numa_nodes > 0 && ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
@@ -687,79 +687,6 @@ static void create_gic(VirtMachineState *vms)
     gic_set_msi_interrupt(vms);
 }
 
-static void create_uart(const VirtMachineState *vms, int uart,
-                        MemoryRegion *mem, Chardev *chr)
-{
-    char *nodename;
-    const ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr base = ams->memmap[uart].base;
-    hwaddr size = ams->memmap[uart].size;
-    int irq = ams->irqmap[uart];
-    const char compat[] = "arm,pl011\0arm,primecell";
-    const char clocknames[] = "uartclk\0apb_pclk";
-    DeviceState *dev = qdev_create(NULL, "pl011");
-    SysBusDevice *s = SYS_BUS_DEVICE(dev);
-
-    qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
-    memory_region_add_subregion(mem, base,
-                                sysbus_mmio_get_region(s, 0));
-    sysbus_connect_irq(s, 0, qdev_get_gpio_in(ams->gic, irq));
-
-    nodename = g_strdup_printf("/pl011@%" PRIx64, base);
-    qemu_fdt_add_subnode(ams->fdt, nodename);
-    /* Note that we can't use setprop_string because of the embedded NUL */
-    qemu_fdt_setprop(ams->fdt, nodename, "compatible",
-                         compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                     2, base, 2, size);
-    qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irq,
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cells(ams->fdt, nodename, "clocks",
-                               vms->clock_phandle, vms->clock_phandle);
-    qemu_fdt_setprop(ams->fdt, nodename, "clock-names",
-                         clocknames, sizeof(clocknames));
-
-    if (uart == VIRT_UART) {
-        qemu_fdt_setprop_string(ams->fdt, "/chosen", "stdout-path", nodename);
-    } else {
-        /* Mark as not usable by the normal world */
-        qemu_fdt_setprop_string(ams->fdt, nodename, "status", "disabled");
-        qemu_fdt_setprop_string(ams->fdt, nodename, "secure-status", "okay");
-
-        qemu_fdt_add_subnode(ams->fdt, "/secure-chosen");
-        qemu_fdt_setprop_string(ams->fdt, "/secure-chosen", "stdout-path",
-                                nodename);
-    }
-
-    g_free(nodename);
-}
-
-static void create_rtc(const VirtMachineState *vms)
-{
-    char *nodename;
-    const ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr base = ams->memmap[VIRT_RTC].base;
-    hwaddr size = ams->memmap[VIRT_RTC].size;
-    int irq = ams->irqmap[VIRT_RTC];
-    const char compat[] = "arm,pl031\0arm,primecell";
-
-    sysbus_create_simple("pl031", base, qdev_get_gpio_in(ams->gic, irq));
-
-    nodename = g_strdup_printf("/pl031@%" PRIx64, base);
-    qemu_fdt_add_subnode(ams->fdt, nodename);
-    qemu_fdt_setprop(ams->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                 2, base, 2, size);
-    qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, irq,
-                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cell(ams->fdt, nodename, "clocks", vms->clock_phandle);
-    qemu_fdt_setprop_string(ams->fdt, nodename, "clock-names", "apb_pclk");
-    g_free(nodename);
-}
-
 static DeviceState *gpio_key_dev;
 static void virt_powerdown_req(Notifier *n, void *opaque)
 {
@@ -797,7 +724,7 @@ static void create_gpio(const VirtMachineState *vms)
     qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cell(ams->fdt, nodename, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "clocks", ams->clock_phandle);
     qemu_fdt_setprop_string(ams->fdt, nodename, "clock-names", "apb_pclk");
     qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", phandle);
 
@@ -818,73 +745,6 @@ static void create_gpio(const VirtMachineState *vms)
     g_free(nodename);
 }
 
-static void create_virtio_devices(const VirtMachineState *vms)
-{
-    int i;
-    const ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr size = ams->memmap[VIRT_MMIO].size;
-
-    /* We create the transports in forwards order. Since qbus_realize()
-     * prepends (not appends) new child buses, the incrementing loop below will
-     * create a list of virtio-mmio buses with decreasing base addresses.
-     *
-     * When a -device option is processed from the command line,
-     * qbus_find_recursive() picks the next free virtio-mmio bus in forwards
-     * order. The upshot is that -device options in increasing command line
-     * order are mapped to virtio-mmio buses with decreasing base addresses.
-     *
-     * When this code was originally written, that arrangement ensured that the
-     * guest Linux kernel would give the lowest "name" (/dev/vda, eth0, etc) to
-     * the first -device on the command line. (The end-to-end order is a
-     * function of this loop, qbus_realize(), qbus_find_recursive(), and the
-     * guest kernel's name-to-address assignment strategy.)
-     *
-     * Meanwhile, the kernel's traversal seems to have been reversed; see eg.
-     * the message, if not necessarily the code, of commit 70161ff336.
-     * Therefore the loop now establishes the inverse of the original intent.
-     *
-     * Unfortunately, we can't counteract the kernel change by reversing the
-     * loop; it would break existing command lines.
-     *
-     * In any case, the kernel makes no guarantee about the stability of
-     * enumeration order of virtio devices (as demonstrated by it changing
-     * between kernel versions). For reliable and stable identification
-     * of disks users must use UUIDs or similar mechanisms.
-     */
-    for (i = 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
-        int irq = ams->irqmap[VIRT_MMIO] + i;
-        hwaddr base = ams->memmap[VIRT_MMIO].base + i * size;
-
-        sysbus_create_simple("virtio-mmio", base,
-                             qdev_get_gpio_in(ams->gic, irq));
-    }
-
-    /* We add dtb nodes in reverse order so that they appear in the finished
-     * device tree lowest address first.
-     *
-     * Note that this mapping is independent of the loop above. The previous
-     * loop influences virtio device to virtio transport assignment, whereas
-     * this loop controls how virtio transports are laid out in the dtb.
-     */
-    for (i = NUM_VIRTIO_TRANSPORTS - 1; i >= 0; i--) {
-        char *nodename;
-        int irq = ams->irqmap[VIRT_MMIO] + i;
-        hwaddr base = ams->memmap[VIRT_MMIO].base + i * size;
-
-        nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
-        qemu_fdt_add_subnode(ams->fdt, nodename);
-        qemu_fdt_setprop_string(ams->fdt, nodename,
-                                "compatible", "virtio,mmio");
-        qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                     2, base, 2, size);
-        qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irq,
-                               GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
-        qemu_fdt_setprop(ams->fdt, nodename, "dma-coherent", NULL, 0);
-        g_free(nodename);
-    }
-}
-
 #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
 
 static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
@@ -1151,7 +1011,7 @@ static void create_smmu(const VirtMachineState *vms,
     qemu_fdt_setprop(ams->fdt, node, "interrupt-names", irq_names,
                      sizeof(irq_names));
 
-    qemu_fdt_setprop_cell(ams->fdt, node, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_cell(ams->fdt, node, "clocks", ams->clock_phandle);
     qemu_fdt_setprop_string(ams->fdt, node, "clock-names", "apb_pclk");
     qemu_fdt_setprop(ams->fdt, node, "dma-coherent", NULL, 0);
 
@@ -1709,16 +1569,16 @@ static void machvirt_init(MachineState *machine)
 
     fdt_add_pmu_nodes(vms);
 
-    create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
+    create_uart(ams, VIRT_UART, sysmem, serial_hd(0));
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
-        create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
+        create_uart(ams, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
     }
 
     vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
 
-    create_rtc(vms);
+    create_rtc(ams);
 
     create_pcie(vms);
 
@@ -1736,7 +1596,7 @@ static void machvirt_init(MachineState *machine)
      * (which will be automatically plugged in to the transports). If
      * no backend is created the transport will just sit harmlessly idle.
      */
-    create_virtio_devices(vms);
+    create_virtio_devices(ams);
 
     vms->fw_cfg = create_fw_cfg(vms, &address_space_memory);
     rom_set_fw(vms->fw_cfg);
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index bb3680e583..8fec23985e 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -97,6 +97,7 @@ typedef struct {
     int smp_cpus;
     void *fdt;
     int fdt_size;
+    uint32_t clock_phandle;
     uint32_t gic_phandle;
     int psci_conduit;
     DeviceState *gic;
@@ -114,6 +115,13 @@ void qdev_create_gic(ArmMachineState *ams);
 
 void init_gic_sysbus(ArmMachineState *ams);
 
+void create_uart(const ArmMachineState *ams, int uart,
+                 MemoryRegion *mem, Chardev *chr);
+
+void create_rtc(const ArmMachineState *ams);
+
+void create_virtio_devices(const ArmMachineState *ams);
+
 /* Return the number of used redistributor regions  */
 static inline int virt_gicv3_redist_region_count(ArmMachineState *ams)
 {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ad94634038..086a27682f 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -69,7 +69,6 @@ typedef struct {
     bool virt;
     VirtIOMMUType iommu;
     struct arm_boot_info bootinfo;
-    uint32_t clock_phandle;
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
     hwaddr highest_gpa;
-- 
2.18.1


