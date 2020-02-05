Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1C5C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789B321741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QbvMfeuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789B321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH7l-0005tJ-Kb
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3g-0000iV-OB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3e-0004wf-2U
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:20 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3d-0004oU-Po
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:18 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205093316euoutp01017670c7811583e057200bf344bf8625~wd8485UOW2287922879euoutp01a
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200205093316euoutp01017670c7811583e057200bf344bf8625~wd8485UOW2287922879euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580895196;
 bh=U1WBsYzE1zwNDyuAmKB3GlVSl401j/4uBIO1UaB6OLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QbvMfeuLkSVRnRtefSF8Nq6K30n3BY07Th0UNZhAWy73amBnCM0ZK2FtRPCup4l73
 6rk6vU0EYYAdGvB6PDqI86rJULKIWqp8HPNF9GWii2ju/7v4tYnurdnKlxNR9vtXG6
 Tf506g1FpBnpzYQicSJrxR/eKNSp7snNYpHJU9mU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205093316eucas1p14053f56abe04a156d36b4fd96dc28044~wd84vG7Lx3273232732eucas1p1V;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id BF.8A.60698.CDB8A3E5; Wed,  5
 Feb 2020 09:33:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200205093316eucas1p1983761c17c0b3b6d70070bd9e1d99e23~wd84U0-Bc3269332693eucas1p1U;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200205093316eusmtrp141fbf836f679b0a13965ab9e75500ea1~wd84UXhs51029010290eusmtrp1d;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-c5-5e3a8bdc5c4c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id FE.8D.08375.CDB8A3E5; Wed,  5
 Feb 2020 09:33:16 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093315eusmtip269ab0d5182838f9db242b28df4b28388~wd84AZ69J0075000750eusmtip2M;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 7/9] hw/misc/memexpose: Add memexpose memory region
 device
Date: Wed,  5 Feb 2020 10:33:03 +0100
Message-Id: <1580895185-24341-8-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7djPc7p3uq3iDPZuVbDYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBltN7+
 zlow27LiUvsv5gbGdr0uRk4OCQETiZbbO1m6GLk4hARWMEqsaDrFCuF8YZTYO/0ylPOZUWLJ
 5DXMMC19034xQiSWM0pc+HgToeXmvf3sIFVsAmoSO498ZgSxRQQkJX53nQbrZhbIkHg+qxvM
 FhYIlviwtJUFxGYRUJWYsGs2mM0rECDxbNYLFohtchI3z3WC1XMKBEps+vSRDWSZhMBlNolH
 J+YwQRS5SMyZtowRwhaWeHV8CzuELSNxenIP1KB6iZY7O5ggmjsYJfpWTmeDSFhLfNmwFKiI
 A+g6TYn1u/Qhwo4Spw61MoOEJQT4JG68FYS4n09i0rbpUGFeiY42IYhqPYnuJzeZYLYua3zE
 AlHiIXGmMQISPEsYJd4+28E+gVF+FsKuBYyMqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3
 MQLj//S/4193MO77k3SIUYCDUYmHN2CCZZwQa2JZcWXuIUYJDmYlEd7z+kAh3pTEyqrUovz4
 otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbBZJk4OKUaGGUsV/npV3keki/naGjSylv0
 QsnqjXJaoK7TfZ2Ga20upYsXb7y0ytz279u09U8lVBeuzrXeasW4+eF2e+2HVntnTKyz0BGt
 EGrhzPzJICJwTUadWzpJfJ9acLOU5FWV8mkdKSqPNcVTwlUT+hd33jXa/d4tKOFBjX24tKij
 qdDjPavKjfqUWIozEg21mIuKEwEBEaEP+wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xe7p3uq3iDPbtZLPYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehltN7+zlow27LiUvsv5gbGdr0uRk4O
 CQETib5pvxi7GLk4hASWMkr839fJDpGQkfhxeg0bhC0s8edaFxtE0SdGiV1vdrGCJNgE1CR2
 HvnMCGKLCEhK/O46zQxiMwtkSeycfZ8JxBYWCJT49m4zWA2LgKrEhF2zWUBsXoEAiWezXrBA
 LJCTuHmuE6yXE6h+06ePYIuFgGquff3KOoGRbwEjwypGkdTS4tz03GJDveLE3OLSvHS95Pzc
 TYzAcNx27OfmHYyXNgYfYhTgYFTi4V0xyTJOiDWxrLgy9xCjBAezkgjveX2gEG9KYmVValF+
 fFFpTmrxIUZToKMmMkuJJucDYyWvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFq
 EUwfEwenVAOj5eGiFIGKZ36/6kvSSmcymh3bklkS56P3RUDkBl9u/sqQF7uSTq/mLV/+N/t4
 2slXe7bv8jvauPSKAN9XB+2nupsEtvnb+n+9v6ic+3eGm02nINMr35DHB/iy063F/7M94Hwn
 WxWm5vdDXUi6N18uhj3qV4FsVbazjc8Hmc8Jmu+SnA7cu6PEUpyRaKjFXFScCADjm4dBXQIA
 AA==
X-CMS-MailID: 20200205093316eucas1p1983761c17c0b3b6d70070bd9e1d99e23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205093316eucas1p1983761c17c0b3b6d70070bd9e1d99e23
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205093316eucas1p1983761c17c0b3b6d70070bd9e1d99e23
References: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205093316eucas1p1983761c17c0b3b6d70070bd9e1d99e23@eucas1p1.samsung.com>
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


