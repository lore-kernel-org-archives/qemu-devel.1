Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0397DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43A620733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pVQ871x7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43A620733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5ev-0001Zh-Nb
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kV-0002qv-9A
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kT-00009o-SN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:19 -0500
Received: from ozlabs.org ([203.11.71.1]:52861)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4kT-00082s-GS; Mon, 16 Dec 2019 23:46:17 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWj40twz9sTl; Tue, 17 Dec 2019 15:43:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557825;
 bh=beiPXhsZUwnNaLKV4yJfMDkkiO2d9SgIWAQnhLkMIzo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pVQ871x77OBqoeUI0mrRHDW/ZjzdRSAMuBqHNTRoN863Q0u3/QWKm3HSkWfKcIJNB
 kEyz8txojuu4WxM9tXN4O6Q3N0sGJdiRYNHGpqndGINUB0cXxUkqdLdF86BVIsUb1i
 VYNfInoBpbFX/jzD+LQ7e+nVlb55i3fdoBcQ0MvM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 81/88] ppc/pnv: Introduce PnvChipClass::intc_print_info() method
Date: Tue, 17 Dec 2019 15:43:15 +1100
Message-Id: <20191217044322.351838-82-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The pnv_pic_print_info() callback checks the type of the chip in order
to forward to the request appropriate interrupt controller. This can
be achieved with QOM. Introduce a method for this in the base chip class
and implement it in child classes.

This also prepares ground for the upcoming interrupt controller of POWER1=
0
chips.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157623840755.360005.5002022339473369934.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 30 +++++++++++++++++++++++++-----
 include/hw/ppc/pnv.h |  1 +
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a2ad7258f8..35416d1b3f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -831,6 +831,12 @@ static void pnv_chip_power8_intc_destroy(PnvChip *ch=
ip, PowerPCCPU *cpu)
     pnv_cpu->intc =3D NULL;
 }
=20
+static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *c=
pu,
+                                            Monitor *mon)
+{
+    icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
+}
+
 /*
  *    0:48  Reserved - Read as zeroes
  *   49:52  Node ID
@@ -888,6 +894,12 @@ static void pnv_chip_power9_intc_destroy(PnvChip *ch=
ip, PowerPCCPU *cpu)
     pnv_cpu->intc =3D NULL;
 }
=20
+static void pnv_chip_power9_intc_print_info(PnvChip *chip, PowerPCCPU *c=
pu,
+                                            Monitor *mon)
+{
+    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon);
+}
+
 static void pnv_chip_power10_intc_create(PnvChip *chip, PowerPCCPU *cpu,
                                         Error **errp)
 {
@@ -909,6 +921,11 @@ static void pnv_chip_power10_intc_destroy(PnvChip *c=
hip, PowerPCCPU *cpu)
     pnv_cpu->intc =3D NULL;
 }
=20
+static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *=
cpu,
+                                             Monitor *mon)
+{
+}
+
 /*
  * Allowed core identifiers on a POWER8 Processor Chip :
  *
@@ -1085,6 +1102,7 @@ static void pnv_chip_power8e_class_init(ObjectClass=
 *klass, void *data)
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->intc_reset =3D pnv_chip_power8_intc_reset;
     k->intc_destroy =3D pnv_chip_power8_intc_destroy;
+    k->intc_print_info =3D pnv_chip_power8_intc_print_info;
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
@@ -1106,6 +1124,7 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->intc_reset =3D pnv_chip_power8_intc_reset;
     k->intc_destroy =3D pnv_chip_power8_intc_destroy;
+    k->intc_print_info =3D pnv_chip_power8_intc_print_info;
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
@@ -1127,6 +1146,7 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->intc_reset =3D pnv_chip_power8_intc_reset;
     k->intc_destroy =3D pnv_chip_power8_intc_destroy;
+    k->intc_print_info =3D pnv_chip_power8_intc_print_info;
     k->isa_create =3D pnv_chip_power8nvl_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
@@ -1298,6 +1318,7 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
     k->intc_create =3D pnv_chip_power9_intc_create;
     k->intc_reset =3D pnv_chip_power9_intc_reset;
     k->intc_destroy =3D pnv_chip_power9_intc_destroy;
+    k->intc_print_info =3D pnv_chip_power9_intc_print_info;
     k->isa_create =3D pnv_chip_power9_isa_create;
     k->dt_populate =3D pnv_chip_power9_dt_populate;
     k->pic_print_info =3D pnv_chip_power9_pic_print_info;
@@ -1378,6 +1399,7 @@ static void pnv_chip_power10_class_init(ObjectClass=
 *klass, void *data)
     k->intc_create =3D pnv_chip_power10_intc_create;
     k->intc_reset =3D pnv_chip_power10_intc_reset;
     k->intc_destroy =3D pnv_chip_power10_intc_destroy;
+    k->intc_print_info =3D pnv_chip_power10_intc_print_info;
     k->isa_create =3D pnv_chip_power10_isa_create;
     k->dt_populate =3D pnv_chip_power10_dt_populate;
     k->pic_print_info =3D pnv_chip_power10_pic_print_info;
@@ -1574,11 +1596,9 @@ static void pnv_pic_print_info(InterruptStatsProvi=
der *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        if (pnv_chip_is_power9(pnv->chips[0])) {
-            xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc)=
, mon);
-        } else {
-            icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
-        }
+        /* XXX: loop on each chip/core/thread instead of CPU_FOREACH() *=
/
+        PNV_CHIP_GET_CLASS(pnv->chips[0])->intc_print_info(pnv->chips[0]=
, cpu,
+                                                           mon);
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index c213bdd5ec..7d2402784d 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -133,6 +133,7 @@ typedef struct PnvChipClass {
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
+    void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, Monitor *mon=
);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, Monitor *mon);
--=20
2.23.0


