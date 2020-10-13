Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E312C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DE620708
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DE620708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEuW-0003Iq-Hf
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kSErp-0000Z0-0x; Tue, 13 Oct 2020 03:37:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:51188
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kSErl-0005eC-8f; Tue, 13 Oct 2020 03:37:04 -0400
Received: from host86-158-109-18.range86-158.btcentralplus.com
 ([86.158.109.18] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kSEri-0003Eo-ID; Tue, 13 Oct 2020 08:37:03 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
 f4bug@amsat.org
Date: Tue, 13 Oct 2020 08:36:36 +0100
Message-Id: <20201013073636.31389-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201013073636.31389-1-mark.cave-ayland@ilande.co.uk>
References: <20201013073636.31389-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.18
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 3/3] uninorth: use qdev gpios for PCI IRQs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently an object link property is used to pass a reference to the OpenPIC
into the PCI host bridge so that pci_unin_init_irqs() can connect the PCI
IRQs to the PIC itself.

This can be simplified by defining the PCI IRQs as qdev gpios and then wiring
up the PCI IRQs to the PIC in the New World machine init function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/uninorth.c         | 45 +++++++---------------------------
 hw/ppc/mac_newworld.c          | 24 ++++++++++++------
 include/hw/pci-host/uninorth.h |  1 -
 3 files changed, 25 insertions(+), 45 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 1ed1072eeb..0c0a9ecee1 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -32,8 +32,6 @@
 #include "hw/pci-host/uninorth.h"
 #include "trace.h"
 
-static const int unin_irq_line[] = { 0x1b, 0x1c, 0x1d, 0x1e };
-
 static int pci_unin_map_irq(PCIDevice *pci_dev, int irq_num)
 {
     return (irq_num + (pci_dev->devfn >> 3)) & 3;
@@ -43,7 +41,7 @@ static void pci_unin_set_irq(void *opaque, int irq_num, int level)
 {
     UNINHostState *s = opaque;
 
-    trace_unin_set_irq(unin_irq_line[irq_num], level);
+    trace_unin_set_irq(irq_num, level);
     qemu_set_irq(s->irqs[irq_num], level);
 }
 
@@ -112,15 +110,6 @@ static const MemoryRegionOps unin_data_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void pci_unin_init_irqs(UNINHostState *s)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(s->irqs); i++) {
-        s->irqs[i] = qdev_get_gpio_in(DEVICE(s->pic), unin_irq_line[i]);
-    }
-}
-
 static char *pci_unin_main_ofw_unit_address(const SysBusDevice *dev)
 {
     UNINHostState *s = UNI_NORTH_PCI_HOST_BRIDGE(dev);
@@ -141,7 +130,6 @@ static void pci_unin_main_realize(DeviceState *dev, Error **errp)
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
-    pci_unin_init_irqs(s);
 
     /* DEC 21154 bridge */
 #if 0
@@ -172,15 +160,12 @@ static void pci_unin_main_init(Object *obj)
                              "unin-pci-hole", &s->pci_mmio,
                              0x80000000ULL, 0x10000000ULL);
 
-    object_property_add_link(obj, "pic", TYPE_OPENPIC,
-                             (Object **) &s->pic,
-                             qdev_prop_allow_set_link_before_realize,
-                             0);
-
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
     sysbus_init_mmio(sbd, &s->pci_hole);
     sysbus_init_mmio(sbd, &s->pci_io);
+
+    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
 }
 
 static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
@@ -196,7 +181,6 @@ static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
-    pci_unin_init_irqs(s);
 }
 
 static void pci_u3_agp_init(Object *obj)
@@ -220,15 +204,12 @@ static void pci_u3_agp_init(Object *obj)
                              "unin-pci-hole", &s->pci_mmio,
                              0x80000000ULL, 0x70000000ULL);
 
-    object_property_add_link(obj, "pic", TYPE_OPENPIC,
-                             (Object **) &s->pic,
-                             qdev_prop_allow_set_link_before_realize,
-                             0);
-
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
     sysbus_init_mmio(sbd, &s->pci_hole);
     sysbus_init_mmio(sbd, &s->pci_io);
