Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BF0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1C720771
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1C720771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnoW-0002NK-P0
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhv-0006pL-TQ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:43 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:52226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhu-0000l9-7d
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:43 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-791W7vbJM1OJDub1wcFMPQ-1; Mon, 14 Sep 2020 08:35:37 -0400
X-MC-Unique: 791W7vbJM1OJDub1wcFMPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 642C2801F9A;
 Mon, 14 Sep 2020 12:35:36 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 140B41002393;
 Mon, 14 Sep 2020 12:35:34 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/15] spapr: Add a return value to spapr_nvdimm_validate()
Date: Mon, 14 Sep 2020 14:35:02 +0200
Message-Id: <20200914123505.612812-13-groug@kaod.org>
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
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 08:35:33
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

As recommended in "qapi/error.h", return true on success and false on
failure. This allows to reduce error propagation overhead in the callers.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/hw/ppc/spapr_nvdimm.h |  2 +-
 hw/ppc/spapr.c                |  4 +---
 hw/ppc/spapr_nvdimm.c         | 14 ++++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index 3eb344e8e976..b834d82f5545 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -28,7 +28,7 @@ QEMU_BUILD_BUG_ON(SPAPR_MINIMUM_SCM_BLOCK_SIZE % SPAPR_ME=
MORY_BLOCK_SIZE);
 int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **errp)=
;
 void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt);
-void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdi=
mm,
+bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdi=
mm,
                            uint64_t size, Error **errp);
 void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
 void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e11472a53ab4..bfa2a00da77e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3481,9 +3481,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
     }
=20
     if (is_nvdimm) {
-        spapr_nvdimm_validate(hotplug_dev, NVDIMM(dev), size, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!spapr_nvdimm_validate(hotplug_dev, NVDIMM(dev), size, errp)) =
{
             return;
         }
     } else if (size % SPAPR_MEMORY_BLOCK_SIZE) {
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index c06f903e5bff..b3a489e9fe18 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -33,7 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/ppc/spapr_numa.h"
=20
-void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdi=
mm,
+bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdi=
mm,
                            uint64_t size, Error **errp)
 {
     const MachineClass *mc =3D MACHINE_GET_CLASS(hotplug_dev);
@@ -45,7 +45,7 @@ void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, N=
VDIMMDevice *nvdimm,
=20
     if (!mc->nvdimm_supported) {
         error_setg(errp, "NVDIMM hotplug not supported for this machine");
-        return;
+        return false;
     }
=20
     /*
@@ -59,20 +59,20 @@ void spapr_nvdimm_validate(HotplugHandler *hotplug_dev,=
 NVDIMMDevice *nvdimm,
      */
     if (!ms->nvdimms_state->is_enabled && nvdimm_opt) {
         error_setg(errp, "nvdimm device found but 'nvdimm=3Doff' was set")=
;
-        return;
+        return false;
     }
=20
     if (object_property_get_int(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
                                 &error_abort) =3D=3D 0) {
         error_setg(errp, "PAPR requires NVDIMM devices to have label-size =
set");
-        return;
+        return false;
     }
=20
     if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
         error_setg(errp, "PAPR requires NVDIMM memory size (excluding labe=
l)"
                    " to be a multiple of %" PRIu64 "MB",
                    SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
-        return;
+        return false;
     }
=20
     uuidstr =3D object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP,
@@ -82,8 +82,10 @@ void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, =
NVDIMMDevice *nvdimm,
=20
     if (qemu_uuid_is_null(&uuid)) {
         error_setg(errp, "NVDIMM device requires the uuid to be set");
-        return;
+        return false;
     }
+
+    return true;
 }
=20
=20
--=20
2.26.2


