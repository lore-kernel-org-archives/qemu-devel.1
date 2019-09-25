Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773DC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A33217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XBTZB/56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A33217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1Gc-0003Z3-Hq
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 02:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13l-0008Io-ID
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13j-0003Vg-0f
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:57 -0400
Received: from ozlabs.org ([203.11.71.1]:56047)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iD13i-0003Sb-9i; Wed, 25 Sep 2019 02:45:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dT8p65Cbz9sR4; Wed, 25 Sep 2019 16:45:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569393946;
 bh=87aArDsIH1kv8YDMPpbVVsKjdvS7WIR74uaACPSqMhs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XBTZB/56HH0rQe/KxJwmu5ygx1oTVrXoyklGyzn5M/2Zirv2/n7j7nWOYhX1x19yp
 vL8E6r/uhyMfesGgFOIIyyMKmWTcSP8L8QnkrdZcXWemU5xypNor2mnRwHWeNMOG+g
 nTLivUPpaivKNozqlIBch1LKfm1o5yqdQOpAyQBU=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/20] spapr: Simplify spapr_qirq() handling
Date: Wed, 25 Sep 2019 16:45:26 +1000
Message-Id: <20190925064534.19155-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925064534.19155-1-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently spapr_qirq() used to find the qemu_irq for an spapr global irq
number, redirects through the SpaprIrq::qirq method.  But the array of
qemu_irqs is allocated in the PAPR layer, not the backends, and so the
method implementations all return the same thing, just differing in the
preliminary checks they make.

So, we can remove the method, and just implement spapr_qirq() directly,
including all the relevant checks in one place.  We change all those
checks into assert()s as well, since a failure here indicates an error in
the calling code.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c         | 47 ++++++++++----------------------------
 include/hw/ppc/spapr_irq.h |  1 -
 2 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 9a9e486eb5..038bfffff4 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -150,17 +150,6 @@ static void spapr_irq_free_xics(SpaprMachineState *s=
papr, int irq, int num)
     }
 }
=20
-static qemu_irq spapr_qirq_xics(SpaprMachineState *spapr, int irq)
-{
-    ICSState *ics =3D spapr->ics;
-
-    if (ics_valid_irq(ics, irq)) {
-        return spapr->qirqs[irq];
-    }
-
-    return NULL;
-}
-
 static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monitor =
*mon)
 {
     CPUState *cs;
@@ -242,7 +231,6 @@ SpaprIrq spapr_irq_xics =3D {
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
     .free        =3D spapr_irq_free_xics,
-    .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
@@ -300,20 +288,6 @@ static void spapr_irq_free_xive(SpaprMachineState *s=
papr, int irq, int num)
     }
 }
=20
-static qemu_irq spapr_qirq_xive(SpaprMachineState *spapr, int irq)
-{
-    SpaprXive *xive =3D spapr->xive;
-
-    if ((irq < SPAPR_XIRQ_BASE) || (irq >=3D xive->nr_irqs)) {
-        return NULL;
-    }
-
-    /* The sPAPR machine/device should have claimed the IRQ before */
-    assert(xive_eas_is_valid(&xive->eat[irq]));
-
-    return spapr->qirqs[irq];
-}
-
 static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
                                       Monitor *mon)
 {
@@ -413,7 +387,6 @@ SpaprIrq spapr_irq_xive =3D {
     .init        =3D spapr_irq_init_xive,
     .claim       =3D spapr_irq_claim_xive,
     .free        =3D spapr_irq_free_xive,
-    .qirq        =3D spapr_qirq_xive,
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_dt_xive,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
@@ -487,11 +460,6 @@ static void spapr_irq_free_dual(SpaprMachineState *s=
papr, int irq, int num)
     spapr_irq_xive.free(spapr, irq, num);
 }
=20
-static qemu_irq spapr_qirq_dual(SpaprMachineState *spapr, int irq)
-{
-    return spapr_irq_current(spapr)->qirq(spapr, irq);
-}
-
 static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monitor =
*mon)
 {
     spapr_irq_current(spapr)->print_info(spapr, mon);
@@ -586,7 +554,6 @@ SpaprIrq spapr_irq_dual =3D {
     .init        =3D spapr_irq_init_dual,
     .claim       =3D spapr_irq_claim_dual,
     .free        =3D spapr_irq_free_dual,
-    .qirq        =3D spapr_qirq_dual,
     .print_info  =3D spapr_irq_print_info_dual,
     .dt_populate =3D spapr_irq_dt_populate_dual,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
@@ -700,7 +667,18 @@ void spapr_irq_free(SpaprMachineState *spapr, int ir=
q, int num)
=20
 qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
 {
-    return spapr->irq->qirq(spapr, irq);
+    assert(irq >=3D SPAPR_XIRQ_BASE);
+    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
+
+    if (spapr->ics) {
+        assert(ics_valid_irq(spapr->ics, irq));
+    }
+    if (spapr->xive) {
+        assert(irq < spapr->xive->nr_irqs);
+        assert(xive_eas_is_valid(&spapr->xive->eat[irq]));
+    }
+
+    return spapr->qirqs[irq];
 }
=20
 int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
@@ -803,7 +781,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
     .free        =3D spapr_irq_free_xics,
-    .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 7e26288fcd..a4e790ef60 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -44,7 +44,6 @@ typedef struct SpaprIrq {
     void (*init)(SpaprMachineState *spapr, Error **errp);
     int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **er=
rp);
     void (*free)(SpaprMachineState *spapr, int irq, int num);
-    qemu_irq (*qirq)(SpaprMachineState *spapr, int irq);
     void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
     void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
--=20
2.21.0


