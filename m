Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1008C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CCD2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CCD2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRuxZ-0003kB-B2
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kRurm-00059P-F8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:15:42 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:53698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kRurl-0004iK-3l
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:15:42 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-58ZJxrYaNZqJpperwHOmUw-1; Mon, 12 Oct 2020 06:15:26 -0400
X-MC-Unique: 58ZJxrYaNZqJpperwHOmUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F2891921FB0;
 Mon, 12 Oct 2020 10:15:24 +0000 (UTC)
Received: from bahia.lan (ovpn-112-78.ams2.redhat.com [10.36.112.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 917CD1002382;
 Mon, 12 Oct 2020 10:15:22 +0000 (UTC)
Subject: [PATCH] spapr: Move spapr_create_nvdimm_dr_connectors() to core
 machine code
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Oct 2020 12:15:21 +0200
Message-ID: <160249772183.757627.7396780936543977766.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 06:15:30
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The spapr_create_nvdimm_dr_connectors() function doesn't need to access
any internal details of the sPAPR NVDIMM implementation. Also, pretty
much like for the LMBs, only spapr_machine_init() is responsible for the
creation of DR connectors for NVDIMMs.

Make this clear by making this function static in hw/ppc/spapr.c.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c                |   10 ++++++++++
 hw/ppc/spapr_nvdimm.c         |   11 -----------
 include/hw/ppc/spapr_nvdimm.h |    1 -
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 63315f2d0fa9..ee716a12af73 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2641,6 +2641,16 @@ static hwaddr spapr_rma_size(SpaprMachineState *spap=
r, Error **errp)
     return rma_size;
 }
=20
+static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
+{
+    MachineState *machine =3D MACHINE(spapr);
+    int i;
+
+    for (i =3D 0; i < machine->ram_slots; i++) {
+        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
+    }
+}
+
 /* pSeries LPAR / sPAPR hardware init */
 static void spapr_machine_init(MachineState *machine)
 {
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index b3a489e9fe18..9e3d94071fe1 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -106,17 +106,6 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t slot,=
 Error **errp)
     }
 }
=20
-void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
-{
-    MachineState *machine =3D MACHINE(spapr);
-    int i;
-
-    for (i =3D 0; i < machine->ram_slots; i++) {
-        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
-    }
-}
-
-
 static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
                            int parent_offset, NVDIMMDevice *nvdimm)
 {
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index b834d82f5545..490b19a009f4 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -31,6 +31,5 @@ void spapr_dt_persistent_memory(SpaprMachineState *spapr,=
 void *fdt);
 bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdi=
mm,
                            uint64_t size, Error **errp);
 void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
-void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
=20
 #endif



