Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E97C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29972072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PAeF7c4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29972072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4oM-0007X0-6e
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hu-0007xh-1E
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hs-0005Hj-QK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:37 -0500
Received: from ozlabs.org ([203.11.71.1]:48911)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4hs-0005C9-Er; Mon, 16 Dec 2019 23:43:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWN6Sbzz9sSK; Tue, 17 Dec 2019 15:43:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557808;
 bh=3OB/+PigK7cKnLJGlLXLbBDqK/mIpgH/LS3KK12fuxY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PAeF7c4+d9nDESaL37rmN2tFtoBquzv9Q+lUAIN/EmM3QGd/G/+oI+xSTPS7MzL5M
 Szx2e5vM/SZwwRH1Km9vSKSp8bzGo8TQhqJNWmOuKvGOkNTbYpoAUpjmCuVogsb90I
 QKm4bWAi0QyvwbHYrV+dBcAXPlnctzoChaRfaLg8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 05/88] xive: Link "xive" property to XiveSource::xive pointer
Date: Tue, 17 Dec 2019 15:41:59 +1100
Message-Id: <20191217044322.351838-6-david@gibson.dropbear.id.au>
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

The source object has both a pointer and a "xive" property pointing to th=
e
notifier object. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitely sets the pointer.
The property isn't optional : not being able to set the link is a bug
and QEMU should rather abort than exit in this case.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157383333227.165747.12901571295951957951.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c   |  4 ++--
 hw/intc/spapr_xive.c |  4 ++--
 hw/intc/xive.c       | 13 +++----------
 hw/ppc/pnv_psi.c     |  3 +--
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 348f2fdd26..9e23dc705d 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1695,8 +1695,8 @@ static void pnv_xive_realize(DeviceState *dev, Erro=
r **errp)
      */
     object_property_set_int(OBJECT(xsrc), PNV_XIVE_NR_IRQS, "nr-irqs",
                             &error_fatal);
-    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
-                                   &error_fatal);
+    object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
+                             &error_abort);
     object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err)=
;
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 9cb8d38a3b..10890aeeeb 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -276,8 +276,8 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
      */
     object_property_set_int(OBJECT(xsrc), xive->nr_irqs, "nr-irqs",
                             &error_fatal);
-    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
-                                   &error_fatal);
+    object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
+                             &error_abort);
     object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err)=
;
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 9376e84aff..2eac15efa6 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1060,17 +1060,8 @@ static void xive_source_reset(void *dev)
 static void xive_source_realize(DeviceState *dev, Error **errp)
 {
     XiveSource *xsrc =3D XIVE_SOURCE(dev);
-    Object *obj;
-    Error *local_err =3D NULL;
-
-    obj =3D object_property_get_link(OBJECT(dev), "xive", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'xive' not found: ");
-        return;
-    }
=20
-    xsrc->xive =3D XIVE_NOTIFIER(obj);
+    assert(xsrc->xive);
=20
     if (!xsrc->nr_irqs) {
         error_setg(errp, "Number of interrupt needs to be greater than 0=
");
@@ -1116,6 +1107,8 @@ static Property xive_source_properties[] =3D {
     DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
     DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
     DEFINE_PROP_UINT32("shift", XiveSource, esb_shift, XIVE_ESB_64K_2PAG=
E),
+    DEFINE_PROP_LINK("xive", XiveSource, xive, TYPE_XIVE_NOTIFIER,
+                     XiveNotifier *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 68d0dfacfe..a360515a86 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -851,8 +851,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
                             &error_fatal);
     object_property_set_int(OBJECT(xsrc), PSIHB9_NUM_IRQS, "nr-irqs",
                             &error_fatal);
-    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(psi),
-                                   &error_fatal);
+    object_property_set_link(OBJECT(xsrc), OBJECT(psi), "xive", &error_a=
bort);
     object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err)=
;
     if (local_err) {
         error_propagate(errp, local_err);
--=20
2.23.0


