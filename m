Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBB0C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8B42067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mzcEnazb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8B42067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip42L-0006Lb-F8
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oy-0004T7-PG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3ox-0003L7-IM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:56 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51671 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3ox-0002n2-7r; Wed, 08 Jan 2020 00:23:55 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMF5TL7z9sSt; Wed,  8 Jan 2020 16:23:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578461001;
 bh=BYYjGY0hh7GQE6wOJ9JGviMu9wKU8eOeK3Ac1On8/p8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mzcEnazbFDPDlpB/sKIL+fgD6Q0oRs0e/7yW7SQbffzkWqts7WlPbqpnkPCEK7EzY
 pZZuQtP8MV7ZrnywauZyCgEy8VGOO+srx7tA6TVA8AwnjcAG4Q8L71m4LsVOfZjfkG
 mPUfPCm2waJnNaeTwn04SQr9UKdy4h67warhooNU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 23/26] pnv/psi: Add device reset hook
Date: Wed,  8 Jan 2020 16:23:09 +1100
Message-Id: <20200108052312.238710-24-david@gibson.dropbear.id.au>
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
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

And call it from a QEMU reset handler. This allows each PNV child class t=
o
override the reset hook if needed, eg. POWER8 doesn't but POWER9 does.
The proper way to do that would be to use device_class_set_parent_reset()=
,
but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_reset
pointer adds a fair amount of code. Calling pnv_psi_reset() explicitely i=
s
fine for now.

A subsequent patch will consolidate the call to qemu_register_reset() in
a single place.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <157841476035.66386.17838417527621752518.stgit@bahia.tlslab.i=
bm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_psi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 4da3d25686..846171914f 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -455,7 +455,7 @@ static const MemoryRegionOps pnv_psi_xscom_ops =3D {
     }
 };
=20
-static void pnv_psi_reset(void *dev)
+static void pnv_psi_reset(DeviceState *dev)
 {
     PnvPsi *psi =3D PNV_PSI(dev);
=20
@@ -464,6 +464,11 @@ static void pnv_psi_reset(void *dev)
     psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
 }
=20
+static void pnv_psi_reset_handler(void *dev)
+{
+    device_reset(DEVICE(dev));
+}
+
 static void pnv_psi_power8_instance_init(Object *obj)
 {
     Pnv8Psi *psi8 =3D PNV8_PSI(obj);
@@ -526,7 +531,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
             ((uint64_t) i << PSIHB_XIVR_SRC_SH);
     }
=20
-    qemu_register_reset(pnv_psi_reset, dev);
+    qemu_register_reset(pnv_psi_reset_handler, dev);
 }
=20
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
@@ -809,7 +814,7 @@ static void pnv_psi_power9_irq_set(PnvPsi *psi, int i=
rq, bool state)
     qemu_set_irq(psi->qirqs[irq], state);
 }
=20
-static void pnv_psi_power9_reset(void *dev)
+static void pnv_psi_power9_reset(DeviceState *dev)
 {
     Pnv9Psi *psi =3D PNV9_PSI(dev);
=20
@@ -863,7 +868,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
=20
     pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
=20
-    qemu_register_reset(pnv_psi_power9_reset, dev);
+    qemu_register_reset(pnv_psi_reset_handler, dev);
 }
=20
 static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
@@ -875,6 +880,7 @@ static void pnv_psi_power9_class_init(ObjectClass *kl=
ass, void *data)
=20
     dc->desc    =3D "PowerNV PSI Controller POWER9";
     dc->realize =3D pnv_psi_power9_realize;
+    dc->reset   =3D pnv_psi_power9_reset;
=20
     ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
     ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
@@ -927,6 +933,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
=20
     dc->desc =3D "PowerNV PSI Controller";
     dc->props =3D pnv_psi_properties;
+    dc->reset =3D pnv_psi_reset;
 }
=20
 static const TypeInfo pnv_psi_info =3D {
--=20
2.24.1


