Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63261C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D14A217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JaBn/QlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D14A217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1G9-00024Q-LT
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 02:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13l-0008J8-ME
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13j-0003Vp-3E
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:57 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56525)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iD13i-0003Sh-CI; Wed, 25 Sep 2019 02:45:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dT8p3vxbz9sPq; Wed, 25 Sep 2019 16:45:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569393946;
 bh=MWyjaNqGeiZxSx2ghrsuLbE75RKkfcGeLPbhW/hfzCU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JaBn/QlMP4fkzRW2WrKR8m+DwvsHLahByHRQ8vxh+IaxPjisL0E3aRBwJc0cfRaZ2
 QnPquIKfNqHWgvofj9axw5UKuVLSU5H1c/p9KOEe2Ofmf3aC2G3bHh6SN64+Js78gI
 LZjRTqEBCRK97YgfqcBJtFAt8mDqz1h/YpoStKsE=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/20] spapr: Eliminate SpaprIrq:get_nodename method
Date: Wed, 25 Sep 2019 16:45:27 +1000
Message-Id: <20190925064534.19155-14-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925064534.19155-1-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This method is used to determine the name of the irq backend's node in th=
e
device tree, so that we can find its phandle (after SLOF may have modifie=
d
it from the phandle we initially gave it).

But, in the two cases the only difference between the node name is the
presence of a unit address.  Searching for a node name without considerin=
g
unit address is standard practice for the device tree, and
fdt_subnode_offset() will do exactly that.

So, the method is unnecessary.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c         | 25 +++----------------------
 include/hw/ppc/spapr_irq.h |  1 -
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 038bfffff4..79167ccc68 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -211,11 +211,6 @@ static void spapr_irq_reset_xics(SpaprMachineState *=
spapr, Error **errp)
     }
 }
=20
-static const char *spapr_irq_get_nodename_xics(SpaprMachineState *spapr)
-{
-    return XICS_NODENAME;
-}
-
 static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **er=
rp)
 {
     if (kvm_enabled()) {
@@ -237,7 +232,6 @@ SpaprIrq spapr_irq_xics =3D {
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
-    .get_nodename =3D spapr_irq_get_nodename_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
=20
@@ -362,11 +356,6 @@ static void spapr_irq_set_irq_xive(void *opaque, int=
 irq, int val)
     }
 }
=20
-static const char *spapr_irq_get_nodename_xive(SpaprMachineState *spapr)
-{
-    return spapr->xive->nodename;
-}
-
 static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **er=
rp)
 {
     if (kvm_enabled()) {
@@ -393,7 +382,6 @@ SpaprIrq spapr_irq_xive =3D {
     .post_load   =3D spapr_irq_post_load_xive,
     .reset       =3D spapr_irq_reset_xive,
     .set_irq     =3D spapr_irq_set_irq_xive,
-    .get_nodename =3D spapr_irq_get_nodename_xive,
     .init_kvm    =3D spapr_irq_init_kvm_xive,
 };
=20
@@ -538,11 +526,6 @@ static void spapr_irq_set_irq_dual(void *opaque, int=
 irq, int val)
     spapr_irq_current(spapr)->set_irq(spapr, irq, val);
 }
=20
-static const char *spapr_irq_get_nodename_dual(SpaprMachineState *spapr)
-{
-    return spapr_irq_current(spapr)->get_nodename(spapr);
-}
-
 /*
  * Define values in sync with the XIVE and XICS backend
  */
@@ -560,7 +543,6 @@ SpaprIrq spapr_irq_dual =3D {
     .post_load   =3D spapr_irq_post_load_dual,
     .reset       =3D spapr_irq_reset_dual,
     .set_irq     =3D spapr_irq_set_irq_dual,
-    .get_nodename =3D spapr_irq_get_nodename_dual,
     .init_kvm    =3D NULL, /* should not be used */
 };
=20
@@ -697,13 +679,13 @@ void spapr_irq_reset(SpaprMachineState *spapr, Erro=
r **errp)
=20
 int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **e=
rrp)
 {
-    const char *nodename =3D spapr->irq->get_nodename(spapr);
+    const char *nodename =3D "interrupt-controller";
     int offset, phandle;
=20
     offset =3D fdt_subnode_offset(fdt, 0, nodename);
     if (offset < 0) {
-        error_setg(errp, "Can't find node \"%s\": %s", nodename,
-                   fdt_strerror(offset));
+        error_setg(errp, "Can't find node \"%s\": %s",
+                   nodename, fdt_strerror(offset));
         return -1;
     }
=20
@@ -787,6 +769,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
-    .get_nodename =3D spapr_irq_get_nodename_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index a4e790ef60..9b60378e28 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -52,7 +52,6 @@ typedef struct SpaprIrq {
     int (*post_load)(SpaprMachineState *spapr, int version_id);
     void (*reset)(SpaprMachineState *spapr, Error **errp);
     void (*set_irq)(void *opaque, int srcno, int val);
-    const char *(*get_nodename)(SpaprMachineState *spapr);
     void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
 } SpaprIrq;
=20
--=20
2.21.0


