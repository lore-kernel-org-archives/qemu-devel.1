Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27605C352A2
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0B52072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kZbsjFyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0B52072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKkp-000145-0Q
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjZ-0007kT-SN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjY-0004uM-1v
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50270)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjX-0004rB-Pi
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205132846euoutp02f6391c2bf4685a4007b7b222d333f081~whKgnB9S40896308963euoutp02Y
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200205132846euoutp02f6391c2bf4685a4007b7b222d333f081~whKgnB9S40896308963euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580909326;
 bh=2EdIg2dqS4is2/71/wtKDkcAjFpedYTyvl4ZZh7iwes=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kZbsjFyfgnBRznqYjVXZCkNmDfDeL3aapkySimyIvM/tbBOCc+5V1Mh1flA9ZfVWa
 HgQe8uf8U5zKVOSnZMS6HqebecdNf1v7KsGeY/wOY2xcwT4oJ+4ss+YQHVohpv5x7P
 dJ+jmSl8rzneY/L0EHHeoHNV2eZm0082njRu0txE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200205132846eucas1p2abe52493f56a5da6270db890fee6be9a~whKgYdpwn0491704917eucas1p2G;
 Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 19.1E.61286.E03CA3E5; Wed,  5
 Feb 2020 13:28:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200205132846eucas1p1c9a1974934b43e8cfe74e0e670de3a23~whKgHN4142962229622eucas1p1c;
 Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200205132846eusmtrp2eaff9fda5f09bd2399b81ab099060005~whKgGo3p43040630406eusmtrp2I;
 Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-a9-5e3ac30e7eb0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 74.00.08375.E03CA3E5; Wed,  5
 Feb 2020 13:28:46 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132846eusmtip21942ea584f8da78710d61bd9c7c47fde~whKfvhevY0228002280eusmtip2N;
 Wed,  5 Feb 2020 13:28:45 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 9/9] hw/arm/virt: Hack in support for memexpose device
Date: Wed,  5 Feb 2020 14:28:37 +0100
Message-Id: <1580909317-23884-10-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djP87p8h63iDI4uVrPYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRXDYpqTmZ
 ZalF+nYJXBmte+axF6y1q1hwmauBcaduFyMnh4SAiUTHqunsILaQwApGiQ1T5boYuYDsL4wS
 024vY4RIfGaUuLg1Eabh2bJPLBBFyxklem9cY4TrmHB6BVgHm4CaxM4jn8FsEQFJid9dp5lB
 ipgFGhglHl0/C5YQFvCXOHnhL5jNIqAq8X/TDbA7eAUCJZZ/usIOsU5O4ua5TmYQmxMofvnZ
 FFaQQRICj9kkTp76ygZR5CJxsP8+E4QtLPHq+BaoZhmJ/zvnQ8XrJVru7GCCaO5glOhbOR2q
 2Vriy4alQA9xAJ2nKbF+lz5E2FHi3Ly3YGEJAT6JG28FQcLMQOakbdOZIcK8Eh1tQhDVehLd
 T24ywWxd1viIBcL2kJi36TUTJICWMEp837KbfQKj/CyEZQsYGVcxiqeWFuempxYb5qWW6xUn
 5haX5qXrJefnbmIEJoTT/45/2sH49VLSIUYBDkYlHt4VkyzjhFgTy4orcw8xSnAwK4nwntcH
 CvGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cAYYFp1vebf
 RZNc9T/vnbV3rl8i0v3tbJfQ/CCBSzI7qzsLuNfVrDo++YXJre2exeHlYQtV3CrvXpt16M4F
 mQkdH+Y/FQq8ZeWXVF8++fdHtXy3s+eV2Q37W6uOfg05v/0l/5rlWs7t0i/8V20PqZsww//f
 KfMNizp3RcdcmXD0y6t9j+SEuU0vKbEUZyQaajEXFScCAA0ZIUQEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsVy+t/xe7p8h63iDBp7xSz2XHjMZnHv5k1m
 i/3b/rFazDnzgMXieO8OFgdWjzvX9rB5PLm2mcnj4Ls9TB7v911l89h+chJTAGuUnk1RfmlJ
 qkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXkbrnnnsBWvtKhZc
 5mpg3KnbxcjJISFgIvFs2SeWLkYuDiGBpYwS374+ZoFIyEj8OL2GDcIWlvhzrQvMFhL4xChx
 bi5YM5uAmsTOI58ZQWwRAUmJ312nmUEGMQu0MEo8e9LOBJIQFvCVWPTkMSuIzSKgKvF/0w12
 EJtXIFBi+acr7BAL5CRunutkBrE5geKXn01hhVgWIPF64hXmCYx8CxgZVjGKpJYW56bnFhvq
 FSfmFpfmpesl5+duYgQG6LZjPzfvYLy0MfgQowAHoxIP74pJlnFCrIllxZW5hxglOJiVRHjP
 6wOFeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0OR8YPXkl8YamhuYWlobmxubGZhZK4rwdAgdj
 hATSE0tSs1NTC1KLYPqYODilGhgZL+X0TGiUX7KaZZ/B7p+vrtzc8vrcaYtNHS5F/0tTbx5M
 1xRNMkt+fNmHKVRszvyTj5a3OUpqv5xVOLN6783/tl/l61j5mN3lbZe8mp662kvjxdv4Yy3S
 +0LnOgds5/zSx9ZhuEbZ48+yLMembz+2xUanvd+qHM/TFO/gvkP7ZFC83OqDn1qVWIozEg21
 mIuKEwF2/z2tZgIAAA==
