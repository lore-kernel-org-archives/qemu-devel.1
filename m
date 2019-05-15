Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E68C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6375020815
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6375020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42669 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR1DO-0007dR-GL
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 17:13:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0sB-0006cE-1A
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0s4-0001h1-R9
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0s4-0001dC-EL
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8B15A971A
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:51:22 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 283821820E;
	Wed, 15 May 2019 20:51:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:33 +0200
Message-Id: <1557953433-19663-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 15 May 2019 20:51:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 21/21] hw/net/ne2000: Extract the PCI device
 from the chipset common code
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The ne2000.c file contains functions common the the ISA and PCI
devices. To allow to build with one or another, extract the PCI
specific part into a new file.

This fix an issue where the NE2000_ISA Kconfig had to pull the
full PCI core objects.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190504123538.14952-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/Kconfig       |   7 ++-
 hw/net/Makefile.objs |   3 +-
 hw/net/ne2000-pci.c  | 132 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/net/ne2000.c      | 105 ----------------------------------------
 4 files changed, 139 insertions(+), 108 deletions(-)
 create mode 100644 hw/net/ne2000-pci.c

diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 7d7bbc5..4ef86dc 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -1,10 +1,14 @@
 config DP8393X
     bool
=20
+config NE2000_COMMON
+    bool
+
 config NE2000_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select NE2000_COMMON
=20
 config EEPRO100_PCI
     bool
@@ -51,8 +55,7 @@ config NE2000_ISA
     bool
     default y
     depends on ISA_BUS
-    depends on PCI # for NE2000State
-    select NE2000_PCI
+    select NE2000_COMMON
=20
 config OPENCORES_ETH
     bool
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index ea63715..9904273 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -1,8 +1,9 @@
 common-obj-$(CONFIG_DP8393X) +=3D dp8393x.o
 common-obj-$(CONFIG_XEN) +=3D xen_nic.o
+common-obj-$(CONFIG_NE2000_COMMON) +=3D ne2000.o
=20
 # PCI network cards
