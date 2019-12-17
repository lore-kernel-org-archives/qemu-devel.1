Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E91CC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2946A20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="O/ij+1BI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2946A20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4pM-0000xF-VC
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hv-0007yP-0w
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ht-0005J0-HD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:38 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46943 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ht-0005CX-6w; Mon, 16 Dec 2019 23:43:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWP2qhgz9sSV; Tue, 17 Dec 2019 15:43:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557809;
 bh=tSyoSdwyR3uKzR0o5jcXN4uMBZ9xtr5h1Z8KnS7ZHbA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O/ij+1BI0CsG3aTfJN6CiqkvR2CY3k+OPhCiLpatVm5B2FYPIss28whquCgyrYlqC
 Ed8CDoC5i+MPuPoGRY59zrFpiynbtvRFSb7aPtu5jiVOJvwkTLGNYiM2MRHyxvFIEO
 0u1u6ePMHdFzvwSv97Hhn13rJFn0FYKuVPuEA3Fo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 08/88] ppc/pnv: Link "psi" property to PnvOCC::psi pointer
Date: Tue, 17 Dec 2019 15:42:02 +1100
Message-Id: <20191217044322.351838-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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

The OCC object has both a pointer and a "psi" property pointing to the
PSI object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157383334894.165747.7617090757862105199.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c     |  8 ++++----
 hw/ppc/pnv_occ.c | 20 +++++++++-----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 201facc701..ce24a4ee99 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -904,8 +904,6 @@ static void pnv_chip_power8_instance_init(Object *obj=
)
=20
     object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ)=
,
                             TYPE_PNV8_OCC, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip8->occ), "psi",
-                                   OBJECT(&chip8->psi), &error_abort);
=20
     object_initialize_child(obj, "homer",  &chip8->homer, sizeof(chip8->=
homer),
                             TYPE_PNV8_HOMER, &error_abort, NULL);
@@ -1000,6 +998,8 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
     }
=20
     /* Create the simplified OCC model */
+    object_property_set_link(OBJECT(&chip8->occ), OBJECT(&chip8->psi), "=
psi",
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip8->occ), true, "realized", &loc=
al_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1102,8 +1102,6 @@ static void pnv_chip_power9_instance_init(Object *o=
bj)
=20
     object_initialize_child(obj, "occ",  &chip9->occ, sizeof(chip9->occ)=
,
                             TYPE_PNV9_OCC, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip9->occ), "psi",
-                                   OBJECT(&chip9->psi), &error_abort);
=20
     object_initialize_child(obj, "homer",  &chip9->homer, sizeof(chip9->=
homer),
                             TYPE_PNV9_HOMER, &error_abort, NULL);
@@ -1211,6 +1209,8 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
                                             (uint64_t) PNV9_LPCM_BASE(ch=
ip));
=20
     /* Create the simplified OCC model */
+    object_property_set_link(OBJECT(&chip9->occ), OBJECT(&chip9->psi), "=
psi",
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip9->occ), true, "realized", &loc=
al_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 785653bb67..765c0a6ce5 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-
+#include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_occ.h"
@@ -257,18 +257,10 @@ static void pnv_occ_realize(DeviceState *dev, Error=
 **errp)
 {
     PnvOCC *occ =3D PNV_OCC(dev);
     PnvOCCClass *poc =3D PNV_OCC_GET_CLASS(occ);
-    Object *obj;
-    Error *local_err =3D NULL;
=20
-    occ->occmisc =3D 0;
+    assert(occ->psi);
=20
-    obj =3D object_property_get_link(OBJECT(dev), "psi", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'psi' not found: ");
-        return;
-    }
-    occ->psi =3D PNV_PSI(obj);
+    occ->occmisc =3D 0;
=20
     /* XScom region for OCC registers */
     pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), poc->xscom_ops,
@@ -279,12 +271,18 @@ static void pnv_occ_realize(DeviceState *dev, Error=
 **errp)
                           occ, "occ-common-area", poc->sram_size);
 }
=20
+static Property pnv_occ_properties[] =3D {
+    DEFINE_PROP_LINK("psi", PnvOCC, psi, TYPE_PNV_PSI, PnvPsi *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pnv_occ_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->realize =3D pnv_occ_realize;
     dc->desc =3D "PowerNV OCC Controller";
+    dc->props =3D pnv_occ_properties;
 }
=20
 static const TypeInfo pnv_occ_type_info =3D {
--=20
2.23.0


