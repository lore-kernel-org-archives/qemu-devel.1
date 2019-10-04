Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2BDC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 161F0207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Tkx09MTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161F0207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKqI-0001JY-QI
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK3U-0006Fk-79
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK3S-0006KD-LI
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:39:20 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45185)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK3S-00061m-8z; Fri, 04 Oct 2019 05:39:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YR4738z9sSW; Fri,  4 Oct 2019 19:38:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181883;
 bh=dRmc8C87IgfOESV6wlmWQRDExLiKHVz7EnhGNOYr28s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tkx09MTq4SbJHq4K6sGrS9iGrT8JnDfDqFA8Ok2JeE4Vn5ORqCv68uAmy6geCgqRg
 4TPf8YRm8KngW6GVrUsY64wonkE7s9iBZOhl7+3NzEMVBDe+2pztpytb11gUipe4vn
 uV4NfONjsIzuLcx2AttDAN3QtTeC5qUuJXzDPyKI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 45/53] spapr: Eliminate SpaprIrq:get_nodename method
Date: Fri,  4 Oct 2019 19:37:39 +1000
Message-Id: <20191004093747.31350-46-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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
fdt_subnode_offset() will do exactly that, making this method unecessary.

While we're there, remove the XICS_NODENAME define.  The name
"interrupt-controller" is required by PAPR (and IEEE1275), and a bunch of
places assume it already.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_spapr.c        |  2 +-
 hw/ppc/spapr_irq.c          | 25 +++----------------------
 include/hw/ppc/spapr_irq.h  |  1 -
 include/hw/ppc/xics_spapr.h |  2 --
 4 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index e6dd004587..6e5eb24b3c 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -316,7 +316,7 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_t=
 nr_servers, void *fdt,
     };
     int node;
=20
-    _FDT(node =3D fdt_add_subnode(fdt, 0, XICS_NODENAME));
+    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
=20
     _FDT(fdt_setprop_string(fdt, node, "device_type",
                             "PowerPC-External-Interrupt-Presentation"));
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 8f179076c6..ec2229d2d1 100644
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
@@ -388,7 +377,6 @@ SpaprIrq spapr_irq_xive =3D {
     .post_load   =3D spapr_irq_post_load_xive,
     .reset       =3D spapr_irq_reset_xive,
     .set_irq     =3D spapr_irq_set_irq_xive,
-    .get_nodename =3D spapr_irq_get_nodename_xive,
     .init_kvm    =3D spapr_irq_init_kvm_xive,
 };
=20
@@ -533,11 +521,6 @@ static void spapr_irq_set_irq_dual(void *opaque, int=
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
@@ -555,7 +538,6 @@ SpaprIrq spapr_irq_dual =3D {
     .post_load   =3D spapr_irq_post_load_dual,
     .reset       =3D spapr_irq_reset_dual,
     .set_irq     =3D spapr_irq_set_irq_dual,
-    .get_nodename =3D spapr_irq_get_nodename_dual,
     .init_kvm    =3D NULL, /* should not be used */
 };
=20
@@ -699,13 +681,13 @@ void spapr_irq_reset(SpaprMachineState *spapr, Erro=
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
@@ -789,6 +771,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
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
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 691a6d00f7..0b35e85c26 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -29,8 +29,6 @@
=20
 #include "hw/ppc/spapr.h"
=20
-#define XICS_NODENAME "interrupt-controller"
-
 #define TYPE_ICS_SPAPR "ics-spapr"
 #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
=20
--=20
2.21.0


