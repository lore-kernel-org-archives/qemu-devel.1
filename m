Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C8CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCAD207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCAD207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioULO-00031b-4T
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioTpT-0001SG-JY
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioTpS-0001Mw-B1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:58:03 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:56943)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioTpS-0001LP-5i
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:58:02 -0500
Received: from player731.ha.ovh.net (unknown [10.108.35.128])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2A577123112
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 15:58:00 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 9E6DDDB3A8A5;
 Mon,  6 Jan 2020 14:57:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 11/12] pnv/psi: Add device reset hook
Date: Mon,  6 Jan 2020 15:56:44 +0100
Message-Id: <20200106145645.4539-12-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106145645.4539-1-clg@kaod.org>
References: <20200106145645.4539-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5402067756057856998
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedv
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.219
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
---
 hw/ppc/pnv_psi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 4da3d2568624..cf21e42d93b7 100644
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
@@ -464,6 +464,13 @@ static void pnv_psi_reset(void *dev)
     psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
 }
=20
+static void pnv_psi_reset_handler(void *dev)
+{
+    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
+
+    dc->reset(DEVICE(dev));
+}
+
 static void pnv_psi_power8_instance_init(Object *obj)
 {
     Pnv8Psi *psi8 =3D PNV8_PSI(obj);
@@ -526,7 +533,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
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
@@ -809,7 +816,7 @@ static void pnv_psi_power9_irq_set(PnvPsi *psi, int i=
rq, bool state)
     qemu_set_irq(psi->qirqs[irq], state);
 }
=20
-static void pnv_psi_power9_reset(void *dev)
+static void pnv_psi_power9_reset(DeviceState *dev)
 {
     Pnv9Psi *psi =3D PNV9_PSI(dev);
=20
@@ -863,7 +870,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
=20
     pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
=20
-    qemu_register_reset(pnv_psi_power9_reset, dev);
+    qemu_register_reset(pnv_psi_reset_handler, dev);
 }
=20
 static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
@@ -875,6 +882,7 @@ static void pnv_psi_power9_class_init(ObjectClass *kl=
ass, void *data)
=20
     dc->desc    =3D "PowerNV PSI Controller POWER9";
     dc->realize =3D pnv_psi_power9_realize;
+    dc->reset   =3D pnv_psi_power9_reset;
=20
     ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
     ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
@@ -927,6 +935,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
=20
     dc->desc =3D "PowerNV PSI Controller";
     dc->props =3D pnv_psi_properties;
+    dc->reset =3D pnv_psi_reset;
 }
=20
 static const TypeInfo pnv_psi_info =3D {
--=20
2.21.1


