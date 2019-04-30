Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A9FC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842532075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842532075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLN2C-0000DF-JU
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 03:18:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLMzR-0006SZ-3c
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLMzO-0004Wa-8J
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:15:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hLMyv-0004KI-9F; Tue, 30 Apr 2019 03:15:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D36273086227;
	Tue, 30 Apr 2019 07:15:08 +0000 (UTC)
Received: from thuth.com (ovpn-116-190.ams2.redhat.com [10.36.116.190])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC02B1001DD2;
	Tue, 30 Apr 2019 07:14:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Date: Tue, 30 Apr 2019 09:13:39 +0200
Message-Id: <20190430071405.16714-5-thuth@redhat.com>
In-Reply-To: <20190430071405.16714-1-thuth@redhat.com>
References: <20190430071405.16714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 30 Apr 2019 07:15:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 04/30] hw/usb/hcd-ohci: Move PCI-related
 code into a separate file
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Rob Herring <robh@kernel.org>, qemu-block@nongnu.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
	Jan Kiszka <jan.kiszka@web.de>, Cedric Le Goater <clg@kaod.org>,
	John Snow <jsnow@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Andrew Jeffery <andrew@aj.id.au>, Peter Chubb <peter.chubb@nicta.com.au>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430071339.kIOPzg_fqww0706dexxZ1i7_Fb_yH-92cFIusN-02lw@z>

Some machines (like the pxa2xx-based ARM machines) only have a sysbus
OHCI controller, but no PCI. With the new Kconfig-style build system,
it will soon be possible to create QEMU binaries that only contain
such PCI-less machines. However, the two OHCI controllers, for sysbus
and for PCI, are currently both located in one file, so the PCI code
is still required for linking here. Move the OHCI-PCI device code
into a separate file, so that it is possible to use the sysbus OHCI
device also without the PCI dependency.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/sh4/Kconfig        |   2 +-
 hw/usb/Kconfig        |   6 +-
 hw/usb/Makefile.objs  |   1 +
 hw/usb/hcd-ohci-pci.c | 163 +++++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.c     | 216 ++----------------------------------------
 hw/usb/hcd-ohci.h     | 104 ++++++++++++++++++++
 6 files changed, 284 insertions(+), 208 deletions(-)
 create mode 100644 hw/usb/hcd-ohci-pci.c
 create mode 100644 hw/usb/hcd-ohci.h

diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
index 593662d28a..4cbce3a0ed 100644
--- a/hw/sh4/Kconfig
+++ b/hw/sh4/Kconfig
@@ -6,7 +6,7 @@ config R2D
     select I82378 if TEST_DEVICES
     select IDE_MMIO
     select PFLASH_CFI02
-    select USB_OHCI
+    select USB_OHCI_PCI
     select PCI
     select SM501
     select SH4
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index a1b7acb12a..564305e283 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -8,10 +8,14 @@ config USB_UHCI
     select USB
=20
 config USB_OHCI
+    bool
+    select USB
+
+config USB_OHCI_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
-    select USB
+    select USB_OHCI
=20
 config USB_EHCI
     bool
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 2b929649ac..81688f6e70 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -5,6 +5,7 @@ common-obj-$(CONFIG_USB) +=3D desc.o desc-msos.o
 # usb host adapters
 common-obj-$(CONFIG_USB_UHCI) +=3D hcd-uhci.o
 common-obj-$(CONFIG_USB_OHCI) +=3D hcd-ohci.o
