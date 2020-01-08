Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A74C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31A220720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="el2chWJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31A220720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3wU-0006yH-9Z
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3od-0003u8-3o
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3ob-0002mF-9r
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:34 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57905 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oa-0002iV-VM; Wed, 08 Jan 2020 00:23:33 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMD5sG2z9sSl; Wed,  8 Jan 2020 16:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578461000;
 bh=YKj/JCOL4eY6T2jPRiGw4s60Uql1wUM2s7+5CxP/exA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=el2chWJBxQYRq7XKP+la4OeNZ2DGThS3V2l1sQ8GN0AVEu8tSiYKYJjYrrgYJBGqm
 wl2DWdSGcDAXJKqEQh2uc+/8E0R+o+QdPdqnwGoT/VhUlksyl3vLFdFcY67sY7Gx3w
 uELRH15zNfracfG0bTMUI7m+4J5kZiPJtIHnpS4U=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 13/26] ppc/pnv: Introduce a "xics" property alias under the PSI
 model
Date: Wed,  8 Jan 2020 16:22:59 +1100
Message-Id: <20200108052312.238710-14-david@gibson.dropbear.id.au>
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

From: C=C3=A9dric Le Goater <clg@kaod.org>

This removes the need of the intermediate link under PSI to pass the
XICS link to the underlying ICSState object.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200106145645.4539-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c     |  4 ++--
 hw/ppc/pnv_psi.c | 11 ++---------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6d7bf9280e..90e92e82c5 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1004,8 +1004,6 @@ static void pnv_chip_power8_instance_init(Object *o=
bj)
=20
     object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi)=
,
                             TYPE_PNV8_PSI, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip8->psi), "xics",
-                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
=20
     object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc)=
,
                             TYPE_PNV8_LPC, &error_abort, NULL);
@@ -1072,6 +1070,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip8->psi), PNV_PSIHB_BASE(chip),
                             "bar", &error_fatal);
+    object_property_set_link(OBJECT(&chip8->psi), OBJECT(qdev_get_machin=
e()),
+                             ICS_PROP_XICS, &error_abort);
     object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &loc=
al_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 75e20d9da0..4da3d25686 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -470,6 +470,8 @@ static void pnv_psi_power8_instance_init(Object *obj)
=20
     object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->ic=
s),
                             TYPE_ICS, &error_abort, NULL);
+    object_property_add_alias(obj, ICS_PROP_XICS, OBJECT(&psi8->ics),
+                              ICS_PROP_XICS, &error_abort);
 }
=20
 static const uint8_t irq_to_xivr[] =3D {
@@ -485,19 +487,10 @@ static void pnv_psi_power8_realize(DeviceState *dev=
, Error **errp)
 {
     PnvPsi *psi =3D PNV_PSI(dev);
     ICSState *ics =3D &PNV8_PSI(psi)->ics;
-    Object *obj;
     Error *err =3D NULL;
     unsigned int i;
=20
-    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
-    if (!obj) {
-        error_setg(errp, "%s: required link 'xics' not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
-
     /* Create PSI interrupt control source */
-    object_property_set_link(OBJECT(ics), obj, ICS_PROP_XICS, &error_abo=
rt);
     object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs", =
&err);
     if (err) {
         error_propagate(errp, err);
--=20
2.24.1


