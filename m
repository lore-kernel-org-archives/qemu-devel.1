Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B13C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEAE20771
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEAE20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnp8-0003nb-GL
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhz-0006yE-N6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:47 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:60426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhx-0000lw-Tr
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:47 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-WUr8KAl9MNKJV4O3UKnRYw-1; Mon, 14 Sep 2020 08:35:41 -0400
X-MC-Unique: WUr8KAl9MNKJV4O3UKnRYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF70A18BA288;
 Mon, 14 Sep 2020 12:35:39 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E0ED10023A7;
 Mon, 14 Sep 2020 12:35:38 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/15] spapr: Simplify error handling in spapr_memory_plug()
Date: Mon, 14 Sep 2020 14:35:04 +0200
Message-Id: <20200914123505.612812-15-groug@kaod.org>
In-Reply-To: <20200914123505.612812-1-groug@kaod.org>
References: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 08:35:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

As recommended in "qapi/error.h", add a bool return value to
spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
of local_err in spapr_memory_plug().

Since object_property_get_uint() only returns 0 on failure, use
that as well.

Also call ERRP_GUARD() to be able to check the status of void
function pc_dimm_plug() with *errp.

This allows to get rid of the error propagation overhead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/hw/ppc/spapr_nvdimm.h |  2 +-
 hw/ppc/spapr.c                | 35 +++++++++++++----------------------
 hw/ppc/spapr_nvdimm.c         |  5 +++--
 3 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index b834d82f5545..dc30edece997 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -30,7 +30,7 @@ int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineSta=
te *spapr,
 void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt);
 bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdi=
mm,
                            uint64_t size, Error **errp);
-void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
+bool spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
 void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
=20
 #endif
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e813c7cfb949..d6b4de6a1c53 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3366,7 +3366,7 @@ int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachine=
State *spapr,
     return 0;
 }
=20
-static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t=
 size,
+static bool spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t=
 size,
                            bool dedicated_hp_event_source, Error **errp)
 {
     SpaprDrc *drc;
@@ -3387,7 +3387,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t=
 addr_start, uint64_t size,
                                       addr / SPAPR_MEMORY_BLOCK_SIZE);
                 spapr_drc_detach(drc);
             }
-            return;
+            return false;
         }
         if (!hotplugged) {
             spapr_drc_reset(drc);
@@ -3409,12 +3409,13 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
                                            nr_lmbs);
         }
     }
+    return true;
 }
=20
 static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *de=
v,
                               Error **errp)
 {
-    Error *local_err =3D NULL;
+    ERRP_GUARD();
     SpaprMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     uint64_t size, addr, slot;
@@ -3422,39 +3423,29 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
=20
     size =3D memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abor=
t);
=20
-    pc_dimm_plug(dimm, MACHINE(ms), &local_err);
-    if (local_err) {
-        goto out;
+    pc_dimm_plug(dimm, MACHINE(ms), errp);
+    if (*errp) {
+        return;
     }
=20
     if (!is_nvdimm) {
-        addr =3D object_property_get_uint(OBJECT(dimm),
-                                        PC_DIMM_ADDR_PROP, &local_err);
-        if (local_err) {
+        addr =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,=
 errp);
+        if (!addr ||
+            !spapr_add_lmbs(dev, addr, size,
+                            spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT), errp=
)) {
             goto out_unplug;
         }
-        spapr_add_lmbs(dev, addr, size,
-                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
-                       &local_err);
     } else {
-        slot =3D object_property_get_uint(OBJECT(dimm),
-                                        PC_DIMM_SLOT_PROP, &local_err);
-        if (local_err) {
+        slot =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_SLOT_PROP,=
 errp);
+        if (!slot || !spapr_add_nvdimm(dev, slot, errp)) {
             goto out_unplug;
         }
-        spapr_add_nvdimm(dev, slot, &local_err);
-    }
-
-    if (local_err) {
-        goto out_unplug;
     }
=20
     return;
=20
 out_unplug:
     pc_dimm_unplug(dimm, MACHINE(ms));
-out:
-    error_propagate(errp, local_err);
 }
=20
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index b3a489e9fe18..361ac8c28e33 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -89,7 +89,7 @@ bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, N=
VDIMMDevice *nvdimm,
 }
=20
=20
-void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
+bool spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
 {
     SpaprDrc *drc;
     bool hotplugged =3D spapr_drc_hotplugged(dev);
@@ -98,12 +98,13 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, =
Error **errp)
     g_assert(drc);
=20
     if (!spapr_drc_attach(drc, dev, errp)) {
-        return;
+        return false;
     }
=20
     if (hotplugged) {
         spapr_hotplug_req_add_by_index(drc);
     }
+    return true;
 }
=20
 void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
--=20
2.26.2


