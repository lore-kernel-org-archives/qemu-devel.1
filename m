Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A440C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A8C2072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Tgi+luE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A8C2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4pR-00014A-1n
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hv-000808-V8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hu-0005K5-Ej
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:39 -0500
Received: from ozlabs.org ([203.11.71.1]:53943)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4hu-0005Cm-2b; Mon, 16 Dec 2019 23:43:38 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWP3rR1z9sSL; Tue, 17 Dec 2019 15:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557809;
 bh=o607y6vGbDPx2ydgklkHMMijSMIsRAC5+3Ij0tB2wRc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tgi+luE7yWf53Wf1kN5wg+yY6u+wLtXQNIDPyR43tU5/DSZMU1/FkDOt47+D5NOF4
 2+fzV8q1B2cxpZ3Pn0kLmYlWrwqsSD7qm77f0Ez5tzDDDRJUQtyMvOoHGR2SJMxVI2
 dVlBEJkw2mizaI78JDviUB5/wjamuufapQLhHMpk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 11/88] ppc/pnv: Link "chip" property to PnvXive::chip pointer
Date: Tue, 17 Dec 2019 15:42:05 +1100
Message-Id: <20191217044322.351838-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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

The XIVE object has both a pointer and a "chip" property pointing to the
chip object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157383336564.165747.10250365296928442882.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c | 13 +++----------
 hw/ppc/pnv.c       |  4 ++--
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 6aa7aeed6f..4e56c2e468 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1675,17 +1675,8 @@ static void pnv_xive_realize(DeviceState *dev, Err=
or **errp)
     XiveSource *xsrc =3D &xive->ipi_source;
     XiveENDSource *end_xsrc =3D &xive->end_source;
     Error *local_err =3D NULL;
-    Object *obj;
=20
-    obj =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'chip' not found: ");
-        return;
-    }
-
-    /* The PnvChip id identifies the XIVE interrupt controller. */
-    xive->chip =3D PNV_CHIP(obj);
+    assert(xive->chip);
=20
     /*
      * The XiveSource and XiveENDSource objects are realized with the
@@ -1800,6 +1791,8 @@ static Property pnv_xive_properties[] =3D {
     DEFINE_PROP_UINT64("vc-bar", PnvXive, vc_base, 0),
     DEFINE_PROP_UINT64("pc-bar", PnvXive, pc_base, 0),
     DEFINE_PROP_UINT64("tm-bar", PnvXive, tm_base, 0),
+    /* The PnvChip id identifies the XIVE interrupt controller. */
+    DEFINE_PROP_LINK("chip", PnvXive, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 2bf8a3b23b..a2a8b97330 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1091,8 +1091,6 @@ static void pnv_chip_power9_instance_init(Object *o=
bj)
=20
     object_initialize_child(obj, "xive", &chip9->xive, sizeof(chip9->xiv=
e),
                             TYPE_PNV_XIVE, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip9->xive), "chip", obj,
-                                   &error_abort);
=20
     object_initialize_child(obj, "psi",  &chip9->psi, sizeof(chip9->psi)=
,
                             TYPE_PNV9_PSI, &error_abort, NULL);
@@ -1172,6 +1170,8 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
                             "pc-bar", &error_fatal);
     object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_TM_BASE(chip=
),
                             "tm-bar", &error_fatal);
+    object_property_set_link(OBJECT(&chip9->xive), OBJECT(chip), "chip",
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip9->xive), true, "realized",
                              &local_err);
     if (local_err) {
--=20
2.23.0


