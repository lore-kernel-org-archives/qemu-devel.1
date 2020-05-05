Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E325BC4725A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF74A20836
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkKVun9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF74A20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzep-0004qj-SW
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVt-0003SS-O6
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56513
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVo-0007UR-QY
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nz1SI3/ZdTVo+MFVAGFDXfoG9wpFPAq5P2VGKLfiQd4=;
 b=ZkKVun9AG77O6VGWczPLRp+kkiBLLeDqJbEVR5TDXGA9dKWM7TF1UuaShnjKSMx4w7OCGE
 1mNeR2Lry1QWJ13PPjOJnR5TPLN3LH+6tF/PIJPcqr88NddyJJXrHJxXLiq4DtZrJmdkfJ
 a+KjsW+NoBvpsH3KZ/5ke7Yf8aR6Auk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-0mlh4XlUOweLSrCELBKPSA-1; Tue, 05 May 2020 11:29:34 -0400
X-MC-Unique: 0mlh4XlUOweLSrCELBKPSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FC3E1005510;
 Tue,  5 May 2020 15:29:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0911C19C4F;
 Tue,  5 May 2020 15:29:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A6FA11358CE; Tue,  5 May 2020 17:29:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/18] spapr_pci: Drop some dead error handling
Date: Tue,  5 May 2020 17:29:25 +0200
Message-Id: <20200505152926.18877-18-armbru@redhat.com>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
References: <20200505152926.18877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, pbonzini@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

chassis_from_bus() uses object_property_get_uint() to get property
"chassis_nr" of the bridge device.  Failure would be a programming
error.  Pass &error_abort, and simplify its callers.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/spapr_pci.c | 86 ++++++++++------------------------------------
 1 file changed, 18 insertions(+), 68 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 1d73d05a0a..b6036be51c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1203,46 +1203,36 @@ static SpaprDrc *drc_from_devfn(SpaprPhbState *phb,
                            drc_id_from_devfn(phb, chassis, devfn));
 }
=20
-static uint8_t chassis_from_bus(PCIBus *bus, Error **errp)
+static uint8_t chassis_from_bus(PCIBus *bus)
 {
     if (pci_bus_is_root(bus)) {
         return 0;
     } else {
         PCIDevice *bridge =3D pci_bridge_get_device(bus);
=20
-        return object_property_get_uint(OBJECT(bridge), "chassis_nr", errp=
);
+        return object_property_get_uint(OBJECT(bridge), "chassis_nr",
+                                        &error_abort);
     }
 }
=20
 static SpaprDrc *drc_from_dev(SpaprPhbState *phb, PCIDevice *dev)
 {
-    Error *local_err =3D NULL;
-    uint8_t chassis =3D chassis_from_bus(pci_get_bus(dev), &local_err);
-
-    if (local_err) {
-        error_report_err(local_err);
-        return NULL;
-    }
+    uint8_t chassis =3D chassis_from_bus(pci_get_bus(dev));
=20
     return drc_from_devfn(phb, chassis, dev->devfn);
 }
