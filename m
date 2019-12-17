Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A871AC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7345320733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="F9mVrSJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7345320733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4pd-0001PA-8Q
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hw-00080Y-6F
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hu-0005KF-ID
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:40 -0500
Received: from ozlabs.org ([203.11.71.1]:58873)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4hu-0005D7-5Y; Mon, 16 Dec 2019 23:43:38 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWP4ntgz9sST; Tue, 17 Dec 2019 15:43:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557809;
 bh=xdy4ml9PTOzwf29Yc3/mszIQeVuCWoBI17z72LVZWy4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F9mVrSJ/zschzBC4hr9/dboMEgtTG3CYagHIZ89ASSjg9CVJJqjnok+nrth3g+1jS
 G0lRh1DRAaE1Rukd98F3FLw7kYOFEd8JLsTA0+rjmPK5yzCMITkvLVivA2PapaiVap
 Lm92mVDaWb/eWoW08vFv4Yv7I13gzwlOD3KO/8Jo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 09/88] ppc/pnv: Link "chip" property to PnvHomer::chip pointer
Date: Tue, 17 Dec 2019 15:42:03 +1100
Message-Id: <20191217044322.351838-10-david@gibson.dropbear.id.au>
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

The homer object has both a pointer and a "chip" property pointing to the
chip object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157383335451.165747.32301068645427993.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c       |  8 ++++----
 hw/ppc/pnv_homer.c | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ce24a4ee99..3fa24a2d60 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -907,8 +907,6 @@ static void pnv_chip_power8_instance_init(Object *obj=
)
=20
     object_initialize_child(obj, "homer",  &chip8->homer, sizeof(chip8->=
homer),
                             TYPE_PNV8_HOMER, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip8->homer), "chip", obj,
-                                   &error_abort);
 }
=20
 static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
@@ -1012,6 +1010,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
                                 &chip8->occ.sram_regs);
=20
     /* HOMER */
+    object_property_set_link(OBJECT(&chip8->homer), OBJECT(chip), "chip"=
,
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip8->homer), true, "realized",
                              &local_err);
     if (local_err) {
@@ -1105,8 +1105,6 @@ static void pnv_chip_power9_instance_init(Object *o=
bj)
=20
     object_initialize_child(obj, "homer",  &chip9->homer, sizeof(chip9->=
homer),
                             TYPE_PNV9_HOMER, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip9->homer), "chip", obj,
-                                   &error_abort);
 }
=20
 static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
@@ -1223,6 +1221,8 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
                                 &chip9->occ.sram_regs);
=20
     /* HOMER */
+    object_property_set_link(OBJECT(&chip9->homer), OBJECT(chip), "chip"=
,
+                             &error_abort);
     object_property_set_bool(OBJECT(&chip9->homer), true, "realized",
                              &local_err);
     if (local_err) {
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index cc881a3b32..994a378108 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -22,6 +22,7 @@
 #include "exec/memory.h"
 #include "sysemu/cpus.h"
 #include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_homer.h"
=20
@@ -229,28 +230,27 @@ static void pnv_homer_realize(DeviceState *dev, Err=
or **errp)
 {
     PnvHomer *homer =3D PNV_HOMER(dev);
     PnvHomerClass *hmrc =3D PNV_HOMER_GET_CLASS(homer);
-    Object *obj;
-    Error *local_err =3D NULL;
-
-    obj =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'chip' not found: ");
-        return;
-    }
-    homer->chip =3D PNV_CHIP(obj);
+
+    assert(homer->chip);
+
     /* homer region */
     memory_region_init_io(&homer->regs, OBJECT(dev),
                           hmrc->homer_ops, homer, "homer-main-memory",
                           hmrc->homer_size);
 }
=20
+static Property pnv_homer_properties[] =3D {
+    DEFINE_PROP_LINK("chip", PnvHomer, chip, TYPE_PNV_CHIP, PnvChip *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pnv_homer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->realize =3D pnv_homer_realize;
     dc->desc =3D "PowerNV HOMER Memory";
+    dc->props =3D pnv_homer_properties;
 }
=20
 static const TypeInfo pnv_homer_type_info =3D {
--=20
2.23.0


