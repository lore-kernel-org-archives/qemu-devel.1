Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F89C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2338227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2338227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0LH-0004Ap-HO
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ii0Hp-0000LF-NT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ii0Ho-0003M9-DR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:33 -0500
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:42168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ii0Ho-0003DH-4A
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:32 -0500
Received: from player734.ha.ovh.net (unknown [10.108.16.42])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 83238263637
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 19:12:30 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id DB1BAD6D632E;
 Thu, 19 Dec 2019 18:12:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 04/13] ppc/pnv: Introduce a "xics" property under the
 POWER8 chip
Date: Thu, 19 Dec 2019 19:11:46 +0100
Message-Id: <20191219181155.32530-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219181155.32530-1-clg@kaod.org>
References: <20191219181155.32530-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 13658854720716966886
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdduuddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepud
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.107.29
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

POWER8 is the only chip using the XICS interface. Add a "xics" link
and a XICSFabric attribute under this chip to remove the use of
qdev_get_machine()

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  2 ++
 hw/ppc/pnv.c         | 26 ++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f31180618672..8b957dfb5736 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -74,6 +74,8 @@ typedef struct Pnv8Chip {
     Pnv8Psi      psi;
     PnvOCC       occ;
     PnvHomer     homer;
+
+    XICSFabric    *xics;
 } Pnv8Chip;
=20
 #define TYPE_PNV9_CHIP "pnv9-chip"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 163a658806e2..2a1b15a69aed 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -797,6 +797,13 @@ static void pnv_init(MachineState *machine)
          */
         object_property_set_link(chip, OBJECT(sysmem), "system-memory",
                                  &error_abort);
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
@@ -838,12 +845,12 @@ static uint32_t pnv_chip_core_pir_p8(PnvChip *chip,=
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
@@ -997,6 +1004,12 @@ static void pnv_chip_power8_instance_init(Object *o=
bj)
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
@@ -1016,7 +1029,6 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, E=
rror **errp)
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
     int i, j;
     char *name;
-    XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
=20
     name =3D g_strdup_printf("icp-%x", chip->chip_id);
     memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZ=
E);
@@ -1032,7 +1044,7 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, E=
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
@@ -1048,6 +1060,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
     Pnv8Psi *psi8 =3D &chip8->psi;
     Error *local_err =3D NULL;
=20
+    assert(chip8->xics);
+
     /* XSCOM bridge is first */
     pnv_xscom_realize(chip, PNV_XSCOM_SIZE, &local_err);
     if (local_err) {
@@ -1067,8 +1081,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
                             "bar", &error_fatal);
     object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip->system_me=
mory),
                              "system-memory", &error_abort);
-    object_property_set_link(OBJECT(&chip8->psi), OBJECT(qdev_get_machin=
e()),
-                             ICS_PROP_XICS, &error_abort);
+    object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip8->xics),
+                              ICS_PROP_XICS, &error_abort);
     object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &loc=
al_err);
     if (local_err) {
         error_propagate(errp, local_err);
--=20
2.21.0


