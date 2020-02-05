Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8085C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3233B21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YKR+sa4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3233B21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKnK-00049c-8L
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjZ-0007kS-S8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjX-0004rv-GE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:49 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46827)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjX-0004oM-AT
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205132846euoutp01a001c9d2e2e2603cea15d325565652cd~whKgHqAm12847728477euoutp01-
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200205132846euoutp01a001c9d2e2e2603cea15d325565652cd~whKgHqAm12847728477euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580909326;
 bh=U1WBsYzE1zwNDyuAmKB3GlVSl401j/4uBIO1UaB6OLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YKR+sa4DcHCAIyaS9HNzGjwUCMPAsrgO4HLJoGfF1YpWz2neuooowl/CL4+uAsz65
 DvYQ/ImP2E/tCsdcXXiFIA4x1ncGcK4LJH437CUQTzNi6LtwFjY0mIMqoZU/5Ud/yS
 BEUesL9P+U7+NnL/1ODw0aOPKenMrRqMk+UMnkZc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205132846eucas1p1b02220a89bd545f201d9147323dc0b47~whKfzwYyu0238102381eucas1p11;
 Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 3C.9F.60698.E03CA3E5; Wed,  5
 Feb 2020 13:28:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132845eucas1p201cc6584241b267b432c97b9e09b5e10~whKfa2B1E0490104901eucas1p2G;
 Wed,  5 Feb 2020 13:28:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200205132845eusmtrp25e59ca3c02fbb8f00c917a7b0b932004~whKfaW2zQ3040630406eusmtrp2G;
 Wed,  5 Feb 2020 13:28:45 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-2b-5e3ac30e0db4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.00.08375.D03CA3E5; Wed,  5
 Feb 2020 13:28:45 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132845eusmtip280ac55c977c7542849863ed895cd75ab~whKfDZyBr0228002280eusmtip2M;
 Wed,  5 Feb 2020 13:28:45 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 7/9] hw/misc/memexpose: Add memexpose memory region
 device
Date: Wed,  5 Feb 2020 14:28:35 +0100
Message-Id: <1580909317-23884-8-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djP87p8h63iDLauZLHYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRXDYpqTmZ
 ZalF+nYJXBmtt7+zFsy2rLjU/ou5gbFdr4uRk0NCwERixufbbF2MXBxCAisYJRb9vsUGkhAS
 +MIocXaaC0TiM6PEjvUfmGE65n9azg5RtJxRYv7zOogioIbNC9YygSTYBNQkdh75zAhiiwhI
 SvzuOs0MUsQs0MAo8ej6WaAEB4ewQLDEx3NFIDUsAqoSjyZPYQGxeQUCJPat2Qe1TE7i5rlO
 MJtTIFDi8rMprBDxx2wSixfyQNguEr0Tz0LVC0u8Or6FHcKWkfi/cz4ThF0v0XJnBxPIDRIC
 HYwSfSuns0EkrCW+bFjKAnIPs4CmxPpd+hBhR4mPt3eAhSUE+CRuvBUECTMDmZO2TWeGCPNK
 dLQJQVTrSXQ/uckEs3VZ4yMWCNtD4tS3OYyQ4FnCKPHj6F3WCYzysxCWLWBkXMUonlpanJue
 Wmycl1quV5yYW1yal66XnJ+7iRGYDk7/O/51B+O+P0mHGAU4GJV4eAMmWMYJsSaWFVfmHmKU
 4GBWEuE9rw8U4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1Oq
 gTG95Irfoys3zl7bd+llr16Xz6yzx1y9TkVruuws+Wsod27m2wXrH09WXnd6jfT8E4eL1loa
 Ktb7xJ2fZzhb/F95jEWK+O49XGH3bKwEPut72kVkmkm+vLnz5FKfQy0dW9YKXVS8wJspfkfJ
 7h7jSXenlsfn2E/P0GvdwTSBO5BZOYT3vdyTl9uVWIozEg21mIuKEwGxbXZEAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xe7q8h63iDP7NUrXYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRejZF+aUl
 qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmtt7+zFsy2rLjU
 /ou5gbFdr4uRk0NCwERi/qfl7F2MXBxCAksZJSbNb2CFSMhI/Di9hg3CFpb4c62LDaLoE6PE
 5FUnmUESbAJqEjuPfGYEsUUEJCV+d51mBiliFmhhlHj2pJ0JJCEsECjRtLabHcRmEVCVeDR5
 CguIzSsQILFvzT5miA1yEjfPdYLZnED1l59NAbtCCKjm9cQrzBMY+RYwMqxiFEktLc5Nzy02
 1CtOzC0uzUvXS87P3cQIDNJtx35u3sF4aWPwIUYBDkYlHt4VkyzjhFgTy4orcw8xSnAwK4nw
 ntcHCvGmJFZWpRblxxeV5qQWH2I0BTpqIrOUaHI+MILySuINTQ3NLSwNzY3Njc0slMR5OwQO
 xggJpCeWpGanphakFsH0MXFwSjUwSrYkn3CdwPBs6czWXcdOsO2ykfM/fYDVS+Fu2css/32F
 jy9pT1eRWdHr0xd2/cd/EdP9c/UdloiskVp53yPQ57yUtrJQ2ev8C5vuHdnYckb65xyJKT9K
 rb49s0oX93gq+VZ1/vvYFyoay3PNW4vPXm4sVTf7s91E2ChUcOty1up5fz69/yGarsRSnJFo
 qMVcVJwIAOS0d+toAgAA