X-CMS-MailID: 20200205132846eucas1p1c9a1974934b43e8cfe74e0e670de3a23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205132846eucas1p1c9a1974934b43e8cfe74e0e670de3a23
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205132846eucas1p1c9a1974934b43e8cfe74e0e670de3a23
References: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205132846eucas1p1c9a1974934b43e8cfe74e0e670de3a23@eucas1p1.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, jan.kiszka@siemens.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 hw/arm/virt.c         | 110 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/virt.h |   5 +++
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f788fe2..ba35b21 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -71,6 +71,8 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/misc/memexpose/memexpose-core.h"
+#include "hw/misc/memexpose/memexpose-memregion.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -168,6 +170,8 @@ static MemMapEntry extended_memmap[] = {
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
     [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
+    [VIRT_HIGH_MEMEXPOSE_MMIO] =     { 0x0, 256 * MiB },
+    [VIRT_HIGH_MEMEXPOSE] =     { 0x0, 32 * GiB },
     /* Second PCIe window */
     [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
 };
@@ -179,6 +183,7 @@ static const int a15irqmap[] = {
     [VIRT_GPIO] = 7,
     [VIRT_SECURE_UART] = 8,
     [VIRT_ACPI_GED] = 9,
+    [VIRT_MEMEXPOSE] = 10,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
@@ -763,6 +768,67 @@ static void create_uart(const VirtMachineState *vms, int uart,
     g_free(nodename);
 }
 
+static void create_memexpose(const VirtMachineState *vms, MemoryRegion *mem,
+                             Error **errp)
+{
+    if (!vms->memexpose_size) {
+        error_setg(errp, "For memexpose support, memexpose_size "
+                         "needs to be greater than zero");
+        return;
+    }
+    if (!strcmp("", vms->memexpose_ep)) {
+        error_setg(errp, "For memexpose support, memexpose_ep "
+                         "needs to be non-empty");
+        return;
+    }
+
+    DeviceState *dev = qdev_create(NULL, "memexpose-memdev");
+
+    hwaddr base = vms->memmap[VIRT_HIGH_MEMEXPOSE].base;
+    hwaddr size = vms->memexpose_size;
+    hwaddr mmio_base = vms->memmap[VIRT_HIGH_MEMEXPOSE_MMIO].base;
+    hwaddr mmio_size = MEMEXPOSE_INTR_MEM_SIZE;
+    int irq = vms->irqmap[VIRT_MEMEXPOSE];
+
+    qdev_prop_set_uint64(dev, "shm_size", size);
+
+    char *intr_ep = g_strdup_printf("%s-intr", vms->memexpose_ep);
+    char *mem_ep = g_strdup_printf("%s-mem", vms->memexpose_ep);
+    Chardev *c = qemu_chr_find(mem_ep);
+    if (!c) {
+        error_setg(errp, "Failed to find memexpose memory endpoint");
+        return;
+    }
+    qdev_prop_set_chr(dev, "mem_chardev", c);
+    c = qemu_chr_find(intr_ep);
+    if (!c) {
+        error_setg(errp, "Failed to find memexpose interrupt endpoint");
+        return;
+    }
+    qdev_prop_set_chr(dev, "intr_chardev", c);
+    g_free(intr_ep);
+    g_free(mem_ep);
+
+    qdev_init_nofail(dev);
+    MemexposeMemdev *mdev = MEMEXPOSE_MEMDEV(dev);
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+    memory_region_add_subregion(mem, mmio_base, &mdev->intr.shmem);
+    memory_region_add_subregion(mem, base, &mdev->mem.shmem);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
+
+    char *nodename = g_strdup_printf("/memexpose@%" PRIx64, mmio_base);
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+                            "memexpose-memregion");
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+                                 2, mmio_base, 2, mmio_size,
+                                 2, base, 2, size);
+    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    g_free(nodename);
+}
+
 static void create_rtc(const VirtMachineState *vms)
 {
     char *nodename;
@@ -1572,7 +1638,6 @@ static void machvirt_init(MachineState *machine)
                            UINT64_MAX);
         memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
     }
