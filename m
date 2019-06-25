Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA636C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09CC20656
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09CC20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfji2-0003yG-Oh
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 07:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53682)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hfjdC-0006xk-FN
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hfjdA-0004A8-L3
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:28:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52884 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jonathan.cameron@huawei.com>)
 id 1hfjd6-0003xB-Dt; Tue, 25 Jun 2019 07:28:53 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4F9DDCE1D6C9A67333DF;
 Tue, 25 Jun 2019 19:28:48 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Jun 2019 19:28:39 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Tue, 25 Jun 2019 19:27:49 +0800
Message-ID: <20190625112752.83188-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
References: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: [Qemu-devel] [RFC PATCH 4/7] pci-bridge: CCIX capable PCIE/CCIX
 switch upstream port.
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

Note that these occur as function 0 within CCIX devices that
have many other elements in the PCIE topology.

This driver has around 100 lines of code copied directly from
the xio3130-upstream.c file. There are various options to
avoid this:

1) Expose the xio3130 functions so this module can just call them.
2) Create a library for the code that is shared.
3) Don't worry too much about it as it's likely they will diverge
   overtime as we extend the CCIX driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/Kconfig         |   5 +
 hw/pci-bridge/Makefile.objs   |   1 +
 hw/pci-bridge/ccix_upstream.c | 197 ++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)

diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
index a51ec716f5..f6ff8975a5 100644
--- a/hw/pci-bridge/Kconfig
+++ b/hw/pci-bridge/Kconfig
@@ -27,3 +27,8 @@ config DEC_PCI
=20
 config SIMBA
     bool
+
+config CCIX_SWITCH
+    default y if CCIX_EP
+    depends on PCI_EXPRESS && MSI_NONBROKEN
+    select CCIX_LIB
diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
index 47065f87d9..e266e39fed 100644
--- a/hw/pci-bridge/Makefile.objs
+++ b/hw/pci-bridge/Makefile.objs
@@ -8,3 +8,4 @@ common-obj-$(CONFIG_I82801B11) +=3D i82801b11.o
 common-obj-$(CONFIG_DEC_PCI) +=3D dec.o
 # Sun4u
 common-obj-$(CONFIG_SIMBA) +=3D simba.o
