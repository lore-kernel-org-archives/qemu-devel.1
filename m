Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0793CECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CADB02086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PyJR2ESw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADB02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFUrK-0008WF-2D
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUkl-0001ai-2y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUki-0002pA-Dh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:52:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45965)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFUkh-0002mc-Od; Tue, 01 Oct 2019 22:52:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jgf70WtXz9sQp; Wed,  2 Oct 2019 12:52:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569984735;
 bh=1DtTW1OF6hT7tfzi6fXxKl2FRK1cUrxrcPViCs66eyw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PyJR2ESwhtdQaoJCBo1fMg8RdyF5+Rmm0lGWEDe5N3SLtMCYWPZ+S8P8u5GQpeUcr
 h925t6/ObMqt0ZxS3l+0zpW94NQ/lyMlrFflO4hT7kKM2N4LjAnrEPOMo2yCWOxE0T
 vbBKg96b79m7WG336/76KsA3QDtEJrKKoJUCDUfQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 06/34] xics: Create sPAPR specific ICS subtype
Date: Wed,  2 Oct 2019 12:51:40 +1000
Message-Id: <20191002025208.3487-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002025208.3487-1-david@gibson.dropbear.id.au>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We create a subtype of TYPE_ICS specifically for sPAPR.  For now all this
does is move the setup of the PAPR specific hcalls and RTAS calls to
the realize() function for this, rather than requiring the PAPR code to
explicitly call xics_spapr_init().  In future it will have some more
function.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_spapr.c        | 34 +++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_irq.c          |  6 ++----
 include/hw/ppc/xics_spapr.h |  4 +++-
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 3e9444813a..e6dd004587 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -283,8 +283,18 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-void xics_spapr_init(SpaprMachineState *spapr)
+static void ics_spapr_realize(DeviceState *dev, Error **errp)
 {
+    ICSState *ics =3D ICS_SPAPR(dev);
+    ICSStateClass *icsc =3D ICS_GET_CLASS(ics);
+    Error *local_err =3D NULL;
+
+    icsc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
     spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get_xive=
);
     spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_int_off);
@@ -319,3 +329,25 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_=
t nr_servers, void *fdt,
     _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
     _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
 }
+
+static void ics_spapr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ICSStateClass *isc =3D ICS_CLASS(klass);
+
+    device_class_set_parent_realize(dc, ics_spapr_realize,
+                                    &isc->parent_realize);
+}
+
+static const TypeInfo ics_spapr_info =3D {
+    .name =3D TYPE_ICS_SPAPR,
+    .parent =3D TYPE_ICS,
+    .class_init =3D ics_spapr_class_init,
+};
+
+static void xics_spapr_register_types(void)
+{
+    type_register_static(&ics_spapr_info);
+}
+
+type_init(xics_spapr_register_types)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 6c45d2a3c0..8c26fa2d1e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -98,7 +98,7 @@ static void spapr_irq_init_xics(SpaprMachineState *spap=
r, int nr_irqs,
     Object *obj;
     Error *local_err =3D NULL;
=20
-    obj =3D object_new(TYPE_ICS);
+    obj =3D object_new(TYPE_ICS_SPAPR);
     object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
     object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
                                    &error_fatal);
@@ -109,9 +109,7 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
         return;
     }
=20
-    spapr->ics =3D ICS(obj);
-
-    xics_spapr_init(spapr);
+    spapr->ics =3D ICS_SPAPR(obj);
 }
=20
 static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool =
lsi,
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 5dabc9a138..691a6d00f7 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -31,11 +31,13 @@
=20
 #define XICS_NODENAME "interrupt-controller"
=20
+#define TYPE_ICS_SPAPR "ics-spapr"
+#define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
+
 void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
 int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
 void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
 bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
-void xics_spapr_init(SpaprMachineState *spapr);
=20
 #endif /* XICS_SPAPR_H */
--=20
2.21.0