+common-obj-$(CONFIG_USB_OHCI_PCI) +=3D hcd-ohci-pci.o
 common-obj-$(CONFIG_USB_EHCI) +=3D hcd-ehci.o hcd-ehci-pci.o
 common-obj-$(CONFIG_USB_EHCI_SYSBUS) +=3D hcd-ehci.o hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) +=3D hcd-xhci.o
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
new file mode 100644
index 0000000000..e8f372c6ad
--- /dev/null
+++ b/hw/usb/hcd-ohci-pci.c
@@ -0,0 +1,163 @@
+/*
+ * QEMU USB OHCI Emulation
+ * Copyright (c) 2004 Gianni Tedesco
+ * Copyright (c) 2006 CodeSourcery
+ * Copyright (c) 2006 Openedhand Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "qapi/error.h"
+#include "qemu/timer.h"
+#include "hw/usb.h"
+#include "hw/pci/pci.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-dma.h"
+#include "trace.h"
+#include "hcd-ohci.h"
+
+#define TYPE_PCI_OHCI "pci-ohci"
+#define PCI_OHCI(obj) OBJECT_CHECK(OHCIPCIState, (obj), TYPE_PCI_OHCI)
+
+typedef struct {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    OHCIState state;
+    char *masterbus;
+    uint32_t num_ports;
+    uint32_t firstport;
+} OHCIPCIState;
+
+/**
+ * A typical PCI OHCI will additionally set PERR in its configspace to
+ * signal that it got an error.
+ */
+static void ohci_pci_die(struct OHCIState *ohci)
+{
+    OHCIPCIState *dev =3D container_of(ohci, OHCIPCIState, state);
+
+    ohci_sysbus_die(ohci);
+
+    pci_set_word(dev->parent_obj.config + PCI_STATUS,
+                 PCI_STATUS_DETECTED_PARITY);
+}
+
+static void usb_ohci_realize_pci(PCIDevice *dev, Error **errp)
+{
+    Error *err =3D NULL;
+    OHCIPCIState *ohci =3D PCI_OHCI(dev);
+
+    dev->config[PCI_CLASS_PROG] =3D 0x10; /* OHCI */
+    dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin A */
+
+    usb_ohci_init(&ohci->state, DEVICE(dev), ohci->num_ports, 0,
+                  ohci->masterbus, ohci->firstport,
+                  pci_get_address_space(dev), ohci_pci_die, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    ohci->state.irq =3D pci_allocate_irq(dev);
+    pci_register_bar(dev, 0, 0, &ohci->state.mem);
+}
+
+static void usb_ohci_exit(PCIDevice *dev)
+{
+    OHCIPCIState *ohci =3D PCI_OHCI(dev);
+    OHCIState *s =3D &ohci->state;
+
+    trace_usb_ohci_exit(s->name);
+    ohci_bus_stop(s);
+
+    if (s->async_td) {
+        usb_cancel_packet(&s->usb_packet);
+        s->async_td =3D 0;
+    }
+    ohci_stop_endpoints(s);
+
+    if (!ohci->masterbus) {
+        usb_bus_release(&s->bus);
+    }
+
+    timer_del(s->eof_timer);
+    timer_free(s->eof_timer);
+}
+
+static void usb_ohci_reset_pci(DeviceState *d)
+{
+    PCIDevice *dev =3D PCI_DEVICE(d);
+    OHCIPCIState *ohci =3D PCI_OHCI(dev);
+    OHCIState *s =3D &ohci->state;
+
+    ohci_hard_reset(s);
+}
+
+static Property ohci_pci_properties[] =3D {
+    DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),
+    DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),
+    DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_ohci =3D {
+    .name =3D "ohci",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, OHCIPCIState),
+        VMSTATE_STRUCT(state, OHCIPCIState, 1, vmstate_ohci_state, OHCIS=
tate),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void ohci_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->realize =3D usb_ohci_realize_pci;
+    k->exit =3D usb_ohci_exit;
+    k->vendor_id =3D PCI_VENDOR_ID_APPLE;
+    k->device_id =3D PCI_DEVICE_ID_APPLE_IPID_USB;
+    k->class_id =3D PCI_CLASS_SERIAL_USB;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+    dc->desc =3D "Apple USB Controller";
+    dc->props =3D ohci_pci_properties;
+    dc->hotpluggable =3D false;
+    dc->vmsd =3D &vmstate_ohci;
+    dc->reset =3D usb_ohci_reset_pci;
+}
+
+static const TypeInfo ohci_pci_info =3D {
+    .name          =3D TYPE_PCI_OHCI,
+    .parent        =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(OHCIPCIState),
+    .class_init    =3D ohci_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void ohci_pci_register_types(void)
+{
+    type_register_static(&ohci_pci_info);
+}
+
+type_init(ohci_pci_register_types)
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 6d3f556989..aaba090588 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -30,87 +30,19 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
-#include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
 #include "trace.h"
+#include "hcd-ohci.h"
=20
 /* This causes frames to occur 1000x slower */
 //#define OHCI_TIME_WARP 1
=20
-/* Number of Downstream Ports on the root hub.  */
-
-#define OHCI_MAX_PORTS 15
-
 #define ED_LINK_LIMIT 32
=20
 static int64_t usb_frame_time;
 static int64_t usb_bit_time;
=20
-typedef struct OHCIPort {
-    USBPort port;
-    uint32_t ctrl;
-} OHCIPort;
-
-typedef struct OHCIState {
-    USBBus bus;
-    qemu_irq irq;
-    MemoryRegion mem;
-    AddressSpace *as;
-    uint32_t num_ports;
-    const char *name;
-
-    QEMUTimer *eof_timer;
-    int64_t sof_time;
-
-    /* OHCI state */
-    /* Control partition */
-    uint32_t ctl, status;
-    uint32_t intr_status;
-    uint32_t intr;
-
-    /* memory pointer partition */
-    uint32_t hcca;
-    uint32_t ctrl_head, ctrl_cur;
-    uint32_t bulk_head, bulk_cur;
-    uint32_t per_cur;
-    uint32_t done;
-    int32_t done_count;
-
-    /* Frame counter partition */
-    uint16_t fsmps;
-    uint8_t fit;
-    uint16_t fi;
-    uint8_t frt;
-    uint16_t frame_number;
-    uint16_t padding;
-    uint32_t pstart;
-    uint32_t lst;
-
-    /* Root Hub partition */
-    uint32_t rhdesc_a, rhdesc_b;
-    uint32_t rhstatus;
-    OHCIPort rhport[OHCI_MAX_PORTS];
-
-    /* PXA27x Non-OHCI events */
-    uint32_t hstatus;
-    uint32_t hmask;
-    uint32_t hreset;
-    uint32_t htest;
-
-    /* SM501 local memory offset */
-    dma_addr_t localmem_base;
-
-    /* Active packets.  */
-    uint32_t old_ctl;
-    USBPacket usb_packet;
-    uint8_t usb_buf[8192];
-    uint32_t async_td;
-    bool async_complete;
-
-    void (*ohci_die)(struct OHCIState *ohci);
-} OHCIState;
-
 /* Host Controller Communications Area */
 struct ohci_hcca {
     uint32_t intr[32];
@@ -123,7 +55,6 @@ struct ohci_hcca {
 #define ED_WBACK_OFFSET offsetof(struct ohci_ed, head)
 #define ED_WBACK_SIZE   4
=20
-static void ohci_bus_stop(OHCIState *ohci);
 static void ohci_async_cancel_device(OHCIState *ohci, USBDevice *dev);
=20
 /* Bitfields for the first word of an Endpoint Desciptor.  */
@@ -430,7 +361,7 @@ static USBDevice *ohci_find_device(OHCIState *ohci, u=
int8_t addr)
     return NULL;
 }
=20
-static void ohci_stop_endpoints(OHCIState *ohci)
+void ohci_stop_endpoints(OHCIState *ohci)
 {
     USBDevice *dev;
     int i, j;
@@ -502,7 +433,7 @@ static void ohci_soft_reset(OHCIState *ohci)
     ohci->lst =3D OHCI_LS_THRESH;
 }
=20
-static void ohci_hard_reset(OHCIState *ohci)
+void ohci_hard_reset(OHCIState *ohci)
 {
     ohci_soft_reset(ohci);
     ohci->ctl =3D 0;
@@ -1376,7 +1307,7 @@ static int ohci_bus_start(OHCIState *ohci)
 }
=20
 /* Stop sending SOF tokens on the bus */
-static void ohci_bus_stop(OHCIState *ohci)
+void ohci_bus_stop(OHCIState *ohci)
 {
     trace_usb_ohci_stop(ohci->name);
     timer_del(ohci->eof_timer);
@@ -1856,10 +1787,10 @@ static USBPortOps ohci_port_ops =3D {
 static USBBusOps ohci_bus_ops =3D {
 };
=20
-static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
-                          uint32_t num_ports, dma_addr_t localmem_base,
-                          char *masterbus, uint32_t firstport, AddressSp=
ace *as,
-                          void (*ohci_die_fn)(struct OHCIState *), Error=
 **errp)
+void usb_ohci_init(OHCIState *ohci, DeviceState *dev, uint32_t num_ports=
,
+                   dma_addr_t localmem_base, char *masterbus,
+                   uint32_t firstport, AddressSpace *as,
+                   void (*ohci_die_fn)(struct OHCIState *), Error **errp=
)
 {
     Error *err =3D NULL;
     int i;
@@ -1924,25 +1855,11 @@ static void usb_ohci_init(OHCIState *ohci, Device=
State *dev,
                                    ohci_frame_boundary, ohci);
 }
=20
-#define TYPE_PCI_OHCI "pci-ohci"
-#define PCI_OHCI(obj) OBJECT_CHECK(OHCIPCIState, (obj), TYPE_PCI_OHCI)
-
-typedef struct {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    OHCIState state;
-    char *masterbus;
-    uint32_t num_ports;
-    uint32_t firstport;
-} OHCIPCIState;
-
 /**
  * A typical OHCI will stop operating and set itself into error state
  * (which can be queried by MMIO) to signal that it got an error.
  */
-static void ohci_sysbus_die(struct OHCIState *ohci)
+void ohci_sysbus_die(struct OHCIState *ohci)
 {
     trace_usb_ohci_die();
=20
@@ -1950,71 +1867,6 @@ static void ohci_sysbus_die(struct OHCIState *ohci=
)
     ohci_bus_stop(ohci);
 }
=20
-/**
- * A typical PCI OHCI will additionally set PERR in its configspace to
- * signal that it got an error.
- */
-static void ohci_pci_die(struct OHCIState *ohci)
-{
-    OHCIPCIState *dev =3D container_of(ohci, OHCIPCIState, state);
-
-    ohci_sysbus_die(ohci);
-
-    pci_set_word(dev->parent_obj.config + PCI_STATUS,
-                 PCI_STATUS_DETECTED_PARITY);
-}
-
-static void usb_ohci_realize_pci(PCIDevice *dev, Error **errp)
-{
-    Error *err =3D NULL;
-    OHCIPCIState *ohci =3D PCI_OHCI(dev);
-
-    dev->config[PCI_CLASS_PROG] =3D 0x10; /* OHCI */
-    dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin A */
-
-    usb_ohci_init(&ohci->state, DEVICE(dev), ohci->num_ports, 0,
-                  ohci->masterbus, ohci->firstport,
-                  pci_get_address_space(dev), ohci_pci_die, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    ohci->state.irq =3D pci_allocate_irq(dev);
-    pci_register_bar(dev, 0, 0, &ohci->state.mem);
-}
-
-static void usb_ohci_exit(PCIDevice *dev)
-{
-    OHCIPCIState *ohci =3D PCI_OHCI(dev);
-    OHCIState *s =3D &ohci->state;
-
-    trace_usb_ohci_exit(s->name);
-    ohci_bus_stop(s);
-
-    if (s->async_td) {
-        usb_cancel_packet(&s->usb_packet);
-        s->async_td =3D 0;
-    }
-    ohci_stop_endpoints(s);
-
-    if (!ohci->masterbus) {
-        usb_bus_release(&s->bus);
-    }
-
-    timer_del(s->eof_timer);
-    timer_free(s->eof_timer);
-}
-
-static void usb_ohci_reset_pci(DeviceState *d)
-{
-    PCIDevice *dev =3D PCI_DEVICE(d);
-    OHCIPCIState *ohci =3D PCI_OHCI(dev);
-    OHCIState *s =3D &ohci->state;
-
-    ohci_hard_reset(s);
-}
-
 #define TYPE_SYSBUS_OHCI "sysbus-ohci"
 #define SYSBUS_OHCI(obj) OBJECT_CHECK(OHCISysBusState, (obj), TYPE_SYSBU=
S_OHCI)
=20
@@ -2055,13 +1907,6 @@ static void usb_ohci_reset_sysbus(DeviceState *dev=
)
     ohci_hard_reset(ohci);
 }
=20
-static Property ohci_pci_properties[] =3D {
-    DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),
-    DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),
-    DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static const VMStateDescription vmstate_ohci_state_port =3D {
     .name =3D "ohci-core/port",
     .version_id =3D 1,
@@ -2090,7 +1935,7 @@ static const VMStateDescription vmstate_ohci_eof_ti=
mer =3D {
     },
 };
=20
-static const VMStateDescription vmstate_ohci_state =3D {
+const VMStateDescription vmstate_ohci_state =3D {
     .name =3D "ohci-core",
     .version_id =3D 1,
     .minimum_version_id =3D 1,
@@ -2137,46 +1982,6 @@ static const VMStateDescription vmstate_ohci_state=
 =3D {
     }
 };
=20
-static const VMStateDescription vmstate_ohci =3D {
-    .name =3D "ohci",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(parent_obj, OHCIPCIState),
-        VMSTATE_STRUCT(state, OHCIPCIState, 1, vmstate_ohci_state, OHCIS=
tate),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void ohci_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
-
-    k->realize =3D usb_ohci_realize_pci;
-    k->exit =3D usb_ohci_exit;
-    k->vendor_id =3D PCI_VENDOR_ID_APPLE;
-    k->device_id =3D PCI_DEVICE_ID_APPLE_IPID_USB;
-    k->class_id =3D PCI_CLASS_SERIAL_USB;
-    set_bit(DEVICE_CATEGORY_USB, dc->categories);
-    dc->desc =3D "Apple USB Controller";
-    dc->props =3D ohci_pci_properties;
-    dc->hotpluggable =3D false;
-    dc->vmsd =3D &vmstate_ohci;
-    dc->reset =3D usb_ohci_reset_pci;
-}
-
-static const TypeInfo ohci_pci_info =3D {
-    .name          =3D TYPE_PCI_OHCI,
-    .parent        =3D TYPE_PCI_DEVICE,
-    .instance_size =3D sizeof(OHCIPCIState),
-    .class_init    =3D ohci_pci_class_init,
-    .interfaces =3D (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
 static Property ohci_sysbus_properties[] =3D {
     DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
     DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
@@ -2205,7 +2010,6 @@ static const TypeInfo ohci_sysbus_info =3D {
=20
 static void ohci_register_types(void)
 {
-    type_register_static(&ohci_pci_info);
     type_register_static(&ohci_sysbus_info);
 }
=20
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
new file mode 100644
index 0000000000..16e3f1e13a
--- /dev/null
+++ b/hw/usb/hcd-ohci.h
@@ -0,0 +1,104 @@
+/*
+ * QEMU USB OHCI Emulation
+ * Copyright (c) 2004 Gianni Tedesco
+ * Copyright (c) 2006 CodeSourcery
+ * Copyright (c) 2006 Openedhand Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ */
+
+#ifndef HCD_OHCI_H
+#define HCD_OHCI_H
+
+#include "sysemu/dma.h"
+
+/* Number of Downstream Ports on the root hub: */
+#define OHCI_MAX_PORTS 15
+
+typedef struct OHCIPort {
+    USBPort port;
+    uint32_t ctrl;
+} OHCIPort;
+
+typedef struct OHCIState {
+    USBBus bus;
+    qemu_irq irq;
+    MemoryRegion mem;
+    AddressSpace *as;
+    uint32_t num_ports;
+    const char *name;
+
+    QEMUTimer *eof_timer;
+    int64_t sof_time;
+
+    /* OHCI state */
+    /* Control partition */
+    uint32_t ctl, status;
+    uint32_t intr_status;
+    uint32_t intr;
+
+    /* memory pointer partition */
+    uint32_t hcca;
+    uint32_t ctrl_head, ctrl_cur;
+    uint32_t bulk_head, bulk_cur;
+    uint32_t per_cur;
+    uint32_t done;
+    int32_t done_count;
+
+    /* Frame counter partition */
+    uint16_t fsmps;
+    uint8_t fit;
+    uint16_t fi;
+    uint8_t frt;
+    uint16_t frame_number;
+    uint16_t padding;
+    uint32_t pstart;
+    uint32_t lst;
+
+    /* Root Hub partition */
+    uint32_t rhdesc_a, rhdesc_b;
+    uint32_t rhstatus;
+    OHCIPort rhport[OHCI_MAX_PORTS];
+
+    /* PXA27x Non-OHCI events */
+    uint32_t hstatus;
+    uint32_t hmask;
+    uint32_t hreset;
+    uint32_t htest;
+
+    /* SM501 local memory offset */
+    dma_addr_t localmem_base;
+
+    /* Active packets.  */
+    uint32_t old_ctl;
+    USBPacket usb_packet;
+    uint8_t usb_buf[8192];
+    uint32_t async_td;
+    bool async_complete;
+
+    void (*ohci_die)(struct OHCIState *ohci);
+} OHCIState;
+
+extern const VMStateDescription vmstate_ohci_state;
+
+void usb_ohci_init(OHCIState *ohci, DeviceState *dev, uint32_t num_ports=
,
+                   dma_addr_t localmem_base, char *masterbus,
+                   uint32_t firstport, AddressSpace *as,
+                   void (*ohci_die_fn)(struct OHCIState *), Error **errp=
);
+void ohci_bus_stop(OHCIState *ohci);
+void ohci_stop_endpoints(OHCIState *ohci);
+void ohci_hard_reset(OHCIState *ohci);
+void ohci_sysbus_die(struct OHCIState *ohci);
+
+#endif
--=20
2.21.0