+
+    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
 }
 
 static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
@@ -244,7 +225,6 @@ static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
-    pci_unin_init_irqs(s);
 }
 
 static void pci_unin_agp_init(Object *obj)
@@ -259,13 +239,10 @@ static void pci_unin_agp_init(Object *obj)
     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
                           obj, "unin-agp-conf-data", 0x1000);
 
-    object_property_add_link(obj, "pic", TYPE_OPENPIC,
-                             (Object **) &s->pic,
-                             qdev_prop_allow_set_link_before_realize,
-                             0);
-
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
+
+    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
 }
 
 static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
@@ -281,7 +258,6 @@ static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
                                    PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
 
     pci_create_simple(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci");
-    pci_unin_init_irqs(s);
 }
 
 static void pci_unin_internal_init(Object *obj)
@@ -296,13 +272,10 @@ static void pci_unin_internal_init(Object *obj)
     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
                           obj, "unin-pci-conf-data", 0x1000);
 
-    object_property_add_link(obj, "pic", TYPE_OPENPIC,
-                             (Object **) &s->pic,
-                             qdev_prop_allow_set_link_before_realize,
-                             0);
-
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
+
+    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
 }
 
 static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 6f5ef2e782..7a8dc09c8d 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -303,8 +303,6 @@ static void ppc_core99_init(MachineState *machine)
         /* 970 gets a U3 bus */
         /* Uninorth AGP bus */
         dev = qdev_new(TYPE_U3_AGP_HOST_BRIDGE);
-        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
-                                 &error_abort);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         uninorth_pci = U3_AGP_HOST_BRIDGE(dev);
         s = SYS_BUS_DEVICE(dev);
@@ -317,32 +315,38 @@ static void ppc_core99_init(MachineState *machine)
         sysbus_mmio_map(s, 0, 0xf0800000);
         sysbus_mmio_map(s, 1, 0xf0c00000);
 
+        for (i = 0; i < 4; i++) {
+            qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x1b + i));
+        }
+
         machine_arch = ARCH_MAC99_U3;
     } else {
         /* Use values found on a real PowerMac */
         /* Uninorth AGP bus */
         dev = qdev_new(TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
-        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
-                                 &error_abort);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_mmio_map(s, 0, 0xf0800000);
         sysbus_mmio_map(s, 1, 0xf0c00000);
 
+        for (i = 0; i < 4; i++) {
+            qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x1b + i));
+        }
+
         /* Uninorth internal bus */
         dev = qdev_new(TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
-        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
-                                 &error_abort);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_mmio_map(s, 0, 0xf4800000);
         sysbus_mmio_map(s, 1, 0xf4c00000);
 
+        for (i = 0; i < 4; i++) {
+            qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x1b + i));
+        }
+
         /* Uninorth main bus */
         dev = qdev_new(TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
         qdev_prop_set_uint32(dev, "ofw-addr", 0xf2000000);
-        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
-                                 &error_abort);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         uninorth_pci = UNI_NORTH_PCI_HOST_BRIDGE(dev);
         s = SYS_BUS_DEVICE(dev);
@@ -355,6 +359,10 @@ static void ppc_core99_init(MachineState *machine)
         sysbus_mmio_map(s, 0, 0xf2800000);
         sysbus_mmio_map(s, 1, 0xf2c00000);
 
+        for (i = 0; i < 4; i++) {
+            qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x1b + i));
+        }
+
         machine_arch = ARCH_MAC99;
     }
 
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
index a6ba5f21a8..360c2160e4 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -51,7 +51,6 @@ struct UNINHostState {
     PCIHostState parent_obj;
 
     uint32_t ofw_addr;
-    OpenPICState *pic;
     qemu_irq irqs[4];
     MemoryRegion pci_mmio;
     MemoryRegion pci_hole;
-- 
2.20.1


