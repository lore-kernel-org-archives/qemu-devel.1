Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D740C31E47
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7295320874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z51HDnGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7295320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hawOq-0001ab-5v
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 02:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1haw8o-0004ZL-I4
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1haw8l-00073W-3V
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:49:46 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53731 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1haw8k-00071C-Ck; Wed, 12 Jun 2019 01:49:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NwtR3X0zz9sNp; Wed, 12 Jun 2019 15:49:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560318575;
 bh=kqdUGeH6ieL5NQXTxSXSwkj8DXS2BqmKfoTd/xekpGQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z51HDnGygAWnxyhWO58nDPI8t8RCH9VtGHJ4wfrZ+fqly32nbtaKLa/8lHg2sQWLh
 dBDj+xsgA6fh7QTk0ZfQbia1frPuA16wmWR4gGIkWgIEhiu0HS9ZpAXvO4PvbPZLZ3
 upgEf4sSk/qpvJKnQOgCuIftgEZpFyyAwaz9oK7M=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 12 Jun 2019 15:49:26 +1000
Message-Id: <20190612054929.21136-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612054929.21136-1-david@gibson.dropbear.id.au>
References: <20190612054929.21136-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 10/13] spapr: Allow hot plug/unplug of PCI
 bridges and devices under PCI bridges
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
Cc: lvivier@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pseries machine type already allows PCI hotplug and unplug via the
PAPR mechanism, but only on the root bus of each PHB.  This patch extends
this to allow PCI to PCI bridges to be hotplugged, and devices to be
hotplugged or unplugged under P2P bridges.

For now we disallow hot unplugging P2P bridges.  I tried doing that, but
haven't managed to get it working, I think due to some guest side problem=
s
that need further investigation.

To do this we dynamically construct DRCs when bridges are hot (or cold)
added, which can in turn be used to hotplug devices under the bridge.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 115 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 102 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 9d99bc0b4c..c8d7838385 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1257,30 +1257,53 @@ static SpaprDrc *drc_from_dev(SpaprPhbState *phb,=
 PCIDevice *dev)
     return drc_from_devfn(phb, chassis, dev->devfn);
 }
=20
-static void add_drcs(SpaprPhbState *phb)
+static void add_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
 {
+    Object *owner;
     int i;
+    uint8_t chassis;
+    Error *local_err =3D NULL;
=20
     if (!phb->dr_enabled) {
         return;
     }
=20
+    chassis =3D chassis_from_bus(bus, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (pci_bus_is_root(bus)) {
+        owner =3D OBJECT(phb);
+    } else {
+        owner =3D OBJECT(pci_bridge_get_device(bus));
+    }
+
     for (i =3D 0; i < PCI_SLOT_MAX * PCI_FUNC_MAX; i++) {
-        spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
-                               drc_id_from_devfn(phb, 0, i));
+        spapr_dr_connector_new(owner, TYPE_SPAPR_DRC_PCI,
+                               drc_id_from_devfn(phb, chassis, i));
     }
 }
=20
-static void remove_drcs(SpaprPhbState *phb)
+static void remove_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
 {
     int i;
+    uint8_t chassis;
+    Error *local_err =3D NULL;
=20
     if (!phb->dr_enabled) {
         return;
     }
=20
+    chassis =3D chassis_from_bus(bus, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     for (i =3D PCI_SLOT_MAX * PCI_FUNC_MAX - 1; i >=3D 0; i--) {
-        SpaprDrc *drc =3D drc_from_devfn(phb, 0, i);
+        SpaprDrc *drc =3D drc_from_devfn(phb, chassis, i);
=20
         if (drc) {
             object_unparent(OBJECT(drc));
@@ -1325,6 +1348,7 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, PC=
IBus *bus,
         .sphb =3D sphb,
         .err =3D 0,
     };
+    int ret;
=20
     _FDT(fdt_setprop_cell(fdt, offset, "#address-cells",
                           RESOURCE_CELLS_ADDRESS));
@@ -1339,6 +1363,12 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, P=
CIBus *bus,
         }
     }
=20
+    ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),
+                       SPAPR_DR_CONNECTOR_TYPE_PCI);
+    if (ret) {
+        return ret;
+    }
+
     return offset;
 }
=20
@@ -1483,11 +1513,26 @@ int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMac=
hineState *spapr,
     return 0;
 }
