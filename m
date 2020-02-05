Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726A5C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCB620661
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e6Y3oBdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCB620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH6f-0004Kp-AB
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3g-0000ht-BT
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3e-0004wk-2d
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:20 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3d-0004lr-PW
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205093316euoutp01ebfdfdc03836fa6a6b1acb6d0039205d~wd84mgcjD2281022810euoutp01i
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200205093316euoutp01ebfdfdc03836fa6a6b1acb6d0039205d~wd84mgcjD2281022810euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580895196;
 bh=2F49GVD50FFc7SohifeVm5zou/I4maN8aL4yyICPULM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e6Y3oBddYo1sK7yoqG+xm+ImvKPn7wTVNss2r7Z8Bf7kcGpUmUAC9knr/6jOI72++
 h7wL6Jtwlf5Zf/BEO6Cyh5+Qp/axC6/Up4pwLcVTYBB9OHjaZXBWZQMSQmrjxpXBvt
 ZgVqre592nB72ia5UIPDzAS9sKg8yhJH+ZPCuUvE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205093316eucas1p15f8292c186b65b72173d4ae737a3d5f2~wd84R7axw3063030630eucas1p1e;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id CE.19.61286.CDB8A3E5; Wed,  5
 Feb 2020 09:33:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200205093315eucas1p1d39671ae41a5918bf60f10e110d4e938~wd84C8hIr3269132691eucas1p1b;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200205093315eusmtrp1b256f0e25641520329abc3226a864010~wd84CchSn1029010290eusmtrp1b;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-58-5e3a8bdcd28f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id AE.8D.08375.BDB8A3E5; Wed,  5
 Feb 2020 09:33:15 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093315eusmtip2f87bfe96c9baf2725353fa028c5069ab~wd83wLOR60077300773eusmtip2K;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 6/9] hw/misc/memexpose: Add memexpose pci device
Date: Wed,  5 Feb 2020 10:33:02 +0100
Message-Id: <1580895185-24341-7-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7djPc7p3uq3iDC6v5bDYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBlvDl0
 kbXgpXXFs483GBsYj+p1MXJySAiYSMyeeoEZxBYSWMEo0TfDoouRC8j+wigxbcMeRgjnM6PE
 urPtQFUcYB33m/wh4suBitadZ4LruHLtERvIKDYBNYmdRz4zgtgiApISv7tOg61gFsiQeD6r
 G8wWFnCXmPv0DSPIUBYBVYnHv+NBwrwCARJfN/QyQ1wnJ3HzXCeYzSkQKLHp00c2kF0SApfZ
 JD4dewdV5CLx68clVghbWOLV8S3sELaMxOnJPSwQdr1Ey50dTBDNHUBvrpzOBpGwlviyYSkL
 yBHMApoS63fpQ4QdJWbPvgn1MJ/EjbeCEOfzSUzaNh0qzCvR0SYEUa0n0f3kJhPM1mWNj6C2
 ekg8OneZGRI8SxglFvz7wzqBUX4WwrIFjIyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcx
 AmP/9L/jn3Ywfr2UdIhRgINRiYd3xSTLOCHWxLLiytxDjBIczEoivOf1gUK8KYmVValF+fFF
 pTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUw8sok3JixqEzMQOeYv827ZW/X
 bhb3KTx/+lvDUv8NV3qLTXub12uZrROO/dGitP7i24vuXyU2aeyTFS1a9eXIGtmo6H6PQJP2
 GF8p2cNPePoWJl++P4lTmjvW23bpv1WPJS1XPrF3bXjF4KlixBUr+fO2s9411l/bjyjfsDfo
 uLj6fsTWxucGSizFGYmGWsxFxYkAr3GlnPkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsVy+t/xe7q3u63iDLZ9MrLYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlvDl0kbXgpXXFs483GBsYj+p1MXJw
 SAiYSNxv8u9i5OIQEljKKPGl4T9LFyMnUFxG4sfpNWwQtrDEn2tdYLaQwCdGiXV9SSA2m4Ca
 xM4jnxlBbBEBSYnfXaeZQWxmgSyJnbPvM4HYwgLuEnOfvmEE2cUioCrx+Hc8SJhXIEDi64Ze
 ZojxchI3z3WC2ZwCgRKbPn2EWhUgce3rV9YJjHwLGBlWMYqklhbnpucWG+oVJ+YWl+al6yXn
 525iBAbitmM/N+9gvLQx+BCjAAejEg/vikmWcUKsiWXFlbmHGCU4mJVEeM/rA4V4UxIrq1KL
 8uOLSnNSiw8xmgLdNJFZSjQ5HxgleSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1ML
 Uotg+pg4OKUaGPVj5qVWsVlxeQh6/w6czPmII7RA4dTj67wOWosKZrbenXIt5OYZHvV5hyws
 HjsycSzblCnybvX+T40rK6umre7+G7+wuVf+oe+39mBd07frY2az8NovuHqvXfh7mV/Xmx7R
 qYyyfpNZPVh3FlpcjH2xPPFv+KNP7CXebtOd3NTKzjw2Uy90V2Ipzkg01GIuKk4EAPZxshZa
 AgAA
