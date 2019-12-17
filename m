Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2637BC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41D8206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Lpt77gIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41D8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4jw-0001Vu-Do
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:45:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hq-0007ud-MS
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hp-0005BG-6B
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:34 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:37875)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ho-00059K-BC; Mon, 16 Dec 2019 23:43:33 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWN3wTjz9sRp; Tue, 17 Dec 2019 15:43:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557808;
 bh=UDfW8SoLIaylq9GKYZ8he7eeO/FI+2un69sC1ihH+ec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lpt77gIuRGAacdA/ktowzyKYGybwmTwq4h5iQv9kxbgdFrD/lhftE6aLoCNJXpTJj
 HJ2wWLatS8TVG5kYl1GTnorLsbBHaCMy9AYDg30qQVC/arfapU1vqP3vFKJmnahE/P
 a3wANWjP3ndhsqlaPaGjcBCCEFaML0AGvmS84gVw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 04/88] xive: Link "cpu" property to XiveTCTX::cs pointer
Date: Tue, 17 Dec 2019 15:41:58 +1100
Message-Id: <20191217044322.351838-5-david@gibson.dropbear.id.au>
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

The TCTX object has both a pointer and a "cpu" property pointing to the
vCPU object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157383332669.165747.2484056603605646820.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 75dce82fb2..9376e84aff 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -580,19 +580,11 @@ static void xive_tctx_realize(DeviceState *dev, Err=
or **errp)
     XiveTCTX *tctx =3D XIVE_TCTX(dev);
     PowerPCCPU *cpu;
     CPUPPCState *env;
-    Object *obj;
     Error *local_err =3D NULL;
=20
-    obj =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'cpu' not found: ");
-        return;
-    }
-
-    cpu =3D POWERPC_CPU(obj);
-    tctx->cs =3D CPU(obj);
+    assert(tctx->cs);
=20
+    cpu =3D POWERPC_CPU(tctx->cs);
     env =3D &cpu->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER9:
@@ -662,6 +654,11 @@ static const VMStateDescription vmstate_xive_tctx =3D=
 {
     },
 };
=20
+static Property xive_tctx_properties[] =3D {
+    DEFINE_PROP_LINK("cpu", XiveTCTX, cs, TYPE_CPU, CPUState *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void xive_tctx_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -669,6 +666,7 @@ static void xive_tctx_class_init(ObjectClass *klass, =
void *data)
     dc->desc =3D "XIVE Interrupt Thread Context";
     dc->realize =3D xive_tctx_realize;
     dc->vmsd =3D &vmstate_xive_tctx;
+    dc->props =3D xive_tctx_properties;
     /*
      * Reason: part of XIVE interrupt controller, needs to be wired up
      * by xive_tctx_create().
@@ -691,8 +689,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrt=
r, Error **errp)
     obj =3D object_new(TYPE_XIVE_TCTX);
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
     object_unref(obj);
-    object_ref(cpu);
-    object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_set_link(obj, cpu, "cpu", &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         goto error;
@@ -710,7 +707,6 @@ void xive_tctx_destroy(XiveTCTX *tctx)
 {
     Object *obj =3D OBJECT(tctx);
=20
-    object_unref(object_property_get_link(obj, "cpu", &error_abort));
     object_unparent(obj);
 }
=20
--=20
2.23.0


