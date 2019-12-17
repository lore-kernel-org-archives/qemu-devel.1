Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F1DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F212072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G+ehzKJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F212072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih58A-000334-QE
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iq-0000p0-8o
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4in-0006FU-Qv
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:35 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33735 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4in-0005nf-G2; Mon, 16 Dec 2019 23:44:33 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWW2zbBz9sSw; Tue, 17 Dec 2019 15:43:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557815;
 bh=aHFtWdrb+8pmavyOXG6lJ9YUtDF+TfjGta6fhwbERI0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G+ehzKJr/jacEzz1apPYITGlMaQ3ZYh6IIbfqXXJdeVFPa/aszwAPQzL3FbdVwvU0
 HXQKqpyYDI7EewCmGMsy+yOSEOvN7UWakwgowdXpuN0Fm+rKMIJVcXhmVd0gSSlbx9
 6wrAaJMbUnFOikW7MmIDHvxslptdRkjAe+mvVKvg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 29/88] ppc/pnv: Instantiate cores separately
Date: Tue, 17 Dec 2019 15:42:23 +1100
Message-Id: <20191217044322.351838-30-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Allocating a big void * array to store multiple objects isn't a
recommended practice for various reasons:
 - no compile time type checking
 - potential dangling pointers if a reference on an individual is
  taken and the array is freed later on
 - duplicate boiler plate everywhere the array is browsed through

Allocate an array of pointers and populate it instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 30 ++++++++++++------------------
 include/hw/ppc/pnv.h |  2 +-
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f0adb06c8d..d899c83e52 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -280,14 +280,12 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, ui=
nt32_t pir,
=20
 static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
 {
-    const char *typename =3D pnv_chip_core_typename(chip);
-    size_t typesize =3D object_type_get_instance_size(typename);
     int i;
=20
     pnv_dt_xscom(chip, fdt, 0);
=20
     for (i =3D 0; i < chip->nr_cores; i++) {
-        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
+        PnvCore *pnv_core =3D chip->cores[i];
=20
         pnv_dt_core(chip, pnv_core, fdt);
=20
@@ -302,14 +300,12 @@ static void pnv_chip_power8_dt_populate(PnvChip *ch=
ip, void *fdt)
=20
 static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 {
-    const char *typename =3D pnv_chip_core_typename(chip);
-    size_t typesize =3D object_type_get_instance_size(typename);
     int i;
=20
     pnv_dt_xscom(chip, fdt, 0);
=20
     for (i =3D 0; i < chip->nr_cores; i++) {
-        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
+        PnvCore *pnv_core =3D chip->cores[i];
=20
         pnv_dt_core(chip, pnv_core, fdt);
     }
@@ -913,8 +909,6 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Err=
or **errp)
  {
     PnvChip *chip =3D PNV_CHIP(chip8);
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
-    const char *typename =3D pnv_chip_core_typename(chip);
-    size_t typesize =3D object_type_get_instance_size(typename);
     int i, j;
     char *name;
     XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
@@ -928,7 +922,7 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Err=
or **errp)
=20
     /* Map the ICP registers for each thread */
     for (i =3D 0; i < chip->nr_cores; i++) {
-        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
+        PnvCore *pnv_core =3D chip->cores[i];
         int core_hwid =3D CPU_CORE(pnv_core)->core_id;
=20
         for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
@@ -1108,8 +1102,6 @@ static void pnv_chip_power9_instance_init(Object *o=
bj)
 static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
 {
     PnvChip *chip =3D PNV_CHIP(chip9);
-    const char *typename =3D pnv_chip_core_typename(chip);
-    size_t typesize =3D object_type_get_instance_size(typename);
     int i;
=20
     chip9->nr_quads =3D DIV_ROUND_UP(chip->nr_cores, 4);
@@ -1118,7 +1110,7 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9, =
Error **errp)
     for (i =3D 0; i < chip9->nr_quads; i++) {
         char eq_name[32];
         PnvQuad *eq =3D &chip9->quads[i];
-        PnvCore *pnv_core =3D PNV_CORE(chip->cores + (i * 4) * typesize)=
;
+        PnvCore *pnv_core =3D chip->cores[i * 4];
         int core_id =3D CPU_CORE(pnv_core)->core_id;
=20
         snprintf(eq_name, sizeof(eq_name), "eq[%d]", core_id);
@@ -1290,7 +1282,6 @@ static void pnv_chip_core_realize(PnvChip *chip, Er=
ror **errp)
     Error *error =3D NULL;
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
     const char *typename =3D pnv_chip_core_typename(chip);
-    size_t typesize =3D object_type_get_instance_size(typename);
     int i, core_hwid;
=20
     if (!object_class_by_name(typename)) {
@@ -1305,21 +1296,24 @@ static void pnv_chip_core_realize(PnvChip *chip, =
Error **errp)
         return;
     }
=20
-    chip->cores =3D g_malloc0(typesize * chip->nr_cores);
+    chip->cores =3D g_new0(PnvCore *, chip->nr_cores);
=20
     for (i =3D 0, core_hwid =3D 0; (core_hwid < sizeof(chip->cores_mask)=
 * 8)
              && (i < chip->nr_cores); core_hwid++) {
         char core_name[32];
-        void *pnv_core =3D chip->cores + i * typesize;
+        PnvCore *pnv_core;
         uint64_t xscom_core_base;
=20
         if (!(chip->cores_mask & (1ull << core_hwid))) {
             continue;
         }
=20
+        pnv_core =3D PNV_CORE(object_new(typename));
+
         snprintf(core_name, sizeof(core_name), "core[%d]", core_hwid);
-        object_initialize_child(OBJECT(chip), core_name, pnv_core, types=
ize,
-                                typename, &error_fatal, NULL);
+        object_property_add_child(OBJECT(chip), core_name, OBJECT(pnv_co=
re),
+                                  &error_abort);
+        chip->cores[i] =3D pnv_core;
         object_property_set_int(OBJECT(pnv_core), ms->smp.threads, "nr-t=
hreads",
                                 &error_fatal);
         object_property_set_int(OBJECT(pnv_core), core_hwid,
@@ -1340,7 +1334,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Er=
ror **errp)
         }
=20
         pnv_xscom_add_subregion(chip, xscom_core_base,
-                                &PNV_CORE(pnv_core)->xscom_regs);
+                                &pnv_core->xscom_regs);
         i++;
     }
 }
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 90f1343ed0..03cb429f21 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -56,7 +56,7 @@ typedef struct PnvChip {
=20
     uint32_t     nr_cores;
     uint64_t     cores_mask;
-    void         *cores;
+    PnvCore      **cores;
=20
     MemoryRegion xscom_mmio;
     MemoryRegion xscom;
--=20
2.23.0