-common-obj-$(CONFIG_NE2000_PCI) +=3D ne2000.o
+common-obj-$(CONFIG_NE2000_PCI) +=3D ne2000-pci.o
 common-obj-$(CONFIG_EEPRO100_PCI) +=3D eepro100.o
 common-obj-$(CONFIG_PCNET_PCI) +=3D pcnet-pci.o
 common-obj-$(CONFIG_PCNET_COMMON) +=3D pcnet.o
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
new file mode 100644
index 0000000..cb05744
--- /dev/null
+++ b/hw/net/ne2000-pci.c
@@ -0,0 +1,132 @@
+/*
+ * QEMU NE2000 emulation (PCI bus)
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "ne2000.h"
+#include "sysemu/sysemu.h"
+
+typedef struct PCINE2000State {
+    PCIDevice dev;
+    NE2000State ne2000;
+} PCINE2000State;
+
+static const VMStateDescription vmstate_pci_ne2000 =3D {
+    .name =3D "ne2000",
+    .version_id =3D 3,
+    .minimum_version_id =3D 3,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, PCINE2000State),
+        VMSTATE_STRUCT(ne2000, PCINE2000State, 0, vmstate_ne2000, NE2000=
State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static NetClientInfo net_ne2000_info =3D {
+    .type =3D NET_CLIENT_DRIVER_NIC,
+    .size =3D sizeof(NICState),
+    .receive =3D ne2000_receive,
+};
+
+static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
+{
+    PCINE2000State *d =3D DO_UPCAST(PCINE2000State, dev, pci_dev);
+    NE2000State *s;
+    uint8_t *pci_conf;
+
+    pci_conf =3D d->dev.config;
+    pci_conf[PCI_INTERRUPT_PIN] =3D 1; /* interrupt pin A */
+
+    s =3D &d->ne2000;
+    ne2000_setup_io(s, DEVICE(pci_dev), 0x100);
+    pci_register_bar(&d->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
+    s->irq =3D pci_allocate_irq(&d->dev);
+
+    qemu_macaddr_default_if_unset(&s->c.macaddr);
+    ne2000_reset(s);
+
+    s->nic =3D qemu_new_nic(&net_ne2000_info, &s->c,
+                          object_get_typename(OBJECT(pci_dev)),
+                          pci_dev->qdev.id, s);
+    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
+}
+
+static void pci_ne2000_exit(PCIDevice *pci_dev)
+{
+    PCINE2000State *d =3D DO_UPCAST(PCINE2000State, dev, pci_dev);
+    NE2000State *s =3D &d->ne2000;
+
+    qemu_del_nic(s->nic);
+    qemu_free_irq(s->irq);
+}
+
+static void ne2000_instance_init(Object *obj)
+{
+    PCIDevice *pci_dev =3D PCI_DEVICE(obj);
+    PCINE2000State *d =3D DO_UPCAST(PCINE2000State, dev, pci_dev);
+    NE2000State *s =3D &d->ne2000;
+
+    device_add_bootindex_property(obj, &s->c.bootindex,
+                                  "bootindex", "/ethernet-phy@0",
+                                  &pci_dev->qdev, NULL);
+}
+
+static Property ne2000_properties[] =3D {
+    DEFINE_NIC_PROPERTIES(PCINE2000State, ne2000.c),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ne2000_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->realize =3D pci_ne2000_realize;
+    k->exit =3D pci_ne2000_exit;
+    k->romfile =3D "efi-ne2k_pci.rom",
+    k->vendor_id =3D PCI_VENDOR_ID_REALTEK;
+    k->device_id =3D PCI_DEVICE_ID_REALTEK_8029;
+    k->class_id =3D PCI_CLASS_NETWORK_ETHERNET;
+    dc->vmsd =3D &vmstate_pci_ne2000;
+    dc->props =3D ne2000_properties;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+}
+
+static const TypeInfo ne2000_info =3D {
+    .name          =3D "ne2k_pci",
+    .parent        =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(PCINE2000State),
+    .class_init    =3D ne2000_class_init,
+    .instance_init =3D ne2000_instance_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void ne2000_register_types(void)
+{
+    type_register_static(&ne2000_info);
+}
+
+type_init(ne2000_register_types)
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 037afc8..ca792d9 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "hw/pci/pci.h"
 #include "net/eth.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
@@ -118,11 +117,6 @@
 #define ENTSR_CDH 0x40	/* The collision detect "heartbeat" signal was lo=
st. */
 #define ENTSR_OWC 0x80  /* There was an out-of-window collision. */
=20
-typedef struct PCINE2000State {
-    PCIDevice dev;
-    NE2000State ne2000;
-} PCINE2000State;
-
 void ne2000_reset(NE2000State *s)
 {
     int i;
@@ -644,17 +638,6 @@ const VMStateDescription vmstate_ne2000 =3D {
     }
 };
=20
-static const VMStateDescription vmstate_pci_ne2000 =3D {
-    .name =3D "ne2000",
-    .version_id =3D 3,
-    .minimum_version_id =3D 3,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, PCINE2000State),
-        VMSTATE_STRUCT(ne2000, PCINE2000State, 0, vmstate_ne2000, NE2000=
State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static uint64_t ne2000_read(void *opaque, hwaddr addr,
                             unsigned size)
 {
@@ -711,91 +694,3 @@ void ne2000_setup_io(NE2000State *s, DeviceState *de=
v, unsigned size)
 {
     memory_region_init_io(&s->io, OBJECT(dev), &ne2000_ops, s, "ne2000",=
 size);
 }
-
-static NetClientInfo net_ne2000_info =3D {
-    .type =3D NET_CLIENT_DRIVER_NIC,
-    .size =3D sizeof(NICState),
-    .receive =3D ne2000_receive,
-};
-
-static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
-{
-    PCINE2000State *d =3D DO_UPCAST(PCINE2000State, dev, pci_dev);
-    NE2000State *s;
-    uint8_t *pci_conf;
-
-    pci_conf =3D d->dev.config;
-    pci_conf[PCI_INTERRUPT_PIN] =3D 1; /* interrupt pin A */
-
-    s =3D &d->ne2000;
-    ne2000_setup_io(s, DEVICE(pci_dev), 0x100);
-    pci_register_bar(&d->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
-    s->irq =3D pci_allocate_irq(&d->dev);
-
-    qemu_macaddr_default_if_unset(&s->c.macaddr);
-    ne2000_reset(s);
-
-    s->nic =3D qemu_new_nic(&net_ne2000_info, &s->c,
-                          object_get_typename(OBJECT(pci_dev)), pci_dev-=
>qdev.id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
-}
-
-static void pci_ne2000_exit(PCIDevice *pci_dev)
-{
-    PCINE2000State *d =3D DO_UPCAST(PCINE2000State, dev, pci_dev);
-    NE2000State *s =3D &d->ne2000;
-
-    qemu_del_nic(s->nic);
-    qemu_free_irq(s->irq);
-}
-
-static void ne2000_instance_init(Object *obj)
-{
-    PCIDevice *pci_dev =3D PCI_DEVICE(obj);
-    PCINE2000State *d =3D DO_UPCAST(PCINE2000State, dev, pci_dev);
-    NE2000State *s =3D &d->ne2000;
-
-    device_add_bootindex_property(obj, &s->c.bootindex,
-                                  "bootindex", "/ethernet-phy@0",
-                                  &pci_dev->qdev, NULL);
-}
-
-static Property ne2000_properties[] =3D {
-    DEFINE_NIC_PROPERTIES(PCINE2000State, ne2000.c),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void ne2000_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
-
-    k->realize =3D pci_ne2000_realize;
-    k->exit =3D pci_ne2000_exit;
-    k->romfile =3D "efi-ne2k_pci.rom",
-    k->vendor_id =3D PCI_VENDOR_ID_REALTEK;
-    k->device_id =3D PCI_DEVICE_ID_REALTEK_8029;
-    k->class_id =3D PCI_CLASS_NETWORK_ETHERNET;
-    dc->vmsd =3D &vmstate_pci_ne2000;
-    dc->props =3D ne2000_properties;
-    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
-}
-
-static const TypeInfo ne2000_info =3D {
-    .name          =3D "ne2k_pci",
-    .parent        =3D TYPE_PCI_DEVICE,
-    .instance_size =3D sizeof(PCINE2000State),
-    .class_init    =3D ne2000_class_init,
-    .instance_init =3D ne2000_instance_init,
-    .interfaces =3D (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
-static void ne2000_register_types(void)
-{
-    type_register_static(&ne2000_info);
-}
-
-type_init(ne2000_register_types)
--=20
1.8.3.1


