Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73869C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F100206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hY0GgRnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F100206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4kL-0001kv-EO
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hu-0007xq-5O
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hs-0005Hb-Lt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:38 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51499 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4hs-0005C0-Aj; Mon, 16 Dec 2019 23:43:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWN5LtLz9sS6; Tue, 17 Dec 2019 15:43:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557808;
 bh=cIWbSV2hKfff9gsmveOl7Eih/ky92vv9vdYrVaFyE9s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hY0GgRnblNFayn8s02HEx8IabSoGlVzTNXrXtxxr3NE6EhzL1nTTxPLB5NaCKYHt8
 VHezLzmxYgiB0PvgSH9Vk3OR+YFDQmlrnsaEjYkfp+Yar9yyMWxiUEYHDUyE2mN+yY
 nMvMtZ0zBlEf92ocfAQAJ1mjjUZWyrpb7YD6FXdQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 07/88] ppc/pnv: Link "psi" property to PnvLpc::psi pointer
Date: Tue, 17 Dec 2019 15:42:01 +1100
Message-Id: <20191217044322.351838-8-david@gibson.dropbear.id.au>
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

The LPC object has both a pointer and a "psi" property pointing to the
PSI object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157383334342.165747.3159314903077305653.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c     |  8 ++++----
 hw/ppc/pnv_lpc.c | 19 ++++++++-----------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4e9ddc05ad..201facc701 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -901,8 +901,6 @@ static void pnv_chip_power8_instance_init(Object *obj=
)
=20
     object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc)=
,
                             TYPE_PNV8_LPC, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
-                                   OBJECT(&chip8->psi), &error_abort);
=20
     object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ)=
,
                             TYPE_PNV8_OCC, &error_abort, NULL);
@@ -981,6 +979,8 @@ static void pnv_chip_power8_realize(DeviceState *dev,=
 Error **errp)
                             &PNV_PSI(psi8)->xscom_regs);
=20
     /* Create LPC controller */
+    object_property_set_link(OBJECT(&chip8->lpc), OBJECT(&chip8->psi), "=
psi",
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip8->lpc), true, "realized",
                              &error_fatal);
     pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xscom_=
regs);
@@ -1099,8 +1099,6 @@ static void pnv_chip_power9_instance_init(Object *o=
bj)
=20
     object_initialize_child(obj, "lpc",  &chip9->lpc, sizeof(chip9->lpc)=
,
                             TYPE_PNV9_LPC, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip9->lpc), "psi",
-                                   OBJECT(&chip9->psi), &error_abort);
=20
     object_initialize_child(obj, "occ",  &chip9->occ, sizeof(chip9->occ)=
,
                             TYPE_PNV9_OCC, &error_abort, NULL);
@@ -1199,6 +1197,8 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
                             &PNV_PSI(psi9)->xscom_regs);
=20
     /* LPC */
+    object_property_set_link(OBJECT(&chip9->lpc), OBJECT(&chip9->psi), "=
psi",
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip9->lpc), true, "realized", &loc=
al_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 9466d4a1be..fb9f930320 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -24,7 +24,7 @@
 #include "qemu/module.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
-
+#include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_xscom.h"
@@ -682,17 +682,8 @@ static const TypeInfo pnv_lpc_power9_info =3D {
 static void pnv_lpc_realize(DeviceState *dev, Error **errp)
 {
     PnvLpcController *lpc =3D PNV_LPC(dev);
-    Object *obj;
-    Error *local_err =3D NULL;
=20
-    obj =3D object_property_get_link(OBJECT(dev), "psi", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'psi' not found: ");
-        return;
-    }
-    /* The LPC controller needs PSI to generate interrupts  */
-    lpc->psi =3D PNV_PSI(obj);
+    assert(lpc->psi);
=20
     /* Reg inits */
     lpc->lpc_hc_fw_rd_acc_size =3D LPC_HC_FW_RD_4B;
@@ -734,12 +725,18 @@ static void pnv_lpc_realize(DeviceState *dev, Error=
 **errp)
                                 &lpc->lpc_hc_regs);
 }
=20
+static Property pnv_lpc_properties[] =3D {
+    DEFINE_PROP_LINK("psi", PnvLpcController, psi, TYPE_PNV_PSI, PnvPsi =
*),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pnv_lpc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->realize =3D pnv_lpc_realize;
     dc->desc =3D "PowerNV LPC Controller";
+    dc->props =3D pnv_lpc_properties;
 }
=20
 static const TypeInfo pnv_lpc_info =3D {
--=20
2.23.0


