Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E35C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4DD20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OH3sVZUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4DD20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0xG-0006Xm-QF
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0ui-0000bW-N5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:37:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0uf-000254-Sn
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592987865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUE6yhXXkEqubuCqpbkAAocAfBn9p/pQ69VGMy/Y9ro=;
 b=OH3sVZUP3UGV9OzP2WWhaNYptLdWTmCYYJusGRaJtYzxT0m4V57eR0Vi3+Bvo4vaAqcn1r
 iDfU8r4nUXCiYrybJs2MDjXcr9EcjLVN6sZBlhCNZbZFjINe0xyoyY6DMndvS37fuZ5wqb
 eUbIp3uXfEPBWiwqup/1MOuEl+G/RX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-j6TgGh4MNo2ZwMIe8Y4cZg-1; Wed, 24 Jun 2020 04:37:43 -0400
X-MC-Unique: j6TgGh4MNo2ZwMIe8Y4cZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5BB9805EE2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 08:37:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55EC779313;
 Wed, 24 Jun 2020 08:37:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD362113847C; Wed, 24 Jun 2020 10:37:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/25] qdev: Drop qbus_set_hotplug_handler() parameter @errp
Date: Wed, 24 Jun 2020 10:37:26 +0200
Message-Id: <20200624083737.3086768-15-armbru@redhat.com>
In-Reply-To: <20200624083737.3086768-1-armbru@redhat.com>
References: <20200624083737.3086768-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qbus_set_hotplug_handler() is a simple wrapper around
object_property_set_link().

object_property_set_link() fails when the property doesn't exist, is
not settable, or its .check() method fails.  These are all programming
errors here, so passing &error_abort to qbus_set_hotplug_handler() is
appropriate.

Most of its callers do.  Exceptions:

* pcie_cap_slot_init(), shpc_init(), spapr_phb_realize() pass NULL,
  i.e. they ignore errors.

* spapr_machine_init() passes &error_fatal.

* s390_pcihost_realize(), virtio_serial_device_realize(),
  s390_pcihost_plug() pass the error to their callers.  The latter two
  keep going after the error, which looks wrong.

Drop the @errp parameter, and instead pass &error_abort to
object_property_set_link().

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-core.h        |  3 +--
 hw/acpi/pcihp.c               |  3 +--
 hw/acpi/piix4.c               |  2 +-
 hw/char/virtio-serial-bus.c   |  4 ++--
 hw/core/bus.c                 |  6 +++---
 hw/pci/pcie.c                 |  2 +-
 hw/pci/shpc.c                 |  2 +-
 hw/ppc/spapr.c                |  3 +--
 hw/ppc/spapr_pci.c            |  4 ++--
 hw/s390x/ap-bridge.c          |  2 +-
 hw/s390x/css-bridge.c         |  2 +-
 hw/s390x/s390-pci-bus.c       | 14 +++-----------
 hw/scsi/virtio-scsi.c         |  4 ++--
 hw/scsi/vmw_pvscsi.c          |  2 +-
 hw/usb/dev-smartcard-reader.c |  2 +-
 15 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 78acdeaed6..fe78073c70 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -535,8 +535,7 @@ extern bool qdev_hot_removed;
 
 char *qdev_get_dev_path(DeviceState *dev);
 
-void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp);
-
+void qbus_set_hotplug_handler(BusState *bus, Object *handler);
 void qbus_set_bus_hotplug_handler(BusState *bus);
 
 static inline bool qbus_is_hotpluggable(BusState *bus)
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 33ea2b76ae..9e31ab2da4 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -246,8 +246,7 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
             object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
             PCIBus *sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
 
-            qbus_set_hotplug_handler(BUS(sec), OBJECT(hotplug_dev),
-                                     &error_abort);
+            qbus_set_hotplug_handler(BUS(sec), OBJECT(hotplug_dev));
             /* We don't have to overwrite any other hotplug handler yet */
             assert(QLIST_EMPTY(&sec->child));
         }
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1262abc77a..52bcbd6414 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -505,7 +505,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
 
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s), &error_abort);
+    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));
 
     piix4_pm_add_propeties(s);
 }
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 262089c0c9..f9a4428bd6 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1056,7 +1056,7 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
     /* Spawn a new virtio-serial bus on which the ports will ride as devices */
     qbus_create_inplace(&vser->bus, sizeof(vser->bus), TYPE_VIRTIO_SERIAL_BUS,
                         dev, vdev->bus_name);
-    qbus_set_hotplug_handler(BUS(&vser->bus), OBJECT(vser), errp);
+    qbus_set_hotplug_handler(BUS(&vser->bus), OBJECT(vser));
     vser->bus.vser = vser;
     QTAILQ_INIT(&vser->ports);
 
@@ -1147,7 +1147,7 @@ static void virtio_serial_device_unrealize(DeviceState *dev)
         g_free(vser->post_load);
     }
 
-    qbus_set_hotplug_handler(BUS(&vser->bus), NULL, &error_abort);
+    qbus_set_hotplug_handler(BUS(&vser->bus), NULL);
 
     virtio_cleanup(vdev);
 }
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 8d4e810d7f..544dd8a6fa 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -23,15 +23,15 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 
-void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp)
+void qbus_set_hotplug_handler(BusState *bus, Object *handler)
 {
     object_property_set_link(OBJECT(bus), handler,
-                             QDEV_HOTPLUG_HANDLER_PROPERTY, errp);
+                             QDEV_HOTPLUG_HANDLER_PROPERTY, &error_abort);
 }
 
 void qbus_set_bus_hotplug_handler(BusState *bus)
 {
-    qbus_set_hotplug_handler(bus, OBJECT(bus), &error_abort);
+    qbus_set_hotplug_handler(bus, OBJECT(bus));
 }
 
 int qbus_walk_children(BusState *bus,
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 086d0dfceb..5b48bae0f6 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -574,7 +574,7 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
     dev->exp.hpev_notified = false;
 
     qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))),