X-CMS-MailID: 20200205132845eucas1p201cc6584241b267b432c97b9e09b5e10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205132845eucas1p201cc6584241b267b432c97b9e09b5e10
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205132845eucas1p201cc6584241b267b432c97b9e09b5e10
References: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205132845eucas1p201cc6584241b267b432c97b9e09b5e10@eucas1p2.samsung.com>
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
 MAINTAINERS                             |   2 +
 hw/misc/memexpose/Makefile.objs         |   1 +
 hw/misc/memexpose/memexpose-memregion.c | 142 ++++++++++++++++++++++++++++++++
 hw/misc/memexpose/memexpose-memregion.h |  41 +++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 hw/misc/memexpose/memexpose-memregion.c
 create mode 100644 hw/misc/memexpose/memexpose-memregion.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0517556..e016cff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1648,6 +1648,8 @@ F: hw/misc/memexpose/memexpose-core.c
 F: hw/misc/memexpose/memexpose-msg.h
 F: hw/misc/memexpose/memexpose-msg.c
 F: hw/misc/memexpose/memexpose-pci.c
+F: hw/misc/memexpose/memexpose-memregion.h
+F: hw/misc/memexpose/memexpose-memregion.c
 
 nvme
 M: Keith Busch <keith.busch@intel.com>
diff --git a/hw/misc/memexpose/Makefile.objs b/hw/misc/memexpose/Makefile.objs
index 05a2395..056bff3 100644
--- a/hw/misc/memexpose/Makefile.objs
+++ b/hw/misc/memexpose/Makefile.objs
@@ -1,3 +1,4 @@
 common-obj-y += memexpose-msg.o
 common-obj-y += memexpose-core.o
 common-obj-$(CONFIG_PCI) += memexpose-pci.o
