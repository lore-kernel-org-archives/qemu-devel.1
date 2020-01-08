Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6705FC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D38206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k7QnnUki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D38206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip47V-0005pq-Vp
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oz-0004TX-22
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3ox-0003Lg-SK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:56 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38425 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3ox-0002nQ-Hq; Wed, 08 Jan 2020 00:23:55 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMG0RyWz9sSv; Wed,  8 Jan 2020 16:23:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578461002;
 bh=sGi5Y8ljHCPGECepK1BCD4Nnhy2bRAmyrXp5RMVEkZU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k7QnnUkiMOY7LzuAzoyi7OrKfIsEhpq2yevBSO96laT4aHSlMVGe5Kxp19LqEXbLc
 ENHc03EucjIHRAMPt+q8QxnUN4R1Ij996Ov6JA6y8zcYIFicwrfOnW6RuE23JORQCt
 cf0q5jxNNFym6918ubf/6Lei6jfqDFvQpSi5+iHw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 24/26] pnv/psi: Consolidate some duplicated code in
 pnv_psi_realize()
Date: Wed,  8 Jan 2020 16:23:10 +1100
Message-Id: <20200108052312.238710-25-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The proper way to do that would be to use device_class_set_parent_realize=
(),
but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_realiz=
e
pointer adds a fair amount of code. Calling pnv_psi_realize() explicitely
is fine for now.

This should probably be achieved with a device realize hook in the
PSI base class and device_class_set_parent_realize() in the children
classes.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <157841476667.66386.13659183399113837990.stgit@bahia.tlslab.i=
bm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_psi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 846171914f..1d8da31738 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -469,6 +469,16 @@ static void pnv_psi_reset_handler(void *dev)
     device_reset(DEVICE(dev));
 }
=20
+static void pnv_psi_realize(DeviceState *dev, Error **errp)
+{
+    PnvPsi *psi =3D PNV_PSI(dev);
+
+    /* Default BAR for MMIO region */
+    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
+
+    qemu_register_reset(pnv_psi_reset_handler, dev);
+}
+
 static void pnv_psi_power8_instance_init(Object *obj)
 {
     Pnv8Psi *psi8 =3D PNV8_PSI(obj);
@@ -521,9 +531,6 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
     memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, psi=
,
                           "psihb", PNV_PSIHB_SIZE);
=20
-    /* Default BAR for MMIO region */
-    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
-
     /* Default sources in XIVR */
     for (i =3D 0; i < PSI_NUM_INTERRUPTS; i++) {
         uint8_t xivr =3D irq_to_xivr[i];
@@ -531,7 +538,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
             ((uint64_t) i << PSIHB_XIVR_SRC_SH);
     }
=20
-    qemu_register_reset(pnv_psi_reset_handler, dev);
+    pnv_psi_realize(dev, errp);
 }
=20
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
@@ -866,9 +873,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
     memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9_mmio_o=
ps, psi,
                           "psihb", PNV9_PSIHB_SIZE);
=20
-    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
-
-    qemu_register_reset(pnv_psi_reset_handler, dev);
+    pnv_psi_realize(dev, errp);
 }
=20
 static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
--=20
2.24.1


