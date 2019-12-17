Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D308C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E5120733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="P1vTwRBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E5120733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4qN-0002f2-Pk
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hu-0007y0-Cx
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hs-0005I5-WD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:38 -0500
Received: from ozlabs.org ([203.11.71.1]:58479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4hs-0005CM-Jh; Mon, 16 Dec 2019 23:43:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWP1mSQz9sSF; Tue, 17 Dec 2019 15:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557809;
 bh=I3lX+zITKorz/QN+en/TanYk+EQ79cpoj7L5bElovIA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P1vTwRBKhY2EqmOjJ74BLJp8tgTSUaCJU77V5t2BRF+iNioKH+xIUMdUiVXOaNiSm
 f/WVH8xmiXFrHymQebTSo5/Gk+1NUNnMXBqJGeZDvaSxN2TrMlYmzobf8NB9XA+Csf
 lPzbcfKMJviPGU5LhhOIMXzEnb2MZmUQeIYWjY2k=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 12/88] xics: Link ICS_PROP_XICS property to ICSState::xics
 pointer
Date: Tue, 17 Dec 2019 15:42:06 +1100
Message-Id: <20191217044322.351838-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The ICS object has both a pointer and an ICS_PROP_XICS property pointing
to the XICS fabric. Confusing bugs could arise if these ever go out of
sync.

Change the property definition so that it explicitely sets the pointer.
The property isn't optional : not being able to set the link is a bug
and QEMU should rather abort than exit in this case.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157403283596.409804.17347207690271971987.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c     | 13 +++----------
 hw/ppc/pnv_psi.c   |  3 +--
 hw/ppc/spapr_irq.c |  9 ++-------
 3 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e7ac9ba618..f7a4548089 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -609,17 +609,8 @@ static void ics_reset_handler(void *dev)
 static void ics_realize(DeviceState *dev, Error **errp)
 {
     ICSState *ics =3D ICS(dev);
-    Error *local_err =3D NULL;
-    Object *obj;
=20
-    obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &local_=
err);
-    if (!obj) {
-        error_propagate_prepend(errp, local_err,
-                                "required link '" ICS_PROP_XICS
-                                "' not found: ");
-        return;
-    }
-    ics->xics =3D XICS_FABRIC(obj);
+    assert(ics->xics);
=20
     if (!ics->nr_irqs) {
         error_setg(errp, "Number of interrupts needs to be greater 0");
@@ -699,6 +690,8 @@ static const VMStateDescription vmstate_ics =3D {
=20
 static Property ics_properties[] =3D {
     DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
+    DEFINE_PROP_LINK(ICS_PROP_XICS, ICSState, xics, TYPE_XICS_FABRIC,
+                     XICSFabric *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index a360515a86..7e725aaf2b 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -497,8 +497,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
     }
=20
     /* Create PSI interrupt control source */
-    object_property_add_const_link(OBJECT(ics), ICS_PROP_XICS, obj,
-                                   &error_abort);
+    object_property_set_link(OBJECT(ics), obj, ICS_PROP_XICS, &error_abo=
rt);
     object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs", =
&err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d6bb7fd2d6..fbdda14372 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -319,13 +319,8 @@ void spapr_irq_init(SpaprMachineState *spapr, Error =
**errp)
             return;
         }
=20
-        object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr)=
,
-                                       &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-
+        object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
+                                 &error_abort);
         object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &local_er=
r);
         if (local_err) {
             error_propagate(errp, local_err);
--=20
2.23.0