+common-obj-y += memexpose-memregion.o
diff --git a/hw/misc/memexpose/memexpose-memregion.c b/hw/misc/memexpose/memexpose-memregion.c
new file mode 100644
index 0000000..fbdd966
--- /dev/null
+++ b/hw/misc/memexpose/memexpose-memregion.c
@@ -0,0 +1,142 @@
+/*
+ *  Memexpose ARM device
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
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "memexpose-core.h"
+#include "memexpose-memregion.h"
+
+static void memexpose_memdev_intr(void *opaque, int dir)
+{
+    MemexposeMemdev *dev = opaque;
+    if (dir) {
+        qemu_set_irq(dev->irq, 1);
+    } else {
+        qemu_set_irq(dev->irq, 0);
+    }
+}
+
+static int memexpose_memdev_enable(void *opaque)
+{
+    int ret;
+    MemexposeMemdev *s = opaque;
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
+static void memexpose_memdev_disable(void *opaque)
+{
+    MemexposeMemdev *s = opaque;
+
+    memexpose_intr_disable(&s->intr);
+    memexpose_mem_disable(&s->mem);
+}
+
+static void memexpose_memdev_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    MemexposeMemdev *mdev = MEMEXPOSE_MEMDEV(obj);
+    sysbus_init_mmio(sbd, &mdev->intr.shmem);
+    sysbus_init_irq(sbd, &mdev->irq);
+}
+
+static void memexpose_memdev_finalize(Object *obj)
+{
+}
+
+static void memexpose_memdev_realize(DeviceState *dev, Error **errp)
+{
+    MemexposeMemdev *mdev = MEMEXPOSE_MEMDEV(dev);
+    struct memexpose_intr_ops ops = {
+        .parent = dev,
+        .intr = memexpose_memdev_intr,
+        .enable = memexpose_memdev_enable,
+        .disable = memexpose_memdev_disable,
+    };
+
+    memexpose_intr_init(&mdev->intr, &ops, OBJECT(dev), &mdev->intr_chr, errp);
+    if (*errp) {
+        return;
+    }
+    memexpose_mem_init(&mdev->mem, OBJECT(dev),
+                       get_system_memory(),
+                       &mdev->mem_chr, 1, errp);
+    if (*errp) {
+        goto free_intr;
+    }
+    return;
+
+free_intr:
+    memexpose_intr_destroy(&mdev->intr);
+}
+
+static void memexpose_memdev_unrealize(DeviceState *dev, Error **errp)
+{
+    MemexposeMemdev *mdev = MEMEXPOSE_MEMDEV(dev);
+    memexpose_mem_destroy(&mdev->mem);
+    memexpose_intr_destroy(&mdev->intr);
+}
+
+static Property memexpose_memdev_properties[] = {
+    DEFINE_PROP_CHR("intr_chardev", MemexposeMemdev, intr_chr),
+    DEFINE_PROP_CHR("mem_chardev", MemexposeMemdev, mem_chr),
+    DEFINE_PROP_UINT64("shm_size", MemexposeMemdev, mem.shmem_size, 4096),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void memexpose_memdev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = memexpose_memdev_realize;
+    dc->unrealize = memexpose_memdev_unrealize;
+    device_class_set_props(dc, memexpose_memdev_properties);
+}
+
+static const TypeInfo memexpose_memdev_info = {
+    .name = TYPE_MEMEXPOSE_MEMDEV,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MemexposeMemdev),
+    .instance_init = memexpose_memdev_init,
+    .instance_finalize = memexpose_memdev_finalize,
+    .class_init = memexpose_memdev_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&memexpose_memdev_info);
+}
+
+type_init(register_types);
diff --git a/hw/misc/memexpose/memexpose-memregion.h b/hw/misc/memexpose/memexpose-memregion.h
new file mode 100644
index 0000000..7eddcbe
--- /dev/null
+++ b/hw/misc/memexpose/memexpose-memregion.h
@@ -0,0 +1,41 @@
+/*
+ *  Memexpose ARM device
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
+#ifndef _MEMEXPOSE_MEMDEV_H_
+#define _MEMEXPOSE_MEMDEV_H_
+
+#include "memexpose-core.h"
+#include "hw/sysbus.h"
+
+#define TYPE_MEMEXPOSE_MEMDEV "memexpose-memdev"
+#define MEMEXPOSE_MEMDEV(obj) \
+    OBJECT_CHECK(MemexposeMemdev, (obj), TYPE_MEMEXPOSE_MEMDEV)
+
+typedef struct MemexposeMemdev {
+    SysBusDevice dev;
+    MemexposeIntr intr;
+    MemexposeMem mem;
+    CharBackend intr_chr;
+    CharBackend mem_chr;
+    qemu_irq irq;
+} MemexposeMemdev;
+
+#endif /* _MEMEXPOSE_MEMDEV_H_ */
-- 
2.7.4


