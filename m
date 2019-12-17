Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00968C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DC020733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LUl5y+Us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DC020733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5ZN-0002cK-Jt
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kX-0002uQ-EZ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kW-0000EV-4t
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:21 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48539 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4kV-0000AG-Qc; Mon, 16 Dec 2019 23:46:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWl3KnJz9sRp; Tue, 17 Dec 2019 15:43:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557827;
 bh=np9HcZx1KFwcdtSNbC/6aMTF85SHkdWiNq+VeNbUHxQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LUl5y+UsDMwQYqxEFOcV16ZS9koA9Tz8+pPDbG85i5MtOHrsBJnC+aISTYUzTNysj
 +/zOWpd4gW6DbNwyokYI6lUTLoXCoQrbWb9ImjDG9Xm/XVGrv8lJvHsq6vrImedbmR
 TA59GeT4QAePL0kt87Rdyt7z7sLGnitBROwY3gxw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 76/88] ppc/pnv: Introduce PnvPsiClass::compat
Date: Tue, 17 Dec 2019 15:43:10 +1100
Message-Id: <20191217044322.351838-77-david@gibson.dropbear.id.au>
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

The Processor Service Interface (PSI) model has a chip_type class level
attribute, which is used to generate the content of the "compatible" DT
property according to the CPU type.

Since the PSI model already has specialized classes for each supported
CPU type, it seems cleaner to achieve this with QOM. Provide the content
of the "compatible" property with a new class level attribute.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157623837974.360005.14706607446188964477.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_psi.c         | 25 +++++++++++--------------
 include/hw/ppc/pnv_psi.h |  2 ++
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 572924388b..98a82b25e0 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -536,10 +536,6 @@ static void pnv_psi_power8_realize(DeviceState *dev,=
 Error **errp)
     qemu_register_reset(pnv_psi_reset, dev);
 }
=20
-static const char compat_p8[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
-static const char compat_p9[] =3D "ibm,power9-psihb-x\0ibm,psihb-x";
-static const char compat_p10[] =3D "ibm,power10-psihb-x\0ibm,psihb-x";
-
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
 {
     PnvPsiClass *ppc =3D PNV_PSI_GET_CLASS(dev);
@@ -558,16 +554,8 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *dev, =
void *fdt, int xscom_offset)
     _FDT(fdt_setprop(fdt, offset, "reg", reg, sizeof(reg)));
     _FDT(fdt_setprop_cell(fdt, offset, "#address-cells", 2));
     _FDT(fdt_setprop_cell(fdt, offset, "#size-cells", 1));
-    if (ppc->chip_type =3D=3D PNV_CHIP_POWER10) {
-        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p10,
-                         sizeof(compat_p10)));
-    } else if (ppc->chip_type =3D=3D PNV_CHIP_POWER9) {
-        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p9,
-                         sizeof(compat_p9)));
-    } else {
-        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p8,
-                         sizeof(compat_p8)));
-    }
+    _FDT(fdt_setprop(fdt, offset, "compatible", ppc->compat,
+                     ppc->compat_size));
     return 0;
 }
=20
@@ -581,6 +569,7 @@ static void pnv_psi_power8_class_init(ObjectClass *kl=
ass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
+    static const char compat[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
=20
     dc->desc    =3D "PowerNV PSI Controller POWER8";
     dc->realize =3D pnv_psi_power8_realize;
@@ -590,6 +579,8 @@ static void pnv_psi_power8_class_init(ObjectClass *kl=
ass, void *data)
     ppc->xscom_size =3D PNV_XSCOM_PSIHB_SIZE;
     ppc->bar_mask   =3D PSIHB_BAR_MASK;
     ppc->irq_set    =3D pnv_psi_power8_irq_set;
+    ppc->compat     =3D compat;
+    ppc->compat_size =3D sizeof(compat);
 }
=20
 static const TypeInfo pnv_psi_power8_info =3D {
@@ -888,6 +879,7 @@ static void pnv_psi_power9_class_init(ObjectClass *kl=
ass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
     XiveNotifierClass *xfc =3D XIVE_NOTIFIER_CLASS(klass);
+    static const char compat[] =3D "ibm,power9-psihb-x\0ibm,psihb-x";
=20
     dc->desc    =3D "PowerNV PSI Controller POWER9";
     dc->realize =3D pnv_psi_power9_realize;
@@ -897,6 +889,8 @@ static void pnv_psi_power9_class_init(ObjectClass *kl=
ass, void *data)
     ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
     ppc->bar_mask   =3D PSIHB9_BAR_MASK;
     ppc->irq_set    =3D pnv_psi_power9_irq_set;
+    ppc->compat     =3D compat;
+    ppc->compat_size =3D sizeof(compat);
=20
     xfc->notify      =3D pnv_psi_notify;
 }
@@ -917,12 +911,15 @@ static void pnv_psi_power10_class_init(ObjectClass =
*klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
+    static const char compat[] =3D "ibm,power10-psihb-x\0ibm,psihb-x";
=20
     dc->desc    =3D "PowerNV PSI Controller POWER10";
=20
     ppc->chip_type  =3D PNV_CHIP_POWER10;
     ppc->xscom_pcba =3D PNV10_XSCOM_PSIHB_BASE;
     ppc->xscom_size =3D PNV10_XSCOM_PSIHB_SIZE;
+    ppc->compat     =3D compat;
+    ppc->compat_size =3D sizeof(compat);
 }
=20
 static const TypeInfo pnv_psi_power10_info =3D {
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index a044aab304..fc068c95e5 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -83,6 +83,8 @@ typedef struct PnvPsiClass {
     uint32_t xscom_pcba;
     uint32_t xscom_size;
     uint64_t bar_mask;
+    const char *compat;
+    int compat_size;
=20
     void (*irq_set)(PnvPsi *psi, int, bool state);
 } PnvPsiClass;
--=20
2.23.0