X-CMS-MailID: 20200205093315eucas1p1d39671ae41a5918bf60f10e110d4e938
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205093315eucas1p1d39671ae41a5918bf60f10e110d4e938
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205093315eucas1p1d39671ae41a5918bf60f10e110d4e938
References: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205093315eucas1p1d39671ae41a5918bf60f10e110d4e938@eucas1p1.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
 MAINTAINERS                       |   1 +
 hw/misc/memexpose/Makefile.objs   |   1 +
 hw/misc/memexpose/memexpose-pci.c | 218 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 hw/misc/memexpose/memexpose-pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c98fef..0517556 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1647,6 +1647,7 @@ F: hw/misc/memexpose/memexpose-core.h
 F: hw/misc/memexpose/memexpose-core.c
 F: hw/misc/memexpose/memexpose-msg.h
 F: hw/misc/memexpose/memexpose-msg.c
+F: hw/misc/memexpose/memexpose-pci.c
 
 nvme
 M: Keith Busch <keith.busch@intel.com>
diff --git a/hw/misc/memexpose/Makefile.objs b/hw/misc/memexpose/Makefile.objs
index f405fe7..05a2395 100644
--- a/hw/misc/memexpose/Makefile.objs
+++ b/hw/misc/memexpose/Makefile.objs
@@ -1,2 +1,3 @@
 common-obj-y += memexpose-msg.o
 common-obj-y += memexpose-core.o
