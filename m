Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561EEC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1290A2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j4Jdmbob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1290A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH9v-0000oE-8C
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3h-0000jL-9F
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3f-00054S-4a
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:21 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3e-0004xZ-Pl
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205093317euoutp0215c1cc0fbe42fa57edf6c038e154c329~wd85oHY1f1429014290euoutp02h
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 09:33:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200205093317euoutp0215c1cc0fbe42fa57edf6c038e154c329~wd85oHY1f1429014290euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580895197;
 bh=2EdIg2dqS4is2/71/wtKDkcAjFpedYTyvl4ZZh7iwes=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j4JdmbobcWRIstHh552DYk5UOjm+m38MEJfxzJoQQdhEqZSd8vcBKKq779K7UrxN7
 jE31U+loVUg+8dy6WvkzE1d+Wk4+hmdOY5bJbogX9MtBKrlFTgPItdXYJhVyb4OyNP
 ijUcCMihRaGE5R06H8cTBX+hHyihPmrDz5SnyaKY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200205093317eucas1p25d1445ba03cefeea41c146eb62ce70a8~wd85Sacka1343613436eucas1p25;
 Wed,  5 Feb 2020 09:33:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 1F.39.60679.DDB8A3E5; Wed,  5
 Feb 2020 09:33:17 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093316eucas1p2b1b7b0cec7991ec53f26bd1444b7e596~wd85Adxar1341413414eucas1p29;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200205093316eusmtrp19f6f09f53f4e984eec28ec1f1649cc97~wd85ADF8l1029010290eusmtrp1k;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-9b-5e3a8bdd4b7b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.9A.07950.CDB8A3E5; Wed,  5
 Feb 2020 09:33:16 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093316eusmtip29c56a815c32c0e8bffd05bc6b6c4cde6~wd84uzYT00075700757eusmtip2M;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 9/9] hw/arm/virt: Hack in support for memexpose device
Date: Wed,  5 Feb 2020 10:33:05 +0100
Message-Id: <1580895185-24341-10-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djPc7p3u63iDD6e4bbYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBltO6Z
 x16w1q5iwWWuBsadul2MnBwSAiYSi67eZuli5OIQEljBKHHwfD8ThPOFUWLFt3VQzmdGiRuP
 trHBtGza85MZIrGcUeLe1TcsCC0dP8Cq2ATUJHYe+cwIYosISEr87jrNDGIzC2RIPJ/VDWYL
 C/hLnJr3DMxmEVCVuHV0Jlgvr0CgRNf080wQ2+Qkbp7rBKvhBIpv+vQR6orLbBJnJgVD2C4S
 y9/sZIawhSVeHd/CDmHLSJye3MMCYddLtNzZAfaOhEAHo0TfyulQg6wlvmxYClTEAXScpsT6
 XfoQYUeJDwuns4KEJQT4JG68FYQ4n09i0rbpzBBhXomONiGIaj2J7ic3mWC2Lmt8BLXVQ+Lm
 5XvQsFrCKLGu5z3LBEb5WQjLFjAyrmIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAiM/tP/
 jn/ZwbjrT9IhRgEORiUe3hWTLOOEWBPLiitzDzFKcDArifCe1wcK8aYkVlalFuXHF5XmpBYf
 YpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwMha/kg16Ep10F+xeW++rztyYGWWGedt
 jwcJnQ3cCjF/tS0c5Jcmyuv13GqK+nlk09NbSruf3XfTrLZnUymRtd3QXNb65kkZl4i79YaY
 JUUPtwk07cgNn3mzOvBpBsNC2yU/DVofyeSrrJn6q2rC/co3C17sFzl8MqbqRt8Ulmn1+xVq
 8ov2T1diKc5INNRiLipOBAD/2Jep+gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xe7p3uq3iDHa3mVnsufCYzWL/tn+s
 FnPOPGCxON67g8WBxePOtT1sHk+ubWbyOPhuD5PH+31X2QJYovRsivJLS1IVMvKLS2yVog0t
 jPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyWvfMYy9Ya1ex4DJXA+NO3S5GTg4J
 AROJTXt+MncxcnEICSxllJi/6QAbREJG4sfpNVC2sMSfa11sEEWfGCV+fr3NDJJgE1CT2Hnk
 MyOILSIgKfG76zRYnFkgS2Ln7PtMILawgK/E+Xc/2UFsFgFViVtHZ4IN5RUIlOiafp4JYoGc
 xM1znWC9nEDxTZ8+gtUICQRIXPv6lXUCI98CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsY
 gcG47djPLTsYu94FH2IU4GBU4uENmGAZJ8SaWFZcmXuIUYKDWUmE97w+UIg3JbGyKrUoP76o
 NCe1+BCjKdBRE5mlRJPzgZGSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQim
 j4mDU6qBcer0k60b6zQjD2Q1bz2ZOJsz2HGe3eY1qgGP3W+FBYpMqw//f3nFs5vCMVnLqta/
 5xdacX591pEdzieFBI0Mi7xLV2hdcvvyI01v50/3FxvFb1zYNq84tEqbs/bf+6ZNmX18E57x
 79sy8aL1+idZQekBy5zfXzn+ToX78xSn2RUeXDzpr4tE9iixFGckGmoxFxUnAgBycBdHXAIA
 AA==
X-CMS-MailID: 20200205093316eucas1p2b1b7b0cec7991ec53f26bd1444b7e596
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205093316eucas1p2b1b7b0cec7991ec53f26bd1444b7e596
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205093316eucas1p2b1b7b0cec7991ec53f26bd1444b7e596
References: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205093316eucas1p2b1b7b0cec7991ec53f26bd1444b7e596@eucas1p2.samsung.com>
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
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
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


