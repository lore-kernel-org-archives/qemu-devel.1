Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E55FC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1566F20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UbLl3kzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1566F20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5mL-0004F5-3l
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kn-0003Mk-Kw
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4km-0000wd-7t
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:37 -0500
Received: from ozlabs.org ([203.11.71.1]:39065)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4kl-0008WV-SX; Mon, 16 Dec 2019 23:46:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWl0k8gz9sTn; Tue, 17 Dec 2019 15:43:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557827;
 bh=erWSHyC5lwCGEGfTSMrCkh+lwueXLVKO1d9GXDjoZFg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UbLl3kzQV+63G/sw/RVkDN06ZYKPIIMJ2yC5f8Hss5pIffV6kPshKynzPtot83MPM
 QbU7mMsdZwNE7KIaEYF5VkIbERinOn8u/WqwEiycShmGmQyJi1NKspH4qd+oMi+6ZL
 vjvbZI+swxf3Nfxq2RrpjHFeD+gV4wOo6f2WjFHw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 82/88] ppc/pnv: Introduce PnvChipClass::xscom_core_base() method
Date: Tue, 17 Dec 2019 15:43:16 +1100
Message-Id: <20191217044322.351838-83-david@gibson.dropbear.id.au>
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

The pnv_chip_core_realize() function configures the XSCOM MMIO subregion
for each core of a single chip. The base address of the subregion depends
on the CPU type. Its computation is currently open-code using the
pnv_chip_is_powerXX() helpers. This can be achieved with QOM. Introduce
a method for this in the base chip class and implement it in child classe=
s.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157623841311.360005.4705705734873339545.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 31 ++++++++++++++++++++++++-------
 include/hw/ppc/pnv.h |  1 +
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 35416d1b3f..16f4e407ee 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -615,6 +615,24 @@ static void pnv_chip_power9_pic_print_info(PnvChip *=
chip, Monitor *mon)
     pnv_psi_pic_print_info(&chip9->psi, mon);
 }
=20
+static uint64_t pnv_chip_power8_xscom_core_base(PnvChip *chip,
+                                                uint32_t core_id)
+{
+    return PNV_XSCOM_EX_BASE(core_id);
+}
+
+static uint64_t pnv_chip_power9_xscom_core_base(PnvChip *chip,
+                                                uint32_t core_id)
+{
+    return PNV9_XSCOM_EC_BASE(core_id);
+}
+
+static uint64_t pnv_chip_power10_xscom_core_base(PnvChip *chip,
+                                                 uint32_t core_id)
+{
+    return PNV10_XSCOM_EC_BASE(core_id);
+}
+
 static bool pnv_match_cpu(const char *default_type, const char *cpu_type=
)
 {
     PowerPCCPUClass *ppc_default =3D
@@ -1106,6 +1124,7 @@ static void pnv_chip_power8e_class_init(ObjectClass=
 *klass, void *data)
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
+    k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
     dc->desc =3D "PowerNV Chip POWER8E";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1128,6 +1147,7 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
+    k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
     dc->desc =3D "PowerNV Chip POWER8";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1150,6 +1170,7 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
     k->isa_create =3D pnv_chip_power8nvl_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
+    k->xscom_core_base =3D pnv_chip_power8_xscom_core_base;
     dc->desc =3D "PowerNV Chip POWER8NVL";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1322,6 +1343,7 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
     k->isa_create =3D pnv_chip_power9_isa_create;
     k->dt_populate =3D pnv_chip_power9_dt_populate;
     k->pic_print_info =3D pnv_chip_power9_pic_print_info;
+    k->xscom_core_base =3D pnv_chip_power9_xscom_core_base;
     dc->desc =3D "PowerNV Chip POWER9";
=20
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
@@ -1403,6 +1425,7 @@ static void pnv_chip_power10_class_init(ObjectClass=
 *klass, void *data)
     k->isa_create =3D pnv_chip_power10_isa_create;
     k->dt_populate =3D pnv_chip_power10_dt_populate;
     k->pic_print_info =3D pnv_chip_power10_pic_print_info;
+    k->xscom_core_base =3D pnv_chip_power10_xscom_core_base;
     dc->desc =3D "PowerNV Chip POWER10";
=20
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
@@ -1490,13 +1513,7 @@ static void pnv_chip_core_realize(PnvChip *chip, E=
rror **errp)
                                  &error_fatal);
=20
         /* Each core has an XSCOM MMIO region */
-        if (pnv_chip_is_power10(chip)) {
-            xscom_core_base =3D PNV10_XSCOM_EC_BASE(core_hwid);
-        } else if (pnv_chip_is_power9(chip)) {
-            xscom_core_base =3D PNV9_XSCOM_EC_BASE(core_hwid);
-        } else {
-            xscom_core_base =3D PNV_XSCOM_EX_BASE(core_hwid);
-        }
+        xscom_core_base =3D pcc->xscom_core_base(chip, core_hwid);
=20
         pnv_xscom_add_subregion(chip, xscom_core_base,
                                 &pnv_core->xscom_regs);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 7d2402784d..17ca9a14ac 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -137,6 +137,7 @@ typedef struct PnvChipClass {
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, Monitor *mon);
+    uint64_t (*xscom_core_base)(PnvChip *chip, uint32_t core_id);
 } PnvChipClass;
=20
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
--=20
2.23.0


