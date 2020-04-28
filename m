Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B912CC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8410A20757
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7czX2vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8410A20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTWa-0004FD-L2
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTFV-00071b-WF
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTCK-0001R1-9G
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTTCJ-0001Lc-OW
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQwH1VpDlSEnLSU0fZuHsUOtlyQNckNkOd5+9Gq8oIk=;
 b=b7czX2vj+HoY3Rqjj4k6tLDEwJtxGTeVgnmMfo1tLJInV3j37su9HoiwlpfNrhhk0cs8Gq
 oNaRYM2rterlFIrmYlyHTzBDSVAC8RdM/1gr/BJyhnHOjcGeMh3UOEkHXajwi/Z3VYkYrO
 O1W7PPZxKj3KJnJLKSS1LFuTSSEPphs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-x6PanweUNH6fBdDXM9hYGQ-1; Tue, 28 Apr 2020 12:34:32 -0400
X-MC-Unique: x6PanweUNH6fBdDXM9hYGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5B381895A33;
 Tue, 28 Apr 2020 16:34:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEDDB5DA6A;
 Tue, 28 Apr 2020 16:34:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37EA911358CD; Tue, 28 Apr 2020 18:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/17] spapr_pci: Drop some dead error handling
Date: Tue, 28 Apr 2020 18:34:18 +0200
Message-Id: <20200428163419.4483-17-armbru@redhat.com>
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-ppc@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

chassis_from_bus() uses object_property_get_uint() to get property
"chassis_nr" of the bridge device.  Failure would be a programming
error.  Pass &error_abort, and simplify its callers.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


