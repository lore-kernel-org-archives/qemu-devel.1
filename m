Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2295BC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E227B2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E227B2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59054 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfjle-0007i5-6L
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 07:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53761)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hfjdG-000775-Ma
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hfjdF-0004Gi-31
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:29:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43142 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jonathan.cameron@huawei.com>)
 id 1hfjdA-000472-LJ; Tue, 25 Jun 2019 07:28:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 46FF97BF38E2C0BCB813;
 Tue, 25 Jun 2019 19:28:53 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Jun 2019 19:28:44 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Tue, 25 Jun 2019 19:27:51 +0800
Message-ID: <20190625112752.83188-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
References: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: [Qemu-devel] [RFC PATCH 6/7] misc: CCIX endpoint function
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jcm@redhat.com,
 linuxarm@huawei.com, Auger Eric <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This handles the case where a given function is not also a
PCIe topology upstream or downstream port.

This include, non function 0 functions on upstream ports and
any function on a device without a PCIe switch.  Note that
this doesn't exclude the possibility of this being the upstream
port of a CCIX layer switch.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/misc/Kconfig       |   5 ++
 hw/misc/Makefile.objs |   1 +
 hw/misc/ccix-ep.c     | 112 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 385e1b0cec..7aba167999 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -118,3 +118,8 @@ config AUX
     select I2C
=20
 source macio/Kconfig
+
+config CCIX_EP
+    bool
+    select CCIX_LIB
+   =20
\ No newline at end of file
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 77b9df9796..56a6cb3591 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_ISA_DEBUG) +=3D debugexit.o
 common-obj-$(CONFIG_SGA) +=3D sga.o
 common-obj-$(CONFIG_ISA_TESTDEV) +=3D pc-testdev.o
 common-obj-$(CONFIG_PCI_TESTDEV) +=3D pci-testdev.o
+common-obj-$(CONFIG_CCIX_EP) +=3D ccix-ep.o
 common-obj-$(CONFIG_EDU) +=3D edu.o
 common-obj-$(CONFIG_PCA9552) +=3D pca9552.o
=20
diff --git a/hw/misc/ccix-ep.c b/hw/misc/ccix-ep.c
new file mode 100644
index 0000000000..40a5b22dd8
--- /dev/null
+++ b/hw/misc/ccix-ep.c
@@ -0,0 +1,112 @@
+/*
+ * CCIX EP configuration space test device
+ *
+ * Copyright (c) 2019 Huawei
+ * Author: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
+ *
+ * Portions copied from pci-testdev.c
+ * Copyright (c) 2012 Red Hat Inc.
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "qemu/event_notifier.h"
+#include "sysemu/kvm.h"
+#include "hw/misc/ccix.h"
+#include "qemu/module.h"
+
+typedef struct CCIXEpState {
+    PCIDevice parent_obj;
+    struct CCIXState s;
+
+} CCIXEpState;
+
+#define TYPE_CCIX_EP "ccix-ep"
+#define CCIX_EP_DEV(obj) OBJECT_CHECK(CCIXEpState, (obj), TYPE_CCIX_EP)
+
+static void ccix_ep_write_config(PCIDevice *pci_dev, uint32_t addr,
+                                 uint32_t val_in, int l)
+{
+    CCIXEpState *s =3D CCIX_EP_DEV(pci_dev);
+
+    ccix_write_config(pci_dev, &s->s, addr, val_in, l);=20
+    pci_default_write_config(pci_dev, addr, val_in, l);
+}
+
+static void ccix_ep_realize(PCIDevice *pci_dev, Error **errp)
+{
+    CCIXEpState *s =3D CCIX_EP_DEV(pci_dev);
+    int offset =3D PCI_CONFIG_SPACE_SIZE;
+
+    if (PCI_FUNC(pci_dev->devfn) =3D=3D 0)
+        ccix_set_port(&s->s);
+    initialize_ccixstate(&s->s, pci_dev);
+    pci_dev->config_write =3D ccix_ep_write_config;
+    pcie_endpoint_cap_init(pci_dev, 0);
+    offset =3D ccix_add_prldvsec(pci_dev, &s->s, offset);
+    if (s->s.flags & (1 << CCIX_IS_PORT))
+        ccix_add_tdldvsec(pci_dev, offset);
+
+    pci_dev->config[PCI_INTERRUPT_PIN] =3D 0; /* no interrupt pin */
+    ccix_register(&s->s);
+}
+
+static Property ccix_props[] =3D {
+    DEFINE_PROP_STRING("ccix_device", CCIXEpState, s.ccix_dev_name),
+    DEFINE_PROP_BIT("primaryport", CCIXEpState, s.flags, PRIMARY_PORT_BI=
T, true),
+    DEFINE_PROP_UINT8("port_id", CCIXEpState, s.port_id, 0),
+    DEFINE_PROP_UINT8("num_links", CCIXEpState, s.num_links, 1),
+    DEFINE_PROP_UINT8("psam_entries", CCIXEpState, s.psam_entries, 0),
+    DEFINE_PROP_UINT8("request_agents", CCIXEpState, s.num_ras, 0),
+    DEFINE_PROP_UINT8("home_agents", CCIXEpState, s.num_has, 0),
+    DEFINE_PROP_UINT8("hsam_entries", CCIXEpState, s.hsam_entries, 0),
+    DEFINE_PROP_UINT8("rsam_entries", CCIXEpState, s.rsam_entries, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ccix_ep_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->realize =3D ccix_ep_realize;
+    k->vendor_id =3D PCI_VENDOR_ID_HUAWEI;
+    k->device_id =3D PCI_DEVICE_ID_HUAWEI_CCIX_EP;
+    k->revision =3D 0x00;
+    k->class_id =3D PCI_CLASS_OTHERS;
+    dc->desc =3D "CCIX EP Test Device";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->props =3D ccix_props;
+}
+
+static const TypeInfo ccix_ep_info =3D {
+    .name          =3D TYPE_CCIX_EP,
+    .parent        =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(CCIXEpState),
+    .class_init    =3D ccix_ep_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { },
+    },
+};
+
+static void ccix_register_types(void)
+{
+    type_register_static(&ccix_ep_info);
+}
+
+type_init(ccix_register_types)
--=20
2.20.1


