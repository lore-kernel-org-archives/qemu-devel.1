Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C30C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2838A20759
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2838A20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnmp-0007GQ-6F
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhr-0006fZ-Qf
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnho-0000jU-B0
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:39 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-Km16BvvtM6i7GxzKA3sAfQ-1; Mon, 14 Sep 2020 08:35:31 -0400
X-MC-Unique: Km16BvvtM6i7GxzKA3sAfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D162E1084D62;
 Mon, 14 Sep 2020 12:35:29 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8127B105509D;
 Mon, 14 Sep 2020 12:35:28 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/15] spapr: Add a return value to spapr_drc_attach()
Date: Mon, 14 Sep 2020 14:34:58 +0200
Message-Id: <20200914123505.612812-9-groug@kaod.org>
In-Reply-To: <20200914123505.612812-1-groug@kaod.org>
References: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Greg Kurz <groug@kaod.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As recommended in "qapi/error.h", return true on success and false on
failure. This allows to reduce error propagation overhead in the callers.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/hw/ppc/spapr_drc.h |  2 +-
 hw/ppc/spapr.c             | 15 +++------------
 hw/ppc/spapr_drc.c         |  5 +++--
 hw/ppc/spapr_nvdimm.c      |  5 +----
 hw/ppc/spapr_pci.c         |  5 +----
 5 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f2708607696e..165b281496bb 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -235,7 +235,7 @@ SpaprDrc *spapr_drc_by_index(uint32_t index);
 SpaprDrc *spapr_drc_by_id(const char *type, uint32_t id);
 int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_m=
ask);
=20
-void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp);
+bool spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp);
 void spapr_drc_detach(SpaprDrc *drc);
=20
 /* Returns true if a hot plug/unplug request is pending */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c0a3f5f26d97..8b2b4e6272e6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3374,22 +3374,19 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
     int i;
     uint64_t addr =3D addr_start;
     bool hotplugged =3D spapr_drc_hotplugged(dev);
-    Error *local_err =3D NULL;
=20
     for (i =3D 0; i < nr_lmbs; i++) {
         drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
                               addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
=20
-        spapr_drc_attach(drc, dev, &local_err);
-        if (local_err) {
+        if (!spapr_drc_attach(drc, dev, errp)) {
             while (addr > addr_start) {
                 addr -=3D SPAPR_MEMORY_BLOCK_SIZE;
                 drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
                                       addr / SPAPR_MEMORY_BLOCK_SIZE);
                 spapr_drc_detach(drc);
             }
-            error_propagate(errp, local_err);
             return;
         }
         if (!hotplugged) {
@@ -3770,7 +3767,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_d=
ev, DeviceState *dev,
     CPUCore *cc =3D CPU_CORE(dev);
     CPUState *cs;
     SpaprDrc *drc;
-    Error *local_err =3D NULL;
     CPUArchId *core_slot;
     int index;
     bool hotplugged =3D spapr_drc_hotplugged(dev);
@@ -3788,9 +3784,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_d=
ev, DeviceState *dev,
     g_assert(drc || !mc->has_hotpluggable_cpus);
=20
     if (drc) {
-        spapr_drc_attach(drc, dev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!spapr_drc_attach(drc, dev, errp)) {
             return;
         }
=20
@@ -3942,7 +3936,6 @@ static void spapr_phb_plug(HotplugHandler *hotplug_de=
v, DeviceState *dev,
     SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
     SpaprDrc *drc;
     bool hotplugged =3D spapr_drc_hotplugged(dev);
-    Error *local_err =3D NULL;
=20
     if (!smc->dr_phb_enabled) {
         return;
@@ -3952,9 +3945,7 @@ static void spapr_phb_plug(HotplugHandler *hotplug_de=
v, DeviceState *dev,
     /* hotplug hooks should check it's enabled before getting this far */
     assert(drc);
=20
-    spapr_drc_attach(drc, dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!spapr_drc_attach(drc, dev, errp)) {
         return;
     }
=20
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index fe998d8108b1..04a6bf134ee8 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -371,13 +371,13 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
     } while (fdt_depth !=3D 0);
 }
=20
-void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp)
+bool spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp)
 {
     trace_spapr_drc_attach(spapr_drc_index(drc));
=20
     if (drc->dev) {
         error_setg(errp, "an attached device is still awaiting release");
-        return;
+        return false;
     }
     g_assert((drc->state =3D=3D SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
              || (drc->state =3D=3D SPAPR_DRC_STATE_PHYSICAL_POWERON));
@@ -388,6 +388,7 @@ void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Er=
ror **errp)
                              object_get_typename(OBJECT(drc->dev)),
                              (Object **)(&drc->dev),
                              NULL, 0);
+    return true;
 }
=20
 static void spapr_drc_release(SpaprDrc *drc)
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 63872054f375..c06f903e5bff 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -91,14 +91,11 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, =
Error **errp)
 {
     SpaprDrc *drc;
     bool hotplugged =3D spapr_drc_hotplugged(dev);
-    Error *local_err =3D NULL;
=20
     drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
     g_assert(drc);
=20
-    spapr_drc_attach(drc, dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!spapr_drc_attach(drc, dev, errp)) {
         return;
     }
=20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 4d97ff6c70f2..30d054a4d04c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1539,7 +1539,6 @@ static void spapr_pci_plug(HotplugHandler *plug_handl=
er,
     PCIDevice *pdev =3D PCI_DEVICE(plugged_dev);
     PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(plugged_dev);
     SpaprDrc *drc =3D drc_from_dev(phb, pdev);
-    Error *local_err =3D NULL;
     PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
     uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
=20
@@ -1578,9 +1577,7 @@ static void spapr_pci_plug(HotplugHandler *plug_handl=
er,
         return;
     }
=20
-    spapr_drc_attach(drc, DEVICE(pdev), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!spapr_drc_attach(drc, DEVICE(pdev), errp)) {
         return;
     }
=20
--=20
2.26.2


