Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1576C10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 08:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E5F213F2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 08:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E5F213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35934 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD32C-0001X9-15
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 04:20:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hD31A-0001AS-Bk
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 04:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hD319-000746-77
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 04:19:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2257 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guoheyi@huawei.com>)
	id 1hD316-0006yN-96; Sun, 07 Apr 2019 04:19:04 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id B4069CDBAB1A1E366A48;
	Sun,  7 Apr 2019 16:18:58 +0800 (CST)
Received: from linux-wjgadX.huawei.com (10.90.31.46) by
	DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server
	id 14.3.408.0; Sun, 7 Apr 2019 16:18:52 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Date: Sun, 7 Apr 2019 16:14:53 +0800
Message-ID: <1554624893-8363-1-git-send-email-guoheyi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.90.31.46]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: [Qemu-devel] [RFC] arm/virt: add one more uart for UEFI runtime
 debug
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com,
	Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407081453.w3SIQeSbYszTCWW5rd-QighhIVnjN8DDzJVvXG_Ykvw@z>

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