=20
-static void add_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
+static void add_drcs(SpaprPhbState *phb, PCIBus *bus)
 {
     Object *owner;
     int i;
     uint8_t chassis;
-    Error *local_err =3D NULL;
=20
     if (!phb->dr_enabled) {
         return;
     }
=20
-    chassis =3D chassis_from_bus(bus, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    chassis =3D chassis_from_bus(bus);
=20
     if (pci_bus_is_root(bus)) {
         owner =3D OBJECT(phb);
@@ -1256,21 +1246,16 @@ static void add_drcs(SpaprPhbState *phb, PCIBus *bu=
s, Error **errp)
     }
 }
=20
-static void remove_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
+static void remove_drcs(SpaprPhbState *phb, PCIBus *bus)
 {
     int i;
     uint8_t chassis;
-    Error *local_err =3D NULL;
=20
     if (!phb->dr_enabled) {
         return;
     }
=20
-    chassis =3D chassis_from_bus(bus, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    chassis =3D chassis_from_bus(bus);
=20
     for (i =3D PCI_SLOT_MAX * PCI_FUNC_MAX - 1; i >=3D 0; i--) {
         SpaprDrc *drc =3D drc_from_devfn(phb, chassis, i);
@@ -1488,17 +1473,11 @@ int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMachi=
neState *spapr,
 }
=20
 static void spapr_pci_bridge_plug(SpaprPhbState *phb,
-                                  PCIBridge *bridge,
-                                  Error **errp)
+                                  PCIBridge *bridge)
 {
-    Error *local_err =3D NULL;
     PCIBus *bus =3D pci_bridge_get_sec_bus(bridge);
=20
-    add_drcs(phb, bus, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    add_drcs(phb, bus);
 }
=20
 static void spapr_pci_plug(HotplugHandler *plug_handler,
@@ -1529,11 +1508,7 @@ static void spapr_pci_plug(HotplugHandler *plug_hand=
ler,
     g_assert(drc);
=20
     if (pc->is_bridge) {
-        spapr_pci_bridge_plug(phb, PCI_BRIDGE(plugged_dev), &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
+        spapr_pci_bridge_plug(phb, PCI_BRIDGE(plugged_dev));
     }
=20
     /* Following the QEMU convention used for PCIe multifunction
@@ -1560,12 +1535,7 @@ static void spapr_pci_plug(HotplugHandler *plug_hand=
ler,
         spapr_drc_reset(drc);
     } else if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
         int i;
-        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev), &local_err=
);
-
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
+        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev));
=20
         for (i =3D 0; i < 8; i++) {
             SpaprDrc *func_drc;
@@ -1587,17 +1557,11 @@ out:
 }
=20
 static void spapr_pci_bridge_unplug(SpaprPhbState *phb,
-                                    PCIBridge *bridge,
-                                    Error **errp)
+                                    PCIBridge *bridge)
 {
-    Error *local_err =3D NULL;
     PCIBus *bus =3D pci_bridge_get_sec_bus(bridge);
=20
-    remove_drcs(phb, bus, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    remove_drcs(phb, bus);
 }
=20
 static void spapr_pci_unplug(HotplugHandler *plug_handler,
@@ -1619,11 +1583,7 @@ static void spapr_pci_unplug(HotplugHandler *plug_ha=
ndler,
     pci_device_reset(PCI_DEVICE(plugged_dev));
=20
     if (pc->is_bridge) {
-        Error *local_err =3D NULL;
-        spapr_pci_bridge_unplug(phb, PCI_BRIDGE(plugged_dev), &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-        }
+        spapr_pci_bridge_unplug(phb, PCI_BRIDGE(plugged_dev));
         return;
     }
=20
@@ -1654,13 +1614,7 @@ static void spapr_pci_unplug_request(HotplugHandler =
*plug_handler,
         SpaprDrcClass *func_drck;
         SpaprDREntitySense state;
         int i;
-        Error *local_err =3D NULL;
-        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev), &local_err=
);
-
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
+        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev));
=20
         if (pc->is_bridge) {
             error_setg(errp, "PCI: Hot unplug of PCI bridges not supported=
");
@@ -1741,7 +1695,7 @@ static void spapr_phb_unrealize(DeviceState *dev)
         }
     }
=20
-    remove_drcs(sphb, phb->bus, &error_abort);
+    remove_drcs(sphb, phb->bus);
=20
     for (i =3D PCI_NUM_PINS - 1; i >=3D 0; i--) {
         if (sphb->lsi_table[i].irq) {
@@ -1980,11 +1934,7 @@ static void spapr_phb_realize(DeviceState *dev, Erro=
r **errp)
     }
=20
     /* allocate connectors for child PCI devices */
-    add_drcs(sphb, phb->bus, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto unrealize;
-    }
+    add_drcs(sphb, phb->bus);
=20
     /* DMA setup */
     for (i =3D 0; i < windows_supported; ++i) {
--=20
2.21.1