-                             OBJECT(dev), NULL);
+                             OBJECT(dev));
 }
 
 void pcie_cap_slot_reset(PCIDevice *dev)
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 99d65d5c4c..b00dce629c 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -649,7 +649,7 @@ int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar,
     shpc_cap_update_dword(d);
     memory_region_add_subregion(bar, offset, &shpc->mmio);
 
-    qbus_set_hotplug_handler(BUS(sec_bus), OBJECT(d), NULL);
+    qbus_set_hotplug_handler(BUS(sec_bus), OBJECT(d));
 
     d->cap_present |= QEMU_PCI_CAP_SHPC;
     return 0;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9bd2183ead..83b974870c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3033,8 +3033,7 @@ static void spapr_machine_init(MachineState *machine)
     register_savevm_live("spapr/htab", VMSTATE_INSTANCE_ID_ANY, 1,
                          &savevm_htab_handlers, spapr);
 
-    qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
-                             &error_fatal);
+    qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine));
 
     qemu_register_boot_set(spapr_boot_set, spapr);
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 329002ac04..0f00e2421f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1719,7 +1719,7 @@ static void spapr_phb_unrealize(DeviceState *dev)
     address_space_remove_listeners(&sphb->iommu_as);
     address_space_destroy(&sphb->iommu_as);
 
-    qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
+    qbus_set_hotplug_handler(BUS(phb->bus), NULL);
     pci_unregister_root_bus(phb->bus);
 
     memory_region_del_subregion(get_system_memory(), &sphb->iowindow);
@@ -1868,7 +1868,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
     }
     phb->bus = bus;
-    qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
+    qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb));
 
     /*
      * Initialize PHB address space.
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index c4e3188ad6..8bcf8ece9d 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -58,7 +58,7 @@ void s390_init_ap(void)
     bus = qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
 
     /* Enable hotplugging */
-    qbus_set_hotplug_handler(bus, OBJECT(dev), &error_abort);
+    qbus_set_hotplug_handler(bus, OBJECT(dev));
  }
 
 static void ap_bridge_class_init(ObjectClass *oc, void *data)
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index e37a54d3f2..9d793d671e 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -111,7 +111,7 @@ VirtualCssBus *virtual_css_bus_init(void)
     cbus = VIRTUAL_CSS_BUS(bus);
 
     /* Enable hotplugging */
-    qbus_set_hotplug_handler(bus, OBJECT(dev), &error_abort);
+    qbus_set_hotplug_handler(bus, OBJECT(dev));
 
     css_register_io_adapters(CSS_IO_ADAPTER_VIRTIO, true, false,
                              0, &error_abort);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index a13978bb37..142e52a8ff 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -751,19 +751,11 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     pci_setup_iommu(b, s390_pci_dma_iommu, s);
 
     bus = BUS(b);
-    qbus_set_hotplug_handler(bus, OBJECT(dev), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    qbus_set_hotplug_handler(bus, OBJECT(dev));
     phb->bus = b;
 
     s->bus = S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, dev, NULL));
-    qbus_set_hotplug_handler(BUS(s->bus), OBJECT(dev), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    qbus_set_hotplug_handler(BUS(s->bus), OBJECT(dev));
 
     s->iommu_table = g_hash_table_new_full(g_int64_hash, g_int64_equal,
                                            NULL, g_free);
@@ -921,7 +913,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
         pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
 
-        qbus_set_hotplug_handler(BUS(&pb->sec_bus), OBJECT(s), errp);
+        qbus_set_hotplug_handler(BUS(&pb->sec_bus), OBJECT(s));
 
         if (dev->hotplugged) {
             pci_default_write_config(pdev, PCI_PRIMARY_BUS,
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 9b72094a61..b49775269e 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -934,7 +934,7 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     scsi_bus_new(&s->bus, sizeof(s->bus), dev,
                  &virtio_scsi_scsi_info, vdev->bus_name);
     /* override default SCSI bus hotplug-handler, with virtio-scsi's one */
-    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev), &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev));
 
     virtio_scsi_dataplane_setup(s, errp);
 }
@@ -958,7 +958,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev)
 {
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
 
-    qbus_set_hotplug_handler(BUS(&s->bus), NULL, &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
     virtio_scsi_common_unrealize(dev);
 }
 
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index ec5bf9ea34..df07ab6bfb 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1147,7 +1147,7 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(pci_dev),
                  &pvscsi_scsi_info, NULL);
     /* override default SCSI bus hotplug-handler, with pvscsi's one */
-    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(s), &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(s));
     pvscsi_reset_state(s);
 }
 
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index ada18c1983..fcfe216594 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1320,7 +1320,7 @@ static void ccid_realize(USBDevice *dev, Error **errp)
     usb_desc_init(dev);
     qbus_create_inplace(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(dev),
                         NULL);
-    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev), &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev));
     s->intr = usb_ep_get(dev, USB_TOKEN_IN, CCID_INT_IN_EP);
     s->bulk = usb_ep_get(dev, USB_TOKEN_IN, CCID_BULK_IN_EP);
     s->card = NULL;
-- 
2.26.2


