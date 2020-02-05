Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7F6C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCA5217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eifd8BSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCA5217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKkp-00015u-Bh
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjZ-0007kQ-Sc
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjX-0004qC-3F
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:49 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46819)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjW-0004mb-TD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205132846euoutp01e9433e61731075f518fcda3ca88b7d1a~whKfvnxPN2833328333euoutp01Q
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200205132846euoutp01e9433e61731075f518fcda3ca88b7d1a~whKfvnxPN2833328333euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580909326;
 bh=2F49GVD50FFc7SohifeVm5zou/I4maN8aL4yyICPULM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eifd8BScW9EcdIO8+4a3OTXN+T77aTcRUO0ICfIbg3F0r3mEzRzkr3lwMXgJP7PIA
 5ptUS9qkaeWk8QWB74I8un/3WzAEiqrkp7rPqtpMzorfdJJVX8c/RKosvLReCdC3n/
 41JvrzhT1GE0eiysx9VQEN9Y/9ICQ6s75MW47Mvc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200205132845eucas1p203c5e2013665e3ef26ac8d1094b6318e~whKfSh4mI0492104921eucas1p2E;
 Wed,  5 Feb 2020 13:28:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.1E.61286.D03CA3E5; Wed,  5
 Feb 2020 13:28:45 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132845eucas1p2940f5b7b185369ce73511e613aa575cc~whKfDHwdz0081500815eucas1p2Y;
 Wed,  5 Feb 2020 13:28:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200205132845eusmtrp270f9778a79018f4e78f14e603bb0399b~whKfCitR_3040630406eusmtrp2E;
 Wed,  5 Feb 2020 13:28:45 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-a5-5e3ac30dc818
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 33.00.08375.D03CA3E5; Wed,  5
 Feb 2020 13:28:45 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132844eusmtip2101e5d1d53218f847bd59e0e878de78f~whKerVnwz0172901729eusmtip2b;
 Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 6/9] hw/misc/memexpose: Add memexpose pci device
Date: Wed,  5 Feb 2020 14:28:34 +0100
Message-Id: <1580909317-23884-7-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djP87q8h63iDFr75Cz2XHjMZnHv5k1m
 i/3b/rFazDnzgMXieO8OFgdWjzvX9rB5PLm2mcnj4Ls9TB7v911l89h+chJTAGsUl01Kak5m
 WWqRvl0CV8abQxdZC15aVzz7eIOxgfGoXhcjJ4eEgInE/8PdbF2MXBxCAisYJeZdfMkK4Xxh
 lJi1+yQjhPOZUWLp0TfMMC1zfx1jh0gsZ5RoOfGGBa7l0ZJ+JpAqNgE1iZ1HPjOC2CICkhK/
 u04zgxQxCzQAFV0/C5Tg4BAWcJfY8c0NpIZFQFXiV+ceFpAwr0CAxKWHFRDL5CRunusEW8wp
 EChx+dkUsPMkBJ6zSfTdOMMEUeQi0de4hxXCFpZ4dXwLO4QtI/F/53yomnqJljs7mCCaOxgl
 +lZOZ4NIWEt82bAUbDGzgKbE+l36EGFHiW2rNrGBhCUE+CRuvBUECTMDmZO2TWeGCPNKdLQJ
 QVTrSXQ/uckEs3VZ4yMWCNtD4sf3qcyQ4FnCKHFu32e2CYzysxCWLWBkXMUonlpanJueWmyY
 l1quV5yYW1yal66XnJ+7iRGYEk7/O/5pB+PXS0mHGAU4GJV4eFdMsowTYk0sK67MPcQowcGs
 JMJ7Xh8oxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dUA6Oa
 CptkWmPP7vaseS5L0mJbF39bJSX/jVlG0+vnS8283oXrSq8EiLnucQ0V5XuzwHXHcRmuTTbC
 m2y4Jh+y75PVcxaUnXdU5K0qk97lr5XXPeN0p3jG7Irc/3vFxy8HNNQ9Z9ho1b6bt6PBntuq
 UZkp4vqt4xFfhLayhcVNu37EkrHdUkmhXImlOCPRUIu5qDgRANmdSoUFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsVy+t/xe7q8h63iDM5e5rPYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRejZF+aUl
 qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlvDl1kLXhpXfHs
 4w3GBsajel2MnBwSAiYSc38dY+9i5OIQEljKKPH38XpmiISMxI/Ta9ggbGGJP9e62CCKPjFK
 XD/3mhUkwSagJrHzyGdGEFtEQFLid9dpZpAiZoEWRolnT9qZuhg5OIQF3CV2fHMDqWERUJX4
 1bmHBSTMKxAgcelhBcR8OYmb5zrB9nIKBEpcfjYFbLwQUMnriVeYJzDyLWBkWMUoklpanJue
 W2yoV5yYW1yal66XnJ+7iREYoNuO/dy8g/HSxuBDjAIcjEo8vCsmWcYJsSaWFVfmHmKU4GBW
 EuE9rw8U4k1JrKxKLcqPLyrNSS0+xGgKdNNEZinR5Hxg9OSVxBuaGppbWBqaG5sbm1koifN2
 CByMERJITyxJzU5NLUgtgulj4uCUamAUmjx9wem9KlEiqiX/05ve2Jp/vb6rY+1B9f6b9WZb
 VzurTu+ft1F7xs0Yn5D2V+I2k4UD98z9l/Ob4ZFflBOL17yUQ8GNgb+PtKpulpAMuPrgvYa3
 HNNvm+uuRbWG+87zXpFVeWPXtZNFKHzG4+B9P9lOhq3LPONkXX4xw/9xdcGZ8vh6VXslluKM
 REMt5qLiRAAnLFUtZgIAAA==
X-CMS-MailID: 20200205132845eucas1p2940f5b7b185369ce73511e613aa575cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205132845eucas1p2940f5b7b185369ce73511e613aa575cc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205132845eucas1p2940f5b7b185369ce73511e613aa575cc
References: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205132845eucas1p2940f5b7b185369ce73511e613aa575cc@eucas1p2.samsung.com>
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
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, jan.kiszka@siemens.com,
 pbonzini@redhat.com
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


