Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4BEC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770C12086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aVw6HapX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770C12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFUrf-0000Zw-1K
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUkk-0001ae-JY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUkh-0002oM-S8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:52:34 -0400
Received: from ozlabs.org ([203.11.71.1]:40399)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFUkh-0002mW-BT; Tue, 01 Oct 2019 22:52:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jgf75bGZz9sRD; Wed,  2 Oct 2019 12:52:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569984735;
 bh=nIuSmMjmRIP2JxH6+XRAiVaVtFEjEQi4rUDk6u8g8NA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aVw6HapXVQYUka+6kWCW91DwOWqibX5vgA9H05x3JOIDZ/1vCyaYhVzT/2aqjCI33
 stnljoReR8HpPmglG2yn8K1bnhduN8a+oRlwICQfkPAoS7oGEr8m7xdwQuTxmY8GNT
 1ULl4hroCPZCKx7yC6cgbcQV/8MCkdPTkBe+XbgE=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 12/34] spapr: Simplify spapr_qirq() handling
Date: Wed,  2 Oct 2019 12:51:46 +1000
Message-Id: <20191002025208.3487-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002025208.3487-1-david@gibson.dropbear.id.au>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently spapr_qirq(), whic is used to find the qemu_irq for an spapr
global irq number, redirects through the SpaprIrq::qirq method.  But
the array of qemu_irqs is allocated in the PAPR layer, not the
backends, and so the method implementations all return the same thing,
just differing in the preliminary checks they make.

So, we can remove the method, and just implement spapr_qirq() directly,
including all the relevant checks in one place.  We change all those
checks into assert()s as well, since a failure here indicates an error in
the calling code.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/spapr_irq.c         | 54 ++++++++++++++------------------------
 include/hw/ppc/spapr_irq.h |  1 -
 2 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 8f79aa829f..8f179076c6 100644
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
@@ -408,7 +382,6 @@ SpaprIrq spapr_irq_xive =3D {
     .init        =3D spapr_irq_init_xive,
     .claim       =3D spapr_irq_claim_xive,
     .free        =3D spapr_irq_free_xive,
-    .qirq        =3D spapr_qirq_xive,
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_dt_xive,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
@@ -482,11 +455,6 @@ static void spapr_irq_free_dual(SpaprMachineState *s=
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
@@ -581,7 +549,6 @@ SpaprIrq spapr_irq_dual =3D {
     .init        =3D spapr_irq_init_dual,
     .claim       =3D spapr_irq_claim_dual,
     .free        =3D spapr_irq_free_dual,
-    .qirq        =3D spapr_qirq_dual,
     .print_info  =3D spapr_irq_print_info_dual,
     .dt_populate =3D spapr_irq_dt_populate_dual,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
@@ -695,7 +662,25 @@ void spapr_irq_free(SpaprMachineState *spapr, int ir=
q, int num)
=20
 qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
 {
-    return spapr->irq->qirq(spapr, irq);
+    /*
+     * This interface is basically for VIO and PHB devices to find the
+     * right qemu_irq to manipulate, so we only allow access to the
+     * external irqs for now.  Currently anything which needs to
+     * access the IPIs most naturally gets there via the guest side
+     * interfaces, we can change this if we need to in future.
+     */
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
@@ -798,7 +783,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
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


