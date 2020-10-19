Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9285EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091662225A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091662225A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQsc-0006kw-Vz
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUQr6-0004zV-34
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:49:24 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:52764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUQr4-00032L-Hs
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:49:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-NxMkSShpNWKOqL-VLApkkQ-1; Mon, 19 Oct 2020 04:49:15 -0400
X-MC-Unique: NxMkSShpNWKOqL-VLApkkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB5451060DD8;
 Mon, 19 Oct 2020 08:49:11 +0000 (UTC)
Received: from bahia.lan (ovpn-112-78.ams2.redhat.com [10.36.112.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B21177367B;
 Mon, 19 Oct 2020 08:49:02 +0000 (UTC)
Subject: [PATCH 5/5] spapr: Simplify error handling in spapr_memory_plug()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 19 Oct 2020 10:49:01 +0200
Message-ID: <160309734178.2739814.3488437759887793902.stgit@bahia.lan>
In-Reply-To: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 04:48:02
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As recommended in "qapi/error.h", add a bool return value to
spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
of local_err in spapr_memory_plug().

This allows to get rid of the error propagation overhead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c                |   23 ++++++++++-------------
 hw/ppc/spapr_nvdimm.c         |    5 +++--
 include/hw/ppc/spapr_nvdimm.h |    2 +-
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 62f217a6b914..0cc19b5863a4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3382,7 +3382,7 @@ int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachine=
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
@@ -3403,7 +3403,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t=
 addr_start, uint64_t size,
                                       addr / SPAPR_MEMORY_BLOCK_SIZE);
                 spapr_drc_detach(drc);
             }
-            return;
+            return false;
         }
         if (!hotplugged) {
             spapr_drc_reset(drc);
@@ -3425,12 +3425,12 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
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
     SpaprMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     uint64_t size, addr;
@@ -3444,27 +3444,24 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
     if (!is_nvdimm) {
         addr =3D object_property_get_uint(OBJECT(dimm),
                                         PC_DIMM_ADDR_PROP, &error_abort);
-        spapr_add_lmbs(dev, addr, size,
-                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
-                       &local_err);
+        if (!spapr_add_lmbs(dev, addr, size,
+                            spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT), errp=
)) {
+            goto out_unplug;
+        }
     } else {
         slot =3D object_property_get_int(OBJECT(dimm),
                                        PC_DIMM_SLOT_PROP, &error_abort);
         /* We should have valid slot number at this point */
         g_assert(slot >=3D 0);
-        spapr_add_nvdimm(dev, slot, &local_err);
-    }
-
-    if (local_err) {
-        goto out_unplug;
+        if (!spapr_add_nvdimm(dev, slot, errp)) {
+            goto out_unplug;
+        }
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
index 9e3d94071fe1..a833a63b5ed3 100644
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
 static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index 490b19a009f4..344582d2f5f7 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -30,6 +30,6 @@ int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineSta=
te *spapr,
 void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt);
 bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdi=
mm,
                            uint64_t size, Error **errp);
-void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
+bool spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
=20
 #endif