+common-obj-$(CONFIG_CCIX_SWITCH) +=3D ccix_upstream.o
diff --git a/hw/pci-bridge/ccix_upstream.c b/hw/pci-bridge/ccix_upstream.=
c
new file mode 100644
index 0000000000..f2b8441fba
--- /dev/null
+++ b/hw/pci-bridge/ccix_upstream.c
@@ -0,0 +1,197 @@
+/*
+ * ccix_upstream.c
+ * CCIX / pci express upstream port switch
+ *
+ * Copyright (c) 2019 Jonathan Camerom <Jonathan.Cameron@huawei.com>
+ *                    Huawei
+ * Based on: xio3130_downstream.c
+ * Copyright (c) 2010 Isaku Yamahata <yamahata at valinux co jp>
+ *                    VA Linux Systems Japan K.K.
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
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci_ids.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/misc/ccix.h"
+#include "qemu/module.h"
+
+/*
+ * As no CCIX devices have publically available specs, just use
+ * the xio3130 elements for the PCIe specific parts.
+ */
+#define XIO3130_REVISION                0x2
+#define XIO3130_MSI_OFFSET              0x70
+#define XIO3130_MSI_SUPPORTED_FLAGS     PCI_MSI_FLAGS_64BIT
+#define XIO3130_MSI_NR_VECTOR           1
+#define XIO3130_SSVID_OFFSET            0x80
+#define XIO3130_SSVID_SVID              0
+#define XIO3130_SSVID_SSID              0
+#define XIO3130_EXP_OFFSET              0x90
+#define XIO3130_AER_OFFSET              0x100
+
+#define TYPE_CCIX_UP_PORT "ccix-upstream-port"
+
+#define CCIX_UP_DEV(obj) OBJECT_CHECK(CCIXUpPortState, (obj), TYPE_CCIX_=
UP_PORT)
+
+typedef struct CCIXUpPortState {
+    PCIEPort parent_obj;
+    struct CCIXState s;
+} CCIXUpPortState;
+
+static void ccix_upstream_port_write_config(PCIDevice *d, uint32_t addre=
ss,
+                                            uint32_t val, int len)
+{
+    CCIXUpPortState *s =3D CCIX_UP_DEV(d);
+    pci_bridge_write_config(d, address, val, len);
+    pcie_cap_flr_write_config(d, address, val, len);
+    pcie_aer_write_config(d, address, val, len);
+    ccix_write_config(d, &s->s, address, val, len);
+}
+
+static void xio3130_upstream_reset(DeviceState *qdev)
+{
+    PCIDevice *d =3D PCI_DEVICE(qdev);
+
+    pci_bridge_reset(qdev);
+    pcie_cap_deverr_reset(d);
+}
+
+static void ccix_upstream_port_realize(PCIDevice *d, Error **errp)
+{
+    CCIXUpPortState *s =3D CCIX_UP_DEV(d);
+    PCIEPort *p =3D PCIE_PORT(d);
+    uint32_t offset =3D 0x180;
+    int rc;
+
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pcie_port_init_reg(d);
+
+    rc =3D msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
+                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
+                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
+                  errp);
+    if (rc < 0) {
+        assert(rc =3D=3D -ENOTSUP);
+        goto err_bridge;
+    }
+
+    rc =3D pci_bridge_ssvid_init(d, XIO3130_SSVID_OFFSET,
+                               XIO3130_SSVID_SVID, XIO3130_SSVID_SSID,
+                               errp);
+    if (rc < 0) {
+        goto err_bridge;
+    }
+
+    rc =3D pcie_cap_init(d, XIO3130_EXP_OFFSET, PCI_EXP_TYPE_UPSTREAM,
+                       p->port, errp);
+    if (rc < 0) {
+        goto err_msi;
+    }
+    pcie_cap_flr_init(d);
+    pcie_cap_deverr_init(d);
+
+    rc =3D pcie_aer_init(d, PCI_ERR_VER, XIO3130_AER_OFFSET,
+                       PCI_ERR_SIZEOF, errp);
+    if (rc < 0) {
+        goto err;
+    }
+    initialize_ccixstate(&s->s, d);
+    ccix_set_port(&s->s);
+    offset =3D ccix_add_prldvsec(d, &s->s, offset);
+    ccix_register(&s->s);
+
+    return;
+
+err:
+    pcie_cap_exit(d);
+err_msi:
+    msi_uninit(d);
+err_bridge:
+    pci_bridge_exitfn(d);
+}
+
+static Property ccix_props[] =3D {
+    DEFINE_PROP_STRING("ccix_device", CCIXUpPortState, s.ccix_dev_name),
+    DEFINE_PROP_BIT("primaryport", CCIXUpPortState, s.flags, PRIMARY_POR=
T_BIT, true),
+    DEFINE_PROP_UINT8("port_id", CCIXUpPortState, s.port_id, 0),
+    DEFINE_PROP_UINT8("num_links", CCIXUpPortState, s.num_links, 1),
+    DEFINE_PROP_UINT8("psam_entries", CCIXUpPortState, s.psam_entries, 0=
),
+    DEFINE_PROP_UINT8("request_agents", CCIXUpPortState, s.num_ras, 0),
+    DEFINE_PROP_UINT8("home_agents", CCIXUpPortState, s.num_has, 0),
+    DEFINE_PROP_UINT8("hsam_entries", CCIXUpPortState, s.hsam_entries, 0=
),
+    DEFINE_PROP_UINT8("rsam_entries", CCIXUpPortState, s.rsam_entries, 0=
),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ccix_upstream_exitfn(PCIDevice *d)
+{
+    pcie_aer_exit(d);
+    pcie_cap_exit(d);
+    msi_uninit(d);
+    pci_bridge_exitfn(d);
+}
+
+static const VMStateDescription vmstate_ccix_upstream =3D {
+    .name =3D "ccix-upstream-port",
+    .priority =3D MIG_PRI_PCI_BUS,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj, PCIEPort),
+        VMSTATE_STRUCT(parent_obj.parent_obj.exp.aer_log, PCIEPort, 0,
+                       vmstate_pcie_aer_log, PCIEAERLog),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void ccix_upstream_port_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->is_bridge =3D true;
+    k->config_write =3D ccix_upstream_port_write_config;
+    k->realize =3D ccix_upstream_port_realize;
+    k->exit =3D ccix_upstream_exitfn;
+    k->vendor_id =3D PCI_VENDOR_ID_HUAWEI;
+    k->device_id =3D PCI_DEVICE_ID_HUAWEI_CCIX_UP;
+    k->revision =3D 1;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->desc =3D "CCIX / PCIe switch upstream port";
+    dc->props =3D ccix_props;
+    dc->reset =3D xio3130_upstream_reset;
+    dc->vmsd =3D &vmstate_ccix_upstream;
+}
+
+static const TypeInfo ccix_upstream_port_info =3D {
+    .name =3D TYPE_CCIX_UP_PORT,
+    .parent =3D TYPE_PCIE_PORT,
+    .class_init =3D ccix_upstream_port_init,
+    .instance_size =3D sizeof(CCIXUpPortState),
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void ccix_upstream_register_types(void)
+{
+    type_register_static(&ccix_upstream_port_info);
+}
+
+type_init(ccix_upstream_register_types)
--=20
2.20.1