=20
+static void spapr_pci_bridge_plug(SpaprPhbState *phb,
+                                  PCIBridge *bridge,
+                                  Error **errp)
+{
+    Error *local_err =3D NULL;
+    PCIBus *bus =3D pci_bridge_get_sec_bus(bridge);
+
+    add_drcs(phb, bus, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
 static void spapr_pci_plug(HotplugHandler *plug_handler,
                            DeviceState *plugged_dev, Error **errp)
 {
     SpaprPhbState *phb =3D SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
     PCIDevice *pdev =3D PCI_DEVICE(plugged_dev);
+    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(plugged_dev);
     SpaprDrc *drc =3D drc_from_dev(phb, pdev);
     Error *local_err =3D NULL;
     PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
@@ -1509,6 +1554,14 @@ static void spapr_pci_plug(HotplugHandler *plug_ha=
ndler,
=20
     g_assert(drc);
=20
+    if (pc->is_bridge) {
+        spapr_pci_bridge_plug(phb, PCI_BRIDGE(plugged_dev), &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
     /* Following the QEMU convention used for PCIe multifunction
      * hotplug, we do not allow functions to be hotplugged to a
      * slot that already has function 0 present
@@ -1559,9 +1612,26 @@ out:
     error_propagate(errp, local_err);
 }
=20
+static void spapr_pci_bridge_unplug(SpaprPhbState *phb,
+                                    PCIBridge *bridge,
+                                    Error **errp)
+{
+    Error *local_err =3D NULL;
+    PCIBus *bus =3D pci_bridge_get_sec_bus(bridge);
+
+    remove_drcs(phb, bus, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
 static void spapr_pci_unplug(HotplugHandler *plug_handler,
                              DeviceState *plugged_dev, Error **errp)
 {
+    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(plugged_dev);
+    SpaprPhbState *phb =3D SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
+
     /* some version guests do not wait for completion of a device
      * cleanup (generally done asynchronously by the kernel) before
      * signaling to QEMU that the device is safe, but instead sleep
@@ -1573,6 +1643,16 @@ static void spapr_pci_unplug(HotplugHandler *plug_=
handler,
      * an 'idle' state, as the device cleanup code expects.
      */
     pci_device_reset(PCI_DEVICE(plugged_dev));
+
+    if (pc->is_bridge) {
+        Error *local_err =3D NULL;
+        spapr_pci_bridge_unplug(phb, PCI_BRIDGE(plugged_dev), &local_err=
);
+        if (local_err) {
+            error_propagate(errp, local_err);
+        }
+        return;
+    }
+
     object_property_set_bool(OBJECT(plugged_dev), false, "realized", NUL=
L);
 }
=20
@@ -1593,6 +1673,7 @@ static void spapr_pci_unplug_request(HotplugHandler=
 *plug_handler,
     g_assert(drc->dev =3D=3D plugged_dev);
=20
     if (!spapr_drc_unplug_requested(drc)) {
+        PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(plugged_dev);
         uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
         SpaprDrc *func_drc;
         SpaprDrcClass *func_drck;
@@ -1606,6 +1687,10 @@ static void spapr_pci_unplug_request(HotplugHandle=
r *plug_handler,
             return;
         }
=20
+        if (pc->is_bridge) {
+            error_setg(errp, "PCI: Hot unplug of PCI bridges not support=
ed");
+        }
+
         /* ensure any other present functions are pending unplug */
         if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
             for (i =3D 1; i < 8; i++) {
@@ -1658,6 +1743,7 @@ static void spapr_phb_unrealize(DeviceState *dev, E=
rror **errp)
     SpaprTceTable *tcet;
     int i;
     const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
+    Error *local_err =3D NULL;
=20
     spapr_phb_nvgpu_free(sphb);
=20
@@ -1678,7 +1764,11 @@ static void spapr_phb_unrealize(DeviceState *dev, =
Error **errp)
         }
     }
=20
-    remove_drcs(sphb);
+    remove_drcs(sphb, phb->bus, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
     for (i =3D PCI_NUM_PINS - 1; i >=3D 0; i--) {
         if (sphb->lsi_table[i].irq) {
@@ -1721,6 +1811,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     uint64_t msi_window_size =3D 4096;
     SpaprTceTable *tcet;
     const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
+    Error *local_err =3D NULL;
=20
     if (!spapr) {
         error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries ma=
chine");
@@ -1873,7 +1964,6 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     /* Initialize the LSI table */
     for (i =3D 0; i < PCI_NUM_PINS; i++) {
         uint32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS =
+ i;
-        Error *local_err =3D NULL;
=20
         if (smc->legacy_irq_allocation) {
             irq =3D spapr_irq_findone(spapr, &local_err);
@@ -1898,7 +1988,11 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
     }
=20
     /* allocate connectors for child PCI devices */
-    add_drcs(sphb);
+    add_drcs(sphb, phb->bus, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto unrealize;
+    }
=20
     /* DMA setup */
     for (i =3D 0; i < windows_supported; ++i) {
@@ -2314,11 +2408,6 @@ int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc=
_phandle, void *fdt,
         return ret;
     }
=20
-    ret =3D spapr_dt_drc(fdt, bus_off, OBJECT(phb), SPAPR_DR_CONNECTOR_T=
YPE_PCI);
-    if (ret) {
-        return ret;
-    }
-
     spapr_phb_nvgpu_populate_dt(phb, fdt, bus_off, &errp);
     if (errp) {
         error_report_err(errp);
--=20
2.21.0


