Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B265FC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E02320705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NVazueh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E02320705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3z5-0001Ji-4H
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oc-0003tv-SJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3ob-0002lh-2e
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:34 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37531 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oa-0002hh-MB; Wed, 08 Jan 2020 00:23:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMC2D23z9sSf; Wed,  8 Jan 2020 16:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460999;
 bh=pyebuMBw3ms/ikfLlL+4BIuNnNMNU0G7ZtDbW5bCLxs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NVazueh+YdVTr3b4MoAS7rD2S2+vtQRDHEtFtswsAJROKN+NcHaC6K41G6hrTYIFn
 omDNIg02upNE35vHeks05cZpYQY1nOa1T2tlfOhGWRZltLdbdbN0PK2aHWtlnJJ6R5
 2+cJLpYu2Qft4Ic6zswJQfizzUGD6vkP79QpXc7A=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 14/26] ppc/pnv: Introduce a "xics" property under the POWER8
 chip
Date: Wed,  8 Jan 2020 16:23:00 +1100
Message-Id: <20200108052312.238710-15-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

POWER8 is the only chip using the XICS interface. Add a "xics" link
and a XICSFabric attribute under this chip to remove the use of
qdev_get_machine()

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20200106145645.4539-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 24 +++++++++++++++++++-----
 include/hw/ppc/pnv.h |  2 ++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 90e92e82c5..65cba84335 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -802,6 +802,13 @@ static void pnv_init(MachineState *machine)
                                 &error_fatal);
         object_property_set_int(chip, machine->smp.cores,
                                 "nr-cores", &error_fatal);
+        /*
+         * The POWER8 machine use the XICS interrupt interface.
+         * Propagate the XICS fabric to the chip and its controllers.
+         */
+        if (object_dynamic_cast(OBJECT(pnv), TYPE_XICS_FABRIC)) {
+            object_property_set_link(chip, OBJECT(pnv), "xics", &error_a=
bort);
+        }
         object_property_set_bool(chip, true, "realized", &error_fatal);
     }
     g_free(chip_typename);
@@ -843,12 +850,12 @@ static uint32_t pnv_chip_core_pir_p8(PnvChip *chip,=
 uint32_t core_id)
 static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
                                         Error **errp)
 {
+    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
     Error *local_err =3D NULL;
     Object *obj;
     PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
=20
-    obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, XICS_FABRIC(qdev_get_m=
achine()),
-                     &local_err);
+    obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, chip8->xics, &local_er=
r);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1002,6 +1009,12 @@ static void pnv_chip_power8_instance_init(Object *=
obj)
 {
     Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
=20
+    object_property_add_link(obj, "xics", TYPE_XICS_FABRIC,
+                             (Object **)&chip8->xics,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_STRONG,
+                             &error_abort);
+
     object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi)=
,
                             TYPE_PNV8_PSI, &error_abort, NULL);
=20
@@ -1021,7 +1034,6 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, E=
rror **errp)
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
     int i, j;
     char *name;
-    XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
=20
     name =3D g_strdup_printf("icp-%x", chip->chip_id);
     memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZ=
E);
@@ -1037,7 +1049,7 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, E=
rror **errp)
=20
         for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
             uint32_t pir =3D pcc->core_pir(chip, core_hwid) + j;
-            PnvICPState *icp =3D PNV_ICP(xics_icp_get(xi, pir));
+            PnvICPState *icp =3D PNV_ICP(xics_icp_get(chip8->xics, pir))=
;
=20
             memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
                                         &icp->mmio);
@@ -1053,6 +1065,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
     Pnv8Psi *psi8 =3D &chip8->psi;
     Error *local_err =3D NULL;
=20
+    assert(chip8->xics);
+
     /* XSCOM bridge is first */
     pnv_xscom_realize(chip, PNV_XSCOM_SIZE, &local_err);
     if (local_err) {
@@ -1070,7 +1084,7 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip8->psi), PNV_PSIHB_BASE(chip),
                             "bar", &error_fatal);
-    object_property_set_link(OBJECT(&chip8->psi), OBJECT(qdev_get_machin=
e()),
+    object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip8->xics),
                              ICS_PROP_XICS, &error_abort);
     object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &loc=
al_err);
     if (local_err) {
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f78fd0dd96..56277862dd 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -72,6 +72,8 @@ typedef struct Pnv8Chip {
     Pnv8Psi      psi;
     PnvOCC       occ;
     PnvHomer     homer;
+
+    XICSFabric    *xics;
 } Pnv8Chip;
=20
 #define TYPE_PNV9_CHIP "pnv9-chip"
--=20
2.24.1