-
     firmware_loaded = virt_firmware_init(vms, sysmem,
                                          secure_sysmem ?: sysmem);
 
@@ -1721,6 +1786,8 @@ static void machvirt_init(MachineState *machine)
     fdt_add_pmu_nodes(vms);
 
     create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
+    if (vms->memexpose_size > 0)
+        create_memexpose(vms, sysmem, &error_abort);
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
@@ -1849,6 +1916,32 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
     }
 }
 
+static char *virt_get_memexpose_ep(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    return g_strdup(vms->memexpose_ep);
+}
+
+static void virt_set_memexpose_ep(Object *obj, const char *value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    g_free(vms->memexpose_ep);
+    vms->memexpose_ep = g_strdup(value);
+}
+
+static char *virt_get_memexpose_size(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    return g_strdup_printf("%" PRIx64, vms->memexpose_size);
+}
+
+static void virt_set_memexpose_size(Object *obj, const char *value,
+                                    Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    parse_option_size("memexpose-size", value, &vms->memexpose_size, errp);
+}
+
 static char *virt_get_iommu(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -2103,6 +2196,21 @@ static void virt_instance_init(Object *obj)
                                     "Set GIC version. "
                                     "Valid values are 2, 3 and host", NULL);
 
+    /* Memexpose disabled by default */
+    vms->memexpose_ep = g_strdup("");
+    object_property_add_str(obj, "memexpose-ep", virt_get_memexpose_ep,
+                            virt_set_memexpose_ep, NULL);
+    object_property_set_description(obj, "memexpose-ep",
+                                    "Set path to memexpose server socket. "
+                                    "Sockets used for communication will be "
+                                    "<name>-intr and <name>-mem. Set to empty "
+                                    "to disable memexpose.", NULL);
+    vms->memexpose_size = 0;
+    object_property_add_str(obj, "memexpose-size", virt_get_memexpose_size,
+                            virt_set_memexpose_size, NULL);
+    object_property_set_description(obj, "memexpose-size",
+                                    "Size of the memexpose region to access.",
+                                    NULL);
     vms->highmem_ecam = !vmc->no_highmem_ecam;
 
     if (vmc->no_its) {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 71508bf..d0aeb67 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -76,6 +76,7 @@ enum {
     VIRT_PLATFORM_BUS,
     VIRT_GPIO,
     VIRT_SECURE_UART,
+    VIRT_MEMEXPOSE,
     VIRT_SECURE_MEM,
     VIRT_PCDIMM_ACPI,
     VIRT_ACPI_GED,
@@ -86,6 +87,8 @@ enum {
 enum {
     VIRT_HIGH_GIC_REDIST2 =  VIRT_LOWMEMMAP_LAST,
     VIRT_HIGH_PCIE_ECAM,
+    VIRT_HIGH_MEMEXPOSE_MMIO,
+    VIRT_HIGH_MEMEXPOSE,
     VIRT_HIGH_PCIE_MMIO,
 };
 
@@ -124,6 +127,8 @@ typedef struct {
     bool its;
     bool virt;
     int32_t gic_version;
+    char *memexpose_ep;
+    uint64_t memexpose_size;
     VirtIOMMUType iommu;
     struct arm_boot_info bootinfo;
     MemMapEntry *memmap;
-- 
2.7.4