+common-obj-$(CONFIG_PCI) += memexpose-pci.o
diff --git a/hw/misc/memexpose/memexpose-pci.c b/hw/misc/memexpose/memexpose-pci.c
new file mode 100644
index 0000000..7372651
--- /dev/null
+++ b/hw/misc/memexpose/memexpose-pci.c
@@ -0,0 +1,218 @@
+/*
+ *  Memexpose PCI device
+ *
+ *  Copyright (C) 2020 Samsung Electronics Co Ltd.
+ *    Igor Kotrasinski, <i.kotrasinsk@partner.samsung.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hw/qdev-properties.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "memexpose-core.h"
+
+#define PCI_VENDOR_ID_MEMEXPOSE            PCI_VENDOR_ID_REDHAT_QUMRANET
+#define TYPE_MEMEXPOSE_PCI "memexpose-pci"
+#define PCI_DEVICE_ID_MEMEXPOSE     0x1111
+#define MEMEXPOSE_PCI(obj) \
+    OBJECT_CHECK(MemexposePCIState, (obj), TYPE_MEMEXPOSE_PCI)
+
+typedef struct MemexposePCIState {
+    PCIDevice parent_obj;
+
+    CharBackend intr_chr;
+    CharBackend mem_chr;
+
+    MemexposeIntr intr;
+    uint32_t intr_status;
+    MemexposeMem mem;
+} MemexposePCIState;
+
+static void raise_irq(MemexposePCIState *s)
+{
+    s->intr_status |= 1;
+    if (msi_enabled(&s->parent_obj)) {
+        msi_notify(&s->parent_obj, 0);
+    } else {
+        pci_set_irq(&s->parent_obj, 1);
+    }
+}
+
+static void lower_irq(MemexposePCIState *s)
+{
+    s->intr_status &= (~1);
+    if (!s->intr_status && !msi_enabled(&s->parent_obj)) {
+        pci_set_irq(&s->parent_obj, 0);
+    }
+}
+
+static void handle_irq(void *opaque, int dir)
+{
+    MemexposePCIState *s = opaque;
+    if (dir) {
+        raise_irq(s);
+    } else {
+        lower_irq(s);
+    }
+}
+
+static int memexpose_enable(void *opaque)
+{
+    int ret;
+    MemexposePCIState *s = opaque;
+
+    ret = memexpose_intr_enable(&s->intr);
+    if (ret) {
+        return ret;
+    }
+
+    ret = memexpose_mem_enable(&s->mem);
+    if (ret) {
+        memexpose_intr_disable(&s->intr);
+        return ret;
+    }
+
+    return 0;
+}
+
+static void memexpose_disable(void *opaque)
+{
+    MemexposePCIState *s = opaque;
+
+    memexpose_intr_disable(&s->intr);
+    memexpose_mem_disable(&s->mem);
+}
+
+static void memexpose_pci_intr_init(PCIDevice *dev, Error **errp)
+{
+    MemexposePCIState *s = MEMEXPOSE_PCI(dev);
+    struct memexpose_intr_ops ops;
+    ops.intr = handle_irq;
+    ops.enable = memexpose_enable;
+    ops.disable = memexpose_disable;
+    ops.parent = s;
+
+    memexpose_intr_init(&s->intr, &ops, OBJECT(dev), &s->intr_chr, errp);
+    if (*errp) {
+        return;
+    }
+
+    s->intr_status = 0;
+    uint8_t *pci_conf;
+    pci_conf = dev->config;
+    pci_conf[PCI_COMMAND] = PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
+    pci_config_set_interrupt_pin(pci_conf, 1);
+    if (msi_init(dev, 0, 1, true, false, errp)) {
+        error_setg(errp, "Failed to initialize memexpose PCI interrupts");
+        memexpose_intr_destroy(&s->intr);
+        return;
+    }
+
+    /* region for registers*/
+    pci_register_bar(dev, 0,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY,
+                     &s->intr.shmem);
+    MEMEXPOSE_DPRINTF("Initialized bar.\n");
+}
+
+static void memexpose_pci_intr_exit(PCIDevice *dev)
+{
+    MemexposePCIState *s = MEMEXPOSE_PCI(dev);
+    msi_uninit(dev);
+    memexpose_intr_destroy(&s->intr);
+}
+
+static void memexpose_pci_realize(PCIDevice *dev, Error **errp)
+{
+    MemexposePCIState *s = MEMEXPOSE_PCI(dev);
+    memexpose_pci_intr_init(dev, errp);
+    if (*errp) {
+        return;
+    }
+
+    Chardev *chrd = qemu_chr_fe_get_driver(&s->mem_chr);
+    assert(chrd);
+    MEMEXPOSE_DPRINTF("Memexpose endpoint at %s!\n",
+                      chrd->filename);
+    memexpose_mem_init(&s->mem, OBJECT(dev),
+                       get_system_memory(),
+                       &s->mem_chr, 0, errp);
+    if (*errp) {
+        memexpose_pci_intr_exit(dev);
+        return;
+    }
+
+    pci_register_bar(dev, 1,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &s->mem.shmem);
+    MEMEXPOSE_DPRINTF("Initialized second bar.\n");
+}
+
+static void memexpose_pci_exit(PCIDevice *dev)
+{
+    MemexposePCIState *s = MEMEXPOSE_PCI(dev);
+    memexpose_mem_destroy(&s->mem);
+    memexpose_pci_intr_exit(dev);
+}
+
+static Property memexpose_pci_properties[] = {
+    DEFINE_PROP_CHR("mem_chardev", MemexposePCIState, mem_chr),
+    DEFINE_PROP_CHR("intr_chardev", MemexposePCIState, intr_chr),
+    DEFINE_PROP_UINT64("shm_size", MemexposePCIState, mem.shmem_size, 4096),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void memexpose_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = memexpose_pci_realize;
+    k->exit = memexpose_pci_exit;
+    k->vendor_id = PCI_VENDOR_ID_MEMEXPOSE;
+    k->device_id = PCI_DEVICE_ID_MEMEXPOSE;
+    k->class_id = PCI_CLASS_MEMORY_RAM;
+    k->revision = 1;
+    device_class_set_props(dc, memexpose_pci_properties);
+}
+
+static const TypeInfo memexpose_pci_info = {
+    .name          = TYPE_MEMEXPOSE_PCI,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(MemexposePCIState),
+    .class_init    = memexpose_pci_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+
+static void memexpose_pci_register_types(void)
+{
+    type_register_static(&memexpose_pci_info);
+}
+
+type_init(memexpose_pci_register_types)
-- 
2.7.4


